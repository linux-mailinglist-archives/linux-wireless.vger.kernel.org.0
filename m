Return-Path: <linux-wireless+bounces-15145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E49C1D68
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 13:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818D41C22CC9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936781E5000;
	Fri,  8 Nov 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azJ+J0xG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D71D0F5C
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070592; cv=none; b=BIxYNLE8gEtQQ6VgJNA3RvRuKMecEvW7eP/wlfd8wAVqUu4Qzsiw2H2PdVwBNE2cAuG9RCrgRpb57kP64QefQMMRwaVIVcLRe/4FemXYusRLCTVtw5gNdXQLs9GWJY8rtlSGgDqtzSc++SEgzMpr8freEJbwAppTTFmMNhaNOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070592; c=relaxed/simple;
	bh=hD3Y4qFa/J+cr4HJW7f2yt7j0/IUkwG6u7HeJERV1dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h06MZre47OaajeqM2unmEol9zsqPOIhFMjq0x+kazJSPr/752LxlhX7waPMRXfR4iU7xZNN00ITGFH7IL4ByM3Pu0kvwTKhoX3242Ax/aW0Xx/Jz93rRAe3fiGsEVDwRAGW3jzAGRQLVGp17ktGvx0G2AMX08pgvyxXWJHDoqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azJ+J0xG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso319838266b.3
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2024 04:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731070589; x=1731675389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0joV1BmRCBv88D0p4Iir5SGSAXsE60E5ZQGw3bVuWQ=;
        b=azJ+J0xGSSbAY9jHOIhJYwvD4rNIa2xIqHJVCrpI0/3j5xx+PgYLkaKgW+kRaDI2jy
         b76OqebWv1/e9oVbf9r0+qFlp0PDHexFyGn0kiDyDMgAOTZYmirYcNoSJoO14qfH2wZn
         JPiduj14Cah4fVxdO5c23Ob2RyL27PBGundAD0Lb4WCjUOo5q/BtGgeL/T1OMTAFekf7
         1lRltiPZhiHvLKl82wENQW2g7/fACy1gHUzoifpCCH02nl6vAwDnw4NU++bvpZOssoqX
         qLlb1ANNv8jtEuWadBry3gHR7+SLBGfFMNJhVxop+XdMg0rn+Kg9v9EDJTyQt79toP+P
         jt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731070589; x=1731675389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0joV1BmRCBv88D0p4Iir5SGSAXsE60E5ZQGw3bVuWQ=;
        b=JaI1J9cFnbDbc67txPPFn0CpjPPHe7SKEPro5o5gxQwhBDXXMBBDDpQJIej0sisfoK
         A94EX7su3J0nN0bmVz6a0uMU0+MwLI7/qcK888q7pKQFIL70kfVhmBzPlqWdZ2SB3mlJ
         4Z7KIwQ3W1Kt6/C0OQwoB5eZ357ecAdVRW6ws6BFAQBU/aNclCt/UPRxbwdmckYutMFT
         ihlckJ7oMervtZlscOGQw6PA9uBy5M6yBC22Kd8MoPeqmmicgarryNHrIDVUrto6s7FH
         eCZP6xTPSGSaBquoTrrJy9weissCZ0mVTg/THiv/OPtDbSDnoaZmpbAhfnKUkt+E0wpD
         BvnA==
X-Gm-Message-State: AOJu0Yxb0CevjJ1elHbjmTIhgl/6gASpG76y/aSi2coHOnkAXo6jAGml
	Mq3/3lTDvo/o5obx62Ch9yFnhuWWwtCdIYhRzswVMTzHRQ0A9eIL
X-Google-Smtp-Source: AGHT+IHPXoPd7Z4KNLTQ2FZog6p2rMAeE5YnaCRsmCQCCLDAj8qdUPS6wrUQX+D21pBuwSuQ13sgMQ==
X-Received: by 2002:a17:907:1c98:b0:a99:543e:94b4 with SMTP id a640c23a62f3a-a9ef001909amr225544366b.56.1731070588951;
        Fri, 08 Nov 2024 04:56:28 -0800 (PST)
Received: from wlt.home (77-165-185-46.fixed.kpn.net. [77.165.185.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a7d3sm229584766b.70.2024.11.08.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 04:56:28 -0800 (PST)
From: nvbolhuis@gmail.com
To: brcm80211@lists.linux.dev
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	arend.vanspriel@broadcom.com,
	Norbert van Bolhuis <nvbolhuis@gmail.com>
Subject: [PATCH] wifi: brcmfmac: fix scatter-gather handling by detecting end of sg list
Date: Fri,  8 Nov 2024 13:52:30 +0100
Message-ID: <20241108125609.107016-1-nvbolhuis@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert van Bolhuis <nvbolhuis@gmail.com>

The scatter-gather handling uses a pre-allocated list (with nents entries).
If the driver runs out of sg entries it will result in an oops. Let's detect
this instead and make the SDIO block transfer fail.

Signed-off-by: Norbert van Bolhuis <nvbolhuis@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 42d991d9f8cb..60eb95fc19a5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -455,6 +455,11 @@ static int brcmf_sdiod_sglist_rw(struct brcmf_sdio_dev *sdiodev,
 			if (sg_data_sz > max_req_sz - req_sz)
 				sg_data_sz = max_req_sz - req_sz;
 
+			if (!sgl) {
+				/* out of (pre-allocated) scatterlist entries */
+				ret = -ENOMEM;
+				goto exit;
+			}
 			sg_set_buf(sgl, pkt_data, sg_data_sz);
 			sg_cnt++;
 
-- 
2.42.0


