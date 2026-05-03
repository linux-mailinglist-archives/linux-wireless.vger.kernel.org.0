Return-Path: <linux-wireless+bounces-35775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2gMoJvSa9mlxWwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 02:46:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1204B3E48
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 02:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 335CB3001FAC
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0037D18D658;
	Sun,  3 May 2026 00:46:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA51E4AF
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769198; cv=none; b=XYCd6tHzz+IBKZXrd9FozEXNpnMfRW6hhFz3OT0NYIDnawEIOnoFDJZh6YztRabTxgsdJy8qzf30qz+GHsq+McqFHEuSrQ1CsANTxXnHin/lFJOHSxg2TYnje/OCKmTeVpZqgJR9t6rwiDOx2On3ULX58jlRm4RxQm43tyf22rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769198; c=relaxed/simple;
	bh=AgGNIcoP8ETojL2ZD5BOVF+o2AyLdJmsHs1V68TjKQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSf0nvYhKWq3rmYuSAA1XGn6mEdKwfTHmh+e+8CvpbpsOquFkPuG3pD5HCdS+vcVhvMczmkQCWZsyddKhCa0/rMKF7mn7tmsp6lZx+sAjobNPqpBsOymi++LPWMzA6z5nwAaPNWS1ZAaXyp2IdT3ZchrhkJBFE+NRuwOWXvxSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7de431da8fbso2791611a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 17:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777769196; x=1778373996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eap8RnFDVR20sEEA+o+PI5j6JhdG1y2nOoY00DgIrcI=;
        b=qGNG+1l9O1tda43jSo8nOSZkFWPrOo69pkgfLrGI/46Uo02O/V3gHNKmd828OIeWn0
         FuO+xItwpblyZm61tABG21XRUPizpq9yYLzluxf6KiY6Wo2Zy81jXhbuJZk5bID2Of+0
         iOaj7ctUMNTbMbzs1X6ZZ4HrBCUKjhe1RYXxdJVs1pJRFM8lqEZ3R5lguQ4L3iBMVZWd
         vLT54msYv8tMthhHuyFVsX8F8BT536zWpJRu5W395TNXKD29v0RNzzwt7H7sJSThj49E
         ExRZBJUpkgRa0cFa4d1NWlKWq28O44QDXk2qzJ57l0EBmZ1eH3389E3guAJdaBA/HbBL
         ho4w==
X-Gm-Message-State: AOJu0Yy+oVQQzIk7MX0XhWm4Ug5EkJTvIsE4NrpqAFxR5il0xtUWF8e/
	sAYfNYb0YyChIs08JSGOYG17kzC2WL8bucYUa1bE26m/USK0WdDeMbl6
X-Gm-Gg: AeBDieu5TOKHx94o0I8nu/gRMvV5bkPnnCuibwi/tiJjsQpMdsf7tNSnYYPmr13ko/t
	z3q619runh2yhCAPGW/vUvJNiuKi5u34J5U5YEF/bNKYxLUqJiUD3rnWavX06WPaIPOh6Q2m4PH
	irCpZeTcfPgF+1Av561f7dutFUzYQfqqmevB256/5/XEpfMXqIwKOB97U6AiR65QOvIL2++2g7x
	3to8Nn7mqOOPoRneF4fdhM7k7lyI115x+quL+ElVdAQ8saGR/G4jm8Ws83iVPqKI1o5MSWw6VE7
	+lwW8H2BVTiPFno61crhqe42X8f8wMGhHy9ZMQerowyrtBE9HKkwtc9swS8iiRj9SI5nDtJ2fuk
	9XgUn5C8t9S0W2BgmPt2U9iPj11BplHvLbZe10VnQVVzfwcASlukcgYgdJPocyEltYTcvaEYlgv
	J6tBYWu8Xc5P/o8dKfBJGFoaH04n/S3XkU2wlK3oymHBZHPOF15hAnbpMadAvO68MDvhDcPw0QZ
	eIimIzeAjGR1VL8PrQbqBso735csxcuHiu9sOOZLo1CiCRXmd//0Q==
X-Received: by 2002:a05:6830:3913:b0:7dc:e1e6:7687 with SMTP id 46e09a7af769-7dee12af86emr2958954a34.4.1777769196312;
        Sat, 02 May 2026 17:46:36 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (65-36-108-159.dyn.grandenetworks.net. [65.36.108.159])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca80d5b7sm5048838a34.9.2026.05.02.17.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:46:35 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Bongani Hlope <developer@hlope.org.za>
Subject: [PATCH] wifi: mt76: mt792x: fix NULL dereference during CSA beacon handling
Date: Sat,  2 May 2026 19:46:13 -0500
Message-ID: <20260503004613.17903-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E1204B3E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35775-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

mac80211 may call channel_switch_rx_beacon() while CSA is active, but
mt76's cached dev->new_ctx is not guaranteed to be valid at that point.

Avoid dereferencing dev->new_ctx when the target channel context is not
available and leave the existing CSA timer unchanged.

kernel: Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
kernel: RIP: 0010:mt7921_channel_switch_rx_beacon+0x1f/0x100
[mt7921_common]
kernel: RAX: 0000000000000000
kernel: CR2: 0000000000000000
kernel: Call Trace:
kernel:  <TASK>
kernel:  ieee80211_sta_process_chanswitch+0x67c/0xee0 [mac80211]
kernel:  ieee80211_rx_mgmt_beacon+0x842/0x22a0 [mac80211]
kernel:  ieee80211_sta_rx_queued_mgmt+0xa7/0xbb0 [mac80211]
kernel:  ieee80211_iface_work+0x62e/0x890 [mac80211]
kernel:  cfg80211_wiphy_work+0x1ee/0x280 [cfg80211]
kernel:  process_scheduled_works+0x180/0x680
kernel:  worker_thread+0x1aa/0x450
kernel:  kthread+0x181/0x1e0
kernel:  ret_from_fork+0x405/0x600
kernel:  ret_from_fork_asm+0x11/0x20
kernel:  </TASK>
kernel: CR2: 0000000000000000
kernel: ---[ end trace 0000000000000000 ]---

mt7925 has the same unsafe dev->new_ctx dereference in its CSA beacon
handling path, so guard both drivers against the missing target channel
context and leave the existing CSA timer unchanged.

Reported-by: Bongani Hlope <developer@hlope.org.za>
Closes: https://lore.kernel.org/linux-wireless/20260502140616.7672da98@bongani-mini.home.org.za/
Fixes: 8aa2f59260eb ("wifi: mt76: mt7921: introduce CSA support")
Fixes: 7900da40e315 ("wifi: mt76: mt7925: introduce CSA support in non-MLO mode")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3d74fabe7408..a326f4c95c7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1508,6 +1508,9 @@ static void mt7921_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	u16 beacon_interval = vif->bss_conf.beacon_int;
 
+	if (!dev->new_ctx)
+		return;
+
 	if (cfg80211_chandef_identical(&chsw->chandef,
 				       &dev->new_ctx->def) &&
 				       chsw->count) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 73d3722739d0..b96a8e2efcbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2402,6 +2402,9 @@ static void mt7925_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 
 	beacon_interval = vif->bss_conf.beacon_int;
 
+	if (!dev->new_ctx)
+		return;
+
 	if (cfg80211_chandef_identical(&chsw->chandef,
 				       &dev->new_ctx->def) &&
 				       chsw->count) {
-- 
2.43.0


