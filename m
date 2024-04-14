Return-Path: <linux-wireless+bounces-6290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502F58A446B
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD131F2115B
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A291350CD;
	Sun, 14 Apr 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi3IXMu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE112FF71
	for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713116334; cv=none; b=QJw64WEXG6kJC11dn+mrBYuCxb2Z5NIPVjlGEmciU2aYBpBZhT2XuskcU88g70XMqeLHbJOHf+Ovb0Q+nEnsvZfq7Tnx0YX5RbGpnQJlF0sGfTfPo1wHotSxYxBh+wGDmePSNXtLMn8bLqYlX2MFChGKnOAVvsU6F3V4qnEVUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713116334; c=relaxed/simple;
	bh=Xq3oCNMLj9DVTfSiRdBnZzlE3oEs39CzSQgwhA6VK7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utmEqiKwyBWJH5ETxfMbPHfdHuyaeDaWk7pe5T8cKDEztnDeEurDoJdqAMq7ODkWM13XnmiPVtRYP+ogIYpBFnvCEpy7YYE6Lc/cyOZagmczWrCkHa3tyDf6LlUVewwsp79e2P5/YK1Du3Gwcz9c+gDK2WoXaRP7QcDvzNbsgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi3IXMu1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1550809a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713116332; x=1713721132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKKsw8IFNEpqWfKQXxODID/0PBe87Pa6CaDudtoVnDY=;
        b=Fi3IXMu18cCa/B7lq6UDvLl15zbof+O3424GkP+C1WA/KKl7BoYde6Lo2bGIAT3Uda
         ONykYXj7nGC//q69Af0YjWTF/TDIpUyDSo8ZhEI3KuzfNKkq74ix/J7vQNO5BbUlxmNq
         VxBk6/dunWlpZvByOBVpJbQC8agj8GN0wW08AIxDag8xav6LDwgiLyFiRPZ3tsO8E/yy
         fpltXiSRclCtxTiVAkw4BzbcbGXAM+5QiYuUas5ATWu7JtkW3knz1Z4s3ceQuMoRYpyi
         FZhYKwwtg9vBEaFZbIka3T3AU1NWZHFAxWq6lH+DR7f92Q/ExTTv4gIkffaXaQIr7se/
         PZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713116332; x=1713721132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKKsw8IFNEpqWfKQXxODID/0PBe87Pa6CaDudtoVnDY=;
        b=Bt/b9kk396/WyY/c7FRPK7yylOUu8j6dfcSiRk3Gegxcofywn/9Do2vRLmSK3aYGwP
         jsNUo+zLrq5FAb0ZjBRFpFZV0Amg6wnoy8cp9kjtYi5eIoQ5sMmXxg6lUm+qo7bU1v7H
         eXUhzBOrP8iSlMLj5sLo5zYUeitLoFbyCEmGBkABjt3mns+ZRfoHAB/dmAUUyDIQKyKY
         RDx8e9HAhyypZdPz5jLBPFhtgySqEJwGzORqUGJV0BDHb/MlNOHbqCEinJ4Sd1MHUuZl
         PwOh0PkPCkGchgTus9wWt9C7wiH7AeIgYkJF++naAxVRZKcqvRw1g5opQDmJOFJ6f6wb
         BlPA==
X-Gm-Message-State: AOJu0YyFw/9DKfTX/krgRr4upViC1tmTczfudJ/hEMJ7bZLEUC+1QLeL
	WGch8BID3cQxlg62IevYkZ8SPh+ih9iznZZvteaujrpNm5bDQaRWXi8MLTuy
X-Google-Smtp-Source: AGHT+IGfpX0zT1cfzvJ1sR1SopujLwQktchKJNyX9bCRtFVl39DZe94eP2MYzGQbW6UswYUmJVJCow==
X-Received: by 2002:a17:902:e549:b0:1e2:992a:ae3 with SMTP id n9-20020a170902e54900b001e2992a0ae3mr8806593plf.45.1713116331729;
        Sun, 14 Apr 2024 10:38:51 -0700 (PDT)
Received: from smtp.gmail.com ([49.205.251.18])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b001e3cee88212sm6272826plc.230.2024.04.14.10.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 10:38:51 -0700 (PDT)
From: changename <chaitanya.mgit@gmail.com>
X-Google-Original-From: changename <change@change.com>
To: linux-wireless@vger.kernel.org
Cc: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>,
	Chaitanya Tata <Chaitanya.Tk17@gmail.com>
Subject: [PATCH] wifi: mac80211_hwsim: Use wider regulatory for custom for 6GHz tests
Date: Sun, 14 Apr 2024 23:08:47 +0530
Message-Id: <20240414173847.222809-1-change@change.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>

If a custom regulatory is being used, use the 6GHz regulatory for
testing 6GHz channels.

Signed-off-by: Chaitanya Tata <Chaitanya.Tk17@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9a8faaf4c6b6..16f9bcf21f79 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6589,11 +6589,11 @@ static int __init init_mac80211_hwsim(void)
 				param.regd = &hwsim_world_regdom_custom_01;
 			break;
 		case HWSIM_REGTEST_CUSTOM_WORLD:
-			param.regd = &hwsim_world_regdom_custom_01;
+			param.regd = &hwsim_world_regdom_custom_03;
 			break;
 		case HWSIM_REGTEST_CUSTOM_WORLD_2:
 			if (i == 0)
-				param.regd = &hwsim_world_regdom_custom_01;
+				param.regd = &hwsim_world_regdom_custom_03;
 			else if (i == 1)
 				param.regd = &hwsim_world_regdom_custom_02;
 			break;
-- 
2.34.1


