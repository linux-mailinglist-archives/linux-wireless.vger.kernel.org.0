Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05C64554F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 09:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLGIQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 03:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGIP7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 03:15:59 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150F631DFF
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 00:15:57 -0800 (PST)
Received: from [192.168.0.203] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MJVU0-1pMYKa1hhw-00JoZC; Wed, 07 Dec 2022 09:15:40 +0100
Message-ID: <8e8cfe60-c040-bf02-665b-a980852864aa@green-communications.fr>
Date:   Wed, 7 Dec 2022 09:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/3] wifi: mt76: mt7915: rework
 mt7915_thermal_set_cur_throttle_state()
To:     Howard Hsu <howard-yh.hsu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221207052500.10855-1-howard-yh.hsu@mediatek.com>
 <20221207052500.10855-2-howard-yh.hsu@mediatek.com>
Content-Language: fr, en-US
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <20221207052500.10855-2-howard-yh.hsu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FpWw88GeqX3jW6EjsKRsQ73rCjXuWJGpYRlKHXjjjCHzaZj9tKl
 EuBXx162xQHqn3voRUIYTkbZ+6b0nmSXBG+1St3QklfsLLYlNaoDuwPPdY6dexSqAMMj22R
 uetPcijNsuDN1dZ1iKDxDwofFu/0EpqD3RBN5bDQwDXbJFxTvXtE1t3IsQ/cG+0XLUcg+nl
 A0xitxqqXFGFrahNdRfTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AIrAURp8oE8=:ILMB5225nDfqxkLO62IAZV
 6qiwG3ZGy/hKS6pYnW6InsejwiX1RwWUiG3UFpWdza3t5VefnXfC8VF/ffkHfqJceD5yybrIB
 jhOmSXRuY5w/SQg3CjmNcQ7zfxCJKs7k3lq5TzwIgCYTIl8+KLnS+h77dkIOdu8nI7yRAiCZa
 pRbyg+C6pKxdwLNnKvIbuHNPbySwIyihxQRvU0UI7Fr3sdg5X1jgLFZpkLcAL4H1E97hr2jGJ
 D1GuWcImU/Bcy0stSGzqisnz/TaXMYwYeh7Owj6ETjgQErNzATAlWQzzU+IlpH1OwZP/HVTkY
 Wfg3ZABJ2QRs0q8s+pIrLac5+LTstInQNJoGVLmEd7VWT1u6IvxFO9Mm1qIZwQebANnCRxKMs
 0Vi4kdJHLR8y9qiVvN0nqdc69+DSTW7y33aFRZd9RXHfP6tiFPKLkQCPxMFfFzpeqvaRR44wE
 kqM9rcoRHH0LhaZ3rDXjrAiJuu6IXUbYZy9PIBKVmnLEfMn4zkjSIf68w86uegfeodPRpNrce
 4K9HJh+LsJT+c4aMBAC+dKe+xSEkLIsE59aLIj2hLU6nYp9QU7UErNrSfhttylkA6/bxmgS0l
 4hwVVyyyI5gsA/pa/WfCCHsjSfC2JtybYWpl4CAgNNbm0EduvWv6LtMZUBxfPSH0PrUpVVqPI
 IL7iJSdyReNWQKF5m0X59CAVeAZkQ0wVBbF9h2kY1xf0xy+3508VrOouiiGF1FEUP9KqbxiZa
 qMVQsy1PIAFTTpoWgRkKMCdDpQminrit3mGzogbdFSDVaBT9wE0A40uI0U80DXpXBtjlpsk1K
 Owg1zttKDcUTEucXTogPfgRrBnt4ReiTxXyFy5H/YNR/NZW65o=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07/12/2022 06:24, Howard Hsu wrote:
> This patch includes 3 changes:
> 1. The maximum throttle state can be set to 100 to fix the problem that
> thermal_protect_disable can never be triggered.

You are modifying the cooling_device part.  The cooling_device is 
explicitly configured to have a max state of MT7915_CDEV_THROTTLE_MAX 
(=99), so the thermal subsystem will probably prevent 
mt7915_thermal_set_cur_throttle_state from being called with a higher 
value.  It will also probably complain if get_cur_state starts returning 
values above MT7915_CDEV_THROTTLE_MAX.

And, as the comment below indicates, the thermal subsystem expect that a 
higher state provide more cooling.  So if 99 means "maximum cooling", 
100 cannot mean "disable cooling".

Also, last time I tried, thermal_protect_disable didn't work; It didn't 
disable anything, the previous thermal throttle kept being applied. 
Maybe a new firmware fixed this, but the kernel cannot simply expect the 
firmware to be up to date.

> 2. Throttle state do not need to be different from the previous state.
> This will make it is impossible for users to just change the
> trigger/restore temp but not the throttle state.

The throttle state is mostly set by the kernel's thermal governor and 
the user has only very little control over it.  The thermal governor 
runs every X seconds and will change the state if it thinks it is too 
low or too high.

The default step_wise governor will aggressively set it to zero if the 
system isn't overheating, for example.

> 3. Add dev_err so that it is easier to see invalid setting while looking at dmesg.
> 
> Fixes: 771cd8d4c369 ("mt76: mt7915e: Fix degraded performance after temporary overheat")
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> ---
>   .../net/wireless/mediatek/mt76/mt7915/init.c   | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index c810c31fbd6e..abeecf15f1c8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -131,14 +131,17 @@ mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
>   	u8 throttling = MT7915_THERMAL_THROTTLE_MAX - state;
>   	int ret;
>   
> -	if (state > MT7915_CDEV_THROTTLE_MAX)
> +	if (state > MT7915_THERMAL_THROTTLE_MAX) {
> +		dev_err(phy->dev->mt76.dev,
> +			"please specify a valid throttling state\n");
>   		return -EINVAL;
> +	}
>   
> -	if (phy->throttle_temp[0] > phy->throttle_temp[1])
> -		return 0;
> -
> -	if (state == phy->cdev_state)
> -		return 0;
> +	if (phy->throttle_temp[0] > phy->throttle_temp[1]) {
> +		dev_err(phy->dev->mt76.dev,
> +			"temp1_crit shall not be greater than temp1_max\n");
> +		return -EINVAL;
> +	}
>   
>   	/*
>   	 * cooling_device convention: 0 = no cooling, more = more cooling
            ^^^^^^^^^^^^^^^^^^^^^^^^^

