Return-Path: <linux-wireless+bounces-38838-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9IKPLhldUGrexQIAu9opvQ
	(envelope-from <linux-wireless+bounces-38838-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 04:46:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5495A736C33
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 04:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZMmDUN+Y;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38838-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38838-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3F873018300
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E048356A12;
	Fri, 10 Jul 2026 02:46:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF33546FB
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 02:46:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651608; cv=none; b=ObmUVgzdub+DadpCxuzGEpiViM3hsxWC/0W9VdHYKCkf3/GX36WwtOl8WLcstw+KPOmUYOlvYRImdMhcdkRntgXUjhVbn2SG4HuqdnZUJow73DvzPZmhUIngSBwpovNeA+zIJsrPaJbnDbFI/Y7O/ykVf5S1R4VAGlS0xpB330Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651608; c=relaxed/simple;
	bh=hff1wBVxc+gdsbYSnkjITjhgAaQ4xxf4qNCiI5XxoLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hiyhll/1+1yZ8h20VBcccwF7UAsNy3mcCnR6NCP4nCKbc/zh5kP5Hr6b5IwL13BKLABMv9LL1PLUnbl0a+00oq/qpq7Tt6JOIP+6aUrvOymWkBbYCY3AI41943oGZGtwdW3yPAKwJHa7iQJDpuAqCzteQmVEL23SPGniFqKM2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMmDUN+Y; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caea3f742bso4515945ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783651605; x=1784256405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1+uIdIPwFYA1yAM1+Wp/SLlMmUj3NwLN29QZ9tDSmS8=;
        b=ZMmDUN+Y/8io2PiYyaC2vGiYxd4k6+6MEttjtBZ7dNiTiEfAcvZY6tEW7S92FbNwwj
         GKzxmtKLIYbSG7+9IKfGpOeSBIVEFidtVbyKsa6bWvcaTXzo9WlF8CBNJQu3bQsaMNy+
         7fJ2HT55tToiznC8TIqJ38BARc2VjVfutBaJJ2JxahQItNBBKH0bLjZF5eXe1BmLBUkA
         IWX62ECl/w9V/B1nk4zCilfIkXBRDYDt10y/XkT3MrSR8qwkLtbOjDa72bR02YH27g6k
         uYWg+xmbSXBb9Cx5NrxQ8AUQwDWjNri2hNd0YKgxjf7OY3qVxERqgCh9dntfnfsmRX+3
         Xmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651605; x=1784256405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+uIdIPwFYA1yAM1+Wp/SLlMmUj3NwLN29QZ9tDSmS8=;
        b=jkCSWdY4K0q4BYP7QGpfSe1zeunjWJ3l6BLDSwaTiOkgs1uCnUDOnNd66P2AGgIQAd
         uGzQfgxL+lB/d1n8+MMbu2ObDyNpWyBE4giAE4Imq1WKbTJALeTAYgm2RDlKLEhoBkM0
         CxkMiDcnvqHkMqk4BV0pGW3LUlOKgBGBO/fos8zjvwzrE7pps/I0+1k0Sg0kF6slteVC
         Ibd+2E2CYFzgWBQe0WhWl6JSWT6xeSo+E21mnmf6p/OE04ScNScgHjDMxfFCGgFic9T4
         7DOH8G7VL5bq8q4no7nOiy4osJnT9/7+ecMFzVyQTwLYdopCSOIqXzX1eeNvMRgBxt+v
         tjog==
X-Gm-Message-State: AOJu0YzX7dK6qAd5ghtMF4/75YIWGpmnshJu5Id8AiFewr4Aw5G0BYX5
	9IQeY+EoiRAPLV1jdwDngr+5vWbyTTmnlT6gKS7cpwlapD2rPZ3m4HO2IrKzEA==
X-Gm-Gg: AfdE7clMD8G+8GHjFXGY6iBbq+U/16DL0DYKFo36RZI0ZzGzppDteykTC9pgPV8tha3
	QKiPN88+JsRR0os2Ws766bAs1rUToK8ROJn8Q44BMMce3H1KHJfRr0h362K/xNFQqGfIxOdn05r
	Z4SdDzkMvsOtWPKcGIzXBAxUVJ3E3P8X8+gNEeFSmo1UOtMJNHOvOIvZ6s6NbVbv4RtpQfwFCIC
	7gTqtHHzYTL4fnmkYIGiZ0nZfUUeDoeYQPcnMrOPF6vjUzdAUa2Nj0A+Y8YlGRriF4xMfDNhyHc
	r0rc04bFBstcDvX5r1vk4lhTxuv1fe+3j0tu1QD5NCq3mikvgaLkIbu/Jh/yOZfmmwk2KWSVrJA
	iKJkYtqh3ohmJ7JH4ss9oG9+gW8CFjdLb8D14umEv4J4T0pw9JDND/sMoUVI7Tq1/87H7v8aeVB
	U70qc0Oj6xWSoY5mBpkKJpZx6u78m2wKK9KEouDFUQJp37e5uYyzA9gE7YZZelNkZbHjVx
X-Received: by 2002:a05:6a21:496:b0:3bf:b9de:854d with SMTP id adf61e73a8af0-3c0bcc6a209mr11900481637.23.1783651604784;
        Thu, 09 Jul 2026 19:46:44 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:4ec4:3b70:556f:d77f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119d5cf176sm13391345eec.12.2026.07.09.19.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:46:44 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com
Subject: [PATCH] wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()
Date: Fri, 10 Jul 2026 08:16:37 +0530
Message-ID: <20260710024637.16729-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38838-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kartikey406@gmail.com,m:syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,cc867e537e4bd36f69bb];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5495A736C33

Syzkaller reported a KASAN slab-out-of-bounds read in skip_ie()
and a fortify memcpy panic in cfg80211_sme_get_conn_ies().

The KASAN allocation trace shows that a malformed IE buffer is
stored via SIOCSIWGENIE (cfg80211_wext_siwgenie()) without any
validation. The crash trace shows that a subsequent SIOCSIWESSID
triggers a connection attempt which calls cfg80211_sme_get_conn_ies()
to process the stored IE buffer, causing:

 - An out-of-bounds read in skip_ie() which reads ies[pos+1]
   (the length byte) past the end of the 1-byte buffer.

 - An integer underflow in the memcpy size argument when offs
   returned by ieee80211_ie_split() exceeds ies_len, causing
   unsigned subtraction to wrap to SIZE_MAX and triggering a
   fortify panic.

Fix this by validating the IE buffer in cfg80211_wext_siwgenie()
before storing it. Add cfg80211_validate_ies() which walks the
buffer and verifies every element has at least 2 bytes (type +
length) and sufficient data bytes as indicated by its length
field. Return -EINVAL if validation fails.

Reported-by: syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cc867e537e4bd36f69bb
Tested-by: syzbot+cc867e537e4bd36f69bb@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 include/net/cfg80211.h  |  1 +
 net/wireless/util.c     | 16 ++++++++++++++++
 net/wireless/wext-sme.c |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8188ad200de5..32cef926f8a4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10992,4 +10992,5 @@ void cfg80211_incumbent_signal_notify(struct wiphy *wiphy,
 				      u32 signal_interference_bitmap,
 				      gfp_t gfp);
 
+bool cfg80211_validate_ies(const u8 *ies, size_t ies_len);
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 24527bf321b2..a685020c8efc 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -3083,3 +3083,19 @@ bool cfg80211_wdev_channel_allowed(struct wireless_dev *wdev,
 	return false;
 }
 EXPORT_SYMBOL(cfg80211_wdev_channel_allowed);
+
+bool cfg80211_validate_ies(const u8 *ies, size_t ies_len)
+{
+	size_t pos = 0;
+
+	while (pos < ies_len) {
+		if (pos + 2 > ies_len)
+			return false;
+		if (pos + 2 + ies[pos + 1] > ies_len)
+			return false;
+		pos += 2 + ies[pos + 1];
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(cfg80211_validate_ies);
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index 573b6b15a446..3e9b071f6d66 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -319,6 +319,8 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 		return 0;
 
 	if (ie_len) {
+		if (!cfg80211_validate_ies(extra, ie_len))
+			return -EINVAL;
 		ie = kmemdup(extra, ie_len, GFP_KERNEL);
 		if (!ie)
 			return -ENOMEM;
-- 
2.43.0


