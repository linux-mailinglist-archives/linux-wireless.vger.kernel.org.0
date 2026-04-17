Return-Path: <linux-wireless+bounces-34931-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNvbHtAx4mkZ3QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34931-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:12:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711E41B7C5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EAB2305A462
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9B3B3C0D;
	Fri, 17 Apr 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cSYS4Lk3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3F3B2FC6
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431494; cv=none; b=RoOnaFidy/oAcne1q+3F1w7R2ABSTq8qsBUBMAMjXinaIDF1EKAieOCrNe26KtYpaus3vxaH3RGrn4dudf0P9EjFkmrSuAOFzn6fLEaI2Unw2OtZDpdrd9Qwp6nG2E8myz8oTo182+5MUA+kIEeOn18zWNU0WmQfveVYHkOFBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431494; c=relaxed/simple;
	bh=99pqrTeNKVIGhX8X08ShNnx6aTU/lVS+ge4kgGBnY5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoDbXLFug5UCL/5iODl0zkB8YT1gYD8YxaKhyBNwX5OFKxNW/jjD1J42ilsarhXWQQDgM4Kdw7K4HcXuYdpF438VI72QMb3uYZNgekb2iSVOtBUKBB7ItJs861aUGAdCZYpxAJS+qHsgASyTr/o84tADXPkH3y6z1+5MRAtJGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=cSYS4Lk3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so9318775e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431492; x=1777036292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QkS3sLAmP1yQm4RdEvs3fVFr4UG0LEkh3x6qqTYVOk=;
        b=cSYS4Lk3lU5D+TFPsZpcrlzjYHoDRuQjQhOlef6IvbIS7pRRCmZ23ZES4wVQzYmGUw
         7gZbZDSocymG+Vvad7rxziFofEclSD3uVkZQDP2MZHZazMX6nvciaHiv6b4mT3rck71P
         7pSkwYF0wX3tEBxCwt5MFJYtHifWpqPgo8K8ua6Z1dvudrmauYfaoK2wp21jL6/sm1MY
         YCWOp7tMFT+pLvnMiwUZq2OX7KUWgfjzbUMzsqKWd1IMGoMYpiMQFOUANpCJt7FoZu2G
         THTYR+JKeus/LzChkN921ouAbWWYAmkZN/OuGxYzdxKWR7EUCGh3Gq8zTOwg62/J4Ycb
         J4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431492; x=1777036292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4QkS3sLAmP1yQm4RdEvs3fVFr4UG0LEkh3x6qqTYVOk=;
        b=nvyXVUtnTc727UUXFeIuYUkeFGpB4tNjDZ8Kq7IZtENUMsAoitHI2mnCiEMozI6v68
         NA8ebKjEmN9OOoEcu2wkd7YNR9pvYIg21qqWz1iiHeHJlGKurzVeb9XSWxL2DkGMarbN
         4SbvdwpQQmyVYjlzxxK/AcVx6Ix8cFH/kLvilO7Q5qj4n4c7VutMT/Wgv9exzW01ndTd
         N98OAZiiPcYt5ZxLYtgkhfU485cIFVv3tQhKyzy6BZFUVTHzUKKRUDx639qyC4Isngyr
         RfFXlSGFy//0T8v80v/SjDEOPUpgZVm/nhuqIJQGNgPanh7gcVvwKM7biG2xZZQAy6oS
         yT+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9UX6NzIcwZCVgNVZR1VzPYvh2ixp1w1Xxe8+Wbu2afRjWWI13tv/UrOr4Cm/yilGdFqEesjQeKjFiZ3ln0hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztHsr97IYFziiy1xb5MzRMQSwqqqn33Qsu6OsQtYN+YKv8H8Q2
	dgPkZW1MqFAuN6pPm3zf52n2xvCMAeIhLQzTgdcKMbFjQd1DkgpZnoskIWVoGGnW02g=
X-Gm-Gg: AeBDiesOf/dsRd5oJXxIUV+akbOvE/jAziTKyWKGZJC6jaZf7oabc7ouRACYtlP2bXS
	4bEiKx537EXzK6P08UclfpZtuuYAgbCmKKtLwvD8eYI7XdhxOxLPiV0/zoWr9jPt4+FCb+GtJH7
	bSNmMvNIzeAvQzWTpuLT929Uekapft5r/yb1GlGmX6mG1cmDpFQRvRxmxqOkFQKRymolAGdLZu2
	y9buOEqssu855GG5LGZpaoJfjW4mEeegz47AWA+h9lEOqDWWtQP9st4NvVcmbmIqTzeKhmfl/rm
	0Q7KCrYrZqWzeMcMTikm+i4mt5BMJ0EjcStHDk7oEYYUPSxg5a+a4h733iYKcU5aPgQXXm6IDVX
	VRE1znuvCXsEl66NkAkX2zVzjiJe7QNeni1LR8uqIA0V9NVjqtYqZwEdSwJ1vFchhgsssrxYkHE
	y1YCCT5G2m9XqiMleDIx8liGsXwFwmnByxcOXRVKrgbF2zm12x6s4rbbleII3LSogiiFVoOtYW8
	CXuO0jaihIIbGJARQnwriM65MIfIvB7u58=
X-Received: by 2002:a05:600c:c090:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488fb74e130mr29074175e9.8.1776431491453;
        Fri, 17 Apr 2026 06:11:31 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb75af76sm16948365e9.13.2026.04.17.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 5/6] wifi: mt76: mt7921-sdio: Make use of driver data pointer in sdio_device_id
Date: Fri, 17 Apr 2026 15:10:51 +0200
Message-ID:  <a6c6c5efe0716f910439026ea6f26efc6e2fe58c.1776429984.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2715; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=99pqrTeNKVIGhX8X08ShNnx6aTU/lVS+ge4kgGBnY5s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFjhPgBeIjDZSAgsGrUVzIaAF/51tn611lA9 289Fe0ABRSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxYwAKCRCPgPtYfRL+ TtocCACiFjo/eQXQbwFRG2rY8GPBYwH48Wp024nyRoqStITAWsFQz3AVUa4pD9Peymq+C1E3gqo 9EOZgF9UlMBfXt0268RDR03XVaqnkyzqRMneyxxRDbBs9zAq+q42ZMOdc/13Djg10kLb1I7TpZT 28N0AoNRk5EIoEs5Fm7cjjWC4I7YoYYvUOADvK4Oc1GPoeKf/UFyom6VNqlRTykoWb3UTFNZq3G QqbLaTKbdIE+jor5zs87/HY0geFwlP1w4jGSp/S16eW8H57HQ8lcV05kjYnfKSrVHh3JbDnzr4H WmfbEqU44OJX4RZjn8ofHu6GxEsbWGVHAMc+dpLQSiZ5UHyB
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34931-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre.com:email,baylibre-com.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1711E41B7C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Recently struct sdio_device_id gained a new member to store a pointer to
driver data. Make use of that to get rid of a bunch of casts.

The pointer is declared as const, which requires the addition of another
const for mt792x_get_mac80211_ops() to make the compiler happy which is
a nice side effect.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt792x.h      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 3421e53dc948..284529fe6282 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -18,7 +18,7 @@
 
 static const struct sdio_device_id mt7921s_table[] = {
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7901),
-		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+		.driver_data_ptr = MT7921_FIRMWARE_WM },
 	{ }	/* Terminating entry */
 };
 
@@ -129,7 +129,7 @@ static int mt7921s_probe(struct sdio_func *func,
 	int ret;
 
 	ops = mt792x_get_mac80211_ops(&func->dev, &mt7921_ops,
-				      (void *)id->driver_data, &features);
+				      id->driver_data_ptr, &features);
 	if (!ops)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 8388638ed550..51c36ef4084e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -436,7 +436,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw);
 struct ieee80211_ops *
 mt792x_get_mac80211_ops(struct device *dev,
 			const struct ieee80211_ops *mac80211_ops,
-			void *drv_data, u8 *fw_features);
+			const void *drv_data, u8 *fw_features);
 int mt792x_init_wcid(struct mt792x_dev *dev);
 int mt792x_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f2ed16feb6c1..b92bae3f2151 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -763,7 +763,7 @@ mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
 struct ieee80211_ops *
 mt792x_get_mac80211_ops(struct device *dev,
 			const struct ieee80211_ops *mac80211_ops,
-			void *drv_data, u8 *fw_features)
+			const void *drv_data, u8 *fw_features)
 {
 	struct ieee80211_ops *ops;
 
-- 
2.47.3


