Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8B478C3C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 14:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhLQNYd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 08:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhLQNYc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 08:24:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B8C061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 05:24:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3AE621DD
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 13:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755CAC36AE1;
        Fri, 17 Dec 2021 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639747471;
        bh=t6oLbhiwbKhPIPXhsGy+crhSAADTLaUa+GPxfLDqqsc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ROzwkRPBlgFpJy50jl3UEF5B+59jgIl/x3IH12DlPMp+xYF1zyD4MIScbE0gY+LlO
         mHS8tKs3yo5c468hz8trs3sgzxQnxRr0tJIxU0WBF3PcDXsUm43mvQ4AWLaFC4JVto
         lgkR2ysU2SrMSFQ/fnvDyHN7MI9KJD+/bo45zMtQIZtiY0sVHvS+ObA4ZVaE7cdTVa
         LLnFyZPupTpIf02NNi8SOo3vfSRTwDZhEtoUTPYr3LnJkT2ONPKkZ9M84IYtvIDtsV
         bM7d6cBxz+rj4MKixa+ESEUdGQ/tWbUgo+snUjU63heVB2b7CDOfn+lj1sq0SVFkGx
         dr1lct15CnbsA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] ath11k: add fallback board name without variant
 while
 searching board-2.bin
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211208072327.19719-2-quic_wgong@quicinc.com>
References: <20211208072327.19719-2-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163974746775.27118.6803677219230814732.kvalo@kernel.org>
Date:   Fri, 17 Dec 2021 13:24:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Sometimes it has a variant value which read from DT or SMBIOS by
> ath11k, and meanwhile it does not have the matched board name in
> board-2.bin, then it will failed at boot up phase.
> 
> Add fallback board name which removed variant value and search again
> in board-2.bin when failed with variant and try to load the board
> data again to increase boot up success rate.
> 
> dmesg log after this patch:
> [169547.248472] ath11k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262,variant=test'
> [169547.248565] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 180324
> [169547.248568] ath11k_pci 0000:05:00.0: board name
> [169547.248570] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
> [169547.248571] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
> [169547.248572] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
> [169547.248574] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
> [169547.248575] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
> [169547.248576] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
> [169547.248577] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
> [169547.248578] ath11k_pci 0000:05:00.0: board name
> [169547.248579] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
> [169547.248581] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
> [169547.248582] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
> [169547.248583] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
> [169547.248584] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
> [169547.248585] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
> [169547.248587] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 36                    ard-id=266
> [169547.248588] ath11k_pci 0000:05:00.0: board name
> [169547.248589] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
> [169547.248590] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
> [169547.248591] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
> [169547.248592] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
> [169547.248594] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
> [169547.248595] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 31 38 2c 71 6d 69 2d 62  chip-id=18,qmi-b
> [169547.248596] ath11k_pci 0000:05:00.0: 00000060: 6f 61 72 64 2d 69 64 3d 32 36 36                 oard-id=266
> [169547.248597] ath11k_pci 0000:05:00.0: failed to fetch board data for bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262,variant=test from ath11k/WCN6855/hw2.0/board-2.bin
> [169547.248476] ath11k_pci 0000:05:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
> [169547.248634] ath11k_pci 0000:05:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 180324
> [169547.248636] ath11k_pci 0000:05:00.0: board name
> [169547.248637] ath11k_pci 0000:05:00.0: 00000000: 62 75 73 3d 70 63 69 2c 76 65 6e 64 6f 72 3d 31  bus=pci,vendor=1
> [169547.248638] ath11k_pci 0000:05:00.0: 00000010: 37 63 62 2c 64 65 76 69 63 65 3d 31 31 30 33 2c  7cb,device=1103,
> [169547.248639] ath11k_pci 0000:05:00.0: 00000020: 73 75 62 73 79 73 74 65 6d 2d 76 65 6e 64 6f 72  subsystem-vendor
> [169547.248641] ath11k_pci 0000:05:00.0: 00000030: 3d 31 37 63 62 2c 73 75 62 73 79 73 74 65 6d 2d  =17cb,subsystem-
> [169547.248642] ath11k_pci 0000:05:00.0: 00000040: 64 65 76 69 63 65 3d 33 33 37 34 2c 71 6d 69 2d  device=3374,qmi-
> [169547.248643] ath11k_pci 0000:05:00.0: 00000050: 63 68 69 70 2d 69 64 3d 32 2c 71 6d 69 2d 62 6f  chip-id=2,qmi-bo
> [169547.248645] ath11k_pci 0000:05:00.0: 00000060: 61 72 64 2d 69 64 3d 32 36 32                    ard-id=262
> [169547.248646] ath11k_pci 0000:05:00.0: boot found match for name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
> [169547.248647] ath11k_pci 0000:05:00.0: boot found board data for 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
> [169547.248649] ath11k_pci 0000:05:00.0: using board api 2
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

On Dell XPS 13 9310 I see a new warning when testing the pending branch:

[    2.471334] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
[    2.471339] ath11k_pci 0000:72:00.0: fw_version 0x101c06cc fw_build_timestamp 2020-06-24 19:50 fw_build_id 
[    2.471761] ath11k_pci 0000:72:00.0: failed to fetch board data for bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=DE_1901 from ath11k/QCA6390/hw2.0/board-2.bin
[    2.513436] ath11k_pci 0000:72:00.0: leaving PCI ASPM disabled to avoid MHI M2 problems

I suspect (but not sure!) it comes from this patchset.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211208072327.19719-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

