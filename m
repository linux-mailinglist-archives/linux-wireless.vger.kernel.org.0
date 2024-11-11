Return-Path: <linux-wireless+bounces-15169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900CA9C38CF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 08:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B271F2152C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AED132103;
	Mon, 11 Nov 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HjPozOCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA80157A48
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308542; cv=none; b=J3lKlD5xyWCKQmPyclor+wJazFyhJm/NbS0XgYOaM2jKn0csf8f+5UN4YM8XteBOVfxraom9+90Qi5CoOhy9IHf9P+/2U5UjzQJa8um0TbnvR7LkTWygYMgIhXAClltsrIjEgkuQnH252ox7r0AkTPZlFjepk3Uzo3HtMZ0Qpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308542; c=relaxed/simple;
	bh=WhZKkn6MGnvrGY569L92nxM1TPLGnQX/FHo4N7X6GJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWf/IAD6nOljUPeBKuGmVDsqO+6BeFNHRY/g/c4qmeitTXFrj0o03kzHVfyE9Eup8vOwm784tlV4DA0pDB1gA9flmgnPDiqFjs0IMyqkn0L8fIFgwSq4NgySl0xMy/3tVjgdJWPMuAcRaZFyyT1Ljj+CF1tklEunbB6DhQsMlMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HjPozOCa; arc=none smtp.client-ip=178.154.239.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward202a.mail.yandex.net (Yandex) with ESMTPS id E2AA26D26B
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 10:02:11 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 6822C60E97;
	Mon, 11 Nov 2024 10:02:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 22g22h1xFKo0-8zlvh9yw;
	Mon, 11 Nov 2024 10:02:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731308522; bh=kvGXn9BM3jNbzW5aDeunEoBEoVYjCFM1GXfIwX/+7uk=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=HjPozOCaNS/zFs9ye/x/xqPLF8M1y8BXo8tAUzGpzyjlvMswYHzvZArXDm+3nJfCU
	 xieO/gGvGd314fPTKb933E24rNtzkzLG+dbnCf77+EDfh/VGfliDf5gqsqjm28d75n
	 PunxO3LnPNp4VoEQY/P+pL+lGi65IMXJpWxI735w=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 1/4] wifi: ath11k: cleanup struct ath11k_vif
Date: Mon, 11 Nov 2024 10:01:49 +0300
Message-ID: <20241111070152.85140-1-dmantipov@yandex.ru>
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
v2: join the series but unchanged otherwise
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


