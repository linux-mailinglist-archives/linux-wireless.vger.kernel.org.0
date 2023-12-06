Return-Path: <linux-wireless+bounces-513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB5807A98
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 22:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5122824C2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4370976;
	Wed,  6 Dec 2023 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HCIm+649"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D483F7
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=n0Jcmc3nKkjYHcz+Ls08VACQCoIcq+YPGfMAPU2iSGw=; t=1701898686; x=1703108286; 
	b=HCIm+6493quu7pEsC9B2wIwgaQ1sn0B6O3sfp3xqYZhMNm9kz3WarKq8p0bmwAqDFgdYn0UiS3h
	ef6TUHYL/kqks8twXHD5ZKrejw0/RlO9hX5Gb1jAjjtiXgNZicVjP+I+GAL3N3vnyAt1CijH5JGJ9
	QvmYJK8AzohuAfljcVrudZsvYSRj+CZBQHivecw9CtQ3vUAbzHOBFyEk81NVBiTx51e5CdRFgFAnR
	g4JBjg3lujRmappVhFxluK+DxjhCDogB9ddbqzIWhT1TnuzLZ4mrOzoV/nxbRPxq7+D3rpt8w1j16
	IR/lnrsQPEtpcAOyWuqui6nZTJ0DX7arzBNQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAzal-00000000JAJ-2dnI;
	Wed, 06 Dec 2023 22:38:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Jouni Malinen <j@w1.fi>
Subject: [PATCH] wifi: ieee80211: don't require protected vendor action frames
Date: Wed,  6 Dec 2023 22:37:57 +0100
Message-ID: <20231206223801.f6a2cf4e67ec.Ifa6acc774bd67801d3dafb405278f297683187aa@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For vendor action frames, whether a protected one should be
used or not is clearly up to the individual vendor and frame,
so even though a protected dual is defined, it may not get
used. Thus, don't require protection for vendor action frames
when they're used in a connection.

Since we obviously don't process frames unknown to the kernel
in the kernel, it may makes sense to invert this list to have
all the ones the kernel processes and knows to be requiring
protection, but that'd be a different change.

Fixes: 91535613b609 ("wifi: mac80211: don't drop all unprotected public action frames")
Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c2ac9e9e7ee9..2b5e500bf093 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4447,7 +4447,8 @@ ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
 		action != WLAN_PUB_ACTION_LOC_TRACK_NOTI &&
 		action != WLAN_PUB_ACTION_FTM_REQUEST &&
 		action != WLAN_PUB_ACTION_FTM_RESPONSE &&
-		action != WLAN_PUB_ACTION_FILS_DISCOVERY;
+		action != WLAN_PUB_ACTION_FILS_DISCOVERY &&
+		action != WLAN_PUB_ACTION_VENDOR_SPECIFIC;
 }
 
 /**
-- 
2.43.0


