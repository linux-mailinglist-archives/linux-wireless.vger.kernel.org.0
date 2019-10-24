Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63DEE2E21
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 12:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393195AbfJXKH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 06:07:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36180 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390572AbfJXKH0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 06:07:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BA36F60D9D; Thu, 24 Oct 2019 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571911646;
        bh=3HRV3/j6kPCBPAw9zEpnXfXY5IayCssj8E6lqB3QPFE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mGKqCa5bj8ODjoaONbCwAjUv1DRfc8xeg+wblkUMRlX2nt1YL+G9dat9sTNVbgTUu
         dhenn2w5S7x2GUakuWwfsQbp0U2+Fh8sT4tFz3EIOn3v5xE7dNH3T5+vZDXddpsFwA
         0UP2xQV1BDeU3n5M4DV7Yk0VpCebcCae9F4OEDCI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 771B7602DF;
        Thu, 24 Oct 2019 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571911644;
        bh=3HRV3/j6kPCBPAw9zEpnXfXY5IayCssj8E6lqB3QPFE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WORImIE3uRBfKzC6vIKLAudqrVJp2FfjQPCLETjiX3YnzZEMxI7m7/nzEC1p1HAHg
         Lgz1EhOLzdyEG1fLs6JN2/QgERbmqKOEDpBcXvFbtgqgnakCnj03+lnvf/PnWFC9iA
         z5aga/sdZBdUi0PMsOKe5T6DxLR2Ea+nyqO9NxVQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 771B7602DF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtw88: fix GENMASK_ULL for u64
References: <20191024091948.10569-1-yhchuang@realtek.com>
Date:   Thu, 24 Oct 2019 13:07:20 +0300
In-Reply-To: <20191024091948.10569-1-yhchuang@realtek.com> (yhchuang's message
        of "Thu, 24 Oct 2019 17:19:48 +0800")
Message-ID: <87ftjie9t3.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> This fixes compile warning:
>
>     In file included from include/linux/bitops.h:5:0,
>                      from include/linux/kernel.h:12,
>                      from include/asm-generic/bug.h:19,
>                      from arch/mips/include/asm/bug.h:42,
>                      from include/linux/bug.h:5,
>                      from include/net/mac80211.h:16,
>                      from drivers/net/wireless/realtek/rtw88/main.h:8,
>                      from drivers/net/wireless/realtek/rtw88/main.c:5:
>     drivers/net/wireless/realtek/rtw88/main.c: In function 'rtw_update_rate_mask':
>       include/linux/bits.h:23:11: warning: right shift count is negative
>       [-Wshift-count-negative]
>        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
>                ^
>     drivers/net/wireless/realtek/rtw88/main.c:622:17: note: in expansion of macro 'GENMASK'
>       u64 cfg_mask = GENMASK(63, 0);
>                      ^~~~~~~
>
> Fixes: f39e9bd49a3d ("rtw88: add set_bitrate_mask support")
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

I'll add:

Reported-by: kbuild test robot <lkp@intel.com>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
