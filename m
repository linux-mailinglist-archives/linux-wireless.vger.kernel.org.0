Return-Path: <linux-wireless+bounces-15047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FF9C007C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1399528200D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DA21DC720;
	Thu,  7 Nov 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Kd2h7t3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B911DDC24
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969702; cv=none; b=VrZZlT17N17DehQi5J38NOpLBIDeOIGJohA6DT5M11fA9BDRfpVE95YpWKAaYeIqEeRRkBSopl9BX5Io4zvH5wyGV2jqKNS2k0mxQ81o1HAOoQgRF0PSgk9UOZjs+KrDjXtNKCuxBidpX65SlajwO6nYjys8+1bR94CtpHrxvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969702; c=relaxed/simple;
	bh=0/W7sk7YlplcJ2KjQVVbhQVuOxriM8rOhiPsuaP+3bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0F9oKbVnp7jmqr8F95CxsnIYmoTpTIB7DbgFr5zsVhdXHWkiO4Cr0hYBdTxC+xNG4cc8ouk2IwIdrZT2G/LTyNZdSqY/n1gLwK+i0Kfb1idHlamW42tMb6vG59PY+oM87i/++yHcEHuJsy+AZ/Frxc+QAnFleWp0W5IMISaUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Kd2h7t3g; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2e9d:0:640:5e79:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 29B8660E4B;
	Thu,  7 Nov 2024 11:54:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id usdEEKE7UKo0-p46LF6Ww;
	Thu, 07 Nov 2024 11:54:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730969696; bh=76mnb3IeiSJ5Qb6v2c8NFgRXUy0/RW4iOC9h+AhxDzM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Kd2h7t3gahp2RjYZ6VJN6o4JtPGiJ0tbkTvzvvquXUsKNvFkEJhceVudDYsObIc00
	 rTTuHWkabj7rOP2RtUloFC/B6sjoCRkH1W+airYM6m5OlEUZeBmVZWyvTIhlbbiBkT
	 cjwW6LqvFAjgclyAwjykWpJ4yWVj9yDUGJvKZrkI=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] ath11k: cleanup struct ath11k_vif
Date: Thu,  7 Nov 2024 11:54:54 +0300
Message-ID: <20241107085455.78788-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove set but otherwise unused 'tx_seq_no' member of 'struct ath11k_vif',
adjust 'ath11k_control_beaconing()' accordingly. This field was actually
unused since an initial commit of the driver. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/core.h | 1 -
 drivers/net/wireless/ath/ath11k/mac.c  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 09c37e19a168..5ab1fdd21144 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -370,7 +370,6 @@ struct ath11k_vif {
 	struct ath11k *ar;
 	struct ieee80211_vif *vif;
 
-	u16 tx_seq_no;
 	struct wmi_wmm_params_all_arg wmm_params;
 	struct list_head list;
 	union {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e6acbff06749..9757ac4aae50 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1697,8 +1697,6 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 		return;
 	}
 
-	arvif->tx_seq_no = 0x1000;
-
 	arvif->aid = 0;
 
 	ether_addr_copy(arvif->bssid, info->bssid);
-- 
2.47.0


