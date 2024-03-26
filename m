Return-Path: <linux-wireless+bounces-5303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F23088CF34
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 21:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DD9B2C611
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3812B151;
	Tue, 26 Mar 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QExyMkjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480C3DABF0
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485546; cv=none; b=BHmiibvSKiNbvrXRmCjEFqRssO8BAdrXLU5zpKYQYXJew7zk9gj7Dg7eK3NCNR72a+gYLb6/cbg7H1A/RdEqHlPF/SzMX+wuf3Q4nphXCbVR2sgBohGMOvlVPjlY9uI55gXccSpbmSmg/4DFi6HHzU7mLpuvKCLs8ocxEuVHgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485546; c=relaxed/simple;
	bh=ec1iZUWICRrY3BnFaAg4nVTMTosH7b+7vtLa3x1W1t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1xLjsp5VT/XuKpEyluRvw9X0MDlgq5pm25orV/wAESm2FmyO4cbqwH14E+58NfWc+in7FvnTveMRotnazGqbV2H7zfw5mXb1XBNtCv2DJXxSOuP6m0wOHG0YzNqF6FOUTCUCZQ+PUhxyI3hTqkn7Q09YXOAWL4KNhUBYGmjqi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QExyMkjn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=mIIGLinBxYbnxOYibGp7xqZdSaNB9FBeNNDKE73ThnM=; t=1711485544; x=1712695144; 
	b=QExyMkjny1pIK9bZJFtfjSFmNKMgQo5MDeptnFB1xnMWncsUY7Scq3WiwXSs5qnLcqIYJUP2h66
	h7lqRpzFg3ZjvZxSWVgCZnrYd33jWzPlNM8QBdGrhVNKwR0IFaGMyUZNqGEHCEy49P75xOO3K5+aJ
	g4ijsWUZlCE6SzDrBtBgx0QYUji0G4mKDnX2Ze9tQtfPLjM1mbWYBhrabF1kzZTNaaUHPQRNbSzb2
	SKtlOAj89M0EhnlLyBoehE2tzU50oENjQFae0lP3A3z48Kp/fE8E6jcSwvocr1pzX4VX7Pe29VGnr
	V1YRDZNr4opVidNV1Xfz4WdASEZOojDOjhgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpDZU-0000000FyOY-35Rg;
	Tue, 26 Mar 2024 21:39:01 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+75af45a00cf13243ba39@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: check EHT/TTLM action frame length
Date: Tue, 26 Mar 2024 21:38:58 +0100
Message-ID: <20240326213858.19c84f34349f.I71b439f016b28f65284bb7646fe36343b74cbc9a@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Check the EHT action frame length before accessing
the action code, if it's not present then the frame
cannot be valid.

Reported-by: syzbot+75af45a00cf13243ba39@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000006c06870614886611@google.com/
Fixes: 8f500fbc6c65 ("wifi: mac80211: process and save negotiated TID to Link mapping request")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c1f850138405..685185dc04f9 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3780,6 +3780,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		}
 		break;
 	case WLAN_CATEGORY_PROTECTED_EHT:
+		if (len < offsetofend(typeof(*mgmt),
+				      u.action.u.ttlm_req.action_code))
+			break;
+
 		switch (mgmt->u.action.u.ttlm_req.action_code) {
 		case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
 			if (sdata->vif.type != NL80211_IFTYPE_STATION)
-- 
2.44.0


