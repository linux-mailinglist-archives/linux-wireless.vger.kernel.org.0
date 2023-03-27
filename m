Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A56CAA00
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjC0QI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjC0QI5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 12:08:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA6BF
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 09:08:56 -0700 (PDT)
Message-ID: <7efd83bd-f6f9-eb2c-3b6a-1795307d4e2f@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679933334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6LssaJPekRSjRe1Wm9EJ7qCY9kPNlTgyHfcIvtOJg8=;
        b=nWq+B4DH3VSY80pR1DSzlSyXXzK4GB4m+oshX8u1j1kWxmbFLb43k8uwvlRQj9r3Oat9KD
        VIWedi4A5azsrL9tEgqFd5tMCfsgsa6J4lh9k3pMB5mFPd57YzPPzM8hOSkAZZhDRTpUTw
        tjCRsCvcEbR5xQwzaUYn+eAAcHykkwNEeN+eoht/xAthEIIUIKNfYh0qYFCWybshz2F5ZK
        kZyf7U3klartzghJuN8eFHipssIQ/sXiU4ksYWoo3Wa2X1EQFRX2iebBZqXiTDcPUkH1fR
        NNxMZMvVlLm2meWRkSbF5kUVdGLd3RVd/COfIfJkD9Fz7rzNmzexbHRswIsviA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679933334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6LssaJPekRSjRe1Wm9EJ7qCY9kPNlTgyHfcIvtOJg8=;
        b=4QUPBkRevMKnskfsiEyLD2/pjWX1YpBxLXwQ5taP93fR9V1hy3NLHV05ufnEI0QUvekbpG
        zslC52VBty8/zaBw==
Date:   Mon, 27 Mar 2023 18:08:53 +0200
MIME-Version: 1.0
Subject: Re: [RFC PATCH 01/14] wifi: rtl8xxxu: Add start_ap() callback
Content-Language: de-DE, en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-2-martin.kaistra@linutronix.de>
 <62bf7fa9-e041-c8d8-c63e-42b3674fc9d8@gmail.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <62bf7fa9-e041-c8d8-c63e-42b3674fc9d8@gmail.com>
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

Am 27.03.23 um 15:10 schrieb Bitterblue Smith:
> On 22/03/2023 19:18, Martin Kaistra wrote:
>> This gets called at the start of AP mode operation. Set bssid, beacon
>> interval and send a connect report to the HW.
>>
> 
> Hmm, but why send a connect report when you don't have anything
> connected yet?

I tried following the vendor driver here, I don't know what exactly 
happens in the firmware.
I can test, though, if there is any difference, if I remove it.

> 
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index c152b228606f1..90b98b9dcbd9d 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4899,6 +4899,20 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>   	return;
>>   }
>>   
>> +static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>> +			     struct ieee80211_bss_conf *link_conf)
>> +{
>> +	struct rtl8xxxu_priv *priv = hw->priv;
>> +	struct device *dev = &priv->udev->dev;
>> +
>> +	dev_dbg(dev, "Start AP mode\n");
>> +	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
>> +	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
>> +	priv->fops->report_connect(priv, 0, true);
>> +
>> +	return 0;
>> +}
>> +
>>   static u32 rtl8xxxu_80211_to_rtl_queue(u32 queue)
>>   {
>>   	u32 rtlqueue;
>> @@ -7026,6 +7040,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
>>   	.config = rtl8xxxu_config,
>>   	.conf_tx = rtl8xxxu_conf_tx,
>>   	.bss_info_changed = rtl8xxxu_bss_info_changed,
>> +	.start_ap = rtl8xxxu_start_ap,
>>   	.configure_filter = rtl8xxxu_configure_filter,
>>   	.set_rts_threshold = rtl8xxxu_set_rts_threshold,
>>   	.start = rtl8xxxu_start,
> 
