Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF547BB3B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhLUHlN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 02:41:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60516 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbhLUHlM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 02:41:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4576B80F79
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 07:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0580C36AE7;
        Tue, 21 Dec 2021 07:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640072470;
        bh=PVFg5S1sgvZBxDIrRUWz0zd6gmwybBdxsRBeZJTS/8M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HbCiI8qisADsk55WS6qrrdZb5ZUemazeI3OwigEr7OyWlAf0uBwc11o8vbKJuZXcf
         QllifbiG5jKyzvXMEoKnZwReM2xlzrx7r7SaPudtleZV2ptH2GlmTaHuajX+mlgaVK
         laeM5NuE+5DyCC1orLB3cbhXnj+Oue9xoUAIKomysLFoy0TvP3RYJlMocklZZCwuVV
         ZsTafZlY+JtLfNKhL6dTh4pdyzdw99abS/lMCv2zNfsoC0D734BKcfim/om3KAeaxG
         1LPEMhoARy9UTBBOtlQT3YEBhDSbQOjpc5Eej4/rEHD/7ygKAUxb8CUhHVwTzO72e3
         7JdJTOSJgEm2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: add regdb.bin download for regdb offload
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211220062355.17021-1-quic_wgong@quicinc.com>
References: <20211220062355.17021-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164007246520.16882.10676980430691629338.kvalo@kernel.org>
Date:   Tue, 21 Dec 2021 07:41:09 +0000 (UTC)
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

Patch applied to ath-next branch of ath.git, thanks.

01417e57939f ath11k: add regdb.bin download for regdb offload

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211220062355.17021-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

