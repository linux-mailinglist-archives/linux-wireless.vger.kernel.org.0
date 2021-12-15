Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7063475515
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbhLOJXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbhLOJXV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 04:23:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB44C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 01:23:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so16819975pjr.5
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 01:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jg374ikfEXKm7P46q3/8thcqHOhklArXb41uNlTfmtY=;
        b=nuF2A5Lm8y26+J4pkQM+F1ncA/ImpF4CAlWJ2HmvwN2qmR/QTG7JiF4PR8EOkON1zg
         /PYTPF6xuWzvvD5FppbpfgPeULNg9RQ83G/xqkfzQeyCuMG1EJsuZFsFOxObTEdSlFNI
         au2ptMCPBKPA0zcr32VNgussDa+dqtfHB5rMcEgweNpPpLg1sr+uOsjxEDnK/BZ6im2K
         20HYeYm//qWh2qkGTz9z3hiN3j+QjkvEeN3DpL3kynMDYBR5eKbe+vEKn/an85RpAiDw
         i7XI8W4iwTOFnjnZ54+4D14EWrs4js76kBRwcaK46YB7635sSdcfOfcQsFZLLEjrk5qE
         vcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jg374ikfEXKm7P46q3/8thcqHOhklArXb41uNlTfmtY=;
        b=y3UL3+2getnGxayLpUMxK38i1iEzYQTg08tBdhaHKhRXKY6qFq9G+dYLZ90iXIN3/O
         mik18i/9mMikcIR/m8oebKdp+u+4D71qsJE5J7Go4MRXyukX8hYANODTg0VZh7gfzDct
         C7feNEaR8rMi3X/2OT4E0h6vt+86XMW5Iby8JM7f9bZYN3FjhghxHQ84D0KJURkw4WDL
         j0TSw0ht0sDLvNOLC/e28iIH6CiIdXFAvhvNLwcTU/fiLLlxsHq+WIWnhdnxNhuu6qwX
         weqshdBn5ne2CT8Hlu7oFfX/7lp/N1VKx/Q0GGT5GUJ8XfuYZci8Q8vrIOoJ3SGfLfe0
         NGzQ==
X-Gm-Message-State: AOAM533vDlFtwqEBWVTRLZFbq42VECy9d/Z9I6UEdxpI72UdTS4Hq9fH
        tcusK8IaqX/137x139f+4tkXVEzhasPgpLncbxMm+A==
X-Google-Smtp-Source: ABdhPJwpC/xjAp6NtBgoBg3OdZ2SroUCL8lQESAaARr7BkTU+xTzd78CleerANgYxwYUDsaqAemJ6c/NahlBEihuqAM=
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr10855843pjj.40.1639560200856;
 Wed, 15 Dec 2021 01:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20211214134630.2214840-1-bryan.odonoghue@linaro.org> <20211214134630.2214840-3-bryan.odonoghue@linaro.org>
In-Reply-To: <20211214134630.2214840-3-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 15 Dec 2021 10:34:54 +0100
Message-ID: <CAMZdPi-0jwFr7m-i8esxSARZLmn72af4WWtD87=Hkc91DRioKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] wcn36xx: Fix physical location of beacon filter comment
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        benl@squareup.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 14 Dec 2021 at 14:44, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> The comment in the header with respect to beacon filtering makes a
> reference to "the structure above" and "the structure below" which would be
> informative if the comment appeared in the right place but, it does not.
>
> Fix the comment location so that it a least makes sense w/r/t the physical
> location statements.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
