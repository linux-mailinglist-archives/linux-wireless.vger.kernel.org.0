Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3DE6575
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Oct 2019 21:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfJ0U4n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Oct 2019 16:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfJ0U4m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Oct 2019 16:56:42 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE90F2070B;
        Sun, 27 Oct 2019 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572209802;
        bh=brHu22CgUlAV8oo+Awhnk9cnfWOJvOQW97kCTXit2WU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Os7jSXBdq+tNAQvsHGTWhUqQJ5w71uHdVTomU37AgfER53r15NwzIcZD8sWwkyYzi
         3BifG1DGDCiJbgDqnauTpDb2vDODUujJqvUV3cSKuO2oP4WDeJNMgnS+MwcuIeKoGq
         uAInRHy9HZNPr4AIu1zErZGYp4ZEIehkVHXFabyI=
Received: by mail-qt1-f175.google.com with SMTP id g50so11713323qtb.4;
        Sun, 27 Oct 2019 13:56:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUd7VulgOpSdF4UCZImejxwaIa6sHZ/djIabkGstvqAKf+tZJsZ
        zVitstGbdiT/wjQjYxsSxEQHs73FJxLKVGR04w==
X-Google-Smtp-Source: APXvYqxDhNXRbEZ8TgMXoK+AXNhKy2RNanFb613NmTAxbWJ6MlbcBdMf+P31Qz6AiSmpPB5/rmZ/7D4Kvt6H81tju40=
X-Received: by 2002:a0c:d2b4:: with SMTP id q49mr13714601qvh.135.1572209801059;
 Sun, 27 Oct 2019 13:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
 <1571565847-10338-2-git-send-email-kvalo@codeaurora.org> <20191025213028.GA5117@bogus>
 <874kzu9v2g.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <874kzu9v2g.fsf@kamboji.qca.qualcomm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 27 Oct 2019 15:56:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLD5UfSfYtvp62aGJSDC-Cm4ifk_YmNPRNAXQMnJ2CzVA@mail.gmail.com>
Message-ID: <CAL_JsqLD5UfSfYtvp62aGJSDC-Cm4ifk_YmNPRNAXQMnJ2CzVA@mail.gmail.com>
Subject: Re: [PATCH v2 01/49] dt: bindings: net: add qcom,ath11k.yaml
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     devicetree@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Oct 27, 2019 at 8:28 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Rob Herring <robh@kernel.org> writes:
>
> > On Sun, Oct 20, 2019 at 01:03:19PM +0300, Kalle Valo wrote:
> >> ath11k is a driver for Qualcomm IEEE 802.11ax devices. Add a
> >> bindings document for the driver, first documenting IPQ8074 which is the
> >> only device ath11k currently supports.
> >>
> >> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> >> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> >> ---
> >>  .../bindings/net/wireless/qcom,ath11k.yaml         | 277 +++++++++++++++++++++
> >>  1 file changed, 277 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> >> b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> >> new file mode 100644
> >> index 000000000000..5d25542f85f8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> >> @@ -0,0 +1,277 @@
> >> +# SPDX-License-Identifier: BSD-3-Clause-Clear
> >
> > (GPL-2.0-only OR BSD-2-Clause) please.
>
> I chose BSD-3-Clause-Clear because ath11k uses that license and I would
> prefer to use the same license throughout the driver.

The schema is not the driver.

> Also it's
> categorised as a preferred license:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/preferred

So are the 2 I listed. (GPL-2.0 is the deprecated version of GPL-2.0-only).

> Any specific reason why you want to change the license?

So that we have some sort of consistency between schemas. It's been a
free-for-all for licensing dts files, headers and bindings til now,
and I'm trying to address some of that as we add schema.

Rob
