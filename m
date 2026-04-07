Return-Path: <linux-wireless+bounces-34398-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOnZJSVN1GnvsgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34398-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:17:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F833A8667
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98F8D3079C2E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9D1A6835;
	Tue,  7 Apr 2026 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDNtDDiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D0169AD2
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520968; cv=none; b=oiNjGhPuWid05q0L5MtKGNKtVfIxgSBCG6JGqcAZp8dPP+j5WM7BXUf/5TWiq6yGxDNjCsFtXC7p4oZb9XHaNzszT1F4FyFE5q/cLC28P4KiSQHdXwfQFjvwjohACPXrcn4ylbNw56xcgEraLeNNxcMcSO3FB1G/hRz7t6BVKxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520968; c=relaxed/simple;
	bh=+50rzGhBt4ishhKokCcSA1l9V0TX9Tak+B9Pgz58g80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR4SwlPBFikahB/TTyCLjK9+BU0vNRtuOoQtevXWRGoqX/QVPo/GsttWtN6Po1qNEgVqpxLOAveWkr1mRndKqFTSSrPm8yLLRivehuxoFJZVsvaN2L6+fXreFS8wmbvpU92I8Yh0FLKqLUB3xKB7IoSLS3oAypCHXPfullcHM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDNtDDiM; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65006c99d38so4728588d50.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520966; x=1776125766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l12nMVHZLcuAdmgVWy1G8JLewfzqeYRmAf+JAzu/Tc=;
        b=GDNtDDiMUUpnqJylFJIDfNUrUR6J0Mx+5K48C/JLyaW50IZQ8rxADj7Eoxe1n0dZBQ
         hDkLIVwtO4goLWDlWuIKv0mXUcqNEn8A5huMeIHlP5XLyCrvCObJTF2HKv00xJBv/waY
         BhDOUxJi8bgHAar8Zp+6CxVw2S7+i/V/a9g99zJ99O3lXDodPhO6qF2BtThoIAXLFNTV
         u/T5gykwA5DaNrbnNYTLzphoEGwSjOKSkB6BM7ATpo1kRiJuXVlmKVYt+MmmAJ19Kfjj
         SieqwXeUhaCzIwVFkqO7yuYXILLYLOIdKKE/MaKBt/xjsBFlpO4rDmuvX3tTwS3MyBJ6
         BLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520966; x=1776125766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5l12nMVHZLcuAdmgVWy1G8JLewfzqeYRmAf+JAzu/Tc=;
        b=Dxd67B+zD02J4Y2edokDxXBAnI9XihquqVX+rzCPuoPZ6LQ05W5EOcWo4wqJd2AEFY
         anUOgr6Gec3TJMeL+fJWjFLPt/bxn6SZL6KUUNO4zSbFv06RoZTfCjhJcWXOQYpbDCok
         ADtqu+jt3NsGcQmNEttNEjqGcj7I2d6BF6xTX3RFTRyaqyQplCwkpAnGlACOFM50TX5o
         bqmMV+zfbX3QKqdIB+TSZlY0LofwksV8OfhTuvga9NHMWQHGtX/w/jP4plFBvgPPsRNu
         cPj5pZuZ3kdS5/rtR19OePYcd6VQIrna8Jwtyds2QCmVxqprRblQ7mGcUeaBcNahIkq1
         0Olw==
X-Gm-Message-State: AOJu0YymMOAaJ0r40TiRrZhDraKbuN4OCweRPqp80MFVtB8fUzLyC6EY
	Mp9lYloFW0MHVi7J9wK/bdbMijQXZ3QPk+CR+WAy2V9NuN8ippTyw4wosu0qnsGg
X-Gm-Gg: AeBDievn8bi2npzOz6spYnjpk7BLzP7bq/GQrEWEaS4exaKKIqGyp/6HllSJRy/VVnH
	8VGIxQIzlvJsV9p2qfddZVFsXogrLPHMIIIl6IiEvw0wzaj7qqsk9dqoshX6RhyMQcfL3eoqTos
	idBtWc9kJckbwhff71N92bxroJ5rMpqPbaNluAIoU1enJ7296nqjDvnpbwWB9OrtAh15QSjddza
	UW1cuDCZXB/l3jn4jhw1+qFuCOpDaHskHvgJ9oV0hHMki2TjtOfYjvTstDTJrNAsJQ6g81Vws9y
	9vT/iABO14mS4aBRZ4U7qOXQeV0V8imd1nHI8noEtTRblRdKF0WvhxF/jqoCvCGeAUYKkxg6iw+
	yIq35ES7Z3wjm2llXPcS8gdBPElEwBzUP/T20dDVjwT/g6oRj5CYs4QKvmwZWvSKiZw8nf4j4r5
	HCtX/QPKUWgZXT1soewWIQBV6la8Upgv871Ud6VmHsQBAVvvKjbk0/YNtJVz9z
X-Received: by 2002:a05:690e:128c:b0:650:747d:f70f with SMTP id 956f58d0204a3-650747df9a4mr3030565d50.66.1775520965820;
        Mon, 06 Apr 2026 17:16:05 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:05 -0700 (PDT)
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
Subject: [PATCH wireless v2 1/4] wifi: mt76: mt7915: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:15:57 -0400
Message-ID: <20260407001600.31234-2-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34398-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19F833A8667
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

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cefe56c057..cf72b38c85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -221,7 +221,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		msta->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


