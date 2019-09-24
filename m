Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61107BC16F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 07:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392994AbfIXFml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 01:42:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388254AbfIXFmk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 01:42:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D3AEC60A00; Tue, 24 Sep 2019 05:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569303759;
        bh=OZumyeEfbvXBxK+pyI7dwFbulpy6LZOgCrgBslqqRWc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=keS1nlkildg8HvZsyyH/BNlcMBIB7itjkkGU5JWVpClgNdrEoBfR99CKxjJRS0bj2
         juu2rZqzIySW/AP07DUD4Ei6o7bO/GIuud3jX13ShCjrrr34x4+AT+1UZGseGWJr3h
         hlaBKDoVVfnhJCIsnEEILusoMBnwiH+IXZnBTGlg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38FA0602F2;
        Tue, 24 Sep 2019 05:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569303759;
        bh=OZumyeEfbvXBxK+pyI7dwFbulpy6LZOgCrgBslqqRWc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=keS1nlkildg8HvZsyyH/BNlcMBIB7itjkkGU5JWVpClgNdrEoBfR99CKxjJRS0bj2
         juu2rZqzIySW/AP07DUD4Ei6o7bO/GIuud3jX13ShCjrrr34x4+AT+1UZGseGWJr3h
         hlaBKDoVVfnhJCIsnEEILusoMBnwiH+IXZnBTGlg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38FA0602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 0/2] add fw coredump for sdio when firmware assert
References: <1569241055-30816-1-git-send-email-wgong@codeaurora.org>
Date:   Tue, 24 Sep 2019 08:42:35 +0300
In-Reply-To: <1569241055-30816-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Mon, 23 Sep 2019 20:17:33 +0800")
Message-ID: <878sqe5jxw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> add fw coredump for sdio when firmware assert

Please add the changelog here.

> Wen Gong (2):
>   ath10k: add bus type for each layout of coredump
> v2: change code style
> v3: split bus type to another patch, 
> remove ATH10K_BUS_ANY, 
> add bus type for each layout
>   ath10k: add fw coredump for sdio when firmware assert
> v2: change code style
> v3: add commit log for fastdump, 
> add commit log for ath10k_sdio_hif_diag_read,
> change ath10k_err to dbg log

Then you mix the changelog with patch titles like that it makes it hard
to read the summary. So instead add the changelog above, before the
summary, and leave the summary intact.

Also this didn't apply:

Applying: ath10k: add bus type for each layout of coredump
Applying: ath10k: add fw coredump for sdio when firmware assert
fatal: sha1 information is lacking or useless (drivers/net/wireless/ath/ath10k/coredump.c).
error: could not build fake ancestor
Patch failed at 0002 ath10k: add fw coredump for sdio when firmware assert

Then you submit the patch use ath.git master branch as the baseline and
do NOT have any other patches applied. Otherwise the sha1 information is
wrong and it's a lot more work for me to fix the conflicts.

So please rebase and resend.

-- 
Kalle Valo
