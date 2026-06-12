Return-Path: <linux-wireless+bounces-37740-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0tSjERkMLGpPKQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37740-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:39:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE651679E88
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:39:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gG6rxkAh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37740-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37740-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9853330E9BED
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06FF3EB115;
	Fri, 12 Jun 2026 13:37:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3943B1002
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:37:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271425; cv=none; b=fksbJGlt6KjbHhw2zE7wMZhsqqc4dr1Pj5T21saAF06h1uloVtpHxjb1XFcd2eOLxbPVhj3m3DI1tUH1K4DPPOcbuhNPhAMB7+4Fb00YI6yeLML63A3wpE4HDW+dpf7e7ENVEF4XipLAPv74C1vqbFRJ3MeoPFTg48sJXNqyOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271425; c=relaxed/simple;
	bh=2KWpkPQa41bZlQsm6JluDJgkZzmr13UUr59IacwjTO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuGjplPedEOKmdCa8/OL5Jd/pC3UzzmX7xvRUUhAv8CK/zTTObXhnlocaviDijI4qb/0aQzPdtwMMzsC2e2Sivhp2I+aT9+BFuyZZKVxhEf0jUXgv8B1zOBVeZOArKpNyVCZkm7eqAhZ3/EmNSY0m1+CDJfjNoCZNuCzA/HWoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gG6rxkAh; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422f395a4aso722211b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781271423; x=1781876223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtjgRP64pOcIgAiCaPMHfLRKQkkQ9g99va4bg4X2WuI=;
        b=gG6rxkAhBo8NS58cYQ1q1y5l2jGqyYfEFy9NBCJnkffIFV0Lof1Tt+eM65o3J/VYbg
         mQU3C4dGd8ljvzlhKkBNkN2+Cj0PbvLypmsLikzEXxwecf1ItsjzQQVwC3+4VB3oQMDm
         TVjVAS7n8zXhTYwZeMYkZQGvAgEJ4KtLjnQwTIXnyWD1laH6FbHyVaHb1IXffE7XbRS/
         p5PuEWYmtLJ3Fhws0ThVo4je4WfpImZBSZ+2T1tiuWIjmzbnu/8lInP3LidiMKNhywsP
         fgcUxOfrOwuaCgHb0vlzIwdv0mAG/Ifrl3iaWfk4gDTtBR5vmjGYNqgGFrHdB+8toyzO
         Ovag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271423; x=1781876223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtjgRP64pOcIgAiCaPMHfLRKQkkQ9g99va4bg4X2WuI=;
        b=oK/DnUtlHJODeU0GtTShpb5bSqe/Hqdr9/DNMu/HUNitIKVRvxgDxJaBg5kdrZhcGZ
         v4J+zY4k+1neSjSUOGHlHPmB1IOAqcdCD9TersNdJI/t4S9c2c8uPFqWJxLdV1cjyRev
         2TvImOcI30WS7jy0kzpBG20k4yFWBjf436Pwzadvg9Aa0YXoaJ50yE7za0FFQj/yRBml
         a0sGQf9Zk+21sg43/fNaay9unZKQyRPBarW/GkRn/Ij3QGqiJlsEV1gy7DyIpIi2DGyF
         9T+xk8NH0XpwB8oZfclL1TPmPrAcDJatUL+aRtLx49CS3nRY+kl2GdsV80s+neZwzgzl
         I2xw==
X-Gm-Message-State: AOJu0YwbXllpb5mx/nU2wHBPFptw/j8QlSkCUQitmASpIo1MYFrF37hT
	HQP54lj9eGToby3ieX1oxjp9yJ5H+W3JRDaBoP6plPery0o5ScJli5x2
X-Gm-Gg: Acq92OEIyTxqfWP0dVmPIBQOJIIRu+xXgt4eTq56Yd1BCdMp+SfW4wuti7yEDaiPtdI
	llTZuIX1XFhz0GwL8M4HLahkkGKegph2yk09GlC54DAqWRfHX8OivR5MDuREOyt+p30slGeKNM4
	xDg51qdeiCijLzuFgy3DBzVx1eorEvEHnri/VOyz7ifexAsgCQS0J7Vi2Wy11kaSV3B38VYkbqB
	6mX/wteAo7aPHqwoZgULHNFEowUauzCUDpsqKQxIfH0y+X5ZOSUnIJtOFR9WBpPFtDI4cVFudb2
	uLUoiHO+/FWLaRSZn8djseOKbzhQy6+gZt24Xz4fbvSzJnEFQiBKvp+933zAiKKDQ9inpH5ivMi
	hsrRgtIEnDEVAe4nBv1yXZB0jS11EO0VoeZj4yDoncihQGF274SeooTt27hw4w9VwjIkxsxglf4
	CWJ1DyIkQ92oaaODT0UrHo2gXjSqfuhWPtDaduJ179SWlhHxshdgaLyuDRmR2sM/I=
X-Received: by 2002:a05:6a00:451c:b0:842:614b:50dc with SMTP id d2e1a72fcca58-8434958ae59mr2904990b3a.13.1781271422827;
        Fri, 12 Jun 2026 06:37:02 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9bfe1sm2574272b3a.12.2026.06.12.06.37.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 06:37:02 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: validate PMSR measurement type data
Date: Fri, 12 Jun 2026 21:36:57 +0800
Message-ID: <20260612133656.92900-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37740-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE651679E88

PMSR request parsing accepts missing or duplicated measurement type
entries in NL80211_PMSR_REQ_ATTR_DATA.

Track whether one measurement type was already provided, reject a
second one immediately, and return an error if the request data block
contains no measurement type at all.

Fixes: 9bb7e0f24e7e7 ("cfg80211: add peer measurement with FTM initiator API")
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/pmsr.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index d6cd0de64d1f8..b1ead4adf9690 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -213,6 +213,7 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 	struct nlattr *tb[NL80211_PMSR_PEER_ATTR_MAX + 1];
 	struct nlattr *req[NL80211_PMSR_REQ_ATTR_MAX + 1];
 	struct nlattr *treq;
+	bool have_measurement_type = false;
 	int err, rem;
 
 	/* no validation needed - was already done via nested policy */
@@ -265,6 +266,14 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 	}
 
 	nla_for_each_nested(treq, req[NL80211_PMSR_REQ_ATTR_DATA], rem) {
+		if (have_measurement_type) {
+			NL_SET_ERR_MSG_ATTR(info->extack, treq,
+					    "multiple measurement types in request data");
+			return -EINVAL;
+		}
+
+		have_measurement_type = true;
+
 		switch (nla_type(treq)) {
 		case NL80211_PMSR_TYPE_FTM:
 			err = pmsr_parse_ftm(rdev, treq, out, info);
@@ -274,10 +283,16 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 					    "unsupported measurement type");
 			err = -EINVAL;
 		}
+		if (err)
+			return err;
 	}
 
-	if (err)
-		return err;
+	if (!have_measurement_type) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    req[NL80211_PMSR_REQ_ATTR_DATA],
+				    "missing measurement type in request data");
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.50.1 (Apple Git-155)

