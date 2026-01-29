Return-Path: <linux-wireless+bounces-31311-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBAjBRkje2nXBgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31311-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 10:06:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B7BADEE6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 10:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50D0130022FD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFEB335554;
	Thu, 29 Jan 2026 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlcd3tHI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C92DB79A
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677586; cv=none; b=BuDdNO0W0y0F6lsyUUgclrFegVS9Y+QYaCozQPH8Py5GlOAfCXMH8pUaHdsEpQIlTxVRCi92jAaouNfMzTp4WbChPwuVvZUJw4DGib9uzve/f67WD7V3b6GrY2wDD2HW2Y4kNK0MPpRAB02DvJixUTtHYiMEWDVuU1OIlMpSH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677586; c=relaxed/simple;
	bh=R6dVrUcNBbpLQt3Rtteu0UsbahuTBhGADTZQ8hJ0c5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ak8xzA75dI2Zua6PLP4GYpzlPE5mYZXLS5QMjOWbu1axdMqvGTYhQwvpKL5+TkAK0cl1xsm8lZkYV26kIhHwXIcYi0YGb3S26zEDeA8XTslOiHlbw2/yiGbVR0OZKwkA4optV/imLS/I/OAxq2tk1xqx/sx2jlLBByYmJl+YiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlcd3tHI; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b720bb90d0so735007eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 01:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769677584; x=1770282384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DytMJO0WqVXchRW5Tcsc01QJ5SYiHM6gt4jb9e/3TBI=;
        b=hlcd3tHIRAwQRbR3pZY9gS+lqZlxkP+pAvtkXwAWPp8gO8D/Kzt5nqG8QVmhCyT83t
         r3KGl7rrXJG2DmbLN3LrYSLjffBq71NLmFy7Sz2arukaCq1MgUxgv99VZTNx1p8XxdF3
         07ymXdo9N0f8OFjnzhwU5iZO4zzLIH2oJpIPBCFTckkkPpBzJKFoJNiZCBsgWGT3ofqr
         7VWi/Afo27UMBXmBK9ngbQAHH418iiQ6qMbwfyj/iMIl8etoyNwt+89ZXONPkyHmsdJL
         QfKxDPHxsVX33p+Zn9PPQcReryCmHSPdWE4Zg28ObQdTf9Bw/EHIkiHqUr+syMLLRsNW
         ddNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769677584; x=1770282384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DytMJO0WqVXchRW5Tcsc01QJ5SYiHM6gt4jb9e/3TBI=;
        b=Tkn/866u5iGngtRCooMbrMMB41gqUfhQcimG8AIq2cB4pl8rUJn42ek0/5kpxnMFtn
         eKQN/5CUIlw/Fa35B4vuxlCv/GMHDE79XvX8OjR3EVmGq5nEnOrTDTquL7fxE3/4EiKt
         spkht9YZoueYSxwBnci1h8rohWs15ItkE1xJ+wQfrk6CXKkywgjSxyhxjR+iNkLKpUo3
         DPQDGfTl9dHnFDY+sxxhxU5U9jhAiUobeJN3SqVhWp86WJbyt7urridEx/vHF0q8eZgy
         tKm0FB+B/JV3AwTOFzKXbVA5A/cTPLSkbfDDA4MEu6bX2DS8g7jcWc5do1Xhloec7UCU
         TS3g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/jq/0BOpPeggu8SVepsM2k7wJ2Vf39BpsOSCn/mlcZpQ815qc006wvhUaeMaixCct4+pzSNsvgYh3ngP1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyticE4JXN3A41q63/aE4yDJ5O5o4N5XNL/9vZlAE2m/ph6Gl/x
	nRHpaSp26rg8zbtF8epMS4de5Z7pw6r0YIxC56Kp0W5O8BxRtGDgUfh+
X-Gm-Gg: AZuq6aInsYzx4F/CdHdqIETkIL0xIlHZibLJKIeSktzsfKxshDaqKGCwnxcmF6xdq5v
	1WM0d0t5EduFD0X+BO4ToTGtudM/x8LL6curz/gYGIzvSSC1g7aN/y2Ep4q+FDjHg7+Fo1ysZtQ
	UQqw8MlIKNoq9Yj5/ZzGQPVM4LxqNr56/uVZdBBdo1LoqDY6mMb+OUBDMkJvv2bPFE2NQ3WE9XQ
	QRsazT1TAS4oFFKflWE1nv15Tjb4Ht0e7tiJPcDOgZm9DjLg9tCwprFPrdX5GxrLtqeSisxuuO1
	xGwjVclbUALxNcPi7DinlSye+6YSq1ED8K/lmc//qVejXSKmQt2wm6DWzCfEnLtPDsBR8enb02g
	UD6BVywJN8ykfeGviV4W8BZgrM6+QGLBVoTu0TGHb+Dou8es7S6Lt0mP+jVdPJliSqbCyy43d3X
	TcsNHerfDFmgRCpmMrn8OkFcFOq1XsC7/ar4sAC6lJvdXDIVbS9DhbdFe5v1oiEw==
X-Received: by 2002:a05:693c:310e:b0:2b7:2551:502f with SMTP id 5a478bee46e88-2b78da5a1b0mr4292742eec.35.1769677583860;
        Thu, 29 Jan 2026 01:06:23 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe714sm6050559eec.20.2026.01.29.01.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 01:06:23 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: zac@zacbowling.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zbowling@gmail.com
Subject: [v7 PATCH 7/7] wifi: mt76: mt7925: add error logging for MLO ROC setup in set_links
Date: Thu, 29 Jan 2026 01:05:22 -0800
Message-ID: <20260129090520.192374-3-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129084611.187744-1-zac@zacbowling.com>
References: <20260129084611.187744-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-31311-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RBL_SEM_FAIL(0.00)[172.232.135.74:query timed out];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[zacbowling.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[zacbowling.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:mid,zacbowling.com:email]
X-Rspamd-Queue-Id: E5B7BADEE6
X-Rspamd-Action: no action

Add error logging in mt7925_mac_set_links() when mt7925_set_mlo_roc()
fails. Previously the error return was silently ignored since the
callback function is void.

The function now logs non-ENOLINK errors as warnings. ENOLINK errors
are expected during link transitions when the link configuration is
not yet ready, and mac80211 will retry the operation later.

This complements the error handling changes in mt7925_mcu_set_mlo_roc()
where WARN_ON_ONCE was replaced with proper -ENOLINK returns.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 0b088c448151..769c09e99d48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1048,11 +1048,16 @@ mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
 
 	if (band == NL80211_BAND_2GHZ ||
 	    (band == NL80211_BAND_5GHZ && secondary_band == NL80211_BAND_6GHZ)) {
+		int ret;
+
 		mt7925_abort_roc(mvif->phy, &mvif->bss_conf);
 
 		mt792x_mutex_acquire(dev);
 
-		mt7925_set_mlo_roc(mvif->phy, &mvif->bss_conf, sel_links);
+		ret = mt7925_set_mlo_roc(mvif->phy, &mvif->bss_conf, sel_links);
+		if (ret && ret != -ENOLINK)
+			dev_warn(dev->mt76.dev,
+				 "MLO ROC setup failed in set_links: %d\n", ret);
 
 		mt792x_mutex_release(dev);
 	}
-- 
2.52.0


