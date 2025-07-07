Return-Path: <linux-wireless+bounces-24863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F890AFA9DA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 04:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FC9178A55
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D831B425C;
	Mon,  7 Jul 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmpCihX4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292341C2335
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856391; cv=none; b=FFMg6pTVX+C+juaEjCs70nzD52DYIDWK/zqfPL/IfbBVQ1iPKhPyAQ0rFUuy/DjWN9Cv9LYSEmJDyLkAngHkmS1Xnr7hYc3nsbB+DUzj+oMEbp/wUdLhJo7JI7To/uUdhQX0XUNs4VL/PO+q9VSjk7OJnYIROUSn2c4mgPcFIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856391; c=relaxed/simple;
	bh=kr9hL3ac71b3VvzABOCGVLYvnE3w5m4oIMZxbHn36Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5m+iK7Zc0A1k0Lf19cUsh8vgqq6k/oaKLe/B2gz+KSOYdEycikbwiw/j2Tarp14J3Jd8Ljk4xTsbZegWGx5ewJ77Afi0hKurePnWs60gdDX+girVT+ec/JCldYxWDZZOJASADW/Vwnht+j3DTPBVY03sYS8xkoTOAc1AeES//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmpCihX4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2220288b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751856388; x=1752461188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B56oOjVy/FRxsveY15m5DvIIxZetafEEuqVHsJ2ZzKs=;
        b=BmpCihX4o5FD7LX9vN63uqmqqukf2Otnkny1nN4U8qKOdXVHl8PUSWFXBgXzCNnzxE
         vULAdiwBXM67edLu76IUfm+rQ0NC3e3Pwrez3FZHelql5sLIk3ac/w9WBLpmf4ah3rT+
         gIwCVs+Z+Ms+aG5jIRfyU0adDOsPgp509i7sFRt3IzVGex+1eb0dvzSF5ndt6zuTXgOs
         RwUTZTWqvw0NtL5e9YmPdPChnlJG0bPn1OR/VAlAVPbUSRd4mifymFujVYcb3myN1BBu
         C5P+zixYdI7WMpnrCCyAEFwijC19kXX6lgq332U8MBqC5vmul6dw2ULWG7JV6Y85jiXR
         Cw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751856388; x=1752461188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B56oOjVy/FRxsveY15m5DvIIxZetafEEuqVHsJ2ZzKs=;
        b=OK8irAiORqGDJrz3PzJ+de0wl6ZyO/oN/6luMWjdtD78Vv4GnN3kOmZcM+G1O8XNGJ
         q1eXjQ1bamYb02r3S9WvIrPKurR+G3MRy1i2Wd9aCef+cGoNKN6B0bBGMyuUvRhn+pUh
         zDt//SQNFDQyfJ+7kF9AP09o67gCl/jEeewm3EngYw5EJbzArDPSGHnf2l27KrQkVufC
         b5lovq8bZWK4vrOoBI4t1gCigIhw4H2VMYB3rmpr1kjo2W1ndH1SnpLJ21ZBt86EbPWy
         Gbyd1SD5pndmQEDVwNLhucRVRc+6SF/zKu7t+OPUfrdQ/hd8KVGdFJTr27mqxOGq4X4J
         eHxQ==
X-Gm-Message-State: AOJu0YzUUX8TVxdrE8Dn0zTxwtpFnZ5/+9CxqJKBXQIlST8zGVBm3xOz
	/R2/EwXU9yOSnwIG/71hSHjVQhq1QGpK3ksgbC+NEE9HIBbCIfYJPl8iHw4R3w==
X-Gm-Gg: ASbGnct8o5qI5JXcdNzzngrljPNnXm9xsZvjm5nus6aHxgoBSccqMtFvHt6SMTjncxE
	diw9zh8lj/oNSRhd2GV7041CGd0M+DGrFiUIgXQDcAK2EvJDVGXKn/3xD2qWoQRMcqos+fpNv07
	kBGSMNKwqVyxDxznqK6NG+elSr1R7W8WfXvvb1xicc028qcT4q/zhQekYQyoZN1VCNOGMbXx1JA
	2r/jxSufFK7n10lWlMeAMOxX0Wd9+2Xvb7ANLaujwG/5aAMimfQBTuZCpC15JkGhc1zsuHvW9/M
	uqFOjchQV+QRYPmoGpu+TJ86SDLYZHy8Wi0s8VB0C3eH9yqtTO8lyM6mII2g5b2IQJEjyBWIcWa
	iGdFatxRHm7/sbWlPpLryDNJc2BWWThthEmwG
X-Google-Smtp-Source: AGHT+IEfQ6URslGrfO3OqnNejVIYyV+8z+DZoo0rVfGTWgb4sKGc4b7k9Vh2jiyz5iyaJaIQZifzOg==
X-Received: by 2002:a05:6a00:3e0f:b0:748:fe1a:3432 with SMTP id d2e1a72fcca58-74cf6f1d2bamr8130287b3a.9.1751856388365;
        Sun, 06 Jul 2025 19:46:28 -0700 (PDT)
Received: from localhost.localdomain (125-231-129-141.dynamic-ip.hinet.net. [125.231.129.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce35cd066sm8205274b3a.53.2025.07.06.19.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 19:46:27 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 2/3] wireless-regdb: update regulatory rules for India (IN) on 6 GHz for 2025
Date: Mon,  7 Jul 2025 10:46:14 +0800
Message-Id: <20250707024615.38507-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250707024615.38507-1-pkshih@gmail.com>
References: <20250707024615.38507-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Ministry of communications, India released 6 GHz [1] on the 16th May 2025.
Technical parameters are listed on page 7:

 * Lower power indoor
   - Indoor
   - Max. PSD e.i.r.p: 5 dBm/MHz
     (Since minimum bandwidth is 20 MHz for WiFi, e.i.r.p limit is 18 dBm)
   - Max. e.i.r.p: 30 dBm
   - Max. Emission Bandwidth: 320 MHz
 * Very lower power outdoor
   - Outdoor
   - Max. PSD e.i.r.p: -5 dBm/MHz
   - Max. e.i.r.p: 14 dBm
   - Max. Emission Bandwidth: 320 MHz

[1] https://www.legalitysimplified.com/wp-content/uploads/2025/05/Exemption-from-Licensing-Requirement-Rules-2025.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/db.txt b/db.txt
index b5b1308460cc..224edfcd90a9 100644
--- a/db.txt
+++ b/db.txt
@@ -940,12 +940,14 @@ country IL: DFS-ETSI
 # Source:
 # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
 # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
+# https://www.legalitysimplified.com/wp-content/uploads/2025/05/Exemption-from-Licensing-Requirement-Rules-2025.pdf
 country IN:
 	(2402 - 2482 @ 40), (30)
 	(5150 - 5250 @ 80), (30)
 	(5250 - 5350 @ 80), (24), DFS
 	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5875 @ 80), (30)
+	(5925 - 6425 @ 320), (18), NO-OUTDOOR
 
 # Source:
 # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
-- 
2.25.1


