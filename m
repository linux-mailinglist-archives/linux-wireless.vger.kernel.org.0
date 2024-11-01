Return-Path: <linux-wireless+bounces-14807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2839B8C49
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 08:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908321C208EE
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330915A84E;
	Fri,  1 Nov 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLiiX4kM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5D155C82;
	Fri,  1 Nov 2024 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447207; cv=none; b=Vtj16VJw0OW9Fw4cU0I2WHYAesFwFFny65yg1iPo2tzJYXXREFs7SrJlMHGD2Hh3xOSVqpRuIIOFmhifvOcHCX4qYLhv6XgSu+zm8UuCPlK7zUB1U2/cqTwIFzPaZe71b/HyYbeG+NzA9aHt0akisMv/0vQy6Tr0aRL65/mYZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447207; c=relaxed/simple;
	bh=TF6bZIvSMDp9mqHIuwU8sLZ1ByDGmrUCLsCTB5m3/fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Po0u0cXyJexhjK0wNi0fjHiEGXHTrcF4tnoQrIF5wzg1WheqOc18eBX0aTpy7gtc+2g09PgVnZC93WHnFAgXGV48D3wXBr2c1GrRTnzQ9utbeiYfB1xIN7PDqR+nABCPJEO+CySGQaR4QVVI2zWvYh9fYnxagKKD4o8FsuBPY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLiiX4kM; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b5affde14so13810665ad.3;
        Fri, 01 Nov 2024 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730447205; x=1731052005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz4PoH12jyh9oC2ESydlrxm91wEB4TKbC9HA6hPB9Zo=;
        b=QLiiX4kMjlcn27EPrN3eOxLtA0V5X55JKKsznrkKdcWwABlXbjkRrBgvKzUTf5bfA3
         xxvWZzIvvtKhyrzLvaREQ+PCPwsFiNKQxLneaUM5k+L5BDBigsKekklc+ZFEH53I5bLr
         yx9eFXhExJFrbW/mV12b0VhwG2N+nlMuQr5yBLS/REYgI9FGJbwXEAL7v9I7dvw7j0zo
         9C50G0CLi3IWfigPzPA/vDWUBHIvOkRgUf+qx1bZs7744WApFv0WbxfCQMp0IdLEGswc
         xD60wO559XHxnALD5LL5I1PVUFYmV75bXtj5qfrZ9mOBwaTJjhgSDSlRcKEMKEliwoZf
         1qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447205; x=1731052005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nz4PoH12jyh9oC2ESydlrxm91wEB4TKbC9HA6hPB9Zo=;
        b=hiyM9aiScJPRBD8bZxJ4xxHPF68GIthuPD3hH1e6dJbvlF+7VRRSfsYEIcptzcvAN7
         v2cuexdLHY4V/HF7YDaMlY3uk9ibfCziwwCFNKoxQ2o9Tv4wsVsNKEHa5AC1nxNgIapX
         atNAhSsw0Bf41MNcaBD/BO5CLVUD55ZUNxuq5Hw9c7kUxvXNecJb9+V8Z2xuAziomDZw
         teAeVx4njue38zsU7DxngaNwd6DzkE/tUw+1cCHISxZ5HbrlyqcD8r6xsq46EE9tGAfQ
         Fkgp/1sMBibNR9/qOCYnDnaFl0jEQzzILW4D6hqp88s8y1Yd5qrUQmQBuMTFEK78cJcB
         N9RA==
X-Forwarded-Encrypted: i=1; AJvYcCXcXwp7R+tbMocE1JzF7sbzoYr5jCAHtL4EGQw1tZl2Wf+g0tOlw4ripvRxYzujDUC2ipD8Uc45cfldTO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmvUeO/mZ0VroH1uzahhoM5vfKQ8jeRu4vjuERttbLqIj711k
	5Omm9PjcsZg1HCRsN3EIyBEfaza2kWH9O14kYB/lkQk5E7Qjg8oF
X-Google-Smtp-Source: AGHT+IEnjqZXRFFl/HYyvTdaUyHu1abBvCfO6O45RDVhOBDwH+2H38UMiLNuyL6cnsCehls03BQRjw==
X-Received: by 2002:a17:90a:508:b0:2c9:6a38:54e4 with SMTP id 98e67ed59e1d1-2e8f12f55aemr21061780a91.41.1730447205193;
        Fri, 01 Nov 2024 00:46:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:250:4000:8246:8007:bb90:49ad:3903])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edb4csm17640335ad.58.2024.11.01.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:46:44 -0700 (PDT)
From: Gan Jie <ganjie182@gmail.com>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	ganjie163@hust.edu.cn,
	ganjie182@gmail.com
Subject: [PATCH] Driver:net:wireless: Fix typo 'adderss'
Date: Fri,  1 Nov 2024 15:46:25 +0800
Message-ID: <20241101074626.961-1-ganjie182@gmail.com>
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


