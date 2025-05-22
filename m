Return-Path: <linux-wireless+bounces-23309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A745AAC0B79
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 14:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF27AF888
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D728B3F7;
	Thu, 22 May 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJU2l+/V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B128AB1E;
	Thu, 22 May 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747916238; cv=none; b=LIftqxUifY4kk+T/NppkF0G5U+KUutDiMjl88Sl31t64N7WR6xDHF8lQTl716Erp4M/WtwM77P4Kk2+/PNXhkcvhj36Rvw/plqzKZYmqiFgn8RlMEXlBSWB5cLW0THNDE3jWEXH3oOuRiT/whueQzbTcOcbfO/xzKCgBaxf5k7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747916238; c=relaxed/simple;
	bh=ybrI75a9RN1E/0+uLOs2ARYJ2nlAKkqM2SIhQcdDZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbDEw3w5ba50VNd/EXarRDoLpcxgZQwu/K09JDKUtrpGfICIZ6cKrTO5zIIhqMsLCPEDQeT/DNo+UFOkQCOuMjItSrG2TYzN2VtQ0LvQNWMqWgFez846bBMJb9ju7EoWM7NqIjDS7kwW1X571WiBhxI9vi/EnT07T6Zn79XjPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJU2l+/V; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a064a3e143so4514832f8f.3;
        Thu, 22 May 2025 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747916235; x=1748521035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4ccgbumLuRGNhw1wu4Pws8lLAmQ2dpUvbInDT1mq2k=;
        b=SJU2l+/VPDBRYLTpjjOX/fEcsxGyI5Bd26TStpejM/zuJ8aVzRJzwSJvkiH5E7OapD
         ZrQXraOq9r1de2NhMNyHW0ym2px761w1+nI+KUsKiHWfvCBCvtAiAXDu/QWFhfXInAjQ
         3riDQZbTyKFEPefEMKqdSpghOWpZURWrYJXON/L255vz9+aAK0p/3qIZ1CZxyFbKmsgd
         YEwlRDCxqQZ8NrOAFvrmUjIHWWe1OyCj5mkwW5NY3maPTi932yrVR3fzndNDzcGOP/y/
         VeEgeTTgPplWAOvN6BtE3CRsKk8AHIi6Mk7Zf7DmM52hfhrZdQAYOeSKKc+nEhymXRfx
         kAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747916235; x=1748521035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4ccgbumLuRGNhw1wu4Pws8lLAmQ2dpUvbInDT1mq2k=;
        b=pXqfjaN/EBw8F24eyNEmygYZgrvPFOL8OE9HNSIp9Uprza6xG1NzG+HOTfoJN5vZNJ
         IRM9Y9kEGVm4S6X6F9xrAilBJswwh/w5WACGv5SSFaRf7BODw7D/We3FkeSUFBUHgY3+
         Kr1BygErdLOFtd1sjopjzJSYGHz9vPa8t/EaP0xzX4qTDVSJmgRJvmkuhRFG2y+sHN6g
         eCBCF21xh3aRErlICTxSwJDx3f3rsMoiB0fnRGjfbMBUIx1r7RW1VQTIxGfnKpVcurqz
         VU+U35rpN40chz+BdeWP4ZJDtaiQPGA4SPlP6zasBNB+CC5n/GYYVJn2DZsCdQi0wPw6
         pDEA==
X-Forwarded-Encrypted: i=1; AJvYcCWj9V9y6sMOF+UITjgyZkMBlX5MBzQ1CE11CEknGgTb7AqzAM0afu+XrA6I4EcOxtV3ZT/hnFnldYXm1FUlDq8=@vger.kernel.org, AJvYcCXPyogreJXGMba73R240KsrkBK5htNWQz6SQhO6YQFpwSjRsgrqKldcSMZL24fuqmvi7I9Vn6jIkey4NRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAC32sU3RtXmdkK6kJt4YxnLRSXQQYCrb6AbFYYBO7HzluhK1Z
	rCAdtSfHRl3I9HKrogOoN8ptMJueuIQXeu9kLLsCNknOKvFn5c+g7LMx5IU1lHm2Yo5LOA==
X-Gm-Gg: ASbGnctaqJU5RKJuwH2256wriy3Vg9UMNRbEjRWRQlDBXH3s2dc82htYehueBu7Dh5x
	3phOkJTHuvbiZKejomGfkonhXc0uPG8Z9aXNMxOBZMr/tfThi1UbcnhhnfZzQIcYEyUSVBG5jGd
	TaZncptW1qWAnkXGbeswpUEajd4jtQgcaOHLwyAwYjwN2uNVXX5B68Pk8+Y5zjaDg/gB8PM59AQ
	WL0zBkZFDeUTX8JUySduU8LKa9pVoaGiGyRQYou1XflrnRO0rsKUH/ZZUjiGWEWG1+AIFZvz0Gn
	6x6d9RTiG07BCWpKbjJLfRiGxTJyuWED46+kuZDHHfUfD6akJON6nCsi72gI
X-Google-Smtp-Source: AGHT+IFkOdZ+GSdpjX1YgFUwQ6nomqhDvBeozfmiqqIvQVXgOMOJmKj8zOCKqygDltErIiabx2znJA==
X-Received: by 2002:a05:6000:2586:b0:3a3:6a58:6f99 with SMTP id ffacd0b85a97d-3a36a587093mr16305481f8f.19.1747916235086;
        Thu, 22 May 2025 05:17:15 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca889a7sm23122754f8f.72.2025.05.22.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 05:17:13 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: Fix incorrect logic on cmd_ver range checking
Date: Thu, 22 May 2025 13:17:03 +0100
Message-ID: <20250522121703.2766764-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The current cmd_ver range checking on cmd_ver < 1 && cmd_ver > 3 can
never be true because the logical operator && is being used, cmd_ver
can never be less than 1 and also greater than 3. Fix this by using
the logical || operator.

Fixes: df6146a0296e ("wifi: iwlwifi: Add a new version for mac config command")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 81ca9ff67be9..3c255ae916c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -34,7 +34,7 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 					    WIDE_ID(MAC_CONF_GROUP,
 						    MAC_CONFIG_CMD), 0);
 
-	if (WARN_ON(cmd_ver < 1 && cmd_ver > 3))
+	if (WARN_ON(cmd_ver < 1 || cmd_ver > 3))
 		return;
 
 	cmd->id_and_color = cpu_to_le32(mvmvif->id);
-- 
2.49.0


