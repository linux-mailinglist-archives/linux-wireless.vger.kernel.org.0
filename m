Return-Path: <linux-wireless+bounces-7783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940238C87CA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475362836F3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF10F5FDA9;
	Fri, 17 May 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaEPibya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970C5FDA5;
	Fri, 17 May 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955459; cv=none; b=Lkw2kLNXNFtlT/Sipq2OdlEhofPiOhCx+MA0KXT2SS548qX7elaD8vKhAPWAWTBQYDN2vEynDS7KSey9t3fZBreWNk1QUBf2eElawFome0cnkPigGUI8iKOsdCs8Sw+UTtdUDMHABmNV4LfJGjyvVVuuti/fYdA9Xa26ep5Yccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955459; c=relaxed/simple;
	bh=UlVN8KocOAhtWIXU31zRHoZb50+kGf3alSGInsXEu38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SgVfaFS2vc2dZg/pPQ/UTO0WKMJLMebRxo4S1A3GJ6uiAUOpr8PatTFHiD17gdO2ymRprpPLN2bF0nagbiTBwC1l2PhIFo6oapO0gmh7YN5txrHzb9C7VjZ5+LUID5fExam0gV1H7DxYl1a8S9ENpe5VPlLdFcEX7ojjvE7gnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaEPibya; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f0937479f8so9786425ad.3;
        Fri, 17 May 2024 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715955457; x=1716560257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0gWHVk+PDtCh2ofIWQM39wsmxkQQMVGedJsGGN+LCw=;
        b=DaEPibya0T7QFQIgcoPOdKdeDXuMvNjxLoSdKdatCr0Z2W+cnbE7EALkXq7Rj2o+Nz
         m/Sm12LHbpUiuBAgaqGPd7nyR+vw30ulKpsbBYjdodvKW5lA66bVbxRCJHhAMExyI1Pg
         vL4NLZRyh8SxMgfCmko+xrf6qUUpys/8mIZrOPxVtHlBb5NQjLoSTH8CamxH+s7Dm65F
         vfhJaA9aYXfLupxHnZ0KR2d+9mGsH22P9O1ZudAw6/rb8w9nFpE4BpJZ2GcS/pZXUTFk
         NVIsQMZojlP2DmJHelg0kdR1973/1Cd9fknTZFKlxQiehFnjMzNNqWrlf0Gc6tTuDeIU
         sM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715955457; x=1716560257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0gWHVk+PDtCh2ofIWQM39wsmxkQQMVGedJsGGN+LCw=;
        b=fAxsz5ldIcpPk2+jvLqvmIwqSPMcqFa7NmQ8PibNRUSombNlJVlkxxGBZAzbDUFiYU
         Mma172U8ITerXRB7LOWP0O5wyX4HhrCFmADytU9aE+l1X5TSHsFrvK6hFPXa7cdqPb+c
         4p2LzwC/RFI98jOHCP/XOM1Zw5Aad5VHUX0WU+/ImqiqS4kX1sayR6+E4enuRN498zcE
         pcdc2hJAu0hKljzwcFMTCf2EAvQZcgf3a5KlPAbX1+/i07QWnEb9YeSb5LEuTH8owaMu
         p2tiPti6z4lD1+owgLSnUZnJ+rwW6rfvId3ee6nnhg+CxkR2xh5XgG5wcU9Xd7OfvaHi
         5b5w==
X-Forwarded-Encrypted: i=1; AJvYcCVxEvkhYcRaABYUDwMA1WZXOeIFTs1tygzhXY2PjEA+SC6U1Ml5k6RQn8cj+RhTZv90Qvyz11ZvU+fwk6n9bRSBgyWfK9ZruvUCMpNNNBSgQ28D1JzTKrJNbIB3YAxJuMDzZqtrZLGAyZEO9Yo=
X-Gm-Message-State: AOJu0Yzumb1cHlwfbgJ5eiiKHTn/PfXuCwFy9vFznEaHEXjgcb+9wtHy
	XooteYIMieGCSXi8uZR7v/tsqXMMFqwb5Hg9Lv9OSOfB+OCG0I2P
X-Google-Smtp-Source: AGHT+IFWEWq4oaXHET8s/wXTwXeZk60tuo/XSjfAZ0qxnhYX+de2q2ohHkuAfvfltCb0kg1wgq7Qug==
X-Received: by 2002:a17:90a:4418:b0:2ac:5a93:636b with SMTP id 98e67ed59e1d1-2b6cc34280dmr18888932a91.2.1715955457379;
        Fri, 17 May 2024 07:17:37 -0700 (PDT)
Received: from localhost.localdomain ([187.120.157.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd2a841037sm2775853a91.52.2024.05.17.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:17:37 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	rafael.j.wysocki@intel.com,
	daniel.lezcano@linaro.org,
	johannes.berg@intel.com,
	dmantipov@yandex.ru
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: adding check if the thermal firmware is running
Date: Fri, 17 May 2024 11:16:50 -0300
Message-ID: <20240517141655.2797-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the dmesg is showing the message "failed to read out thermal zone"
as if the temperature read is failed by don't find the thermal zone.

After researching and debugging, I see that this specific error is
occurrenced because the thermal try read the temperature when is started,
but the firmware is not running yet.

For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
After this change, in my computer I compile and install kernel in /boot
and in my dmesg the message "failed to read out thermal zone" is not show
any more.

I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> for
your suggestions in mu first patch that results in this another patch.
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 8083c4b2ab6b..68ab9966330c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 
 	mutex_lock(&mvm->mutex);
 
-	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
+	const int res = iwl_mvm_firmware_running(mvm);
+
+	if (!res) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
 		ret = -ENODATA;
 		goto out;
 	}
-- 
2.45.1


