Return-Path: <linux-wireless+bounces-7794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B38C8AAD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 19:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E371C215F3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20513DB90;
	Fri, 17 May 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMOW82/b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687912F5A3;
	Fri, 17 May 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966092; cv=none; b=E5CrD5y3Cb6lFR3LLp3cmTkOiFpg44l7YFt/GiJynixGERpM3kKGeiOirTJmxy2sywjJdW6xQiU74cWRXyq4p6/AsJVwYy1oZ/DYQS7Kz5v3UI08PGr0tjQNo6AELXZRyE0WyUtNhO72nii1D0O3cuFKvYq1g4dSH5NmA/k9cBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966092; c=relaxed/simple;
	bh=uw9CPXGjU0B7A7pqt8vkqgvzDyz6OO8UztQRenWCnVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUS6UezdSv2LcoXp20WhjM3XbfeFGswGxkCfI2Kx70RhkDsae6fYlbF6BQnV123jHNmmMWkLPFQDIrC0hxGmoz1ZR8QHbDNjpyEk2jxy/+xJsqkAriId3aTIGxj6wJQrQucrQOL/pqozKw58TK4wpJtIZ8J++aIiKwNfhdB7Ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMOW82/b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed96772f92so15461405ad.0;
        Fri, 17 May 2024 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715966091; x=1716570891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X56rUOhK9RH8FnxHSRChz/vg6z6AwcLdxNOEL1Ao9+4=;
        b=YMOW82/bN76MHkCqK6fgX3H/4vr3VY1iF3zfdFYlaaA8reqLAbZzUWy9oWSl/P6UFZ
         rKfIiCxURvy2hGkFMQXGG++jUD+zzopn829bu7OnW8iYQ8lQQVfqMylE4vCncNgWwM5T
         HLuAr0P5umeKnak0K378a1nwoOEPwnOh4Rl6LMA9KJ0kjs+2uo2CKl5e35qzi7H9qpFq
         5QwxOrieFznVaZXtdTBR6Q7s2a8zeTrQ/lOZ7hTSQewB/WJszTmfxs+W76LDS63Zl1uI
         OS4ZsDsxc4+yOrRKof/weqnl5Ll8eWwSngAv8mcOmfWSkcumc/vp0YHQuldzLxu4n9B6
         a69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966091; x=1716570891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X56rUOhK9RH8FnxHSRChz/vg6z6AwcLdxNOEL1Ao9+4=;
        b=QtA0UIGV2tWXYfBg5feHXlh3RyBLyDcj5dt6WrQ+3tOD5oe4Z6kbtuc49jYQ6Rgy4o
         jCZKaCxFEIb3Y1WB1rJU7o6yhRQebCyFyaRTXJ1YuBIYubPs9YFFBEdZQU1QDXAhoKiV
         NutajSj+/G7Wn8o7r1oju6N5ZWfdU50xt4VwEXfaupuXzfGBOD1VuwlT2YDyvAhp26eC
         66qvwFf3YYt/fiRD0+YPQdPKAMSmGF0HwairGv6ivEdK04monps8PuGTCD+TLlMiDP45
         LqtTJm97RqpDFW8m6SpNlYBIuaB7Zz4Hpb8W3VrGWuchlzaYWVEPXDqFTIZyI3s5HHjX
         rLfA==
X-Forwarded-Encrypted: i=1; AJvYcCXHTsSDgzaOUECUm6qNgRu6qrBJaZMOXTq3dcRGVoM6pNpFmgVvHGeYH2jl1W/ZjZVTQItOOFmEphcqYRulHzQmHTMM9ho007560gmU9kRN5NkcCQRoFuOJ5E16kMGOSaJfAzhUWkB5sCuoCiA=
X-Gm-Message-State: AOJu0YxoTgqp9RHwyhr3lmIonKE1flPKTUgeRBC24T/3RWcQlQvuXNPH
	qwuncVyv9nNnKuSZ3L04aB5ZCp7l5HLPqEoJe/DNirPWIsuOlda2
X-Google-Smtp-Source: AGHT+IGpa2Dr0JDdAiMoTugcbrVLY0mUR0iw+IOqX/boafkVx/d5zR2uQ7+D1n+sqry4E4YaQ6Ztdw==
X-Received: by 2002:a05:6a21:3115:b0:1b0:1be7:3705 with SMTP id adf61e73a8af0-1b01be7387cmr10024240637.7.1715966090589;
        Fri, 17 May 2024 10:14:50 -0700 (PDT)
Received: from localhost.localdomain ([187.120.157.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a86a4fsm14988250b3a.63.2024.05.17.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:14:50 -0700 (PDT)
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
Subject: [PATCH v2] iwlwifi: mvm: adding check if the thermal firmware is running
Date: Fri, 17 May 2024 14:13:05 -0300
Message-ID: <20240517171311.3705-1-trintaeoitogc@gmail.com>
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
2.45.1


