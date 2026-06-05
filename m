Return-Path: <linux-wireless+bounces-37404-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hrp3IrljImoCWAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37404-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 07:50:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C96454B3
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 07:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=aerlync.com header.s=google header.b=XkYZRVdq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37404-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37404-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=aerlync.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0622A301A1D2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 05:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5A3B8D4F;
	Fri,  5 Jun 2026 05:43:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AA3BB136
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 05:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638208; cv=none; b=npvCfTBzCUGn9CvDMWa41reKG9w1lzAGwWlJSxksMQHjtoqkzxLo4DbsX5GKGxEGdJPMVX2qNZvexoeMfTU8l3tA51SvW3Qayr2T4RIfiV3/JtvR+Fpp7mUcYZt2O3e67wB7BZS6O+3KxW/CGcNC2DhN/LsI2nmvnNVyAQb5sD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638208; c=relaxed/simple;
	bh=gGUvHyvzHMsGpAbJTZd2UDW79of12UPb0DK/PTb2shw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cfea+l+L2bez0eHjGoZDRRqkIfYt4+5RxKjlIHQOV/RD7lu+BLmZBv6wfL6R1PHVD0VmctiYemTZkV08zuSA/hd74fEVefWDnpDQ0LNFLjrvBaoHekacPS6ZMUltl4f2Xq0XeElyR8MVOBTgK1FtLzOvr/Z4amoEz9+bSlxZCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=XkYZRVdq reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c168baac83so7305235ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 22:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1780638206; x=1781243006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rr3uHyRr40Kradp7b17MtfEThEXSmT+CiVoEre+5jfE=;
        b=XkYZRVdqs75Ghy9l9WEoUabe8+2zdRqT8UwxFhUuSABXYRPve5Paj3/c33Fkml1lqs
         mt26QKKBfPF3jl2XI1o92J9XnppBkZBIrMbpoAx8NvqSPWYHQIZj9D8QS1k0OXYTy49c
         XvVQ4TCFWOE3C2C07hjjFcqupTUer3gH3lRxz5IAuj11FOEuVpC1FNmYj93nW2pChAkI
         ks9d4NMiHCqIQRSUhGI/CCn93nQgknZH6kwzGSzgjyjF2HDBH2r6H3ajFt+KzYnnVdI0
         rxnEc8KhHpTYOHc1l7okGELjZ7nHFG8ZJH5F7tz8q9KPW3xkpelITsp/+CjKjEBovdyj
         iruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780638206; x=1781243006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr3uHyRr40Kradp7b17MtfEThEXSmT+CiVoEre+5jfE=;
        b=OoXjddhB7CCuRfllQhmwXGQeiQ9dX9HGiFKELRmHQfyNkyVmzKskB/6ZJmX3DOLKUN
         fYVL2W/yRFL2DGZ8lRILhTdv22fw/cg+4bUnI6tz/oyJUF7PfJQYIDpzjqT3Fdu4mEqh
         VNFUcLw1NXVMGPchk+V4JMTjnlWmMiGfRRR4VmfuHzRkgU+Vb5W/B0Bk9ag9jF3rfJ8/
         UnV7CG2XxKbRVlmQOlg5tn34tjptQ52cYpvZvxKPNVwxIf6r6qAqEYzp/O7tlYnP/f2V
         tkBTzwrazkHWdpgULlbVtpF5J6XayhxGHQpN6AO7mv4WUZNirRHI5RvCfI1YyCYG7BWn
         XEZg==
X-Forwarded-Encrypted: i=1; AFNElJ8PHRVH9qYinEFUiDHHJnS2zoEI7Ft3PQ1jvnTDLOwM+qOnQasFNckaqtUFgJaKjjA5gHBDRk/DF4H7rL/pNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpxzDkUGkNglM2RCcqHasjRc786SzRAnqt/LzmFn/WgMHkYkY
	MedTrFO7jmbLOkOWusDXJVFoHlGfomGeJmkQL60OHjzvp5x+q47bV4TOPuJOn+XoVqE=
X-Gm-Gg: Acq92OHQtinM9ShKAXcRc0kSdw1Ir5KyaF8QqHmkNwmCgNYMDZFaL1LLKjaYokhbywz
	nM5XIy1a0VCzJflCzEvEJKTXKiE0j5UHvds77vwPVy8pcZLj4grdVR2jzliY56Giht+GUzcSMmz
	UyZVvfJTcdy511Bb8eQ3WzxlewipRxgSGfF3LKmCUAkXMbUha7IP9h/g6dKFppshGBLfoEtkmQC
	0q81wtwby3NFvdjqt2wxy1YVBWP3nZ4e7fiik7MdrnKWJCV363QhAkwVzAcngZ815E/OH0YYWQD
	k1Qp+cFp38fjSO4BA6Ore9EIvXE5LuIToCT0YH0gg9lQmNAsUouxhwgwMMVc4TlnK0lUI0WnYut
	gIoulgjE8uKcs511KE5lsWMUTtjmpzVyDUPPHMPs3owhTpvHlMRyXtvoAYGDP/4M3Flh+mql+8i
	8lDVvTjW8X5s7QPc7Um9EQFdAyAn2P37Unvf4hMt/13qTCOfoCNHk=
X-Received: by 2002:a17:903:2348:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2c1ee755854mr10393355ad.20.1780638206576;
        Thu, 04 Jun 2026 22:43:26 -0700 (PDT)
Received: from localhost.localdomain ([60.243.50.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8792bsm78231815ad.23.2026.06.04.22.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 22:43:25 -0700 (PDT)
From: Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
Subject: [PATCH] wifi: nl80211: Increase ie_len size to prevent truncated IEs in new peer notifications
Date: Fri,  5 Jun 2026 11:13:07 +0530
Message-ID: <20260605054307.427874-1-thiyagarajan@aerlync.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37404-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:thiyagarajan@aerlync.com,s:lists@lfdr.de];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[thiyagarajan@aerlync.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[aerlync.com:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thiyagarajan@aerlync.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,aerlync.com:mid,aerlync.com:from_mime,aerlync.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 019C96454B3

Currently, ie_len in cfg80211_notify_new_peer_candidate is defined as
1-byte field, capping the maximum IE list size at 255 bytes. When a
large beacon is received, the IE list is truncated, passing incomplete
data to wpa_supplicant. This causes supplicant to fail parsing the IEs.

Increasing the size of ie_len to allow the full length of the IE list to
be forwarded properly.

Signed-off-by: Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/nl80211.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d3639ff9c28..36af36533cac 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8445,7 +8445,7 @@ void cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
  * cfg80211 then sends a notification to userspace.
  */
 void cfg80211_notify_new_peer_candidate(struct net_device *dev,
-		const u8 *macaddr, const u8 *ie, u8 ie_len,
+		const u8 *macaddr, const u8 *ie, size_t ie_len,
 		int sig_dbm, gfp_t gfp);
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7db9cd433801..0d97a47c35fb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20958,7 +20958,7 @@ void nl80211_send_ibss_bssid(struct cfg80211_registered_device *rdev,
 }
 
 void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8 *addr,
-					const u8 *ie, u8 ie_len,
+					const u8 *ie, size_t ie_len,
 					int sig_dbm, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-- 
2.43.0


