Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF02E0B63
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 20:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfJVSYu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 14:24:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43353 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJVSYt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 14:24:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id a194so13114985qkg.10
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 11:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6a2nV0MVVlfJzNZnPnOTDLrt++nGC/Q++LUC46+Srfs=;
        b=B7m7JsBJsWKVw3wfzfsT/zcjS8PLZ5UgZiG0O24kuzjlryiQbYwwQXFIZ1SpwMZKvf
         emTWQOrp5Unu0z6DLbDlDEZ/csmuv+n3F1FX4hLkYUK8MM7uZp1n6FD1BvyoP/llsqAY
         cG9NdURv9NpIM7Zu0lgEkbzlIf2kv85J7bD21HXRU0R/Azi1Mmi3UIsPlxoB1rm59FAO
         VGkH47FOd6V/iD2ETTmesPMlbLgN0eR2zcE5WjeyL7Wt/FUg1Lusg5auIR/Eky3k8F2V
         mMb3meXPZ8jv/QSh/aw4EK53AK0uJMb6L39bAfsMI7Af5EGmf/JDZrushF/sUENMUKkb
         DDBQ==
X-Gm-Message-State: APjAAAXUzfxTHzmflxwwU5/PIoq4o9CIxM7IA0rMH3O6V3Tta6dDSvdt
        ZXH5jzEqCg3OkfmOWtkIeTJ+h3XkUvgDBu+R9Quv8Q==
X-Google-Smtp-Source: APXvYqx9mOfVbCYC9GsKFZa4fGYTxPWRK90Y0l+O0nTsCrcQwbRGfHV+Trm4l5Z1EWT36RNpBdbMKGjLmtkMaFyycY8=
X-Received: by 2002:a37:67d6:: with SMTP id b205mr4512027qkc.183.1571768688431;
 Tue, 22 Oct 2019 11:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org> <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
In-Reply-To: <d6cfd945-7bab-a01d-0157-e0e1802f66e3@eero.com>
From:   Adrian Chadd <adrian@freebsd.org>
Date:   Tue, 22 Oct 2019 11:24:36 -0700
Message-ID: <CAJ-VmonXbUQ=Gv9fBbpN+ez25c3Pz+xxLoL67etMdC0Q+bwyXg@mail.gmail.com>
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     Peter Oh <peter.oh@eero.com>
Cc:     Zhi Chen <zhichen@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 22 Oct 2019 at 10:17, Peter Oh <peter.oh@eero.com> wrote:
>
>
> On 10/22/19 1:57 AM, Zhi Chen wrote:
> > This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
> > PCIe hung issue was observed on multiple platforms. The issue was reproduced
> > when DUT was configured as AP and associated with 50+ STAs.
> >
> > With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
> > issue happened. It broke PCIe spec and caused PCIe stuck.
>
> How can you say value 0 (I believe it's 64 bytes) DMA burst size causes
> the symptom and 1 fixes it?


+1 to this question.

Also, shouldn't the DMA engine be doing what the firmware says? Is the
firmware/copy engine actually somehow bursting / prefetching across a
4K page boundary?

Surely this is something that can be fixed in software/firmware by
correctly configuring up buffer size/offsets?



-adrian
