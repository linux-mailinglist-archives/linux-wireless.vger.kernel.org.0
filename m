Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB71C3426
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfJAMW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 08:22:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfJAMW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 08:22:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3711D6119F; Tue,  1 Oct 2019 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569932576;
        bh=+GW/X3g8lJp7cIRJtrReo6a69n6wrENFhuWCZ3R57II=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ChlGfm7uveBPlBGyQrDupViQzXRS4UdzcI4PKzNxExAzJ05CmPyhk8a6SXp6ZjTFl
         uwaIvFxf/0/O2W2A/j2STPRG8pY5gV6oVQTHrxnZ8zd6mzBLaPwPxpd76r0B2FVpDW
         r8TO5fqB4yvQqtyDZNXPWOGAxxto3CdLY6EHpCGU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF59F608CE;
        Tue,  1 Oct 2019 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569932575;
        bh=+GW/X3g8lJp7cIRJtrReo6a69n6wrENFhuWCZ3R57II=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZMjJ22rk0vo4oQ3NcyIGt8V3T6BMP2sv5G/nA9h76dOVk3GaV3LnfSyD44BOTmeAU
         lQgGZLckH7yW3oLTMG6WSUiJwFfmwtiQaLT66KwiqWHu4q7cvjsny31e/0UxJgbEEr
         +TUwijpe5soTvi2w0lixFlZirG18dVZyNYY6vEnM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF59F608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2 5/5] ath10k: sdio: remove skb_trim in TX path
References: <20190417191503.18814-1-erik.stromdahl@gmail.com>
        <20190417191503.18814-6-erik.stromdahl@gmail.com>
Date:   Tue, 01 Oct 2019 15:22:52 +0300
In-Reply-To: <20190417191503.18814-6-erik.stromdahl@gmail.com> (Erik
        Stromdahl's message of "Wed, 17 Apr 2019 21:15:03 +0200")
Message-ID: <871rvw64f7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> writes:

> This patch fixes a bug with padding of the skb data buffer.
> Since skb_trim can only be used to reduce the skb len, it is useless when
> we pad (increase the length of) the skb. Instead we allocate a new
> buffer with enough space to contain both the TX data and padding.
>
> Since some skb's have multiple references, we can't use skb_put_padto()
> to extend and pad skb->data (since it causes a panic if there is more
> than one reference).
>
> Also, in order to avoid the following possible deadlock issue (reported by
> lockdep):
>
> [   26.508508]  Possible interrupt unsafe locking scenario:
> [   26.508508]
> [   26.515314]        CPU0                    CPU1
> [   26.519862]        ----                    ----
> [   26.524408]   lock(fs_reclaim);
> [   26.527573]                                local_irq_disable();
> [   26.533508]                                lock(_xmit_ETHER#2);
> [   26.539453]                                lock(fs_reclaim);
> [   26.545135]   <Interrupt>
> [   26.547769]     lock(_xmit_ETHER#2);
> [   26.551370]
> [   26.551370]  *** DEADLOCK ***
>
> ... we use the GFP_NOFS flag with kzalloc()
>
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>

I replied to v1 about using skb_pad(), let's discuss more there:

https://patchwork.kernel.org/patch/10891949/

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
