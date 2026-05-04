Return-Path: <linux-wireless+bounces-35839-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIkeGxaY+GknwwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35839-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:59:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4494BD512
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 613F23028C04
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D293D8121;
	Mon,  4 May 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tco+vu+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3313D7D95
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899482; cv=none; b=Me7DhNV3/f7Ds/8FiyPiqsAozDkPpDfHM2H0P06MdVv8GJUPeAiEObuaS9KOC4wbss+n9XH24wYjIOomyc+rkp4clXZw7fqG3BX5abLzhjxqSfzziYCCa9NCKRjtJ+b8FVPZhI5NGj2faEVfWV+HYpVmNMaEn7XrCiSpewPGAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899482; c=relaxed/simple;
	bh=+mo3C6yzqMAksWubJQ/UbNn3zX4fALJsxYwaY5clI+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtnYGRkcD6Dl2bNQQJN9sWhJJuPLuRoWPhxtjauwRsDVb1EOc9UgKzrWtJVv4z0I6jllWxVgU/Fv7d4CcCkKE5Z46e9qdpWPQXoNmtyz3kHxKfeOtcSY4Hs9RgHvIXmo6MhUEwx9J/kSBIGCPNolE3Ayx9IHlJJNtFRwTINlSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tco+vu+D; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8296d553142so2916614b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777899480; x=1778504280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yITZMlaJKOwZTlv07eJ7UVNzuxofMHYUdK+QlQSgjD4=;
        b=Tco+vu+Dd8nXNOaE+Q7GVZyumHmnCH0aEB9fv6qw681xU2lrvO5cE+lA1gLbQkMovb
         0DWovdsNDGVgBEPo/oD/hM14EMeOzWWDufokidUzP0tiOkuLtrTHStQMioPNuSVjLmN5
         l7YEcaKwlWrgW02N0N/gtWsy/R8bD7DsnzBjn4PzngLfbXgbN0bJimYE+uIFsdkb9kX8
         onN8Bq/QdFvv9ZplEGoIzfu6M+voeKB3idgiCVYuCM17BRhQ8rA4iTgSdjRcxrDT6doG
         pi5+Wb6PfSDF3f42YqpbBG8BHhovLjs6pz7Z62yDYsCxKx21u4Jp0ziIKtSs8/lZwLDm
         oBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899480; x=1778504280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yITZMlaJKOwZTlv07eJ7UVNzuxofMHYUdK+QlQSgjD4=;
        b=pcU6bCY1fiEuPMoUQDFST0sFnHg45th/UBevSv3NqRqS0jB53al3oJlO+0wESHVOif
         z7EqjENb47qL7FPOkdYDvDpvh21QmsV3NTkAc2ZnPgVhPeJlYanpPLdcrvfqLZqxFsY1
         Zo7u0VgztFcLvQBOf+yM6Zt2e7t1utcyPqQ6D5G1GUFSqxOdxyHD/2svzlFdYrR2LqjD
         oD2mQ+S6OIRU9RsZusWLPQtxesfN/sR0K6iI6IYpRC6Odye1GrxTSyuW5modphOurwuS
         ON3IRxjzO/KtX6+AN0RsWFvD0VrYnZimIxNT1FWyZr3cj1S4ZzYdXlQ803f580NTjcNg
         WYwQ==
X-Gm-Message-State: AOJu0Yxq//wQ+zTkkCW9SeGkEATLkTgIIedLDX0HweqwA71pPAJlHTB2
	bcGT4newpq64V1GHnueZ+YK16UKOzDFNxnRBIGUzUODJFMbNEOwdXR4H
X-Gm-Gg: AeBDieuAZakP3Q+bDJmuuZX/3aqZttAbF5UNf54Lhif/m/NzkAUAS5SK5azZdORT4Hu
	3J1jasKseXOC0PwgkrOPHiH3oo2b2+0JLCWjc8HuJHDelRw7dUC2fe3Pzo6IofxSPsi+PszvVpA
	U4RTvYVHWYaFTFvMIosFFFTFQeoHD1MnGo3hV+d/iBKHiVRyUCon0ot47vnjL65A9hIFfT6Uhtf
	XiNsxPr8IbgI0LeGJEeLnKHnAFIKXvP1V7VxM6+jbvAM6VrHlENQS04VWy4zXeDZkdGi736JpUI
	U7kRwz0FGH4ez+WiNMvOgVp/g/PPnORTrNsBYOcCIXOsRS9oTXimuCkKJpVscmK5VNjss/d2F37
	Q4FYZeBGye8KxM0CVpgYafTeUPySp3efmBpKJI7wUBiMQY4noQh1Bw3bcHfwu36vVfYGGQWJ2ZA
	4Si5faxEbdzudtVfCjMf8oZIcheL+eQfpYiM2thUQahKqxNisPzEGOyxlNK7y4MCdGmsg=
X-Received: by 2002:a05:6a00:460e:b0:838:6d43:9486 with SMTP id d2e1a72fcca58-8386d43a2bcmr1362596b3a.10.1777899480120;
        Mon, 04 May 2026 05:58:00 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158aeebesm10748864b3a.21.2026.05.04.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:57:59 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] wifi: nl80211: require CAP_NET_ADMIN over the target netns in SET_WIPHY_NETNS
Date: Mon,  4 May 2026 20:57:52 +0800
Message-Id: <20260504125753.1154601-2-maoyi.xie@ntu.edu.sg>
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
X-Rspamd-Queue-Id: DD4494BD512
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
	TAGGED_FROM(0.00)[bounces-35839-lists,linux-wireless=lfdr.de];
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

Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
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


