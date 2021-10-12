Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5842A1F3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhJLK03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 06:26:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:51347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhJLK02 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 06:26:28 -0400
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N2E9Y-1mkjda1tTK-013eCv; Tue, 12 Oct 2021 12:24:20 +0200
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
References: <20201129153055.1971298-1-luca@coelho.fi>
 <iwlwifi.20201129172929.290fa5c5568a.Ic5732aa64de6ee97ae3578bd5779fc723ba489d1@changeid>
 <e8e6afa6-275e-2cc5-6351-e1ed5eb0e0af@green-communications.fr>
 <87ily325t4.fsf@tynnyri.adurom.net>
Subject: Re: [PATCH 09/13] cfg80211: Save the regulatory domain when setting
 custom regulatory
Message-ID: <cedc93ef-496f-a403-0089-b2a82477fe0f@green-communications.fr>
Date:   Tue, 12 Oct 2021 12:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87ily325t4.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NFb3DiIVumic+Y4ptgRlpnoDS068/GPSfkAkUKMjjrYsHksjASW
 re2tZirBTJlVh/t6thf3Ccs86tqSHH72oFSL8qeEWC5ysyXYGa0ywsMV/Z4CNoRQBDym7XC
 q9+DhlMr3KH7tTLFWGU+sb4GeVO3cd8IqO39PiActIlkG5ckEUwlauwR7Cb9D+kQOpSrrWr
 j6yUXbtKltozfutW+it5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yy/UhS/FEmE=:ACMOug2S1S2Z45K13d5Va+
 AN3aipRtueLnX4w7/43xo+8BwI4c5RPrDWuvIidwmvo8lHPI3h1ufSbaUgZs8uJARcWWm73a3
 +laKQDMdbi2ZahCJoTi1elTEzQZ5314sx1NY1OvAiSGEYmf4R3trBGU4UU96WBcKA/SihnPUH
 7UhcRD7puXd8eJEuUz1z3mpKPibpKkpaoM+JL9hcHnQmULo0UrH0dxIsMHgXC47LaPE14oom+
 X3yfzslqgxmIcOpqQy2uBpp+inQBs6OYifukdDBl0cP8Kbt8KXisnEw4YvcMufKQNbK+2irYK
 M1qKE+VSnoveQHim/fhugw31usggQEK2BUPsJFkDQeXQq8JzR1N06kBjvPMAlWZOutxIyfo8v
 o/gV3YPfbhxYJvG0k+JowC632CpQ0JKrSfK7aF04xvqgOOCx9W4me7VrHBv1ikHhxYN7Cus/o
 6FZcSsx2eU7RRl0d/bjgHlQagXpNgZY3j1Pxa8Zaz3xuexw7HHzA9CmNLhByG8rV/IlQBQdvd
 Qj2mAGs0J9Vqfb/Gi4hDNh2ItMZtfL0ap17HEZpzTC/NUjk9fCx235y4ZQfDW3hBHF0pNK/Gs
 z2gcghPdwCczKiLlI8IYXP+V2SY3+l7jQ2h0uD9VhfUZLmDRecgIa2+KCCH2aWExCxWBIYDG9
 YpSsLtwXAxnL/bAw2+zZNJvTFJiyKQ4yfuaPhC7yJRfn3WVbi6alQEbEOmvPwfrMqWLPRLRjc
 ffYQX9P8/o+z4oQSztfwmDLPCv8CDTeErpgQ4bREtrlxO2aJTw1fJAFrg9JZ4yxUKUHku+jeK
 Y1FsCsq
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
> 

It appears to be still unresolved on 5.14.11 :

ath: EEPROM regdomain: 0x80fa
ath: EEPROM indicates we should expect a country code
ath: doing EEPROM country->regdmn map search
ath: country maps to regdmn code: 0x37
ath: Country alpha2 being used: FR
ath: Regpair used: 0x37

yet,

$ iw reg get
global
country 00: DFS-UNSET
         (2402 - 2472 @ 40), (N/A, 20), (N/A)
         (2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
         (2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
         (5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
         (5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
         (5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
         (5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
         (57240 - 63720 @ 2160), (N/A, 0), (N/A)

phy#1
country 99: DFS-UNSET
         (2402 - 2472 @ 40), (N/A, 20), (N/A)
         (5140 - 5360 @ 80), (N/A, 30), (N/A), PASSIVE-SCAN
         (5715 - 5860 @ 80), (N/A, 30), (N/A), PASSIVE-SCAN

If i revert this patch, i get this instead:

global
country FR: DFS-ETSI
         (2400 - 2483 @ 40), (N/A, 20), (N/A)
         (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
         (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
         (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
         (5725 - 5875 @ 80), (N/A, 13), (N/A)
         (57000 - 66000 @ 2160), (N/A, 40), (N/A)

phy#2
country FR: DFS-ETSI
         (2400 - 2483 @ 40), (N/A, 20), (N/A)
         (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
         (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
         (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
         (5725 - 5875 @ 80), (N/A, 13), (N/A)
         (57000 - 66000 @ 2160), (N/A, 40), (N/A)

I'm not familiar with the regd code, but looking at where ath9k calls 
wiphy_apply_custom_regulatory in ath_regd_init_wiphy() 
(drivers/net/wireless/ath/regd.c):

           wiphy->regulatory_flags |= REGULATORY_STRICT_REG |
                                      REGULATORY_CUSTOM_REG;

           if (ath_is_world_regd(reg)) {
                   /*
                    * Anything applied here (prior to wiphy registration) gets
                    * saved on the wiphy orig_* parameters
                    */
                   regd = ath_world_regdomain(reg);
                   wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_FOLLOW_POWER;
           } else {
                   /*
                    * This gets applied in the case of the absence of CRDA,
                    * it's our own custom world regulatory domain, similar to
                    * cfg80211's but we enable passive scanning.
                    */
                   regd = ath_default_world_regdomain();
           }

           wiphy_apply_custom_regulatory(wiphy, regd);

Probably not calling wiphy_apply_custom_regulatory() in the non-world-regd case 
would solve the problem ? i'm not sure if the comment is still valid.
