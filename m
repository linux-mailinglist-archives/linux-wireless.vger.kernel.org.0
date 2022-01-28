Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952E49F974
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiA1Mdq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiA1Mdp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:33:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B686C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 04:33:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FC0AB8256F
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 12:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB721C340E0;
        Fri, 28 Jan 2022 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643373222;
        bh=oG8gDDpka20GtbCIqwZ9VlLsUTtrPGOprKqV9D+rH8M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aK31KYs+3hC0Pg5hp5VYCRLTqBz/fHNKYxrxisEuNyaDJD4FVnCsITPbJUxZjDA6X
         fK2NwejzLxvdipQm+Seo9jhpDW1O7yqlzo6TTCViG3is0QM1sSrlZxu6FFINpYHA94
         Z2SzsU/st+psG41RhbIdr+GhlBALBOKJCc5RkCPnhsOQ07b3s84+N0Wg58aLGDAKEQ
         p/BqgFY3qU7oQwJgMbFYJt1PqARaYVvvvMuk/IsulARsRxI2T7df6jBMAY2gIaVC3L
         LyPi/+wFeZKbn20oZvbDzaa0Tdrdhw2JTV+yafJYg5qUVU3+jNABYjJ6WKt7bfEd3D
         UiL56HdD89cdQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: set WMI_PEER_40MHZ while peer assoc for 6 GHz
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220119034211.28622-1-quic_wgong@quicinc.com>
References: <20220119034211.28622-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164337322019.4876.12031068891666275250.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 12:33:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When station connect to AP of 6 GHz with 40 MHz bandwidth, the TX is
> always stay 20 MHz, it is because the flag WMI_PEER_40MHZ is not set
> while peer assoc. Add the flag if remote peer is 40 MHz bandwidth.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> 
> Fixes: c3a7d7eb4c98 ("ath11k: add 6 GHz params in peer assoc command")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1cb747192de2 ath11k: set WMI_PEER_40MHZ while peer assoc for 6 GHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220119034211.28622-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

