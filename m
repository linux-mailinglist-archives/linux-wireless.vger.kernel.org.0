Return-Path: <linux-wireless+bounces-8590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA588FD74B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1219F2856E0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921E1586D3;
	Wed,  5 Jun 2024 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IesPMI9q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F21586C7;
	Wed,  5 Jun 2024 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618274; cv=none; b=dpqBKnAncgihZtVVqm9HNtVF4seYOR3geE0AdvJQWPFziZnYeWtYaw/Ne6htClEbynH6A58qfd3nGn5mdGB38brzuge5wMDmSE7pwrNNvgEnWynQWp7wS5FVcfaY9xLwws+iDu0i0SP/v6l9HHAmFcmjmDApeB5Lc3MjfmdFRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618274; c=relaxed/simple;
	bh=FAe5RBSeVUQvSoNMovSUxUr4BZQMUMsViBXF99Eg278=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBlfTutLsg2O8MnYRhiRevgddy5YPEcNTH5RqxlUzpXdvZCGemFnAzDYcpaAKVq88FyPGSybuA/z/B7aJYE+RE6+UT6n19/CCZJpFb1adMbYCYbFhiecHMBhkkZ8v11wt4NIo+/5Tpc9J1G4qNhd4tFyQVBA4BWBpUek6MPWOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IesPMI9q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f6b0a40721so2144015ad.2;
        Wed, 05 Jun 2024 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717618272; x=1718223072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=IesPMI9qop3z5oa+1hM9U9pWVhZR8+EuRU3qJeeAt3QvwGkLtL4XzB6YFx7xUwUJQf
         qlHSa5CQLB1H5SjlmaBuysdxjDEoa3gz1wQShbo7za2dyXVLQqNqAPeYKd1Xg2/pdqDe
         XWGjx0BhccnSCohXTOc/5yJgV8rE/NHZfWPGPTRSFaSXhOl5Efbok0F3LfFfiPz0hCgT
         8Moidpdk6URZCgYzquETJsJXG4jo0q3aA3XlrF56rs55rzddSSBSFnTWrrCzCkiXVRN9
         mVeGIgs7QOJoyqQlXUASUQIf0+dmvqkdsRUCs0lNldTKOL4ZvVf4Ifdh1bz8wwHhxlwj
         Ijfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717618272; x=1718223072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBj9aeVGLx9lk0+gvee4j7l4tMQJNLmoyqkeXTYVawA=;
        b=Qu9L2GVsu1ikYDDuQhVR9yShIXmWvqCIE7QifHFl/AGRiU8nu+ohPwYHgpS6TxYPrb
         88DaffymPqSjhciGxhY9jW3wAO/xen0/v76SoipNaTy+GTnj+l76h/97PKYIPCSnvzjy
         S3KWGAU7v81ktl4ZQCDQmqY93gMmc0Ou4LZ5SqrmSBZ2LoHHHm0xobLeImTqnHg6puNp
         MzSFB7oSNRn49oOZghaBBEcT5CHqVdbNMwS5FdgYh0K4ajQNminlLJi28189TNjYG8ey
         8kGZHW2favKUI8vP73IPUb4GfUSHw0Qpdi+9Nkow1szs4erJ6ZCAUBMsvi6jl4MwV4m3
         I0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCW0biwhAl6+eILDAZNyCm9MP3YXoqUwhaT/NkdUPvQMAOJ0KuEfjnWhhFmV3WBb2brAeXYPjPLEA3joo67GlHru5djEleaw7PtKzqTvRikDBwy2HJ3XZKJgd3UvLip41tO7awjtgTujoZO6jZA=
X-Gm-Message-State: AOJu0YxHBv1h20fI8QE2gP5oq9RZZZovAa8kZoC4S6JTXs4VWQ0cjGZU
	D0lRpCJMKUO4h6DtXb6ic20BN7+uUmj7OV+CfXoUm18IX3rGhE1L
X-Google-Smtp-Source: AGHT+IEGu5ShaAHzYkwyBq4xYwcioUEVZUexCPqMcpakJMWRGFjg+Bo4DSNwD23lkoPdDBjRtp+M6g==
X-Received: by 2002:a17:902:c40a:b0:1f6:73a9:ec9a with SMTP id d9443c01a7336-1f6a5a023f2mr49103245ad.12.1717618271758;
        Wed, 05 Jun 2024 13:11:11 -0700 (PDT)
Received: from localhost.localdomain ([177.21.143.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dfe3bsm109428335ad.135.2024.06.05.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:11:11 -0700 (PDT)
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
Subject: [PATCH v4] iwlwifi: mvm: adding check if the thermal firmware is running
Date: Wed,  5 Jun 2024 17:10:48 -0300
Message-ID: <20240605201049.94826-1-trintaeoitogc@gmail.com>
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


