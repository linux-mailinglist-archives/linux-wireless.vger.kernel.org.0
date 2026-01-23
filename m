Return-Path: <linux-wireless+bounces-31127-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ESwCH6K2c2ncyAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31127-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 18:57:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84BC7943D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77E7301AA4F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5126B971;
	Fri, 23 Jan 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="KiiCcHkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFF244186
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190986; cv=none; b=VVHLyhtCpnFO9oDxqWnnyk5EDMqUm6xSGtE+MSn0OZb49qgAa1n4dnYoMhWPWwinQP9lseKRM3Inwne23yFIDoH5h72SLF+wD6r6yhKWd/R3dvqrTiYf3DQOUQErcUdyJQmYISwBZsvrloz+cY4Al3ZdAzQ3uUGaOVJHte7FMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190986; c=relaxed/simple;
	bh=3s1ZvG4P3WmIZF3H5HsQvvQxalPtq1UMEG/svuL5U4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aB016TM0yzjirOEs7N54swvPZX7HBUNu83d5JOS6mXZt/dPQtcpQqSQRHJzh7DLUJ11dDCBG7gmERC+CbIbpzzqcbkopS3unPaU/Hh/L15itRbHjeZPIHzAMQLXTwp60saIx75faOiBP2wxZdLKUO8LwhWPy/HT/PvcPwf455Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=KiiCcHkc; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-66106a2f8d0so1728576eaf.2
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769190984; x=1769795784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFDEOmaGngrWuic2vWW8nkHShPa2cF6a+SEkB8r9KMU=;
        b=KiiCcHkcWLY0V1ndrwC60VIMS41gmVfgAuIlcnVOVqDaNlccgQn88sM4XP6sQEYfGH
         06NlMSgbKIwOazIZs68ONcEPsSDIZSfNAlelvZpnoe0om0Raa10Kwlftcd2I10BunFua
         U3cMFdNuMSFAnuipHJ2N7WTdyTnch734dOw86tMDMntSPg8NTbpA6eO4Fl5GS5z5Ym6J
         ETNtk/RV6lZo/oflWQkWZzXMFwqCs3GylgwaDE2NYKy4bG927ZLgZG9NQOyuyX+NZhXW
         WQoct4e6S4ZoJElsFI8osxh0/BNGcHBhdPC6bA8e2b1Ze7dJ9QsNIiiKVK9EEbnlgayY
         jEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190984; x=1769795784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFDEOmaGngrWuic2vWW8nkHShPa2cF6a+SEkB8r9KMU=;
        b=YfyEGvg+NaOwFMxl73lkg37W085fIYX5IK3ZOV7UQlYpsB/mnRWRxGzX8kcsnLcRi/
         xj6ljWTMgMfW1WYtaTjsDCxvDgWntJCyGCRul9F4rDUKYRXHxrjPE1J7nHi7F0z2NzNK
         KEGpqIQrOs6KaaHrloPboA/FtTaYOgn4FfhlOrRO4NAI+mVe8WN8zBmAgAG6xuJtICEi
         pyew6yQZLm7wRNbiJukLeVCPpkCojhE3Cy3sNzHjl37AXzo1a7d7poMiX0wojE7hxOEA
         4NdzJOkP0+L2bH69H8U2DX7pjJNktmCbuNPqFeHW2GuC6lKrXfry/YNni2UtJrtAKLE9
         BnVg==
X-Gm-Message-State: AOJu0YxBbC2Mb8BVMits7OdKPSMaUd5rOKTgFf+1fQZu4dyBHo2QTlfq
	C5/u+dTN5tM5aP4C908mOeaniesfmYl9iUuT88IvfHjWMFyjUK+lkAMl/D0XnmttYD8=
X-Gm-Gg: AZuq6aJzXbU2NUO9mo8ffnOHMDb1DwdTtsiEsNr1UTHJsPYoD2E53qPIXvMYrEcMPcs
	g8Z7usmhsv8O2MzVL83fAM9CGZHEfGWcXpDwXyiySWuSsV1ATtadXk75NNoQm5whIAzzeoiNKTW
	w6vhsh/BnOmzYYu7hpmLkjaN+eswdAMr4l3/Gki6/2aah9xxfi4Z+hd/oN4QSiLycHhtXj04w/3
	r0OSh5GtUco5VzSK50GPtPmzFvGV1LCdN/DClHhKy22sEi32WXBozOGsUPLs4No3wrD+gR/gHvh
	uZAuFJCXInB6RVMKZ201ev2CfLHNwvaOXIeGKSjqYq4iChC1JO8Tzy/2VKIy2REK1atfzWsS8ZQ
	iLnCC5OkjV2CWLEMEp/4A1oiQq8EGdQ4UFbO6mrjJjK0r7fZE8Mf0v3nWWrDa9K1YWjObeHZW+i
	zVuf6dnv8W2V+/5ys/rPMzJH/vN7IT0iDJOxnRKBe2IL9xWoV0ud79R81svybl/4Dw9Gi4JWbGj
	Tn6x3MZaTe11vECXR1RCW6DnS8W04c=
X-Received: by 2002:a05:6820:1794:b0:65f:27dd:f565 with SMTP id 006d021491bc7-662caaefbddmr1770681eaf.22.1769190979584;
        Fri, 23 Jan 2026 09:56:19 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb666c45sm1354143eaf.15.2026.01.23.09.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:56:19 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v2] wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
Date: Fri, 23 Jan 2026 17:56:11 +0000
Message-Id: <20260123175611.767731-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31127-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u-northwestern-edu.20230601.gappssmtp.com:dkim,u.northwestern.edu:mid,northwestern.edu:email]
X-Rspamd-Queue-Id: C84BC7943D
X-Rspamd-Action: no action

ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
assert that ar->data_lock should be held by the caller, but neither
ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
before calling this function.

The field arsta->peer_ps_state is documented as protected by
ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.

Add spin_lock_bh()/spin_unlock_bh() around the peer_ps_state update,
and remove the lockdep_assert_held() to be aligned with new locking,
following the pattern used by other WMI event handlers in the driver.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
v2:
 - Remove lockdep_assert_held() as suggested, since
   we are now taking the lock internally.

 drivers/net/wireless/ath/ath10k/wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index b4aad6604d6d..061a2fa8f00f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5289,7 +5289,6 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
 	struct ath10k_sta *arsta;
 	u8 peer_addr[ETH_ALEN];
 
-	lockdep_assert_held(&ar->data_lock);
 
 	ev = (struct wmi_peer_sta_ps_state_chg_event *)skb->data;
 	ether_addr_copy(peer_addr, ev->peer_macaddr.addr);
@@ -5305,7 +5304,9 @@ ath10k_wmi_event_peer_sta_ps_state_chg(struct ath10k *ar, struct sk_buff *skb)
 	}
 
 	arsta = (struct ath10k_sta *)sta->drv_priv;
+	spin_lock_bh(&ar->data_lock);
 	arsta->peer_ps_state = __le32_to_cpu(ev->peer_ps_state);
+	spin_unlock_bh(&ar->data_lock);
 
 exit:
 	rcu_read_unlock();
-- 
2.34.1


