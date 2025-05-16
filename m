Return-Path: <linux-wireless+bounces-23076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AD4AB9B92
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 13:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84004A7F64
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F0238C1D;
	Fri, 16 May 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k/t9sJb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED23E47B;
	Fri, 16 May 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396782; cv=none; b=SgfHyKjbcLBqTulrjh/TMGvlVu5rs1HRyHsEcXj1gxDqXgoUKjTmbYIn2pfGRONq1fAJFZIimD9z65bva2Y/7kH7B0ItSCnGsZue6pQWXhOHe8+kLhMJwoLG4oZuV/jyUso47A85KIR4GFfofBkUdT0x8v9x2l/smW6iXmEGo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396782; c=relaxed/simple;
	bh=jvpXSptIQdCkod2SYNNCI5du/IYJD+vrubcAMOXpQ9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSIEa6h66otI3EuCJV9a/qwSlDKq2DI+ZvFgkU50IuKidyDXfe8b+Csc2IlM3n0PDpgYycfHfSVfOzeweI/OCX1bh5Wa8oTGuw7a5DsFu/VXTAo4OULXxKVMc7licYd4AbFyDq7SRPjTnssFrWven2VIahoCbycN035T1LrzOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k/t9sJb1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=t/4JlCOSTsV5ih/xh8Ov1+h0/+JYX+ZEDRFX33NhTvU=; t=1747396781; x=1748606381; 
	b=k/t9sJb1eRNtbH3e3rTyGmJPYA4M02H+KE+YDE199+hOUmH5nX1wqBlXk3t4QE9nZSI+nazEl10
	W+xKU9VughWW0C55hVT8WeA6C09n5qFl9BachwVKNFqIK5rec3zYlPEIkpJ5j2avInv7gPFVv+XlJ
	JI8MlZVfDqUOiSBCexbt2yDuwQ7+azK7rIbWdZCoRy5/P44DUpK6PNQS1W+UFfQQ+s+21uYxNZvUV
	J8Zy35/sZLCOKEBDlcc2lfi4i8wE2RwPwdwgD9LbQ4nnGJYx7j5Clp7SqK3gON186h7UCyn6BgCIt
	IvLEeWx/Ip/dINwxq4F5YC9S+bmf3vRrMSlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFtit-0000000EX8I-11sK;
	Fri, 16 May 2025 13:59:31 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next] net: netlink: reduce extack cookie size
Date: Fri, 16 May 2025 13:59:27 +0200
Message-ID: <20250516115927.38209-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Seems like the extack cookie hasn't found any users outside
of wireless, which always uses nl_set_extack_cookie_u64().
Thus, allocating 20 bytes for it is pointless, reduce that
to 8 bytes, and add a BUILD_BUG_ON() to ensure it's enough
(obviously it is, for a u64, but in case it changes again.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/netlink.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index c3ae84a77e16..882e9c1b6c1d 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -63,7 +63,7 @@ netlink_kernel_create(struct net *net, int unit, struct netlink_kernel_cfg *cfg)
 }
 
 /* this can be increased when necessary - don't expose to userland */
-#define NETLINK_MAX_COOKIE_LEN	20
+#define NETLINK_MAX_COOKIE_LEN	8
 #define NETLINK_MAX_FMTMSG_LEN	80
 
 /**
@@ -212,6 +212,7 @@ static inline void nl_set_extack_cookie_u64(struct netlink_ext_ack *extack,
 {
 	if (!extack)
 		return;
+	BUILD_BUG_ON(sizeof(extack->cookie) < sizeof(cookie));
 	memcpy(extack->cookie, &cookie, sizeof(cookie));
 	extack->cookie_len = sizeof(cookie);
 }
-- 
2.49.0


