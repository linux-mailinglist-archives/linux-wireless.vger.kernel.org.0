Return-Path: <linux-wireless+bounces-4173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D619686ABDA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9201F22F73
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38D2D052;
	Wed, 28 Feb 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SK1CSyQM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203c.mail.yandex.net (forward203c.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B91EB22
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114839; cv=none; b=AaAlmow0yfODkLic46k+sHp0GHEGTKj1xDebBkOs1UMotMDTKqcmAvCVI51aNxPwBID27au6qd3FFnngFcUNhVQSFmv3RSbgbWUlvZ6WYMvtWtfdO8Xzt8Fb2yNJlNV3rAkKB3Lzj00vsALFhpj2sz7CCBLgjbM8mvundcoNjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114839; c=relaxed/simple;
	bh=ekK2toNcYssRB+Ke9KTOU38XoEmlkj4TzqCZDVJVX00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcWtFcfZvq8z57Ee3mgBIzvu9MkC6BQiNwzsC7wHZ9YXg9LWxic1/p9JAWqSywWHC9GaTNcYHdUuaioyYqWHxHsPQCPFumzMlxr0KZoWBbGyWtaxKTC8TeCbaoMAwYl6M5/0lwpVcnjAcc5UOueq/QLvItQV55nDaPMGk/XL344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SK1CSyQM; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward203c.mail.yandex.net (Yandex) with ESMTPS id 5D8E865028
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 13:01:04 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:40a4:0:640:8f61:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id ED909609CC;
	Wed, 28 Feb 2024 13:00:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s0WeXZ7EUGk0-MPorsuKX;
	Wed, 28 Feb 2024 13:00:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1709114455; bh=qEJeYbmJxo0BtItp/7yVTF7rBZlv9oown4rhFVe/Ymw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=SK1CSyQMM4jD42S1SLWEHk7xn+TZARBpgwD7fqWz+ozAdqoZmY7hzrMtI0ezC0wGd
	 Q520UvPdLOjkv4GpbO/eGos5M1AThga4qVbXFaRLxs4bKkXVQB7dsMCphdaPGY7AoY
	 gAUMR/6+omTKRKV7I8zVaFfwBMmxY4nL/6BSZd8A=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: use ath11k_mac_get_ar_by_pdev_id() consistently
Date: Wed, 28 Feb 2024 13:00:38 +0300
Message-ID: <20240228100038.138267-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.2
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
2.43.2


