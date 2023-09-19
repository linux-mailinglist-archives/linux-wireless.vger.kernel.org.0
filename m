Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1BD7A611B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 13:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjISLYv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 07:24:50 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E15B8
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nz9zy64piDIMjKVico5bSyWsHNkVnY1RNGYYRHL51Zw=; b=aNOOktZO6O52E/flwiUp8tEJ3G
        T0tQrqe6oLZvU4zr71v11Q/up3KwcImcNhA2pBcb73A4M+Rlsy6SOsGhmzci/9Ib6wQ/Ojf2xFled
        xT+DLiTs/SONj8r/ugk3r+6B0UUc1NoQ3ybis6VDRWnGY1WPr0784Ybax6WE3gR0tGg4=;
Received: from p54ae986d.dip0.t-ipconnect.de ([84.174.152.109] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qiYqP-004Ocv-IP; Tue, 19 Sep 2023 13:24:41 +0200
Message-ID: <8af6de3f-0248-4f86-82fb-bd437f00c61c@nbd.name>
Date:   Tue, 19 Sep 2023 13:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt76x02: correct external LNA gain
Content-Language: en-US
To:     Shiji Yang <yangshiji66@outlook.com>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
References: <TYAP286MB0315A2BAF9E9E74B2377EE4CBCFAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
From:   Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <TYAP286MB0315A2BAF9E9E74B2377EE4CBCFAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19.09.23 06:48, Shiji Yang wrote:
> Referring to the MT761{0,2} EEPROM content, setting the corresponding
> EEPROM control bit means enabling external LNA. In this case, we
> should use the EEMROM LNA gain instead of 0.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
> index 0acabba2d..a0b95509a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
> @@ -135,9 +135,9 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
>   	u8 lna;
>   
>   	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
> -	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
> +	if (!(val & MT_EE_NIC_CONF_1_LNA_EXT_2G))
>   		*lna_2g = 0;
> -	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
> +	if (!(val & MT_EE_NIC_CONF_1_LNA_EXT_5G))
>   		memset(lna_5g, 0, sizeof(s8) * 3);
>   
>   	if (chan->band == NL80211_BAND_2GHZ)

I took a closer look at the interpretation of these flags and how they
are handled in the vendor driver. From what I can tell, on MT76x2 LNA
gain should only be used as part of the RSSI calculation for internal
LNA devices. In the MT76x0 code, I see no such checks, so the LNA gain
should be used unconditionally.
What do you think about this patch?

Thanks,

- Felix

---
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -131,15 +131,8 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
  			s8 *lna_2g, s8 *lna_5g,
  			struct ieee80211_channel *chan)
  {
-	u16 val;
  	u8 lna;
  
-	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
-		*lna_2g = 0;
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
-		memset(lna_5g, 0, sizeof(s8) * 3);
-
  	if (chan->band == NL80211_BAND_2GHZ)
  		lna = *lna_2g;
  	else if (chan->hw_value <= 64)
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -256,7 +256,8 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
  	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
  	int channel = chan->hw_value;
  	s8 lna_5g[3], lna_2g;
-	u8 lna;
+	bool use_lna;
+	u8 lna = 0;
  	u16 val;
  
  	if (chan->band == NL80211_BAND_2GHZ)
@@ -275,7 +276,14 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
  	dev->cal.rx.mcu_gain |= (lna_5g[1] & 0xff) << 16;
  	dev->cal.rx.mcu_gain |= (lna_5g[2] & 0xff) << 24;
  
-	lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+	if (chan->band == NL80211_BAND_2GHZ)
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_2G);
+	else
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_5G);
+
+	if (use_lna)
+		lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+
  	dev->cal.rx.lna_gain = mt76x02_sign_extend(lna, 8);
  }
  EXPORT_SYMBOL_GPL(mt76x2_read_rx_gain);

