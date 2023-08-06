Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480B7713F3
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Aug 2023 10:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHFI1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Aug 2023 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHFI1M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Aug 2023 04:27:12 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9E1FC4
        for <linux-wireless@vger.kernel.org>; Sun,  6 Aug 2023 01:27:09 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 17787 invoked from network); 6 Aug 2023 10:27:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1691310422; bh=7mKBJlViK1Pg6UnDMGtryonK8fF8vwGfUSFJYpaSbUA=;
          h=From:To:Cc:Subject;
          b=tNxAmKi8Bv37NI/aCEhczjEsszO2wZzcDH/iDQuAGE1kks/3g8U0fK3sqf+4bYzGH
           0A7Dp5AXZHDGYS9WI0LYo9xOEa+4xZv9dxsK+cBTEnmvGybkOlR8eU7R71eZkogayn
           A0WU5XKU+MpQByxppW3aPzywChrdqxXLnIcith+8=
Received: from 89-64-15-58.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.15.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 6 Aug 2023 10:27:02 +0200
Date:   Sun, 6 Aug 2023 10:27:01 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Subject: Re: [PATCH] wifi: rt2x00: limit MT7620 TX power based on eeprom
 calibration
Message-ID: <20230806082701.GA361202@wp.pl>
References: <TYAP286MB0315C7523FE0E2EEA7413BC4BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315C7523FE0E2EEA7413BC4BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: 54899c07202484ee674b108f2c81a839
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EdPV]                               
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 05, 2023 at 05:17:55PM +0800, Shiji Yang wrote:
> In the vendor driver, the current channel power is queried from
> EEPROM_TXPOWER_BG1 and EEPROM_TXPOWER_BG2. And then the mixed value
> will be written into the low half-word of the TX_ALC_CFG_0 register.
> The high half-word of the TX_ALC_CFG_0 is a fixed value 0x2f2f.
> 
> We can't get the accurate TX power. Based on my tests and the new
> MediaTek mt76 driver source code, the real TX power is approximately
> equal to channel_power + (max) rate_power. Usually max rate_power is
> the gain of the OFDM 6M rate, which can be readed from the offset
> EEPROM_TXPOWER_BYRATE +1.
> 
> Based on these eeprom values, this patch adds basic TX power control
> for the MT7620 and limits its maximum TX power. This can avoid the
> link speed decrease caused by chip overheating. rt2800_config_alc()
> function has also been renamed to rt2800_config_alc_rt6352() because
> it's only used by RT6352(MT7620).
> 
> Notice:
> It's still need some work to sync the max channel power to the user
> interface. This part is missing from the rt2x00 driver framework. If
> we set the power exceed the calibration value, it won't take effect.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  .../net/wireless/ralink/rt2x00/rt2800lib.c    | 56 +++++++++++++------
>  1 file changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index 1226a883c..ff891353c 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -3865,28 +3865,50 @@ static void rt2800_config_channel_rf7620(struct rt2x00_dev *rt2x00dev,
>  	}
>  }
>  
> -static void rt2800_config_alc(struct rt2x00_dev *rt2x00dev,
> -			      struct ieee80211_channel *chan,
> -			      int power_level) {
> -	u16 eeprom, target_power, max_power;
> +static void rt2800_config_alc_rt6352(struct rt2x00_dev *rt2x00dev,
> +				     struct ieee80211_channel *chan,
> +				     int power_level)
> +{
> +	u16 eeprom, chan_power, rate_power, target_power;
> +	u16 tx_power[2];
> +	s8 *power_group[2];
>  	u32 mac_sys_ctrl;
> -	u32 reg;
> +	u32 cnt, reg;
>  	u8 bbp;
>  
> -	/* hardware unit is 0.5dBm, limited to 23.5dBm */
> -	power_level *= 2;
> -	if (power_level > 0x2f)
> -		power_level = 0x2f;
> +	/* get per chain power, 2 chains in total, unit is 0.5dBm */
> +	power_level = (power_level - 3) * 2;
> +
> +	/*
> +	 * We can't get the accurate TX power. Based on some tests, the real
> +	 * TX power is approximately equal to channel_power + (max)rate_power.
> +	 * Usually max rate_power is the gain of the OFDM 6M rate. The antenna
> +	 * gain and externel PA gain are not included as we are unable to
> +	 * obtain these values.
> +	 */
> +	rate_power = rt2800_eeprom_read_from_array(rt2x00dev,
> +						   EEPROM_TXPOWER_BYRATE, 1);
> +	rate_power &= 0x3f;
> +	power_level -= rate_power;
> +	if (power_level < 1)
> +		power_level = 1;
> +	if (power_level > chan->max_power * 2)
> +		power_level = chan->max_power * 2;
>  
> -	max_power = chan->max_power * 2;
> -	if (max_power > 0x2f)
> -		max_power = 0x2f;
> +	power_group[0] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG1);
> +	power_group[1] = rt2800_eeprom_addr(rt2x00dev, EEPROM_TXPOWER_BG2);
> +	for (cnt = 0; cnt < 2; cnt++) {
> +		chan_power = power_group[cnt][rt2x00dev->rf_channel - 1];

I whould add

if (WARN_ON(rt2x00dev->rf_channel not in proper range))
	return;

just to be on safe side. This can be done in separate patch, if you think
it is appropriate.

The change overall looks ok to me.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

