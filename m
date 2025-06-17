Return-Path: <linux-wireless+bounces-24176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1EEADC33C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 09:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D80D188A49F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7A28DB46;
	Tue, 17 Jun 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R187Zh0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0071DE3DB;
	Tue, 17 Jun 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145350; cv=none; b=CZ95gseNAxDQzESafVGEi3jyIdcluOESsJPx6GFDtG9Fid7HrzaURvjoOJ9+aj/A9lHZ+4K3EiRUeQQqY1dmYEXPz0RaI8Cof9u+CH1Nz9JQ+Qt5Q4/Ur++uOAsp5d/RfXEeaYLdzIa6dSsTj9dSGVlGv2ZNXwrRq2BPFulkIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145350; c=relaxed/simple;
	bh=AuWkEGwym3nXMHNk44MsuVeLpiI/Wz8yHeXqHBrVbJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gR4YR2vlcgjxD75gkUytyaRrQz5vHXcnc6NDAvkYNLVEKiizKRUsSIJs/e17HyQxMUtlsxy18MuNrnDngREOqwC6VpLHS5NR5g5F+82zMPrTEnwj6k0kv094PTeiaIAuK14Qd5e9+aM6ELTu11YyBGYocuTWyVFGKCHXvKTpp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R187Zh0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F31C4CEE3;
	Tue, 17 Jun 2025 07:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750145350;
	bh=AuWkEGwym3nXMHNk44MsuVeLpiI/Wz8yHeXqHBrVbJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R187Zh0JcPnBZlACGJx9Xo7x7tsUxSKgap3xEnydh4J9ymsL/26rE49zbMEjqjjKn
	 +wJ9ts73AQl5pqagF58b2HkySoF2IFCwmhihqdpXFWvT22ItD7AW+mL64l5y7oVlo6
	 yLckux5yU9bubF36m4L8k4uZaCeKAHt1po7znKJO9b8xd4v1ERB34+g7B0Ma/WHjJq
	 CH1vfHjv6iLOSy2LPmXIL9HM6JTbau712oriVZlEDLflYJRp7dHfD6Egvnfi5cWFyD
	 uTDxUirb0nvDiTYE569P7a2v/0C9MtWbFq1gAOUl8WTQuqGKgSM7toUienTCuewnOp
	 KQ4AasbvxUp9Q==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Troy Hanson <quic_thanson@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	sebastian.reichel@collabora.com,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org
Subject: Re: [PATCH v6] bus: mhi: host: don't free bhie tables during suspend/hibernation
Date: Tue, 17 Jun 2025 12:58:51 +0530
Message-ID: <175014516328.16478.17449149106590025798.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516184952.878726-1-usama.anjum@collabora.com>
References: <20250516184952.878726-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 May 2025 23:49:31 +0500, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation because of memory pressure. There is a report where at
> resume time, the memory from the dma doesn't get allocated and MHI
> fails to re-initialize.
> 
> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> [...]

Applied, thanks!

[1/1] bus: mhi: host: don't free bhie tables during suspend/hibernation
      commit: df75d6d7ce922645e674f5d591c7333f11027cdc

Note: I've modified the patch little bit to rename __mhi_unprepare_keep_dev to
mhi_deinit_dev_ctxt() and also reworded the description.

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

