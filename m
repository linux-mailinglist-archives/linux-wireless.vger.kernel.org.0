Return-Path: <linux-wireless+bounces-30326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 385E3CF17CD
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 360A0302EA2D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0DB1B4224;
	Mon,  5 Jan 2026 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJR8GJWE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B418787A
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572817; cv=none; b=THn6X82bUVZY8MNroWnix0fwYOSvhyYy8rvZjR0xZ3bxj+Os7PONYTTmEuqxEED1R8v4JMs2g82n+ig3y9X67iQRAgQDpm6G5yIcxW2hrhaSG1+HH7k0Hi/spVqOQ7sC0jmHit1oX+tK8r985mkbiKgOmfblP8Qfl6OMeUhGi6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572817; c=relaxed/simple;
	bh=GenBBIdoaeGrNuDXWpewI+FWlcSedQ3dzL6cf8SnKio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi0mJkytPMuXTgclogUUlKfPQov/QjoR/o4ENtIK0GSujOa/uE4AvwIJHXCu1gvtCqYOTwHfsDFaRuWe3zzpkrckdD59Fj2Mfx4llUp/UMyLLP8NPExInoUvOp6Od01n54Kgz3vcqQ7BmsHyN+0pPrcwH1c5BfiD17/eSeEfYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJR8GJWE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f0f875bc5so201261755ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572815; x=1768177615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A75z2eUdNK91diKdVTUHzH8dkd/SHqnoNMun1BNbA8=;
        b=OJR8GJWEh15AhZV5KdBfjUfXlKgQeVQDFYF4B60z+YIBzvb+/lc1AzSwhuXM1MRiT1
         tk8dhrjd89nWhUL8ocwhCuAYy9c2qdewFpNvoQxs5bmARx0WGGoLhUpGT5E+dKQzcKu4
         J/YatftFo8M16Wipl8ZF0zeg3ukGQ22GzNXTMPJx2qO3/BpmknvF9c2nSDxE9M0+KTJ4
         WcWggn9/ECynGdItlV1szELvavFd/PlottCG4wB0SvCCOe845crJNsRkLUs+0vQN2gNw
         0WCX9wgaLtaZGpZbGluiB9AToF4LfVv0npFjKc6o6WTCZDv8G6QkWETWb+gwy9NHnBHU
         psuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572815; x=1768177615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4A75z2eUdNK91diKdVTUHzH8dkd/SHqnoNMun1BNbA8=;
        b=Qu3Dj9WGlKjeO3AMxX2kN88IVqVXebd52ikxv4OSL3uqJCLDDyntTFjaY505KZ7l/L
         Con+f3nNrKd+db0Re7+bGyBuDiwi3wTXvxKqMGVRFrgqmeusLWaLJL8yEQQZm/xC03vS
         mns1pUIth2ZhUvqS9Sb6HmPsirFnZVwEIlb0fykVsZWehMPzZMZxA2YGzDNu1Q44Iiab
         fK50wW+NYf9IgKFVdyi7vy46pHxiylgr4W4+LIA0u/e3kTMwOzFQ2ppsyHpgPLnTCLcD
         8vDu2mhFRP+r6uoD9cahDH3yKeSEhOHSeuG5vog8yOSUzqqoHrXoBmq37QIiwc659MxR
         9f5A==
X-Forwarded-Encrypted: i=1; AJvYcCUQeqfoluQxkssM69xKAR1NHLsk3rkptardMLaT6QOK7oCwSW7KP5jlgCLnA5ki0cpcDQSwYKCrPRtRw/jxkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2SBtaeuCKHk/GP3PJS4RsPzJ4qhDPe4uQ96QZH08Eg49XN0d
	OgXYbnDYay/Gknq2GkeCrt67lr/RGVUe8PSl3vpYyfS/XOq4KXAX/yHP
X-Gm-Gg: AY/fxX7i0Krbivrv7u1Lnr2mnt3SlHOz3uL9JliDRGkkjVobfS3mwJP9Nbvc3T7+/gk
	i9WtPtCKdpl2WfLcmj5XjWEBLLhzihvWp8oKbST7GxgeAx0yTWRPGcqezZzFPJdQbcz8eRwRitq
	NIQwU2sOgl6LqU1DEp0JBxP+WB6Set/ODljqzCAJNW3fui272yrwW1PzpfIKISxgK6YEs7I0Fes
	9XsY+6DyMARPHptw/alf6BrKLSGN433vQf9eRmYX9HZN3r5XDO53937SDwidftaMh5KWVHQkCrJ
	lyUy+V6z8s1LhWl+w01YcdJLBf1fAW9f3NTInk9dbRHRc4JJKCTVBvVMI1oU8F4lEV8M7ThW25n
	K9V3PxRwbwNqagzujWwybsLcMgVVib8OcaJG7WjaHrKpcQeeFsRzaS9oYnP7B38jH+kX8wQl22x
	Ph4MKGMsmgdmQpWXsrm8f8j0mzKVgbJpkP0xkdJpE3b3FE2RrAFJ3t9SV1VdvecjY=
X-Google-Smtp-Source: AGHT+IFBK3F0/2RgdN/ZpBCzCmAP/zg/RkfAb+km8zi3yK6Guq4CtpKQC9B+fW+51Yj7xBIyBIQ59g==
X-Received: by 2002:a05:7022:6190:b0:119:e56b:9585 with SMTP id a92af1059eb24-121722ac504mr52295722c88.10.1767572814538;
        Sun, 04 Jan 2026 16:26:54 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:53 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 04/17] wifi: mt76: mt7925: add NULL checks in MCU STA TLV functions
Date: Sun,  4 Jan 2026 16:26:25 -0800
Message-ID: <20260105002638.668723-5-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL pointer checks for link_conf and mconf in:
- mt7925_mcu_sta_phy_tlv(): builds PHY capability TLV for station record
- mt7925_mcu_sta_rate_ctrl_tlv(): builds rate control TLV for station record

Both functions call mt792x_vif_to_bss_conf() and mt792x_vif_to_link()
which can return NULL during MLO link state transitions when the link
configuration in mac80211 is not yet synchronized with the driver's
link tracking.

Without these checks, the driver will crash with a NULL pointer
dereference when accessing link_conf->chanreq.oper or link_conf->basic_rates.

Found through static analysis (clang-tidy pattern matching for unchecked
return values from functions known to return NULL).

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..d61a7fbda745 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1773,6 +1773,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 
@@ -1851,6 +1855,10 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 	band = chandef->chan->band;
-- 
2.51.0


