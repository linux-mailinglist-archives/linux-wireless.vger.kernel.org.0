Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3796A47D5EA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 18:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbhLVRj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 12:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhLVRj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 12:39:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE88C061574
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 09:39:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F82C61B87
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 17:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB1CC36AE8;
        Wed, 22 Dec 2021 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640194764;
        bh=WKr+MZnRoi4x2/+qLX13uG3/111TAK8lneB6RcSwLls=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Tx+oMY3/5yxQ/zNApnQ5C46Wfnc5tCKZL8jNiwXmpzmWKtrpPIfyJSpxbSLbNh1du
         4+WNCGwVjRpH6F8be3je56orLbnRN8mAd5NANEiQB7T43FLHIXi5wh1lNqJunhkUyr
         pgHsHcrlfv7BtRnwNcUenTOCAMs2rWG62ADcy78JiOwVi4yjzqXm6smKxpTeSjeP6/
         CCpixSm1IkorBlAqZacG6fYpqyPxHlgjmNL7BbkqJuNgyHCRVfYXdDCrKl/RdF4Nvk
         PlDLUjcOGumt5nwqfT6mNjPbJo8f6bL/cafiJbkLVW2recPqnHC4oN2zDOYpEJrHqc
         eiwoIr0VGOtSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix unexpected return buffer manager error for
 QCA6390
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211222013536.582527-1-quic_bqiang@quicinc.com>
References: <20211222013536.582527-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164019475894.13998.9287903984814236611.kvalo@kernel.org>
Date:   Wed, 22 Dec 2021 17:39:23 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing below error on QCA6390:
> ...
> [70211.671189] ath11k_pci 0000:72:00.0: failed to parse rx error in wbm_rel ring desc -22
> [70212.696154] ath11k_pci 0000:72:00.0: failed to parse rx error in wbm_rel ring desc -22
> [70213.092941] ath11k_pci 0000:72:00.0: failed to parse rx error in wbm_rel ring desc -22
> ...
> 
> The reason is that, with commit 734223d78428 ("ath11k: change return
> buffer manager for QCA6390"), ath11k expects the return buffer manager
> (RBM) field of descriptor configured as HAL_RX_BUF_RBM_SW1_BM when
> parsing error frames from WBM2SW3_RELEASE ring. This is a wrong change
> cause the RBM field is set as HAL_RX_BUF_RBM_SW3_BM.
> 
> The same issue also applies to REO2TCL ring though we have not got any
> error reported.
> 
> Fix it by changing RBM from HAL_RX_BUF_RBM_SW1_BM to HAL_RX_BUF_RBM_SW3_BM
> for these two rings.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Fixes: 734223d78428 ("ath11k: change return buffer manager for QCA6390")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

71c748b5e01e ath11k: Fix unexpected return buffer manager error for QCA6390

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211222013536.582527-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

