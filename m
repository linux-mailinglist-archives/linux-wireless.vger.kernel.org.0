Return-Path: <linux-wireless+bounces-31302-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNDBJjQYe2lCBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31302-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:20:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FBAD6BE
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB958303F046
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113C37BE73;
	Thu, 29 Jan 2026 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iueXKMOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B17379990
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674732; cv=none; b=qo5lgeHs7P8vZ3MuqAKAqLUxjkKRy1wl1FTg4hKqvIVz/2z02nI9DkOrZkyP6kaqZtqhBRtSwWqYJy6Hwt21ghPQQTBBb3ERJpZKNPk1+Wf8mBpxXsw2NzoBNrhdHClA8IIv5kKScP2cXH/+m5ECWcHQrZoC0TwKM4DotGs4ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674732; c=relaxed/simple;
	bh=tGrKCYWuOVVysmCKf0lksAy7dVWbeM9mIvGdn3TNHuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaG0C4TkQD55gdnAGl4n7XSWC5OviKMrkT5dScj/P+g2WlSZ8JgnExgwfNJB3aUyM4KJr6uvIgmpqsntmBNoACRSaXVrT8nBZBnf+vlyjJ2Sy/vyY1Yl/EneqNmHzY5U6jdF6vsC0fNBRAoQwRsgMw+9x+/JLJSrfq82E22XAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iueXKMOF; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so1318105c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674730; x=1770279530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDaqmz+jOzRuCeSxlUAdH2cvfPDelKI52XxXT1MsurU=;
        b=iueXKMOFR1h+Gzek9wyCB38UYhW2QnXNkJKZH3s/142R8pmKAjriNDhh03XhGwc1qe
         EU7LhW7+ahhY5gu/CyN9wngfKbTFHqamMaHc725C5zhhp7uwB5cEDC4MA6mu9suN6CNo
         xTYEx/MHahUl883h+tDZeCEHxKsW07t1ulB/o6hb32PjrodYW1U8EC/dMZisnuCKmsGL
         mBt4Aw0Knq5D2Gf194trmYsfk9CvRaDTORiAm+6TTLJu8J03UhlSOEwf+j+k7rivU6cs
         GKsxiKb3FNu9Qm9eB6xf5+0FQLUWvTRFY4NXckK5dVohuS4drM1ImmkzqipQfff7hJac
         ruAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674730; x=1770279530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDaqmz+jOzRuCeSxlUAdH2cvfPDelKI52XxXT1MsurU=;
        b=FUlcJk5WF/cufLQv4JAtjZ9134Uv5hWu41qf0QQvzPaJQVZUvbOLqnxiRWhPfUvAkr
         Dou9aiNrEfKJdNU3JkSGu17tHwi4YvNwUF5z4cKhDxTopzI+9FYAXHUlWY2SP3P34vLA
         mpUZIngb+k42wB/jF+ZDFUTmdrFLJSjOI0T/8orkBN6vI0VuD4ijKDjuRpwe4HxlL6Oo
         x2xjIMnaX04icqH3BX6JAaddcUG7r5xItgMxq1xXBtHPKF9aDdNzUTh+ENie9onGccAN
         7udXhApm0250/R48qt72T2OX6WR6rrG2neuG+4mvCXJafPb+EuYbvdVt6e+aa/l2//ZO
         I5Og==
X-Forwarded-Encrypted: i=1; AJvYcCWwqUeq6kVNTcONRHhe8dnF8QbAAOYXfhG2yxpbcxy5aCldfEsEn9C3mGRBvA0JlxT7k2DWrmREZ5mffxLlGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+Nl0Nyf/HEXabg+4qjMql9tlIUmCKYosYsqAufZ4p3ExReWy
	9XCsL57u/b+aZqibl6SbjIjCOTR+8LTJL+8Q/IDNwEDF041c5Fo7tp0A
X-Gm-Gg: AZuq6aInEA7HubuWQf+qbfI16yAlKv/flqtGw3vuq4DLFp9xSI1g5rpEqbynr2Kd6AN
	kB8avv3uCzq9hw+Cno4WNqNo7vcO+rwWNZStt5Zt94vRYfEHNAivNjbgp3D83E/Ikx+zi9Uf81G
	aPh3cDFUjUx6YjMmzJrKyl6X63P9z8SPhqQY+lYCm4ro7XqwI/aGoz7GY5EQF80/X8beQGNo3j4
	11pr3mZeGKmycKjWN4LUUuJAVr0yXQNqKTVySOlLQ+ESjnw13KHatxtvakVCalQRdg8+8jXcb5d
	az14kx906CBzLYW+sUJ5yM/30ItNDmpsLI0qZ1E+U79ukJuvYZrk1x2eWwzVnKl6osBO9UBioCi
	T5/Xp9aEWOiMgFOxjswRMuBWkaMy91BPcVK/pVU6Ry0QX0rtEnp8sFOMrnXPgbUxMz5tKbdKc4B
	RSH/42fB8Keh9BVRHUuFQ/jk3VweKZpYwLXy+I7L6jzYucUIGOIaMMn3CIwecY99T5MGBfA7k=
X-Received: by 2002:a05:7022:e0e:b0:11e:70d8:5dbb with SMTP id a92af1059eb24-124a005f9damr4371735c88.7.1769674730326;
        Thu, 29 Jan 2026 00:18:50 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm5483508c88.16.2026.01.29.00.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:18:49 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v7 3/6] wifi: mt76: mt7925: add mutex protection in critical paths
Date: Thu, 29 Jan 2026 00:18:36 -0800
Message-ID: <20260129081839.179709-4-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129081839.179709-1-zac@zacbowling.com>
References: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
 <20260129081839.179709-1-zac@zacbowling.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31302-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zacbowling.com:mid,zacbowling.com:email]
X-Rspamd-Queue-Id: 0D1FBAD6BE
X-Rspamd-Action: no action

Add proper mutex protection for mt7925 driver operations that access
hardware state without proper synchronization. This fixes race conditions
that can cause system instability during power management and recovery.

Fixes:

1. mac.c: mt7925_mac_reset_work()
   - Wrap ieee80211_iterate_active_interfaces() with mt792x_mutex
   - The vif_connect_iter callback accesses hardware state

2. main.c: mt7925_set_runtime_pm()
   - Add mutex protection around ieee80211_iterate_active_interfaces()
   - Runtime PM can race with other operations

These protections ensure consistent hardware state access during power
management transitions and recovery operations.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index f1f0bc9eab04..88cf214ab452 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1330,9 +1330,11 @@ void mt7925_mac_reset_work(struct work_struct *work)
 	dev->hw_full_reset = false;
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_vif_connect_iter, NULL);
+	mt792x_mutex_release(dev);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 
 	mt7925_regd_change(&dev->phy, "00");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 88ee90709b75..82de6f30ec27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -770,9 +770,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
 }
-- 
2.52.0


