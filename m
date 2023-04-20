Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9296E9B92
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjDTS0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDTS0r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 14:26:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB17272C
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 11:26:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f86ee42669so811535f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682015204; x=1684607204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmp/0Jx1odD2CjQqsBue22oM8EGfuthZc97Q5GcmLZk=;
        b=RlOVtisaBYz/PhYtl1GElL/N50Tw3r+TzfR4THSw7e5eNtuK9C2Zl/nt4C4P02RbWo
         axVbx+j4wKrtrmeWvKJqun7Kvo8sxYFdZCOSX3nBlSppyRKYwscKiWyUvP6kFjQPX0/6
         avrLhtlkm+V038lvrKzUUIKfNzquPb1Sc84VQ/O8lNTa/JAdbNmGS/AnAPiC8gBt3PnV
         v2bR63bA71Fya867LcSq3TTQlVIMYJBTpcDlu8Td8q3iOE6gHz6sj1jPjz96IWlUt5EW
         iuLR3eDTvQ8HUbx37gR0FIxrBZQ7bmBni0+v6eYLbpukutWOqK9zZDzqS6MWdLu9lw54
         5yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682015204; x=1684607204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmp/0Jx1odD2CjQqsBue22oM8EGfuthZc97Q5GcmLZk=;
        b=eii8/Akvfn86yDn2x64SrDD9kILpwwgoSinb20iXwGPQs1S6sHQD/IFX8rSWINvUeM
         AQEnu9zvEBb+DJK4H+skR8bv/3GEYlPvqsEbR8VfMrysWY3YN/4u5p1Z3XsgKq43LP0l
         SFjgkae1OAEOnTBZbNlC3bvyM7O5zGyjmEuxHM4pfK/5BCj45CR8fz74d6TuuTYzL8Hx
         uZFcL7lYgy/7f7q0ga4j/uU3rEE3FXM81JmPWsDyyonw57+FdewSzWCYJX54pD5NTk6A
         jSTloaXEcL2JgBYIzWiVP0yAKaQtyLZxXNnCxNuwIoHpJN6+C5NICmOEcN6bWBa9aSMQ
         UG0g==
X-Gm-Message-State: AAQBX9cPY5VIShjzTcxGgFenzILL5wmu5gbFY3UvlIoxLmu0dIUax0P5
        nbPHgt8EbYw3Cs/4htUgJt5dzJZO1Sk=
X-Google-Smtp-Source: AKy350b0G31yM9cYxNaGJiEoOwcKcWPX88itMqxaAgzZ61iK+9Hw10u5MkreCrQM1qFdPjmMNtMDDQ==
X-Received: by 2002:adf:f5c5:0:b0:2ef:a57e:bb9a with SMTP id k5-20020adff5c5000000b002efa57ebb9amr1972185wrp.6.1682015203922;
        Thu, 20 Apr 2023 11:26:43 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id g8-20020a056000118800b002fe0894ac09sm2547292wrx.81.2023.04.20.11.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 11:26:43 -0700 (PDT)
Message-ID: <8eaeb64e-3f7f-6752-4476-c0f0c88a008b@gmail.com>
Date:   Thu, 20 Apr 2023 21:26:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
Content-Language: en-US
To:     Artem Makhutov <artem.makhutov@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
 <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
 <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com>
 <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
 <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
 <3ceecfc1-ab04-7d54-51bd-457a4708c0ac@gmail.com>
 <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALbLcfCpb8xbN+w2VvCZ6Gdr+L_ECH0UQsWZrpO1Hcpoef66UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/04/2023 19:12, Artem Makhutov wrote:
> Hi,
> 
> Am Do., 20. Apr. 2023 um 17:33 Uhr schrieb Bitterblue Smith
> <rtl8821cerfe2@gmail.com>:
>>
>> On 20/04/2023 14:40, Artem Makhutov wrote:
>>> Hi,
>>>
>>> I think that I have found the problem: It happens when rx_desc->rxht
>>> == 1 - then the urb is 4 bytes shorter...
>>>
>>
>> That's very interesting. So it has a problem with MCS rates
>>
>> According to Johannes Berg, the 8 bytes at the end of the working ping
>> are the MIC, which mac80211 will strip. Of course mac80211 doesn't know
>> that rtl8xxxu sometimes receives 4 bytes fewer.
> 
> The strange thing is that this issue does not appear with another
> Logilink WL0151 connected to my home network... Here the MCS rates
> work fine and I am always getting the full 8 bytes.
> 
>> What kind of encryption does the network have? Is it possible to try
>> without any encryption?
> 
> It uses WPA1 + WPA2 right now. Before that we had WPA2 only and it was
> exactly the same.
> I also did a test without encryption before. As far as I remember I
> was able to send larger packets, but the issue was still there.
> I will redo the test without encryption to double check it.
> 
>> Another thing to try is software crypto, using this tested patch and
>> the module parameter debug=0x8000:
> 
> Just tried it out. There was no change at all.
> 
> Any ideas?

So it's probably not related to the encryption.

The v5.2.2.4 driver uses USB RX aggregation, unless you disabled it.
We can try to use it in rtl8xxxu too, with this patch and the
module parameter dma_aggregation=1:

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index d9fd7f79821b..169b66333fc3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1963,6 +1963,7 @@ struct rtl8xxxu_fileops {
 };
 
 extern int rtl8xxxu_debug;
+extern bool rtl8xxxu_dma_aggregation;
 
 extern const struct rtl8xxxu_reg8val rtl8xxxu_gen1_mac_init_table[];
 extern const u32 rtl8xxxu_iqk_phy_iq_bb_reg[];
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index 6d0f975f891b..ddd94d73816d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -540,14 +540,25 @@ static void rtl8188eu_config_channel(struct ieee80211_hw *hw)
 static void rtl8188eu_init_aggregation(struct rtl8xxxu_priv *priv)
 {
 	u8 agg_ctrl, usb_spec;
+	u8 rxagg_usb_size = 16;
+	u8 rxagg_usb_timeout = 6;
 
 	usb_spec = rtl8xxxu_read8(priv, REG_USB_SPECIAL_OPTION);
 	usb_spec &= ~USB_SPEC_USB_AGG_ENABLE;
+	if (rtl8xxxu_dma_aggregation)
+		usb_spec |= USB_SPEC_USB_AGG_ENABLE;
 	rtl8xxxu_write8(priv, REG_USB_SPECIAL_OPTION, usb_spec);
 
 	agg_ctrl = rtl8xxxu_read8(priv, REG_TRXDMA_CTRL);
 	agg_ctrl &= ~TRXDMA_CTRL_RXDMA_AGG_EN;
 	rtl8xxxu_write8(priv, REG_TRXDMA_CTRL, agg_ctrl);
+
+	if (rtl8xxxu_dma_aggregation) {
+		rtl8xxxu_write8(priv, REG_USB_AGG_THRESH, rxagg_usb_size);
+		rtl8xxxu_write8(priv, REG_USB_AGG_TIMEOUT, rxagg_usb_timeout);
+
+		priv->rx_buf_aggregation = 1;
+	}
 }
 
 static int rtl8188eu_parse_efuse(struct rtl8xxxu_priv *priv)
@@ -1877,6 +1888,8 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.cck_rssi = rtl8188e_cck_rssi,
 	.led_classdev_brightness_set = rtl8188eu_led_brightness_set,
 	.writeN_block_size = 128,
+	.rx_agg_buf_size = 15360 - sizeof(struct rtl8xxxu_rxdesc16)
+				 - sizeof(struct rtl8723au_phy_stats),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.has_tx_report = 1,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 01285300b83b..9b7fe459cb78 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -36,7 +36,7 @@
 
 int rtl8xxxu_debug;
 static bool rtl8xxxu_ht40_2g;
-static bool rtl8xxxu_dma_aggregation;
+bool rtl8xxxu_dma_aggregation;
 static int rtl8xxxu_dma_agg_timeout = -1;
 static int rtl8xxxu_dma_agg_pages = -1;
 
@@ -6240,6 +6240,8 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 		return RX_TYPE_ERROR;
 	}
 
+	// pr_warn("urb_len: %d\n", urb_len);
+
 	do {
 		rx_desc = (struct rtl8xxxu_rxdesc16 *)skb->data;
 		_rx_desc_le = (__le32 *)skb->data;
@@ -6259,8 +6261,21 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 		drvinfo_sz = rx_desc->drvinfo_sz * 8;
 		desc_shift = rx_desc->shift;
+
+		if (rx_desc->rpt_sel == 1) {
+			pkt_len = 8;
+			drvinfo_sz = 0;
+			desc_shift = 0;
+		} else if (rx_desc->rpt_sel == 2) {
+			pkt_len = pkt_len & 0x3ff;
+			drvinfo_sz = 0;
+			desc_shift = 0;
+		}
+
 		pkt_offset = roundup(pkt_len + drvinfo_sz + desc_shift +
-				     sizeof(struct rtl8xxxu_rxdesc16), 128);
+				     sizeof(struct rtl8xxxu_rxdesc16), 4);
+
+		// pr_warn("  pkt_len %d pkt_offset %d rpt_sel %d\n", pkt_len, pkt_offset, rx_desc->rpt_sel);
 
 		/*
 		 * Only clone the skb if there's enough data at the end to
@@ -6275,16 +6290,16 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 
 		skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc16));
 
+		phy_stats = (struct rtl8723au_phy_stats *)skb->data;
+
+		skb_pull(skb, drvinfo_sz + desc_shift);
+
+		skb_trim(skb, pkt_len);
+
 		if (rx_desc->rpt_sel) {
 			skb_queue_tail(&priv->c2hcmd_queue, skb);
 			schedule_work(&priv->c2hcmd_work);
 		} else {
-			phy_stats = (struct rtl8723au_phy_stats *)skb->data;
-
-			skb_pull(skb, drvinfo_sz + desc_shift);
-
-			skb_trim(skb, pkt_len);
-
 			if (rx_desc->phy_stats)
 				priv->fops->parse_phystats(
 					priv, rx_status, phy_stats,

