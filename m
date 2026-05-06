Return-Path: <linux-wireless+bounces-35989-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGKgM3Tk+mmGTgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35989-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:49:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D223D4D6C5B
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93A90301F4F2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 06:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12C368276;
	Wed,  6 May 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA77DnCv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32676367F51
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050142; cv=none; b=MTpFLYsSUAAz1YmjucGZscT8N3KZn/6y2h3PiOY2JtwKKTyqhI9MXzTYm3sepkUQ0Qn5Hzffp2WE8YDAlEsN0kUZPZjKWlbsm+jKEcV0Lbvdo9bZQnUgjEtK/QK274BwYC8QRIx3GLi7pfjrk4Nf1Y6eVGpog9ekU9lfZPjrYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050142; c=relaxed/simple;
	bh=k+uzamRbo0nKKagULwVG/B+k3B3TJdppE8sMG29amlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nECANjGQ2Fse3B9F4aw9wcup6lCpwcSoS2pHXWt1CBd0n6VGItPFUmd1sEyJ7WaN/wnLbmplpLEQKd3a61Bcplj98PJWRSY3PMtHyR48tQnAuhnd03eroS5QiT6oBvlSIe+9hVvzjFe94+aZxCPOij1vLOnNuLbxBfgW1aFaQbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA77DnCv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83945063f70so294656b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050140; x=1778654940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJykL2m6ICx+4XkwZ+Xgccbe84118vMdIZH0tGbTgkg=;
        b=bA77DnCvIpu8xf4L4kTcKw19u4hzKuxlU7yH4Cmk3Fc2AFi2Z0lG1zQCCJc7dWLa1Q
         Y90nvB++D0rI4AdNC7c5RTNQryxVLBDkX47DBRFRJ8a54dUUefLsGPKB6MWW/nb+VpSw
         mybJhw4bsXODYPWC8/Bm+4kZqBaoxfbmTdAnoSwPChWLfBmRekmUzxbrYeZHoELkRw11
         I47+f8vq4viUwVuUqoinTmMCqhL4Fd+iqbNrSP39GFwaljERpZgJVBEnoEi+mgsRM3HQ
         L2kvN5N2E13m4bT/5Oe5d4TT62JdxfkBjZli5n8jSY2bEFNXhISUQDQzZlwS4Z+wJfDt
         IcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050140; x=1778654940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJykL2m6ICx+4XkwZ+Xgccbe84118vMdIZH0tGbTgkg=;
        b=BsEPhDQkIyQkREolNBHFvRoECg2ZTsK32aLhx4EBP2cWhm6tLpkgKdSGHVwnf1SIbj
         kcrdbiWAuwcFu6A2WdNtOV6hOfaGnYzseFjv/56l3BpCWeL8yLeg5txwdPcOYvD7L+By
         22f+h4VCdkUiPbt9xtFv+QMNDIIZCzSeVfT7ZtEi7kFXLET8QKjwBlnxfNCZpsRaxVo3
         XmC6Osf/Dh/0yjuO2ag1DUcN+PFDp+H8i+Xej/giIsr26YezTbWNggXhrYjVQknPzMOX
         xVHoJ5++H1VzMt3+oNFNp9PehSMS1S/VeIuJoJp9Zl9fDm2aECqdCuj3Dm2DkQozT3zo
         chlw==
X-Gm-Message-State: AOJu0YyVx1Yei2EdAbI3ur8yCBpRKjtn0Idkegt1xyeWDFeEmD2FKNyc
	Bu6fMVT0TnOAk8S293DBOcGrQWtr0gZqNBpCcN/iPRcjmto7+sIOngkW
X-Gm-Gg: AeBDietKSiMF5NS/9qgusgrQHOgWMEY0njR0hvO6XvpH/zddOJ6ucBGT49gylKEjXl5
	q/mAVxwk2dvrvkm9/6IWK21tRdkILlHaI0J6OhsO67kuvWaMb9OpKtCHq56rhBP1AQ+gSZ+Kr/B
	z7PwBFZBJYuYxhSwEAsTM26WthjSrOay2kVslC1rH9+q0MIQ0pq5Nh2cwrSamxiZ1gYaMdvuFD6
	3/bJSI9Hl22B+obkziuLEW81Sl33tmKx+bshzNw63rLWixXT1M+gQv7F/u/3aU7YMGKKNwf9ie3
	nJFphw2BxKNw4RAFPxOeWGMpKOeReSnH/L0ga91rVvTFg7G5woEdYeTMQuwTer2JCXy1BFUB90G
	nX/48i2J+m3l2emx2o2OqZe2WlEsghUqaX1k3PoQP/4UOc7UyCwhJwdjKCKz09J0uQAN2aWl+0D
	Q8oEpnZFisZ6c8CL9YhiQ3gWUY+yv6hSvbnq/Rk9YZaiFTXiPRIdoLS2y/bmU=
X-Received: by 2002:a05:6a00:300f:b0:82f:6d4a:df3e with SMTP id d2e1a72fcca58-83a543f60f9mr1650768b3a.5.1778050140495;
        Tue, 05 May 2026 23:49:00 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm5136490b3a.50.2026.05.05.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 23:49:00 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH v3 1/2] wifi: nl80211: require CAP_NET_ADMIN over the target netns in SET_WIPHY_NETNS
Date: Wed,  6 May 2026 14:48:53 +0800
Message-Id: <20260506064854.2207105-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506064854.2207105-1-maoyixie.tju@gmail.com>
References: <20260506064854.2207105-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D223D4D6C5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35989-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

NL80211_CMD_SET_WIPHY_NETNS dispatches with GENL_UNS_ADMIN_PERM, which
verifies that the caller has CAP_NET_ADMIN over the user namespace
owning the source netns (the netlink socket's netns). It does not
verify that the caller has CAP_NET_ADMIN over the target netns
selected by NL80211_ATTR_NETNS_FD or NL80211_ATTR_PID.

This diverges from the convention enforced in
net/core/rtnetlink.c::rtnl_get_net_ns_capable():

    /* For now, the caller is required to have CAP_NET_ADMIN in
     * the user namespace owning the target net ns.
     */
    if (!sk_ns_capable(sk, net->user_ns, CAP_NET_ADMIN))
        return ERR_PTR(-EACCES);

A user with CAP_NET_ADMIN in their own user namespace can therefore
push a wiphy into an arbitrary netns (including init_net) over which
they have no privilege.

Reachable from an unprivileged user namespace as soon as the caller
holds, in their own netns, a wiphy that has WIPHY_FLAG_NETNS_OK set
(true for mac80211_hwsim and for any wiphy that an administrator has
delegated into a container).

Reproducer (mac80211_hwsim, KASAN VM):

    1. As real root, modprobe mac80211_hwsim radios=1 in init_net.
    2. fork(); child unshare(CLONE_NEWUSER | CLONE_NEWNET) and writes
       0-mapped uid_map.
    3. Real root migrates phyN into the child's netns via
       NL80211_CMD_SET_WIPHY_NETNS (legitimate admin step).
    4. Child, with CAP_NET_ADMIN only in its own user_ns, sends
       NL80211_CMD_SET_WIPHY_NETNS targeting init_net's netns fd.
    5. The kernel honours the request and the wiphy is moved back
       to init_net even though the caller has no privilege there.

Mirror the rtnetlink convention by requiring ns_capable(net->user_ns,
CAP_NET_ADMIN) on the resolved target netns before calling
cfg80211_switch_netns().

Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/wireless/nl80211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 67088804d..db546dd93 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13867,6 +13867,19 @@ static int nl80211_wiphy_netns(struct sk_buff *skb, struct genl_info *info)
 	if (IS_ERR(net))
 		return PTR_ERR(net);
 
+	/*
+	 * The caller already has CAP_NET_ADMIN over the source netns
+	 * (enforced by GENL_UNS_ADMIN_PERM on the genl op). Mirror the
+	 * convention used by net/core/rtnetlink.c::rtnl_get_net_ns_capable()
+	 * and require CAP_NET_ADMIN over the target netns as well, so that
+	 * a caller that is privileged in their own user namespace cannot
+	 * push a wiphy into a netns where they have no privilege.
+	 */
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return -EPERM;
+	}
+
 	err = 0;
 
 	/* check if anything to do */
-- 
2.34.1


