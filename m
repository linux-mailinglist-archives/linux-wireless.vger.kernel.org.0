Return-Path: <linux-wireless+bounces-12615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841F896FC5E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 21:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F81F21DD0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24BB1D6788;
	Fri,  6 Sep 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV4F1ymp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3413C3F2
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652444; cv=none; b=thcjkMTp8c9KYOt3dG8Xg4v1oEgy2OZGSbcJwZmlClj7VA8xTZ7CsCpaISu2xkccT4NCZlcJHNeCvJaxUXw3TsTFnBnYPLZcOPWK5T3/iRTKNuFsuo+NLtSdU5LSZO85zaTF+TswAmgKGc8GrlVQrib9tmm/wdUE/fyByEUe2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652444; c=relaxed/simple;
	bh=WnvyFFK3cuKEwdYAd9S+ApvA6FKMM6oYN4T0bScrlTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKPin8BwBN/sMdkLtZ/yWYe1bG6EaExEvyn7P/C8TScYyTB8CnIzQt+nsShavk4ENZAvfjOBr6CEZrjb/3SkKYLUXR9OA0SWbcTrcVK9jfEb4XVn764eNWIWvDhsIfNIG2mjQSCH5FQ8KDs+189h+i3wl2EfFDHi+Ph0VgaTYjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV4F1ymp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so1748990a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2024 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652443; x=1726257243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tOAE5lYXIqswc9ysrQaHFWZw9vsI1EIllIjuF/U03w=;
        b=gV4F1ympgLVM2in7E/lB0y8wtl5HuVZ7vvUFIH1KHtxeYXiUJiMj0mElQKMVBc7nH/
         hcXpNX4UdHQR8p9q1PhEIzIC/M3NlPQD81Ul88MFWg7LaDeJShj5nYmqpMjt0rDIxJbw
         lrp4koGtZMFELnbjEhSm7iWQBLRU7CzuWJcW0dWPxhcXANkMEtsgiOsyIj7oGX/1tvhW
         VeekSSHU3FyB5jRxjh6FMSrSP1ycTZT1W23fAaoQOkQN0+rQuKon8/RRbE2Co6HEdi8y
         4nU3PmKDwwdBJBB/8IL8qhBOtoCeMxujvpK/bUlsln14HrcA1aDyIAJVWa7+T6UrG6Ic
         AuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652443; x=1726257243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tOAE5lYXIqswc9ysrQaHFWZw9vsI1EIllIjuF/U03w=;
        b=uFXw2PO3N06PRoEVaHsBeQ2N/77BRArxGGKYVTqx1na7ulRZgsJhCiX+m7XL1h311y
         cE6M2B7Mp4WzbGtbFwGmOf0itLSW1M18OR9tIBUJgZJ//jxPXWYca94ztuPlKOqsGgEu
         2ga1/dog1Jsav2YGQCzhBvt9HTkrUiicfvMMsX4J23x3scXIl6j3LrE8kwEoY831ng+L
         zXXnmJZ81uhvKj+l2+y/Yb7W5KHOkKmQpjDIK35P+mNr+q4XmLn71vJKEwPg1XvRh680
         /DxWCdElEB8AzIB6QaML53XlDZTQEROk6cgs2LZ9FM6twE7Fbj65VlZDEO382DYZk+Fh
         1mLw==
X-Gm-Message-State: AOJu0YzHbCfhu/+V/RwsMpwNFN3An/KZNMJj+YaTUyQZrXGBY56gpC5k
	hR96VP/i1YltmLy06dRBAvWbb7+/wmu8VlQh65gk9pz8Q+/4daXSIU2zyJBh
X-Google-Smtp-Source: AGHT+IEAxLuKHyDiVwkRTs0sVrnegDh5X9tJHXAOwradxbTubLzaXRj1nNXRkbf7iucdsEsZ9lVOAw==
X-Received: by 2002:a17:90a:39cb:b0:2d8:8509:85d1 with SMTP id 98e67ed59e1d1-2dad50fc7c2mr4299655a91.38.1725652442611;
        Fri, 06 Sep 2024 12:54:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm2015954a91.34.2024.09.06.12.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:54:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	hauke@hauke-m.de
Subject: [PATCHv2 1/3] wifi: ath9k: eeprom: remove platform data
Date: Fri,  6 Sep 2024 12:53:57 -0700
Message-ID: <20240906195359.6982-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906195359.6982-1-rosenp@gmail.com>
References: <20240906195359.6982-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no more board files defining platform data for this driver and
eeprom support through NVMEM has already been implemented. No need to
keep this old functionality around.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/eeprom.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index efb7889142d4..df58dc02e104 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -15,7 +15,6 @@
  */
 
 #include "hw.h"
-#include <linux/ath9k_platform.h>
 
 void ath9k_hw_analog_shift_regwrite(struct ath_hw *ah, u32 reg, u32 val)
 {
@@ -119,14 +118,6 @@ static bool ath9k_hw_nvram_read_array(u16 *blob, size_t blob_size,
 	return true;
 }
 
-static bool ath9k_hw_nvram_read_pdata(struct ath9k_platform_data *pdata,
-				      off_t offset, u16 *data)
-{
-	return ath9k_hw_nvram_read_array(pdata->eeprom_data,
-					 ARRAY_SIZE(pdata->eeprom_data),
-					 offset, data);
-}
-
 static bool ath9k_hw_nvram_read_firmware(const struct firmware *eeprom_blob,
 					 off_t offset, u16 *data)
 {
@@ -146,15 +137,12 @@ static bool ath9k_hw_nvram_read_nvmem(struct ath_hw *ah, off_t offset,
 bool ath9k_hw_nvram_read(struct ath_hw *ah, u32 off, u16 *data)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_platform_data *pdata = ah->dev->platform_data;
 	bool ret;
 
 	if (ah->nvmem_blob)
 		ret = ath9k_hw_nvram_read_nvmem(ah, off, data);
 	else if (ah->eeprom_blob)
 		ret = ath9k_hw_nvram_read_firmware(ah->eeprom_blob, off, data);
-	else if (pdata && !pdata->use_eeprom)
-		ret = ath9k_hw_nvram_read_pdata(pdata, off, data);
 	else
 		ret = common->bus_ops->eeprom_read(common, off, data);
 
-- 
2.46.0


