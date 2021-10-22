Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72805437371
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 10:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhJVIHR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhJVIHQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 04:07:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436AEC061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 01:04:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id n8so44661lfk.6
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J7oRwF5ruTykuTdKEmW48jFK5feApA/qAili2vpUmyI=;
        b=TSqHD752YHVW2pf926w27u2nU3GApZpMtErj93posI7K+me0unUQkec5W5VLwKl8Pt
         IhJciX5qHJ1t4oU+dOyMilFN/CwLJV5nsa41GmLKQ3yBCDtvnHDxlX9ZBG3sA03RnyZb
         OLHf8QYcXNjj1tAglae3EG+m3fIXwvgJePWS9tdKvO/YbJxdawrY3R9LG5W0L0zkbTh+
         rd7/e06uZ4SAblOwo0OuC5ZkguPy7UT3Wwg+byUkNDU8deI+KRSpSJaRxBJ0D3ygH/EC
         u4h7AJJq7X5Nm3uwq7m+F6dI6ZenkBZnPeZDIN8xcDSg6cqfM/Tt9EKyoE5gLI+m0TMa
         Wfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J7oRwF5ruTykuTdKEmW48jFK5feApA/qAili2vpUmyI=;
        b=jXnv7yPUm9ebgBEAdsgB4PmLiHSOUTcXo11liQoe9fJAz8WhaB0ExHsmqoyXN5bJwJ
         e24fEPLhJaUuT/xOUkFBNAZYPFApHHYCl+TWHUHMbzTZakc673CNEmMU7zS2lwLgd1DQ
         pdIRtY4icHl1HEK8+Yxf97RAH31BWkvzgsFmAjBqhk/ZEvlx3kJ9LK/nonkQRq0c8pOt
         DOYBrZQshIkvjaubeca4bfkeqerEubl0dzBr9jPtYStupm+hst4FpN2Mhzypf37Fg7Rw
         4H7eJ9DnjQgUwjjrup2djbXmUszLV1Au6dxSZv3s0Q4zyY6Bu0aFQ3Xx9iI7+50vhhpk
         KIoA==
X-Gm-Message-State: AOAM532cUENsVV3dPiqFnsUJGXJhwOqfNZ9yR0PKQVexaqbX3VmwJjYP
        Z5f6Bw8ZhUONvLG6otYo/1QFnsG7d4nTO48TE1hOShpwiqXDYQ==
X-Google-Smtp-Source: ABdhPJxjr/cjSRuV2wHb2JgJAUevX0GYc7hIZ0wHDdgsLdju+LgfTC02GZaQRy/fJ+obTWHsiMhkgSm8uJrbi+sZMp4=
X-Received: by 2002:a05:6512:3f0:: with SMTP id n16mr8518158lfq.514.1634889897620;
 Fri, 22 Oct 2021 01:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201223030225.2345-1-cjhuang@codeaurora.org> <87czx7t748.fsf@codeaurora.org>
In-Reply-To: <87czx7t748.fsf@codeaurora.org>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Fri, 22 Oct 2021 10:04:46 +0200
Message-ID: <CAFED-jnaYfXvz8S7d8orJmY+_=T-MRZ+v-c9OJFCg78HqS7=cw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ath11k: support one MSI vector
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Carl Huang <cjhuang@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

czw., 11 lut 2021 o 08:10 Kalle Valo <kvalo@codeaurora.org> napisa=C5=82(a)=
:
>
> Carl Huang <cjhuang@codeaurora.org> writes:
>
> > This patch set is to support one MSI vector for QCA6390.
> >
> > Carl Huang (6):
> >   ath11k: get msi_data again after request_irq is called
> >   ath11k: add ce and ext irq flag to indicate irq_handler
> >   ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for dp irqx
> >   ath11k: refactor mulitple msi vector implementation
> >   ath11k: supports one MSI vector
> >   ath11k: do not restore ASPM in case of single MSI vector
>
> I did some cleanup and before submitting v2 I noticed the patchset (both
> v1 and v2) is crashing during suspend on my Dell XPS 13 9310. We are
> investigating the reason for that and will submit v2 once those are
> fixed.
>
Hello Kalle,

What is status for this series?
I am using ath11k in my banana-pi-r64 (backports-5.15-rc6) board and hit:
[  162.392043] ath11k_pci 0000:01:00.0: failed to get 32 MSI vectors,
only -28 available
[  162.399927] ath11k_pci 0000:01:00.0: failed to enable msi: -28
[  162.405778] ath11k_pci 0000:01:00.0: disabling bus mastering
[  162.411481] ath11k_pci: probe of 0000:01:00.0 failed with error -28

I suspect this series should fix my issue?

BR
Janusz

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches



--=20
Janusz Dziedzic
