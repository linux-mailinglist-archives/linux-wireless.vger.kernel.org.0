Return-Path: <linux-wireless+bounces-7254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36BB8BD5EC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9546D1F22A22
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA215B10E;
	Mon,  6 May 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U2fDjDRG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09915B0EA
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025352; cv=none; b=mImUt2H7kceq/Fa6wkg/RP5H8E+ft7U7tfp7b9Nf6QEkpuPIgG7vsJodV9LG5yhvU4+dSmEIAn4ybGZhTFlaEwDnO62xi36SmEDxgQHdnZE0im0Q7+TksTVJEpP+PyCPawyZaZ5tR+YlbHTlcZstsExduTs3pj20xYb0EH9PXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025352; c=relaxed/simple;
	bh=kvSQaOgFsSO5D8bzs5eW3nVVKhG3jzfxToGchngpd1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAzOLhA1wFm5rLTnamfQLglX7UKFwLuFPHY/NX8teDEN2KfOOJRtxXpYtr/gF13i1BtEAGtr7nXbfPYPWKN7F47KnWPRHURTnom+7etYk66un3h3ZxVnzyVkiON3MHeJkkpRi6oxiqXjb8VS0ttXUMp58lhUSnwYx56PAcXdAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U2fDjDRG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rNeapsk451lAvrsk8HiDljg4BOIvjs4trPTzCw1kv2s=;
	t=1715025350; x=1716234950; b=U2fDjDRG72srKmNY+bJeYXFExjk5Mr4lEIMSUVBx6g5PJRQ
	7R54XGfeEG3/1gpXY71JtRhBS6Ni5UcucGqJeG8uEVZfG1h1U8/cOns17RguWxStUUOpZOsawfA5j
	9yvtktFv1M96dYQFs3deCAHOyF1Dlb/56yCFWIZNP75n1B4FbTEaAqPYjOFm7zS7Bm9hz5D212Ds3
	pi+HMf7dY+kqurAysxljZpyAiSwo7g7IWSyj27tAhckj0S8DWnCeH1s+jsg4i0DzPQ6LrBag5p4gc
	DiPwzfmDB3qZNKH1i2BFkDwEEsBTioF3AqmVCL2KsQdyQyDBxt2Q3fmydlk3ZQ4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44R9-00000008Cj6-2kmC;
	Mon, 06 May 2024 21:55:47 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 4/4] wifi: mac80211: refactor chanreq.ap setting
Date: Mon,  6 May 2024 21:54:52 +0200
Message-ID: <20240506215543.5cd6a209e58a.I3be318959d9e2df5dccd2d0938c3d2fcc6688030@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506195543.104411-6-johannes@sipsolutions.net>
References: <20240506195543.104411-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are now three places setting up chanreq.ap which always
depends on the mode (EHT being used or not) and override flag.
Refactor that code into a common function with a comment, to
make that clearer.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 77d690323006..ef3280fafbe9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -789,6 +789,29 @@ static void ieee80211_rearrange_tpe(struct ieee80211_parsed_tpe *tpe,
 	}
 }
 
+/*
+ * The AP part of the channel request is used to distinguish settings
+ * to the device used for wider bandwidth OFDMA. This is used in the
+ * channel context code to assign two channel contexts even if they're
+ * both for the same channel, if the AP bandwidths are incompatible.
+ * If not EHT (or driver override) then ap.chan == NULL indicates that
+ * there's no wider BW OFDMA used.
+ */
+static void ieee80211_set_chanreq_ap(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_chan_req *chanreq,
+				     struct ieee80211_conn_settings *conn,
+				     struct cfg80211_chan_def *ap_chandef)
+{
+	chanreq->ap.chan = NULL;
+
+	if (conn->mode < IEEE80211_CONN_MODE_EHT)
+		return;
+	if (sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW)
+		return;
+
+	chanreq->ap = *ap_chandef;
+}
+
 static struct ieee802_11_elems *
 ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
@@ -886,12 +909,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 
 	chanreq->oper = *ap_chandef;
 
-	/* wider-bandwidth OFDMA is only done in EHT */
-	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
-	    !(sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW))
-		chanreq->ap = *ap_chandef;
-	else
-		chanreq->ap.chan = NULL;
+	ieee80211_set_chanreq_ap(sdata, chanreq, conn, ap_chandef);
 
 	while (!ieee80211_chandef_usable(sdata, &chanreq->oper,
 					 IEEE80211_CHAN_DISABLED)) {
@@ -999,11 +1017,9 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return -EINVAL;
 	}
 
-	chanreq.ap = ap_chandef;
 	chanreq.oper = ap_chandef;
-	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT ||
-	    sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW)
-		chanreq.ap.chan = NULL;
+	ieee80211_set_chanreq_ap(sdata, &chanreq, &link->u.mgd.conn,
+				 &ap_chandef);
 
 	/*
 	 * if HT operation mode changed store the new one -
@@ -2535,10 +2551,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	link->u.mgd.csa.ap_chandef = csa_ie.chanreq.ap;
 
-	link->csa.chanreq = csa_ie.chanreq;
-	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT ||
-	    sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW)
-		link->csa.chanreq.ap.chan = NULL;
+	link->csa.chanreq.oper = csa_ie.chanreq.oper;
+	ieee80211_set_chanreq_ap(sdata, &link->csa.chanreq, &link->u.mgd.conn,
+				 &csa_ie.chanreq.ap);
 
 	if (chanctx) {
 		res = ieee80211_link_reserve_chanctx(link, &link->csa.chanreq,
-- 
2.44.0


