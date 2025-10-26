Return-Path: <linux-wireless+bounces-28277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516CC0A60A
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 11:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5194B343197
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56681F1932;
	Sun, 26 Oct 2025 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPxa2L4x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332661917CD
	for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761474501; cv=none; b=Ea1rf9Ayyffs3GTOt8wit9tZUYxVKL2QXpMBzTGah5bhKMnSoRMhzypWQ4IJNekTKbtURY9y98FZb06oKdOPIQXfmYcnAmXSfOoEbO5nbEAiAIg0SGFHaTPqlCewSIW6WBKu5euwm/7uvceMu+Jh5QpwV69Efa+DLdXdTqD2r7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761474501; c=relaxed/simple;
	bh=8dzXp9/KYqQYHVACjQCZvkxplsXyD0cYJB0DhrM70So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCsk1HYpXaZ0uxIoHwG4y07yDcPdDZoOnJmAEsNC6qwsdZVx7vMgT0C84Z2Bk2FdLm5rDSm6b6m278UFiOMWg+N56mf8FtEOU9/cR50hWkeNfFjVLH4IDCUnm271ZU43+0LKJCUEWgFwP7ga3bJn6iAOCkmRokIeBRToHraSAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPxa2L4x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so10081375e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Oct 2025 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761474498; x=1762079298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51VY72e9FEkKqG6+2mvOCEhCmlAcbiJMrlSp3dN7Jrw=;
        b=UPxa2L4xjlSxrVmahynXt2RcrjuoawQmb7szsP8iv1HBSpJkprtyurQFQRJ6RBKe+C
         CL6iWDWjDWAndetHa9ymLViCq5Fl/4wW85HFzg/DohPjU7D76K2HG3ggH+lYO1Pp199N
         XPcy2skCpXhobTEsoU5R0BNUdJtcB7WI8nCK8y7a9O1KsPDvdHnbWmZX3igmd60dO2qs
         6oBpmlD904LQwJH0ZjdRWPLXMCQDaOrm6g2/YvAKCWgcv5BzqJIt1667TN106ZBy3UGo
         JoCwjReBv2Rw8O2uXQHC54fzOCXaM70vVFQaYdi9wAb0JhqRBpAv4oxPfwSe6RVE7D0c
         rhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761474498; x=1762079298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51VY72e9FEkKqG6+2mvOCEhCmlAcbiJMrlSp3dN7Jrw=;
        b=V0yGb+TWSyBt7e6e2MYTxGcb3JsveBlp5dPilxfjU6ZaJK8dEYBk7qZ182rjzDTm7K
         /nBMRPBgC6motxNX36RgY5/PkbDRhfNIBtxB2RI21Zh7RBCoKOqbqYTm5WGIjWqXde6k
         emTFnnbzDlYqxWOBc6DN1pCsrTwXhgDcwNAOvL5GTd1WQQamBWFrRr7+8DP0BiAdvODf
         RmJL/u7LRGEuExB2SsUIF1aXHMcq+RpaaT5I5MVyKN3XP24mukCGctASbHXpgqqsf5IH
         mYXvDEz1hP5e4SGqTg0LopVWlZ7juxe+wqwb9m9qQoxN5p+B+P2L7C1e3IsTPP2GXUgZ
         DHgA==
X-Gm-Message-State: AOJu0YxjPwe0CnSbEN5O9W2SdOHO/8A4sCa5zqctF2Qn3KPpFeLDZebw
	8k5i9GuZfEK6JR7qICVZRFVKfBp5l1iEMBn1NxP7Ev47LQrqfHly5meTffPULGrN
X-Gm-Gg: ASbGncsI3Tke648kYUqcj6lZ58dXzKnZts4YOrFA+Bp205Ggw1YM4Nz8IxlY0O3FS0m
	ifzQ09FrzNbUaBiDPE3gY1tU4F3bshX8TMqjEI5lrULdhxxPzLyIHENVRa5oXBeXxXTDeflm/FZ
	sx+1DQHR3ZXMjNLhUsqbaKy6EnmqgTPBObpq3FZE7+3+POxyZCnrmtZ9a5n8CM2YOkqOdYxOBwL
	wygyPuI/pxhM5jiOuVOwu41cwMGPrk/+dsyZiNZCunjyHdKww+EskJnMeLrwhAfF59tZUAXv6t0
	Tk6s/scJuFGtgNXpR34vp7bCKEjBfjufpAXsLE36IfQx78GGbmaR+RXqBj+efIzh+jdCewPfSce
	tHraT7CScl+Eq4A5xvPvjY8E6+7bGVMFMiovEv9wY5DwbyXCUz6uIFqPG31bJjU4fwGwbsVA4Fj
	dHB3zOvBMO3QTdtY+QQfgoQLJzAI7/qYbM+Zc4sLM=
X-Google-Smtp-Source: AGHT+IFan8YLfXlnFjdb3HdJpuP0WEmGtDW/qHZWAeEkrfQ3GytKpeE1q5lo/KTTnMIwVAsGRbrQ6Q==
X-Received: by 2002:a05:600c:4446:b0:471:1717:421 with SMTP id 5b1f17b1804b1-475d2ebf3e0mr65347725e9.19.1761474498216;
        Sun, 26 Oct 2025 03:28:18 -0700 (PDT)
Received: from cppmashine (82-132-212-167.dab.02.net. [82.132.212.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d3532sm8320758f8f.20.2025.10.26.03.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:28:17 -0700 (PDT)
From: Nikita Aleksandrov <n.aleksandrovuk@gmail.com>
X-Google-Original-From: Nikita Aleksandrov <N.Aleksandrovuk@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikita Aleksandrov <N.Aleksandrovuk@gmail.com>,
	syzbot+e55106f8389651870be0@syzkaller.appspotmail.com
Subject: [PATCH] mac80211: tdls: don't WARN_ON_ONCE on missing STA info
Date: Sun, 26 Oct 2025 10:25:53 +0000
Message-ID: <20251026102553.29195-1-N.Aleksandrovuk@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report e55106f8389651870be0 revealed a crash in tdls handling
when the STA or AP STA info was missing.
Fix: replace WARN_ON_ONCE with a regular error log (sdata_err) and
return early if STA info is missing. Avoids panic_on_warn.

Reported-by: syzbot+e55106f8389651870be0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e55106f8389651870be0
Fixes: 3a8660878839 ("Linux 6.18-rc1")
Signed-off-by: Nikita Aleksandrov <N.Aleksandrovuk@gmail.com>
---
 net/mac80211/tdls.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index ba5fbacbeeda..7e54dcfad651 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -608,8 +608,12 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_link_data *link,
 	sta = sta_info_get(sdata, peer);
 	ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 
-	if (WARN_ON_ONCE(!sta || !ap_sta))
+	if (!sta || !ap_sta) {
+		sdata_err(sdata, "Missing STA info for peer %pM or AP %pM\n",
+			  peer,
+			  sdata->vif.cfg.ap_addr);
 		return;
+	}
 
 	sta->tdls_chandef = link->conf->chanreq.oper;
 
-- 
2.51.1


