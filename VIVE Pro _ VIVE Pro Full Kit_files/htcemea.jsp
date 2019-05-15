



Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,n=new Array(r),o=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(o[i],i,o)&&(n[l++]=o[i]);else for(;++i!==r;)i in this&&t.call(e,o[i],i,o)&&(n[l++]=o[i]);return n.length=l,n}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null===this||void 0===this)throw new TypeError('"this" is null or not defined');var n=Object(this),o=n.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<o;){var l;r in n&&(l=n[r],t.call(e,l,r,n)),r++}}),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var n=Object(this),o=n.length>>>0;if(0===o)return-1;var l=0|e;if(l>=o)return-1;for(r=Math.max(l>=0?l:o-Math.abs(l),0);r<o;){if(r in n&&n[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,n,o=document,l=[];if(o.querySelectorAll)return o.querySelectorAll("."+t);if(o.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=o.evaluate(r,o,null,0,null);n=e.iterateNext();)l.push(n);else for(e=o.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),n=0;n<e.length;n++)r.test(e[n].className)&&l.push(e[n]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),n=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),n.push(e);return document._qsa=null,n}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],n=r.length;return function(o){if("function"!=typeof o&&("object"!=typeof o||null===o))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in o)t.call(o,l)&&s.push(l);if(e)for(i=0;i<n;i++)t.call(o,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		log:function(msg) {
			
		},
		log_error: function(msg) {
			
		},
		log_success: function(msg) {
			
		},
		dir:function(obj) {
			
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "//www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
	    device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
			var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
			var regex = new RegExp(regexS);
			var results = regex.exec(window.location.href);
			if (results == null) return "";
			else return results[1];
		},
		load_script:function(source) {
			var docHead = document.getElementsByTagName("head")[0];
			if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			docHead.appendChild(newScript);
		},
		load_display:function(usiQS, usiSiteID, usiKey) {
			usiKey = usiKey || "";
			this.load_script(this.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey);
		},
		load_facebook:function(usiQS, usiSiteID, usiKey) {
			usiKey = usiKey || "";
			this.load_script(this.domain + "/hound/facebook.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey);
		},
		load_view:function(usiHash, usiSiteID, usiKey) {
			if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
				usiKey = usiKey || "";
				var date = "";
				if (this.gup("usi_force_date") != "") date = "&usi_force_date=" + this.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) date = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				this.load_script(this.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + date);
			}
		},
		load_precapture:function(usiQS, usiSiteID) {
			this.load_script(this.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&domain=" + encodeURIComponent(this.domain));
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (!!siteID && !!info.name && !!info.link && !!info.pid && !!info.price && !!info.image) {
					var queryString = siteID + "|" + info.name + "|" + info.link + "|" + info.pid + "|" + info.price + "|" + info.image;
					if (info.extra) queryString += "|" + info.extra;
					var filetype = real_time ? "jsp" : "js";
					this.load_script(this.domain + "/active/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err != null) {
				if (typeof err === 'string') {
					err = new Error(err);
				}
				if (err instanceof Error) {
					if (location.href.indexOf('usishowerrors') !== -1) {
						throw err;
					}
					else {
						usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack));
					}
					
					usi_commons.log_error(err.message);
					usi_commons.dir(err);
				}
			}
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			if (typeof usi_cookies === 'undefined') {
				usi_commons.log_error('usi_cookies is not defined');
				return;
			}
			expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
			var value = null;
			var qsValue = usi_commons.gup(name);
			if (qsValue !== '') {
				value = qsValue;
				usi_cookies.set(name, value, expireSeconds, forceCookie);
			}
			else {
				value = usi_cookies.get(name);
			}
			return (value || '');
		}
	};
}


	"undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,n,i){try{var t=-1;if(-1!=i){var o=new Date;o.setTime(o.getTime()+1e3*i),t=o.getTime()}var r=window.top||window,s=0;null!=n&&-1!=n.indexOf("=")&&(n=n.replace(new RegExp("=","g"),"USIEQLS")),null!=n&&-1!=n.indexOf(";")&&(n=n.replace(new RegExp(";","g"),"USIPRNS"));for(var u=r.name.split(";"),c="",a=0;a<u.length;a++){var l=u[a].split("=");3==l.length?(l[0]==e&&(l[1]=n,l[2]=t,s=1),null!=l[1]&&"null"!=l[1]&&(c+=l[0]+"="+l[1]+"="+l[2]+";")):""!=u[a]&&(c+=u[a]+";")}0==s&&(c+=e+"="+n+"="+t+";"),r.name=c}catch(e){}},flush_window_name:function(e){try{for(var n=window.top||window,i=n.name.split(";"),t="",o=0;o<i.length;o++){var r=i[o].split("=");3==r.length&&(0==r[0].indexOf(e)||(t+=i[o]+";"))}n.name=t}catch(e){}},get_from_window_name:function(e){try{for(var n=(window.top||window).name.split(";"),i=0;i<n.length;i++){var t=n[i].split("=");if(3==t.length){if(t[0]==e)if(-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=t[2]&&this.datediff(t[2])<0))return"undefined"==typeof usi_cookieless&&this.create_cookie(t[0],o,this.datediff(t[2])/1e3),usi_results=[o,t[2]],usi_results}else if(2==t.length){var o;if(t[0]==e)return-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),usi_results=[o,(new Date).getTime()+6048e5],usi_results}}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",this.search_cookies(e).length},create_cookie:function(e,n,i){var t="";if(-1!=i){var o=new Date;o.setTime(o.getTime()+1e3*i),t="; expires="+o.toGMTString()}"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)?document.cookie=e+"="+encodeURIComponent(n)+t+"; path=/;domain="+usi_parent_domain+";":document.cookie=e+"="+encodeURIComponent(n)+t+"; path=/;domain="+document.domain+";"},read_cookie:function(e){for(var n=e+"=",i=document.cookie.split(";"),t=0;t<i.length;t++){for(var o=i[t];" "==o.charAt(0);)o=o.substring(1,o.length);if(0==o.indexOf(n))return decodeURIComponent(o.substring(n.length,o.length))}return null},del:function(e){this.set(e,null,-100)},get:function(e){var n=null,i=this.get_from_window_name(e);return null==(n=null!=i&&i.length>1?decodeURIComponent(i[0]):this.read_cookie(e))?null:n},get_json:function(e){var n=null,i=usi_cookies.get(e);if(null==i)return null;try{n=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{n=JSON.parse(JSON.parse(i))}catch(e){try{n=JSON.parse(i)}catch(e){}}}return n},search_cookies:function(e){e=e||"";var n=[];return document.cookie.split(";").forEach(function(i){var t=i.split("=")[0].trim();""!==e&&0!==t.indexOf(e)||n.push(t)}),n},set:function(e,n,i,t){"undefined"!=typeof usi_nevercookie&&(t=!1);try{n=n.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}if("undefined"==typeof usi_windownameless&&this.update_window_name(e+"",n+"",i),"undefined"==typeof usi_cookieless||t||null==n){if(null!=n){if(null==this.read_cookie(e))if(!t)if(this.search_cookies("usi_").length+1>this.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+this.max_cookies_count);n.length>this.max_cookie_length&&(usi_cookies.report_error('Cookie "'+e+'" truncated ('+n.length+"). Max single-cookie length is "+this.max_cookie_length),n=n.substring(0,this.max_cookie_length-1))}this.create_cookie(e,n,i)}},set_json:function(e,n,i,t){var o=JSON.stringify(n).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,o,i,t)},flush:function(e){e=e||"usi_";var n,i,t,o=document.cookie.split(";");for(n=0;n<o.length;n++)0==(i=o[n]).trim().toLowerCase().indexOf(e)&&(t=i.trim().split("=")[0],this.del(t));this.flush_window_name(e)},print:function(){for(var e=document.cookie.split(";"),n="",i=0;i<e.length;i++){var t=e[i];0==t.trim().toLowerCase().indexOf("usi_")&&(console.log(t.trim()+" (cookie)"),n+=","+t.trim().toLowerCase().split("=")[0]+",")}var o=(window.top||window).name.split(";");for(i=0;i<o.length;i++){var r=o[i].split("=");3==r.length&&0==r[0].indexOf("usi_")&&-1==n.indexOf(","+r[0]+",")&&console.log(r[0]+"="+r[1]+" (window.name)")}},value_exists:function(){var e,n;for(e=0;e<arguments.length;e++)if(""===(n=this.get(arguments[e]))||null===n||"null"===n||"undefined"===n)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}});


if (typeof usi_dom === 'undefined') {
    usi_dom = {};
    usi_dom.get_elements = function(selector, element) {
        var elements = [];
        element = (element || document);
        elements = Array.prototype.slice.call(element.querySelectorAll(selector));
        return elements;
    };
    usi_dom.count_elements = function(selector, element) {
        element = (element || document);
        return usi_dom.get_elements(selector, element).length;
    };
    usi_dom.get_nth_element = function(ordinal, selector, element) {
        var nthElement = null;
        element = (element || document);
        var elements = usi_dom.get_elements(selector, element);
        if (elements.length >= ordinal) {
            nthElement = elements[ordinal - 1];
        }
        return nthElement;
    };
    usi_dom.get_first_element = function(selector, element) {
        if ((selector || '') === '') {
            return null;
        }
        element = (element || document);
        if (Object.prototype.toString.call(selector) === '[object Array]') {
            var selectedElement = null;
            for (var selectorIndex = 0; selectorIndex < selector.length; selectorIndex++) {
                var selectorItem = selector[selectorIndex];
                selectedElement = usi_dom.get_first_element(selectorItem, element);
                if (selectedElement != null) {
                    break;
                }
            }
            return selectedElement;
        } else {
            return element.querySelector(selector);
        }
    };
    usi_dom.get_element_text_no_children = function(element, doCleanString) {
        var content = '';
        if (doCleanString == null) {
            doCleanString = false;
        }
        element = (element || document);
        if (element != null && element.childNodes != null) {
            for (var i = 0; i < element.childNodes.length; ++i) {
                if (element.childNodes[i].nodeType === 3) {
                    content += element.childNodes[i].textContent;
                }
            }
        }
        if (doCleanString === true) {
            content = usi_dom.clean_string(content);
        }
        return content.trim();
    };
    usi_dom.clean_string = function(content) {
        if (typeof content !== 'string') {
            return;
        }
        content = content.replace(/[\u2010-\u2015\u2043]/g, '-');
        content = content.replace(/[\u2018-\u201B]/g, "'");
        content = content.replace(/[\u201C-\u201F]/g, '"');
        content = content.replace(/\u2024/g, '.');
        content = content.replace(/\u2025/g, '..');
        content = content.replace(/\u2026/g, '...');
        content = content.replace(/\u2044/g, '/');
        var nonAsciiChars = /[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g;
        return content.replace(nonAsciiChars, '').trim();
    };
    usi_dom.encode = function(content) {
        if (typeof content !== 'string') {
            return;
        }
        var encodedContent = encodeURIComponent(content);
        encodedContent = encodedContent.replace(/[-_.!~*'()]/g, function(r) {
            return '%' + r.charCodeAt(0).toString(16).toUpperCase();
        });
        return encodedContent;
    };
    usi_dom.get_closest = function(element, selector) {
        element = (element || document);
        if (typeof Element.prototype.matches !== 'function') {
            Element.prototype.matches =
                Element.prototype.matchesSelector ||
                Element.prototype.mozMatchesSelector ||
                Element.prototype.msMatchesSelector ||
                Element.prototype.oMatchesSelector ||
                Element.prototype.webkitMatchesSelector ||
                function(s) {
                    var matches = (this.document || this.ownerDocument).querySelectorAll(s);
                    var matchIndex = matches.length;
                    while (--matchIndex >= 0 && matches.item(matchIndex) !== this) {}
                    return matchIndex > -1;
                };
        }
        for (; element != null && element !== document; element = element.parentNode) {
            if (element.matches(selector)) {
                return element;
            }
        }
        return null;
    };
    usi_dom.get_classes = function(element) {
        var classes = [];
        if (element != null && element.classList != null) {
            classes = Array.prototype.slice.call(element.classList);
        }
        return classes;
    };
    usi_dom.add_class = function(element, className) {
        if (element != null) {
            var classes = usi_dom.get_classes(element);
            if (classes.indexOf(className) === -1) {
                classes.push(className);
                element.className = classes.join(' ');
            }
        }
    };
    usi_dom.string_to_decimal = function(stringContent) {
        var decimalValue = null;
        if (typeof stringContent === 'string') {
            try {
                var testValue = parseFloat(stringContent.replace(/[^0-9\.-]+/g, ''));
                if (isNaN(testValue) === false) {
                    decimalValue = testValue;
                }
            } catch (err) {
                usi_commons.log('Error: ' + err.message);
            }
        }
        return decimalValue;
    };
    usi_dom.string_to_integer = function(stringContent) {
        var integerValue = null;
        if (typeof stringContent === 'string') {
            try {
                var testValue = parseInt(stringContent.replace(/[^0-9-]+/g, ''));
                if (isNaN(testValue) === false) {
                    integerValue = testValue;
                }
            } catch (err) {
                usi_commons.log('Error: ' + err.message);
            }
        }
        return integerValue;
    };
    usi_dom.get_currency_string_from_content = function(stringContent) {
        if (typeof stringContent !== 'string') {
            return '';
        }
        try {
            stringContent = stringContent.trim();
            var currencyPattern = /^([^$]*?)($(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/;
            var currencyMatches = (stringContent.match(currencyPattern) || []);
            if (currencyMatches.length === 4) {
                return currencyMatches[2];
            } else {
                return '';
            }
        } catch (err) {
            usi_commons.log('Error: ' + err.message);
            return '';
        }
    };
    usi_dom.get_absolute_url = (function() {
        var a;
        return function(url) {
            a = (a || document.createElement('a'));
            a.href = url;
            return a.href;
        };
    })();
    usi_dom.format_number = function(number, decimalPlaces) {
        var formattedNumber = '';
        if (typeof number === 'number') {
            decimalPlaces = (decimalPlaces || 0);
            var workingNumber = number.toFixed(decimalPlaces);
            var numberParts = workingNumber.split(/\./g);
            if (numberParts.length == 1 || numberParts.length == 2) {
                var numberPortion = numberParts[0];
                formattedNumber = numberPortion.replace(/./g, function(c, i, a) {
                    return i && c !== '.' && ((a.length - i) % 3 === 0) ? ',' + c : c;
                });
                if (numberParts.length == 2) {
                    formattedNumber += '.' + numberParts[1];
                }
            }
        }
        return formattedNumber;
    };
    usi_dom.format_currency = function(number, languageCode, options) {
        var formattedCurrency = '';
        number = Number(number);
        if (isNaN(number) === false) {
            if (typeof Intl == 'object' && typeof Intl.NumberFormat == 'function') {
                languageCode = languageCode || 'en-US';
                options = options || {
                    style: 'currency',
                    currency: 'USD'
                };
                formattedCurrency = number.toLocaleString(languageCode, options);
            } else {
                formattedCurrency = number;
            }
        }
        return formattedCurrency;
    };
    usi_dom.to_decimal_places = function(numberValue, decimalPlaces) {
        if (numberValue != null && typeof numberValue === 'number' && decimalPlaces != null && typeof decimalPlaces === 'number') {
            if (decimalPlaces == 0) {
                return parseFloat(Math.round(numberValue));
            }
            var multiplier = 10;
            for (var i = 1; i < decimalPlaces; i++) {
                multiplier *= 10;
            }
            return parseFloat(Math.round(numberValue * multiplier) / multiplier);
        } else {
            return null;
        }
    };
    usi_dom.trim_string = function(stringValue, maxLength, trimmedText) {
        stringValue = (stringValue || '');
        trimmedText = (trimmedText || '');
        if (stringValue.length > maxLength) {
            stringValue = stringValue.substring(0, maxLength);
            if (trimmedText !== '') {
                stringValue += trimmedText;
            }
        }
        return stringValue;
    };
    usi_dom.attach_event = function(eventName, func, element) {
        var attachToElement = usi_dom.find_supported_element(eventName, element);
        usi_dom.detach_event(eventName, func, attachToElement);
        if (attachToElement.addEventListener) {
            attachToElement.addEventListener(eventName, func, false);
        } else {
            attachToElement.attachEvent('on' + eventName, func);
        }
    };
    usi_dom.detach_event = function(eventName, func, element) {
        var removeFromElement = usi_dom.find_supported_element(eventName, element);
        if (removeFromElement.removeEventListener) {
            removeFromElement.removeEventListener(eventName, func, false);
        } else {
            removeFromElement.detachEvent('on' + eventName, func);
        }
    };
    usi_dom.find_supported_element = function(eventName, element) {
        element = (element || document);
        if (element === window) {
            return window;
        } else if (usi_dom.is_event_supported(eventName, element) === true) {
            return element;
        } else {
            if (element === document) {
                return window;
            } else {
                return usi_dom.find_supported_element(eventName, document);
            }
        }
    };
    usi_dom.is_event_supported = function(eventName, element) {
        return (element != null && typeof element['on' + eventName] !== 'undefined');
    };
    usi_dom.is_defined = function(testObj, propertyPath) {
        if (testObj == null) {
            return false;
        }
        if ((propertyPath || '') === '') {
            return false;
        }
        var isDefined = true;
        var currentObj = testObj;
        var properties = propertyPath.split('.');
        properties.forEach(function(propertyName) {
            if (isDefined === true) {
                if (currentObj == null || typeof currentObj !== 'object' || currentObj.hasOwnProperty(propertyName) === false) {
                    isDefined = false;
                } else {
                    currentObj = currentObj[propertyName];
                }
            }
        });
        return isDefined;
    };
    usi_dom.observe = (function(element, options, callback) {
        var url = location.href;
        var defaultOptions = {
            onUrlUpdate: false,
            observerOptions: {
                childList: true,
                subtree: true
            }
        };
        var MutationObserver = window.MutationObserver || window.WebkitMutationObserver;
        options = options || defaultOptions;
        return function(element, callback) {
            var observer = null;
            var callbackHandler = function() {
                var currentUrl = location.href;
                if (options.onUrlUpdate && currentUrl !== url) {
                    callback();
                    url = currentUrl;
                } else {
                    callback();
                }
            };
            if (MutationObserver) {
                observer = new MutationObserver(function(mutations) {
                    var currentUrl = location.href;
                    var hasMutations = mutations[0].addedNodes.length || mutations[0].removedNodes.length;
                    if (hasMutations && options.onUrlUpdate && currentUrl !== url) {
                        callback();
                        url = currentUrl;
                    } else if (hasMutations) {
                        callback();
                    }
                });
                observer.observe(element, options.observerOptions);
            } else if (window.addEventListener) {
                element.addEventListener('DOMNodeInserted', callbackHandler, false);
                element.addEventListener('DOMNodeRemoved', callbackHandler, false);
            }
        };
    })();
    usi_dom.params_to_object = function(paramsString) {
        var paramsObj = {};
        if ((paramsString || '') != '') {
            var params = paramsString.split('&');
            params.forEach(function(param) {
                var paramParts = param.split('=');
                if (paramParts.length === 2) {
                    paramsObj[decodeURIComponent(paramParts[0])] = decodeURIComponent(paramParts[1]);
                } else if (paramParts.length === 1) {
                    paramsObj[decodeURIComponent(paramParts[0])] = null;
                }
            });
        }
        return paramsObj;
    };
    usi_dom.object_to_params = function(obj) {
        var params = [];
        if (obj != null) {
            for (var key in obj) {
                if (obj.hasOwnProperty(key) === true) {
                    params.push(encodeURIComponent(key) + '=' + (obj[key] == null ? '' : encodeURIComponent(obj[key])));
                }
            }
        }
        return params.join('&');
    };
    usi_dom.interval_with_timeout = function(iterationFunction, timeoutCallback, completeCallback, options) {
        if (typeof iterationFunction !== 'function') {
            throw new Error('usi_dom.interval_with_timeout(): iterationFunction must be a function');
        }
        if (timeoutCallback == null) {
            timeoutCallback = function(timeoutResult) {
                return timeoutResult;
            }
        } else if (typeof timeoutCallback !== 'function') {
            throw new Error('usi_dom.interval_with_timeout(): timeoutCallback must be a function');
        }
        if (completeCallback == null) {
            completeCallback = function(completeResult) {
                return completeResult;
            }
        } else if (typeof completeCallback !== 'function') {
            throw new Error('usi_dom.interval_with_timeout(): completeCallback must be a function');
        }
        options = (options || {});
        var intervalMS = (options.intervalMS || 20);
        var timeoutMS = (options.timeoutMS || 2000);
        if (typeof intervalMS !== 'number') {
            throw new Error('usi_dom.interval_with_timeout(): intervalMS must be a number');
        }
        if (typeof timeoutMS !== 'number') {
            throw new Error('usi_dom.interval_with_timeout(): timeoutMS must be a number');
        }
        var completionIsRunning = false;
        var intervalStartDate = new Date();
        var interval = setInterval(function() {
            var elapsedMS = ((new Date()) - intervalStartDate);
            if (elapsedMS >= timeoutMS) {
                clearInterval(interval);
                var timeoutResult = {
                    elapsedMS: elapsedMS
                };
                return timeoutCallback(timeoutResult);
            } else {
                if (completionIsRunning === false) {
                    completionIsRunning = true;
                    iterationFunction(function(isComplete, completeResult) {
                        completionIsRunning = false;
                        if (isComplete === true) {
                            clearInterval(interval);
                            completeResult = (completeResult || {});
                            completeResult.elapsedMS = ((new Date()) - intervalStartDate);
                            return completeCallback(completeResult);
                        }
                    });
                }
            }
        }, intervalMS);
    };
    usi_dom.load_external_stylesheet = function(url, id, callback) {
        if ((url || '') !== '') {
            if ((id || '') === '') {
                id = 'usi_stylesheet_' + ((new Date()).getTime());
            }
            var result = {
                url: url,
                id: id
            };
            var headElement = document.getElementsByTagName("head")[0];
            if (headElement != null) {
                var linkElement = document.createElement('link');
                linkElement.type = 'text/css';
                linkElement.rel = 'stylesheet';
                linkElement.id = result.id;
                linkElement.href = url;
                usi_dom.attach_event('load', function() {
                    if (callback != null) {
                        return callback(null, result);
                    }
                }, linkElement);
                headElement.appendChild(linkElement);
            }
        } else {
            if (callback != null) {
                return callback(null, result);
            }
        }
    };
    usi_dom.ready = function(callback) {
        if (typeof (document.readyState) != "undefined" && document.readyState === "complete") {
            callback();
        } else if (window.addEventListener) {
            window.addEventListener('load', callback, true);
        } else if (window["attachEvent"]) {
            window["attachEvent"]('onload', callback);
        } else {
            setTimeout(callback, 5000);
        }
    };
}
if (window.usi_app === undefined) {
	try {
		usi_app = {};
	
		usi_app.main = function () {
			usi_app.url = location.href.toLowerCase();
			usi_app.gb_cart = usi_app.url.indexOf('locale=en_gb') > -1;
			usi_app.ie_cart = usi_app.url.indexOf('locale=en_ie') > -1;
			usi_app.store_page = usi_app.url.indexOf('displaythreepgcheckoutaddresspaymentinfopage') > -1 ||
					usi_app.url == "https://store.eu.vive.com/drhm/store";
			usi_app.receipt_page = usi_app.url.indexOf("thankyoupage") > -1;
			usi_app.cart = usi_app.url.indexOf('threepgcheckoutshoppingcartpage') > -1;
			usi_app.visited_ie = !!usi_cookies.get('usi_ie');
			usi_app.visited_gb = !!usi_cookies.get('usi_gb');
			usi_app.can_launch = !!usi_cookies.get('usi_can_launch');
	
			if (usi_app.cart && usi_app.url.indexOf('en_gb') > -1) {
				usi_cookies.set('usi_gb', 'true', usi_cookies.expire_time.day);
			} else if (usi_app.cart && usi_app.url.indexOf('en_ie') > -1) {
				usi_cookies.set('usi_ie', 'true', usi_cookies.expire_time.day);
			}
	
			if (usi_app.cart) {
				usi_app.check_products();
				usi_app.set_cart_data(usi_app.get_cart_data());
			}
	
			usi_app.load();
		};
	
		usi_app.check_products = function() {
			if (usi_app.gb_cart && usi_app.has_vive_product()) {
				usi_cookies.set('usi_can_launch', 'true', usi_cookies.expire_time.day);
			}
		};
	
		usi_app.get_cart_data = function() {
			var cartData = usi_app.get_new_cart();
			var cartItems = usi_dom.get_elements('.dr_oddRow, .dr_evenRow');
			if (usi_dom.get_elements('.dr_oddRow, .dr_evenRow').length > 0 && usi_dom.get_first_element('.cart-total .cart-price-col') != null) {
				var subtotal = usi_dom.get_first_element('.cart-total .cart-price-col').innerText.trim();
		
				cartItems.forEach(function(item) {
					var prod = {
						image: usi_dom.get_first_element('img', item).src,
						name: usi_dom.get_first_element('h4', item).innerText,
						price: usi_dom.get_first_element('.dr_price', item).innerText
					};
					if (prod.price.indexOf("\n")!= -1) {
						prod.price = prod.price.substring(prod.price.indexOf("\n"));
					}
					cartData.products.push(prod);
				});
		
				cartData.subtotal = subtotal;
			}
	
			return cartData;
		};
	
		usi_app.get_new_cart = function() {
			usi_commons.log('Retrieving new cart');
	
			return {
				subtotal: 0,
				products: []
			};
		};
	
		usi_app.set_cart_data = function(data) {
			usi_commons.log('Saving cart data...');
			usi_commons.log(data);
			usi_cookies.set('usi_cart', JSON.stringify(data), usi_cookies.expire_time.week);
		};
	
		// Have to store a cookie to differentiate
		// between different locales on store page
		usi_app.load = function() {
			if (usi_app.store_page && usi_app.visited_gb && usi_app.can_launch) {
				usi_commons.load_precapture('uYI9DC994dUIpwIEWiJDQWs', '19502');
			} else if (usi_app.store_page && usi_app.visited_ie && usi_app.can_launch) {
				usi_commons.load_precapture('i9DtlYINKWMHJ32OI4spDpw', '19500');
			}
		};
	
		// Only returns true if it is the only product
		usi_app.has_vive_product = function() {
			var hasViveProduct = false;
			var productImgs = usi_dom.get_elements('.cart-product-thumb');
	
			productImgs.forEach(function(image) {
				if (image.src.toLowerCase().indexOf('vive') != -1) {
					usi_commons.log('Vive found');
					hasViveProduct = true;
				}
			});
	
			return hasViveProduct;
		};
		usi_app.main();
	} catch(err) {
		usi_commons.report_error(err);
	}
}