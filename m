Return-Path: <linux-wireless+bounces-34648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBXBJfX32WncxQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:27:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C02883DEADC
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 929343040468
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 07:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB3330D23;
	Sat, 11 Apr 2026 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vt0Fd6qz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6C2E6CAB
	for <linux-wireless@vger.kernel.org>; Sat, 11 Apr 2026 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892324; cv=none; b=ZTHDcudKgxWf/Q4vecoUeLNRnMLvT3SLvqY+l0B+wklUzxBwqem+u4hd9cUVMI7rPAfl7rUhVrkhPbzVb+NTtMaOwg/miryuNXv6dobiCJIgdkfGoiFdGeGJW8b+Y+14gh7wq+8VsNQoER+mOM5jRS4iiX6eyOtzsAe2GY1Y+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892324; c=relaxed/simple;
	bh=jgRNKutRprqwiPczqy5Dd9x8XPe1sik/sNaao4p1Pw8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gXko4GC5y+Os6Hg0hICGOBhDudRTUCrE6TMNyyqd4o8OoDQC6o4a9yZbNKNXvL4zhxPl/vEhNtavqt7/Ppr3nY9TS6RJdyL7WpuB9wcfaPL6VDrhY25MSzpIHbWf0En6eMcP9OTSJB2Z/sCqyVD6+h9ifz+BAi/v4CKML+5exHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vt0Fd6qz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63B7PExiC164892, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775892314; bh=wFElcvs8918T5kFRDUcTNiXpjaOVOfvW9uAzbVF0hjg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vt0Fd6qzXRMqh6pli0lGHwyvnYAhv2g2qmxDvKyYhjXGvmHU5Gi6vSW3bYLSOuYAa
	 5+RWVE3/CkZUiMFu+wTWiNp0UGteMUiUxoN2jpIN7VUl0sjSjUrp61E68HZ+1DNTRB
	 x/BSv+DZYSackwBZkxjuRKzzEj0Nroc2LBhLX19bQm/D8zZlPBEZb5IseU9CnZUXlK
	 OKYknYV3JHSFebYQEtxHlZA6j/J45aYHmY2qlyNQsVpJ83jEVHVGaHpTr2rQjxY8nw
	 a/xe8ZlD6hkZgTlaDObJr9JSDI+uqcEmc/qz3CzWyZmCXHmIJXq3O7xJ3pzruRXD5L
	 gVnyiauDQH8dg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63B7PExiC164892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 15:25:14 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 11 Apr 2026 15:25:10 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 11 Apr 2026 15:25:10 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 11 Apr 2026 15:25:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH wireless-next] wifi: mac80211: add __packed to union members of struct ieee80211_rx_status
Date: Sat, 11 Apr 2026 15:25:09 +0800
Message-ID: <20260411072509.1556635-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34648-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C02883DEADC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The arm-linux-gnueabi-gcc compiler, align the field followed by union
members, causing size of struct ieee80211_rx_status over skb->cb
(48 bytes). By investigation, the union member starts at offset 32,
and the offset of next field rate_idx is 36 instead of expected 33, and
the total size is (unexpected) 52.

When compiling rtw88 driver, it throws:

In file included from /work/linux-src/linux-stable/include/linux/string.h:386,
                 from /work/linux-src/linux-stable/include/linux/bitmap.h:13,
                 from /work/linux-src/linux-stable/include/linux/cpumask.h:11,
                 from /work/linux-src/linux-stable/include/linux/smp.h:13,
                 from /work/linux-src/linux-stable/include/linux/lockdep.h:14,
                 from /work/linux-src/linux-stable/include/linux/mutex.h:17,
                 from /work/linux-src/linux-stable/include/linux/kernfs.h:11,
                 from /work/linux-src/linux-stable/include/linux/sysfs.h:16,
                 from /work/linux-src/linux-stable/include/linux/kobject.h:20,
                 from /work/linux-src/linux-stable/include/linux/dmi.h:6,
                 from pci.c:5:
In function 'fortify_memcpy_chk',
    inlined from 'rtw_pci_rx_napi.constprop' at pci.c:1095:4:
/work/linux-src/linux-stable/include/linux/fortify-string.h:569:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  569 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After this patch, the size of struct ieee80211_rx_status is 48.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Because of size assertion of rtw88's efuse map [1], I found
arm-linux-gnueabi-gcc compiler throws this warning, but x86 gcc is absolutely
silent and expected without this patch.

[1] https://lore.kernel.org/linux-wireless/7c65e315-5a2e-455e-87ee-8fc6d60ed807@gmail.com/T/#m43fdf8a1c2b8cff92c1ef50faab7993522647162
---
 include/net/mac80211.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 40cb20d9309c..02318a4be0e1 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1747,18 +1747,18 @@ struct ieee80211_rx_status {
 			u8 he_ru:3;
 			u8 he_gi:2;
 			u8 he_dcm:1;
-		};
+		} __packed;
 		struct {
 			u8 ru:4;
 			u8 gi:2;
-		} eht;
+		} __packed eht;
 		struct {
 			u8 ru:4;
 			u8 gi:2;
 			u8 elr:1;
 			u8 im:1;
-		} uhr;
-	};
+		} __packed uhr;
+	} __packed;
 	u8 rate_idx;
 	u8 nss;
 	u8 rx_flags;
@@ -1771,6 +1771,8 @@ struct ieee80211_rx_status {
 	u8 link_valid:1, link_id:4;
 };
 
+static_assert(sizeof(struct ieee80211_rx_status) <= sizeof_field(struct sk_buff, cb));
+
 static inline u32
 ieee80211_rx_status_to_khz(struct ieee80211_rx_status *rx_status)
 {
-- 
2.25.1


