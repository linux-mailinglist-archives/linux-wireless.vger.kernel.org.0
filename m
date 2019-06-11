Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6F3CD3C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391253AbfFKNni (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 09:43:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbfFKNnh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 09:43:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 64566602F3; Tue, 11 Jun 2019 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560260617;
        bh=W42Jjl6olvpcRbE4JrwKtXyWc4LDnzFTCCCaEZTqzqY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gprOqQkZIsGTfTBb4ISiQuuBFYLQaHYT8j/BMhk61BqKujUH7tItjK6XOmlqcn7A/
         eBu3Pf0BiApu4lReI+nbWpp7egKBT8by3mifKySvSvBOoP6jPRBwGLR+xVtGRpcF3J
         WQoC9kufBd8x/zepgBFazgXbAOU5qUkHuLD6S/Fg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B0F7605A5;
        Tue, 11 Jun 2019 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560260617;
        bh=W42Jjl6olvpcRbE4JrwKtXyWc4LDnzFTCCCaEZTqzqY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gprOqQkZIsGTfTBb4ISiQuuBFYLQaHYT8j/BMhk61BqKujUH7tItjK6XOmlqcn7A/
         eBu3Pf0BiApu4lReI+nbWpp7egKBT8by3mifKySvSvBOoP6jPRBwGLR+xVtGRpcF3J
         WQoC9kufBd8x/zepgBFazgXbAOU5qUkHuLD6S/Fg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B0F7605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Zefir Kurtisi <zefir.kurtisi@neratec.com>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH v2] ath9k: correctly handle short radar pulses (fixes 3c0efb745a)
References: <20190611131006.29715-1-zefir.kurtisi@neratec.com>
        <20190611133656.16964-1-zefir.kurtisi@neratec.com>
Date:   Tue, 11 Jun 2019 16:43:33 +0300
In-Reply-To: <20190611133656.16964-1-zefir.kurtisi@neratec.com> (Zefir
        Kurtisi's message of "Tue, 11 Jun 2019 15:36:56 +0200")
Message-ID: <87h88wgrui.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zefir Kurtisi <zefir.kurtisi@neratec.com> writes:

> Changes to v1:
> * typos fixed in commit-message
> --
>
> In commit '3c0efb745a17 ("ath9k: discard undersized packets")'
> the lower bound of RX packets was set to 10 (min ACK size) to
> filter those that would otherwise be treated as invalid at
> mac80211.
>
> Alas, short radar pulses are reported as PHY_ERROR frames
> with length set to 3. Therefore their detection stopped
> working after that commit.
>
> NOTE: ath9k drivers built thereafter will not pass DFS
> certification.
>
> This extends the criteria for short packets to explicitly
> handle PHY_ERROR frames.
>
> Signed-off-by: Zefir Kurtisi <zefir.kurtisi@neratec.com>

Forgot to mention that the Fixes line should be before s-o-b, not in the
title:

Fixes: 3c0efb745a17 ("ath9k: discard undersized packets")

I'll fix (no pun intended) that as well.

-- 
Kalle Valo
