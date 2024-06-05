Return-Path: <linux-wireless+bounces-8586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72C8FD6C8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 21:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D356F1F27EBA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F66154448;
	Wed,  5 Jun 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk35WUGP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D21527AA;
	Wed,  5 Jun 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617107; cv=none; b=OoPAYR6kXidhsBIgBzRVMEVg48UDO510g9ZtNpd4bok/PBxWYYBR5BRwIuJkIR5b4xjF6w56Vk14cV0gSj6jCrEzT1TfjqMoGQ83J046Pvzxb9lHR7fgaT7gW8YawtXCW9eUxtinp5W7wFF+HfizAh0xF2AE0aUXjIyPaOrUK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617107; c=relaxed/simple;
	bh=13pNVGD9Kxcf1hFGXjLsg/bvuyKWmCGBqbVx1C7p2fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvjUtPojd3Cf8CjgyyKAiwD6RckhYEN/X8c64xguO3m+KWdDYfW2bU72jXLIqTNxelIpnAb5SHo7ECJ4Gkr2gSgovbBDYn32bCTQP2Qy3GbmeqyGt2Q7uRn2nCaxalFK09lTRSmMPE7+tbdTBTLTh6KAlDk1mR1c79bp1sPKupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk35WUGP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f630e35a01so2140385ad.1;
        Wed, 05 Jun 2024 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717617106; x=1718221906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rK84/e0NpWu6xN5WA2vo2qIrm/0cYRoieZimvFEhelM=;
        b=hk35WUGPKOdVLWFXDpQ4LtSg2JKT5ME5H/WGKLmdvtJmwXoHYvCFL8oLcfquZ8uQj4
         1xNO4L7yQxtru0slwJ/bMRNzSP3SjoUKMPJ33QJFpvB3GQtVCylFxrCsCju6ePL+YFh8
         TYK6U7DLqEscLMKoiddPmK6B/E4IAb9s6g4KEhA5+tSaXbdijBQw7XLy1scsuAWoHMFH
         mqSnMUd5skl39RKUmwBUYgs3IzPhfbHMUD9Xioj83LapAf+QgfiVqSF9rpEfKAfaK5gl
         8k6vdaFF5nJqcTMDj60PcF2oh4TNfZHXJZ2nwnVRt6A/u/1vZX0hobKU/GPerkapRtMR
         ijFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617106; x=1718221906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK84/e0NpWu6xN5WA2vo2qIrm/0cYRoieZimvFEhelM=;
        b=wOGBuq2Q6omF44wtfHL+tA++0VN2h/shgX+D2Wm+2M16q5vL+ZwbY5M/sGyN0iUCVV
         682AKcoWOnblTNMLqyvILk9lv5zR8aBRDxso959qzBYeFYj3jymKGdVeT5Y9UFUBrOe6
         O6hxN0n5xVpv3UhwRMHPZXmC+iSy0Prj7SGaFOnQEiv9CXoQHae6TMnGrGYb8c4NIjyr
         QUpjac32icOJWwBabxXgq9NVMrpwt6rw5omXjjQUcVYwinF4eFt3B7DXCBu5CKfXN7jY
         srDwG8cKy1RER9EVJ1MYSWhVmcoLQKbjeugsCmke97A6pSZUKwZjE4QOvufCXsHBJBaL
         heHA==
X-Forwarded-Encrypted: i=1; AJvYcCXHmrHidoClds/KFRP4/Pi4/8PBRIKG+sFEZ+ucIw8HDKUVwQcYQzj4lmK/HzPBRaBr7LQQ2T0k2wQfoo5h+kEsQxytamFbngNuCVRU8CORYx7vF0wFyOi/ofyc/sKUmpY63KEOthPaWuHPkaY=
X-Gm-Message-State: AOJu0YyW4ayHGhyT30/tm4Zc+hWhjiiu/8NdPaXthOhstiE5hgFZX6Y1
	n4NWdfi4IxfdL2KuSPCxkbfWwYl9xsKFfA3HuH8D5syz2VlibMEw+KHzlojjL88=
X-Google-Smtp-Source: AGHT+IG7ECbu4hu8GiJMC/+yTrvM3XzzHcS363edQPc1JVWRsN+LUfSOgqhk9H80IDZhhkTS5m2+xQ==
X-Received: by 2002:a17:903:2292:b0:1f4:64ba:af9f with SMTP id d9443c01a7336-1f6a5a69a3dmr40243265ad.48.1717617105510;
        Wed, 05 Jun 2024 12:51:45 -0700 (PDT)
Received: from localhost.localdomain ([177.21.143.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dde56sm109141285ad.165.2024.06.05.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:51:45 -0700 (PDT)
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
Subject: [PATCH v3] iwlwifi: mvm: adding check if the thermal firmware is running
Date: Wed,  5 Jun 2024 16:51:28 -0300
Message-ID: <20240605195129.89353-1-trintaeoitogc@gmail.com>
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
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 8083c4b2ab6b..9aa9e3be39b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 
 	mutex_lock(&mvm->mutex);
 
-	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
+	int res = iwl_mvm_firmware_running(mvm);
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


