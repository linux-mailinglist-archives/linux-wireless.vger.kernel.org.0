Return-Path: <linux-wireless+bounces-14813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096879B933D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA541C210EB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093B1531C5;
	Fri,  1 Nov 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GthHV580"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368060DCF;
	Fri,  1 Nov 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471492; cv=none; b=Atgd/8c5BCiydOSx4z88cJLIXxXEoo0LTboekWnvFSQI0bmo35T42Z5tkCdA5ish+KtoDMzCgjo6NqC6Qfsn3FcrqTP7sw+SmTuU7yEXWyRnzuNCkLqlTvor6gcZBWS1dO51zMySLxUtWYQJ5FXtGjcsCYze2gDNzMm+Pbj0ZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471492; c=relaxed/simple;
	bh=TF6bZIvSMDp9mqHIuwU8sLZ1ByDGmrUCLsCTB5m3/fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7kkhAm3+TpcH6Ye5bk36BOc4PROffHxIfk7jAHdoqcgqHBnrqQnBpfkPzqQOmEB0G9I4HJRTGystUFlLTlY6dxPqvmIO2dFxaA8ancsE7M04alZ7y7DOKAhE+COsS/ilSHihYys1eTN09U5k1k2pTltpcUAKeTnIDtHfhwLOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GthHV580; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20c8c50fdd9so21474355ad.0;
        Fri, 01 Nov 2024 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730471490; x=1731076290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz4PoH12jyh9oC2ESydlrxm91wEB4TKbC9HA6hPB9Zo=;
        b=GthHV580v0TtJDqhGOobZsL537xUX9YqnYKruzJY16wf6u6EctG5ZeiBoVju4enYbb
         V47Xk5zGZxtDu6aCT6b4IVVEa+sCN2XHqLu1aWLL730nA3gp/tf+8Pe8ozI57VwUsBYO
         XXTM5lOkMn/8dVnraWAKT6uvIB55uCKg5yJqPe6Y10cvx4YS6yxqQLzYUysMDaQBAmdL
         QLvqPqcZMdbJsiwl2bXVOQBrWNDQGog7gCos9DmKv8P0NGT9qDvuOIx/UxYbuUL57/+N
         F3nCYj835zkTsEojRMH2iWZu1f8Okzf1CbTfL7eS3j4RAr19qmZWeEzopfH/2C4pBsx7
         8Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471490; x=1731076290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nz4PoH12jyh9oC2ESydlrxm91wEB4TKbC9HA6hPB9Zo=;
        b=kAQcI1+7TQh+YcuAcW4uuLfYawT6JKgS0Z7Mkc9yP8u8yHTlrmeYgl94ISmJtV1uOJ
         h3Uixe3UWcWBFDmsf7TS6WE8/UWNMUGLE0LqWHSA11wqb1cv7Fi2AdFGC7j6Tf5/a7Mf
         SCtUHGCPllKgSa32WHmvsY73azUgCANpsryUYMhOe3KLxczEgacwclVBtA24v2CIgoyw
         Bn1fmyf3hYYvrBArhDanXJ130HR7MUZR0jcFaJeJ5IhJLpTtrMd2H7esV/wRzF7A6Plz
         v8cp+Gvh4ZSDzRg8v7TOiVaa5Zet/zaTrqT274Es3G/dPmVfAhrHl1edAfWJ/USBVI+c
         MY1g==
X-Forwarded-Encrypted: i=1; AJvYcCUCmqEyAU22rfR/L3vCfmUXwDY0kfvIDsKrQvgHLTZX3GgYKXmHS1dkkiiPVoijQYPDGN8AFpvzMb2lUYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jgjBhJh2RFid/8xhTEWe6w57RnBVS/rbFnIIIcgA5R1EvEjq
	wS/Spy5co3zLSc6TlUI4H1/hYR7O2xEc0Sr8WcqDgqT094FjxtOf
X-Google-Smtp-Source: AGHT+IFOQx1sT8HQFPfngTtvElgcmTuOgNhg+E5fMEru/cenHAieLUGmhItzqeknF/uTz5v8u54jqA==
X-Received: by 2002:a17:903:1208:b0:20c:f6c5:7f6c with SMTP id d9443c01a7336-21119440041mr56999455ad.16.1730471490266;
        Fri, 01 Nov 2024 07:31:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:250:4000:8246:8007:bb90:49ad:3903])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ef5e0sm22044495ad.34.2024.11.01.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:31:29 -0700 (PDT)
From: Gan Jie <ganjie182@gmail.com>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	ganjie163@hust.edu.cn,
	ganjie182@gmail.com
Subject: [PATCH] wifi: iwlwifi: fw: fix typo 'adderss'
Date: Fri,  1 Nov 2024 22:30:51 +0800
Message-ID: <20241101143052.1531-1-ganjie182@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo 'adderss' to 'address'.

Signed-off-by: Gan Jie <ganjie182@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index e63b08b7d336..3af275133da0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -169,7 +169,7 @@ struct iwl_fw_error_dump_info {
  * @fw_mon_wr_ptr: the position of the write pointer in the cyclic buffer
  * @fw_mon_base_ptr: base pointer of the data
  * @fw_mon_cycle_cnt: number of wraparounds
- * @fw_mon_base_high_ptr: used in AX210 devices, the base adderss is 64 bit
+ * @fw_mon_base_high_ptr: used in AX210 devices, the base address is 64 bit
  *	so fw_mon_base_ptr holds LSB 32 bits and fw_mon_base_high_ptr hold
  *	MSB 32 bits
  * @reserved: for future use
-- 
2.34.1


