Return-Path: <linux-wireless+bounces-31572-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLKSEywUhGnQyAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31572-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 04:53:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3CCEE6B0
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 04:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF643012278
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 03:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4192E7167;
	Thu,  5 Feb 2026 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu26q0Go"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DC17A31C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263563; cv=none; b=ng71FuIfwKz+3sd7GEcsRGtIkvw4GmmST5B8TKL8wniYhdFZHGwgl/NGbEkEtnt/mcLghOmKPnlHkvX36Ytq9hTIihNXV3ve9D9NnjX4BbeB15pWDwO31hECHPBat1COmV6OOZGJEMccpi2U/Y1CCNFN5jVQN2G22xVmOy8WBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263563; c=relaxed/simple;
	bh=he/euZIb+7nGDowd6ofIEKauu0OYEXlKSqHjuCdgq2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmSi4o7F5NW8oN3dBx5QCgJ/ULy2dSIWspP6TuWX3hzBWjM+MCYjWCSfQzKz7n8Sb8rEJezGR0T8g9m9d6kdB/pfXlRVCDtv23IxI+O3IeK1hqahUUgzAtJw2tWBfPWlM04JzkZ0FgcUYpokBT2K7E5Xb3EWbknjEWA4qPtDAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu26q0Go; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso290192b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 19:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770263562; x=1770868362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+kdKXzJ6z8gg3py8m3rnJr90/PdPYODZxYKzc7gJDw=;
        b=Qu26q0Gov3tSLkc41cxFkh2rskN0jjXMWgoOAtc2cVnH2Slx9eL5yrOU7ZQyIWyyYw
         /CPtk0zVd/rNePQ5JVsafFJiDbllWqXvpgJA8hA0oZqW2Yz4Dak1PyArzcWappQZ+CkG
         fqXKuNQ8+zbSFbpasIJ5EGXa9sNOhR2Cc6LJGYxrmKXQ0YuAqToTn2xoxUVnJbSHYl7d
         +LZagpdCmfjOZBXihnwWy8P+oJ4anhPT+yG6T5wm7II0Je5vP9/PAag8qWoVJaTOMJKP
         KWGt9wK0rk28rMjf10+Ga+cJWlC2cpJCJr7okrS29u6PFewdEaC7r4c71rxbFXHLtkGJ
         zUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263562; x=1770868362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+kdKXzJ6z8gg3py8m3rnJr90/PdPYODZxYKzc7gJDw=;
        b=GrL/NkBrEfaEIrkkwfHUsx8c3ptpjoMKKG5nSP6KFuu/C/z4nGKobwRouEuAJaXcNa
         aBa7Fm2zs53KE4hlF1GTii3crskEVgyUcWhQrbwu7OdcnzCNKN7GvHjKwfAI09NrzeCS
         ji94mIiPvgkKg1vvteK01hg0SGXbG2kGbARqoexXf6SxwHnGxYzndDlrLxOmjEWuAqag
         VlZsoCFomiIAzKejR/4wOwxD0y8AwwFazS1QXfVB8YUL2HGlLFEXRtPw8T3BF0ieiV1g
         s73S/O+3Jq/a28l5M9TH9P/ddFXVF4l3Q8gg3pu+K9TS1p6ne5SkuOicJ+mufDupts11
         5NmA==
X-Gm-Message-State: AOJu0YyKUZDi8+7qexwIQP9qlekiTnveacDGoRn0HDJhNaHELG8i8bft
	C1ds0e6oZpOjnjlUHE8mk025JzyFHjitM6KjZpej5bBceSKRvWauNyaF1Sx7zA==
X-Gm-Gg: AZuq6aJieZ6V8YYN1U1nhcXd1FXF9gz+WdCS+1c0A09NOODuO54gVgusAPBJMhnIiTW
	H2JRIpBORDDbWnMSZxwhkvUXms3OznyfZ/CIaHR/EeAdKpDa9GWEPtbP1OiJWY8FBJ1WNoEgCTt
	Vf2agfXHycxv6W3kPSm5pMrDVs0glLSwt5LRXZALbK6ZBobNjj69WJoWYiS1Zx9K9QeuN6x22O4
	EPcmSlDU5uMswSuvh3rIUasreqUrssaZBw7Mo14TqcuhzOw6UBZAKD455hFSWBBd8C5Ppr0qbYf
	iXWPeAnty/BxeV95ta80V61DMlOn20h+0KCIfgCvapjaKn4uHrL9WDvNW8uePm3Hz3w/xkUDxAN
	k/o4h0o0R4EJy/GBQJWX8vaMvoBVR2+7ltzlfnoSDWOVCm5TxXmJIWgUZYUStVsTSbWf1O6R3cZ
	IwsdVBUnQEvW4=
X-Received: by 2002:a05:6a00:3d54:b0:81f:44f9:7c1a with SMTP id d2e1a72fcca58-8241c188060mr5723484b3a.3.1770263562235;
        Wed, 04 Feb 2026 19:52:42 -0800 (PST)
Received: from mint.. ([2401:4900:7925:4bf8:455e:d5c9:a17:3da7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d435319sm4018523b3a.33.2026.02.04.19.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 19:52:41 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dhyan K Prajapati <dhyan19022009@gmail.com>
Subject: [PATCH] mac80211: fix NULL pointer dereference when switching to monitor mode
Date: Thu,  5 Feb 2026 09:22:23 +0530
Message-ID: <20260205035223.20411-1-dhyan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31572-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB3CCEE6B0
X-Rspamd-Action: no action

When switching an interface to monitor mode, ieee80211_link_info_change_notify()
incorrectly sends BSS change notifications to drivers, even though monitor
interfaces have no associated BSS context. This causes NULL pointer dereferences
in drivers like iwldvm.

The bug occurs because the current code only returns early for monitor interfaces
when WANT_MONITOR_VIF is NOT set. When WANT_MONITOR_VIF IS set, execution breaks
from the switch statement and falls through to drv_link_info_changed(), which
triggers the crash when the driver attempts to dereference link->conf->bss.

Crash trace:
  RIP: iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
  Code: 49 8b 46 10 <8b> 10
  RAX: 0000000000000000 (NULL link->conf->bss)

Fix by unconditionally returning early for IFTYPE_MONITOR, consistent with
IFTYPE_AP_VLAN handling. Also simplify by merging both cases.

Device: Intel Centrino Advanced-N 6205

Signed-off-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
---
 net/mac80211/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7..bc93df21e 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -412,11 +412,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP_VLAN:
-		return;
 	case NL80211_IFTYPE_MONITOR:
-		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
-			return;
-		break;
+		return;
 	default:
 		break;
 	}
-- 
2.43.0


