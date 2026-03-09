Return-Path: <linux-wireless+bounces-32759-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAEvNWyKrmmqFwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32759-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:53:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C51235B1B
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 09:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D9633026897
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50EC34D4CF;
	Mon,  9 Mar 2026 08:52:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8643446A5;
	Mon,  9 Mar 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046362; cv=none; b=O3zwlnruDtlt+nnubOYbzZX8iUw1IpMHfxd5cuQdiPypX7GQEKZQuqfR2qLY1h/eFQDAEdGxDkZYN0VQn3M7n9syed03RP3QVA5ggxfX/6NQOR9J0fdlgg7EF02CmRawHN1qfo4ve7XKYWkb5Ptri6pahdOE6T5xHYPo8b0j7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046362; c=relaxed/simple;
	bh=sUF93EBDGOGMO4hB2ohXq65ZdGM3iI6RilPStFSBYIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGw4zhYw5qe4M+l7qimi0iydCTmHgEgHiyLO6ekk14AjGvzKDQYKnvOnsxBUtui+jodAt/+ZKj8xUCDaQRA+RoMtHFxjeKABCheIxo5Tnhq30QtS8b2IV1c0nJE8ow7m/F87MGZh0RBia6VSA+NKTURooYTk4P4ytLLYnEa3Ado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAC3RgpWiq5pT47xCQ--.45898S2;
	Mon, 09 Mar 2026 16:52:38 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: [PATCH] wifi: cfg80211: scope cfg80211_bss_age() to CONFIG_PM_SLEEP
Date: Mon,  9 Mar 2026 08:52:35 +0000
Message-Id: <20260309085235.718880-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3RgpWiq5pT47xCQ--.45898S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryDKr4kCw48Zw4Utw4fKrg_yoW8Ww13pr
	1rWa9rtrZ8Gr1jvr1rWryFkFyDKFs5twn3ZrZYyFyF9anrKr1rtrn8WF13Xry8ArWDXa4r
	XF1xtrWUurWqqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8NtxDUUUU
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/
X-Rspamd-Queue-Id: C9C51235B1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32759-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng.hou@isrc.iscas.ac.cn,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.448];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isrc.iscas.ac.cn:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Action: no action

In current linux.git (1954c4f01220), cfg80211_bss_age() is defined
and declared unconditionally. However, its only in-tree caller is within
wiphy_resume() in net/wireless/sysfs.c, which is already guarded by #ifdef 
CONFIG_PM_SLEEP.

Match the helper scope to its caller by wrapping the definition in
CONFIG_PM_SLEEP and providing a no-op stub in the header. This fixes the
config-scope mismatch and avoids unnecessary code inclusion when
system sleep support is disabled.

Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
---
diff --git a/net/wireless/core.h b/net/wireless/core.h
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@
 
 void cfg80211_bss_expire(struct cfg80211_registered_device *rdev);
+#ifdef CONFIG_PM_SLEEP
 void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
                       unsigned long age_secs);
+#else
+static inline void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
+				    unsigned long age_secs) { }
+#endif
 void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 				     unsigned int link,
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@
-void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
+#ifdef CONFIG_PM_SLEEP
+void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
                       unsigned long age_secs)
 {
 	struct cfg80211_internal_bss *bss;
@@
 	list_for_each_entry(bss, &rdev->bss_list, list)
 		bss->ts -= age_jiffies;
 	spin_unlock_bh(&rdev->bss_lock);
 }
+#endif
 
 void cfg80211_bss_expire(struct cfg80211_registered_device *rdev)
 {


