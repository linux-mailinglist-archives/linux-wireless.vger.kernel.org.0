Return-Path: <linux-wireless+bounces-23195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720EEABE9B2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 04:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018FD3B1080
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 02:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6413222DFA7;
	Wed, 21 May 2025 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev4nIqYb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C622D9FA;
	Wed, 21 May 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793765; cv=none; b=hxjf88uV4tUkKHxvmf+QO8Kl/yflCPB8NZ3hvZAn9EaeYEEyP6RVDq7TIdMKtYKdnBXFxItozrzAt7c3xBZdJ85zN02Rs8jkp8ELCFCBCvMm5GFiP9+YDowSMVhdQ6UgP1zjW8Cq1/w4q6yqMtKchQczHWyoqWdwGSEiXeN+wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793765; c=relaxed/simple;
	bh=GHzj+vhP0IH7AazDd4aDDdmVsDEWratUTV7OerNI/8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1518A5Dz6+tWyjGjvqE+L0jVLIEn8fLePc9aluiyGbmgF8BcXGM4lOnUAxZKBZyprbqcp6qtY5fFY45sZdGceul+79Si4JidC+wmAXVcqUg5FCh/el3TaXcsBadLPQAxtWOELEP77lFUvUTuvAH9JdXdCQzjxEgwhqGm/MQwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev4nIqYb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376e311086so7596397b3a.3;
        Tue, 20 May 2025 19:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747793763; x=1748398563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=Ev4nIqYbdShpN2ulqu9jJH8dsP3d6j+d4Mnx6f+75EXkb7dMcgMK39pmRbosikfTnU
         dzj9lN2opJhcUca0d26NmU4rpLb+MpN+dqYI2FZ0HAE4UddLep4sk8jsohmtwz7w/JlD
         BNFRvNTtRBFY8iCiSJtdb05h6l5cmpGlHF9lWCcOACVrsMgm00i4G7EpsUBdJJF3BMYR
         TRhq2TqDQQ3LobkZajCv167M5nqc708VK4d7FrLB8hJw9Ru8cM2EgXoBaYkgSV5VmSgd
         9yhLkQDig6KtL0hGp07DPM6sdXkcq/aK7jkDeJw7yzuIzUo9qVbJdhTruNYfyMEMt1T7
         Srzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747793763; x=1748398563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ+RqlSFyQLSDHWP9kEu2/DGiQBnqF1j/beqMyydt5w=;
        b=HZkFQK4js22kLc8TzUfyQiOBOQG/4jzApj+iUNr65G4Czg6p9ebNrWuREpwQgzJ3l6
         0YLMHUmjanrCMO7cRUqO4QNXjxFs1Ezp8rkq65eWuH2UWpY4dWvhTfv4u+zqmi/xoKpr
         WBeCyx2tyEPzxT2kAvns1dI5E8r9A83WLGKCZdVZz9lgV1B6HiA3q2xGzU61runk89GW
         AxtxK2Q58aVCua1tXGkBAF+ZKY1JkP+pIBxk+ZBc/jsTEyRY7+4KVfrnO6cS1jMrC5lf
         y4Mx45xAC2453MdF1n7jrlGlZ4TpbfeRfv49TDUsBFckm26at+OaXExV8xHrLW1HEXSn
         6Emw==
X-Forwarded-Encrypted: i=1; AJvYcCUed8FgpR5l9mSNlWjS6vYTsqIFnNuLVaGMCzrUIpVirM9MjK0KagS8zx0wm7Al/wjS/XmckfIb8YCy@vger.kernel.org, AJvYcCUvCsdPoCfqc5bmuXfB8cYAUpi9Faf3cc3EIySVcCwpTsKgDnIJhxlfqsOfFkuG2iFHfkJASKvcAkLdNJ5B@vger.kernel.org, AJvYcCXdDs5r8HnMowYyYSF1lACnPySQggzayVgyAcgOcf4JJjBi3fP7g48B6D8Bv0xrAP5QJ3T6I3cgBxVlYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhw89CJQ4joquAdAK64jj0MlOSu//rVbLvNrMreDmEsKrM+pvY
	KS8Kdd8I4bKnSgsWxeqPnV6JyKCevFOtsMIS9c7dBLNODmqv2GhJc4GxBmhFiA==
X-Gm-Gg: ASbGnctASpcS2W4WU9RBqv34gXh8OGdDFRWKVOUzFRm4xxIHkUOD3f5L2qoCZkLNJl1
	pylkkxkoOeYrauucteoKFmz71hVyYMB9MpWznzOTvj2W0nTsSvM18dsuEdDS/5OVzjbpRQfjcQP
	6DNZMp7YW10lDdjdbNkcfthAVOSGrgQu79THm61iFeAPVYaEAsf/Hq0bSprQlWqU2pG7J+CiyYS
	nwQvGgM5tAU1I/PS7o7CKNV0XE9xR9lqq+ypaSBbfVL3wZMY0apPrQ38bKCFmA6Y7pSAE6pOUT/
	AzpDdsRtjm5lQW7pfO/qePRPAhM=
X-Google-Smtp-Source: AGHT+IGeWLTZb5NwYwzSur60qnw8GyRy2RzzaZEwLnhcuWI0bwamyWpBiHyknDNeVbIb+gnpNcrrYQ==
X-Received: by 2002:a05:6a20:c6c9:b0:1fd:e9c8:b8c3 with SMTP id adf61e73a8af0-216219c6edcmr27891478637.26.1747793762900;
        Tue, 20 May 2025 19:16:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8758473a12.49.2025.05.20.19.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:16:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] wifi: ath9k: ahb: reorder includes
Date: Tue, 20 May 2025 19:15:55 -0700
Message-ID: <20250521021557.666611-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521021557.666611-1-rosenp@gmail.com>
References: <20250521021557.666611-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alphabetic includes are easier to look at and to make further changes to
them.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index d2a97e74f451..1ffec827ed87 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -16,10 +16,11 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
+
 #include "ath9k.h"
 
 static const struct platform_device_id ath9k_platform_id_table[] = {
-- 
2.49.0


