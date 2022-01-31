Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594064A48E7
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 15:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbiAaOAM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 09:00:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44936 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378963AbiAaOAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 09:00:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80B33B82B2D
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 14:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BE3C340E8;
        Mon, 31 Jan 2022 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643637609;
        bh=e4EkiSX3SihHp5U31Zs8drqYOnv+WBmpGbtaxqsvHB4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bfjuMmtMCuziQYpcvtm/+6lCWRZ/xfFRdAShk7SzbnhY6nUaHZ5E+WDvp9KnNCfwC
         8Ykkwqe451pC5uGhmjNbAsvkG8/rvG/qS1e734S5ZI5n07ez5/W5b2l/EXgJfu3FdK
         4AmER0YTYSrafQDk5tWB6AL4S0n1Q/P/XEwd3sKhD7T++5aH0ioCK5ZJTpGg1LUsYN
         P0CwGjFkN1A9OcQBJtg2jH3kjqHGkxXhUTfbTSYqufbSOSq+Dfw1fn8AWpll1HRo0i
         xVJaa5yBUM6M/BgLlWAaQrtNXOj5DQ8AzGaHOysR1QEdvtqGYCvm0N/z9ERKYie9iW
         CbYwKajyWAQBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix uninitialized symbol 'rx_buf_sz'
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1642605793-13518-1-git-send-email-quic_akolli@quicinc.com>
References: <1642605793-13518-1-git-send-email-quic_akolli@quicinc.com>
To:     Anilkumar Kolli <quic_akolli@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164363760657.22527.17165496476093064241.kvalo@kernel.org>
Date:   Mon, 31 Jan 2022 14:00:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <quic_akolli@quicinc.com> wrote:

> Add missing else statement in ath11k_dp_rx_process_mon_status()
> to fix below smatch warnings,
>     drivers/net/wireless/ath/ath11k/dp_rx.c:3105
>     ath11k_dp_rx_process_mon_status()
>     error: uninitialized symbol 'rx_buf_sz'.
> 
> Fixes: ab18e3bc1c13 ("ath11k: Fix pktlog lite rx events")
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

dca857f07dc1 ath11k: Fix uninitialized symbol 'rx_buf_sz'

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1642605793-13518-1-git-send-email-quic_akolli@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

