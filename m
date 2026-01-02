Return-Path: <linux-wireless+bounces-30299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCAECEF439
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 21:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6223C3037898
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 20:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6B31961F;
	Fri,  2 Jan 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGcXoc6U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB0315D27
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384203; cv=none; b=JLaEKFeo8IEYnng2E8XTX6+Uj4H66ge0gKSM0C3pHqrGJUzQ3G2TqddOgKRNI1opnURH8jvhzbSC6xZmdp30nEjBEtxtUmEbU+ag3ft9jbBSBSNVUWgInU1fn0K49F+pgRCLG3G83fvtrNF3vf1W6UMnqzXFJAq/zziD5pZ9JoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384203; c=relaxed/simple;
	bh=+gGzc4/H75U+8Zhckcv6hSXOd3V0U/RP7kZaO73v5iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smty0BhucPRN2Y99dgjfglmLGp94x10og6QzbddQwSs5FFunpo+X5xaFaR4DYGY0AeA7PJPZdBqBbMujU75kg2GDe3KaprZcOapw7J4lbgJ4xi54eSv1X2wY+sIE53qOI1/xfQdMt6NVfnUTi4FB54rwJ0l5/8ef/IIA18q0nK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGcXoc6U; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so15813705a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767384201; x=1767989001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAEbXECWEgivnkQD0xtzzqIp3unNQs37uaq9tRUxuXg=;
        b=fGcXoc6UALj1jEJoGZYuIkbIf0gn3PAdTm4Lhh4TWh1Tj5b44wqKqfPNSiQFUChT7J
         eFGgSMEdeIb7k3CkCdPhv0Da+CYKP8g6gf2YUTXw4ld4sHw8S4C7RyHB42HUHGuljdfI
         i/2HxWvm+usgzbUWRCFyWXISPsv+ed/Edp/1/9GL/vEKwZAxxZNO0V9Ffk5uxvl0e9Pt
         BQ/iiuOgtpZSTWlCgfhFn3pdbrk9SSVMKbdlPBe4FzdWfewMeHDE5ixVbP8OcdLniQah
         5Am3WloMubrytQzR8jolzppNOQ7kfZ/4XCu6+2761G8iNPKx1sCN8X4dvHwTpaW3vcTr
         gtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767384201; x=1767989001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JAEbXECWEgivnkQD0xtzzqIp3unNQs37uaq9tRUxuXg=;
        b=oVm4AEth7kLb+m68Hbl/uCuGQcB7G3wrRmtH/htBhb3pel2kVe40ZUJhEgjNk+KNuk
         oV5pwB65UeYphRqm3S3l+wu04BpNNEmQ03m10VYCRbLiab1PiHYKFhru72M3NmjJOBHA
         8G3o/2qZC0SY0ZgTvvmUSml8oRfWNhRa0uBeVLnS3mA6FaRQschswIyqd5va/vbonmI5
         3ol+5qLIe8guzr73ljhyP21rKOF5C1+E6Lnq7x99feX4rC723UPwEFiIXNhzsf5vu40Z
         cWztFKQY8LrsL8o6c94hzbSgNTjd/MlIf89nHis1GotvuGcW2sYxEYz62krVKFJhWiHK
         FoRA==
X-Forwarded-Encrypted: i=1; AJvYcCVKew5m/S52Lzly1xUwQzkHZqd2zs5zzan42EJ/nwU2SoyGetwWXxILoNK3ihxYdmtrtqT3S23NOmUsy5ZtNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygSt35eyUSbZ29LFWaBbBUdjVPHqysyhfnquW0p9rdr5KaS3eV
	STR9o83j0XWVB32Pp5Sk5fCHB7bTmonb6SAYn25Hw1pWEEyo1P5yGc/H22twmfjs
X-Gm-Gg: AY/fxX6SgGdlScOQSa98PHZr49AfehZbRI9p/KgFpYsdFEWuUlH5MziKl3goZP7a4Q/
	q0AEJC3+MPPCYSUHPqU5XZq7F7z5RNWx53FYgBx4yqSiIa/rpzsJ9dkfRQ83BzRQmOlGr3UE+qo
	dnvD37zj3VUDKrlr1sAJSy5ZkSJdVGqovzqWZmESxSG1Mpuw6gVo76WCB/fPYfwgTkoqZi+DWQA
	aWJ/MBsJhFGQt1BOFTPnNUbNUDD6RxPlHGDSGvzEzfBkq1Y7B2Q58CeC6UDlAc2XOyh9oclQqTZ
	2GoP6U1ai1RkAshYasEo/CXMVhpxbfjZIpvOUO11IcfRs06puvaPnJn73lD39WzUQ7oMqv88KDY
	hsEAX2YMgrTZqmm6Rj+ymglFmOsHn9FOWcUmQKuOkTk05JdJvbP28emqBVua+8BuiRjPskfpaPS
	D91sJikHBaGyENZsJdto4fPnRmsFP5MJrdtUUyv5MEa7kMHJXDZzXvlDr2T1pc+TqGjBxpiqVKm
	A==
X-Google-Smtp-Source: AGHT+IFlZFMjgiDvsStkZqvxdbjcHI5mtZO0RX7CoRLkYWt7/vu6esI08DiqdmO+npuzhi414kAkog==
X-Received: by 2002:a05:7022:6722:b0:119:e56b:c73d with SMTP id a92af1059eb24-121722a761amr39576353c88.2.1767384201003;
        Fri, 02 Jan 2026 12:03:21 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm120203795c88.10.2026.01.02.12.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 12:03:20 -0800 (PST)
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
Subject: [PATCH] wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU functions
Date: Fri,  2 Jan 2026 12:03:12 -0800
Message-ID: <20260102200315.290015-4-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102200315.290015-1-zbowling@gmail.com>
References: <20260101062543.186499-1-zbowling@gmail.com>
 <20260102200315.290015-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several MCU functions dereference pointers returned by mt792x_sta_to_link()
and mt792x_vif_to_link() without checking for NULL. During MLO state
transitions, these functions can return NULL when link state is being
set up or torn down, causing kernel NULL pointer dereferences.

Add NULL checks in the following functions:

- mt7925_mcu_sta_hdr_trans_tlv(): Check mlink before dereferencing wcid
- mt7925_mcu_wtbl_update_hdr_trans(): Check mlink and mconf before use
- mt7925_mcu_sta_amsdu_tlv(): Check mlink before setting amsdu flag
- mt7925_mcu_sta_mld_tlv(): Check mconf and mlink in link iteration loop
- mt7925_mcu_sta_update(): Initialize mlink to NULL and check both
  link_sta and mlink in the ternary condition

These race conditions can occur during:
- MLO link setup/teardown
- Station add/remove operations
- Firmware command generation during state transitions

The fixes follow the pattern used in mt7996 and ath12k drivers for
similar MLO link state handling.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 mt7925/mcu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mt7925/mcu.c b/mt7925/mcu.c
index bd38807e..b9c4b99d 100644
--- a/mt7925/mcu.c
+++ b/mt7925/mcu.c
@@ -1087,6 +1087,8 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 		struct mt792x_link_sta *mlink;
 
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		if (!mlink)
+			return;
 		wcid = &mlink->wcid;
 	} else {
 		wcid = &mvif->sta.deflink.wcid;
@@ -1120,6 +1122,9 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 	mconf = mt792x_vif_to_link(mvif, link_id);
 
+	if (!mlink || !mconf)
+		return -EINVAL;
+
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
 					      &mlink->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
@@ -1741,6 +1746,8 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	amsdu->amsdu_en = true;
 
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 	mlink->wcid.amsdu = true;
 
 	switch (link_sta->agg.max_amsdu_len) {
@@ -1935,6 +1942,9 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 
 		mconf = mt792x_vif_to_link(mvif, i);
 		mlink = mt792x_sta_to_link(msta, i);
+		if (!mconf || !mlink)
+			continue;
+
 		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
 		mld->link[cnt++].bss_idx = mconf->mt76.idx;
 
@@ -2027,13 +2037,13 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt792x_sta *msta;
-	struct mt792x_link_sta *mlink;
+	struct mt792x_link_sta *mlink = NULL;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
-	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.wcid = (link_sta && mlink) ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
-- 
2.51.0


