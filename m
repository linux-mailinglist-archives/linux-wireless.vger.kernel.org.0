Return-Path: <linux-wireless+bounces-37172-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGP/N1TNGmoh9AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37172-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:43:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEE660C962
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 342E43017F93
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1B3AC0E9;
	Sat, 30 May 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="lOKFzkNf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED63AC0EC;
	Sat, 30 May 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141392; cv=none; b=CK5xW4eC9NMK9cVpJZIidpCWSLa5wUvbKGDzx2BjY5EHUXLA51Ahf5SKsKoDz7WTtr1imF0iYvOH//YzYWqtOsTuCE93WDtcqBymqsuEpGlJsc23GVyenxhT7BNCVjwjujaCTI4KmX2Yc/GAkMfhZrIuwfFhVUA4nf2GdOctF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141392; c=relaxed/simple;
	bh=25vHq+E7jDryH0kj4pNJWNsXwx8lf6KF9+ca7yV3CJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oy1Z0C4OL7Nw8tJ9NJyUTE6/Pq/ckcQFOFr5ha16UJYHKyvV/7Ts2g7dmUoUCzfP2IR8F22PVe/8puxtsGowzlxaeglVmHZG5DK2FHcpj0QeRGxd3EI8aWamDpJnrDYno2I7l6tBa634qXiC3gzGhFYw201Yy7BrZY3dSMTjGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=lOKFzkNf; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ubuntu-jammy.. (unknown [82.22.40.93])
	by mail.ispras.ru (Postfix) with ESMTPSA id 96D8F45F79A1;
	Sat, 30 May 2026 11:42:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 96D8F45F79A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1780141380;
	bh=dF/ov+B2LMDoBsqviZzmq1HcSMdYOweJxIZb1W1we7g=;
	h=From:To:Cc:Subject:Date:From;
	b=lOKFzkNf+8uNjflP5RmWxBGKR4y+3GuP/z8wn8rBnEXDfIa4oObZuyPSzZw62hsji
	 X3NmxL2roFI5LxSiAg/VipmEnpe3S63An+dKbFl6i8t04lB1K1a7w939NEcWhBeRZk
	 pJ5T7qwFNM8PtnzwjM7D6GvRa5jd4ggbl6Q//OkY=
From: Dmitry Morgun <d.morgun@ispras.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Dmitry Morgun <d.morgun@ispras.ru>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()
Date: Sat, 30 May 2026 11:42:52 +0000
Message-Id: <20260530114252.42615-1-d.morgun@ispras.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37172-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[d.morgun@ispras.ru,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4BEE660C962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the first entry in msdu_details has a zero buffer address,
the code accesses msdu_details[i - 1] with i == 0, causing a
buffer underflow.

Fix similarly to ath12k_wifi7_hal_rx_msdu_list_get() by adding
a separate check for i == 0 before the main condition to prevent
the out-of-bounds access.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Dmitry Morgun <d.morgun@ispras.ru>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 2a413e3a0..c9f520c2a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -4565,6 +4565,9 @@ static void ath11k_hal_rx_msdu_list_get(struct ath11k *ar,
 	msdu_details = &msdu_link->msdu_link[0];
 
 	for (i = 0; i < HAL_RX_NUM_MSDU_DESC; i++) {
+		if (!i && FIELD_GET(BUFFER_ADDR_INFO0_ADDR,
+				    msdu_details[i].buf_addr_info.info0) == 0)
+			break;
 		if (FIELD_GET(BUFFER_ADDR_INFO0_ADDR,
 			      msdu_details[i].buf_addr_info.info0) == 0) {
 			msdu_desc_info = &msdu_details[i - 1].rx_msdu_info;
-- 
2.34.1


