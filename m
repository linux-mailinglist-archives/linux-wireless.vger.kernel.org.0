Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08A2E89BC
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 01:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbhACAvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jan 2021 19:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbhACAvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jan 2021 19:51:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E394C061573
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jan 2021 16:51:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z5so21780916iob.11
        for <linux-wireless@vger.kernel.org>; Sat, 02 Jan 2021 16:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=p9X/lDHa7xyVVLgkMFGC8U8z8SRo8W2AUFeXfjXMZEQ=;
        b=Fmmwtb7JPLwteqXRfqMvLVbS6EXALX0KMDrF1/qzkEr0u/LPwF5MdxgzSE0kRxaaDt
         6AR4bLutrRl/xSZcL5HnTTd7aQfq/RduFs1JW64SmEdqJnMAJVamddi0VDwAf64DI7Sh
         tkojJGiUsGDA4q+H7//3muDwLNsxJbuVrPH8s0DA47Vzi+XKy1BQcaVgkys0LzYK6y8w
         gLnfPbm1M0eIccUGCh+3PmswMuUB5x22ZEwhX8FSlBuiSSN8P/Ru3V1pWElbelB12w8+
         YxKm/ph4n1wiyvwRB1ORZ6KMMNojJnBP/7dhgqVoAAWBFTFDlW1/0ILCIKW4h6OQ+JA4
         vyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=p9X/lDHa7xyVVLgkMFGC8U8z8SRo8W2AUFeXfjXMZEQ=;
        b=dtE1PxWwcLc3rHzUXRmXJ/dR3BK8c1bGuPG/gtNgEXzSm2PaHO5Aq4hl/6Ti9ZR8q2
         cUZw0N2uJJiC99PlrAVWSewR8C7/GETJ/zbxAPuOkuBprFTVmYLPesigLuOyI7eknZ0g
         tBYwPjbVa+WUslQK0dVF164aR4L38xlcDaolg6MEy1xhFWavt4iMHlACL2kxTdYq4CGN
         +hj381YQO1ZmYPIXtMvKpEteZtrAAdp92jCgjKnr2WHi/B53krWC/8sxPTMraWc56CIj
         cBtgZ5LBYpvP7EQRbXEn/ZWoY28/P3BnQ/CB1oL5XuS3GFufZSi3jNnxK/j/9D+PX2hc
         Aitw==
X-Gm-Message-State: AOAM530iq1GqC6CRUf1AJLoVndD6YrbFdqzT5B6oz9AHdyNcM5W2SOW6
        Itdq4oKyJb4d3/Ety5PPF6tWY7J0Dk7KHdh6Yn9mglzDusgvUw==
X-Google-Smtp-Source: ABdhPJw2bhc7063lWUZSKf+U0GSBQggWihQHgJs84gDfw/c+AsX4pWWh02Zytk/bj0Iwq5vOb8+va9pCQyNIFAKNzjE=
X-Received: by 2002:a6b:c9cb:: with SMTP id z194mr54140459iof.110.1609635062339;
 Sat, 02 Jan 2021 16:51:02 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
In-Reply-To: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jan 2021 01:50:51 +0100
Message-ID: <CA+icZUUM8cPUvwVRFqodZxNs=4pVaBJGCWu6mL=9T5tym_OmeA@mail.gmail.com>
Subject: wireless wiki: ath11k missing in drivers page
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

recently someone asked about issues with ath11k devices.

So, I checked the wireless wiki pages.

In the drivers overview [1] ath10k is listed and linked [2] but not ath11k.
Smart enough I found [3].

Can you or someone else add the link to athk11 in [1]?

Thanks.

Regards,
- Sedat -

[1] https://wireless.wiki.kernel.org/en/users/drivers
[2] https://wireless.wiki.kernel.org/en/users/drivers/ath10k
[3] https://wireless.wiki.kernel.org/en/users/drivers/ath11k
