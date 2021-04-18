Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF8363435
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 09:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhDRHKv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhDRHI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 03:08:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F3DC06174A
        for <linux-wireless@vger.kernel.org>; Sun, 18 Apr 2021 00:08:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s16so26508409iog.9
        for <linux-wireless@vger.kernel.org>; Sun, 18 Apr 2021 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3LCz9jBnyHrBKI9Py1mAVr5v4jzXAWw6BVLZ1WRVLVo=;
        b=lzdDyZCh7s1L5lWtIGCn4hCR5dDUHNkrTeYWmDSUU5js4tF1nNBIUwmaUhE6iysXt8
         SsVP8HYA6zTDsXmr3Iosf4RELMFXGVZOWnYUTRDTfQfmEb1FxiKP8cT+X0ZRHE+Rmywg
         z7m4vnoQ7Q4hqwnqwABsy+36ePGD/RgUkEHsxN8AblkV+1gMrBrSbupmSaH+WJPxvH0e
         fRh16S0x9uuEvnd5n8ixuEBdtZcdE1cN+S4rniqq/ENWBYBExj42icq+09iv5uujo56Y
         vjntBwZLA3zJc7+SZjGUcP9mNRWSRW1Lw0XZNBwUMAw0nPex82n0TWl0A4RtgGegcCAu
         5omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3LCz9jBnyHrBKI9Py1mAVr5v4jzXAWw6BVLZ1WRVLVo=;
        b=AmvWMv0m95rCRKf+Tca35sDqcjMGKSfsQ3IwEtmT2xMlWJLS9KG2ORZPf9qigGgnu4
         szIaJBpLPvxm8eKIz8av1E6GKMuRvvieT3LvMaQtps2OAxLawFYn/uY/0ivJg2ufSP/T
         769lov7+iDXjLdSwylIwEK/7IOaT5PeoJSrVBAwz6RfZ8aRptGJbkMNBy+1B9CH+WhHl
         q4x/CzEI6TDzuluyIL9xCu1kX5/VEHsOiPU1QiXSuInN8hTM9CH75xkjs/WshygrAlXr
         iDNRYZ4t5q+A+keVoa0X/LweXdbKgJYzqIGCiM1xxWvut6tBTIRBaC3aRQW/x6zRGisw
         5ejQ==
X-Gm-Message-State: AOAM532Fn/Mj+3t/ZHnr29zf13tQ1EiWBvS5OTWzyPhvnZ6Y5MwJdIJR
        m6vtPUjYWsNTwUXn9NWE6kUFe9bqigpEAPcIk9jo7EEWzsAP0g==
X-Google-Smtp-Source: ABdhPJz7JVE9KL/GzG/weC8ALFBmwj8t/brV+Mcv3QPSDFP7YfXlAZf9sgwcQbbpE0I7iTkwemsOchoY7FohHWE0HYE=
X-Received: by 2002:a6b:8bd3:: with SMTP id n202mr9635558iod.57.1618729709307;
 Sun, 18 Apr 2021 00:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
 <20210417085010.58522C433C6@smtp.codeaurora.org> <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
 <871rb8ks2o.fsf@codeaurora.org>
In-Reply-To: <871rb8ks2o.fsf@codeaurora.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 18 Apr 2021 09:07:53 +0200
Message-ID: <CA+icZUWVVRz-=09vowj5gLJ9-OaKpBkkejBXzqSpk-wZ-mDm-Q@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_gen2_enqueue_hcmd()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Apr 18, 2021 at 8:47 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Jiri Kosina <jikos@kernel.org> writes:
>
> > On Sat, 17 Apr 2021, Kalle Valo wrote:
> >
> >> This is malformed in patchwork, check the link below. Please resend, and
> >> I strongly recommend to use git send-email to avoid any format issues.
> >
> > Honestly I have no idea what you are talking about, there is no whitespace
> > damage nor anything else that I'd see to be broken. I just took the patch
> > from the mail I sent, applied with git-am, and it worked flawlessly.
>
> Compare these two links:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm/
>
> https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm/
>

v2 should have this diff:

$ git diff v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd.mbx
v2_20210417_jikos_iwlwifi_fix_softi
rq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd-dileks.mbx
diff --git a/v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd.mbx
b/v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl
_pcie_gen2_enqueue_hcmd-dileks.mbx
index 6d250b75305e..63695ce63065 100644
--- a/v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd.mbx
+++ b/v2_20210417_jikos_iwlwifi_fix_softirq_hardirq_disabling_in_iwl_pcie_gen2_enqueue_hcmd-dileks.mbx
@@ -20,9 +20,7 @@ disabling in iwl_pcie_enqueue_hcmd()"), we must
apply the same fix to
iwl_pcie_gen2_enqueue_hcmd(), as it's being called from exactly the same
contexts.

----
-
-Reported-by: Heiner Kallweit <hkallweit1@gmail.com
+Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c

Otherwise Reported-by and S-o-b is dropped when applying to my local
Git because of "---" in v2.
Closing ">" misses in Heiners Reported-by.

Jiri, can you resend a v3?

- Sedat -

> In v1 there's email discussion in the commit log which shouldn't be
> there.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
