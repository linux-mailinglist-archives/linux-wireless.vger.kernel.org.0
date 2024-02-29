Return-Path: <linux-wireless+bounces-4241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B1986C3EB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 09:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8F81C22394
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA650A6D;
	Thu, 29 Feb 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="fPcJytgm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936143AD5
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196068; cv=none; b=CWUfhWaMCl883W4D3sgRREHjq42rffrRfKn6g7N31SvZcR/bovlp+J3CXebsv8gsSxha6us+h+QM8OoIzpHbTz+UB3v9DCze/hiV3y4i8v/O44ib1bVwxif4gaf9Af56Wsw6E9SdSCE+1ZF4DoMWHRLBoO7KNE0hKxFHeY/8Eu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196068; c=relaxed/simple;
	bh=tq0wf6eEo8lPoEY7Vg8wPwEQ2+/zhBI1SDEB7FHWoBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdnuUEPfMuwV7Uoyw1CaYzLOs/NHsvJdMJDMSlSDJ0QuWC+8GDJZJdHx+0Gf5yXzGZ9x/LPCNrz/U4C6N4TF+1HbdavTGRbsMAvxjYPsgEY3At8oFwjnjJTC3Q/rYSA+E/yUn00IEgS/7ICOUhFiSDno0nsrb9lv2SbR/LDLl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=fPcJytgm; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 129A860B62;
	Thu, 29 Feb 2024 11:40:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id teVSqmLJiW20-6Zz5L67T;
	Thu, 29 Feb 2024 11:40:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709196056; bh=0Ttr1Rc6LQgnqCWP+1fX+y357g9rrnweJwnKxC38lcw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=fPcJytgmrLEdj4b4RUjGE1QFf2MbLbirXX7ySfLWviSpH9d84PMpWcv4JDZrKDeI/
	 NlE9eu7RmuIm8isWTbIH04HFEcQTM7NKeK4WbMMPmlWIBXqjjbWpNaJK/wvz0efAh+
	 aSaN3+xDLSrJd/2Kr1/STmhI0dLvEVz1fLSM4vfE=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] [v2] wifi: ath11k: use ath11k_mac_get_ar_by_pdev_id() consistently
Date: Thu, 29 Feb 2024 11:40:29 +0300
Message-ID: <20240229084031.51957-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
References: <788f1df8-64e1-4b3c-ae8e-00c67be1c3de@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'ath11k_mac_get_ar_by_pdev_id()' can return NULL, check
the return value in 'ath11k_wmi_tlv_rssi_chain_parse()' as well
as in 'ath11k_wmi_tlv_fw_stats_data_parse()', and return -EINVAL
in case of error. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: aggregate to the series
---
 drivers/net/wireless/ath/ath11k/wmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 34ab9631ff36..2d93e4e78a37 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6498,6 +6498,12 @@ static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
 	rcu_read_lock();
 
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "%s: invalid pdev_id %d\n",
+			    __func__, ev->pdev_id);
+		ret = -EINVAL;
+		goto exit;
+	}
 	stats->stats_id = WMI_REQUEST_RSSI_PER_CHAIN_STAT;
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
@@ -6570,6 +6576,12 @@ static int ath11k_wmi_tlv_fw_stats_data_parse(struct ath11k_base *ab,
 	rcu_read_lock();
 
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "%s: invalid pdev_id %d\n",
+			    __func__, ev->pdev_id);
+		ret = -EINVAL;
+		goto exit;
+	}
 
 	for (i = 0; i < ev->num_pdev_stats; i++) {
 		const struct wmi_pdev_stats *src;
-- 
2.44.0


