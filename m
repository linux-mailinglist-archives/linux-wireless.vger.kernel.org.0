Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81C84A5AEB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiBALKu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 06:10:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37916 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiBALKt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 06:10:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517EA60F66
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 11:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E37C340EB;
        Tue,  1 Feb 2022 11:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643713846;
        bh=kd1PiIvWlrvMaOSL6ESELAiFm2KXwdfE6zpQTszXga4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qnxY7TEsQJNngjIPEbrhY/6oSgPg2DJA3MOPzXilVO9VbspuScM07UL0TtkDvujQQ
         XztsoIl7uLXIsMY7L6dc+wsXta0iiCDRxs6qlfKtQKeJmV0LPDJdwF0/LCVw1jUOiH
         QBll2Z4/fNX2+j/Skzynh+RVuZ7/IccfQiVW/0sOqfHDXMj0FnhFreO9kBYCzLoIv6
         tMRJUKlZ0VCfxXZayj2iNEEb1CFbHunFtO3rzTbEeyDXlClDOQGIlb/7JdtvSZT/L3
         ZkrCCcZz03A4TK1n1+I9luKb7ZtdrZXb/cUR240E9Z44qU1iWOfPv2rMQ8J4BPe3uX
         aYlbGbcr3vTVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] ath11k: Add basic WoW functionalities
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1642673607-8896-2-git-send-email-quic_cjhuang@quicinc.com>
References: <1642673607-8896-2-git-send-email-quic_cjhuang@quicinc.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164371384161.32371.4031122545237409876.kvalo@kernel.org>
Date:   Tue,  1 Feb 2022 11:10:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> Implement basic WoW functionalities such as magic-packet, disconnect
> and pattern. The logic is very similar to ath10k.
> 
> When WoW is configured, ath11k_core_suspend and ath11k_core_resume
> are skipped as WoW configuration and hif suspend/resume are done in
> ath11k_wow_op_suspend() and ath11k_wow_op_resume().
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

This didn't apply and as you didn't use --base switch it was impossible
for me to try to solve it. Please rebase.

6 patches set to Changes Requested.

12718491 [v2,1/6] ath11k: Add basic WoW functionalities
12718496 [v2,2/6] ath11k: Add WoW net-detect functionality
12718492 [v2,3/6] ath11k: implement hardware data filter
12718493 [v2,4/6] ath11k: purge rx pktlog when entering WoW
12718494 [v2,5/6] ath11k: support ARP and NS offload
12718495 [v2,6/6] ath11k: support GTK rekey offload

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1642673607-8896-2-git-send-email-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

