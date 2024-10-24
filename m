Return-Path: <linux-wireless+bounces-14464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14559AE3DA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C528322C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A916D1CFECE;
	Thu, 24 Oct 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="JOJfgHMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267B1CFEA9;
	Thu, 24 Oct 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769404; cv=none; b=NgHm+zW3hXUHh7NWhQHTPq/EXV06OzSEsHpZmEnmIrO6w95fp0A7iEczV4Ty0fmog4u+dQ9tVvEn2/cl0om/it9tuVkpNMsUGnuynRB8RtINObuECJA353AS7yShR5YRydqE691cG7hjMD8LvjVi1K5X7/9IqGqsLIBslZMMCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769404; c=relaxed/simple;
	bh=Es75ymu6TA/72wlDe6DDLYMi/A2MnDf7PCeFMC1cgZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wi8X34UzfOaxjZyoIcPRz+/0D+BUJPh6IInKuF/NgAUn8bEIuzaevkbzzDXsEsKsrTrNOlaLjgDq9GNLouSxlgNgmSM0gPHYypfs0QYW0JoSvluvh5Sm0Cur0eldIHfFZS5TTr7W6IIWeZVeC/LXwl8jPa8akE7+WnD4EPNDqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JOJfgHMx; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3e0b:0:640:c81:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 0CC126098B;
	Thu, 24 Oct 2024 14:29:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id oTSTCcEXxKo0-UX2muSCE;
	Thu, 24 Oct 2024 14:29:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729769393; bh=++B3dviPbcmr1FsTl+ZLaUiYpKOFDaZ1XAfNcpeoR9s=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JOJfgHMxsjwfzb6e7ZRo572aX5p16jgqex2ssh8DF6cH4XPKnPEQN8V6R8USJLoT9
	 A+UslEmN8ffoG8cwhxNtUPZRs9l9Y0YvfG5n+6NAbXjjtzpfoVp4WoFL/QRm8u1Cg6
	 +rtyQA3ulg6pOFwIb34gcP3eeGhmUfP5Q2Zo1lGE=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 1/2] wifi: ath12k: annotate skb of struct ath12k_ce_ring with __counted_by
Date: Thu, 24 Oct 2024 14:29:11 +0300
Message-ID: <20241024112912.106104-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to 'ath12k_ce_alloc_ring()', annotate flexible array
member 'skb' of 'struct ath12k_ce_ring' with '__counted_by()'
to improve runtime bounds checking when CONFIG_UBSAN_BOUNDS is
enabled. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: add related comment in ath12k_ce_alloc_ring()
---
 drivers/net/wireless/ath/ath12k/ce.c | 3 +++
 drivers/net/wireless/ath/ath12k/ce.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index be0d669d31fc..23d984da2341 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -550,6 +550,9 @@ ath12k_ce_alloc_ring(struct ath12k_base *ab, int nentries, int desc_sz)
 	if (!ce_ring)
 		return ERR_PTR(-ENOMEM);
 
+	/* Note nentries should be set before populating skb[],
+	 * otherwise __counted_by() might raise false positives.
+	 */
 	ce_ring->nentries = nentries;
 	ce_ring->nentries_mask = nentries - 1;
 
diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 857bc5f9e946..6967e3891030 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -135,7 +135,7 @@ struct ath12k_ce_ring {
 	u32 hal_ring_id;
 
 	/* keep last */
-	struct sk_buff *skb[];
+	struct sk_buff *skb[] __counted_by(nentries);
 };
 
 struct ath12k_ce_pipe {
-- 
2.47.0


