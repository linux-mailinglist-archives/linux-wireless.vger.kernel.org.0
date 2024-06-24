Return-Path: <linux-wireless+bounces-9511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB6915704
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 21:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811A9283D84
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121B619F468;
	Mon, 24 Jun 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bERgEVUo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B8107A0;
	Mon, 24 Jun 2024 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256488; cv=none; b=OmnIlWelIkdHUlcqn7F27giRTlFLHz36wT7ySSS6qv+q32sI7BeeQ3nyGxlTnXDCFB/YQwwDQOGbKYKLxsBMTXftxA8lskuwE8arQjUWb+F7gkGmdy4Qz167pUxvc/2VNh3p5tX7t+SnbIBvUWeVfemQNgDDH6i2NQHkKIKR05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256488; c=relaxed/simple;
	bh=FAe5RBSeVUQvSoNMovSUxUr4BZQMUMsViBXF99Eg278=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dpz4vzdo6cqwdjuVBkVurFzA0TjN3wDy2utP08K59gHBqng5Tbn3FLjBKD0UyWTwhqhbp/+T7n7ASPfCKTGBHJgPS0kkE5QkKROPhbwZaVK0lIZTS6071GUPANFxQm8PXt2HR/j/Q8ive9VVNgDViQXI/3MKfytNtl6JzAeXcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bERgEVUo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6fabe9da3so38418625ad.0;
        Mon, 24 Jun 2024 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719256486; x=1719861286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=bERgEVUolvbKGQykK24TdlC5ejZlX4XvExPyJXztixLrDmKWad3kuHaNs+dueT1Fw/
         FDRUkDVWIWMGuJHgq2DdL2oKz6BoDfVm1iFFtqkOI1u7Ghu85zhKi35dy7zC7E0v6lET
         jI8mqgyhs7mn1B9Z/glSePTMPGjL6Hp6neV5Xk/FFB/XaUnfwXCXFHVoUx8Vug//km2Q
         v/z0WSdBR39VJm7SNZA1uYadeeNZlD30gTz7mCMeJDgBTbpV56Nxp7ciBqwl94Jc736R
         AmfKOJXnKDKSrPj8e4F0inkz8hWx46sHz/tbFW+LhgOnTcvK4ZTXqwO0ePL0/rOqX+te
         NL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719256486; x=1719861286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=rKMxewrooRKX+VYDcS+BWimAN4cSXEIqrxwbJJUOR9UkYVR5VnOWkY+w2fR0ydo+OJ
         syvueSJG8hFRtVCtVAyy8XqL0dl3WuNGz+B3vIb/EAdseMIlYghTjU2iyqe+gijJVeV4
         pA60KLvReOPgtQMHwmsNaPZB4Uk7eAmRPrDdn0yM6uLkJ5pFsW9yQQUAwGgU7Dz4+F75
         +hpmSZbJnjy+ArC8Nwf7fuyO8ymwvOPF1jFMdQt3QGlxmCUlR8j8AJBDKh5Imr4MaUOi
         IXBpz2ayIUKbWjG2/Z+aIGsfifbvvY/hVLSqpBg09VUmmL9J92fhPiHJznvBALbTVtUX
         B9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXst3EJfJmJQRoTOOH/AT+QYdxJ4MMg0BO9d3MJhZ0e8knlekNr4AIUgkE51UMoTel1zH0l5IW8zbuH/58A6UYk67M1rIpkdIHz6b6xxu494iAGVe/fABPk9WRYMbHzTtM8emCsXnHeO2ZJhmQ=
X-Gm-Message-State: AOJu0Yx7ZGZ56oLW8kOQ+3+BFpCjuuSn++0m0YWyYBCewADs+sxHFs8D
	ZA0yVqjG6/NYc2tJmZsmuqILy8YeZR7ePgclh7gGQ/zyiq5t3/13jWNt44IeTduJHg==
X-Google-Smtp-Source: AGHT+IGvFYoTy5I2/iq38TvjfgSmdy8RInr0OTUkDq3okmECv1F1bB0r1tfPfiQwsS8e0FhFDVsXcw==
X-Received: by 2002:a17:902:c943:b0:1f9:f6e6:5ace with SMTP id d9443c01a7336-1fa23f159cemr63529085ad.48.1719256485531;
        Mon, 24 Jun 2024 12:14:45 -0700 (PDT)
Received: from localhost.localdomain ([187.120.159.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa36cc1d10sm27117305ad.305.2024.06.24.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:14:45 -0700 (PDT)
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
Date: Mon, 24 Jun 2024 16:14:26 -0300
Message-ID: <20240624191428.39681-1-trintaeoitogc@gmail.com>
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


