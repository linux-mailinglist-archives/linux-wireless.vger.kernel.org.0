Return-Path: <linux-wireless+bounces-35840-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKhAByyY+GliwwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35840-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:59:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DABB4BD520
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65C11302F7D7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917F3D812B;
	Mon,  4 May 2026 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkgJhMCK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25283D8136
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899484; cv=none; b=uXhz0O1L/erppjQQMtwzpc+jqJoaYcQp0Wa3+6cIgpi+aCZzERmXBTkaVNi9Qa1FVU1/TCpuaeZBqTETq8WspHcWY3SlPbWDvdkQip5vUerzDSY12Rf3YuKV3wbDbgK3/Z+bPnQxWpf5ulLRa11QE0ytHwhgG62xkvHjr6z4tV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899484; c=relaxed/simple;
	bh=WGxwPMj0Jvf62Qf3yIRmxkG+rH8nxvYdAc3vMvAc7YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGf91f7+dZ4Hmwwoz/vshTmxczURF16ZJq0I47mOLdgxr3DxUu2A4SDujGhw0lD39KWh1R2YdrG+Han2zi3PnMUHwbuRKpSgHaiOwPcPIf2Pjc4p6BjistPmViPs8qo7QZHd4VzzlNRhFWfUkx5rKgCQfpRbui1XUAMY2r1EHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkgJhMCK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso3093855b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777899482; x=1778504282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UnTF1dih5K5oi/fx4+6E+Hsrs0XoMIeCSQF+wiUqTc=;
        b=CkgJhMCK+rjEZhU7f3CSJEnhPuWiCdCKtHUryJzcW/C0BBDrXeRkHuFHgoOFiAX2qW
         mY2CHzS/cD3F8/OQl267Icr7fIt0Fly+vP+O6XA0zYlNHHhITXAPF/Zx8LYCxCrVlRIU
         AOyeg2jO8QSLGY0lI9SK+oFoQ8falTR/JTnKK7QJw1jVQDA/AEW3wzhQOWrP+dmfAs8O
         rxUIDI1KSlPeIoX0USvSacTxnwRlzzKHexdXkYfnso58pFoNBkYj8Agn1Gs4qWCS2sbI
         actKjiMtcEPgBacMmLfvb/KalKmzkf1ORL6/OSuyqGlmZiq5Dv6MynbiY0VrfpINH3Fk
         7LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899482; x=1778504282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4UnTF1dih5K5oi/fx4+6E+Hsrs0XoMIeCSQF+wiUqTc=;
        b=E639xP1vpkTIA4y7+pT/3f7XDm3KwIuOM3x83Xeqdt5VRIeMxHZ7Bzesgh0BQKpXUZ
         378atB8C2zsDbwecoyEePlzXgvbgoqiHA8dtGcMI1tKt5cqJCghCeytBihexkBxgdUuR
         GdelT8YkWeYQVIqK+1IxKT2/4xEAQM4ejiICGJxyZ2r2L/xA4I7AY/A3+76NYr8nWXYA
         yMTotzDOOTEPxH0C/m94Ucp2hiZtkk9XBmVxCKoV2GGXcSlIHuv8I6cpgY54fhuXB+o8
         93Gzq5WNreEs4WGjPg4IrbwVI8LtjGIzCvj6CjeHB2Ps8MG7+qdo7A0w+QiAQcFNgvEk
         Pd4A==
X-Gm-Message-State: AOJu0Yx3jZGa0Oq+fogltQk0dGbw8K8wKDmYJdyUZV0hegKOwPq1iBZS
	PgVMrYv9GSOd4EwlPeIc6Bf3gzw9cdcatH4ehu+fdW5pqipdOYq90JNZvwMD+w==
X-Gm-Gg: AeBDiesxgpaIMFDRF8e8fmDMcE3mfJ+bFBdTiu+kqZkBaVBTgL/8ZZR+AdSCNvsL7mG
	leqQruTC1fsWkXig+blrKG0pEVQGb9jRvhTgWpkisrOxZwpEpAA0xizYobngDgsc/w1Q4u/M1Aj
	TFfwZnf4n6NCB1G41SS1saWn5kcWvlxNkly4kOmnnrqTNPJDONpx6vQF0hDvn+rxJEMudU84U08
	VmyNbeD/6gr0aO3NZOLu/WzQ9bTR5Vgs/gZxsoT9gWbazHV2mpYC2gX8mC+EINcPGD4mGbmpgYg
	3LtIoa2UXgzempXfF6WWeUx/fO/vxIRkGJqsR/O5GRdM3FVBJv2UAlRsaPNcPRPiqEkleGA4fY/
	ojRbYBRGCiwWtZIlDu/EwomNDomTAuAZ4/E99JmXhFL83ge2inRthdPLc3P+a9YuT03m7JGmEMk
	agWCcFE0ElWyA8n9ZlOz5Lpx771KOJty2J/CBGI1APIqSpQSBd12O2JJYQ
X-Received: by 2002:a05:6a00:3a15:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-8352d2b58ccmr8968444b3a.33.1777899482140;
        Mon, 04 May 2026 05:58:02 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158aeebesm10748864b3a.21.2026.05.04.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:58:01 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation
Date: Mon,  4 May 2026 20:57:53 +0800
Message-Id: <20260504125753.1154601-3-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
References: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DABB4BD520
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35840-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:mid,ntu.edu.sg:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

NL80211_CMD_GET_SCAN is implemented as a multi-call dumpit. The first
invocation of nl80211_prepare_wdev_dump() validates the requested wdev
against the caller's netns via __cfg80211_wdev_from_attrs(). Subsequent
invocations look up the same wiphy by global index via
wiphy_idx_to_wiphy() and do not re-check that the wiphy is still in
the caller's netns.

If the wiphy is moved between dumpit invocations (via
NL80211_CMD_SET_WIPHY_NETNS), the dump silently continues to copy BSS
list contents from the wiphy's new netns into the caller's netns
socket buffer. The other dump paths in nl80211.c (e.g.
nl80211_dump_wiphy() and the parallel scheduled scan dump) already
filter by net_eq(wiphy_net(...), sock_net(skb->sk)) on every iteration.

Add the same filter to the continuation path. If the wiphy's netns no
longer matches the caller's, return -ENODEV and the netlink dump
machinery terminates the walk cleanly.

This is most usefully fixed alongside the SET_WIPHY_NETNS target-cap
hardening in patch 1/2, which closes the path by which an
unprivileged-userns caller could trigger this race themselves.

Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/wireless/nl80211.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index db546dd93..61b9e5eb0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1276,6 +1276,18 @@ static int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			rtnl_unlock();
 			return -ENODEV;
 		}
+		/*
+		 * The first invocation validated the wdev's netns against
+		 * the caller via __cfg80211_wdev_from_attrs(). The wiphy
+		 * may have moved netns between dumpit invocations (via
+		 * NL80211_CMD_SET_WIPHY_NETNS), so re-check here. Other
+		 * dump paths in this file (nl80211_dump_wiphy() and friends)
+		 * already do this check on every iteration.
+		 */
+		if (!net_eq(wiphy_net(wiphy), sock_net(cb->skb->sk))) {
+			rtnl_unlock();
+			return -ENODEV;
+		}
 		*rdev = wiphy_to_rdev(wiphy);
 		*wdev = NULL;
 
-- 
2.34.1


