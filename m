Return-Path: <linux-wireless+bounces-37010-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEQQMwbzFmo3yQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37010-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 15:35:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF795E5092
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A65B4302D0C5
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FAB40FDAD;
	Wed, 27 May 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqgTVytt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59873410D0F
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888845; cv=none; b=Ddn+Ufudhd+RukowHHdmrC6Ii+r18bGzPkaCKFGLtJxL9y5UK7t/3QJV2w4okBT8yttVTB9gu8So5DhpsTwM+iRNdC/HHyQtfTh7Ik3xRGMoMapjQcPBHGVege9O5soUTdrMiCXBGEumHPOLSrJk9FrKCps/ht02AQ6SpvD3vSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888845; c=relaxed/simple;
	bh=kJg3+vkC/Ksj70rm3U6aG5YJmh840dLCu0pSDSlzRp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oxeq0RkelTtyxGJhQ2EGJP3DHN1Vw2K1cd4LBhb8NVlOImVa0eB4L+Zha08osha4iJij8FHX7lw7IGnPH8ldcuLbLdzZNSWb7dtI3t8m9OQckdWr2B1E+xLxrIfbv1p3yng4GGEUCDrC8rcNlwFJAAqnQ/IeYbetCmqAyzP51OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqgTVytt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bea7176c72so49677095ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779888844; x=1780493644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbFhjouUY/ThE/xIFttbuPkaPlFmLqofLr8oFQGobyg=;
        b=MqgTVyttUgIDr2xKAwZB5dt4x4xbu46UEPJtCDOogBJXtu5fXCBFtnjpYbtQ0c4+gZ
         Cw2/4rQoIW6hAE1XWUvyk0iNRrvF4SNN63ch3t9FB/Koe+PTL4vzGw7m6DcPrxPtqXXn
         kbGyWFFlwReU91kzrbnolDImOj+7dFOWCkWDye9N3xoc1Lg/LPqnObhpcwjYimEjKrNr
         CvmTQ7lboQRili9EOVhQbJbDtyIHCHmUUKrs468cXjmVewK3ZuxTrdR1j5isRbgj/NVq
         N8CwiymlT8tX68q4oCX3lM92oNcJ6ZfIyQStcnVN4f2rLSS4kGk488/mjef5OAR6NeUi
         5pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779888844; x=1780493644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbFhjouUY/ThE/xIFttbuPkaPlFmLqofLr8oFQGobyg=;
        b=Y+ZsIBl5ZePxYpgbrN5JVrIWDvaQGnkhl/MXXxxjwOBVzYtDdbVtPwC1sCXMw6Y/DU
         W/+vP28CAq4rAWxaGvKvt+Lt+zSi3DpGoODuQqwReNugI3zZIZ7mDdwh7e+qTBaeMfG/
         tTuoOzm/C98GyosWVsXOrfY5gBCmiv1csNAbBMlZ9H+eYG1JDa2ZBJGk9awGwG8M0CXe
         hWASZyW/hDo7T8nD/0z5Na6wRFjwmm9fmdevYCEfv/xXH/MAC8MDBEf92v34hlinYxqV
         cLpXGS20hiA+gQBzA+g+7QGsRwzlNY0LY9AYGDwCoZ0dAEDM7ArDkbGjmxdb5wOOgZLI
         1x0g==
X-Gm-Message-State: AOJu0YzTvKQ0XvRC+vJsFeZKRoudxTAvUJfha4w4AV9orXaF+XylAvoC
	3gS/gKBCcrLC/Z7r8b9aiUnyG4SuL2pA09HVO8i67hO19KKRHWHuoLVGufkXQw==
X-Gm-Gg: Acq92OF065TPxitrpM507SMHIPmdqfdEgiTAPUXaXnG3gX2x2yeO+eoDlrUP0+DCVWv
	4APTcHUTsV0TFagablX9oijkZjzPrP/IHUgdRFIlL1aL2BdqC48QO5VK4aj3CSti7D4t6fy8YGd
	BTSXpk0xhbLSdMNmlueEQYvREDcMPtOOKxsWS07TSqKqC3jCGP/iNzFi98/P7s/DKNWhMOlmbxj
	FpE8gYBaMUdlSHPFVyrvsZ45sVvuTLd/SJUf7IQxf4el31xZikJiJK/1qBekGIdeYXANneK8QUM
	ZxFDvbhoYOFnVm5dKP4jEJeL4Z8S+KX420Bu9Tk8Jt97opwkfqpdgy2+aFpQwz3Id7hpv/b/8Jq
	mzYDkSUqTpN/PC3V0J3rY1gCcTeJO9tS9AQYAWp7tn7uEAqdeDtMF7mOY1L81tdHmlH90moazou
	LZwkNsMYxCV5K8qL9V0TT+boAAoimURfOk3V72n+fj8D1Yz552
X-Received: by 2002:a17:903:15cf:b0:2bd:9c0a:32c with SMTP id d9443c01a7336-2beb0674468mr243336965ad.19.1779888843558;
        Wed, 27 May 2026 06:34:03 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2cd6sm160008365ad.52.2026.05.27.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:34:03 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH wireless-next] wifi: nl80211: re-check wiphy netns in testmode and vendor dump continuations
Date: Wed, 27 May 2026 21:33:58 +0800
Message-Id: <20260527133358.2853238-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37010-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EF795E5092
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 79240f3f6d76 ("wifi: nl80211: re-check wiphy netns in
nl80211_prepare_wdev_dump() continuation") fixed one dumpit path that
looked the wiphy up by index on a later call without confirming it was
still in the caller's netns. Two more dumpit paths have the same gap.

nl80211_testmode_dump() and nl80211_prepare_vendor_dump() both keep the
wiphy index in cb->args[] and look it up again on later calls, through
cfg80211_rdev_by_wiphy_idx() and wiphy_idx_to_wiphy(). The first call
binds to the caller's netns. A later call does not check it again. In
between, the wiphy can move to another netns via
NL80211_CMD_SET_WIPHY_NETNS.

Add the same net_eq() check to both. On a mismatch, return -ENODEV and
the dump ends.

No mainline driver registers .testmode_dump or
wiphy_vendor_command.dumpit, so these paths are not reachable today.
Drivers outside the tree can register either.

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/wireless/nl80211.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..d462e0b784ad 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13420,6 +13420,16 @@ static int nl80211_testmode_dump(struct sk_buff *skb,
 			err = -ENOENT;
 			goto out_err;
 		}
+
+		/*
+		 * The wiphy may have moved netns between dumpit
+		 * invocations (via NL80211_CMD_SET_WIPHY_NETNS), so
+		 * re-check that it still matches the caller's netns.
+		 */
+		if (!net_eq(wiphy_net(&rdev->wiphy), sock_net(skb->sk))) {
+			err = -ENODEV;
+			goto out_err;
+		}
 	} else {
 		attrbuf = kzalloc_objs(*attrbuf, NUM_NL80211_ATTR);
 		if (!attrbuf) {
@@ -17382,6 +17392,15 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 
 		if (!wiphy)
 			return -ENODEV;
+
+		/*
+		 * The wiphy may have moved netns between dumpit
+		 * invocations (via NL80211_CMD_SET_WIPHY_NETNS), so
+		 * re-check that it still matches the caller's netns.
+		 */
+		if (!net_eq(wiphy_net(wiphy), sock_net(skb->sk)))
+			return -ENODEV;
+
 		*rdev = wiphy_to_rdev(wiphy);
 		*wdev = NULL;
 
-- 
2.34.1


