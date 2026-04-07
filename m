Return-Path: <linux-wireless+bounces-34399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCuLK0pN1GnvsgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:18:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 131473A867D
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1B26308D6D7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E019CCF7;
	Tue,  7 Apr 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1IryfIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166E1A6809
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520969; cv=none; b=UTUTBm3Ei7YOYQR9mf5AxDcQZAy06Gtw2RqVIVOGTuTcywLlUGoK6u93XejkbVy+D04QLvGBlAz9C9n1GWD4UlRICdpM5UL5Px9wfVn+EKN04xcakrCcCDzRmIS4Tj6QyfrFxgy5U0zQr240NzV9PT5i6DYNgoPuSaVWJdSkmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520969; c=relaxed/simple;
	bh=LfkYvGNeVcUMPzu6EUpovhxxAgmTZnYfYq+C8OGymRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQn5JFtI8fhe89QuTSdcbVg6VNpacnUjPHEITnN9svG+EYQK3rveA/Gc/nTfxKl/tyTOYW4baFzMlQF1TAK28G5/BETBf1Rnay13AWbYFrxf3+XYqJZ2Om5CJdnF4O/RhZo7/GEpaI6Xkkuj3Ap14YfUK2yDZ+UN22K5ct3jKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1IryfIF; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65006c99d38so4728607d50.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520967; x=1776125767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFQLJBb/lmxRWKB/kx5iZa1pg9O2vzapGfay6oRBkO0=;
        b=n1IryfIFiR0hQp5Lgkw7I+X4jRXY1eIajpiyQYEKLgTMfNUP97iHJC2+teAqhcObIy
         t2n5vXFJAzpeN2+PquAjxsVcCa8laE54lKZxKdMz+CZEaonfcTE4xTL3RPVG0Fv2jFS9
         ZnSyIJRZN48LPNywfCadM2BKlPjJAQIe+PQ0zi/CwxZYDy1PUSEM8dJG0lcBgsOa0hFW
         OHCiebc5HyT7P2IK9upx5NbJknz0zC6f0EN7rPSQPzGIT37xwh9IdCryhhmn32Yh2ImS
         j/etsFpKuKMLklxI/oI+mlf6KjfXF3c8ZOu6kCxjpvJw01fjcIJzDT3a9vLzNbj/ysuV
         uQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520967; x=1776125767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFQLJBb/lmxRWKB/kx5iZa1pg9O2vzapGfay6oRBkO0=;
        b=QaPcRjbQLucQHwrXX2agZvKxmDEwOzUNMaGYYeWLLktpYNgkRweUGCk8IC1qhfWwV3
         KV0M0a59W0PdHljKRT8yILptN1kE+zkjGB3S7gnf5AN6imCZP9+kV+nJcIRzWsbgZJf8
         pnr8igx8ApG7Yh9MYris8umOcVwTcFoKMuZ6d85fr1WjdYTW5Qtt2feL2yfi2JAzo3DB
         eC+puXU7VDXMDIlZCLi1K5bouSWo3QT6ar2dBPghBiSjoZRqixbTQhFHIiDRO5iDbeWd
         y0Qgpw4vdb+PgROYVsBPbuVAjYph/NmDCGivAHXhR6ByFN134xdEnF5ouYyo/ew0s8xu
         ABKw==
X-Gm-Message-State: AOJu0YxaKccb83u2RQaSi47n9JbBMtaIr/9XTcMNVkUapKAXWoJEbPcJ
	mkh7BfW2wk06FK9+U8RK2/uZ9lF3rMcbL4+HwfgteZ8AVaLzWl4P5NkF60/ggtxs
X-Gm-Gg: AeBDieufDClVZHniwliqkdjz0JvHoCaHKSX/SjDZ+U4MYkRuxvkqHsRcts/z3Xk5Q6Z
	7YhqA48r+DYjGwDRTK5s30D8kZLoL6Qu59okfXLR9bBc4KIJoe7/D5d4VV58T49JKAxNqf8dxnr
	P8MzB4ostgfYOs4lIEWYnySF0vxEKv8QpMzczF69NEhJijaDQgRTmmjL9Wd4SqtL1DbcwBjsGAp
	qL+IFfp/QMG+5h3nwfwgqWzt3DXzoxsUd7204yOsbLiMWrzWOyVcLsy2MlcAVfc/pfPL/qg65JQ
	K6yUmCp2nKoi4HRkyvExBDWJBbXivHFsPabZEnjtiBYVP4m5rCumIAkfLV18yRb8bjCpRkLCF/m
	+hn3AlegxWVq9PF26Ss20aUTFmBwqpEXuyNsqF8Da9XBECge1aInWuQ6uIVNlyYbL55G8dwQbao
	/3qgHSaMY7fjzKp8I7rfl1WiuVjtb2a8PUZSK2uSsX6PEZqRIVYUjk7vQ4C+HQ
X-Received: by 2002:a05:690e:d49:b0:650:37e7:e590 with SMTP id 956f58d0204a3-6504869b126mr13770674d50.15.1775520966993;
        Mon, 06 Apr 2026 17:16:06 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:06 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 2/4] wifi: mt76: mt7996: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:15:58 -0400
Message-ID: <20260407001600.31234-3-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407001600.31234-1-joshuaklinesmith@gmail.com>
References: <20260407001600.31234-1-joshuaklinesmith@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34399-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 131473A867D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
for the fourth byte, consistent with the other three chains and
with the RCPI3 definitions used elsewhere in the driver
(MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).

On devices with fewer than 4 antenna chains, the corrupted value
is masked out by antenna_mask in mt76_rx_signal(). On 4-chain
devices, this produces incorrect ACK signal strength readings.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index d4f3ee943b..a0342012e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -205,7 +205,7 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink = rcu_dereference(msta->vif->mt76.link[wcid->link_id]);
 		if (mlink) {
-- 
2.43.0


