Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12686B8FEB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfITMpG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 08:45:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfITMpG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 08:45:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E59256141B; Fri, 20 Sep 2019 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568983504;
        bh=vGllR88P9hEZE+i0twWfEPOok8AM3MexNj8GcIjzAwQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FuC3zhZgA2QjEAFiqt/D0exGT9WWA7mGL2uoFj1D5Tdf+9Q7RdZ9l0sA5uGA0pLMK
         TUL1GE6z6xcfP9M0UfE0+RNsZRlGxzEx9ndMl3l0gdKVCXI2uMKIQsnMxXP6Jk3/Xb
         grtMuM7LoNLFw262qq8soPMl/3XHXb7RLq2e10ek=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40B5060A60;
        Fri, 20 Sep 2019 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568983503;
        bh=vGllR88P9hEZE+i0twWfEPOok8AM3MexNj8GcIjzAwQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=P0LswFBtKy4swZy+f/Wrw2EiCFXrPZoNu4pDPpFDSWs3AC9zv4ewGfpSNzXEkbucx
         yF+0YQIqLPTKAceL67pBakc/y8jC0C9dZrWyW1Rwuhk2J5N1JjJ4SSYEYtTc9vvtP9
         nusCYOBBBOG2jWXInjahLKYEpnEJ2KV06isaiU0w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40B5060A60
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@qti.qualcomm.com>
Cc:     Wen Gong <wgong@codeaurora.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>
Subject: Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
        <87tv9hikwe.fsf@kamboji.qca.qualcomm.com>
        <87d0g5h07v.fsf@kamboji.qca.qualcomm.com>
        <1568346854209.29270@qti.qualcomm.com>
Date:   Fri, 20 Sep 2019 15:44:59 +0300
In-Reply-To: <1568346854209.29270@qti.qualcomm.com> (Wen Gong's message of
        "Fri, 13 Sep 2019 03:54:14 +0000")
Message-ID: <87tv97b0hg.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>>>> The bottleneck of throughout on sdio chip is the bus bandwidth, to the
>>>>patches are all to increase the use ratio of sdio bus.
>
>>> I tried to apply patches 2-8, patch 2 had a conflict due to my changes
>>> and patch 8 didn't apply at all. Also I saw few warnings with the
>>> patches I was able to test:
>
> Hi kalle,
>
> i see some warning is from patch "ath10k: add fw coredump for sdio when firmware assert"
> and this patch also have change in sdio.c, so maybe it will have
> conflict with the 8 patches.
>
> patch 8 didn't apply at all, is it means each change of the patch is
> conflict?

Patches 1-7 applied fine, but patch 8 didn't apply. I didn't investigate
what was the conflict.

> I used command to check each patch.
> perl ~/opensource/checkpatch.pl --strict --no-tree
> --max-line-length=90 --show-types --ignore CONST_STRUCT ./*
>
> I found it not check Wunused-but-set-variable.

checkpatch only checks style issues, unused-but-set-variable is a
warning from GCC.

I use ath10k-check script to check all ath10k patches:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/codingstyle#checking_code

And I use latest GCC and sparse with that. crosstool is a simple way to
install a relatively new version of GCC for kernel compilation:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

-- 
Kalle Valo
