Return-Path: <linux-wireless+bounces-27111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C87B497D7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957BD1B266AD
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813D30FC3F;
	Mon,  8 Sep 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWLx6ABd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB27FBAC
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354911; cv=none; b=sJutbgs/zjqog1+axgFAF/Ci2agpeaMeBe+KVXvTiLz/wyPN8LWRBAx4OoKlXAj7BJFGajZTcay3ny/qogy4V2zUKWbyAghP4oLZWvJJOST+h0E3nqDqfohnt8XvlOwPHCtOkD5eZyzv3vvNxIkyHEfcYmg6RBryqG7LiStSvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354911; c=relaxed/simple;
	bh=B8xGZw9KPRG4ASe+yeNSIdh2mkXPXhQdK30J+tQa3Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHEzUIt5sCvIcfcL8oMH4Jmu5+scCNxa+/223e77VqL85VtOQDHo4o6G1qUB/lax3i37VzxVp2eErNr9tg1VPDr5Px6mZgoRz9erv3ZwPU4XhzHVPjmOyaBMbkjAHtEkytrRde/rEVKumHlg/LxvH6L102raBQM7YgScMK3Qq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWLx6ABd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso1245635a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757354908; x=1757959708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdXTY8Zhvx/kLzs5VwZyhOrjrtPMrb8FJD0FbuM4/4o=;
        b=AWLx6ABdVxm1KBXpdZmVTNCzThq0OBGB0i9e6eWi0+aT0KCYotIPjrizo1ghW/kCPa
         hrwzcNE4Cw5xgNN+1C46isrQq0NpnOXWC/Q/8er4NMXU7neISCx0FSG9V0zeez/Aizor
         xOjUN9p/i9PKW69NILRVbEE2wlxhixhgoeAw1HsFTysl8s3quFQKP0+7bGba/jr/dcqV
         qwR48xEar6khRsVzdTt9Mm6RS65mKupS0JDCbFDhjQ4EgnbB1cKK+UfJv0DVUTtQSGG2
         IK6c1NDcRaFgsy3RJiHL0nE6pj4W8+uf51NTwc9t4VPEhlu9iCXKt8oWGohm12YFd4MH
         4NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757354908; x=1757959708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdXTY8Zhvx/kLzs5VwZyhOrjrtPMrb8FJD0FbuM4/4o=;
        b=igc4ax+feh7nfg+tBJXTX3asmMKIr9IcTWlIK37lvLVUDrgy3qEFrS7/e0tUCh3mtq
         d5Zj5GJX5Wogw8aOmb94aCfCHqAa3ApvWmx4hDgrKYWGkNsnrBv0Iq7Dt74seHbKQWpI
         Ekr2gF5dn0wnvxKmgCteCCSqZ237Hcdgg0lLNOKCH+9rvoRb+WDvpT1VWdqLWmOMg8Wb
         A6z81MHIMpzDtqepQVyW/8XjgUM7gzRam4Kml0N7pxNLcDIYvtqVIydrnLUDCWJU5XC2
         W26MqR/2KVkcXcMnlRsYdrQ3t5LQ3tfEuSG4KHdWr/72NooIM/aFzOU4F9ZR7dkQUZvC
         r6dw==
X-Gm-Message-State: AOJu0YzUv+07OwQyuJ+p6pTnRWRS9fH/JBW6wcAZ9es/mUZ/JEbawQTZ
	jt40PKTmnkgNFOq89UUNRonT8uOyAk6bF3hy+XnFk3ZKiudq8a1AhpGnSLJ7+xSd
X-Gm-Gg: ASbGncvzLjlML88lQ8Bgq9PAhargHLeUEsXXU1uK4aWsVnyCauluLI0F7k7qqM1apiE
	XA23d+RoV1bvu1G+7eMHpujBsJ/g0d/4nVL8kBRAipmtyWYUaNHTRMvRjY7pApybXtq9TaeFXZl
	sWHrz8XheDcKn80t2wLcXUtgmRwdXHfxN+0SMyRqStPLu+sbxrgsfymjf1NCizqgo6kZg/4OyAc
	RJboAvRaNWE73U33G+TFKyNGtIW8ltHHz1ExUrrlCN5xrxRnKuBxFSaYaRSNveOHohtn5Rk3qJc
	z2u2YdWnPbP8lyklO2SIvQxYfWluKTPA6UocB8NjPX+SVXYSh2/kPJgn1AFK9jQtSU02HNUFbQc
	2qwn2APkHNyMi3KSoi/4vSqAWi/jn2KiAzTu28hqMx89OlyWKvTrwV3DynEQhf5uZdrEdnO8=
X-Google-Smtp-Source: AGHT+IG5vue2VuD5XPXsmpBHN4CfT9a+nmVwQVk+l6OteN+/pS5WxlfFsjdnXE/GvVQ5gxZ9aQFsnw==
X-Received: by 2002:a05:6402:52d3:b0:61e:9c96:9326 with SMTP id 4fb4d7f45d1cf-6237b0ac25amr8624242a12.6.1757354908292;
        Mon, 08 Sep 2025 11:08:28 -0700 (PDT)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc216304sm21131270a12.19.2025.09.08.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:08:27 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH wireless-next] wifi: cfg80211: cancel background radar correctly
Date: Mon,  8 Sep 2025 20:07:25 +0200
Message-ID: <20250908180813.2414794-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Release background radar ownership after cancel
delayed background cac work.

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


