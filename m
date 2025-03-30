Return-Path: <linux-wireless+bounces-20963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B57A75926
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 11:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E164E165DE6
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22EE15820C;
	Sun, 30 Mar 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD2dthyQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C289184F;
	Sun, 30 Mar 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743327409; cv=none; b=FvyVQscv0vC2QZXo0xQVNBchOTFa9g/Bw0MUTjAJDTvLkIQcoA7IOXVEy/i5GTPuDp3LyHb4Nu4NRRSpkn46RLRUyNo7xudRahzOzgFS8YD8SVSrYMsCTdQ+15cdI5BNfj+ZnIX+tLmg9cW2FlZqidgDhz0q2oie/nAJQ1/nm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743327409; c=relaxed/simple;
	bh=Z6N2sgFqDrc+LKPGTaLIbSzwuHDOUkrxXi0adkQkUsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWTuYjr4RaBs2emUpsgmAk3rIUfC2y+KOkhO58Ng3C8ItPmxziOWap+1hz2KtIkm3DHNN510D7fo0yAvQGVr4CvZIcIjSDpiW/MHlLWT/dVWV86U4dX6QWLRc5M4WTWaV3TR9XSiuU+CzwFfovWrnHc7op+erqzEyAwnqkwg6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD2dthyQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so66245555ad.2;
        Sun, 30 Mar 2025 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743327408; x=1743932208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYgs5EwCW20iv2ZHkUXjzYyA5IFX+7v48mlboekMnkI=;
        b=DD2dthyQ/tGMKIjB7ykva+YaqW+uQLf34WP3XXAi4/wJbiND1ZSQu3VcWFVKk8ntal
         9beFVdXyZn9lJT3UoIy+9qNaCutki0xBPXzSzgpnMNdRepyluZ+4NtGS/XEOjcGwR0gp
         Q4jrGuRs+yKOgKvCTPb4K+/qgSEq9p8k1HxRNG7T1IB4ljmcxMQPwr+XTHe6FQTBaDh+
         4ZJBIFUh4XvV41T8pG8bdzLVIkfZgFuxBZsHrVvoMvw+453qVWT6J3WPFtG4bjAYK/HB
         391j1r9LOTciGGzbicu50oHKECiuKU9qi6g6Xc3i5LOujht+WJC4FjNis96yIV/wMqgt
         7E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743327408; x=1743932208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYgs5EwCW20iv2ZHkUXjzYyA5IFX+7v48mlboekMnkI=;
        b=cEx1J/MhoZzIlAmr6Ti7iK0egi2pux8u+gMidOIeHaqP9IsX8cNMwhyfzbHR7lD96j
         jfVPjFM7yWkC8/LyQvdnuxgElYfuG43GVIck24zftvIEuDBN7hKF2Bz+SBypo7amUh0E
         bjamGlav9AOaV7Xlmh2PIme+pcTgseiNsdG7S4QogTc9Hc/05EiMm0i0PjAsL5ce6Ort
         5m9COf2elPYhMt1QT2nm+/lyEjoFI3u2EbaE8ydib0IhEpnlisg9pwX7rAjrOwwjBXw9
         57t9GgeeVoclVUNMetlzA0JjCb364ooctcREZ227Cn4qGHUptVK0eQ8tiofzinhjoQNY
         nsEg==
X-Forwarded-Encrypted: i=1; AJvYcCW7+S/uL3XYTWA4CYMJbyggUznWE7+U5YZ61yRcocNzSbHB2uxHKIGBgiHfgrMRCAZd7eWVSV3DaNhPHfTYFhc=@vger.kernel.org, AJvYcCWnRNZsLBlXCt2kUoDE0HFME8lUkv8YH8FmdEGA+a7A3v/oETfTwYJUKlKqyxCsNiEZRCl9oXxMNf/DkGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7Qft4XfvADrzkNwfAGXsqV969jnaRVsm5S+at2N7QXaSNTUu
	C7iU5ENBJyDvqYu66uRtA3x7Mld9na5//ElL2hWcNQJOqsVGipk0C3B71ESd
X-Gm-Gg: ASbGncvbsZI8LFKFEFtPZguUhSvvyft9RnIGPKcSPX9Qju7CDRw7GMwTZfAvZTe+l/n
	Uw6Yd9qNtBJrLZk1YoM9kQI1JbvS9OQeDzU2V1MdSxDVv/5ynhPLUDSW3G0YFCuvjsXTHYIiT6v
	zFSPtEf7bvIev03sPys9xYTKE7SuhlcydM/F9CIq8yXMLM1Z3O34QESEYknMt4xPSPmpM24rsLz
	j25iF/hwwbJTmgDIrWz7Re6t24sCEs9utv3JfobaJ+AKta/irKN/PS0zQhIlX9b1B21LxGIP4RN
	IK4vlSjABU2Cx/LeCbndtt4rq6rNrU1NinZD+vqfwfPvU/bZAU6SO31M69G+
X-Google-Smtp-Source: AGHT+IHQe5JLOQsc4DfiAdpRLI4eVuDTaOIkdGpNNABtdwCKbTWlJCrWgt8Qi6Cy1jR+TdLWnCW/7w==
X-Received: by 2002:a17:903:1c2:b0:224:de2:7fd0 with SMTP id d9443c01a7336-2292f97482bmr74392445ad.25.1743327407659;
        Sun, 30 Mar 2025 02:36:47 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.226])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291f1df011sm48923455ad.194.2025.03.30.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 02:36:47 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: abdun.nihaal@gmail.com
Cc: luciano.coelho@nokia.com,
	vidhya.govindan@nokia.com,
	linville@tuxdriver.com,
	kalle.valo@nokia.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix memory leak in wl1251_tx_work
Date: Sun, 30 Mar 2025 15:05:56 +0530
Message-ID: <20250330093556.22417-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb dequeued from tx_queue is lost when wl1251_ps_elp_wakeup fails
with a -ETIMEDOUT error. Fix that by queueing the skb back to tx_queue.

Fixes: c5483b719363 ("wl12xx: check if elp wakeup failed")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/wireless/ti/wl1251/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index 474b603c121c..adb4840b0489 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -342,8 +342,10 @@ void wl1251_tx_work(struct work_struct *work)
 	while ((skb = skb_dequeue(&wl->tx_queue))) {
 		if (!woken_up) {
 			ret = wl1251_ps_elp_wakeup(wl);
-			if (ret < 0)
+			if (ret < 0) {
+				skb_queue_head(&wl->tx_queue, skb);
 				goto out;
+			}
 			woken_up = true;
 		}
 
-- 
2.47.2


