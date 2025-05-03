Return-Path: <linux-wireless+bounces-22366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6471AA7DBF
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 02:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA64668F0
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09D3FC2;
	Sat,  3 May 2025 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtQhmJAf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B73C38
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746232357; cv=none; b=Xd0vH8xCYj8ODgtIDfyH3ucuJt0aii/Ld/ihpcLVxY8mUn5s/Vd5+3JpC0PuFhf7CwdWpdswAiW/UJvofSfZksPmkFjPEgdZ48RILahZTFekPKiksgCVbcwBIkarxIS2EIGGaxycs95tX9d1vKQiXF3YV8jaHN80f3J7RYXmxsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746232357; c=relaxed/simple;
	bh=elfNzo2x0ab8GgZ9Xxe8r/XJFntbi0oBNigkx4hb8+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMp7mT1sYdcNvA8vCCknfx6+s5Hc/68GZ92ZmNMQjV8tcYsf2z875bNLTieDL59fi+AZ+8N3BYyzC07L7GT8VV4aj9pcNSl9FxEyAqAlVsXv5+PcQzizepKZJk9gSL5N2vvNZailKdV15lyGzGkZFzgiE9J0W0eRHNR3ECE934c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtQhmJAf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e033a3a07so29095655ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746232355; x=1746837155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR00OwqLHDJesU44sEyKfPl5ecAyo0iW1oIdaidHdAY=;
        b=EtQhmJAfVU7QQD2lUtYGwN865Yy7Ij28onSvyNuWXfziv2YJB6VMHBaoZsSS6tWd3S
         9tYXd+IeXvlXWjfijOiJgwvD7+hVkVCWqB0eksMMLpgg9RLdqnHFioUqi7XoecbaPeI/
         sBYeP/7KZ818l7fPmYEbzyligLe2K1OP4UYRXAhLCQ9Rr/OCgGskVBDGImb7SopxgidY
         vTEWzY4FkU801FW0Ik+slCtFJDDbfWTf7XMp6BjRCo0/089CYSzSoQTWZX786o3tG+kw
         1iSYqop8ekhSolrVC9XECXLbhSHBIQxVIv3BdF+9pqus8JFX1rklLRNxAVf/yxMUmeBu
         Afww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746232355; x=1746837155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR00OwqLHDJesU44sEyKfPl5ecAyo0iW1oIdaidHdAY=;
        b=JVWSwJbMo/hOssS7ujmMvAEeBHzfu5IQyFhHpsocmvX4T65gnA4xLsD6uKryPbCJAE
         SlaKfxYDz57jkOeeQNDyb42zYNdDRqI22iSnjNIhmammAVrEbQaccJxSzKyeafyOPb5k
         e0Lg47VA9OX+7y0rzjCay6w5MJRv0kJpjt7qm09IPPmhnJLuKYH935cqS5rR6FSJd/Wg
         U6M0a3RWXZeAksCfwlgERvLO2v/U6vgid6osAxSsclIL4CicyYM97ZW7ZAE3ce8DnZvV
         M0GRqriJtI6h0c/nPgf3HG/ZCjYrpNRW5X7Wvivuivztm9gnnLIAegL2fosE2JpuFqPB
         my5Q==
X-Gm-Message-State: AOJu0YzTcOc+pqbFHZJ9naWN6ON+1xarnoiFZIej6+VP6CLHmMuZqABZ
	lq17z6daglu82s+Iyd38Nz2LzPSKcSiHyP7zQKPlOEySjJhRiUhFopi6zg==
X-Gm-Gg: ASbGncvmmIh87wo8GDK0tIDwtku2KHHAoE4UgUvCKzE0k/b8Wnb1Y72j/svuIDfUBkY
	2aZP6Rr/kp41pUPUuUUbDv/jyDH2wxfisIztUR4eXgxVjY8i9pHOH80H1wmAw52TAZ1LbqHIG5L
	mbSJfxzTYq31W3Rnq+BsJytXVq6mxjzO1pi0zyuos179SwzXUBNO03TYqKHLCKkzCSJ7g+7ID0R
	eYy3xFxTVxoMrzwC35mdKT3xFcTti4OVkcE38463HGTkdJFwC64v/AQ0b/8DtSj8/Y/tSC4uMzv
	HEQI10Z8irGNSXB93k5sYbMBpoQo3C0Y/Fh9t/DR1XlP3/g7nBCA6p6imoA=
X-Google-Smtp-Source: AGHT+IErDqRRYlOjJt3D3+HbJEcyF4toKOenyX2nAMC8FIiB2w7aUyoMtKIHm2eBueXWLiD+pdY9hA==
X-Received: by 2002:a17:90b:2dc7:b0:303:75a7:26a4 with SMTP id 98e67ed59e1d1-30a5adf923dmr1844782a91.7.1746232355079;
        Fri, 02 May 2025 17:32:35 -0700 (PDT)
Received: from magnate.. (219-103-20-73.btvm.ne.jp. [219.103.20.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4764226csm4140349a91.43.2025.05.02.17.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 17:32:34 -0700 (PDT)
From: Yuuki NAGAO <wf.yn386@gmail.com>
To: wf.yn386@gmail.com
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Subject: [PATCH v2] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
Date: Sat,  3 May 2025 09:32:27 +0900
Message-ID: <20250503003227.6673-1-wf.yn386@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CA+Tmi=P0kFARoU3yrbMTOBhXz=1Q8MoroaSNbQDw_NZye6r60A@mail.gmail.com>
References: <CA+Tmi=P0kFARoU3yrbMTOBhXz=1Q8MoroaSNbQDw_NZye6r60A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add VID/PID 0411/03d1 for recently released
BUFFALO WI-U2-866DM USB WiFi adapter.

Signed-off-by: Yuuki NAGAO <wf.yn386@gmail.com>
---
Changes since v1:
- Fixed malformed patch.
---
---
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index 572d1f31832e..ab50b3c40562 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -77,6 +77,8 @@ static const struct usb_device_id rtw_8822bu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Mercusys MA30N */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Link DWA-T185 rev. A1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03d1, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* BUFFALO WI-U2-866DM */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
-- 
2.43.0


