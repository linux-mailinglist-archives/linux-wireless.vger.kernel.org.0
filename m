Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1262024F0F3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 03:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgHXBpl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Aug 2020 21:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHXBpl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Aug 2020 21:45:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188AC061573
        for <linux-wireless@vger.kernel.org>; Sun, 23 Aug 2020 18:45:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b17so6284516wru.2
        for <linux-wireless@vger.kernel.org>; Sun, 23 Aug 2020 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8g/pLTw9GCJfClSnmXpCVayp8RocKK+bN8K6HeHj03Q=;
        b=aMfUR5uuvok6BvYejglLbmplrIv4kdLQrXCWuyHdA4hDH/hUcC0Y2uJ2N5cGe7goVq
         jMR6BTW/+HpSu7lzr2J9m4SLzJ3bbwym8dhPoUDFxaHwNd+OmhN6JBxjuxMfPgSHh59y
         9JWv0LOjGe3lv1H7lEKvNn7621VcKY9C2AR3uNcjE0XtPI8tuJSBt/90Kx0fjxucrTGG
         1/SccBzEtT+Wint0W/85n0jLCcs6nNDqd3wKKDvtb6TQBxCTc+9LhupOIAsJsEL95MTA
         20xRozMi2t5IlMhIAHbn9obw70/yjnddvxG0f58hXTTTwdqET6FWWYE2MSodjqdayz+M
         6oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8g/pLTw9GCJfClSnmXpCVayp8RocKK+bN8K6HeHj03Q=;
        b=NdqCZtU8AoXB3YW/7a++QgvdB4aHC9aeiOdxMUs+na9m5rx5xQYk34RJaPXAzYEUkj
         pCQiOBrzqK6pel0+0GKuhDMfkb3cTPYFD7EOYjuLsmHPQbC9EgkYPNuXNOVRFEbjtaRb
         iaJt0QArpz1LTrXcfD7HFy22Z3OH9XcK49MM2B5/HKtCcW3t6kvp3uKcEv1jKGInLaiw
         YSlUSs3a5sK/3ost/ZYDHO2S77vD4EPkTHKK/fHCsRwAGQgpIg9gccWlvtZEZGj7ToSn
         BokWpgepUkoqBrpf8fWcQ/q5f4APdLFDi/BH58MQolI1oX9JLYLY8NEY6nEZp4Y1JgF7
         LUgQ==
X-Gm-Message-State: AOAM530rk3QPGTMBOhhd2CNYRA7km56PAzkIwVyqGoV8cUuneqYRBwmm
        i6ITZK5q/PWHFvO/zWUtzyck6shJii6aFYnr
X-Google-Smtp-Source: ABdhPJx8k369sdtOKhn5V+AR3vYBj3hibuBObq5X6z3UqOXggWHwZA4ovelgDkH2wYiF87IQeUGYnA==
X-Received: by 2002:a5d:6711:: with SMTP id o17mr1969021wru.292.1598233538587;
        Sun, 23 Aug 2020 18:45:38 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id r3sm18229436wro.1.2020.08.23.18.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 18:45:37 -0700 (PDT)
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     Loic Poulain <loic.poulain@linaro.org>, kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <db8adbab-bf1a-0552-0dce-af4acee9719e@linaro.org>
Date:   Mon, 24 Aug 2020 02:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/08/2020 17:01, Loic Poulain wrote:
> For software-driven scan, rely on mac80211 software scan instead
> of internal driver implementation. The internal implementation
> cause connection trouble since it keep the antenna busy during
> the entire scan duration, moreover it's only a passive scanning
> (no probe request). Therefore, let mac80211 manages sw scan.
> 
> Note: we fallback to software scan if firmware does not report
> scan offload support or if we need to scan the 5Ghz band (currently
> not supported by the offload scan...).
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

OK.

TL;DR included diff fixes the performance issue.

I've poked about with the old scan, and this new scan and I've managed 
to find to find where the new scan is killing performance.

Please see below.

@@ -792,6 +792,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
  {
         struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
         struct wcn36xx_hal_finish_scan_req_msg msg_body;
+       u8 oper_channel;
         int ret;

         mutex_lock(&wcn->hal_mutex);
@@ -802,7 +803,9 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
                 /* Notify BSSID with null data packet */
                 msg_body.notify = 1;
                 msg_body.frame_type = 2;
-               msg_body.oper_channel = channel;
+               oper_channel = WCN36XX_HW_CHANNEL(wcn);
+               if (oper_channel != channel)
+                       msg_body.oper_channel = channel;
                 msg_body.scan_entry.bss_index[0] = vif_priv->bss_index;
                 msg_body.scan_entry.active_bss_count = 1;
         }

Happily, I'm finding with this modification on top of your patch

1. Running a continuous Android scan
    As in when you have the network scan window open
    A simultaneous "iperf -c xxx.xxx.xxx.xxx -i 1 -t 1800"
2. Performance is as expected
    I see throughput oscillate between 30 mbit and 100 mbit
    - Android runs a scan every 15 seconds
    - Software scan takes 11 seconds to complete
    - So this is expected behavior
3. During quiescent periods we have the expected throughput
4. We gain from the additional stability the rest of your patch provides

Specifically on #4 what I find with the old scan is that with some APs 
we can get a disassocation after a scan completes.

My test-case AP for that behavior is a Ubiquiti Nano HD on a 5ghz frequency.

Its funny that rewriting the operating channel in the finish_scan path 
should make a difference.

All I can guess at here is that the PHY mode doesn't get updated correctly

Loic, can you make sure you are happy with the change and V2 this patch?

You can retain my SoB.

---
bod
