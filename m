Return-Path: <linux-wireless+bounces-7387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96C8C0E04
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F09F28187F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488D14A4DD;
	Thu,  9 May 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US5/nreW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837B149C65
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715249532; cv=none; b=dhue8whuOxsYUI8X3iLJBzHyouMC1lvkNC/kW458tR1Tl5X8ONItn9xjBC9pTrwDeV7YrNou+xyRtCkk8l1ohTuEOwfJpOQR2jv0FXjQjPp7pCjCXK6pJw9v4m9hodnngEjWuYmMjUnaoCgEZ2QRQvXfLUCBTMzdtopuowpGZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715249532; c=relaxed/simple;
	bh=Mn+SL+RxkDkjO61qFpeZzV0d1eBOdobrqLpHHWdlfuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6BLZErvNFH+tUwc1DqiQeCe79E3yLGE/xY1u9y7QVn+p7zsdKsGNz0NpFJiWjBA/IQd3KO27GyB57gcEkIB1CkZuol8iG/6/tu3WEEIvZDWkGQMMtueJG1lMTnPzjA4i1WusjTwL4kUb0+1QwKlNuwrO401t528/4+Dali6I/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US5/nreW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f0b6b682fso714915e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2024 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715249529; x=1715854329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLK0IA6rgDqVJhDuySMI0D/RLRPT992W0pjsZPjDXxs=;
        b=US5/nreWLpbe+08T/bziZm5pQc9IzuajfXCU5sj4xLLkA5Oxjer+YshIRa96/Cq8N2
         z/ythgduNWZ97k8TA8GSSgn7lVgeciMcRcfcIJamQPD3GB5G7e1bax2jAFhQRzo6Glqn
         r6drrEgMpxr3igk2MyRxlJ19nYlfGqlnTaRUosZi1rWx5aztPqe9AwlmOgP/IPS9RSQL
         Rd+Dp7+pZ/BkpQCeqYvoe6qw7dBS4vQJ0jkmx6ismVyz9LF5370lg4SzAGVn8ePqHRXR
         QCTNbC2fIYl18BjrtGul/hhRUCbfKgWmw6VVGWP1oOmS+xzGViBFHtyRHrj5mQgTU0CQ
         iuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715249529; x=1715854329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLK0IA6rgDqVJhDuySMI0D/RLRPT992W0pjsZPjDXxs=;
        b=NIqbhje2n7R9xaQ1QOfjPtgyxXSjhZOUc+XRy+nRM4ylumRYdH1pHg12eDxGgBHnGU
         XZvIwvL5MveIZat/jCbdUIo0nW/z017yyrspxU0lwmiRDh1vateQ9u//EbTRrZLipInA
         qpiBPfOrT6glRRneybebWOlKA7ptocr5yiTfQ3GcMYnocWQjwVW1dEo2cXvLJKM3MSAq
         Vuzf+7dvUKqtFi1WFsx2kMzXegZ9eEiBrY6126DtZ/tTcoysZ3HSgqNavw6uN9OF1oYf
         2/rHZ8joerSci+2FPSYkz86kM/4JmeSzykeRBe0/ps0xDnOnm/mFPNicE5I0DoJ5noUM
         dLrA==
X-Gm-Message-State: AOJu0YxF/GZvgtT6RicyKgI77G2dCycIr5eINDcMsU+Zv6CXhTpCz3vw
	caJD+QFPo2pRCU2WpQGv6TBMDOd1y23SmMaBuUUHPHIWxQq1rqPh
X-Google-Smtp-Source: AGHT+IFeKyhX9HywBfoIwSLYiTAi8hW4IWhP4pd6ZmY58cbZ3Mz/9ce9HIVALEC2hNH4nxXRZPibVw==
X-Received: by 2002:a19:9112:0:b0:51d:9ef1:7c62 with SMTP id 2adb3069b0e04-5217c372bffmr4410954e87.6.1715249528842;
        Thu, 09 May 2024 03:12:08 -0700 (PDT)
Received: from localhost.localdomain ([178.95.48.190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba50csm235273e87.69.2024.05.09.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:12:08 -0700 (PDT)
From: Andrii Batyiev <batyiev@gmail.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org,
	Andrii Batyiev <batyiev@gmail.com>
Subject: [PATCH] iwlegacy: do not skip frames with bad FCS
Date: Thu,  9 May 2024 13:11:25 +0300
Message-ID: <20240509101140.32664-1-batyiev@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Monitor/sniffer mode benefits from all types of frames, even if FCS
check fails. But we must mark frames as such.

Tested on iwl3945 only.

Signed-off-by: Andrii Batyiev <batyiev@gmail.com>
---
 drivers/net/wireless/intel/iwlegacy/3945.c     | 2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945.c b/drivers/net/wireless/intel/iwlegacy/3945.c
index a773939b8c..1fab7849f5 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -566,7 +566,7 @@ il3945_hdl_rx(struct il_priv *il, struct il_rx_buf *rxb)
 	if (!(rx_end->status & RX_RES_STATUS_NO_CRC32_ERROR) ||
 	    !(rx_end->status & RX_RES_STATUS_NO_RXE_OVERFLOW)) {
 		D_RX("Bad CRC or FIFO: 0x%08X.\n", rx_end->status);
-		return;
+		rx_status.flag |= RX_FLAG_FAILED_FCS_CRC;
 	}
 
 	/* Convert 3945's rssi indicator to dBm */
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 4beb7be6d5..d018f56be9 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -664,7 +664,7 @@ il4965_hdl_rx(struct il_priv *il, struct il_rx_buf *rxb)
 	if (!(rx_pkt_status & RX_RES_STATUS_NO_CRC32_ERROR) ||
 	    !(rx_pkt_status & RX_RES_STATUS_NO_RXE_OVERFLOW)) {
 		D_RX("Bad CRC or FIFO: 0x%08X.\n", le32_to_cpu(rx_pkt_status));
-		return;
+		rx_status.flag |= RX_FLAG_FAILED_FCS_CRC;
 	}
 
 	/* This will be used in several places later */
-- 
2.43.2


