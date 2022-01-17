Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D424908C3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbiAQMhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 07:37:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52738 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiAQMhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 07:37:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E970611A6
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 12:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C3DC36AE7;
        Mon, 17 Jan 2022 12:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642423027;
        bh=144ap2SO9WHpXKY6PYR+n9vddvxSLLoMYrvNyrAi/hQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZAmkCAR0bLZ35wtQFdxosUpADNDnbuMzdCMrjvvDch+4zHeguNtZLSb2jBtyMG7f7
         9e+DeXM1ugTAKyrIHSfXv7gYVEwSXoZVGBXxNe2B1h4VUFKkQlK3d3BzfdEabgm2Av
         jkSHkgQHa1Qk6mP5h0rZCxbh70WHnLUiPZN+gjGhRnYGOPR4nzNKwCJszyuvzNEaB5
         w3NnHaAOsTGVo6054eVgECy9CWLc9HtTtXzpdTD5kjR9ZZ7p56sRZNkN5zJZ++WBkJ
         tlvcqMGsbDU+9OI+c8IMWMiSAMf1kOeLGikjtmAFsy04z9uzEc8ZSKq/d5tlz/umbm
         I2xRDdFvI+Slg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: enable RX PPDU stats in monitor co-exist mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220111032224.14093-1-quic_alokad@quicinc.com>
References: <20220111032224.14093-1-quic_alokad@quicinc.com>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Miles Hu <milehu@codeaurora.org>,
        "Aloka Dixit" <quic_alokad@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164242302513.27899.14013951630174562565.kvalo@kernel.org>
Date:   Mon, 17 Jan 2022 12:37:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> wrote:

> RX PPDU statistics collection is missing when monitor mode co-exists
> with other modes. This commit combines the processing of the destination
> ring with the status ring to fix the issue.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01179-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

67a9d399fcb0 ath11k: enable RX PPDU stats in monitor co-exist mode
3cd04a438754 ath11k: move function ath11k_dp_rx_process_mon_status

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220111032224.14093-1-quic_alokad@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

