Return-Path: <linux-wireless+bounces-31346-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPnkDqgkfGnsKgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31346-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 04:25:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF35B6D0B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 04:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7784300D150
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12F2EA482;
	Fri, 30 Jan 2026 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="0xlOyoH6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6B21B9D2
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769743523; cv=none; b=HIKnl63Wfa46JBpz0YvRl5lad+b5L6sUQVeONsLdjE7sjhxSQRHUhDJHx/Pii+6esr7zeCAzakIlq4xNzSTzzbEDMv4U6ZHT/886PS3PWLva8IKv1GsWF9T2swK/ItOgpa7RBDDORwBCuEprgwMPbxQWDfd0LbhFSnVS2l0ApB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769743523; c=relaxed/simple;
	bh=N/F19EKyAEy79y5S0lfKTwus16hpKzJl4uPLwcr9Wp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YO/ZzwGPBwoQEnvJbb14EaKRPOy//AxmFWYeQAfmrnRCof5ZD6NgBYXmSKZLYfshiMrKO6TBZblUOmP+LnkrnVpGmtYomqeaB4kJX7je/kg7GGZ7v/mU3ovFBEdBWm8erqbXs14cL5w7hS9NGHSpVEGpDyoRsd7JiNt6qy5GroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=0xlOyoH6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d15b8feca3so1680118a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 19:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769743520; x=1770348320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6W/Gjxb5BYcwIBkUjagY0/HM2eFwFo2YH1eXPS7fc80=;
        b=0xlOyoH6DIzwp4/Z+nP8RvLjVux6lHBvzNqUAdbjleHt2Vz9J1OUCt9hHsHG8ZxiWl
         5jmM3MZKH46AHihP88oLsjTVOgiUb9s5MDJlkDGvbofqz1WuRMq5BmdJTOVAjxSRqiJw
         0p4bTHmkx4BfUpdroI8C0u0OEVgzG+mHBxsXtEPfHr6wZHmnAb2t1QC98dcKM/+2Qi0M
         ZVlNkKL2YITQCd2i1E93ler1URGNnHVMj91GoDtI2EqUiD373GYkt5W2/0/C8tL3Ef36
         ku3fU4k9HzsGUJ0F1hwz7PT1UP+B0lyKQKtIVZksYvbynP5JpjsELZVfEo5m3SCClIF1
         OjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769743520; x=1770348320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W/Gjxb5BYcwIBkUjagY0/HM2eFwFo2YH1eXPS7fc80=;
        b=Wp5GdWeS1NQ17j2gt95bCUwcNfaG8ai56HLPSp5rHkt+cK5QyK+VnBgZrEUKRGpaL2
         r7vfi2nKxldHuy9Tt4wSrSC5QxRFJXynb32ICp0tmDJH1i1JMtk7tnWcEfIBo3mt2WXN
         +LpJExdV3q8/4ws6qaIhCL5lp/E5IP3ILhba2ZGDuD5WAArRggqwmkJ+r2nZqGKsHu2D
         NBFv3j0RU+xlmaPZNFg9OvYWQh0j8bvI4B59Ug3gZfNekSxYUL4LjBYxjKjaVLA+uDn2
         auhW/VyTtGmnwrdaslqxZIzWzGPfSPK4QXeeh/VwQL8zCc5YcESg8R69esW9YnW0Eh+j
         8vbA==
X-Forwarded-Encrypted: i=1; AJvYcCWQO+lJZHLgHGAxy3Ax4i01OnuDwc3SdaCtC+lO4IZIBjP1kcAkBslplfkx+XA6g6XlqcXI+xtjr2rVS8yX0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSrMV1e233DGF+RdlplA8UhaOO8KSDL/1zfaYZPNIjnUVgh2D
	Cnwej65g4gx7/S0Y8aLdU6Y3k32E8ngJ+4CsIsjysRB5HPxWPVVZy1ePxVMyZNM/Fzs=
X-Gm-Gg: AZuq6aK/W6h+7DmcOd8IzaKVF7j7YzJA+m5j2kZzDlR5ybFH4c0fdTxgOQ3aDbeJt56
	IoHo539mCLNtXE/7EHoWAFl1YDzbS9azoV2i9k3fkFPFXBcTnSugf3Lqz+dQfOfCqRkO/ah3pFg
	HhXKxCKz+zJEkX2Wwg833TQnCUSzEqjLTfhpuzpqjneiATHPDT1sB60d+cxjcMRqMX8fdlIc3op
	k8/1bDH++oGlgfxgQtNti8jxvRTsZcMjFwNc6V2SOrIEXGdO58nZ1NjztSOtZu1pgzGILKwtvKx
	GwFlLE2gdhDjAKhO8B4gUjJtgplowKGf+9KjVuDrgtC4EbQBoSVyYbepYmVgQS71wGL76WGLA1+
	OSTyvR1iNv3QRgETOd3WQs7RJ57f74XtQoeN+iQ6nJrCeIcFzY0IAVJ6bABM5KoAAPM+Q0fyiag
	FKijW0Guf2h0tRLl2XuM85yWDyO81fl1L0QAJqpiOAaT2jR+DxsU0NLpJ8KUgkUksmQ7UYR7f65
	wmGdki/mNKfWxN+/ba6/OGtiDt/y8PAp6KyYzcsxQ==
X-Received: by 2002:a05:6830:43ab:b0:7cf:d1ed:f9ff with SMTP id 46e09a7af769-7d1a539155fmr1076078a34.34.1769743520479;
        Thu, 29 Jan 2026 19:25:20 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c824251sm4757013a34.26.2026.01.29.19.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 19:25:19 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] wifi: mt76: add missing lock protection in mt76_sta_state for sta_event callback
Date: Fri, 30 Jan 2026 03:25:17 +0000
Message-Id: <20260130032517.173590-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31346-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,u.northwestern.edu];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,northwestern.edu:email,u-northwestern-edu.20230601.gappssmtp.com:dkim,u.northwestern.edu:mid]
X-Rspamd-Queue-Id: 5AF35B6D0B
X-Rspamd-Action: no action

mt76_sta_state() calls the sta_event callback without holding dev->mutex.
However, mt7915_mac_sta_event() (MT7915 implementation of this callback)
calls mt7915_mac_twt_teardown_flow() which has 
lockdep_assert_held(&dev->mt76.mutex) indicating that callers must 
hold this lock.

The locking pattern in mt76_sta_state() is inconsistent:
- mt76_sta_add() acquires dev->mutex before calling dev->drv->sta_add
- mt76_sta_remove() acquires dev->mutex before calling __mt76_sta_remove
- But sta_event callback is called without acquiring the lock

Add mutex_lock()/mutex_unlock() around the sta_event callback invocation
to fix the missing lock protection and maintain consistency with the
existing locking pattern.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438..468bc176bacb 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1640,6 +1640,7 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
 	enum mt76_sta_event ev;
+	int ret;
 
 	phy = mt76_vif_phy(hw, vif);
 	if (!phy)
@@ -1668,7 +1669,11 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	else
 		return 0;
 
-	return dev->drv->sta_event(dev, vif, sta, ev);
+	mutex_lock(&dev->mutex);
+	ret = dev->drv->sta_event(dev, vif, sta, ev);
+	mutex_unlock(&dev->mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mt76_sta_state);
 
-- 
2.34.1


