Return-Path: <linux-wireless+bounces-20968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEFA759A6
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F68518883C0
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65614AD2D;
	Sun, 30 Mar 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvJ/tY6i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186C86321;
	Sun, 30 Mar 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743331574; cv=none; b=Rf+yyg5F9DN/0VM2bNoDplkrKJWjwIOEjkMX665xDbXxPtDS/9gi19khgGwPiGX6Z0sX8HrGMjqshFCL2BWJZslMCBTDc26pDXDoPOEp2+fPH3rz7PLiIqeOQlnpPyupNtgj9JecfoD2b6YraMiK5QdnpMZxm+7RrqnSgzm7Pk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743331574; c=relaxed/simple;
	bh=FctZaokXwr+xvHGiTDvfPsOLDx5ylfOLF0lyqQ0ARHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjTTo5KA5cXoGefYcTuBl7BbqVmSff1VbemkFZJjwlKgAeyypUajy/9IYOsHdkSAz7stzlO/JL5SCn8UIInWNzw83Gj37AjaYUpXv0kBryRNyqN6U7pkEKyd76GfKZZx6g4ufX0HkGwVbrAqNgDX54perq4In1i7ZNAxPZhgReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvJ/tY6i; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so5670470a91.0;
        Sun, 30 Mar 2025 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743331572; x=1743936372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yD16MEa4bijmtP1FygKxi9EWx+DwlO/c5yAOdtKifw=;
        b=mvJ/tY6ie0LcUVodgSd8dpWC9NJBuGQWfWgpENeZvazP19yqkeIZEv3V2ZXB8FnNFp
         9GZzwTKSmBs9cjXEOKK2oa93yH6ES3H5Pm2mpAEJoRtD48gSIORJjmUfhf9VoA2zjxwF
         iEmqeSt842YL2SyyTsRYQeZAE0U2Qoc5WHXz99SLXwI/PCn8ywG6EU0bHaCIyIPtJ/JO
         EjOxVngAFxdrpxMZJXB2njncu3W1pZakYJ17Hd9OzndNSzRntfkiwfVGJmoTAlR3Zl9P
         9zJKTsXWgzKTZMyc/3FwlqZC3N9sSadyqZhLpDqn1n3V87VzcxqaglajmOQX1BWzr4oU
         Pg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743331572; x=1743936372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yD16MEa4bijmtP1FygKxi9EWx+DwlO/c5yAOdtKifw=;
        b=tF2NylYaTiXdtJaOtvGNHnAFb5BGPQoprlealujbJPJJgAHPaW7cHd//z4zPRCHX4+
         zs7F+1yrzCgf+Uap7b4wdENXGKJYnnZ1IrNOAxW1qVh8mZTuT3nMRgJRwwpyKQXBdrtF
         yJ6IRpaLlG4d3iDwQ/g96Eccn0fd7omPRkpH3WYVMepY/rg68ETesKIAcPyceuAA9h0X
         yCKFHbFpbrZ9cnbaTPg0LLy0tuidKDKDQfIOV4oBaB/NkD4H7stusWINl2XIPSZ2TtKS
         NOgfE20WkwpR5xxPtLqg+5gHDq7d6YCBlQ+zu1AvfdVZcRxNH6q7HWDGD6/CUbJxCSyv
         2GeA==
X-Forwarded-Encrypted: i=1; AJvYcCUTSddYzQPmgZkFNjQlp5rdPheYcMCfVrXj6Y05Hc97XS5M6HvvnlcBiD+NYv5d9PwGsRsIE9zWsaalusZ+U3s=@vger.kernel.org, AJvYcCW5T1Evgv54SivO9XHG1OmRGsFjvxm84zQ1CjHkgOwzKaafp8yb6Bnyk2AEhHrZtY3LVEz9a2gR5EmzsIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlfDKoOJHzlP+6BvhvKAn834PsDscJaK7tLqY5QI3qYVE3aMO
	pTAiUBHXAW0y6aG6mhhwZZ4IAwAoFtrA3IdW4FLg746PCi8rZSDBRvNGUw==
X-Gm-Gg: ASbGnctk2I7AXUEnVAfwJa1U3p1iFYSJfI+GWW8NA9QdKu5b9EJYY442xFi2vSpUbJq
	eIhznecyVL9JrY4xrcI0eZfpQSij/SZGnBJG0xS6QTBaoPoubFwotkiOoQqVQnu24xzjtApaaJd
	zp7gpwVckjL+oRMTIC4RicgR7V/o4j4djy+zVOSPRwx3mAUYmcUjqlJsk8x1cZ3Ei88jkhQuwtf
	A/OdJgKD8g+zeHGuN2vheUSW0sHbch4xnwL/35UB8l8ifg+Uq3bL64p9BEKa8jif4cmXKPee4yg
	6xfDGCblS1EEvmpD9hP2oR4VKmTepGvG70EowmRhXuy+ojWMS2gUcXDk8ptszx+/wsrGPIY=
X-Google-Smtp-Source: AGHT+IFY52r8zhCnKjYccv4Ga8OKbTR4Yp38mg/2daTNndR1ae+pKawZyBdfbVBmooBI/d/3d/KWOA==
X-Received: by 2002:a17:90a:da87:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-305320b16abmr8363928a91.15.1743331572601;
        Sun, 30 Mar 2025 03:46:12 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.226])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291f1ded45sm49814295ad.163.2025.03.30.03.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:46:12 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: kvalo@kernel.org
Cc: abdun.nihaal@gmail.com,
	linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: wl1251: fix memory leak in wl1251_tx_work
Date: Sun, 30 Mar 2025 16:15:32 +0530
Message-ID: <20250330104532.44935-1-abdun.nihaal@gmail.com>
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
V1 -> V2 : Add subsystem name in commit header message

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

