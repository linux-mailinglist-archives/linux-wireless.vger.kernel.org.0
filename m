Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5012A478C56
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 14:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhLQNbV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 08:31:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36582 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhLQNbU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 08:31:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3B70B8280B
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 13:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96569C36AE7;
        Fri, 17 Dec 2021 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639747878;
        bh=dO21G1S5TYGg8s1h33uOCeWOQqtYH+TK7gHEco/Z9iM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hnDA21dPsP6sON0JsCp+Tkcnb/XJjTM1/IIK6sjUMOBDaqeszz1qBxzMy/Hp0JGz0
         qPoy+R/ARDOqRkXJnQgnnLV9vScNuAIp3SIKvulu2J2d3LNL6Ur8uJjew0/XWOgHIK
         IjqQQLQHRxTeObh2N1fZpy/ivWp0fSyxfAEbpQLThRifNmBraJ6b+WZOi28eevgovE
         VMA9ljAyoyB4hQEktOvVWBFJ7FEelzR796P7EZh61n9qrNfFDY0q7KQH0L+nqNRqIQ
         TPB8LVhqr38h4cvzMPa8ltp6JrcopN/dqS6+6nHZuvcckfAeGYP8vZJq2im7kH1iY5
         mUGbPVTBHWBTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: add regdb.bin download for regdb offload
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211215061556.14282-1-quic_wgong@quicinc.com>
References: <20211215061556.14282-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163974786863.27118.8951264944041941308.kvalo@kernel.org>
Date:   Fri, 17 Dec 2021 13:31:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> The regdomain is self-managed type for ath11k, the regdomain info is
> reported from firmware, it is not from wireless regdb. Firmware fetch
> the regdomain info from board data file before. Currently most of the
> regdomain info has moved to another file regdb.bin from board data
> file for some chips such as QCA6390 and WCN6855, so the regdomain info
> left in board data file is not enough to support the feature which need
> more regdomain info.
> 
> After download regdb.bin, firmware will fetch the regdomain info from
> regdb.bin instead of board data file and report to ath11k. If it does
> not have the file regdb.bin, it also can initialize wlan success and
> firmware then fetch regdomain info from board data file.
> 
> Add download the regdb.bin before download board data for some specific
> chip which support supports_regdb in hardware parameters.
> 
> download regdb.bin log:
> [430082.334162] ath11k_pci 0000:05:00.0: chip_id 0x2 chip_family 0xb board_id 0x106 soc_id 0x400c0200
> [430082.334169] ath11k_pci 0000:05:00.0: fw_version 0x110c8b4c fw_build_timestamp 2021-10-25 07:41 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HSP.1.1-02892-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> [430082.334414] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/regdb.bin size 24310
> 
> output of "iw reg get"
> global
> country US: DFS-FCC
>         (2402 - 2472 @ 40), (N/A, 30), (N/A)
>         (5170 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
>         (5250 - 5330 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (N/A, 23), (0 ms), DFS
>         (5735 - 5835 @ 80), (N/A, 30), (N/A)
>         (57240 - 63720 @ 2160), (N/A, 40), (N/A)
> 
> phy#0 (self-managed)
> country US: DFS-FCC
>         (2402 - 2472 @ 40), (6, 30), (N/A)
>         (5170 - 5250 @ 80), (N/A, 24), (N/A), AUTO-BW
>         (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
>         (5735 - 5895 @ 160), (N/A, 30), (N/A), AUTO-BW
>         (5945 - 7125 @ 160), (N/A, 24), (N/A), NO-OUTDOOR, AUTO-BW
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

With WCN6855 I see new warnings:

[12136.485140] ath11k_pci 0000:06:00.0: qmi failed to load CAL data file:cal-pci-0000:06:00.0.bin
[12169.157236] ath11k_pci 0000:06:00.0: qmi failed to load CAL data file:cal-pci-0000:06:00.0.bin

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211215061556.14282-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

