Return-Path: <linux-wireless+bounces-14461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5CC9AE3CF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDA81C223A2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB01CF28B;
	Thu, 24 Oct 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="MaMAVTd+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA31CEE8D;
	Thu, 24 Oct 2024 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769249; cv=none; b=XKpQIhHGW6bX2QwsqavLpZspHofuQcSu22+EUi7CE8xsmQ5iThtZL3NXgpkxo2RaUZ+aFXQCGuMJs8IfpKFHTxEweZyWqDgn2IYESnFpqFwrMFlrkPCRbbV499eyqld9mdtG7naO4/Wz+Wo/xgOoIfNX4V+1cBqPh/4dWtGU1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769249; c=relaxed/simple;
	bh=f7+wRqBTJ87IJr/ynVG7exWhEStmBKg0qfZz4iY8hg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfEaT3ORdF87AbKKZcvjZd2ZYU6OMZLRTb5CXwmrV7y3pcs9F7EQTyxJ0TPAtNu8sIL5DMYkJNBy3sbo2805fWG6nhC2lmZabfaD5YNTMCKs2Fb7r+nY1QuHN++w7IDzbE+ioRkHex1HSYZSttIkY32GxSFWr+aEKF2/4yWe+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=MaMAVTd+; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id D0C1269E3D;
	Thu, 24 Oct 2024 14:19:40 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c80:0:640:a0f:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id DEE3246D53;
	Thu, 24 Oct 2024 14:19:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SJSJZc7btmI0-tSXkcIaZ;
	Thu, 24 Oct 2024 14:19:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729768772; bh=RuHddOqR/K2dqzEnBWeCDYyPNgYNh3MglBHsKDZdNAs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=MaMAVTd+yg34vniGo/dTY+oZGPvVzyZ8zkoV3+t5YvWgl/IW9CnWVDuSHj2b+Jre3
	 uVPHXyiQJZc5ZeESeUNvbOgNQGaglLJ551H69vbDe/9Hwa2sSF7pZH0fO28+XK4Vj+
	 NMao/81op8LIcnwrcpkMLpljXnkdbjgFZyQ7bNPw=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 1/3] wifi: ath11k: annotate skb of struct ath11k_ce_ring with __counted_by
Date: Thu, 24 Oct 2024 14:19:19 +0300
Message-ID: <20241024111921.93105-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to 'ath11k_ce_alloc_ring()', annotate flexible array
member 'skb' of 'struct ath11k_ce_ring' with '__counted_by()'
to improve runtime bounds checking when CONFIG_UBSAN_BOUNDS is
enabled. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: add related comment in ath11k_ce_alloc_ring()
---
 drivers/net/wireless/ath/ath11k/ce.c | 3 +++
 drivers/net/wireless/ath/ath11k/ce.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..56d616a8506a 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -620,6 +620,9 @@ ath11k_ce_alloc_ring(struct ath11k_base *ab, int nentries, int desc_sz)
 	if (ce_ring == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	/* Note nentries should be set before populating skb[],
+	 * otherwise __counted_by() might raise false positives.
+	 */
 	ce_ring->nentries = nentries;
 	ce_ring->nentries_mask = nentries - 1;
 
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index bcde2fcf02cf..9c54244970ce 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -162,7 +162,7 @@ struct ath11k_ce_ring {
 	u32 hal_ring_id;
 
 	/* keep last */
-	struct sk_buff *skb[];
+	struct sk_buff *skb[] __counted_by(nentries);
 };
 
 struct ath11k_ce_pipe {
-- 
2.47.0


