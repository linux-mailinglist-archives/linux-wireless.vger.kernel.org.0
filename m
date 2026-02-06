Return-Path: <linux-wireless+bounces-31619-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPGbDnoihmklKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31619-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:18:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3452100DE0
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B24A33008321
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB33B530F;
	Fri,  6 Feb 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVULoaOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5263ACF1B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398324; cv=none; b=XomAzXM7kfRxyl8r8KRUnsx03wLDLuP7T9jQwiI1ozL35XB/UXS+8WoeWzTrSqYIx4Xt7CQTn+DTlS1/xsy5siehwY/3QGO83geKgJywzBcEyL+bBcmYIW7gB2efNyDfdrskIYFJzEAzX0iz2Noz9HDzHQcTfvmUuYALV99vLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398324; c=relaxed/simple;
	bh=Ru6IwYp9TYf6IwxXA6fm4FCfKEc9vpq6/Nyd8KVSftU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTe5oIbqByaPL2U3mzUpUfBUbXW+TC7J2gtCIfqgjXJuTIbWlnW218i/o3GR0qcBKAxNi5ecpXHyI/Lb65hFxgcb/2viv0KVhVsnhnGFPR6/Cn9IpiD+UBXMJZniAJ9UqVHExdiTh7JjM3z/wZSYDcz3D0QDeBeE1qB/4c7Yas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVULoaOq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4362e77d7fbso498376f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398323; x=1771003123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=ZVULoaOq+0zP2+wmftig+qPpF62hkkSGIkKdYagWE9MZzwhq8zEa6frbngrwEQkBX6
         /ptuQ2gPM9pTEO+7+l6g1T3hPZVx82vWW9e8Y6XA0GArTTpYdlc5UQi73slAszkzT9WD
         jzqrO00O6T9he4Nr/O68uzHTCr3S5z+kCtxGlGJE9jlp23k763GNPaqHG0gRA1hluxQc
         ZzysLoGjoXgrOkUh6vwT9QSNbPlSihpkBnu6Ut84p6Vpkcn+AGlFsMiyjPVNTZ+sS8II
         DkUuHrkzN3S2az4J+ENXJYvD+ohqN0SjA1kh3plMu7wbeV+EW1NukF0CiIbQ85Y1foOm
         GAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398323; x=1771003123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=bewtcUNuruXudRythwsIr9wfqWPnfdCqb9WZMCbJ+fw1ILcZMZdCE5Rz7At6zB7tm6
         V+kUpVShVUeSQWzv8OFb8NODVgUEx+b90smW/7hn5v//cm3KubZfQSki6EobPffs53fZ
         pHohdTv3HUR9CfBajdSbh+1Ohe2RbVqJ0yapf1+htbhB4zjAzxN7w3bX5uFUGJDoTmC4
         LA1hsnMtlmjKTr4H6ggwNu0Y9nlSz8OB49eZOsWXTQ1z7AzHh7kKbmjQ5dZ/kvjiZaHN
         hq0K+EZ6cPp41VzplHfFlvBf6sOVczrj7WM9MTu6K7XyEg8evVhVMB4J62UGCa0IW3Yf
         f86w==
X-Gm-Message-State: AOJu0YyxhS/YW/vqtbnPdc8tVIf7UmSRgFkFF0/QnCnXnFZp1LKQ23Lf
	Pyk757ukmMMUrxPQjjwNx8xKdLZ7LJPYl8KtPlLnIVmp063vCN3aFoGpHAzLt6on
X-Gm-Gg: AZuq6aKWa+gZDU4KVFvyIgqWViPkJTlG508eFftW5CMGOAVB9coTFtihlC14psJ1eIR
	PHrfh00akJ4M56KpAa+cmx85ITtcVu0UvPptorK5qub2h9NmdlVLd7YT/aq7KFq3iYPEd60Vrxj
	YZpu5r84HZ+rQlo0Gj5IslUnWgYb3BFrrJoSLCIfxb87G+iPHKB96y6JgwAJl+uNyr2Hi4Lsn7h
	J0VOktZef1Bq8YG7TfMAMJNYhkYfiigj8JMc+XPQjXr6JjcD5b1ubFynOGn9H1Rd/JRBUlKrqxD
	HYtxUtSHnhNiHUkQb2cn9mycLci/al3T+dP6dPcg9Vq+hq6qxMn4N1UPC73oVucPlhUJhkNT0c8
	XgmqOTJ6ROdIR6lGTENYc0uj/Fw10DPsHkjrZ0UaDkx32eYoIg85XxzCFaYIqagx16l0IahGxYZ
	10d7O3uV5sarArtr5YC/k8VNyv+eHDO2aeDnW9xp4pVp3S2rSr
X-Received: by 2002:a05:6000:2c05:b0:435:95c9:6891 with SMTP id ffacd0b85a97d-4362938aee7mr6429665f8f.42.1770398322350;
        Fri, 06 Feb 2026 09:18:42 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm7986208f8f.31.2026.02.06.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:18:41 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH v2 wireless-next 1/4] wifi: cfg80211: fix background CAC
Date: Fri,  6 Feb 2026 18:15:48 +0100
Message-ID: <20260206171830.553879-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206171830.553879-1-janusz.dziedzic@gmail.com>
References: <20260206171830.553879-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31619-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3452100DE0
X-Rspamd-Action: no action

Fix:
- Send CAC_ABORT event when background CAC is canceled
- Cancel CAC done workqueue when radar is detected
- Release background wdev ownership when CAC is aborted or passed
- Clean lower layer background radar state when CAC is aborted or passed
- Prevent sending abort event when radar event is sent

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/mlme.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3fc175f9f868..212178d04efa 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1115,8 +1115,10 @@ void __cfg80211_radar_event(struct wiphy *wiphy,
 	 */
 	cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILABLE);
 
-	if (offchan)
+	if (offchan) {
+		cancel_delayed_work(&rdev->background_cac_done_wk);
 		queue_work(cfg80211_wq, &rdev->background_cac_abort_wk);
+	}
 
 	cfg80211_sched_dfs_chan_update(rdev);
 
@@ -1187,21 +1189,16 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_chandef_valid(chandef))
 		return;
 
-	if (!rdev->background_radar_wdev)
-		return;
-
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
 		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
-		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
 		if (!cancel_delayed_work(&rdev->background_cac_done_wk))
 			return;
-		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
 		break;
@@ -1213,17 +1210,6 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	nl80211_radar_notify(rdev, chandef, event, netdev, GFP_KERNEL);
 }
 
-static void
-cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
-			      const struct cfg80211_chan_def *chandef,
-			      enum nl80211_radar_event event)
-{
-	guard(wiphy)(&rdev->wiphy);
-
-	__cfg80211_background_cac_event(rdev, rdev->background_radar_wdev,
-					chandef, event);
-}
-
 void cfg80211_background_cac_done_wk(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
@@ -1231,18 +1217,30 @@ void cfg80211_background_cac_done_wk(struct work_struct *work)
 
 	rdev = container_of(delayed_work, struct cfg80211_registered_device,
 			    background_cac_done_wk);
-	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
-				      NL80211_RADAR_CAC_FINISHED);
+
+	guard(wiphy)(&rdev->wiphy);
+
+	rdev_set_radar_background(rdev, NULL);
+	rdev->background_radar_wdev = NULL;
+
+	__cfg80211_background_cac_event(rdev, rdev->background_radar_wdev,
+					&rdev->background_radar_chandef,
+					NL80211_RADAR_CAC_FINISHED);
 }
 
 void cfg80211_background_cac_abort_wk(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
 
 	rdev = container_of(work, struct cfg80211_registered_device,
 			    background_cac_abort_wk);
-	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
-				      NL80211_RADAR_CAC_ABORTED);
+
+	guard(wiphy)(&rdev->wiphy);
+
+	wdev = rdev->background_radar_wdev;
+	if (wdev)
+		cfg80211_stop_background_radar_detection(wdev);
 }
 
 void cfg80211_background_cac_abort(struct wiphy *wiphy)
-- 
2.43.0


