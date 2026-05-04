Return-Path: <linux-wireless+bounces-35864-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANHgAn2l+GnQxQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35864-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:56:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD44BE23D
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88FAB302FE8C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322E3DEAC9;
	Mon,  4 May 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8T1RT3h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA763DE44B
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902870; cv=none; b=PQdT6MPALlBOLRkS6XKQOulZCvW/AGy77Ga3T5oZ3o4pq+SRcb385rUZyuzDhIqzX52asLIpJTzwnkDYWRGis5Ewneuxy1EPFmS52PDnSEnM8FDZdF+ciPW+9pg1jsds6to14PZ2UUogfQ3ivG7U4lLNpRCYKKvJcIL7XOxbn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902870; c=relaxed/simple;
	bh=lZ43BZt2AaOQounO6PwiBsgobhLyQ5LHCVi3JxWnkdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gk9n4oI5hTJmP5XUS/8obYzXLqvomo0dztGmuW2dEG+sJnTrd7Mw0yImw+azjzEHrURfIbVsA+DZiEPDQcxCOBhteIJ9EHq22YNdhBQ8joCf/DxTCtcwuN2k99v1pGeDrszY3RWeg4iFsiAdHOr7YW8NWkNCjihS3UFYrLN4qzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8T1RT3h; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3651fa24c6bso1179323a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902869; x=1778507669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JrWRWnHNvpiU4/xnJGaTVYu+5KLfhCwion4eRCqHfw=;
        b=p8T1RT3h/NyJsv0CaHHrciqqO34bvVs0mLxzqH0WaOt4COYdWQeae8xGvqxCS6UgmD
         mUQUeSMsnamEuJfZZpzPKC5pOVHh279SKttbMrNHLK1t1UlkznnxkymDQYKi+io2bYCV
         FDSjSo5jAQzZ6JBeip2hdnfofPbOYNyzDn4wKZ0iqfCxSjkwTZrW8y5auUpQznyhsfrV
         FxZbKDcAzXIRnBAUIV+0q6qPVb4lxs0C91ogbW6JZjv7ZzkvhJAMS37fpoTQB/mnxzfu
         kLhS1u+qGClO9irPUPe19TIMVT1NsZIZZYBvIwldvJI2ETDjw6YrxSL/SOpBPp1V6/i4
         Hjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902869; x=1778507669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8JrWRWnHNvpiU4/xnJGaTVYu+5KLfhCwion4eRCqHfw=;
        b=jeaPIRbZ7JXSvPGp2Neg82mTHsNNDzjgRKsJBPVfZeHLtVv9yXYrip2phgApTTKdV0
         1m631+daI/jiV0SE7767l8Jt/68X6BUEfCltMZkzKDKdysCJU2RQuxd0iVeMKBjcRtQr
         l470T+m2QI+/R5Q7J4x4KAK5J/uH8icLxodyoNtNgPxTaCulV/+CIVbGCwkyGzrVGE19
         GG/uazw3Md8xpbT/YzBA0fIGp/G3+JBm4lFwgWY5AcaWTuhntctIsb91eVeGu1mGnoLw
         bcAH9W7UmUcJ10AZhDzrTGm1uKF0uGLIYWvV+gKVL/JZ+rz5bOlgnYPXCKNmrB5WActl
         tbbA==
X-Gm-Message-State: AOJu0YwwsoEeCABXeA84vltzGGnmHAarMgLGbE6cE1ql755IaHFZULJc
	TlITmQZ5F0Cwy8lQSgasdBdNaLr7tJMy9mgUXdZ9NOmGJKh6DcusQLCr
X-Gm-Gg: AeBDiesm6LaYfw0lpKRyTJ5q9Fy9jATG7/r6aA24MlpPyofF8rDH2MIrbObkvP1E8dS
	MnfZBiaTSYKWM0J2ilAjKZGDGb0BZWJmQqOH6DggvUD8B8Zwj5gYyoU5cvDpCyDvchwO1pnKVd0
	7hxD7gGSgFU8ZtVhrzsT0/7JAQ82efQgboR+71nICNjQmKISNNtAQu6t+ddTMLXBJ8V/Z0/Zyyb
	8h52/gzkI0XdjLhLqgKXmSsYiZXZZ4OWgRDiB3bs+toSM4ufv7CAR2a2DLkT/zIbzsUqZT3ZEnh
	mA55mKTHsf708VF3aE45CJiQoICOMXH48JWn3VAl+372KkNE/CZI8gsmB6pF2YIUxwVWNaCgEff
	HAXIpU15rgNZUeVbJRjU0BwDgSMaPiHrTzhfjSnwGEFNffFOTQy+M14MwAscrtZ8m8Hi7Fd9ZKf
	DEwIOpEszjAxliql2jn0MRFFw98hLYd6cpSuXG/SnXR48D6mhZXIcdYKuq
X-Received: by 2002:a17:90a:d407:b0:361:3224:2f5f with SMTP id 98e67ed59e1d1-3650ce713bfmr9740436a91.22.1777902868784;
        Mon, 04 May 2026 06:54:28 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36528ad3154sm5798811a91.2.2026.05.04.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:54:28 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation
Date: Mon,  4 May 2026 21:54:20 +0800
Message-Id: <20260504135420.1178443-3-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504135420.1178443-1-maoyi.xie@ntu.edu.sg>
References: <20260504125753.1154601-1-maoyi.xie@ntu.edu.sg>
 <20260504135420.1178443-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74CD44BE23D
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
	TAGGED_FROM(0.00)[bounces-35864-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:mid,ntu.edu.sg:email]

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
 net/wireless/nl80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index db546dd93..f2c91a939 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1276,6 +1276,16 @@ static int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			rtnl_unlock();
 			return -ENODEV;
 		}
+		/*
+		 * The first invocation validated the wdev's netns against
+		 * the caller via __cfg80211_wdev_from_attrs(). The wiphy
+		 * may have moved netns between dumpit invocations (via
+		 * NL80211_CMD_SET_WIPHY_NETNS), so re-check here.
+		 */
+		if (!net_eq(wiphy_net(wiphy), sock_net(cb->skb->sk))) {
+			rtnl_unlock();
+			return -ENODEV;
+		}
 		*rdev = wiphy_to_rdev(wiphy);
 		*wdev = NULL;
 
-- 
2.34.1


