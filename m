Return-Path: <linux-wireless+bounces-8576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CA8FD5D9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB291C2402F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7D12D1E7;
	Wed,  5 Jun 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNvvnIzx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD58DF78;
	Wed,  5 Jun 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612659; cv=none; b=hfE9QQ9yn2+WuOUynP1W+4IlhK/dM2jKMALlmEla0JyN7/EVCnKq7OTzHPvAPA6+cwXjgSwIj++zDqUEBBO63G+4N9Z84gm/mb0l8+BDitZQOIx3tX8ZoPy1tbnJsnMm8PJGkIMJOqXQX25b5zIvrii7UPuIy6La7OadcQswu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612659; c=relaxed/simple;
	bh=IWRxEymlXyeOoO9yBjR2hKECkwKKp+8egwI0jWkj/dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMmKJo0A3POypQG8FlGlkApbLjZRgx9oTIyM2GYlN+o5KHtCfr8kwsPZDnn3uk0/oX7ObzjLVfCWvL5RDpB6R8ZnFQYXPfNXDnArsc2m7hDwQKKmj1QnWELYApvfJZCBtFyzaTXeUnBBVL6lWn+Kwg+QJTBB86oZPFeMP//1YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNvvnIzx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a0050b9aso1481085ad.2;
        Wed, 05 Jun 2024 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717612658; x=1718217458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBsylD2EcrDb2y9t7J9rNMpo+HTh9H61rht72+hy9NA=;
        b=NNvvnIzxgRubRHoUh4aJV1/nwSjV4Cyz1VQK1e7WpLUZnf6Jw5Nm/z1F1rIbbSka8q
         IvoU2yh+W7aNtC30ArmOtaDPgOdBVOchpsCeCA7QHdmTvdRxWfvsuiHLOCPYX2/FyAYf
         rSw4STKnXIkAoru8JbMdC2jIJgOJT+hQ63p7i0AxPEwK1fBRc1PYHq7C0IvSBhbFub1C
         8X9cezE4ljI/sM0iCdWgEO/gf0H3QrK1kgYQGpa+tRQG1dhAlBEcD9KUpm/vMnGozFvo
         yKOhLyd07sk/jCEwGZR/v8al9DHI8DE7mnVD0WhFzjlofmEpmDoG9oGONvLC4F//1lNF
         0WOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717612658; x=1718217458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBsylD2EcrDb2y9t7J9rNMpo+HTh9H61rht72+hy9NA=;
        b=w2HWbh8+RueXn964RDIRivouU6+LBxiSih6pTKv9Gr7IA+17XJdSGMyNotuht5+Sgt
         ubM+0GQBv2HVPCqQo5mTTK0MpEXLqlVURfFIshNLrS5PlCdD0Dh7jHvI4IzA3RgKe9Lm
         1UeoTdxM3uFeyy7OQ+adryRSvFaoIyuKxBEj40e82mhoJC0E4uBV7BTKXA0XNSQ2jLiu
         goEVAqbYy71RrXixKggBB4UFSigPu5GNS7Uk4gpok/z4O7tJklZ30iV08x8oKN0gLcIu
         DPmsGDAPMBED6++zolr6VXrapdmgsoUgWZCi2Tp39lSnVyYiMU4lvuNjvZxtITF8jY7e
         MmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmIqSdEpJgdYxBKH+DinlYZ5SvSJDgU6Vg9kCZccFMABpHHpmoXXuTx5YXQvXCeF02muirOdKFXa4kmwvk9pJ8Xq9CVn3ze/IHviFM1qb7N+UXTi8Jm5vsBKoQKfn9j3wWJbFKD0xE41jrQY4=
X-Gm-Message-State: AOJu0YwqC16DyH64vjTg316szoyduqDwZpYob7rKyoURh68HhO8aAtbZ
	MGIMbY2hkIG59675zYGkEIDZAIPWPG5ygJm0AxnbIPddYTUXX0eT
X-Google-Smtp-Source: AGHT+IFtOR5FT59qeaQIBc7JDpQX/YF3b15w1TIgp7tAoCBQxFPZKwSXEvQh3HKRFK5LARVdv7tUvg==
X-Received: by 2002:a17:902:e809:b0:1f6:74bb:4921 with SMTP id d9443c01a7336-1f6a5a69a0emr40966495ad.44.1717612657692;
        Wed, 05 Jun 2024 11:37:37 -0700 (PDT)
Received: from localhost.localdomain ([177.21.143.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632338ae5sm105486695ad.37.2024.06.05.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 11:37:37 -0700 (PDT)
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
Subject: [RESEND PATCH v2] iwlwifi: mvm: adding check if the thermal firmware is running
Date: Wed,  5 Jun 2024 15:37:08 -0300
Message-ID: <20240605183710.66016-1-trintaeoitogc@gmail.com>
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

I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> and
Kalle Valo <kvalo@kernel.org> for your suggestions in my first patch.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
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
2.45.2


