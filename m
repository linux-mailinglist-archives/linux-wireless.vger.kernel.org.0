Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26E46BF1A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 16:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhLGPVN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 10:21:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40044 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhLGPVM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 10:21:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D362B817F9
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 15:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A71AC341C3;
        Tue,  7 Dec 2021 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638890259;
        bh=oSFI12w9GF8Up8bhsLXI4q0Q8nILHFuyvJMfcRNsC08=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RKoPwrANetU/rG28CyI0ZuBKI8ePQSOfmOAzeMO20IpCVlEIF9t7Lwh+T1ZSIYhS/
         d7cvgq+WZxyh7mB+a2PLEdeWSiaLChHkC5WlrPFLUmVUR9nW8NaeKQvgEKBujOhy1k
         keYVNX6Mf1qM/J3ya8gQ6rvONRqgq7S/PHhwNfgIc6D7unY6Cu+n5lALWjy1R8bIMv
         2wxG9ATbwswJ2Ds+eV7AQgg4SZ3NpnugB88H6SIBLSZKA+EegE0cNfHRLH/vErhWhW
         jTiQGzlWV0BKBmbyknlh3FyL3W77uq4CydRpboytofVEaB0H8yb6pwsHwRP6aUXcbD
         F8rCQfYE9Jwrw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add support for WCN6855 hw2.1
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211129025613.21594-1-quic_bqiang@quicinc.com>
References: <20211129025613.21594-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163889025741.23771.2385053244216172509.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 15:17:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Ath11k fails to probe WCN6855 hw2.1 chip:
> 
> [ 6.983821] ath11k_pci 0000:06:00.0: enabling device (0000 -> 0002)
> [ 6.983841] ath11k_pci 0000:06:00.0: Unsupported WCN6855 SOC hardware version: 18 17
> 
> This is caused by the wrong bit mask setting of hardware major version:
> for QCA6390/QCN6855, it should be BIT8-11, not BIT8-16, so change the
> definition to GENMASK(11, 8).
> 
> Also, add a separate entry for WCN6855 hw2.1 in ath11k_hw_params.
> 
> Please note that currently WCN6855 hw2.1 shares the same firmwares
> as hw2.0, so users of this chip need to create a symlink as below:
> 
>         ln -s hw2.0 hw2.1
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Fixes: 18ac1665e785 ("ath11k: pci: check TCSR_SOC_HW_VERSION")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d1147a316b53 ath11k: add support for WCN6855 hw2.1

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211129025613.21594-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

