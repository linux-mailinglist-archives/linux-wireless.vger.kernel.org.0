Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08D28D07F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbgJMOmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMOmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 10:42:23 -0400
Received: from mail.blocktrron.ovh (mars.blocktrron.ovh [IPv6:2001:41d0:401:3000::cbd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD9FC0613D0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Oct 2020 07:42:23 -0700 (PDT)
Received: from [IPv6:2003:e5:3f10:8a00:dce3:cb57:2820:3c5a] (p200300e53f108a00dce3cb5728203c5a.dip0.t-ipconnect.de [IPv6:2003:e5:3f10:8a00:dce3:cb57:2820:3c5a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id D64D226EC4;
        Tue, 13 Oct 2020 16:42:21 +0200 (CEST)
Subject: Re: [PATCH] mt76: mt7603: add additional EEPROM chip ID
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        dev@andreas-ziegler.de, Ron Asimi <ron.asimi@gmail.com>
References: <20201013142326.8361-1-mail@david-bauer.net>
 <20201013143219.GA2854@lore-desk>
From:   David Bauer <mail@david-bauer.net>
Autocrypt: addr=mail@david-bauer.net; prefer-encrypt=mutual; keydata=
 mQENBFYkGEcBCADbRMHdOXmszxrmE9G/gWUD4/HXklOfn+hyBpEcOul+GKAet0oFxznkchJe
 hO5MbEFYsnM8TZVxjnEi70c3luF1m4JycjgQ91GJ52+xvLV0dVz+L99JBgVJNRDvvt68rLVq
 A8/LCdkXctZ+GBfrtTYQ6dOeuQf/qWuwlNTvuG92uWVZjncyWOmQX73gv+1MTRsCmIGNYQu1
 ZDVyhr3YsTgJIXTHUCxBHQBDglkb3L5lK9WHPf1puQ2grNbUg9VSmo4a9IzUpRauNtCDUFxi
 1m1e5VnmU5O5/xZyDzwmpWog9tUfScS7X9pdVNQ+2W3zCRrotFEn6FKdD01mhIsLnczjABEB
 AAG0IkRhdmlkIEJhdWVyIDxtYWlsQGRhdmlkLWJhdWVyLm5ldD6JAVkEEwEIAEMCGwMHCwkI
 BwMCAQYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBNcEMml7fEwnOA/No7qzlxS0pLh4BQJe17UP
 BQkKlNBIAAoJELqzlxS0pLh494UH/irs1e2AucUFddh9bRs6DP7vti3C/wkfg32LpVBeNL7D
 0JgGBdEHvCgAZEdorm62rPHZ61oqLnwaFDgqHTZZJO3E843Ax7DfHFY8oZ76eFXQ+Ik4CF4P
 2c7JAI1/Q731wwNPRPBucEE6+llaAyLoD5SRpYGkoj2bvgX8Cc7KbH3pyBUx27V5HhscJUAU
 u6ocDkb58Jx+kH9rMmlKvYFzXZKSmI8roYyTAQCpYJUrM5Z/ecU2UnPTWExJLN1hTGAVrHF6
 ULG9oD8M7X15y6LQPf4wrTf0L0d7o42NuG1Z1J9yCMnQrAMdJm6K6vcTMEru9Ur6fz6+hALp
 Xmm1ZolXIqe5AQ0EViQYRwEIALqz1V6kWIvCTVN/6QN9fepVSwSw+5IiiVBGtf2rtdqujCRD
 bGi96a2ZLYRQzlSQvCZ51skgoZFmIW2YhPP90qiZssSEQxgY1rf+DEYnjWmFSgi3iHqYXRk2
 cY7OI3ZT8D2tAFu9pIAxZpD5FdQznJmUhljeTJw+lGOoxctf1xjHZcRcU6GUFMpFBc4xaLC0
 hUN24HT5pDpklxskPFH91VncDaOsLesqszGaUHWx3hogRfogdADvycUp/bQB80kZO/XqexWN
 GUNJYS4axWM2ND25bWV1h9aFjPpOwFM7FwAyra0VihnnNn7dTL5vBpFztY0IFPlvqyc1Vw8y
 vgtShA0AEQEAAYkBPAQYAQgAJgIbDBYhBNcEMml7fEwnOA/No7qzlxS0pLh4BQJe17UqBQkK
 lNBjAAoJELqzlxS0pLh4YrMH/jwiIFJFEr8BFMxCQHiBgyZhmJm1CBJsdneCrVxrTIHdr7uk
 wCglAio2+/IsB3x2JfzSJjpi0eynkfk7zDF6G1te1CKMfReCDEvMyBZK/X3XWYKJhxDvxuJ7
 ftf3lwLv6iltQddVEB8/RhG+X89cyBwHirKsZEM7fxYMVRCksqanJwh3TFt+mPP9cUEsg1e8
 i9SenxZnF11iIbcsmi0C9H8MAW1KJXu61luiS30RXbrH35psA2k4muf8RqE5BgXrJ5wwTxpL
 MOY7eVfmPmYrr1q1bas8r97ookpcPmavtkk395GtjuCkIfnDx1HtuICczBA8ge41F4tj+Vtx
 BFwmgiA=
Message-ID: <cbd2ecce-09c8-15ec-e6b3-6e0913d09da4@david-bauer.net>
Date:   Tue, 13 Oct 2020 16:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013143219.GA2854@lore-desk>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

On 10/13/20 4:32 PM, Lorenzo Bianconi wrote:
>> Some newer MT7628 based routers (notably the TP-Link Archer C50 v4) are
>> shipped with a chip-id of 0x7600 in the on-flash EEPROM. Add this as a
>> possible valid ID.
>>
>> Ref: https://bugs.openwrt.org/index.php?do=details&task_id=2781
>>
>> Suggested-by: Ron Asimi <ron.asimi@gmail.com>
>> Signed-off-by: David Bauer <mail@david-bauer.net>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
>> index 3ee06e2577b8..422b9d9e8962 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
>> @@ -141,6 +141,7 @@ static int mt7603_check_eeprom(struct mt76_dev *dev)
>>  	switch (val) {
>>  	case 0x7628:
>>  	case 0x7603:
>> +	case 0x7600:
> 
> is it a hw bug or does this part-number really exist?

I assume it's a bug on TP-Links side. However, there's already quite some units with
this chip-id in their EEPROM around.

Best wishes
David

> 
> 
>>  		return 0;
>>  	default:
>>  		return -EINVAL;
>> -- 
>> 2.28.0
>>
