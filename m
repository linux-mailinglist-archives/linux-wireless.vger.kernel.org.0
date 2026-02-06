Return-Path: <linux-wireless+bounces-31621-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLgqC5EihmklKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31621-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:19:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98794100DF8
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 18:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DACF3032DF6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2193B95FA;
	Fri,  6 Feb 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8nuZpom"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236A3D902B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398326; cv=none; b=SUvN/06fkKTqpqjA4EKS8d7+/N81287g7ZhfsSaZxevjhj9OoS3NcN/MrHIS+RVby6KLGBGVXuUhiPs2YoFVJWrabaGagJKl58P+61w+8ttLGAD0eGPy+WGthPeZK8SU+RhVzE00N+pDM7KVfOoXWUieUFxjZIKx7I5F+xVp9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398326; c=relaxed/simple;
	bh=MltIFu2x5Y1v4Kp1oDx3ZUZpniNVhkQhTJsCilokcpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2WsKJJlB9meEG6n/ZnP4nZOREdraa1/70XufiCMWMUCnhFE7PllTYS+v1uH76Xdqh+8kGoMAha2Y71rAY3UDNt8cNjd8aE84xr4/+Sw324Os+qCBF+ywRfb8FCIK5e0PInAwZQhx1EEf/4wrXC57eh1lLdkFLw7ag232yIDBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8nuZpom; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so22990305e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398324; x=1771003124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHLNY6jK0CSQiu55AcHDaYL5w5SL/ULhiPVI1aLOs9Y=;
        b=i8nuZpomZNVafFquTaDvfsp35ZlPBb/FJZgGnBQ7tKrJh7b71Dd9ygHGqGBELx63cf
         vwfw1DlAYV7hY9L1fj32yVICwTEF7siTmoZC7ARxuHA9DSdgFFmrcy5Yix69xDfTMkRn
         bRv/WC3Zz57Owg+4ycBhULJbN6feY9kdJ5QCL9EddJLVYu8QVulrzLyYZDXAqWlXUtp7
         criyW841adYaZ/r6xjGAj8/bbV7KgIubOS0wujVVr3QZx9U6BPfvxASo+6nT2CNh4zrj
         PrChyNT1hfnNdTyVjmA7/D0zMlq+XeDvbz5+MCPRnTlMJs7IKMP2oOFICY283sRVjhSH
         5Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398324; x=1771003124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHLNY6jK0CSQiu55AcHDaYL5w5SL/ULhiPVI1aLOs9Y=;
        b=bFdjTT5TN7SO1+yVkBe3oH1OudmJWuGaBFGez+ZVkIuQejP79o7Be7bZq0HE//NT6o
         c8gAFm9G9RFCyLfWeh5sE+f8iPhMVj+YBbvKTLYIxC5vzC70Gr5u54hDQTCA85vGOGQ/
         n5Ws4RF2kTUkBsn9C9HlIcQ91CY8ffwCM2bX0Wn+DU5HnpZ+L3Km9Kiiopg1Y5d8gFFc
         zWdp5dBKaWoYcdYUYDWcS1BqWExitua0PYVV6TQ91It+fNJ5zCgOWSxiahuC8EKfxsHz
         UUfBpqwKL2DooomadZJt2mNJsUCyG/ILWaPJ5sFSFkhums940hJbXMa+04WKnyIxdT0v
         WulQ==
X-Gm-Message-State: AOJu0YzpyRGA/O9U9q6bXw5n0p8OS0DeW2v9CFhYGaWOJptQdnokTrsi
	Qq5pJnfwzt5Sa/+P30QlSfErc9/RpE5r55WUFMXXYEnVfGj5hV9+CyfBaqr5hqKq
X-Gm-Gg: AZuq6aJ4M0LRnns6oXmGYnFWyVKc2gCtiIv45WdeVNinV8mRUG74JFcq/7VoGPmwu4/
	EdgymkwSGY/w8tEoKtiLt65WfvP1SgFK0gwfjkM0fn5ijwLlxjhEk8eqgUXgBTmuz4om5Qm/OEs
	DLTrP+/e5cyK4rfwHBZyD323lEWRLq/usNhqOe1QkIgc3N/l9nzl4NfDkdR6/DorTEaCmRJiKyR
	mRAbX+Ip06O7Dc0pUGsPR+otiGJ+XpORjHMBZn0dATlAy/RTgqlwFjLplIcM5P2g9J6sFwammCF
	DgTDtWdQoioagZqtZ0rLXVh3UfOANkD/vuabXJHutyAQ7xyLjHgGweerWzGiJphvgO6NZROeRxk
	zIooZvUbjjxr0X4PmM7dh4AFmKLyH5YvND3LN6Q+0UK+htj1T7ZW1dla1mFqXYxtZRYBbA+RGeJ
	DtSAnxZmy+gx/R5c7kalY+d1asfQACQN11VCUYW6jpzrg3biJW
X-Received: by 2002:a05:600c:c84:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-483203d54ffmr49785045e9.13.1770398324325;
        Fri, 06 Feb 2026 09:18:44 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm7986208f8f.31.2026.02.06.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:18:43 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH v2 wireless-next 3/4] wifi: cfg80211: events, report background radar
Date: Fri,  6 Feb 2026 18:15:50 +0100
Message-ID: <20260206171830.553879-4-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31621-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 98794100DF8
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
index 283ea4c7c61e..5cd86253a62e 100644
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


