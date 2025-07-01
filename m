Return-Path: <linux-wireless+bounces-24704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FCBAEEFB1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 09:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127751BC5517
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05501FBEB6;
	Tue,  1 Jul 2025 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bpnj1ypR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3A1EA6F
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354560; cv=none; b=S4YrDPd1pdieWQN48H25ESO+gzierADGpecn3RUh5fJBmELDSHbYlpwFQ9pVMdrqng5g3qRUvLh7IHBSBLm3P4GXFdtgrto6xG+IWZN6WzGfdBI1jVHewJ6v2sfBnP40jZoDZRwR3x7uLO4rZg3AEOB502NIm0OCSXut+mEb21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354560; c=relaxed/simple;
	bh=od3iQ7ZD8oYQim+PQNyTs54c/ZSkyiDQigG2CXmbn6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gs6S/OPKrCvdXGgj6SGXoC61yAXpMGz8akCO0OUKHWVNU3g33+DNaxCILuzFnXke+lKSQNB2sgdh98kFnu21s0HVvXoI/RhOgUG2HPeWHvWeBsXkb+ju3hXbjQyUXKe6mDsT5PrJLuX8FZpbdQwjfJewD3l9SVbMmdoRBMdsf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bpnj1ypR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=aZv6CRfQhKdVyrwO7ewKeaR4JcujBpo2jdf5mdCkwBs=; t=1751354559; x=1752564159; 
	b=bpnj1ypRraGVtMwUTWz191SoMC9o+y39MBPUw7LayuYaNrg3Eot+6zvNbeUAYX9c4u+vS5nLWN5
	VURELLCYT8LAS+q59eCycz3N1WFNHqLrlz0vVZw1r+WSnCiuTV7hDktnOAowdNeBW0fDjwJYW00WW
	gnUY6FcTCQBqWUm9PguaVA805TKM2oEB7fF+cE9oC7GZB395vNnlVrRmTB+tbr0EvkPaLijpUFv1X
	8NjJdb+lPNaIVqruKtacsxV5gNKHp5rPMp+R6X5GkF9PyzI377ifd1SAd+Q+aAttmwa+RhKwFIc2r
	iw0OqH/m61lzxu4XTwbMeBvSxHXi9qcHQRVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uWVJs-00000002Xyo-0Uug;
	Tue, 01 Jul 2025 09:22:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>
Subject: [PATCH wireless v2] wifi: mac80211: clear frame buffer to never leak stack
Date: Tue,  1 Jul 2025 09:22:13 +0200
Message-ID: <20250701072213.13004-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In disconnect paths paths, local frame buffers are used
to build deauthentication frames to send them over the
air and as notifications to userspace. Some internal
error paths (that, given no other bugs, cannot happen)
don't always initialize the buffers before sending them
to userspace, so in the presence of other bugs they can
leak stack content. Initialize the buffers to avoid the
possibility of this happening.

Suggested-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: don't copy-paste the entirely wrong thing for the size
---
 net/mac80211/mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2d46d4af60d7..b707d61c1fe0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3934,6 +3934,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (frame_buf)
+		memset(frame_buf, 0, IEEE80211_DEAUTH_FRAME_LEN);
+
 	if (WARN_ON(!ap_sta))
 		return;
 
-- 
2.50.0


