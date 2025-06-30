Return-Path: <linux-wireless+bounces-24657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AA3AED601
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF3D1674FC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBCC23B61A;
	Mon, 30 Jun 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="LONoxqnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088423958D;
	Mon, 30 Jun 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269530; cv=pass; b=cz1MV8TSn+aaUSQwfzWdADeysPPQY15FUPfNq8In9SV2BGMVK+LZ4ir8kQ9tH6znqAh3Bu/q4puDDcBKf/ARLH1MtuYYYMvCCgQdMvlqRnh1PsTDQkwtzm48FXbn1ZOymyhqDkalpBVym/rekiKpkIZwfcaQqSXzlQnwnXB16V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269530; c=relaxed/simple;
	bh=fP8wNhhvTGhRQdFaeD8zMPPim9ltjmiEw4uBtxVPeuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+P5ChJisXRRzJ2Q+GfzrMS/p005CZ/K90HumtTalOY+tiLVb3jDEjF3EDG5w4i/oXb0hOGdcHGXzC0g0lVGTqSHEknpaYgX3rGHwu87ScgicjioZwx1XjnINOzGwCtWDdHUyUAGn1JdaJb2QE2qu1VzGC8ApB7ZSgs0uYXDG8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=LONoxqnf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751269475; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OWkc/fd86IBru20W3fkAZl/Np/x51Yjfb+/KldMe2iU3VaemuI4mSCVzoBSc3eKULXVV7n6VVR1OGwX+D6OJb30fBcjP2GUbRqXxJ8f0VHYq9m20CVjFMMAHXu9yKGospUPzi/t1k2HEu5Pjw6kaNVjrZnpv8hBRjSzoGp6xSMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751269475; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WO427gDVIXndoIGXFM1y8OPxz33+jCFBhBk8n2lT7ww=; 
	b=TFoyVYEg5FHan2RAk1ce9EY6yLX3C+zJOQmjHDqrB1SQ8kHFz2Z/r7aZaOIgBaVije7p7R5anzKxDqRUYXb2AVwvpiSc6PuZy+2E3kaUZwRnsQUBLtMl643LtCHDKarjaR9gKWYokGozrl61NDC0DTvldNOeHwrznmXuPfLdmQs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751269475;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WO427gDVIXndoIGXFM1y8OPxz33+jCFBhBk8n2lT7ww=;
	b=LONoxqnf+xcD0f6vTP3N7eVWZrY7ompALw78D2YASYEb8nYnmwGfCsr1MOU74T5u
	ymZ0vSFvBqSynanoY4hq8QJ0f84j46AvXCSyvKOgifOGmdt5hWhRE5xcnCAG8TLGwOX
	ymJAGQGUdkcn04py5GckmsjV8MtFh6epHGNRA2GU=
Received: by mx.zohomail.com with SMTPS id 1751269474311920.2371976298095;
	Mon, 30 Jun 2025 00:44:34 -0700 (PDT)
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
Subject: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
Date: Mon, 30 Jun 2025 12:43:29 +0500
Message-Id: <20250630074330.253867-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630074330.253867-1-usama.anjum@collabora.com>
References: <20250630074330.253867-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Don't deinitialize and reinitialize the HAL helpers. The dma memory is
deallocated and there is high possibility that we'll not be able to get
the same memory allocated from dma when there is high memory pressure.

Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 4488e4cdc5e9e..bc4930fe6a367 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	mutex_unlock(&ab->core_lock);
 
 	ath11k_dp_free(ab);
-	ath11k_hal_srng_deinit(ab);
 
 	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
-	ret = ath11k_hal_srng_init(ab);
-	if (ret)
-		return ret;
-
 	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
 
 	ret = ath11k_core_qmi_firmware_ready(ab);
-- 
2.39.5


