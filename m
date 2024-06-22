Return-Path: <linux-wireless+bounces-9452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E6913438
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 15:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C3B1C21980
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jun 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDB16EC0B;
	Sat, 22 Jun 2024 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/mSH8T6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D3482492;
	Sat, 22 Jun 2024 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719063839; cv=none; b=o5OSMamhv1v0ZpafWS14ky1GNGAECgLikMT1MPtvg41qa2+7otuHeNGob8Werku9BwQ/sWaU81MHEdwWJ+5TDXR/KyfldYZsure2MgK8D/TxOgY2X2Hy4iuCxHWdPOmOa+Ak/cvGmRLYAnQ7POcT+ArBT3NwPbZEBTSw8wS1ppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719063839; c=relaxed/simple;
	bh=FAe5RBSeVUQvSoNMovSUxUr4BZQMUMsViBXF99Eg278=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwCzoPqIlgWeWY0/yBkDoS5OT3KmOTsR6Ee+cB17YvP3MCmYBQ+JB3v86QPNtUtEU99kviWnIbsMC5r8cpCvSvpnynm2AeSryLRRsbbI4ntNeY9ovrLW1EUun7Bb+ix89p9VjLjmyixdJHbN9y8JLa5Q/SdRnqKTEBe0rHRuXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/mSH8T6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so1796602a12.1;
        Sat, 22 Jun 2024 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719063837; x=1719668637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=C/mSH8T6fA3ae8kTVx3hmn2UrvgXiQ2DjtShKn9UDUDtKy5vbeasUTgNooFvTZUb6T
         l++KVn+5+oznFkN60HrNVQReaA/r134wSCA/OvdfcjigyayOaYL7czuPPQwSWGrDG6Lh
         0/zdCYUvq4epQ/9E0fsB7hbDGFYiUSnxQNm3MLG1pmzuogjQlgozq1VQ1VtPJxrXJvj3
         dRi9t2PZtQuRYX0xYOr+5MpBsfnZdFH/xiYNUSzzK7XzRFKXXf3nHgKUqmKbmIW1/FoH
         11NkkRwuienGJDmNL/JDCOGY69kVk/CU5cHxVj/l+DB0AEfm40GbQVvZZVRBPzvWEfeS
         PD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719063837; x=1719668637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=rimBKP+sZ7EfLl+4FqHHzx+j8V5U71W+AmH+q7oRSNjQJEe6RnVx7vHTzYm9jPXabV
         qJEAMJbhTtiz8Om2J5oAT6ZYWomQx6gGpdzOnOmGBopdNBsCYgZUZqbumgby8+4M0Mfp
         H0T3TIsvt2KKqX/zGaRCiVS52bbp0v9xygutWET2bMvf3qIReKXm9YnyIA3B6TsWAYq7
         2bryKc3PgbCShqfM8QMviBAiLm01k100Yl2GsZFANkZ7XN8ktlp4tRUX5uU8xEtSjZXP
         6Sm3IgGzdmNpKAVj2UpKSAzNUkA4g71vNZpIwt3QIYdcTpjuM9l5GBjqZf9A4ppIE/m0
         NXCA==
X-Forwarded-Encrypted: i=1; AJvYcCVjqidCmJoP/TxoGMuDGrlkDeMjrOyeyJa5NGSjr/S5DJOUhvd4dik2Mozi7oh4H5tQvd1Ib7PJwR4bRUslv9eKUNmKPEoxHqAcftLuxtQ+4k4zy/1kAGuhklv27ux4bdxSakPkfDyZYOZg9+o=
X-Gm-Message-State: AOJu0YxYCobibmnSpXu+dpPumDFUR3x3VSAE56ucdqDX0OUGz7ah1YX1
	6oFjpW+LaUcAWNlSP/ubTbHqPm/KMfp36hyWToTAdJ1SD6zmkJmN
X-Google-Smtp-Source: AGHT+IGmcA86UfiC6NQEJ4XvVpRnOH6WwIJzPhPSpA7BkgkuJxCwwpTqvinCsPwpD7h9iqNeDZwZlg==
X-Received: by 2002:a05:6a20:6b9f:b0:1bc:c206:1449 with SMTP id adf61e73a8af0-1bcf4498f61mr373240637.25.1719063836706;
        Sat, 22 Jun 2024 06:43:56 -0700 (PDT)
Received: from localhost.localdomain ([187.120.159.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107c287sm3081014b3a.21.2024.06.22.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:43:56 -0700 (PDT)
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
Date: Sat, 22 Jun 2024 10:43:30 -0300
Message-ID: <20240622134331.15476-1-trintaeoitogc@gmail.com>
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


