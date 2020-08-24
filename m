Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3D224F352
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHXHq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 03:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHXHq0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 03:46:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DABC061573
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 00:46:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id oz20so5667735ejb.5
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGnMShr3jyWL9jcFhE2qBOM91zVzJyGFbhCG+OBGJbE=;
        b=u6hiAteQ4cqHI8spIHsC+IRH5LLOSsBqgcolHjR9i5bAQ/V6zifbAVzylEPBy758qk
         GMiffk+84EX5t2gRh1iS3o9RHPg6sW0zd8VEWBBA3VZsmqUK2J5gwoEose5LDlpLmwj8
         ap4kGEwWXINaISDaovyXGpfqYsnrhPjQGDB1HM6fIhMaqUSmgJpAgcIUjiDNFpTZlisF
         9eRmtMbgSvEWaiyMjmr5BR+ciVyTOt1C6kkso6T5dl7Tceg5v5Y7Ynuxum3Tjg+Ow6kB
         hJAbKmAUZKwj7Pf9u7y404Vjmi92O8dsLsM+0sEYPhRB19igqHpjdXzmz7pJ3ofhSzdl
         Q9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGnMShr3jyWL9jcFhE2qBOM91zVzJyGFbhCG+OBGJbE=;
        b=H4UwbUvWyQKRoUfDt0iRm6EJkz0woA9s2kFG1Y8SlG4X2kA+BpaD4A1tuBwSBhA5EJ
         jx7riK9icM7ZHWBg9MMUoJnOjg0x6092OZfhdH4fDuHK66OvyVWfoA/I6fPNrKSCvxeO
         pOBzNwQhxcj4W3xsEO4iv0cgFTtNwyvgzPYNR6FqAZcA3pOPNs8bafNyG4vfOmesNIGg
         hwtpDiCJvY98cMwDtzpkQ4cOvHQB+jYDLX84pkvweu/jTf070VVWTB8G2U8ci6kuwC2M
         aIV6H5ZDWyJeDLXMc7Lpr1eDk4NSkxgg92QQtpZDC3K0fHJz1n3h0EB+bZYVo1zmBD5X
         mmcQ==
X-Gm-Message-State: AOAM5312+1yjr91WqIs6cw8pR0ChA5e/oBMhtwFZHjZG1UIJA2JQdpI6
        OEyufnNeKkhk37dpXZbw1AIOYk8euxuWY8Ty5Kyaeg==
X-Google-Smtp-Source: ABdhPJxD646cePEta6zJGL+ITVlaE2PMG+I/mFsdjfnFJ2odeSNaAbHfpxTTcKRe2soQ/HKOXLpM/nt9FiV+k4Bfhec=
X-Received: by 2002:a17:906:394c:: with SMTP id g12mr3407914eje.255.1598255185048;
 Mon, 24 Aug 2020 00:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org> <db8adbab-bf1a-0552-0dce-af4acee9719e@linaro.org>
In-Reply-To: <db8adbab-bf1a-0552-0dce-af4acee9719e@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 24 Aug 2020 09:51:22 +0200
Message-ID: <CAMZdPi8KRJ3Jb129xAqR8fnfc7tKaVvLZH00DF_z+Vx+wOD3Ow@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bryan,

On Mon, 24 Aug 2020 at 03:45, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 17/08/2020 17:01, Loic Poulain wrote:
> > For software-driven scan, rely on mac80211 software scan instead
> > of internal driver implementation. The internal implementation
> > cause connection trouble since it keep the antenna busy during
> > the entire scan duration, moreover it's only a passive scanning
> > (no probe request). Therefore, let mac80211 manages sw scan.
> >
> > Note: we fallback to software scan if firmware does not report
> > scan offload support or if we need to scan the 5Ghz band (currently
> > not supported by the offload scan...).
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>
> OK.
>
> TL;DR included diff fixes the performance issue.
>
> I've poked about with the old scan, and this new scan and I've managed
> to find to find where the new scan is killing performance.
>
> Please see below.
>
> @@ -792,6 +792,7 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
>   {
>          struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
>          struct wcn36xx_hal_finish_scan_req_msg msg_body;
> +       u8 oper_channel;
>          int ret;
>
>          mutex_lock(&wcn->hal_mutex);
> @@ -802,7 +803,9 @@ int wcn36xx_smd_finish_scan(struct wcn36xx *wcn,
>                  /* Notify BSSID with null data packet */
>                  msg_body.notify = 1;
>                  msg_body.frame_type = 2;
> -               msg_body.oper_channel = channel;
> +               oper_channel = WCN36XX_HW_CHANNEL(wcn);
> +               if (oper_channel != channel)
> +                       msg_body.oper_channel = channel;

Is this condition ever satisfied? I mean, finish_scan is normally always
called with operating-channel as channel parameter.

>                  msg_body.scan_entry.bss_index[0] = vif_priv->bss_index;
>                  msg_body.scan_entry.active_bss_count = 1;
>          }
>
> Happily, I'm finding with this modification on top of your patch
>
> 1. Running a continuous Android scan
>     As in when you have the network scan window open
>     A simultaneous "iperf -c xxx.xxx.xxx.xxx -i 1 -t 1800"
> 2. Performance is as expected
>     I see throughput oscillate between 30 mbit and 100 mbit
>     - Android runs a scan every 15 seconds

With scanning app in the foreground, right?
While connected to an AP, Android 'should' only background scan if
RSSI becomes too low (for roaming).

>     - Software scan takes 11 seconds to complete
>     - So this is expected behavior
> 3. During quiescent periods we have the expected throughput
> 4. We gain from the additional stability the rest of your patch provides
>
> Specifically on #4 what I find with the old scan is that with some APs
> we can get a disassocation after a scan completes.
>
> My test-case AP for that behavior is a Ubiquiti Nano HD on a 5ghz frequency.
>
> Its funny that rewriting the operating channel in the finish_scan path
> should make a difference.
>
> All I can guess at here is that the PHY mode doesn't get updated correctly
>
> Loic, can you make sure you are happy with the change and V2 this patch?
>
> You can retain my SoB.
>
> ---
> bod
