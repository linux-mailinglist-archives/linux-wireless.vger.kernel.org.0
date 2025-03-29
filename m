Return-Path: <linux-wireless+bounces-20942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9CA75432
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 05:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C9E168AF3
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 04:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D353595B;
	Sat, 29 Mar 2025 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8SlPQk7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA343208;
	Sat, 29 Mar 2025 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743223751; cv=none; b=S+PFtWt9oNfBoCma+eOldrlQYgcfGgm9exQNBZn9eQ+6FJEWhAC57UIPYJAdKfVa9Cy3hgevrjPLZDzOIo4Le1QndHkUNhlpC1wNV+EKUGOp5Q5emR/6dC39ToOErxzyKBafUULJS6d4zfQL7qasHriTO1tO/h0TVOOUF99oMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743223751; c=relaxed/simple;
	bh=iXWg0/ExmdnFMsUmylEF7NRrPZlUdQuXUAuLue7nLSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=psC76NODMCPr9C7nBTx1jTxefFA7H5DDQr5S5nQJgwwZ+ZCuFHX/pc8OPo5Q6+npbZSBYKA8XsBNbpC8tSPIBz+AMaShDCU3t9lsh9RvpYznV8GtFvxIsNsUrmg0FEvzqIzL3jCUuNmYRgU8gwns8BpGtj4f15Zf9Cc11m07/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8SlPQk7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22928d629faso22387335ad.3;
        Fri, 28 Mar 2025 21:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743223749; x=1743828549; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeHokOBOLl5u009R5p56utczZ+uysy/ZnJJXJvXto7U=;
        b=c8SlPQk77SZjlvglFdUujIBgh72/rWtidu34Da5sYM2IKq/BC67WNunKYpEFDUskEV
         5NTqWOc7Ad1KLziihDGJpMqwDAhNfp90+cVLgIs7rKKKUkxCi448TxIlkuQB8gQgQPAe
         ik0Bx/SqiK/DkYYQQaquEnO0OV43yLPryObqC6/GVv2TClvlFC+YvIW+lhjiynbUjj/X
         iOJunw1iT6FslXcb8CkTcjS0FSg3UDOW3v7sQ1eIh/vj+x/aIQGNUiHff80m3AKcMqWx
         4CfRJ5f0oQ+xmyMyRGYZvsfzXIpyzAx3RJyuwarZHXvp7/AEdonCjli/TZRhWrqWSD3y
         E18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743223749; x=1743828549;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeHokOBOLl5u009R5p56utczZ+uysy/ZnJJXJvXto7U=;
        b=i3oou2ZYFnujNpKMBrCb985Q5yuYCKUweppCxcIgTSGRdoPbiLUbrNCmoYWWg8WyOH
         U1ynQVpZfv8JOdiLCCiZncZLB9z7MWJNBPy2EVaPHeupIKcMmmX4VjtFy0G5/SdlLQq9
         PHDHYwS2G650KAVHg/dcvMP5UiPgEagB7FDF/vEURAJ4TMrR1SuT6XA0dvMccLDNmoPw
         owTHemQuHFGwTB2c+c1zDWxipinIpNvKYVFm1M4MIOVBZgVbp2KlI6WI9+jdzEDKAvFa
         bKgFN7P0YLiXQoaJ4tYh3G+xpsgNDcUKlqAWYpWXX2wuqw5iYKqGVRD+AwFrf/boGTI4
         eZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgOImOyTI+nVEzNB3At2OzH3lhPq1z3kQXGKb0hGekfctfagAF9w4y40C+SmRCU6lrS3wX3ZqWAmjU59A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWx2/fVZqsdG6CI70xs2mQliiMBJ59yXSROuc4WgLbkZM7Z/Sa
	VHsQ71yxD/0Tm1dvkyMEsdY8/Y1KmHWbEEmEGpCzC/0BKRz7RNPhs+Wtiw==
X-Gm-Gg: ASbGncsqsms5o+2bI7UNzJt1cN2T8OYpG2b9SLabQ6StKhIWx18muCTe2wjklzvTse7
	EYwDY7zKHWS7n7TCfHuIYuuTBdnQzYclYKiB6BetyP6obWbSMewhjqyXcN0tDJTqMBQDTGDlNY4
	0sE+kr49pbD1Eg/1g2hcsNCCmOWfozqPtbVd7RSWYW27/QiiXP6Wv4U9/Oj78jUOMRxR7dUGdil
	vOMgPBUHZekG9i82HZMqHps/2t+ttNVZABuCdE4GdMndJ4SO85Gx60CH87ZkwOuxnSr7sIchVG7
	mfQyDaSXhQUYU4dffpzpMt6Odn0sgXxxoOMed7d3GX+b
X-Google-Smtp-Source: AGHT+IGrx6s54eq7C6Y3iirZauCCuUd98k4cbbbWcDiOtj9K2B2V+Jw5VVbEjkf6Ev8gA9MEvEmXvA==
X-Received: by 2002:a05:6a00:439a:b0:739:4723:c4d7 with SMTP id d2e1a72fcca58-73980452946mr2402281b3a.22.1743223748554;
        Fri, 28 Mar 2025 21:49:08 -0700 (PDT)
Received: from [192.168.1.26] ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109d361sm2780870b3a.138.2025.03.28.21.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 21:49:08 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 29 Mar 2025 01:48:49 -0300
Subject: [PATCH] wifi: iwlwifi: Fix iwl_pci_probe() regression
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-wifi-fix-v1-1-d6360e78f091@gmail.com>
X-B4-Tracking: v=1; b=H4sIALB752cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyNL3fLMtEzdtMwKXYtEE0tjw2QDMzMjMyWg8oKiVKAw2Kjo2NpaACX
 qTMRaAAAA
X-Change-ID: 20250329-wifi-fix-8a4931c06626
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Johannes Berg <johannes.berg@intel.com>, 
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Fix the following probing error:

iwlwifi: No config found for PCI dev 2725/1674, rev=0x420, rfid=0x10d000
iwlwifi 0000:3b:00.0: probe with driver iwlwifi failed with error -22

Which happens, as the comment suggests, due to an extra `!` when
comparing the device bandwidth with the no_160 subsystem flag.

Fixes: 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Hi all,

After compiling and testing the latest commit on Linus's tree, I found
that my wifi wasn't working. After bisecting I found:

first bad commit: [75a3313f52b7e08e7e73746f69a68c2b7c28bb2b] wifi: iwlwifi: make no_160 more generic

And the culprit was an extra `!` when getting the device info.

This patch is based on the latest commit of Linus's tree.
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 93446c37400814e2c27ddd2fe93136862fcf4eee..555323341e7d6d7b94e29b4b4530b056bf6433ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1449,7 +1449,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		 * !bw_limit to have a match.
 		 */
 		if (dev_info->bw_limit != IWL_CFG_BW_ANY &&
-		    (dev_info->bw_limit == IWL_CFG_BW_NO_LIM) == !!bw_limit)
+		    (dev_info->bw_limit == IWL_CFG_BW_NO_LIM) == !bw_limit)
 			continue;
 
 		if (dev_info->cores != (u8)IWL_CFG_ANY &&

---
base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
change-id: 20250329-wifi-fix-8a4931c06626

Best regards,
-- 
 ~ Kurt


