Return-Path: <linux-wireless+bounces-34830-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nv3FEIQ4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34830-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94BF408980
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE03A30DDEBE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1160393DF9;
	Wed, 15 Apr 2026 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl97ZQUV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F903939A6
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291814; cv=none; b=lHp0+xTzObn/umAmTtgypXCiTmfPuNeYgwR0vSM+T+otWw4fVEcddJXokRna4l5L1KnDIZXs/eHGDqnfAvYcdrlIt+VpVsbS3ZvXH3ULUYeeSyhPl5neuxwMjZiSsd+lCKVSR4epL2MYz2dI6/wWbyFxHP7UP9F3WdR3abvIpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291814; c=relaxed/simple;
	bh=i+gs3uxAM4NrcK8GQGaRCurIvld3B3rpD0H0OzamVK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN873Pb++Vhns7HMp85pU/ulW94tnnf7xAMGl8tBPa+c8Ep96ScYhvhEYNP6TbnvtCXf5+a7/ZtKxxwiZWIO07kWET8FPEe2MCMsBz+a5+ENuDzg/nm9VKVJtpQKCxjNypQ/h5qrhE1t+vTDShyXexAjReUYmrmdF6U9lwcdZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl97ZQUV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so71784235e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291812; x=1776896612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAMfpcCYFU/GIrIHMML7LkZ0mvmQIzFEut8whP1Vado=;
        b=Sl97ZQUVq0PGmZyrQAWguapjyvPt5aiNEUKP6uxg6CAr9++BNDgfBopzou/SerKqap
         GOMXhLf/fTTmDWqohonnh7Ci/3R80vC+MBvC9Z+MYVb8OvZjPCZT305/xD8V0I2nZWqo
         F+bRu7pbydJVC/1ciTbjXUq12JkqvWJVP//sciaDtNi71EpPYaPx0SSsu1h+U3cklwMH
         mFKcepwCciPOKYpHONrrfo6LaOlmoyKAkoOmYi0wSZS5HC6LLUFt3M1vPhDDgEFzLj4P
         rtZJYsQg29mLdhkj4NxHZV034eFi/r6RXD6I8px7ibxBCTOZNckWbHVOPWRG3RqjG7Ed
         fFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291812; x=1776896612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAMfpcCYFU/GIrIHMML7LkZ0mvmQIzFEut8whP1Vado=;
        b=cstH09sM2sjdpRDoTK4acq2BXSHbtpkgpEL+Xvk1Q19bw5+jYJvF2TVPaWfP7tODYl
         Y11c+U57ink0GD/+8/iO5/1RYrAs6NPV9a1QRnY5Xq6NHasBNJhjt33dNwKzlTp+v68M
         kIjqh90QlDNEIb+Z3/HYEknqE3hYulmESkkF/P3P+ME7tpPN7bhnpR8QnRcC7/PYONaY
         v00hZtAsJqiDtP234jo47FX2Lzh222wdxWmktQl8EXIEjpV8lLw6UUtIYq1BLeBq66dX
         yPLRV/FuD2ZIJfuKurfaQP6r+kPto+bSj9okrW1kvQhdnaI9C1cBYw5CYpFdhwTos+Ay
         4K/g==
X-Forwarded-Encrypted: i=1; AFNElJ+bkqxMrFwB+QVDGXG5uWbmmWW1RHV984FaoRykXchyzpkNk5NR+tJnO2pxhgwPhsfJOTZZrQWuO/BEYPqzkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fBGMIQ57paVwwQG8L+oVJzjskylLmToyvrYFtxgEABiZwpBH
	ntOVl0ZLt74K1ChB2P05DbSEiAFQI5bmj5urS+DvZ2NvLm+wgozkKP4=
X-Gm-Gg: AeBDies09m6zpAC/pU27zwYyyA1cygXcQj2LY1xzHls8xXcLOYd4A12wyFWMFvhyztB
	AxqFfKuUc5L0Bg6u+wwL00QRAtYvfdcY/hRE6yE0hbzB6ViAB+aX1+7oaeiX6zRofywwix8vS+7
	3HJrsM6FmS02HB5PapIquxQ/QFdZ/mn5TYRso7Bb0JyVjMt/1eD3MfTyjPEgfHgXLFVXleirMeP
	K4L4cMEVa3GsXuuzCRZprwp8DrGa1JlzJyw24XZMC4AWZ3Jrn/neMKcPTtzY3/kbvYCsNh1h6SV
	TLjTgqOiEr9NeOncfO6J+czFyDtJfIVk69OFHZ2MsRbJCMsgHUlVW9oLw+NUO8paTcI9bmuj1j3
	O84G58H3KkFVYQunKnDykC9LVqKfRlf0OnJKcpZSo+mQIPRprux6OmO7k65u5XcIUHXorvHqir3
	SSWNc=
X-Received: by 2002:a05:600c:35c7:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-488d68b27d6mr354703085e9.26.1776291811790;
        Wed, 15 Apr 2026 15:23:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb3842sm30160995e9.24.2026.04.15.15.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] wifi: mwifiex: fix OOB write from firmware TID in ADDBA response handler
Date: Wed, 15 Apr 2026 22:23:23 +0000
Message-ID: <20260415222327.1539269-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222327.1539269-1-tristmd@gmail.com>
References: <20260415222327.1539269-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34830-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B94BF408980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The TID value extracted from the Block Ack parameter set is a 4-bit
field (0-15), but aggr_prio_tbl[] has only 8 entries. A TID >= 8 causes
an out-of-bounds write to adjacent struct mwifiex_private fields.

Add a bounds check after extracting the TID.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/marvell/mwifiex/11n.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -155,6 +155,11 @@ int mwifiex_ret_11n_addba_req(struct mwifiex_private *priv,
 	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
 	       >> BLOCKACKPARAM_TID_POS;

+	if (tid >= MAX_NUM_TID) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "ADDBA RSP: invalid tid %d\n", tid);
+		return -EINVAL;
+	}
 	tid_down = mwifiex_wmm_downgrade_tid(priv, tid);
 	ra_list = mwifiex_wmm_get_ralist_node(priv, tid_down, add_ba_rsp->
 		peer_mac_addr);


