Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14236EC88F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjDXJRy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 05:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjDXJRv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 05:17:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2E01FCF
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 02:17:49 -0700 (PDT)
Message-ID: <f1e3e2ef-c91e-bfcd-657e-d124e8cc593e@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682327867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9prlIwkDQG0LxyhXy5KHI3dPLxZHRFxS+D6PyN5DJZA=;
        b=VwkFkMBmza70TDlcKcsFhc0ej11aKda7GWNC87E2A5Sfbylvw9fPE/HYRVC/ee+mGQGKM7
        nYe8ec2r3UrLgwywFIL8PRqZLbdlbqCdXk9P7XnwMl7q9kUTfkBidU+shRooVt8ppkNN4e
        T2eQwg+HH91JhmIr+OdGwdqTwI6bEi35HaJK5P+gAjeHJ1pjL69p5zxRlmqlvXgcR8DwFq
        6mUyOoQHg/T4YafPVctCrfjcFNE5npniC3sRARW51d+4q2LqVDEAL15cWrNF9CkLd6F+fv
        nLPPMMjFCEUr7VougQL7jg/3OQ4DUPmbGeyE7OapgAGe6LFrpXeqrwhWy3HlAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682327867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9prlIwkDQG0LxyhXy5KHI3dPLxZHRFxS+D6PyN5DJZA=;
        b=soEZRU2f/IEHCtIYd2Dshf4Ow4IaJ2RDelfh8Jgx/y44mL2mNAPvlGa/PHzcbkQJWKr+Bq
        fwDAS9d2WzVJvxAQ==
Date:   Mon, 24 Apr 2023 11:17:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/18] wifi: rtl8xxxu: Add beacon functions
Content-Language: de-DE
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
 <20230419100145.159191-4-martin.kaistra@linutronix.de>
 <9849321bafb64c4c941955e27f85fa13@realtek.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <9849321bafb64c4c941955e27f85fa13@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 24.04.23 um 04:29 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Wednesday, April 19, 2023 6:02 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH v2 03/18] wifi: rtl8xxxu: Add beacon functions
>>
>> Add a workqueue to update the beacon contents asynchronously and
>> implement downloading the beacon to the HW and starting beacon tx like
>> the vendor driver.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> 
> [...]
> 
>> @@ -4885,6 +4903,22 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>                  dev_dbg(dev, "Changed BASIC_RATES!\n");
>>                  rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
>>          }
>> +
>> +       if (changed & BSS_CHANGED_BEACON ||
>> +           (changed & BSS_CHANGED_BEACON_ENABLED &&
>> +            bss_conf->enable_beacon)) {
>> +               if (!priv->beacon_enabled) {
> 
> Is it possible to rely on bss_conf->enable_beacon only? Then, we don't need
> priv->beacon_enabled. Like
> 
> if (changed & BSS_CHANGED_BEACON_ENABLED && bss_conf->enable_beacon)
>        rtl8xxxu_start_tx_beacon(priv);
> 
> if (changed & BSS_CHANGED_BEACON)
>        schedule_work(&priv->update_beacon_work);
> 
> if (changed & BSS_CHANGED_BEACON_ENABLED && !bss_conf->enable_beacon)
>        rtl8xxxu_stop_tx_beacon(priv);

Looking at the the mac80211 code which calls ops->bss_info_changed(), this seems 
fine to me. I will implement your suggestion and do some testing.

> 
>> +                       dev_dbg(dev, "BSS_CHANGED_BEACON_ENABLED\n");
>> +                       rtl8xxxu_start_tx_beacon(priv);
>> +               }
>> +               schedule_work(&priv->update_beacon_work);
>> +       }
>> +
>> +       if (changed & BSS_CHANGED_BEACON_ENABLED && !bss_conf->enable_beacon) {
>> +               if (priv->beacon_enabled)
>> +                       rtl8xxxu_stop_tx_beacon(priv);
>> +       }
>> +
>>   error:
>>          return;
>>   }
> 
> [...]
> 
