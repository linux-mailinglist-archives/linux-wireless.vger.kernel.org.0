Return-Path: <linux-wireless+bounces-32137-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAN/L/YJnWmlMgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32137-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 03:16:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F42180F18
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 03:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D9D303CC09
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 02:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51B1DFDB8;
	Tue, 24 Feb 2026 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="WqnL+Y3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2613B584;
	Tue, 24 Feb 2026 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899379; cv=none; b=bLxwz5ZdEExl6/1KW3fWdo04k1Jy1Ud2IHbKw6UkSnGw9tpSVndtImsF3/e1uOXA4VaA1ZVC3gafj6jz9Kt8LTZL+Ed1/LT/oV/d1eQWPlO6r8Gj36AgiLSvlhmeNsIep/iKnIfJan8kW7tb9qit8p31qb06TFFxL4M00vbTT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899379; c=relaxed/simple;
	bh=uISBYiyD8YFxTSKSURn6tgXFL12+gkl4iHchrk1mKik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEuUJWs/z8nJ5dGcs//AT7CBIP8cpPxuUJpSe5dON6q+BZLfBMhS5mJrb0YRf2W8tQl54vOvM+XlFaJHYVERSrbeYvYAr3l5iIpJvFsjFkWoVwK+uWV1m5harXIHXo6UODrYf3KioustBG8Un2mKa1sZCP3lSrho/h5rgs2Sx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=WqnL+Y3Q; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1771899359;
	bh=14rvGqc9KcLL64nC4WJylGsOH6hZhapUoXKj334P5us=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WqnL+Y3Qv78mms8OVZij5r+K/HOeM0v9ZdMtWNZ0RTpbfRxp2On6O9ShyvZaOT7jH
	 vNtQfcbPQDCJRGAdNw51ln0DAsgpgqEyqgWu1JwYUu9v6p46/KepIPApqd9DrXkfyy
	 U/tnXvRLzqQzfNs79qImoSyKySbsJ+dS28sasul0=
X-QQ-mid: esmtpgz12t1771899352tac61139c
X-QQ-Originating-IP: f0HmRaMv/ofkJ2naKt6dRL2ZjGl7nADtqpr3hyR+xNo=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 10:15:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17866013117574701843
EX-QQ-RecipientCnt: 8
From: kexinsun <kexinsun@smail.nju.edu.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	kexinsun@smail.nju.edu.cn
Subject: [PATCH] mac80211: update outdated comment
Date: Tue, 24 Feb 2026 10:15:48 +0800
Message-Id: <20260224021548.1394-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MTyvyLqh9yTfIV5y8jscvhpuk8b+W+J34rLm65eyFlUpSvVrZZB+Id5U
	PqOor7nBNxTW7vYFR9QCIIH3iGoW02/mVEsOY0MEn2+4efnjejobwQ40IrbB67W5Ut2KAPK
	3TWhC1HcM2pvWK8JzOKZyFopcft+kY2lqJTHM5sEpYEhhWE0AxuMiZptfrX9wwT19vMYZL+
	DMDGGDSfE7MuP0HwSVHzq+Y8IbTOssaIeP6FoRjjSOXSDPgh6+AxRecB1KsynWl+EFk1KmQ
	U+plghCe/SdlWPAndJBGNv/aCs1+H5jhf0Z5hl3THkqEoRsruOwHt3LsJeMD8Xy0K+dtcyA
	uqSkHw0Rxb7ImMa9TNTCPHyGZxWe6kEDFekcCPv67/fulc2LJ/PZVT+8WrCsmCNalgn+tJy
	QJ5rN9Y5XQZDuEePTeftJNWrPES4lggDk44fcXQg2+yHcgtT/pddpE9NijYZ7R/RAO4zeta
	0v03bpmocS8PmFH088BmTYEWhM2Wp1jnzDa5KstTNtbaHd2/TeilPicizun7yyLvSlV+wOp
	W7u4Dhp01DV/Vau5/ooqLuivUZuMQkM0KB2267i85tWkkXYXiw1OzeW7vTE4c7VhyYFSqGs
	y+YuwgDIBlLX67j0M62T9awMXB0J5/8m3IJnSKeifEsDxiKr2HOt1W/fLTjD4Z/1CpJ5M6e
	tfK7hWa9GcBu4bK71Kek6J2vsD8HylsxxVjdCH+oBmxcAZmmJN5d9AIN4ZGfSTAtgQKWhU2
	t89ocZ0FedjbQvF7iao0i02huvZpg2xbAgspq/iDufGOmFBW8JuY96maLgQjsLaTQYhEVxQ
	GAwdn7/VAgFNPegtM/exOY00JxRYGe03VPhqOgjvHxvYEvStA9iaSfXFoae+FXbk2Te2viG
	RzpiCCohtf6gjLHo33OLmQ8c5wtcr4CoyWpXKfpvBlyLAjvEkpCdmDbMs2HMoi9tWhq6Ows
	ahmPCv58t7M7ZSvjipW6oJklM+AxF92DEv0RmyP/uPxv3hwj1ponrJfMzJtdGebRcL5iHjE
	9XELp8QCK+GhBaqsqTeCJyfcEzhaU0sWIpRpZMn9RERHQq9WHGkCpeOeGmbAT02+Q0GjXeu
	f/EEWp0dbC/mY50lGQS5f7+Wkzx8oJMn9PEZ0DwUkLDOAyWghRmo+ML/3SDQRIZHvN0RzFO
	Iun3/TuB3WtETDY=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32137-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smail.nju.edu.cn:mid,smail.nju.edu.cn:dkim,nju.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15F42180F18
X-Rspamd-Action: no action

The function ieee80211_start_scan() was refactored and replaced by
__ieee80211_start_scan() in commit f3b85252f081 ("mac80211: fix scan
races and rework scanning"). Update the comment in
ieee80211_tx_h_check_assoc() accordingly.

Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8cdbd417d7be..85c48b42474c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -288,7 +288,7 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 		 * sent and we should not get here, but if we do
 		 * nonetheless, drop them to avoid sending them
 		 * off-channel. See the link below and
-		 * ieee80211_start_scan() for more.
+		 * __ieee80211_start_scan() for more.
 		 *
 		 * http://article.gmane.org/gmane.linux.kernel.wireless.general/30089
 		 */
-- 
2.25.1


