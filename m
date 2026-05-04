Return-Path: <linux-wireless+bounces-35863-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBdYEmKl+GnQxQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35863-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:55:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF64BE218
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 15:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24A32302835B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352073DE43B;
	Mon,  4 May 2026 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaOajKV/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6023DE429
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902869; cv=none; b=fgiiE6ohsO26L0WHFYtnpeVyQyaHNxNUWhJJOpT4xuNp7NIrwlC92sE4P8d7lxbpCm80SYGBFY25o9YlMG4X7Xfp2rBgfYzCCuKNexAJt8mBrPn2VhyJcLEQef1t0FkaV9/CQIP7wFu1U/VV2PhichaAQ3sl3Bcb2SlMgRHVVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902869; c=relaxed/simple;
	bh=+mo3C6yzqMAksWubJQ/UbNn3zX4fALJsxYwaY5clI+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/A32JDuHhOmAwIdB1SdI0poWCWDcVN1ylxo0n+KwNHgg3HPTUR/8vcdu5MMWukXFSg1DsYcHs9iwsLHIRFO3P5yAtLAPZMDx5XhC6AyHyTGesYW3urQdAlYJLF2JUQAtORBnkUOG0mtBCEjKP06ixd67Dh4o9VQoeVHA0utbjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaOajKV/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3650453fb28so1533010a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902867; x=1778507667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yITZMlaJKOwZTlv07eJ7UVNzuxofMHYUdK+QlQSgjD4=;
        b=gaOajKV/Zz7I1zRGDN9OPRRfstU9k3TktVXXlO24M8Ca8JkYq85Du6PMohKSoit5s4
         Y+pMsvh5ozVGsIWSYJT93ocYg3/kj67wLZjNm2OSJz5nVhCnXxgK01R4P1c2dqlZvrUE
         FpO9aqLQSc0miP+LGcz2gx8PgmzFbHnsn1GB4L1Plka/T0O133jVHJ4HwQVIYpMcwYuJ
         SgMQZpLd4zIhvcRHzzoge9/JCpGN26j9gs6zi30GQzwVxumslwLQG8MAERdvq2gBxfN/
         ifWr5f9RaDlkZqOeE7YOFe+7v1SF5QW8LlbhTVUFyLNYODQYiEp7SGiEqCXcjtdkuz37
         9O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902867; x=1778507667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yITZMlaJKOwZTlv07eJ7UVNzuxofMHYUdK+QlQSgjD4=;
        b=pGxsGt8hbFd9gwSGQDo+rnShoOjBj0DudR289t2eYuKJ2vnqV3cCedKfPy2JAF3gwE
         WRqgnTBSS6GfUAPoKfhSuNZBT2UqpOO0e/wfRfJeVjs5Ww9+APOfbIyYSFUQfLvwJL/Y
         drHmuTJzLNePFWAk1q37Cf9nT1qjWJ903gQA1mvXmXSAQtHFg5U/bOx68bF31fzO+IEx
         DMjoPNVzoDT5CPEyzONDBA8sHKI1ar5KbO43KOIsVyqtLMlk1F14Xh1HFVvEMH3GVWs+
         uG+e4zCsdLmBIweOfVBlAUVGGVTakFhvu8F9e2Q/vU96aKE3FCwO8x+hh0PzotZMMDBX
         XAYQ==
X-Gm-Message-State: AOJu0YwjLSvWs/5zEMRGcZ9bf+mxMlrB+rzyN0W/GuWk7iUzg+1j1+Rz
	xUMvAPOW42BjfNPfioofOtHZey6/YdZGb20LImezk4O/qVXZAmUafbq8bGGWAA==
X-Gm-Gg: AeBDietbaMXiScxbPU6r71/Xn3+BlHkZtTSAzVctUn9cW1A2fUykXVS+a1VPU8/kESD
	4GuFJtaPWHuRMQkRIEFIclCFDAVpOEp+5oAedfyvzph1XWDdB5zhehWvTUhd+k7Vh2GbQmdhQ3V
	hsXjQwiQjPY+Kiuy8vtSGwKBbwEkAkTdsuCw40Pxl8NHjIat8DeW/KdBPkxgQwReQV8BJJeNUvM
	WLIRtPXO7CsNmpPq40rFwaUMXoTwM1Vzn+wxYrTTbr4pEu1J31U785Ug8ePL0slbyCDpzXxvmBw
	YJbnxajidHOVr8jwYU8gYjBK+3ZKQ3FAFxBdc2ZWy8N9eee0K87TBfW/zDtsVyzb0b954ZcDRox
	tzXcoSrdUo6MzZaBnS8O8DPK9QYIvwz7EOYe1CtwsXmVgpV4jaczl4vHsw555MBdYhLiC+/Va+5
	HpaWLzGBCzSkIh5YbK1q3p9VFbpiN4T1S6o2bX8ad18Xqt2M8iYj+JnZVh
X-Received: by 2002:a17:90b:1dcc:b0:35f:9ab2:a5bb with SMTP id 98e67ed59e1d1-3650ce184e8mr9848339a91.10.1777902866990;
        Mon, 04 May 2026 06:54:26 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36528ad3154sm5798811a91.2.2026.05.04.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:54:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: nl80211: require CAP_NET_ADMIN over the target netns in SET_WIPHY_NETNS
Date: Mon,  4 May 2026 21:54:19 +0800
Message-Id: <20260504135420.1178443-2-maoyi.xie@ntu.edu.sg>
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
X-Rspamd-Queue-Id: ACCF64BE218
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35863-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:mid,ntu.edu.sg:email]

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


