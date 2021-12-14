Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820DB474A78
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 19:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhLNSII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 13:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhLNSIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 13:08:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F4C061751
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 10:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FB56B81C1B
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F409C34600;
        Tue, 14 Dec 2021 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639505283;
        bh=yjwEQJVy7N05FHSC2+vGjnwKAaUK7BuglCDe5H9HaUY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gznXo6ZRrTs2Ro7/7zycik8yzVJPU0x4mbukufFQ3ce0JWXah9rliuMy2hINXrIC9
         DlxK/WXB3DK0Khiijy2PXvvu4XIpl1eUck8huojODvUFVsYuF2fBB9GQQ7jqbbss74
         T29jSUfSOLSVigAC4GrHcZvz4/fiALgV5fkbbz8Gjj/lfsSsBBpWoVTIzeMnbPN36I
         Ml9c1giZZLpEsXETP2fnDoyDCHmQaVBuCF0IUxygA3EE00Iuadgvl2NQUfM3d8IwIh
         mE09Cl0ZjpZydInhx7PkUlkfDDd5IF3dCKlFbZ0Eb5WXR1NMzTMHGa0wo+SFPEODI4
         NgH+f/W5fqx6w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: add regdb.bin download for regdb offload
References: <20211202083616.15406-1-quic_wgong@quicinc.com>
Date:   Tue, 14 Dec 2021 20:08:00 +0200
In-Reply-To: <20211202083616.15406-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Thu, 2 Dec 2021 03:36:16 -0500")
Message-ID: <87tufbgiv3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> The regdomain is self-managed type for ath11k, the regdomain info is
> reported from firmware, it is not from wireless regdb. Firmware fetch
> the regdomain info from board data file before. Currently most of the
> regdomain info has moved to another file regdb.bin from board data
> file for some chips such as QCA6390 and WCN6855, so the regdomain info
> left in board data file is not enough to support the feature which need
> more reg rules such as 6 GHz LPI, SP and VLP.
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

This adds new warnings for QCA6390:

[  182.941223] ath11k_pci 0000:06:00.0: qmi failed to fetch board file: -2
[  190.847925] ath11k_pci 0000:06:00.0: qmi failed to fetch board file: -2
[  198.736044] ath11k_pci 0000:06:00.0: qmi failed to fetch board file: -2
[  209.274650] ath11k_pci 0000:06:00.0: qmi failed to fetch board file: -2
[  233.441116] ath11k_pci 0000:06:00.0: qmi failed to fetch board file: -2

The patches really should be warning free, whenever you test patches
please make sure that they don't add new warnings.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
