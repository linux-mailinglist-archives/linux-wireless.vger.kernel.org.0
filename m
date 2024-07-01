Return-Path: <linux-wireless+bounces-9787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B555791E800
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 20:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA951B20C50
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 18:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8629CEC;
	Mon,  1 Jul 2024 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvtkY6OC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F810F9
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860103; cv=none; b=JJ7eT9K2HxGEsF6boXQfLxS7cios+duDn1RX+NJu3nBUtkdK/QXwVxi4Vy1mFLfy4ATHQDmFU72A5VQWYijzecT5OhO0ga+GOrPN4XjWcCNWNgSRbR8VQbpBy/Obpak3LNRM1Re8/InYfxX88FgBLQmnklCMiyIFTeJWGDdjwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860103; c=relaxed/simple;
	bh=4mCb/a42Ct77gZPxD4V+B+AhOn13Z7edKd+e9S+WfDo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=EguaE7GxqwfAPrIbcBlBP2D54h8sx08uvRVeNMYSRp3wqH50h1+blLk8+aMfJpfkg7NiEgzsb9L0cu1cMDp04dGUHgK/NcXlbO1rpjsRLcACuSz1pWLNuPcxMPaaaG3zK1TRBlrflK+ERs8zAH4gZx4GgpGc3GPOSuYhDmMxHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvtkY6OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264C0C116B1;
	Mon,  1 Jul 2024 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860102;
	bh=4mCb/a42Ct77gZPxD4V+B+AhOn13Z7edKd+e9S+WfDo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NvtkY6OCKhojS8w+Ur7RMQn+W1dRzlKJ5MHP71dsuUUPgX/TjxfaebRBrr1HjJrns
	 bRB+yL5k5uv56aEywCyDocqEZ5qKxyIn0tjr2mmS2dtYJnVg3bj7h1kk1UlgxtHT9Q
	 OSJXZndoCpjh3vz876Tr6TXt5O0mPHOjsz8f/78G/qHpJgwfcvlnmRefhBgLj/Z4vd
	 qzlsAVLjty1Clg4VCG40B2wzCvFYHQv+/IfhOWnNw+82SOben/QEte78SxvKYeAfm8
	 JPpru2jg5UxXbpALxeWRl2Ukd1DDLGyZm/HDWOxoqR19AmZRZSKakWQwKpDQUsn1Sq
	 DvtaJFmrnxJtg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 1/4] wifi: ath12k: Add support to enable
 debugfs_htt_stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240626085854.2500681-2-quic_rgnanase@quicinc.com>
References: <20240626085854.2500681-2-quic_rgnanase@quicinc.com>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Dinesh Karthikeyan <quic_dinek@quicinc.com>,
 Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171986009909.2958036.17208595155066861853.kvalo@kernel.org>
Date: Mon,  1 Jul 2024 18:55:00 +0000 (UTC)

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> Create debugfs_htt_stats file when ath12k debugfs support is enabled.
> Add basic ath12k_debugfs_htt_stats_register and handle htt_stats_type
> file operations.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

3f73c24f28b3 wifi: ath12k: Add support to enable debugfs_htt_stats
ad201b35d3ec wifi: ath12k: Add htt_stats_dump file ops support
adf6df963c03 wifi: ath12k: Add support to parse requested stats_type
a9f2976f0e9e wifi: ath12k: Dump additional Tx PDEV HTT stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240626085854.2500681-2-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


