Return-Path: <linux-wireless+bounces-24655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBFCAED5FB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF021895E33
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1332231829;
	Mon, 30 Jun 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="EPkySk/t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255971A3A80;
	Mon, 30 Jun 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269527; cv=pass; b=oU31Hwvoqzdjow6NuVIA6HPeTy6h03jxM3LKUgungDQoKT4gbuPGTf1Fhxj7yAsX7xD+EZdvE8JNATdmcsjuvoPtrcqrpATc2yYyu84cNdPce9AH6hp+tUpoo4xZQuPufuLbxAbdYtdPnJS4x0FyrLcWrzfDaxirL7NfkmaSgIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269527; c=relaxed/simple;
	bh=mKf/7lKyVj1aVkhRIZvQhVcxmA9zMcEzKu3bFymG0Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcAPdIZVDNVPiZ5vXXBA9ADOifCytQuQRgFHn1BmB8LH4p6SXq3xi+f/uxc5J3zp8UIsYWEhhB4B78mPJnrlYRRg4sgLPFKXo87GF+4IOkMXmImRjsKcm+Ae2tMEGg2mMvXk08tkTECTOgDT+wn+Isep7rkWOQo98NSycrFQvIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=EPkySk/t; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751269459; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YPXl96toAc9A81uHYDgb3wzuBuBul39m6GIxCdtHx883TeQtZDvgj/BK4H2XKyL7snXDS+LKXfY7qOyuu/jCIOyWPTyWrPpe+h8ywrtlvGvZBJLTZzBgrzf701ejS7DhtDHKxSfXHnrNKltEf2bvssIp3xWFoL7jSKr8R7t7NVs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751269459; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0W903R8oLS9A2Sxqq1i/Td3ToFCQaML7iQd92xG1QFo=; 
	b=NSeiL5qXGb1LbteLWZi78rqdeCQI0hr4i7cB4u+2qGPoniIjCkvpOM6mw1Rq2bALtzXX4afBFvqSv4UItrbLDEDI8O3wRHdkbfnkp1+q+4Lby8KE7UgmNkfM5q1Ker0USBWYRnCkH/wM6erCIWBxRywUDpU+IK5yMOnIeT85bnk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751269459;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=0W903R8oLS9A2Sxqq1i/Td3ToFCQaML7iQd92xG1QFo=;
	b=EPkySk/t1sw5EqicXIkGaYPIbJB6ogRJvd3A5FHYzs/kpFfCnAZBcndTDx1tUpXN
	2wrbcQDYR4mgCU9+L+VATv91rCSS/94LVP+ZIR15ea4ylCeZjG2TofjaP91yigaseTU
	WeQYxaUSdGwwYVhldrR7xEO1nb5xmUYDHds7FL5A=
Received: by mx.zohomail.com with SMTPS id 1751269457487321.0194901089892;
	Mon, 30 Jun 2025 00:44:17 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Matthew Leung <quic_mattleun@quicinc.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Alex Elder <elder@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	Sujeev Dias <sdias@codeaurora.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	John Crispin <john@phrozen.org>,
	Muna Sinada <quic_msinada@quicinc.com>,
	Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
	Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Cc: kernel@collabora.com
Subject: [PATCH 0/3] bus: mhi: keep dma buffers through suspend/hibernation cycles
Date: Mon, 30 Jun 2025 12:43:27 +0500
Message-Id: <20250630074330.253867-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When there is memory pressure during resume and no DMA memory is
available, the ath11k driver fails to resume. The driver currently
frees its DMA memory during suspend or hibernate, and attempts to
re-allocate it during resume. However, if the DMA memory has been
consumed by other software in the meantime, these allocations can
fail, leading to critical failures in the WiFi driver. It has been
reported [1].

Although I have recently fixed several instances [2] [3] to ensure
DMA memory is not freed once allocated, we continue to receive
reports of new failures.

In this series, 3 more such cases are being fixed. There are still
some cases which I'm trying to fix. They can be discussed separately.

[1] https://lore.kernel.org/all/ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com
[2] https://lore.kernel.org/all/20250428080242.466901-1-usama.anjum@collabora.com
[3] https://lore.kernel.org/all/20250516184952.878726-1-usama.anjum@collabora.com

Muhammad Usama Anjum (3):
  bus: mhi: host: keep bhi buffer through suspend cycle
  bus: mhi: don't deinitialize and re-initialize again
  bus: mhi: keep device context through suspend cycles

 drivers/bus/mhi/host/boot.c            | 19 ++++++++++---------
 drivers/bus/mhi/host/init.c            | 16 +++++++++++-----
 drivers/bus/mhi/host/internal.h        |  2 ++
 drivers/net/wireless/ath/ath11k/core.c |  5 -----
 include/linux/mhi.h                    |  1 +
 5 files changed, 24 insertions(+), 19 deletions(-)

-- 
2.39.5


