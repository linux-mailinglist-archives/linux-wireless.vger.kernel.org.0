Return-Path: <linux-wireless+bounces-1975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE282EED6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 13:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC558B212BC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595941B96D;
	Tue, 16 Jan 2024 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ9RZsgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9A1B944
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 12:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52A4C433C7;
	Tue, 16 Jan 2024 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705407603;
	bh=0CmDpSQc0Up0qnAibGSGxlDMH4yJggWHuZlFHOc0WmE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fZ9RZsgR5qpQOMImVAiv0M4+gLu8eXZDGqlKQpU56XO6/E7oB0aMWCog2Qdd9h6GV
	 QF2DP5BIXDkrAmctozG85PoZyQE2hldjJ8K5ybnxQ+H2aRFbEp9tVURM6A2hE4/xAp
	 5gQs6zCuNWuybXI9HIm+8fohhelPSJpTBXVpH/mdXPI3Q97PyKHYrhgDU3GxZDvSCR
	 932v/bHRaF8iulZm3YNV3YMLh2m1QoFlJLW+TG7nZk3IQRxtiH7dTOy9eB/Eb7bPjr
	 KineJVsj1DlCD4bGFlcUGT/bk1P0Jwdhm2fdVqNkRm/nWpU8lBXCSjXIiuweNPrGn3
	 Ie3A2e1grTGig==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath12k: Refactor the DP pdev pre alloc call
 sequence
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231206034920.1037449-2-quic_periyasa@quicinc.com>
References: <20231206034920.1037449-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170540760056.1846129.3705979634876364963.kvalo@kernel.org>
Date: Tue, 16 Jan 2024 12:20:02 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, the data path pdev pre alloc and mac allocate are called
> separately from the core start procedure. The data path pdev pre alloc
> can be called from the mac allocate procedure itself since initialization
> related to pdev happens in the mac allocate procedure. So move the caller
> of DP pdev pre alloc from the core start procedure to the mac allocate
> procedure. This change helps in the future to easily decouple the mac
> allocate procedure from core start handling in order to support MLO in
> multi chip.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

eaf9f17b861b wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc() call
8a742a79f90e wifi: ath12k: refactor ath12k_mac_allocate() and ath12k_mac_destroy()
d2b7a6e5fa1c wifi: ath12k: refactor ath12k_mac_setup_channels_rates()
d786c9f5fe34 wifi: ath12k: refactor ath12k_mac_register() and ath12k_mac_unregister()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231206034920.1037449-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


