Return-Path: <linux-wireless+bounces-31430-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPiFGAB9f2nMrwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31430-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9936C66B6
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 976F1300795F
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4842561A2;
	Sun,  1 Feb 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJcFI8hy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744F24BBFD
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962737; cv=none; b=pJJcRgH3VpAYcRf+w3EmOVLWYc840nJsG+4s4NRMbvwLjJg6d8OtV9kxVaqU1iI8D7FgPYQqCb8MMTHR7DjBu925FR1i+XE8PW45O+y6eFM5kEE7Rlew55zYGFVkNseuMwWXTDg01ju7oett8FwMUIqimVfx0R0CoIL5Ar7wvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962737; c=relaxed/simple;
	bh=PEiB9GArkctP9eUHBCHxEBtX5qslaCuwlJVSTzTJfSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKLKSP6i4Hc7Qq+Joja0fUgW5055MEr19N5Tik/p36i7N7ggC4SF+Afibf5kk/htBIH1Kl3ht49e8zlANR6Y68daHcKypZY+syFue79rdHLUgVB9fQgOF4gaUix+1al8FmXBfIKmJUR8Xd2g0W4bkwpuQ1aaJASRQN3Ih9E8vKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJcFI8hy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2332400f8f.2
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769962734; x=1770567534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4j6AbSbgBeSoUJmbiiTgDOxMtNo0aQocpdaodPfbjw=;
        b=hJcFI8hyPFuxeNfuiAsS7yWIakKLB8jnxxZMD4CeK5YydLRlviTzBJXFj3wK4ageyC
         pMBzmyrIAKd24z6Nvi1y3CmRM1tUB3BWrJaE4z40BL8uqTFDItn/M49RT0yLgBtPJ+aS
         lO+11dUTmDO0DD89KtsO6uxaM/yFlIcivniHxd6+NpYpZ6o+Go5ZE24OABFGG40S3+hJ
         xB6OprzIddtQsUG3ymT8JTORdIxMnEvTzOFPk4esPeRUAfhKqs5KLMP7Qv8qWFdSFHqu
         e01yL68iEomHYbmJTxRo/qC9FaY5Gtexo0FGcJnvjca85gTPEUeACFS+spNQ0VR77365
         r8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769962734; x=1770567534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C4j6AbSbgBeSoUJmbiiTgDOxMtNo0aQocpdaodPfbjw=;
        b=ZPbPa7MHLn/K2OseNjTJ46duh13BgCDq1WxZcYNpiIZoplNxlCoHlfUMkaSS4h8801
         3JffucMHT98FOAmHq0EePIv920JCnXkrD0LyyV+iaRDK7voYws8gLXh1+4FQPgn/hARv
         BfdurykdtlpMgVxjFHQDzf/aPf3Zn1Hx1T7GvwOXJCRFkdCLaDDgbkiQI7dWDXy+rqoN
         9/ChFT+csuISxkWDlxjgNwep6UFIGmgUjoqhGgAV6EhPg9K8RP61dhV7Cbydqqug04KO
         K6hvfEzC6llnlBBv5GgLqm/jGByu003JLoGAmZ2jX0mC6+L0aEH1zgIA0TPA8QlXTqwT
         S//A==
X-Gm-Message-State: AOJu0YyXKjaAkmiR6+mTUmRokNNdclgtQGvln9I5X8uDCvjJdybVJO72
	QCOGZzKqnccQZxJVUUoPDIGI64TScKM2x723gYEG6RQ4go9Wb+9kif08eQw/Ow==
X-Gm-Gg: AZuq6aLYTlGAawLVRuMN/EoxLCnVT2azbInxkuZsuHT5VXBEKInTfaS+wa6SzK6BboX
	L4uS4l+uYQjkHbeeROqurQ7Q0MZzk2S4n5sU0hZ2WY3Sf8QbpFUEP6YvnoKFqAEkGKq56FS+Pke
	LIGpLQdu7HjhEKOE77sisxdxTdwUgtSGlG3GzX0Z65mrt8DLK/YVKeTGre3zC6v5HRjvYYVTO3g
	tc3LWnGPoWkkoXs+GFHyK24uLNyovzms9R8p4tmnmJM9DBaJwftSZTvcfXQuhtcTdMM65mQ6bDP
	uOeddhF9DU2oVhhLXZyf4Qf11loSNngyHhF1nhGH/HmCQgd7pAV/0lPxPdmhLZ18iBz4EoIFkte
	oC+V6k7UowuDGyPzEP2krSN8ZdDqMpmNzanK+BNVKzqAhN88IyZwGb0oCUk94GzrlwzMSpc5RYN
	DilhzAHLdq45dY1vGWePufyNFmJ56IMKrdOnqq/hf4O2cgYJsg
X-Received: by 2002:a5d:588f:0:b0:432:86e1:bd34 with SMTP id ffacd0b85a97d-435f3aaa866mr13668673f8f.39.1769962734041;
        Sun, 01 Feb 2026 08:18:54 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm36368545f8f.24.2026.02.01.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:18:53 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v6 wireless-next 3/4] wifi: cfg80211: events, report background radar
Date: Sun,  1 Feb 2026 17:15:41 +0100
Message-ID: <20260201161836.16506-4-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
References: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31430-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9936C66B6
X-Rspamd-Action: no action

In case we report radar event add also information
this is connected with background one, so user mode
application like hostapd, could check it and behave
correctly.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/mlme.c    | 6 ++++--
 net/wireless/nl80211.c | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index cafb39596a40..da3786417713 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1226,11 +1226,12 @@ void cfg80211_background_cac_done_wk(struct work_struct *work)
 	guard(wiphy)(&rdev->wiphy);
 
 	rdev_set_radar_background(rdev, NULL);
-	rdev->background_radar_wdev = NULL;
 
 	__cfg80211_background_cac_event(rdev, rdev->background_radar_wdev,
 					&rdev->background_radar_chandef,
 					NL80211_RADAR_CAC_FINISHED);
+
+	rdev->background_radar_wdev = NULL;
 }
 
 void cfg80211_background_cac_abort_wk(struct work_struct *work)
@@ -1330,11 +1331,12 @@ void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev)
 		return;
 
 	rdev_set_radar_background(rdev, NULL);
-	rdev->background_radar_wdev = NULL; /* Release offchain ownership */
 
 	__cfg80211_background_cac_event(rdev, wdev,
 					&rdev->background_radar_chandef,
 					NL80211_RADAR_CAC_ABORTED);
+
+	rdev->background_radar_wdev = NULL;
 }
 
 int cfg80211_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 99b323528211..b85a9b36ec33 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21144,6 +21144,13 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	if (rdev->background_radar_wdev &&
+	    cfg80211_chandef_identical(&rdev->background_radar_chandef,
+				       chandef)) {
+		if (nla_put_flag(msg, NL80211_ATTR_RADAR_BACKGROUND))
+			goto nla_put_failure;
+	}
+
 	if (nla_put_u32(msg, NL80211_ATTR_RADAR_EVENT, event))
 		goto nla_put_failure;
 
-- 
2.43.0


