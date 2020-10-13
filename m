Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0369B28DCB2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Oct 2020 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgJNJTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Oct 2020 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgJNJTh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:37 -0400
Received: from mail.blocktrron.ovh (mars.blocktrron.ovh [IPv6:2001:41d0:401:3000::cbd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A2C08EC6F
        for <linux-wireless@vger.kernel.org>; Tue, 13 Oct 2020 16:55:48 -0700 (PDT)
Received: from [IPv6:2003:e5:3f10:8a00:199:967e:17ef:50b5] (p200300e53f108a000199967e17ef50b5.dip0.t-ipconnect.de [IPv6:2003:e5:3f10:8a00:199:967e:17ef:50b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.blocktrron.ovh (Postfix) with ESMTPSA id 4FF2026EA5;
        Wed, 14 Oct 2020 01:55:46 +0200 (CEST)
Subject: Re: [PATCH] mt76: mt7603: add additional EEPROM chip ID
To:     Andreas Ziegler <dev@andreas-ziegler.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        Ron Asimi <ron.asimi@gmail.com>
References: <20201013142326.8361-1-mail@david-bauer.net>
 <20201013143219.GA2854@lore-desk>
 <cbd2ecce-09c8-15ec-e6b3-6e0913d09da4@david-bauer.net>
 <1dae1d32-8cf5-75f3-8bdc-32ec058faba5@andreas-ziegler.de>
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
Message-ID: <4c852fef-b651-a10f-4b46-35df6cddaf9b@david-bauer.net>
Date:   Wed, 14 Oct 2020 01:55:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1dae1d32-8cf5-75f3-8bdc-32ec058faba5@andreas-ziegler.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Andreas,

On 10/13/20 6:00 PM, Andreas Ziegler wrote:
> Hi,
> 
> David Bauer wrote on 13.10.20 16:42:
>>>
>>> is it a hw bug or does this part-number really exist?
>>
>> I assume it's a bug on TP-Links side. However, there's already quite some units with
>> this chip-id in their EEPROM around.
> 
> 
> to my knowledge, all devices of this specific model (Archer C50 v4) have
> this chip-id in their EEPROM, not only some.

The unit I've got back when the v4 first surfaced has the correct chip-id in the
2.4GHz EEPROM (0x7628). However, some (if not all) newer units use 0x7600 as the
chip-id for the MT7628 caldata.

Best wishes
David


> 
> Regards
> 
> Andreas
> 
