Return-Path: <linux-wireless+bounces-4690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74BC87B0D0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 20:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EA1F263C3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B6669D01;
	Wed, 13 Mar 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anddroptable-net.20230601.gappssmtp.com header.i=@anddroptable-net.20230601.gappssmtp.com header.b="ZvPdQDwQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8456997C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352966; cv=none; b=e/BmgoYP2W3tg9a2qZv1kUB8NIfoKe0tExL7OyeyHG+g2ISQEzOZHdUXdOX9YAszuhqBr+erb8/8P7XWNon0DqHkxdka9aE4jz5Lm7+MY43JK5y8EaK+N3fleeS7GBF3DfmxmXrwOdcs1lah7TCG3tLyIBcTcmVQwc+fThe1lKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352966; c=relaxed/simple;
	bh=d8P2S/1lXpLTVK+DbMjmEVnQgdJt6uNCAkAcBhGKgXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AlhQpt/AsX/LjuR0fdvY9GPOL+OEp2GgO0CEbWqoZ70j+yApMAdoCz2T+KzCTBZstPAG9797G5tTepSz9jORXJ9y3s4NvQ7k4PnzuSGhCkZgpuVnYaEAX24n4VLMGWGjlxeWnwo4ZyEGtIIRhPpPhQnHkFpP4p84Ah9wEdH3tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anddroptable.net; spf=none smtp.mailfrom=anddroptable.net; dkim=pass (2048-bit key) header.d=anddroptable-net.20230601.gappssmtp.com header.i=@anddroptable-net.20230601.gappssmtp.com header.b=ZvPdQDwQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anddroptable.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anddroptable.net
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513a6416058so226558e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 11:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anddroptable-net.20230601.gappssmtp.com; s=20230601; t=1710352961; x=1710957761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGAe8hH3+Zeq8r40fkNvF+CxEMn2/xrWFetVwkyYBkQ=;
        b=ZvPdQDwQ9S0jQJzKmUHR1p2Y6/vb0zB7tZimmmc9l/sQ0sRNx6X2MVvx2auJoTnYhN
         cPk/1Ctcg2d0N3x6FMMYe3RcKdrVBOM6q7FbYRyxBgSqan6SB89rOIUAuGUeWiSF9Wvw
         2Yt24I5MbWg/UKJVxvo67LYSYCDRwX/V4ffyfrVqnjKMvltPjxSoRG3hJn6DinDullK0
         l4VY3gy1raeBzb/MO2szIQrA+7nWSG5BbyKm5JN6m7BbEvLEFkGD6rq195uINzuKasIn
         E6cgic4jQu5Uybm+f75LHyhzPe2tYlGYz8aGs4ljiw4h6m2M+i//RkYTJvs/M7ezQ+5W
         C2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710352961; x=1710957761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGAe8hH3+Zeq8r40fkNvF+CxEMn2/xrWFetVwkyYBkQ=;
        b=Q3NI7eAcyQW7bOWtzFpPOXNgIqKuum0nYrOqUqqf1LoRoPxOek2XFHquvWRZrLfAva
         rpBqTOcbi06XbEs+N88TQ6RESYLwHKrn+oWzp5P5GfFz6x4F6sJoSJWAu3vWCWbbxtk5
         JD2IWxtM/LrhohpknDtz0Zdrl/1sp4DMtnwKgTUmWxPtNeJOnrjQcbjD7f5AOSgoUy/H
         ajtqHF1rvYkDs9V0nAnhmrwD078bFytwtiqkqQG2aur87dyJR2HBNXHAdkDYm01s6MSb
         keBKHz3YmhN1mDpksHQq/6BwIC+f6yjdFNhHhhHfa9iDdtx+Flsi95er5ngtUwgo/whs
         Tz5w==
X-Gm-Message-State: AOJu0YyxyedB0wsBJAaZsydOL3zKvGHzxcMZpLNwD8rYlLVPMv/OL6X4
	4ZXNulfLyidfXR3JUY544hoBM2I4AWxtxIuD9eEtZYXbU1lS6G2DypkjdazJKOICtXKmo3CfP6u
	U
X-Google-Smtp-Source: AGHT+IF6dQMZCY0uO/D+WDoXCOymSMO9IMmF9q0hdA2JlwRZ7rB0vGkbLWlJfVHUhA87tn/q5W6JxQ==
X-Received: by 2002:ac2:495e:0:b0:513:cbf2:50b2 with SMTP id o30-20020ac2495e000000b00513cbf250b2mr1057120lfi.13.1710352961405;
        Wed, 13 Mar 2024 11:02:41 -0700 (PDT)
Received: from bl-64.blancco.com ([193.64.185.110])
        by smtp.gmail.com with ESMTPSA id fb6-20020a056512124600b005139cbb1695sm2059655lfb.264.2024.03.13.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:02:41 -0700 (PDT)
From: =?UTF-8?q?V=C3=ADctor=20Gonzalo?= <victor.gonzalo@anddroptable.net>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?V=C3=ADctor=20Gonzalo?= <victor.gonzalo@anddroptable.net>
Subject: [PATCH] wifi: iwlwifi: Add missing MODULE_FIRMWARE for Qu-c0-jf-b0
Date: Wed, 13 Mar 2024 20:02:27 +0200
Message-Id: <20240313180227.2224780-1-victor.gonzalo@anddroptable.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The module metadata for the firmware file iwlwifi-Qu-c0-jf-b0-* is missing.

Signed-off-by: Víctor Gonzalo <victor.gonzalo@anddroptable.net>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d594694206b3..906f2790f561 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -44,6 +44,8 @@
 	IWL_QU_C_HR_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_QU_B_JF_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_JF_B_FW_PRE "-" __stringify(api) ".ucode"
+#define IWL_QU_C_JF_B_MODULE_FIRMWARE(api) \
+	IWL_QU_C_JF_B_FW_PRE "-" __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE "-" __stringify(api) ".ucode"
 
@@ -423,6 +425,7 @@ const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_C_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-- 
2.34.1


