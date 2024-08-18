Return-Path: <linux-wireless+bounces-11587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D93955BA1
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 08:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB5C1F21CE0
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95CD14F90;
	Sun, 18 Aug 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcgZmvjq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF81BC3C;
	Sun, 18 Aug 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963756; cv=none; b=tMv5FabzOZqzHQpnXXWEeLfbysvtCgQkPqA4UK6eI0ovp4qmuuTf+EfaZevPQWxkScjkvBHt19KJuNmyl9sqwbMFgySQTH0G8UO3UPiiZdyC0mVCCtK+iEPlazDbeKSMLisiSdQN4MTP502WJOgzAlRcx/KtBI3/uEtvE0faTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963756; c=relaxed/simple;
	bh=uFKjpSKWuJr4EH1NYhsVClFE8GCC/v5Fjf55YsSRT2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPEjOqTV8FTeyii8yWxl6/e/SWc5270MRy9UJhlejJKVJOdpquZI8ATPngdYc4R4S8WWQLcyN5UMVWhuoCsfmowuN/Z/QpSSjw6VNHe3Gj/rm+2IgD0Vf/6KcFhuP8KulsZWt94wiqkzbL1fBI61M7Ki0Ff1Hy7sk9U8WNY9kuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcgZmvjq; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f6b7250d6dso1310934e0c.0;
        Sat, 17 Aug 2024 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723963754; x=1724568554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qcuV1/bhqx2+PhvCkmyGByyF97mh0J56XinoCbmJVs=;
        b=NcgZmvjqWBHNaUgFKUrAgBKJoAfzkqEJSyuwwQDQUNSR/IIWA57G2gCHRVTx/Wd1gE
         fpSz20BKufYEJjxgjNwjJccPnXAyA3C/PvFAiqSBnI6SSSOrs7erfwPWkoD0BqEl/9RI
         JZ0ae+DyRzLcjnG7HbKuM1QT7L3vgro9T5hOh3A88y8XMVLJXKIMsCjZ0eVOUXhkyS3F
         5dvnvsU1o3RaaHkn/uhFIOjShIjqroBJRoPRN2XYyjQQDdjyeeTKotHNmy1IvR9GOL6e
         WS5WJ19NPrTW6m1YyoLpEDaJ1/FEbD+zmyrccZ3bwJ6bVbjUjPk8sVsfNVpfSuORdAI4
         WWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963754; x=1724568554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qcuV1/bhqx2+PhvCkmyGByyF97mh0J56XinoCbmJVs=;
        b=csqkpPWqeqMt9rKscE5EI2aVw+mnUAWAqFsLqu5liXpLZ3VACGd/ZqlzWlbJkktOQt
         DmGmmwBXM2b7lFRtq5k5ro70ZM8B4fasb4jTIxwEvYBDtCcc3oPMwEVyI2D95KgrBkTf
         B445qRbQ9lvTtlfwzTTvLi5MzxjbmP9WWZV43BHPKdK0zrSLHcbEJtJ24c3LpwPu6BHs
         khV5TUdV/IINcb4mM1TlwHLeIqXswj1k2iwxQmi+UjRFNJO2wgbEZ95/kx8GRKn17j+m
         nSWRwCrPufto2LAfjpfpoL3Hn6o7KSdVpo9MNvv+qnlPBkBlT864yzcAJz44Z/mJTdtu
         n4OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr7kOf4P6wSOXPINyl+tNn+oN1NfB9HO3foXxhqWh+HagPI6f8Gfr5m08c4I3XFN0DReSy95yLkD0kmC+T5/fmqz/A0Snhd1O66Wfd
X-Gm-Message-State: AOJu0YwTBizuKy9QxM8Lh/NHck6PB08/9lgU7cY/5OLhqMHftPyEdKde
	XuJ7Ege7ODUaCgwRxDeWJtYbHkwT8Mqj92Qwwza94LjlOfP/LwHQRffyr33D
X-Google-Smtp-Source: AGHT+IGebxRjer9JYBhkjcmiTwzNK6AFkhGDZxwz4GvdkZmQGwNDgqxX9tX+wSRcxQy7IHZQ6/B8ZQ==
X-Received: by 2002:a05:6122:a21:b0:4f6:b094:80aa with SMTP id 71dfb90a1353d-4fc6c9e0725mr9474060e0c.9.1723963754276;
        Sat, 17 Aug 2024 23:49:14 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b8e30cfsm811032e0c.18.2024.08.17.23.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:49:13 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH 3/3] iwlwifi: mvm: Replace spaces for tabs in iwl_mvm_vendor_events_idx
Date: Sun, 18 Aug 2024 01:48:59 -0500
Message-ID: <a0014cb240df075eddba6a81dc59fac69469acaa.1723963126.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723963126.git.soyjuanarbol@gmail.com>
References: <cover.1723963126.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch replaces spaces with tabs in the affected source files to
adhere to the Linux kernel coding style guidelines.

This change is purely stylistic and do not affect the functionality
of the code.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
index 080a1587caa5..0f7fa6032c66 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
@@ -104,9 +104,9 @@ static const struct wiphy_vendor_command iwl_mvm_vendor_commands[] = {
 };
 
 enum iwl_mvm_vendor_events_idx {
-        /* 0x0 - 0x3 are deprecated */
-        IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN = 4,
-        NUM_IWL_MVM_VENDOR_EVENT_IDX
+	/* 0x0 - 0x3 are deprecated */
+	IWL_MVM_VENDOR_EVENT_IDX_ROAMING_FORBIDDEN = 4,
+	NUM_IWL_MVM_VENDOR_EVENT_IDX
 };
 
 static const struct nl80211_vendor_cmd_info
-- 
2.46.0


