Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2846F120D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345171AbjD1G7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 02:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1G7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 02:59:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D8A1731
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 23:59:26 -0700 (PDT)
Message-ID: <a1ab0e82-5ec5-8d33-5f8c-b8bbf88ed87c@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682665165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+1TTu/qRAxokKaATxZsd7KJTirt4ZOhvSrlcWbDkWk=;
        b=nEi5+HtDWnlqCnV4oVbKGHo0vCBvTBJBlO4a4dpzT4u/NrasyJYLh0iuHV6WEUGaETJbrD
        I9uWqTswXYGbyGIeCo+8UbbhxbWaIB5+3UUL8Fh05fyryTdDXgQ+g8aF5eANvHPfAT0G7u
        rHP4lKVkHHBxgdI4TGWqWI9eg4Z5/kLPmBmRsGtWPm6zjUuqti2pmy7vq8TvZkchXnIJSq
        ZnvoxhW1CpGW0L6FPAFddRgBAWfVZiDpEF00pmccv+k6EZX2Kp+0DuGRuZO1fJP+girk15
        jHuwOcZ7l71Ann4OmkVEw/1xsyLNg/uYg9Ppsj0NA8eAgLP63NMWyQJhcWWdoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682665165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+1TTu/qRAxokKaATxZsd7KJTirt4ZOhvSrlcWbDkWk=;
        b=TcR4pZNkv+yhhgLW3IREjpLlojD/ze248wdqUtLis0RARUnbiF5BlAf4vqK9be4bZWB6Dw
        5X55Zxvj396v2VBQ==
Date:   Fri, 28 Apr 2023 08:59:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 03/18] wifi: rtl8xxxu: Add beacon functions
Content-Language: de-DE
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
 <20230427090922.165088-4-martin.kaistra@linutronix.de>
 <39b41578a55e4375a6bdd5b127a3f20b@realtek.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <39b41578a55e4375a6bdd5b127a3f20b@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 28.04.23 um 02:38 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Thursday, April 27, 2023 5:09 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH v3 03/18] wifi: rtl8xxxu: Add beacon functions
>>
>> Add a workqueue to update the beacon contents asynchronously and
>> implement downloading the beacon to the HW and starting beacon tx like
>> the vendor driver.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
> 
> [...]
> 
>>   /*
>>    * The rtl8723a has 3 channel groups for it's efuse settings. It only
>> @@ -4964,6 +4978,16 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>                  dev_dbg(dev, "Changed BASIC_RATES!\n");
>>                  rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
>>          }
>> +
>> +       if (changed & BSS_CHANGED_BEACON_ENABLED && bss_conf->enable_beacon)
>> +               rtl8xxxu_start_tx_beacon(priv);
>> +
>> +       if (changed & BSS_CHANGED_BEACON)
>> +               schedule_work(&priv->update_beacon_work);
>> +
>> +       if (changed & BSS_CHANGED_BEACON_ENABLED && !bss_conf->enable_beacon)
>> +               rtl8xxxu_stop_tx_beacon(priv);
>> +
> 
> I thought these three synchronous works, so I have this suggestion, but actually
> update_beacon_work is asynchronous. Then, we can start/stop tx_beacon into a
> branch.

I guess I will prepare a v4 then.

> 
> 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
> 		if (bss_conf->enable_beacon)
> 			rtl8xxxu_start_tx_beacon(priv);
> 		else
> 			rtl8xxxu_stop_tx_beacon(priv);
> 	}
> 
> 	if (changed & BSS_CHANGED_BEACON)
> 		schedule_work(&priv->update_beacon_work);
> 
> Ping-Ke
> 

