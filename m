Return-Path: <linux-wireless+bounces-36865-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB0JEcEKFGr6JAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36865-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:39:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 962365C7E44
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FEA430048DE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02603D413C;
	Mon, 25 May 2026 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="bsUatr3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0B3E16B0
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698365; cv=none; b=QmBSnxwdI0U/G5iE4kyeO0J6jt8hhjAGHLKaGxBs+Ed5pa7Eljv7CowYUr8X/wslPWzRiOntPBQfCtS9n0xBKqtDLtX7DQR3EhMns/7D5GPCI979YPdMLaSaaR3QWcvRKxoSM8pS5YYJvuWZBl3qSwBcl/UEErPfJTDp/btBBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698365; c=relaxed/simple;
	bh=nlTjWSZNA4c0E9DTeSrnSX9L+PqP9Qb8MPVCdIU9t7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ym8OaP2+ruu03rkHKQqqh8pLtar1SLsLi5EtNbBThnIxhsCfqm8NwSYe6QQ0QW08bjvLsl2mjyz3euZQBY1z6hnC3P4u5IHYM3hMWZNko5qbDmHNYmhPTjGE8PNMO1RFCZeRsay5iDFFm1Gk5BphBstsw/Vu898bOBvSR/WU3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=bsUatr3D; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1779698364; x=1811234364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nlTjWSZNA4c0E9DTeSrnSX9L+PqP9Qb8MPVCdIU9t7A=;
  b=bsUatr3D1wI4LEsCV+Jj86GT7IGJFHnFAqwubI1vZWXGmb3S7XhKV9Bg
   saFgcVgWf/RmBDvL+GW+IYH6J77t0pkzMC9ozJgXXqK9D0VxuLKHKaRL5
   IV6rrVjfWG5TODcn20L/xnayFjP0nMggXpip3C6E+UJb+pjXpvXkAjseF
   I=;
X-CSE-ConnectionGUID: WudHZjaRSIm3aPuIXgj7TA==
X-CSE-MsgGUID: CBc/5r3KSQWqd4aTHu6C2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="159151233"
X-IronPort-AV: E=Sophos;i="6.24,167,1774306800"; 
   d="scan'208";a="159151233"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 10:39:16 +0200
Received: from MUCSE826.infineon.com (172.23.29.19) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 25 May
 2026 10:39:15 +0200
Received: from ISCN5CG3192MLP.infineon.com (10.161.6.196) by
 MUCSE826.infineon.com (172.23.29.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 10:39:14 +0200
From: Shelley Yang <shelley.yang@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
	<wlan-kernel-dev-list@infineon.com>, Shelley Yang <shelley.yang@infineon.com>
Subject: [PATCH] wifi: brcmfmac: fix 802.11x-SHA256 call trace warning
Date: Mon, 25 May 2026 16:38:59 +0800
Message-ID: <20260525083859.581246-1-shelley.yang@infineon.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE826.infineon.com (172.23.29.19)
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36865-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infineon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shelley.yang@infineon.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infineon.com:email,infineon.com:mid,infineon.com:dkim]
X-Rspamd-Queue-Id: 962365C7E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Based on wpa_auth as 1x_256 mode, need to set up
"use_fwsup" with BRCMF_PROFILE_FWSUP_1X.
Or it will happen trace warning when call brcmf_cfg80211_set_pmk().

[ 4481.831101] ------------[ cut here ]------------
[ 4481.831102] WARNING: CPU: 1 PID: 2997 at
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:7242 brcmf_cfg80211_set_pmk+0x77/0xd0 [brcmfmac]
[...]
[ 4481.831202] Call Trace:
[ 4481.831204]  <TASK>
[ 4481.831205]  nl80211_set_pmk+0x183/0x250 [cfg80211]
[ 4481.831233]  genl_family_rcv_msg_doit+0xea/0x150
[ 4481.831237]  genl_rcv_msg+0x104/0x240
[ 4481.831239]  ? cfg80211_probe_status+0x2c0/0x2c0 [cfg80211]
[ 4481.831257]  ? genl_family_rcv_msg_doit+0x150/0x150
[ 4481.831259]  netlink_rcv_skb+0x4e/0x100
[ 4481.831261]  genl_rcv+0x24/0x40
[ 4481.831262]  netlink_unicast+0x236/0x380
[ 4481.831264]  netlink_sendmsg+0x250/0x4b0
[ 4481.831266]  sock_sendmsg+0x5c/0x70
[ 4481.831269]  ____sys_sendmsg+0x236/0x2b0
[ 4481.831271]  ? copy_msghdr_from_user+0x6d/0xa0
[ 4481.831272]  ___sys_sendmsg+0x86/0xd0
[ 4481.831274]  ? avc_has_perm+0x8c/0x1a0
[ 4481.831276]  ? preempt_count_add+0x6a/0xa0
[ 4481.831279]  ? sock_has_perm+0x82/0xa0
[ 4481.831280]  __sys_sendmsg+0x57/0xa0
[ 4481.831282]  do_syscall_64+0x38/0x90
[ 4481.831284]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 4481.831286] RIP: 0033:0x7fd270d369b4

Fixes: 2526ff21aa77 ("brcmfmac: support 4-way handshake offloading for 802.1X")

Signed-off-by: Shelley Yang <shelley.yang@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0b55d445895f..89f61710a210 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2146,7 +2146,7 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 				 sme->crypto.akm_suites[0]);
 			return -EINVAL;
 		}
-	} else if (val & (WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED)) {
+	} else if (val & (WPA2_AUTH_PSK | WPA2_AUTH_UNSPECIFIED | WPA2_AUTH_1X_SHA256)) {
 		switch (sme->crypto.akm_suites[0]) {
 		case WLAN_AKM_SUITE_8021X:
 			val = WPA2_AUTH_UNSPECIFIED;
-- 
2.25.1


