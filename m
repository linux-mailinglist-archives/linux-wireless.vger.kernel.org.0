Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A266A8E2
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGPMpD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jul 2019 08:45:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMpD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jul 2019 08:45:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 59324616BA; Tue, 16 Jul 2019 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563281102;
        bh=ZFDxLiE7flxwVInXlYnWMV/JhA3Zu9BKOaI5v2XT+0E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d5R9P81IPOG1dlJsBtXGJZv+lHXMF8gY5gjunsjs8O6IPGFqRUVrWUftoAmB9+DYO
         l0rR8dvX5Lv8kMk9S+uO7v7XEOp2A/AqwVuX5OHF5s7cHNEJVuE/rNz6x0HwW3ypnl
         ScIhswiK+/F5oWrLpDkCZ7YE7qZk+cJLJ34H/4nk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 348AB6074F;
        Tue, 16 Jul 2019 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563281102;
        bh=ZFDxLiE7flxwVInXlYnWMV/JhA3Zu9BKOaI5v2XT+0E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d5R9P81IPOG1dlJsBtXGJZv+lHXMF8gY5gjunsjs8O6IPGFqRUVrWUftoAmB9+DYO
         l0rR8dvX5Lv8kMk9S+uO7v7XEOp2A/AqwVuX5OHF5s7cHNEJVuE/rNz6x0HwW3ypnl
         ScIhswiK+/F5oWrLpDkCZ7YE7qZk+cJLJ34H/4nk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 348AB6074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 20/24] wireless: Remove call to memset after dma_alloc_coherent
References: <20190715031941.7120-1-huangfq.daxian@gmail.com>
        <87zhlf8y4s.fsf@kamboji.qca.qualcomm.com>
        <CABXRUiR0XAB8x9MkF=UH1KTojWDovEy9hGaUEuZnAhbfCAcD3w@mail.gmail.com>
Date:   Tue, 16 Jul 2019 15:44:58 +0300
In-Reply-To: <CABXRUiR0XAB8x9MkF=UH1KTojWDovEy9hGaUEuZnAhbfCAcD3w@mail.gmail.com>
        (Fuqian Huang's message of "Mon, 15 Jul 2019 17:56:50 +0800")
Message-ID: <87o91u5et1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(adding back linux-wireless, please don't drop CC)

> Kalle Valo <kvalo@codeaurora.org> =E6=96=BC 2019=E5=B9=B47=E6=9C=8815=E6=
=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:07=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> Fuqian Huang <huangfq.daxian@gmail.com> writes:
>>
>> > In commit 518a2f1925c3
>> > ("dma-mapping: zero memory returned from dma_alloc_*"),
>> > dma_alloc_coherent has already zeroed the memory.
>> > So memset is not needed.
>> >
>> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
>> > ---
>> > Changes in v3:
>> >   - Use actual commit rather than the merge commit in the commit messa=
ge
>> >
>> >  drivers/net/wireless/ath/ath10k/ce.c                     | 5 -----
>> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c  | 2 --
>> >  drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c | 2 --
>> >  drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c | 2 --
>> >  4 files changed, 11 deletions(-)
>>
>> Via which tree is this supposed to go? Can I take this to
>> wireless-drivers-next?
>
> I think the wireless-drivers-next is fine.

Good, I'll then take these to my queue.

> The four file have similar changes. And they are both under wireless
> subsystem. How should i indicate which tree the patch should go to?
> Should I mark them in [patch v3 wireless] or after the Changes in v3?
> I should avoid this mistake next time.

As there's no dependency between patches to me the easiest is that you
send the wireless patches separately, that way I can take them directly
without asking anything, and not worry about dependencies or if someone
else is going to apply them. For example Colin King does that his
cleanup patches and I like it a lot.

But if I see patch 20/24 (and only that, no cover letter or over
patches) I have no clue what the plan is and need extra effort to
understand what I should do.

--=20
Kalle Valo
