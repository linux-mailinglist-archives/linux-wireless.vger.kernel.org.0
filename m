Return-Path: <linux-wireless+bounces-25853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19040B0D8F2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC123AA4B2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35323ED63;
	Tue, 22 Jul 2025 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="VIdw+lgC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A6C1E32D3
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186016; cv=none; b=OhkTEzAk7VKeKW1e8nwOcypPDjJm70SOucQbasA7X5xdK8Oke5H972LTqKYjN3k1MVMTuoAkjYmgOMBzYFxZq74rJ30cfC8f/vbrLTipOfQxLMLRQWJKdeH1lxJNUbioLy9tEC/vY0S2yB8XulD1uFnQTxMj8dYJWSsVkzX+1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186016; c=relaxed/simple;
	bh=ppJMt2dX6PAKYQDivifbqD4Uw1+58CCKGhF2zyZHKCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5mgM5BLuwTRe7yeTWyAMneN6h1swNR+EL4I7hUE+8/BAxxu0iGLgY73KUpWXdXmfEVvcw9P4bGUbPzZWlvvPwcw4o+1nHvSvLN/FMIxQTA+toWV9h7Rksk6rri+xhU9qPyuVXcKtKI8IFsmz9/Yuqv72/xWDORkeLvoJBRVcIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=VIdw+lgC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0c4945c76so731419866b.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1753186013; x=1753790813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5mkJg7GFi/pdCb1VNqRCvZk8UTn9rWH4WjLudKOVEg=;
        b=VIdw+lgCt03vgJzj275dVAAJhGVu9EEXQzPnE4U9tBdNik61cxUSGeCEAJgpJeAx+S
         d+OeNGKjzo77LjUE2k1cXo/qWj7rVBkjqWP/nVTJ46TkFbIYCSBexssMAxF7D4KVlgN7
         Tdo+V4OB1IA9YL1sUwh/HP0lFC1SvavfqKvPJvb2dZUfIUocn5S+qeY5FkzM/oOjs77O
         tgC7ZbCYMHQ7H5wvRrXsaYC/XB0Khfj7swvZ5ToQD3d+6Q5WsRQZzYvtLp7vYx01fvJY
         XrEnUSNe4BRBBXqS2nSDgrCbG3vH9wlq25JkGEXJ18QB8MOUBHEmK1nmVNKWN4E63Zu8
         rzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186013; x=1753790813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5mkJg7GFi/pdCb1VNqRCvZk8UTn9rWH4WjLudKOVEg=;
        b=BlJ6HoqywqFNXSsmk08kbJtc4/nzc2VTVFQohh54mtiqUKb1oNkOs7ugQVSQHL/ZKM
         N5YSA0f2V4XDBAWPfXebFcoTzOTPWFyrAEwdst40dlYmYPQyDN3dPPa2SktVH+4ZSXM6
         cFT0Olt/GlAwFOtg6+11IWYTp+dD2Dpnu9+SxJvIlhtFHv4bLPSeQNPVO/IHqlD+RDqw
         xF2imX/nMahfGTlEzxs2DKi7gIuKJfICSxvOk/P3X25Q9lcf8n+sHpPje/hVK8bBjUDf
         nPtSeI349DCz+7mKsRNQ2N073rma19g0on860tZlb8uVROxfoEAaeU/sWvNJnm3/B83G
         sTVQ==
X-Gm-Message-State: AOJu0Yzq66kWmyNbUZUg+FWrRio1nVNnkafqQSs6lOE3KzhGiYmrfl3v
	yNnNmaSq2AV9tzsRWfLKer0CXt6UpMic5AMb4HAjd76DCFnKL8bs6V43k880zNZRBBkndSUJdPv
	PUR0RFBE=
X-Gm-Gg: ASbGncv/wybdtHZrGT9+mIVK7ScQFLD5u+bcy1WkGT86hbH+pxHCvi45UVrr4hboO0J
	A0uIdWTcuekDOyw/ufoe1vDzANFL78SM2pKdfbUMiOSK5jg0mwpy2v7gQMlxTCdVlxTVzQWOfQI
	E0yyGi+1O/sW+FWNsboEhUPe0ZiuwsjVu0EcxMfVFSgQsNgRj5E/bnv5P4TVymD7rSfx+Ug3H0Q
	YYBDtwxn+4q+x2u0TMOqcVExTpXEBUkm/L6RiONwHGBHXw3LPB/mP4VRELsM2UJX+xmH+VUbPs8
	Mj/eBsN6r+pTmeAFQehDh9iBlGgyipp6P7RhNe2XGSKPMosGD7ReS+WZJg2Pn0vRXx+7nTnk+gm
	7iRN//MJaGkqFRCFoTz/BvlIJfyMkNljvpiAcb2LUTYTxLd0=
X-Google-Smtp-Source: AGHT+IFY+W0g2+ARl1K60fC5/NOcbMDvLLSr1TUptiEP3fhCaU8AvVNTTpKwCh9S4NC8Lkj1Aipthg==
X-Received: by 2002:a17:907:a647:b0:ad8:a935:b8ff with SMTP id a640c23a62f3a-ae9ce094585mr2531812666b.31.1753186012840;
        Tue, 22 Jul 2025 05:06:52 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:b6d9:6def:525:5a1b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca315d5sm858552566b.98.2025.07.22.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:06:52 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-wireless@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH v2] wifi: mac80211: fix unassigned variable access
Date: Tue, 22 Jul 2025 14:06:34 +0200
Message-ID: <20250722120634.3501-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ieee80211_latest_active_link_conn_timeout() we loop over all
sta->links in order to compute the timeout expiring last across
all links.

Such timeout is stored in `latest_timeout` which is used in the
time_after() comparison before having been initialized.

Fix this behaviour by initializing the variable to `jiffies` and
adapt surrouding conditions accordingly.

Note that the caller assumed latest_timeout to be 0 if no active
link was found. This is not appropriate because jiffies=0 is a
valid (and recurrent, although not often) point in time.
By using `jiffies` as default value for latest_timeout, we can
fix the caller as well.

Address-Coverity-ID: 1647986 ("Uninitialized variables (UNINIT)")
Fixes: 1bc892d76a6f ("wifi: mac80211: extend connection monitoring for MLO")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 net/mac80211/mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b4b7ea52c65e..1008eb8e9b13 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8521,7 +8521,7 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 static unsigned long
 ieee80211_latest_active_link_conn_timeout(struct ieee80211_sub_if_data *sdata)
 {
-	unsigned long latest_timeout;
+	unsigned long latest_timeout = jiffies;
 	unsigned int link_id;
 	struct sta_info *sta;
 
@@ -8554,8 +8554,7 @@ ieee80211_latest_active_link_conn_timeout(struct ieee80211_sub_if_data *sdata)
 		 * is still active, and it is scheduled to fire at
 		 * the latest possible timeout.
 		 */
-		if (time_is_after_jiffies(timeout) &&
-		    time_after(timeout, latest_timeout))
+		if (time_after(timeout, latest_timeout))
 			latest_timeout = timeout;
 	}
 
@@ -8579,7 +8578,7 @@ static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
 	 * If latest timeout is after now, then update timer to fire at
 	 * the later date, but do not actually probe at this time.
 	 */
-	if (latest_timeout) {
+	if (time_is_after_jiffies(latest_timeout)) {
 		mod_timer(&ifmgd->conn_mon_timer,
 			  round_jiffies_up(latest_timeout));
 		return;
-- 
2.49.1


