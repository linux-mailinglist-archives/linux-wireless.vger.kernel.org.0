Return-Path: <linux-wireless+bounces-9305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029979103D4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 14:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E492827A8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEC1A4F2A;
	Thu, 20 Jun 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjeXHRPX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978A1ABCDF;
	Thu, 20 Jun 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885722; cv=none; b=ADCljy2cLtEwLLhAXinwey4AD8ddQDG+/4xUvNugen4MCt4+rgbrtdqN42FrTTIoaPMNdDJ5xxwjRCdfxYaxLkKYJuJRJQVMeX2Yiwrz4/iF36EODPw4csLF/mlcLhqcJ97M0xTBJBw9DyxPpoGaXnyPtExaZwPFBhlDqI6j72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885722; c=relaxed/simple;
	bh=FAe5RBSeVUQvSoNMovSUxUr4BZQMUMsViBXF99Eg278=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDi+goA6ouOTO8JuPcYaLg92hKBfsTuQ20awcMlPggVsG32L4LxJk6FnwC6oSiKUSrhVapvBr+avl98atrK9DEctFDaf/FHBGpUGFexdVoif6iUQPHg3C8QYpTVOcI5MbLtRS5m1rV542MQamK8vi04cTO1EYDaHVdH/K1JJhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjeXHRPX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c7fe2dcdf6so253033a91.1;
        Thu, 20 Jun 2024 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718885720; x=1719490520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=IjeXHRPXuj80Ty+TUuEPA+hXbAGNHgX+cq9KopEWrRSTZo1tYqkAh/zoNK2fQ/ZzfU
         LFKT4w1LqotylMg68rGnBuuOFbO9D9LjjdOhq3jRNaAWcePNh2LJrCEgO5Bha6/Yu1k3
         MJyOzeLtuXu0kNkUrCDZB1kqQBc9KOifx76OovAvJP7Lxxe3TwbG13xpgFXTRHpVgAD4
         h8+mCaHjnCCTi5y86i9IAdxwtQR7DEsi+S5MLCcRqIILggAbj7zk4Qmt4DjwKYPKpqIF
         v8iWxo+usD6C+20qQcQ9zDkoUMpx9mqkVhTOxPYLB5MtH6q+BhK/ARLnWpzsJpZzQHNj
         QKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718885720; x=1719490520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=kru9dK2PpTk5CmBpAHJqkkOFv2clNSgjM5sHP19kLoALxmQFbz7EUsTMI4GdD26PLM
         ScBh6aV9aZM/sbp/i2bglrXGoEAygva/Ta739s4uEkJzwjTx0m3jhxIpEdXDfcJI+lZK
         scxTqDby8QB/1tulxqhBapTCFAeKPniBW8ODgKWAXnFTA5G7qNum5AgSIYwU63fx447P
         HEf2GbudHSoROMwWT1LEz2nawwzX40UrrPUVF4ToymNwZW7ycAve3i9ffMwYhGYcI7AX
         EI0XBQuYK/qN6UHE4zve8Pbh+ZKoJ7ZSmWDUVtf+DXIZm9raRmb3PygXsm03IJ4QAvGS
         64Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWPmIEW8k34frzSxDwPbBiacgWwQ7URMKHbtCgB++2akrv4GEoIX2Ol0TZdq0JKhVewIUIxJG/QakjC657xEt8sx1i4VjAiiSUhSuqw6lOCYBxBi0YizaTMmv/y0gf2ET72TDvU3XL7F1H/zyA=
X-Gm-Message-State: AOJu0Yztee7iysfMvYH3O+Wp/DpcC03ccmlnhM/Qy4ElrS9udHTp1pSr
	4h9c4haQCRQMtklsMFVIkNduqCn6qrfmDVHzx5OiPOQKtxyc7g9aeVi33IZKJ+I2ug==
X-Google-Smtp-Source: AGHT+IEN1As4d3Iqumbfv66XPszilX93JI2SWvzwmiHYKNp7MG9IUVm5XIS80NhXAcUsqlk5Gc8TeA==
X-Received: by 2002:a17:90a:d42:b0:2c8:655:87eb with SMTP id 98e67ed59e1d1-2c806558914mr416958a91.9.1718885720258;
        Thu, 20 Jun 2024 05:15:20 -0700 (PDT)
Received: from localhost.localdomain ([187.120.159.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff8dbfsm1535436a91.8.2024.06.20.05.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:15:19 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	rafael.j.wysocki@intel.com,
	daniel.lezcano@linaro.org,
	johannes.berg@intel.com,
	gregory.greenman@intel.com,
	dmantipov@yandex.ru
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4] iwlwifi: mvm: adding check if the thermal firmware is running
Date: Thu, 20 Jun 2024 09:14:59 -0300
Message-ID: <20240620121502.2907-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.45.2
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

I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> ,
Kalle Valo <kvalo@kernel.org> and Johannes Berg <johannes@sipsolutions.net>
for your suggestions in my previous patch.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 8083c4b2ab6b..d1dd334b5049 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -620,8 +620,12 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 
 	mutex_lock(&mvm->mutex);
 
-	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
+	if (!iwl_mvm_firmware_running(mvm)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
 		ret = -ENODATA;
 		goto out;
 	}
-- 
2.45.2


