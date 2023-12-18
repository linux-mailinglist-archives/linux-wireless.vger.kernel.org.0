Return-Path: <linux-wireless+bounces-946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C200817A03
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 19:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FC91C22959
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2361EA7D;
	Mon, 18 Dec 2023 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKxqtYya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307B1E530
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 18:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EBBC433C8;
	Mon, 18 Dec 2023 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702925303;
	bh=W5pDp/Xk6bcXYEyHt0i/qxoIwl3g0rlTDIvftKERqZA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=KKxqtYyauP0FnHa8EY0g7ZZx08lXZ3xggrE+0AqnXt7ynlLv6LpF5G8vJVaQbLrvl
	 k7r+ynRpsErOqNTxdrMK3P0AoEol3rLI6+HV3O/XjenDnQ51aTz2rIaf3FfSmXWkKV
	 7CcYvkWsh+Cir9xZILvB/8tUYIGSwWZrs4D2QKIz3Mf9jXL2tMYpA+gzcKNzocTvlA
	 FwLcFD/GTJqKmrorhAxDToa8gy7xDlETCr/hd4sUrLKZ7ltjhT5KaATjSnECdXAwtr
	 YTkiNZ+p+YtekKI26PempXDVIzICDt4S7zfw/lAH1F1hOB3fcQtYQq2JBix8Wbs7w3
	 8J6i78R3N2Vnw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: ath12k: add string type to search board data in
 board-2.bin for WCN7850
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231216060140.30611-2-quic_bqiang@quicinc.com>
References: <20231216060140.30611-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170292530072.424292.15296808219565634981.kvalo@kernel.org>
Date: Mon, 18 Dec 2023 18:48:22 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently ath12k only supports string type with bus, chip id and board id
> such as "bus=ahb,qmi-chip-id=1,qmi-board-id=4" for AHB bus chip and
> "bus=pci,qmi-chip-id=0,qmi-board-id=255" for PCI bus chip in board-2.bin.
> For WCN7850, it is not enough to distinguish all different chips.
> 
> Add a new string type which includes bus, chip id, board id, vendor,
> device, subsystem-vendor and subsystem-device for WCN7850.
> 
> ath12k will first load board-2.bin and searches in it for the board data
> with the above parameters. If matched with one board data, ath12k downloads
> it to firmware. And if not, downloads board.bin instead.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

5 patches applied to ath-next branch of ath.git, thanks.

f4c2a9d62213 wifi: ath12k: add string type to search board data in board-2.bin for WCN7850
7173972a2eb1 wifi: ath12k: add fallback board name without variant while searching board-2.bin
97474e5f5424 wifi: ath12k: remove unused ATH12K_BD_IE_BOARD_EXT
511207452221 wifi: ath12k: add support to search regdb data in board-2.bin for WCN7850
52f8c45fa36d wifi: ath12k: support default regdb while searching board-2.bin for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231216060140.30611-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


