Return-Path: <linux-wireless+bounces-10128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1892BC7E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4500C1F222F2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6B1586DB;
	Tue,  9 Jul 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YLqma4jS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311D257D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534149; cv=none; b=sw8WW3JfWt86k5l1DcN2z37yogsmOn7izdyAK513TE9dS98OMykTz/WEDuRZim9CIWHLrFyLOsTvv9UHI57zbTkXR2qZET8v5peFi5YN94VPt6bVmyoVBgK4fcsoJNIyMQj03kOoCCSnzh2FP5LJCNswND7kOhMOGZgmoPG2hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534149; c=relaxed/simple;
	bh=tffSv8qDH7y7DlUJY0pyi38Z7ogqBcRplawC7LTOcH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxY+zk+mqT+QyQX7xauWjWviGKYlFooHqNz9F3rftSfih33vECx061qyLx8DOpUJYutYhXRbi2sDNKKJcl3ERwGh1y1Ek2ZNhNWgZaR9K2JSKbJCroxN+onlKKJu5kngKstTRnZk8qsPhJdSvGmhzDyjGEKxD0p/qSEmZZjOSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YLqma4jS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=1LH1SW4ax4711VUrbAUa8dtLI00EEhqiPA0c8wNl6hY=; t=1720534139; x=1721743739; 
	b=YLqma4jSAOGyd9g4NPvTYOiq936HZ7brGPA3Oyd5893Ll6TGFT8K0SFbsnW+murQZ1Ev5fLNKkm
	8TKM2jDUO+VnWzM2WuMyNtc9s70+OlwwIl8XNqAnLCiUgAWU8LvBCAgE4q6zULM0NTtJHgZWJmJqi
	txYEUwzUxKUfI5eVjaXyMCE0QPHXzzOXs0WfCEediYCQkrIaMPSwBZYUTDgSU4Qwt7PSZYyoVef9B
	bwpeM+7WCGn5aIZds95YWKMa+hhvJ1XcIRpqEfFFgbTC0qDnkawQ8OllzldpeDuqrG5KokCHaKKLp
	gOSzKuxNeRUUmbGojtD3NvVl+jKG8sP/vN0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sRBWZ-0000000EF74-0snX;
	Tue, 09 Jul 2024 16:08:55 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Jouni Malinen <j@w1.fi>
Subject: [PATCH] wifi: mac80211: fix AP chandef capturing in CSA
Date: Tue,  9 Jul 2024 16:08:50 +0200
Message-ID: <20240709160851.47805f24624d.I024091f701447f7921e93bb23b46e01c2f46347d@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When the CSA is announced with only HT elements, the AP
chandef isn't captured correctly, leading to crashes in
the later code that checks for TPE changes during CSA.

Capture the AP chandef correctly in both cases to fix
this.

Reported-by: Jouni Malinen <j@w1.fi>
Fixes: 4540568136fe ("wifi: mac80211: handle TPE element during CSA")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/spectmgmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index e91ca4ccdd37..073ff9e0f397 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -343,6 +343,9 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
+	/* capture the AP configuration */
+	csa_ie->chanreq.ap = csa_ie->chanreq.oper;
+
 	/* parse one of the Elements to build a new chandef */
 	memset(&new_chandef, 0, sizeof(new_chandef));
 	new_chandef.chan = new_chan;
@@ -369,11 +372,11 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		validate_chandef_by_ht_vht_oper(sdata, conn, vht_cap_info,
 						&new_chandef);
 
-	/* capture the AP chandef before (potential) downgrading */
-	csa_ie->chanreq.ap = new_chandef;
-
 	/* if data is there validate the bandwidth & use it */
 	if (new_chandef.chan) {
+		/* capture the AP chandef before (potential) downgrading */
+		csa_ie->chanreq.ap = new_chandef;
+
 		if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320 &&
 		    new_chandef.width == NL80211_CHAN_WIDTH_320)
 			ieee80211_chandef_downgrade(&new_chandef, NULL);
-- 
2.45.2


