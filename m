Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3071942910D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242833AbhJKOPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 10:15:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhJKOL1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 10:11:27 -0400
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6svJ-1mpBSr3qLn-018GC7; Mon, 11 Oct 2021 16:09:18 +0200
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
References: <20201129153055.1971298-1-luca@coelho.fi>
 <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
 <e8e6afa6-275e-2cc5-6351-e1ed5eb0e0af@green-communications.fr>
 <87ily325t4.fsf@tynnyri.adurom.net>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting
 custom regulatory
Message-ID: <5a4d958d-6e9a-2a49-314c-8181aaa05ba0@green-communications.fr>
Date:   Mon, 11 Oct 2021 16:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87ily325t4.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kOndQ9ipfk+9qU0xuT9Z/s6ttLtUkwfb9YAOOFcmSziw73Y6iE2
 AEDtRHQqq4znNLuXuwrwATdevAoiEgVMeLFl9kyIlgmp1vynXL4mnBHg/oViJYqlVYCs+aV
 +zxAmBdVQXVZ/7l8GRVrZrQH7tga5tegP+vKm+0Ekrfrro6CQpg8guHL5An9StnA3Y/WHQx
 GmYV275iBHWrd8z4Ows5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ym4k7jRbfNI=:CdNB2H8KilgfplpTji8jdd
 cPma1+lETpattPv0bx+sBRKgve+cxr2+8WvpaGO7IcT3S9/j8tLATWFZIbD+WsuBqanE42Whj
 lrbTAiwVTirM9wRDVrfw3ruOVPHKT0097ldvLZW9Y5bOG195ERQHMVQ8yrv0RzDDx9lrC905e
 VIQw2OVfzkA2G/PvBXxF+4KNKAgUyUUJ7xmx/SYw2JVtIjxZY7nXuUIBoD/7s6DF08a8BATsu
 ZzWvqf1R6wrqCglvQbi06qUmNSNBsJv5FCvTYzyVJFc9FzIG9XPwr7VUMvPdKrQeok0Snzm1/
 uXR3zfnuQqUn2z6cacSviMs5xWRgEts4HJjnCZckOC/Tl9kZRs1yaeCAUFlf4XcdBUwjAOK9c
 GtcMfPqpKt/eW+/sJKbx17jRfoGqILACur3gyE73T9NJA5F2oVaEq3v/U7WiDP0VciWNewNFu
 YQi+aQcehN4mFXBJkpU2UupR1cBQzSQbydbIERJLyV+APVv4NCdjq3wkB6TwvQK1aUmoALdFi
 6ofFnlSEJ/hI0kvbgqUzHWdCvo27QfyBMUTZdiVNWHJwVOIMPIYYQx+Pj40AzxmkT3YK5vSdU
 emClIedo/4QP+plkGNWFx6ZJqZ+QWIzmezWGph+zHbfJRaijn220td4TewyODio9c+fg5B5mI
 PLcBRieJ5wQRDcX9xQ6k1XEAgkDcQUn3SMQGapKRV3g6U5jiyrwPq1J7yWdrKLI+uw/1Euesx
 AHJ/zQ0OJSkMy/Xtyko3EAzQu/aYnSqRPiuiBrHzEsMk3sQ7OXITZVGkI/e/KBBgecDXtQY30
 7fiTyLb
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/10/2021 12:51, Kalle Valo wrote:
> Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr> writes:
> 
>> On 29/11/2020 16:30, Luca Coelho wrote:
>>> From: Ilan Peer <ilan.peer@intel.com>
>>>
>>> When custom regulatory was set, only the channels setting was updated, but
>>> the regulatory domain was not saved. Fix it by saving it.
>>>
>>> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
>>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>> ---
>>>    net/wireless/reg.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/net/wireless/reg.c b/net/wireless/reg.c
>>> index a04fdfb35f07..094492b62f8a 100644
>>> --- a/net/wireless/reg.c
>>> +++ b/net/wireless/reg.c
>>> @@ -2547,6 +2547,7 @@ static void handle_band_custom(struct wiphy *wiphy,
>>>    void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
>>>    				   const struct ieee80211_regdomain *regd)
>>>    {
>>> +	const struct ieee80211_regdomain *new_regd, *tmp;
>>>    	enum nl80211_band band;
>>>    	unsigned int bands_set = 0;
>>>    @@ -2566,6 +2567,13 @@ void wiphy_apply_custom_regulatory(struct
>>> wiphy *wiphy,
>>>    	 * on your device's supported bands.
>>>    	 */
>>>    	WARN_ON(!bands_set);
>>> +	new_regd = reg_copy_regd(regd);
>>> +	if (IS_ERR(new_regd))
>>> +		return;
>>> +
>>> +	tmp = get_wiphy_regdom(wiphy);
>>> +	rcu_assign_pointer(wiphy->regd, new_regd);
>>> +	rcu_free_regdom(tmp);
>>>    }
>>>    EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
>>>    
>>>
>>
>> Hello,
>>
>> This patch somehow appears to break ath9k's eeprom hints and restrict
>> it to the world regulatory domain on v5.12.10.
>>
>> ath9k calls wiphy_apply_custom_regulatory() with its own kind of world
>> regulatory domain, before it decodes hints from the eeprom and uses
>> regulatory_hint() to request a specific alpha2.
>>
>> With this patch, applying the hint fails because wiphy->regd is already set.
>> If i revert this patch, ath9k works again.
> 
> I have lost track, is this regression fixed now or is it sill
> unresolved?

I admit i forgot about it after reverting the patch and haven't tried a new 
kernel with ath9k since then, but from a quick glance, the code hasn't changed. 
I'll try a new kernel tomorrow.
