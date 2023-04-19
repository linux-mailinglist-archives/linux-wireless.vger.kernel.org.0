Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778B6E76E0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjDSJz5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjDSJzw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 05:55:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D67A80
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 02:55:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id gw13so16806873wmb.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681898149; x=1684490149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds5O5nMLGTHvNi2vfdWdedGUv2hqlyhMIVMlXQVqEog=;
        b=OGZaa7KXqolZ0PVPwhdGTh40aMvDPPgcbRjcAPYqOaNG1dCU9VjwPCovSV5Ue1CXjO
         xuUeEA+GDsUJgeaM74/Q++iN61y6/mO5xV03h0z0m5NxcnEXLfWUEQ0iiPRs2JYsqtix
         zPLjLe4EZNwI03946iYq+362CHqkCIWh5oktQCZxeRtfiYu+4HH5x6k1WbqSuZJE0esr
         0wJoxP6DJPjOl9gKcVrrmYnonLKMg1MqAjhN2b74Xiw2EltrDEx0PiW2h2FzxoAkvf7t
         FFIepGwxLA2FMmXslYCoZ+OyD9bGq6stfymSv2grPhQTDQ1IBligRO6B7c23O30bt2C+
         vUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681898149; x=1684490149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds5O5nMLGTHvNi2vfdWdedGUv2hqlyhMIVMlXQVqEog=;
        b=VWI/1ghZFHdlDm1OK+iewcl7uS6DBrYdWH+cLXZA4xTYrqZs+XMAd0VrIMtjMW4I5N
         aLNWuEofR6LhjlVsqcLOpRI/nI1x8rNvYdtTRXUov9/uHC7H3KOz4APWHsxx1BzQU3YX
         /2xcCpjhNbh5VEWdiHibxsVdwFVE+ADgHtp9QtJqv/LIcqChvIehQCFrIS7NOcGVvKbh
         /BRxZxRTmsJgmfvsYkFjMaFZ4uHjOeMpw5LwF9bGwqqDg8pdvol8D7pJXf7qbja0Pnkh
         8T//SGZTJpxspCZ7BfYRQQUJDY5scJt5k7LtMcDgnhPnxHmhcuXnd8/BDTkBLMRONdPT
         doPw==
X-Gm-Message-State: AAQBX9ch5TvlzbfwmdIyFD21lx6Iw4LrL9Ce2XUyYFo9xfzUrP1m69Fc
        4JvjMYazbwM7QTEQfGXjcBCCQWzwfr0=
X-Google-Smtp-Source: AKy350bD+KgdLsS0FkJXjIlZZlxy5lkqI/QtOitrl2fYWnQVe4YsFSHdrjcqiQW6oBWUEX+aVXvGfQ==
X-Received: by 2002:a1c:720a:0:b0:3f1:7ea7:20e5 with SMTP id n10-20020a1c720a000000b003f17ea720e5mr1845270wmc.17.1681898148897;
        Wed, 19 Apr 2023 02:55:48 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d4911000000b002e55cc69169sm15414770wrq.38.2023.04.19.02.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:55:48 -0700 (PDT)
Message-ID: <c4fd7adf-b6b2-8662-a058-529c9b086561@gmail.com>
Date:   Wed, 19 Apr 2023 12:55:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: Support USB RX aggregation for the newer
 chips
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <be2cd114-38c6-d539-446a-a35a872449fc@gmail.com>
 <898154829e2d493c89c73026eb232a29@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <898154829e2d493c89c73026eb232a29@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/04/2023 04:20, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Tuesday, April 18, 2023 9:05 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH] wifi: rtl8xxxu: Support USB RX aggregation for the newer chips
>>
>> The driver can receive several frames in the same USB transfer.
>> Add the code to handle this in rtl8xxxu_parse_rxdesc24(), even though
>> currently all the relevant chips send only one frame per USB transfer
>> (RTL8723BU, RTL8192EU, RTL8188FU, RTL8710BU).
>>
>> rtl8xxxu_parse_rxdesc16() used by RTL8723AU, RTL8192CU, and RTL8188EU
>> already handles RX aggregation.
>>
>> This was tested with RTL8188FU, RTL8192EU, RTL8710BU, and RTL8192FU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 117 ++++++++++++------
>>  1 file changed, 76 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index fd8c8c6d53d6..5fccd898d607 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -6197,61 +6197,96 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>  int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>  {
>>         struct ieee80211_hw *hw = priv->hw;
>> -       struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
>> -       struct rtl8xxxu_rxdesc24 *rx_desc =
>> -               (struct rtl8xxxu_rxdesc24 *)skb->data;
>> +       struct ieee80211_rx_status *rx_status;
>> +       struct rtl8xxxu_rxdesc24 *rx_desc;
>>         struct rtl8723au_phy_stats *phy_stats;
>> -       __le32 *_rx_desc_le = (__le32 *)skb->data;
>> -       u32 *_rx_desc = (u32 *)skb->data;
>> +       struct sk_buff *next_skb = NULL;
>> +       __le32 *_rx_desc_le;
>> +       u32 *_rx_desc;
>>         int drvinfo_sz, desc_shift;
>> -       int i;
>> +       int i, pkt_len, urb_len, pkt_offset;
>>
>> -       for (i = 0; i < (sizeof(struct rtl8xxxu_rxdesc24) / sizeof(u32)); i++)
>> -               _rx_desc[i] = le32_to_cpu(_rx_desc_le[i]);
>> +       urb_len = skb->len;
>>
>> -       memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
>> +       if (urb_len < sizeof(struct rtl8xxxu_rxdesc24)) {
>> +               kfree_skb(skb);
>> +               return RX_TYPE_ERROR;
>> +       }
>>
>> -       skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc24));
>> +       do {
>> +               rx_desc = (struct rtl8xxxu_rxdesc24 *)skb->data;
>> +               _rx_desc_le = (__le32 *)skb->data;
>> +               _rx_desc = (u32 *)skb->data;
>>
>> -       phy_stats = (struct rtl8723au_phy_stats *)skb->data;
>> +               for (i = 0; i < (sizeof(struct rtl8xxxu_rxdesc24) / sizeof(u32)); i++)
>> +                       _rx_desc[i] = le32_to_cpu(_rx_desc_le[i]);
>>
>> -       drvinfo_sz = rx_desc->drvinfo_sz * 8;
>> -       desc_shift = rx_desc->shift;
>> -       skb_pull(skb, drvinfo_sz + desc_shift);
>> +               pkt_len = rx_desc->pktlen;
>>
>> -       if (rx_desc->rpt_sel) {
>> -               struct device *dev = &priv->udev->dev;
>> -               dev_dbg(dev, "%s: C2H packet\n", __func__);
>> -               rtl8723bu_handle_c2h(priv, skb);
>> -               return RX_TYPE_C2H;
>> -       }
>> +               drvinfo_sz = rx_desc->drvinfo_sz * 8;
>> +               desc_shift = rx_desc->shift;
>> +               pkt_offset = roundup(pkt_len + drvinfo_sz + desc_shift +
>> +                                    sizeof(struct rtl8xxxu_rxdesc24), 8);
>>
>> -       if (rx_desc->phy_stats)
>> -               priv->fops->parse_phystats(priv, rx_status, phy_stats,
>> -                                          rx_desc->rxmcs, (struct ieee80211_hdr *)skb->data,
>> -                                          rx_desc->crc32 || rx_desc->icverr);
>> +               /*
>> +                * Only clone the skb if there's enough data at the end to
>> +                * at least cover the rx descriptor
>> +                */
>> +               if (urb_len >= (pkt_offset + sizeof(struct rtl8xxxu_rxdesc24)))
> 
> That means you use 'sizeof(struct rtl8xxxu_rxdesc24)' as clue to know if this
> is the last packet or not, right?
> 
> Do you think if it is needed to handle malformed packet for the last skb if
> its length is shorter than pkt_offset or pkt_len?
> 

I'm not sure. I just copied what rtl8xxxu_parse_rxdesc16() was doing.

>> +                       next_skb = skb_clone(skb, GFP_ATOMIC);
>>
>> -       rx_status->mactime = rx_desc->tsfl;
>> -       rx_status->flag |= RX_FLAG_MACTIME_START;
>> +               rx_status = IEEE80211_SKB_RXCB(skb);
>> +               memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
>>
>> -       if (!rx_desc->swdec)
>> -               rx_status->flag |= RX_FLAG_DECRYPTED;
>> -       if (rx_desc->crc32)
>> -               rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>> -       if (rx_desc->bw)
>> -               rx_status->bw = RATE_INFO_BW_40;
>> +               skb_pull(skb, sizeof(struct rtl8xxxu_rxdesc24));
>>
>> -       if (rx_desc->rxmcs >= DESC_RATE_MCS0) {
>> -               rx_status->encoding = RX_ENC_HT;
>> -               rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
>> -       } else {
>> -               rx_status->rate_idx = rx_desc->rxmcs;
>> -       }
>> +               phy_stats = (struct rtl8723au_phy_stats *)skb->data;
>> +
>> +               skb_pull(skb, drvinfo_sz + desc_shift);
>> +
>> +               skb_trim(skb, pkt_len);
>> +
>> +               if (rx_desc->rpt_sel) {
>> +                       struct device *dev = &priv->udev->dev;
>> +                       dev_dbg(dev, "%s: C2H packet\n", __func__);
>> +                       rtl8723bu_handle_c2h(priv, skb);
>> +               } else {
>> +                       if (rx_desc->phy_stats)
>> +                               priv->fops->parse_phystats(priv, rx_status, phy_stats,
>> +                                                          rx_desc->rxmcs, (struct ieee80211_hdr
>> *)skb->data,
>> +                                                          rx_desc->crc32 || rx_desc->icverr);
> 
> This statement is too long. Add a helper 'struct ieee80211_hdr *hdr', like
> 
> if (rx_desc->phy_stats) {
>         struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
> 
>         priv->fops->parse_phystats(priv, rx_status, phy_stats,
>                                    rx_desc->rxmcs, hdr,
>                                    rx_desc->crc32 || rx_desc->icverr);
> }
> 

Okay.

> 
>> +
>> +                       rx_status->mactime = rx_desc->tsfl;
>> +                       rx_status->flag |= RX_FLAG_MACTIME_START;
>> +
>> +                       if (!rx_desc->swdec)
>> +                               rx_status->flag |= RX_FLAG_DECRYPTED;
>> +                       if (rx_desc->crc32)
>> +                               rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>> +                       if (rx_desc->bw)
>> +                               rx_status->bw = RATE_INFO_BW_40;
>>
>> -       rx_status->freq = hw->conf.chandef.chan->center_freq;
>> -       rx_status->band = hw->conf.chandef.chan->band;
>> +                       if (rx_desc->rxmcs >= DESC_RATE_MCS0) {
>> +                               rx_status->encoding = RX_ENC_HT;
>> +                               rx_status->rate_idx = rx_desc->rxmcs - DESC_RATE_MCS0;
>> +                       } else {
>> +                               rx_status->rate_idx = rx_desc->rxmcs;
>> +                       }
>> +
>> +                       rx_status->freq = hw->conf.chandef.chan->center_freq;
>> +                       rx_status->band = hw->conf.chandef.chan->band;
>> +
>> +                       ieee80211_rx_irqsafe(hw, skb);
>> +               }
>> +
>> +               skb = next_skb;
>> +               if (skb)
>> +                       skb_pull(next_skb, pkt_offset);
>> +
>> +               urb_len -= pkt_offset;
>> +               next_skb = NULL;
>> +       } while (skb && urb_len >= sizeof(struct rtl8xxxu_rxdesc24));
>>
>> -       ieee80211_rx_irqsafe(hw, skb);
>>         return RX_TYPE_DATA_PKT;
>>  }
>>
>> --
>> 2.39.2
>>
>> ------Please consider the environment before printing this e-mail.

