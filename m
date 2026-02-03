Return-Path: <linux-wireless+bounces-31509-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBhXOINFgmlHRQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31509-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 19:59:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F35DDFDE
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A40E6306D51C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61635367F3A;
	Tue,  3 Feb 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmVoVw4u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F736681F
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145057; cv=none; b=MFkUvYtaSy35CqMxNBpLFs9Q4SNdt08eNpdc2actA3FoefKPq9TtiT314NPwhClMKCO3dd+H8Qq2nPP7e5jAOLadlfP6/RPC65/0lvsPwtRosXqmuAJ6h4TbQibTs689N57FtkgavehqgqHhQiIJnxOfwQDyzzDToLBaFHmIZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145057; c=relaxed/simple;
	bh=FpjtRTv1JkiB62graPYMcCm3s54/vXGftY1TQ9lnK3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uD3HEZMg97eAAsPDS5usOeaTQCC1ox7/CaRrHS22fC2389/HGYIlhgX5DF2xogTvV74mqBo6N0kAkCkS7vSbc7LBpycbh1OSOWCJuSrvZbeTbqsmsIadozbrpgwPbKKveQZEBKuJf+FA6pZKFvPyEtomi5MwSlZtZKfoWPAZS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmVoVw4u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f454be5bso1335565e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770145054; x=1770749854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeq1YM5Rd+oFYWz9SrKmF39kI/NHYmHuVKaReNxDYk0=;
        b=QmVoVw4uNjSSngHJFVuDJpkWo1enB/FET9nUgQ8q89Usmlob5GVJmbfCPgRetWzu/A
         89nnjQ7S3XaZ4rvAlPEMSzkUZCk/2KrCCABAu0QC7tkaPkdggbQx31XnebjVIeoGZXXH
         eKeDpwxrQEWUeGBFE4f71A+Rj6jfCql2Zu1T10Hjf+8eOm8eWTo0tNi2oi8DDsdl4/iN
         TODvbIc4tlZUQbYoDPzWSZ0txU9YfRhCaqhw2LMur2VIlnh3Nz2kwTdOXKbVs096kKxT
         +GpzQRnwUEPxDKuOAnv6FXbcUve3am9EIyUpYfEJoYFxI9Yl2BZC7T7O5Z1L3+cc0d6C
         GLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770145054; x=1770749854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yeq1YM5Rd+oFYWz9SrKmF39kI/NHYmHuVKaReNxDYk0=;
        b=Qj6MGMKfw3luo75cc++SOrSsW5H2EFhVXpXatlw45OU4YnOvwlYqfVOlumTcC6l8yY
         OdC91Z1S9j/xvsDZPxOe3zMVhwOLrJp9FaJRGcArrhKzQ8vtLhttQw5VBJeO9+eEDVCj
         RBh1aj0Zy7X9lMS1/58WBmSeVVNIgmEHD7AxboMDO/cDmBGQ8McAdYH0Byon+9L0gM5c
         zLjE1XazV+cX0OGWxrMAx19qbwj8so6Helfonn84VK045QKW09Xu110i0Dyr8SuP5Blf
         josP9nR6vilUMXYe7FMNQOfuAxHxufioWYDmnsEHt1+KOMdNN0woxex2k4ploO3oNFrc
         1VZg==
X-Gm-Message-State: AOJu0Yyo1iRCq011BIDMjJ6VxRIcHlufs+SQpyLjjSxRU1kQzDygW4bW
	EkDuwJt+qTLSbrgFH8VSMpXkJJw1H9yyS8Sj8LDqfF7Y2x7g+yq8eJAHSr0R6g==
X-Gm-Gg: AZuq6aKdnAhPBmXRe8yrqry9RQdD2che3akvEkW6oQsn+vmyLK6INysGgR4eDdaraAb
	r2mCGGDO/hnMWg1Feu62W5V1A8D8Ut59led2M2RJgSjMgzwFBMVO+frqst2fmzw/M/9UktJJgHo
	cueZ5Q5170/B/ILpFv1YnnPNN0j7w/d6wkFyMNUM0NEmn1cBlVhcQD2xXkw9qnGXnn4U9TccFjh
	gTo0dV5e3DYDhBj/KYy9gFP9/ksx7C9/dMpdkXnQ4OxYszrcsOkCetLGYA4VdQKsWEDSfwAmqe1
	tualV90ToJO1oIX58CHBqNzAdgBtLC1lsIinBLBZaqR3sxraZqp3V3sJ6RYKKqO0owqxU44ETHQ
	oT8okK/kD4pLOa71WlQ3mMdhFhjZ1JEMZRaj3aZWWrlIQTmYzBhTKta1nLxLQTyCmaGtyuR+1Kn
	2m7pFCj9JelilPs4yyVy3tyIuztF/2kv0gZXXjqdaKZfJmNOp5t2SaeJO+0Bw=
X-Received: by 2002:a05:600c:34d3:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-4830eb32a68mr5726245e9.8.1770145053996;
        Tue, 03 Feb 2026 10:57:33 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830eac4d11sm7773425e9.3.2026.02.03.10.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:57:33 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH wireless-next 3/4] wifi: cfg80211: events, report background radar
Date: Tue,  3 Feb 2026 19:53:48 +0100
Message-ID: <20260203185717.103810-4-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
References: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-31509-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 83F35DDFDE
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
index f9a739d1ebfb..47b7e0559c73 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21238,6 +21238,13 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
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


