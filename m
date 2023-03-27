Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E36CA559
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC0NPP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 09:15:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4171FCA
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:15:12 -0700 (PDT)
Message-ID: <68eddf63-cd44-881b-bfbe-004fe13b5e71@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679922910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPpEOYR1bpWc5WtUSMqguSRu3LVgkgDlYvRwHmL+Ktc=;
        b=estDlRLNBDdFZT/nMqgU/+LgFEgoQiRkG9RYK9POFqwSWddSqiNLL577o57qJy+YVJ9NNy
        6Vy/iUN7xow3mat6nYlrC6sErHUr/3zNkZ1cXUQrKPNHurNATSQsgmJtRR1UPZS2Q16Hy3
        dyUzYo91J2sPdlZhYHBTlahvocxP6jJn29Lwa114llWQjDrxX/ZLGM8nnAZRpvfE8ORNrr
        /0UJ+C+YzLMJGLvpIeUqGQlH+a8yGldGpxaCvlNqOIFyKoOWPpGyEwchKEIZgOFZrPwlkf
        cI5FZkiJL6KpHNoSEIlFwWl1R4kijVLtsl2DbwHblfP7Ht5+eUFcbMJF2X5Qdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679922910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPpEOYR1bpWc5WtUSMqguSRu3LVgkgDlYvRwHmL+Ktc=;
        b=iRj/OmjHbIZsDrnIOCugV449/XzCN+SfcL3fNbLeV905hcH2zXPZSf7kKp41Xmlr/IfNnn
        JsItDxODHmYoP/DA==
Date:   Mon, 27 Mar 2023 15:15:10 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH 06/14] wifi: rtl8xxxu: Allow creating interface in AP
 mode
Content-Language: de-DE
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-7-martin.kaistra@linutronix.de>
 <f7ee22097962476da7f8e8cdbf040712@realtek.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <f7ee22097962476da7f8e8cdbf040712@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 27.03.23 um 03:39 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Thursday, March 23, 2023 1:19 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [RFC PATCH 06/14] wifi: rtl8xxxu: Allow creating interface in AP mode
>>
>> Use the sequence from the vendor driver for setting up the beacon
>> related registers.
>> Also set the MAC address register.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 31 ++++++++++++++++---
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  2 ++
>>   2 files changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index b233c66a7a5a8..b20ff8bc40870 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -6408,18 +6408,39 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>>          int ret;
>>          u8 val8;
>>
>> +       if (!priv->vif)
>> +               priv->vif = vif;
>> +       else
>> +               return -EOPNOTSUPP;
>> +
>>          switch (vif->type) {
>>          case NL80211_IFTYPE_STATION:
>> -               if (!priv->vif)
>> -                       priv->vif = vif;
>> -               else
>> -                       return -EOPNOTSUPP;
>>                  rtl8xxxu_stop_tx_beacon(priv);
>>
>>                  val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
>>                  val8 |= BEACON_ATIM | BEACON_FUNCTION_ENABLE |
>>                          BEACON_DISABLE_TSF_UPDATE;
>>                  rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
>> +               ret = 0;
>> +               break;
>> +       case NL80211_IFTYPE_AP:
>> +               rtl8xxxu_write8(priv, REG_BEACON_CTRL,
>> +                               BEACON_DISABLE_TSF_UPDATE | BEACON_CTRL_MBSSID);
>> +               rtl8xxxu_write8(priv, REG_ATIMWND, 0x0c); /* 12ms */
>> +               rtl8xxxu_write16(priv, REG_TSFTR_SYN_OFFSET, 0x7fff); /* ~32ms */
>> +               rtl8xxxu_write8(priv, REG_DUAL_TSF_RST, DUAL_TSF_RESET_TSF0);
>> +
>> +               /* enable BCN0 function */
>> +               rtl8xxxu_write8(priv, REG_BEACON_CTRL,
>> +                               BEACON_DISABLE_TSF_UPDATE |
>> +                               BEACON_FUNCTION_ENABLE | BEACON_CTRL_MBSSID |
>> +                               BEACON_CTRL_TX_BEACON_RPT);
>> +
>> +               /* select BCN on port 0 */
>> +               val8 = rtl8xxxu_read8(priv, REG_CCK_CHECK);
>> +               val8 &= ~BIT_BCN_PORT_SEL;
>> +               rtl8xxxu_write8(priv, REG_CCK_CHECK, val8);
>> +
>>                  ret = 0;
>>                  break;
>>          default:
>> @@ -6427,6 +6448,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>>          }
>>
>>          rtl8xxxu_set_linktype(priv, vif->type);
>> +       ether_addr_copy(priv->mac_addr, vif->addr);
>> +       rtl8xxxu_set_mac(priv);
> 
> rtl8xxxu_set_mac() is already called by rtl8xxxu_init_device(). Is there
> anything unexpected?

If the hostapd config has the option "bssid" set, this will be set as 
the MAC address for the interface in AP mode. If the MAC address 
registers are not updated, then I don't see any ack frames being send.

The same could probably happen if the MAC address is set via
ip link set dev <wlan_name> address <MAC address>

Maybe the call to rtl8xxxu_set_mac() in rtl8xxxu_init_device() can be 
removed, if it is also called here.

> 
> While I reviewed first patch, I would like to suggest to call calibration:
>    fops->phy_lc_calibrate(priv);
>    fops->phy_iq_calibrate(priv);
> I traced rtl8xxxu and saw they present in rtl8xxxu_init_device() and rtl8xxxu
> doesn't implement idle power saving to turn off power of wifi card. Then, I
> think the calibration will be fine if rtl8xxxu only does it once.
> 
> So, I would like to know if something I miss.
> 
