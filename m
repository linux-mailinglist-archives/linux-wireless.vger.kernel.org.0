Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052BA1BC210
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgD1O4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD1O4l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 10:56:41 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1754C03C1AB
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 07:56:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c23so16954664qtp.11
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XD7fya1zNr+D/ulKl92kp8+pmc5owM8/sYXRvPaRimg=;
        b=h3dvVWoYMCgIyCcHI4ao/qeO+JJbUsj5sJs3HL4PRCqnNFEmlvAgVcPhbthv5TDN+L
         wtAMRwMWGPDMhUvzhX66Bj4zHYF3SUhxhtd+SmTZM0DaaKn71tNgaUsw2pW42SI11I/5
         1X4chVPV0wNXPNKPgCp2er+qyWkaEA6Wmid6gU/4XDtVfyisg1qZW119vuCraxmsQMxg
         BhV1sYqzNeX55P0Z9VzslVw6OLztG8abF41sGT+2nZWDAcAAbtT0W/jrphHcril4B6Q/
         gA5lbapZ16/gR3D5i2OVtFpql9KFXoo8leHp2T3KADyqteN71h73pQQPajKycYQInzK6
         FtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XD7fya1zNr+D/ulKl92kp8+pmc5owM8/sYXRvPaRimg=;
        b=mHHPjGDYbfkjcZwp5NL1hZgS9Oa7JINCs2l1+BgrREl1vfCWpqgFVG08wxXUcEsbFs
         wPfGQA1aGBtLAg906SFhXKcNc76871JfOInssJAwjbgw5m2c+xdvDkVjVpitoIeUWj2O
         egDm3GkAYTiq3mmrKzrjrTsIEhrosUzZ7wmf1jGVK8ozdlVEBoQyN13OSJ1HwESbYyhs
         Q2RKExwdg8PEbNZlW9xYax0Z629JIUUtsuzUxf/HCal/fFMPotaEmYqslcykAGTfvBN0
         A1iuEREcSvB3Tfdze9/JqXXWB+NPc7bIoyEwUB4IwWFunKZcwZqHDo14F3eiBd1p3eVQ
         bEBg==
X-Gm-Message-State: AGi0PuYa4wIyJqDZzSgZ2Vggv31GD9pvRu31+BNELh354R6uHwj4tnfV
        hniYV1rxf588dsGMgs1ABkJ2TFvEd9ndyMAPNa1Szq6z
X-Google-Smtp-Source: APiQypISM0qjYJttLqWzUmaYzo8JZZYjRg2yFHAL8eyXbqVKU0dAxho/0puYOKXiVHJmN3YKTMVZwe9DGXmIgH0yE6w=
X-Received: by 2002:ac8:7395:: with SMTP id t21mr28856946qtp.155.1588085799693;
 Tue, 28 Apr 2020 07:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200427145435.13151-1-greearb@candelatech.com>
In-Reply-To: <20200427145435.13151-1-greearb@candelatech.com>
From:   Steve deRosier <derosier@gmail.com>
Date:   Tue, 28 Apr 2020 07:56:03 -0700
Message-ID: <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     Ben Greear <greearb@candelatech.com>, dave.taht@gmail.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
>
> From: Ben Greear <greearb@candelatech.com>
>
> While running tcp upload + download tests with ~200
> concurrent TCP streams, 1-2 processes, and 30 station
> vdevs, I noticed that the __ieee80211_stop_queue was taking
> around 20% of the CPU according to perf-top, which other locking
> taking an additional ~15%.
>
> I believe the issue is that the ath10k driver would unlock the
> txqueue when a single frame could be transmitted, instead of
> waiting for a low water mark.
>
> So, this patch adds a low-water mark that is 1/4 of the total
> tx buffers allowed.
>
> This appears to resolve the performance problem that I saw.
>
> Tested with recent wave-1 ath10k-ct firmware.
>

Hey Ben,

Did you do any testing with this patch around latency?  The nature of
the thing that you fixed makes me wonder if it was intentional with
respect to making WiFi fast - ie getting rid of buffers as much as
possible.  Obviously the CPU impact is likely to be an unintended
consequence. In any case, I don't know anything for sure, it was just
a thought that went through my head when reading this.


> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
>  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index 31c4ddbf45cb..b5634781c0dc 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -1941,6 +1941,7 @@ struct ath10k_htt {
>
>         u8 target_version_major;
>         u8 target_version_minor;
> +       bool needs_unlock;
>         struct completion target_version_received;
>         u8 max_num_amsdu;
>         u8 max_num_ampdu;
> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
> index 9b3c3b080e92..44795d9a7c0c 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
>         lockdep_assert_held(&htt->tx_lock);
>
>         htt->num_pending_tx--;
> -       if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
> +       if ((htt->num_pending_tx <= (htt->max_num_pending_tx / 4)) && htt->needs_unlock) {
> +               htt->needs_unlock = false;
>                 ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
> +       }
>  }
>
>  int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
> @@ -157,8 +159,10 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
>                 return -EBUSY;
>
>         htt->num_pending_tx++;
> -       if (htt->num_pending_tx == htt->max_num_pending_tx)
> +       if (htt->num_pending_tx == htt->max_num_pending_tx) {
> +               htt->needs_unlock = true;
>                 ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
> +       }
>
>         return 0;
>  }
> --
> 2.20.1
>
