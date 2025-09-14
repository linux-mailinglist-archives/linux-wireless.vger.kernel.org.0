Return-Path: <linux-wireless+bounces-27279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FB7B56AED
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Sep 2025 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA043B983B
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Sep 2025 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B913246BC7;
	Sun, 14 Sep 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMI6haQo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D8E571
	for <linux-wireless@vger.kernel.org>; Sun, 14 Sep 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872014; cv=none; b=rrvfi0B2IwIvF3nkCHVANjCCmC7vNfT55xcDqFR2xgVLE4NFl/ht3t72cxiyOMT6A9cyqD5J+Kw/DmIxJlMj3GnMjSyNQtylPmkxrf/ufzeogjnQROKi9n/8BVBJx3DLKRC3PkR+Wpzry6m+AZTz8he2ft18BBK/jC0PDhvY1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872014; c=relaxed/simple;
	bh=In9UC2i/NFIQUvFUerroeAGF5gSTu7OdPaqyf0i/jFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZtCJESZzPiu9FYWwzBHjEYDDq8G8uvH4L7r9u5mStsHrJ7l3U1TCcoTmeJsC+42rdQ2/wKNAo3Z/RCpH80JkkA41BCI3lEoROJwz/QmWMcH9x6aQrYK6SEig5bu1A6HXT6RqIrMaxG278W5sDILSv9aNTbIqS96bx/Yi2Lzo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMI6haQo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f261a128cso1217608a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 14 Sep 2025 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757872011; x=1758476811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGBSXJ9C8uEXIsdMVE39DzhqSNcXPOjW71G6iexDuao=;
        b=CMI6haQoINCKymAYBMHUfeLKn61T+i3g6IhYibxFzNTFcbh6lDPHDES6duHqHA/8pH
         x7QVLZRevO8qQj5e+LiCLOQv7fDGS9pv1qmPtlaISR2qsgx52JxWT5MAZC7MeQsvoVzY
         MyuR6IUpRPPDX1IWniq92Z0+HGWnwQW9JBtr4GodjOlkmGXeLOcICz1ihQ81weiaEafI
         KBLUjehrIoZf8Zr6ExoZi6ZkLD67Winq73MlAk71nf2fmBbA/TV3OV6Ta/ysv0RSk2Z9
         rqAijZUajkkB55AqBB1dv5Q6HjcX3NlNuxCFluFj0wOpOscmfawn3v2wPBlKGxu6O34E
         YydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757872011; x=1758476811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGBSXJ9C8uEXIsdMVE39DzhqSNcXPOjW71G6iexDuao=;
        b=k9p05O6g7y11acIZjajqu7zCcmOQ3nvAaJu3wImjPGG8cvAU1AyyPaL5WAMTCG9rN2
         Nm1oslWVEC74doLoH7dkBCXKXtoszFNOOpgADGVA0e+nfdTLSg6DiQawybIYuX8gP2N8
         9mTbm3bUoa4HjmhACCWHE3Ofr54H5GvxeHCn4GMUnNGqoYG3B/KwAd941l/YeKLlsmNA
         CNB9hPXkj5Xk+3mAgdSyApsha6rI9qyiq4su4cu/4dERu9GYMHzHd2i273lS/EiPpMmm
         LH1XQZvOvW+T3LlULzUIjvq2U1eafg1XRDAJs+GLIXIIBdlZ0akcW+Tl6kxwGbbmUsGs
         7xkg==
X-Gm-Message-State: AOJu0YwZue5ZjfgK3nvlyR+Xyv2loqjKnGxppbz90uZS2jes6Sa0to/L
	2y7Zbot17m9TzyuZA4dv5KNwL4qzzAbpjATaqR+42EK/myIs2mSkmsvTUqwwFQ==
X-Gm-Gg: ASbGncstTPVxlyBZR+CQdBtF+TtEvpn/7iU3eVkgQEpveLo3wktnwjf1FXSarZNI9f3
	0vNcYrCSHwtXnkaVrj74QqSoHUOCW2mB/U30H4ufnWjjBXWzcCd2cRIqrJucA1Yi3n9YKRgEi1N
	DnAexL1LvSeFBfgPOYEs3U8h+o9sR6xxjgOmnyVNOS85X6PiJfVTJ+9fVvHmyRh9PvZ228KVoeN
	KaeS5Tj9eGq9Bw6BOY8QMjj1W88/wOmPwGCdg49boFKIF0+rJpSERvxdSEXcgvN5p78SW4bZckG
	1rwxHRdO3593XGVqxu8XL83VT3SOPQjA+rclxfzWiSN11WLy3I0k2b8Bc34gXP5b1271b1I081t
	7US9i1NrFhdhRuJCrxJsj+zd2IqvCo3vfgNbJSdnLmF42gOWtUcqXyaG+CPMgJ33sGl5H1ErtT5
	LQKxyhWg==
X-Google-Smtp-Source: AGHT+IFOOO8LFWsdI44l5Ldx/XgrHzG0L4WC5LDQO2AA1g6E5CNG8MpyzfvGBiHNfGjsWpTkqHyjjA==
X-Received: by 2002:a05:6402:40d5:b0:627:c739:ee36 with SMTP id 4fb4d7f45d1cf-62ed82873a7mr9027666a12.14.1757872010768;
        Sun, 14 Sep 2025 10:46:50 -0700 (PDT)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ee7b531d7sm5063438a12.51.2025.09.14.10.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:46:50 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC wireless-next 1/3] wifi: cfg80211: fix background CAC cancellation
Date: Sun, 14 Sep 2025 19:46:20 +0200
Message-ID: <20250914174622.479249-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Release background radar ownership after cancel
delayed background CAC work and sending the
CAC_ABORTED event to user mode.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 46394eb2086f..9afda72aea38 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1306,11 +1306,12 @@ void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev)
 		return;
 
 	rdev_set_radar_background(rdev, NULL);
-	rdev->background_radar_wdev = NULL; /* Release offchain ownership */
 
 	__cfg80211_background_cac_event(rdev, wdev,
 					&rdev->background_radar_chandef,
 					NL80211_RADAR_CAC_ABORTED);
+
+	rdev->background_radar_wdev = NULL; /* Release offchain ownership */
 }
 
 int cfg80211_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
-- 
2.43.0


