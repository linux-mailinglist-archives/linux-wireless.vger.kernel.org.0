Return-Path: <linux-wireless+bounces-37635-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I2mGJESPKWorZgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37635-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 18:22:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD666B631
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 18:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NqTl75qY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37635-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37635-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F8F376A2C0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2E3F888F;
	Wed, 10 Jun 2026 15:43:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED8429802
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 15:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106192; cv=none; b=Cq/0PhHz+QHlT6KpB18tUbs4Be2juXwcdKHYUXdPlynj4bQc85oq500FbG3/q6/ACsbbeIdSTwMaXBQmPOu8kZHgDnwamyrEOCGwAptts4TtrfIEv6iw4W1swf11pu8YqA4/m3Rm0KF4HytYDVQim6sQ4EVolaO79rQnvNjZjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106192; c=relaxed/simple;
	bh=xqZfYDYPDBPN7aKZCdWGjnvMLnaV5O+1fNS2MXClDPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFLLlrMMwWJ3FRkA7DL0R6eeHW8QvEd/mR7k2Q+FJ8YW0s0vuHUuaAltuypLHRlCQwq0yHM87i8EOr+7RndI+bglo4o9LxxOwM7m3iOtIE4EHSQJTFU2z3VWABdeNZD8i6i52DGXJcY/7ycdywOxCCR8CrMBTRIJUFynHvABAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqTl75qY; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8585cd8400so2696130a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106191; x=1781710991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XDGbUf4iEhNvwcof5vdLMuCB999+9vu1yeTxgx41Mo=;
        b=NqTl75qYL4rVakJ66OV9nA+0nOuFRfU4qnWPcxbMPT4q05LHakfYVq6OahMxifGPwk
         5BjFJn/G3EHoAEO7RfL23QYrroGqaYHiI5DuBgxgMlIat2fbJyyvZz4twZnZ2gUwXxub
         oGdTKqe8W30GCc0v5+IYFDBSBIe4NtzBOPUXYCLlkmZBHPol/jODAXeHq1/62aSmcH9i
         23wG+A9Xs7r6bxd6aKuAcmQHBWpF3paknj0rvKw/MRSuM+OmHZauQdsk0VVFcBHdDkTt
         tS7y43FGqI+6bayXkH0BS6CitJ4bPfaNl3bW3c19jFhQnU1fkYB47O17ksXjUcywMe2y
         VYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106191; x=1781710991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XDGbUf4iEhNvwcof5vdLMuCB999+9vu1yeTxgx41Mo=;
        b=M/O2OaGTO+deYJIZZgz7eFkFTWrclFyNwQXiIj0ekcJ3cQSlyMxLktbXSnezCmsZhf
         7TjNNRJAjEHoJspQSMzGnuJ7kgii9pNxPXGU5+lLvhfIYbDZ97ZH3ET5xz3Q0BBqv1Xi
         W8+4uIf/kWQ2LGhCKdCyDVPmrMRDHc6MMMF5YGOB0ptz25OXywHliRyyNGJm93bQoFE6
         6XRofRDUCnDZzNpMCBLR61IUQoyXoYuxiIOg/fMSegPXlw1ryrkCXCQvWCfpiZGPeW3k
         xAdZMawFRnSyVH5k3iiARJvoyBDJ/BhX6XyfFB94rEey0COdNmcwqM+sbHnTeZf/TFEk
         E1/g==
X-Gm-Message-State: AOJu0Yz6IpMIWWml/SkWzn93kpy99jvL7U9M/mI/RJdecosp8v5jGRD0
	BT17+usFO9cgFHPdpvFcz7AcZWzk16IyqZyRh9Gyf3cb54c2+f5jMh6XOA3f4evbd3i9uD0/
X-Gm-Gg: Acq92OFuoPNW0uprZYhlcG71Xf8aPNVsJi48SCsrqYygPVAB+mWobYXxXQEYQ051DqL
	uj90pMmKWWUzCXrxgVG8gZZ4cAtGQ18n+7/gXBkZadCBA38yHGm0Al9AIOWhPmLKgiZj0xQl29/
	ZVf/P1P/Ui4Cxnv3mWldLi+qd36OYsbGZ5fB+WZw6UflwTK5QZVWTPg3sbwgHviK1PEq5a4L3Vc
	g1ojf4ivIlaa4rZCC1YS5npSbRZq3MaDD33vj0pxgTtGMJX7iRYT2FMhFtguxeYgzK04soqufA6
	Ku5/sGRGfbG2PKm4wBSR53XmVzK7mGLSHImrjrtB39RffhYl3bKalImQCMQtUj20Kwub2Bds67t
	XT5VlRhY81sY+NUUjIm5ZbEM26mFwXgF58+DMacLzhQv+QSyE29aOp3SPNaqhutHEvBqJxe/WAC
	LKKYvKnP9oxp2Zt66L/nt7GEhxmywT1iX222pFmzeTKxhd8nZHCdtsdHdMlVV8qHtv+C2Ee7Vgb
	Q==
X-Received: by 2002:a05:6a21:7a82:b0:3b4:85db:1bea with SMTP id adf61e73a8af0-3b4ccd1b486mr31060842637.5.1781106190947;
        Wed, 10 Jun 2026 08:43:10 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b26bbsm21482885a12.23.2026.06.10.08.43.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 08:43:10 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ieee80211: validate MLE common info length
Date: Wed, 10 Jun 2026 23:43:03 +0800
Message-ID: <20260610154303.37079-1-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37635-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:enderaoelyther@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34FD666B631

ieee80211_mle_size_ok() verifies that the advertised common information
length is large enough for the fixed fields that are present, but it does
not verify that the length also fits in the containing element.

Reconfiguration and Priority Access MLEs also carry a common information
length octet, but currently skip the common-length check. Reconfiguration
additionally fails to include the length octet in the minimum common size.

Validate the common information length for Reconfiguration and Priority
Access MLEs, account for the Reconfiguration length octet, and reject
common lengths that exceed the element body.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 include/linux/ieee80211-eht.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index a97b1d01f3acf..d875045abf6cc 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -878,6 +878,8 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
+		common += 1;
+		check_common_len = true;
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
 		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
@@ -893,6 +895,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		common = ETH_ALEN + 1;
+		check_common_len = true;
 		break;
 	default:
 		/* we don't know this type */
@@ -906,7 +909,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		return true;
 
 	/* if present, common length is the first octet there */
-	return mle->variable[0] >= common;
+	return mle->variable[0] >= common && mle->variable[0] <= len - fixed;
 }
 
 /**
-- 
2.50.1 (Apple Git-155)


