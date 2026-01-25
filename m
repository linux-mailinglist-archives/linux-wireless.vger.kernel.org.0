Return-Path: <linux-wireless+bounces-31146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG4dBgk/dmmXOAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4628154C
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3656300956A
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB3326932;
	Sun, 25 Jan 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UofdU3EH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB3932572E
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357051; cv=none; b=IcA0TRu1cZuSlrn2JqqCHx6ylEwHaXXz/5kurlRyxi8j48v5WABI8c+98WXL7KYl/5r9z2M4xISm6cnZLH0nrYR1awp5BW7UisKh4YgFUyEV5vm3lkQQTt6BpJMr/qQgsZrqBchTBdFeno2ufyGfI75/7l3U2jE+Cwgnr952aCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357051; c=relaxed/simple;
	bh=svk/f/kSODjg9Eh+xZXSZ3mbWOF7R0cQuurSUW1lexQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcNsWLQUUxskLlRzawR3TNqTeSmwVcDQf8/CjB+XzIf1R7L9LiON26mtMfzS8L7uZLDbG9RRKARXFPGvEKiQpWybl1OUGfs/bXgq1bOKb/loNdAS/AQ4iFtDufMRIM9m+rBcYVnH0xrYv7/gGdpoedfAjz/V63eUllOg1+yyug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UofdU3EH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso291828566b.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769357048; x=1769961848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i4Mpn2r/antQ1ODirRW15652yUYQWrQnlE3rhDv/iE=;
        b=UofdU3EHfsWB8IuQbr9cC7cTBiLbVabGhXgaye/QXhH04EV2m16hKozimmaxHZ61xW
         i2xiGlSn+H5sGPiLL7K4YzjcigxeiLSVU4DOISGMciYyom8/7N4HopdBcQJvcck8Uz69
         YEhjNn13d2OkNmEc3Ktq7G6dYiYY/SG2JB6e8mRDDVMChS2ik7TUvplA8on06EUWHDpx
         hY7Nc4efE6nynZLZFoRMlF3d+ekLlOCTCE6LbJklngP5X9B3iSgI9QXndG22LkwnDfxb
         bX8zmU4U+241S5uryZoEAQuEbbDBxIHUA5/qT9NN7dnLysB4QJJEw46E7MB4N8pBX8Hn
         8NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769357048; x=1769961848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5i4Mpn2r/antQ1ODirRW15652yUYQWrQnlE3rhDv/iE=;
        b=mqb9EH2uqaaJEGkvv+7Ij9xRWAQhuGv3O0DzW7b3IHKL7thiA2wj/b/Rd46git7ig2
         ltmtXNLWPLw/7NKuR8K1aWZ6Lx3dOMuD5Vhe4zwADYgPqymUAkVUEElK6r32/EtYes6b
         7N5X2OfbEq0VCK+lpWXTECppgCi/RhPvqYSzQzsuIXRxrQbiAXezVNstytQAauh3INDV
         vF6FkOnv4J8cK86CLidEaLmA5uK2uBydpAlr13qkFVUzsWFfH1TAu/t3tWoCbLn1F85v
         4hSxssgClqYEc2RUrk4IMSwjbo4jwFWUnBNbK9Oq2k/VxY9LTuuRzncYWFQsnRgOfscZ
         QNHQ==
X-Gm-Message-State: AOJu0Yx1gj+JYVRXVoDrK5XNXiM05GESsBb9MQxUG+zZ6oMbfIYCuwnB
	i88blx6zLaH3G+ok3Rp4+WvcUBPBq3uY6Cnt14gSS8pmDDtOLxfgdTC776tmyQ==
X-Gm-Gg: AZuq6aK0aoIyTtqbS8akPBAOX4NK1IklF0NLbQYqv/fZPPxO/aQydF9QbD4WUz9F308
	XeBFXiVu1nhp4BwfSX+V66ecN3dNSgVaDnDxptLeSHkRowrOiMKHUCnvekqF55T7CbCvjFc26YB
	O/Thr6ixRS0AQ+fark+jyvjqYTgkG5Bll40D7wZrlveKeMWPKovi7x+6FsCl5xRCVgavvyeKc2v
	1RqPdXP71hlklREuSbf92agqvCJFhnKJclYOnOmpcyCwoGGJ9bxnfDFajPTLcyGN4Mp80hulB//
	ZgKVSf0XQKpUf8/TPwJI3rdxPp0/p+eji5laKcqGDoMA+4mbITSeeEXCgbme/67N59CQTXvxZT1
	RLWFaTxF+6LFjJbqM0Lnau2auOFNWWAL/dUSt4BVv9GCnXxYPwvL+Q/t8iOSQZk6ft34x9l9t8m
	OuFRVDWdEfBAYjXzLGX3rQ+rPNjV9zzWccXiMTlf1YIXXRW4yR
X-Received: by 2002:a17:907:1b10:b0:b87:17df:4d65 with SMTP id a640c23a62f3a-b8d2e6f02c5mr137198366b.51.1769357048419;
        Sun, 25 Jan 2026 08:04:08 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b886a249e69sm408330466b.6.2026.01.25.08.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 08:04:08 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v5 wireless-next 3/4] wifi: cfg80211: events, report background radar
Date: Sun, 25 Jan 2026 17:00:31 +0100
Message-ID: <20260125160353.34102-4-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
References: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-31146-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6E4628154C
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
index a29419d7256a..84a981153eb9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21127,6 +21127,13 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
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


