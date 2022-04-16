Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58F5037DA
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Apr 2022 20:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiDPSmO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Apr 2022 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiDPSmO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Apr 2022 14:42:14 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D65131DDF
        for <linux-wireless@vger.kernel.org>; Sat, 16 Apr 2022 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tdo84jjlIRX21EAN5K2akVMMm/PADP48RrtviqRdXFY=; b=pf4p8qMRTPvU2BL5s0m9xo4pzk
        e6rdYE4JG4DpxU3O5c95dEg/BTGNHHI73U5zp5Y1OvihrLacgpl5NnNLd7DhAA1cRNYg3ClbgRGhO
        wUSvUmE1Y7VhBpThRjhC0zmZwv7wYYs8MdsWMQ9XRc9SUE/gQtuZRsKj36gKQ/WIDXyU=;
Received: from p57a6f1f9.dip0.t-ipconnect.de ([87.166.241.249] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nfnKY-0001pv-A0; Sat, 16 Apr 2022 20:39:34 +0200
Message-ID: <91c58969-c60e-2f41-00ac-737786d435ae@nbd.name>
Date:   Sat, 16 Apr 2022 20:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] ath9k: fix QCA9561 PA bias
Content-Language: en-US
To:     =?UTF-8?Q?Thibaut_VAR=c3=88NE?= <hacks+kernel@slashdirt.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        Clemens Hopfer <openwrt@wireloss.net>
References: <20220415104419.22749-1-hacks+kernel@slashdirt.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220415104419.22749-1-hacks+kernel@slashdirt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 15.04.22 12:44, Thibaut VARÈNE wrote:
> ath9k is setting the TX PA DC bias level differently on QCA9561 and
> QCA9565 although they have the same radio IP-core, which results in a
> very low output power and very low throughput as devices are further
> away from the AP (compared to other 2.4GHz APs).
> 
> In real life testing, without this patch the 2.4GHz throughput on
> Yuncore XD3200 is around 10Mbps sitting next to the AP, and close to
> practical maximum with the patch applied.
> 
> Tested-by: Petr Štetiar <ynezz@true.cz>
> Signed-off-by: Clemens Hopfer <openwrt@wireloss.net>
> Signed-off-by: Thibaut VARÈNE <hacks+kernel@slashdirt.org>
> ---
>   drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> index b0a4ca355..8f8682f25 100644
> --- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> @@ -3606,9 +3606,10 @@ static void ar9003_hw_xpa_bias_level_apply(struct ath_hw *ah, bool is2ghz)
>   	int bias = ar9003_modal_header(ah, is2ghz)->xpaBiasLvl;
>   
>   	if (AR_SREV_9485(ah) || AR_SREV_9330(ah) || AR_SREV_9340(ah) ||
> -	    AR_SREV_9531(ah) || AR_SREV_9561(ah))
> +	    AR_SREV_9531(ah))
>   		REG_RMW_FIELD(ah, AR_CH0_TOP2, AR_CH0_TOP2_XPABIASLVL, bias);
> -	else if (AR_SREV_9462(ah) || AR_SREV_9550(ah) || AR_SREV_9565(ah))
> +	else if (AR_SREV_9462(ah) || AR_SREV_9550(ah) || AR_SREV_9561(ah) ||
> +		 AR_SREV_9565(ah))
>   		REG_RMW_FIELD(ah, AR_CH0_TOP, AR_CH0_TOP_XPABIASLVL, bias);
The patch looks wrong to me. I'm pretty sure that AR_CH0_TOP2 is the 
correct register, the definition has an explicit check for 9561 as well.
I believe this patch works by accident because it avoids writing a wrong 
value to that register.
The value written to that register is wrong, because while the mask 
definition AR_CH0_TOP2_XPABIASLVL uses a different value for 9561, the 
shift definition AR_CH0_TOP2_XPABIASLVL_S is hardcoded to 12, which is 
wrong for 9561.
Please try adjusting it to this:
#define AR_CH0_TOP2_XPABIASLVL_S (AR_SREV_9561(ah) ? 9 : 12)

- Felix
