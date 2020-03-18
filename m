Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C014D189B59
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCRLxc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 07:53:32 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53144 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbgCRLxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 07:53:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584532409; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IaifDl67O9kkSgFWHxI155xMaMhASjFhXAyHSsnCLwU=;
 b=hqcJ0yp17KYKVcWwcgWEDCdse5YA7j5UPjyt9Qlw34gbDa+EcZLt7Qg+muH0EJRzo9I5eSur
 2uYSj2t3stXgOsf7EnsZIY1vMYQMqrIMLFPRdHrHx5B2EdSzahVed9XWY97CkHflLPKUTe40
 LJRi6MKJoapA/JvPJc8OsNwa0TQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e720ba8.7fc11db98e68-smtp-out-n03;
 Wed, 18 Mar 2020 11:53:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D44CC44798; Wed, 18 Mar 2020 11:53:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91CC6C4478F;
        Wed, 18 Mar 2020 11:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91CC6C4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Adding proper validation before accessing tx_stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1584446369-7021-1-git-send-email-kumarpan@codeaurora.org>
References: <1584446369-7021-1-git-send-email-kumarpan@codeaurora.org>
To:     Pravas Kumar Panda <kumarpan@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pravas Kumar Panda <kumarpan@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200318115311.2D44CC44798@smtp.codeaurora.org>
Date:   Wed, 18 Mar 2020 11:53:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pravas Kumar Panda <kumarpan@codeaurora.org> wrote:

> Before dumping tx_stats proper validation was not been taken care of.
> Due to which we were encountering null pointer dereference(kernel panic).
> This scenario will arise when a station is getting disconnected and
> we are changing the STA state by ath11k_mac_op_sta_state and assigning
> tx_stats as NULL and after this the mac80211 will destroy the
> debugfs entry from where we are trying to read the stats.
> 
> If anyone tries to dump tx_stats for that STA in between setting
> tx_stats to NULL and debugfs file removal without checking the NULL
> value it will run into a NULL pointer exception.
> 
> Proceeding with the analysis of "ARM Kernel Panic".
> The APSS crash happened due to OOPS on CPU 3.
> Crash Signature : Unable to handle kernel NULL pointer dereference at
> virtual address 00000360
> During the crash,
> PC points to "ath11k_debug_htt_stats_init+0x16ac/0x1acc [ath11k]"
> LR points to "ath11k_debug_htt_stats_init+0x1688/0x1acc [ath11k]".
> The Backtrace obtained is as follows:
> [<ffffffbffcfd8590>] ath11k_debug_htt_stats_init+0x16ac/0x1acc [ath11k]
> [<ffffffc000156320>] do_loop_readv_writev+0x60/0xa4
> [<ffffffc000156a5c>] do_readv_writev+0xd8/0x19c
> [<ffffffc000156b54>] vfs_readv+0x34/0x48
> [<ffffffc00017d6f4>] default_file_splice_read+0x1a8/0x2e4
> [<ffffffc00017c56c>] do_splice_to+0x78/0x98
> [<ffffffc00017c63c>] splice_direct_to_actor+0xb0/0x1a4
> [<ffffffc00017c7b4>] do_splice_direct+0x84/0xa8
> [<ffffffc000156f40>] do_sendfile+0x160/0x2a4
> [<ffffffc000157980>] SyS_sendfile64+0xb4/0xc8
> 
> Signed-off-by: Pravas Kumar Panda <kumarpan@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fe0ebb51604f ath11k: Adding proper validation before accessing tx_stats

-- 
https://patchwork.kernel.org/patch/11442613/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
