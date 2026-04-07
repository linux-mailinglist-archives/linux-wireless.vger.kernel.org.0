Return-Path: <linux-wireless+bounces-34411-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFqJOuN21GkOuQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34411-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:15:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E09E3A95D0
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 05:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 333AD3017F8F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD69487BE;
	Tue,  7 Apr 2026 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj38qtr5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9DDDCD
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531744; cv=none; b=df8AQGO16jbi1o0vUvn5FBGcW7MwdHvGL8JkmUAqewOAkpbrM6eanBObinlWmBHXfI12Wnp4+q86pN2wzd4QqMOvsU053iGQN73A6TRwRQqxW9VGuLZTNc4NE0YHQgLCVqGMXQEd8Nvf5z0vD26i7OOB+llTqainXw9fmkkWCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531744; c=relaxed/simple;
	bh=cPmJdMJgtntW7bg8d+ueOxEFNi8V4ozpl6qDssXFCwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGr4JH3bi+1g0DeZ6QBZtul2FpUORFy3ePHhp18WFQaeM/Lwt0W0F37fkCuqA7T13S2bG3kOzQ+QRU8/+z6MY228NuQovFyGwOtEI1xadYj0WuvAZqGnbdtOZciSFOOHmTixs3XIG3SHgEIINYYSz4wimxBXW5gY5UgCFGIxGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj38qtr5; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501d242e3fso4374377d50.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 20:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775531741; x=1776136541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGG5PXDzBNAj88ocnR8MPsiM2zhqIgZiVsme9PGX4xM=;
        b=Cj38qtr543WEndgLKgK6kK31DihhdbHp7RRO5Y9vOGeoiJH2ab/VZBgEWZhKuRvzdW
         8PcexfRqN3TjBNMLLOapEGtbUY31mtUGHyn2Flr5M4i0NgyXL1+e8yUewn4tOFbU1L3V
         qvQzbBQi5VAdv+hgwtTkFWKlWr45z1nzYYjdRIJ911Ex+G2FBsjYkH+6WHGrVZiCH3GU
         pfCnF3Yc5eXAW/zNbT5vFdLdEv0Bxt1HkLWP0GOC2Y/Qldr5XsmUrXZjsEOmRK81nTD3
         X9XdxHz7Vt/ByPoH4jqgwb0nfYXoLgPlgkOE7QEYmj9Uyc9YGfXdxnDKEdNQEvIUvyVj
         iLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775531741; x=1776136541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGG5PXDzBNAj88ocnR8MPsiM2zhqIgZiVsme9PGX4xM=;
        b=VrulNcTEtV3nwEDi7ZU8hbfge/b713DZYsMLRcntCpAOWRkgUwhkomWT8OFwOwUyW7
         niDXBo9RxCt36xvkuEcA4PmK9WCHLTH8oRMzIIugjaaOssAmgOPP+ceYtkJ6g5cjnbhC
         ZSL74tqSsIXU7Os0rO85ZQpdFPVQo2mi7mP3uNlQQrPh9BnXzdJdgKUHWOAZQceQ+iax
         U2fOfsevYCwGOlPybaZJOXr8BgcVc0okD2u+I2Y4h0CGMbj9k/BHBcc5VZWa9WYCsHqn
         1x1s2DAs9Gukb7jRJ+aya/YFt+c9rS+bPLIH6wt+xJQ/7bDnf4YvoG4zxBMzzbTkglHK
         YZtg==
X-Gm-Message-State: AOJu0YzWaX0ayUhfGBCXyXMd0Dzz296ON7K3fs99m1aAwsq9FUS4cHGU
	6d96WasPONrSTdDLIAnAYYphLYEw895n9lCHX0vtZ7jXnA0v7WVeBxzjDhTJpy0s
X-Gm-Gg: AeBDieuqhlo5GsRULXckKCMq8ocBXfJ6tDiTfG3Hp1dZBI20B89FYzl/mz1AlQxf+NU
	4NqdzzoXk7RBQysnAXNfuSmSGW4alChgk5I5IY1YxlDxWaBQEkgzOY1lolyJnc7jdvWyOeBou3F
	MDP8Sov1sLzs1XpR+v4YyDdqgOZtwkD3oHd40iA0OjK+IT638xx8ro8kNJg/VTEVTa+sbDsBJwS
	VbssmyuYYb5km0K33amJmN4ORxd36JihT6QKGBaEsOh7qmEHPYID+LGmtDpFP/ee2xTA87QBg38
	O+JUiwe3UyjttFoPOdfhDPHIMR9YNcRM+IgQ3pdJrrZ5Ly6vF8k3njDfYDFSHhPquFyZ1asLgZc
	MSscCSJIQ7c7OD9kz2nfo8CNFqNHFj43i46CWCwnsA9hnIepUVWg6EBuU1k1DPkTJZyXZFHNmvg
	Zd/WsZBAYosLViefk3+LS5eHgG+XfydKQS1MYDQk5MDUosppQ/FnzMwr1LCbVP
X-Received: by 2002:a05:690c:6e84:b0:79a:1f7e:fca7 with SMTP id 00721157ae682-7a4d2ff2407mr154805437b3.12.1775531741563;
        Mon, 06 Apr 2026 20:15:41 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea27d19sm61859107b3.20.2026.04.06.20.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:15:41 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless] wifi: mt76: mt7915: move sta_poll from tx_free to mac_work
Date: Mon,  6 Apr 2026 23:15:34 -0400
Message-ID: <20260407031534.57132-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34411-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E09E3A95D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mt7915_mac_sta_poll() performs direct MMIO reads of WTBL entries for
airtime accounting, GI reporting, and RSSI. It is called from
mt7915_mac_tx_free_done(), which runs in NAPI context on every
TX-Free-Done event. The high-frequency WTBL access races with firmware
WTBL operations, causing kernel warnings and panics at
mt7915_mac_wtbl_lmac_addr, followed by MCU message timeouts and
firmware communication breakdown.

Move mt7915_mac_sta_poll() into mt7915_mac_work() at the periodic 5th
tick, under the device mutex. This reduces the access frequency from
thousands of times per second to once every ~5 seconds, serializes it
with other driver operations, and eliminates the NAPI-context WTBL
access that triggers the race.

Vendor driver analysis (mt_wifi.ko from MT7981 firmware) confirms the
vendor's TX-free handler (red_tx_free_handle) performs no WTBL reads
or station polling.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Link: https://github.com/openwrt/mt76/issues/1067
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 34a0690c5864..2f307c4caff1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -864,8 +864,6 @@ mt7915_mac_tx_free_done(struct mt7915_dev *dev,
 {
 	struct sk_buff *skb, *tmp;
 
-	mt7915_mac_sta_poll(dev);
-
 	if (wake)
 		mt76_set_tx_blocked(&dev->mt76, false);
 
@@ -2012,6 +2010,7 @@ void mt7915_mac_work(struct work_struct *work)
 	if (++mphy->mac_work_count == 5) {
 		mphy->mac_work_count = 0;
 
+		mt7915_mac_sta_poll(phy->dev);
 		mt7915_mac_update_stats(phy);
 		mt7915_mac_severe_check(phy);
 
-- 
2.43.0


