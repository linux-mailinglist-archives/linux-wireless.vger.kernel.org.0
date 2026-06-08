Return-Path: <linux-wireless+bounces-37529-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JqE/EGfFJmpKkQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37529-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:36:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FAE656B45
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:36:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=aEUXI96G;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37529-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37529-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044D1303CFB6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF1B377011;
	Mon,  8 Jun 2026 13:32:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DA34AB0B
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:32:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925545; cv=none; b=YRSfgu6vv5vwhtdNJuQ34YqiwLaB6W2uT2GXGcfQKkT4ITLHAiKGFCf8M5mXKNqNsior6mk2z0LcVCj1UiYD6KgZlNjg3K3o+15nkA/RcOv5/QyETh7TCgdkdSXR1IiFfBr+GwJkLnuqFHcAFctrnVfUlEcCfcYVhQ9sYJYaOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925545; c=relaxed/simple;
	bh=zznIaWIb2kn7FFAybqoU2YhmCdczMn2HoA1qIP+QoRs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nwiomr49PbZUbfbxKHPGXcTV1QKeUFX5a4w+ioTeDDecpB/judyI5QRnOHd6UjDALZXrKiSXhxqeo8JUXafRde4WkWu7OaYhOYAAfR+gBcFEC/1K19XVRN9YWnKcshn3rjoM72dsv7/6RCJqNIljS68Mzdv0eBnYOlh64FeY9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEUXI96G; arc=none smtp.client-ip=74.125.82.202
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074797dfa9so5922661eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780925543; x=1781530343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQrWfCUPb/iGFsQSPTg8c/hZ3vsvBFETCZvhQuNvMPE=;
        b=aEUXI96GU/9ERoEQSoNXGb1y35zSOP9KeR27C5aD0+v1gxPGV9NpeiWk/ykOd9Ludl
         ruNcNA4rsUTUJpp0UlCkNTVrHdl8lWUxaLrK64dWVbG8mEVc5bIBasjUdKyRZf9KZiA0
         eDkJDbsghIYSonxGb4VyyhyHc/Cpxk/RrBHbgtANE9tzumzBCYAmkg2CNuowmz1ppA6Q
         Aq44ZQVfkinjEPegZSooBLpTUkGLwBy2Mvz+sHsfvmc+LOsCr57+PFdo5/23aieeJiGI
         BnFwta3K5cKKGw4p8XLfvTtJgAQY+W5M3lIj7YohC41ZZKjTxP5GZQzCxuZNDbVWRapg
         tEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925543; x=1781530343;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQrWfCUPb/iGFsQSPTg8c/hZ3vsvBFETCZvhQuNvMPE=;
        b=hl2uFRJdirGNcZUJ+xyhu9iGF6VubWJh2HMwrroKO/tgav6Y7x8i3qeRJ5xybvmEtV
         E+nndtBTEN6zi+FmAJARFAmcUILgFplldveuoKrxs+enIf87Y8ne6jXPQL4uVD5MAPT8
         99whl4lf8IoGtHUOEVzy5h3Js75XeOox11fH/spAkLQR7COD6/eHBSoz8DmNoBJMqazh
         5h3htfYbLm+u492Zyrvih+w2FJlmz7h/lbGmRVfU3JxxpZq5Q/vz8eDaXNSQBFrQMGgR
         jajD5m6Ewg+0dieVIArC0B9UMWlixHFbP9GQZVtMb9o45aDn7lHZxlcj/xHf3V3atOKD
         CJEA==
X-Forwarded-Encrypted: i=1; AFNElJ978mi+8aKEPWDDMlMRzgMKviKfGTBW6I37r5EANN1i9VVDRq2spy4K1Hk5lj3BjcAu4hF77wBuYum2DLnA0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwokEjv0SZIrUzp2yb+1g3h+KvS9De7UJZOmK2ZEl+ytj7h/DS+
	XhkhrdbBVxlH4bsdNYUVOn2nnYLOY4BSufUIRG1L7+wPgGw9PqGXvegcW9gfELympOhGvhz9Sl3
	wy8qnqOUe3uIw5A==
X-Received: from dycqa4.prod.google.com ([2002:a05:7300:fe44:b0:304:1e27:a62f])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:168e:b0:304:630d:e4ec with SMTP id 5a478bee46e88-3077b272073mr8681528eec.28.1780925542521;
 Mon, 08 Jun 2026 06:32:22 -0700 (PDT)
Date: Mon,  8 Jun 2026 13:32:16 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260608133216.1396790-1-cmllamas@google.com>
Subject: [PATCH 6.12.y] wifi: remove zero-length arrays
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: yichenyu@google.com, kernel-team@android.com, 
	Johannes Berg <johannes.berg@intel.com>, 
	syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com, 
	Carlos Llamas <cmllamas@google.com>, Lachlan Hodges <lachlan.hodges@morsemicro.com>, 
	"open list:802.11 (including CFG80211/NL80211)" <linux-wireless@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37529-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:yichenyu@google.com,m:kernel-team@android.com,m:johannes.berg@intel.com,m:syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com,m:cmllamas@google.com,m:lachlan.hodges@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,fd222bb38e916df26fa4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1FAE656B45

From: Johannes Berg <johannes.berg@intel.com>

commit a85b8544d46390469b6ca72d6bfd3ecb7be985ff upstream.

All of these are really meant to be variable-length, and
in the case of s1g_beacon it's actually accessed. Make that
one in particular, and a couple of others (that aren't used
as arrays now), actually variable.

Reported-by: syzbot+fd222bb38e916df26fa4@syzkaller.appspotmail.com
Fixes: 1e1f706fc2ce ("wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements")
Link: https://patch.msgid.link/20250614003037.a3e82e882251.I2e8b58e56ff2a9f8b06c66f036578b7c1d4e4685@changeid
Change-Id: I699f1aaaf11005b45a189bfe164e65c5e2c8a6ce
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/linux/ieee80211.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index abb069aa5fa5..85bf3ac6db57 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1266,7 +1266,7 @@ struct ieee80211_ext {
 			u8 sa[ETH_ALEN];
 			__le32 timestamp;
 			u8 change_seq;
-			u8 variable[0];
+			u8 variable[];
 		} __packed s1g_beacon;
 	} u;
 } __packed __aligned(2);
@@ -1522,7 +1522,7 @@ struct ieee80211_mgmt {
 					u8 action_code;
 					u8 dialog_token;
 					__le16 capability;
-					u8 variable[0];
+					u8 variable[];
 				} __packed tdls_discover_resp;
 				struct {
 					u8 action_code;
@@ -1690,35 +1690,35 @@ struct ieee80211_tdls_data {
 		struct {
 			u8 dialog_token;
 			__le16 capability;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_req;
 		struct {
 			__le16 status_code;
 			u8 dialog_token;
 			__le16 capability;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_resp;
 		struct {
 			__le16 status_code;
 			u8 dialog_token;
-			u8 variable[0];
+			u8 variable[];
 		} __packed setup_cfm;
 		struct {
 			__le16 reason_code;
-			u8 variable[0];
+			u8 variable[];
 		} __packed teardown;
 		struct {
 			u8 dialog_token;
-			u8 variable[0];
+			u8 variable[];
 		} __packed discover_req;
 		struct {
 			u8 target_channel;
 			u8 oper_class;
-			u8 variable[0];
+			u8 variable[];
 		} __packed chan_switch_req;
 		struct {
 			__le16 status_code;
-			u8 variable[0];
+			u8 variable[];
 		} __packed chan_switch_resp;
 	} u;
 } __packed;
-- 
2.54.0.1032.g2f8565e1d1-goog


