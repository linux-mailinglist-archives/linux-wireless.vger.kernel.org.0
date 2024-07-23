Return-Path: <linux-wireless+bounces-10452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F093A05D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 14:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB161F22516
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E714B07D;
	Tue, 23 Jul 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHGkUNrJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5017BD5;
	Tue, 23 Jul 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721736256; cv=none; b=qN3hAEW2ARcnpBwMzdfHcXL+2kpgwhbXWBbFBRD6jV1FqZv5m8zacw6S8cNC3k1Z8AV5XWN4td/K47KQfPY4KzMvEi0nhB648JmQuIidccv4m/Men1rGeQX1crRaOZX8IoVB/5UNx/7R5v7y0XbdPfnhc3TOgIKNj8S1PfNRwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721736256; c=relaxed/simple;
	bh=FAe5RBSeVUQvSoNMovSUxUr4BZQMUMsViBXF99Eg278=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hm71b/90zzQNjf177NTw/Ogd1XJBz4aoIqh8tnyC4SWuACe8fWIQv0sjmIODcMQUrWnU5LngGsoJwaLXEWBScxHUtxYs2YOb67y/52hdwuTHizFH1gKA67V07x05M0Rk1itkalmNRc0MoETLgk+WqoCuGj8FJoRbUaoQz8h+CQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHGkUNrJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd640a6454so4777545ad.3;
        Tue, 23 Jul 2024 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721736254; x=1722341054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=DHGkUNrJbXHCzO9XrpyibKyD3il+ej7n9fozYyQpYfUXHFhRaT7D8iHfmB0ZtJdQIU
         Sn0uzLfJy/EGO/nd9vhf8nS32VJtCuMFGD+qNquCp8PBYx49/10jkF3bYLUUXcg+Uug5
         dHOYN9KnQRaCxzKw6Rl2fzbfhhm37NsveU7HO0BTWDdH4NEnsJiFW1bw8yP5PglKGyqW
         BPve79JnzwzGyrvDd1M2D42vonBMIP9NnXIzeYAymNO7YzObCyjjjf/VmgY/1Cf/lKcG
         dk13QG+tUx6Dh733tcfArO74g1Nsu+z0n2Eo5BlFcD3Tlh3qqC45lY9tdWQmfsHFaN37
         NClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721736254; x=1722341054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=keEYE8Tp6IRIIqQ3Mj2gav0+4zzR7IqxsoDU35Niu6+jLHKcDKB44/ZYIy9axuBwqk
         YKMvI21OxPhspHe64NAiyriyfzp+TMyElyM+cwEprhnnzTrATdXvB+c9bkEEFQTXcyzk
         A47STcb0Nxxl/LPU3Y0QbLG61KKwFHJO68vVpuGIWHefL8IND5CeAoWfZa9ZnT3a8sdS
         ebgpIvtNhjWx6SWl2RG3MQgIVmmB3nVB1Y9QbyOuNIDzs1VnL9nw7cTe5INz+HzdYxEJ
         mrwr2QVguynufIEKmWTshxPxOTSsjIjNG78qp9Jlt3kIWSsA5jlkMBQivumC60EBRD3d
         I/PA==
X-Forwarded-Encrypted: i=1; AJvYcCVOxoTyBVxPX6VAAY1gCJBstF88NMqokOYkvpVP6DLmIIKmXdpHIqqBLiNur1M74tiHi4nGY4MqB3kKipTSDeMB6itHPB9NHdkT1OIDvKAEQeqOHdvkSYXPN7yu4MSMioey7F9zn5WqG0iAe3s=
X-Gm-Message-State: AOJu0YwzCEx5ASLkfnq9N8+c7iy5sb4i1/+4lc6swTmjflDEtMvXbLTo
	SsQvSX1BnZs9MuFwRM7CVo7DoQJykMqfktfSRBhcmxTDnN0LrRvu
X-Google-Smtp-Source: AGHT+IFV1wzilscCcwyJqyFjDIjRJLIzHo/Nk8lJzUvjtc+tXd6K3q9sz6+HJaaZdgVsxqFfLxyz3g==
X-Received: by 2002:a17:902:cec1:b0:1fd:9c2d:2f1b with SMTP id d9443c01a7336-1fd9c2d3180mr53822025ad.52.1721736253908;
        Tue, 23 Jul 2024 05:04:13 -0700 (PDT)
Received: from localhost.localdomain ([177.21.142.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1444b58dsm4979473b3a.18.2024.07.23.05.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 05:04:13 -0700 (PDT)
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
Date: Tue, 23 Jul 2024 09:03:02 -0300
Message-ID: <20240723120321.2537-1-trintaeoitogc@gmail.com>
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


