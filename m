Return-Path: <linux-wireless+bounces-24073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D6CAD7136
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49FE1899105
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3823BF83;
	Thu, 12 Jun 2025 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0auFR2q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61E23BCF5
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733655; cv=none; b=fn8b0F1K+za4t/r1gCoglb0kIExZLWEqcLOSwvNs06sJTcLu304YRVsgchso1kD2mKsgN4uqRnhDin87ZwdlaARoIGbZzGwGhjT4hzaoHwGUX1Z11orlZWihXxKt/FVhUtfGEnWeKf6IYW2oNw2aOf99o9Yy3pOCbdE6HdqZlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733655; c=relaxed/simple;
	bh=z6N1TMabJk8XUstMPq0jYPGGMmny/6BK+fsPOJYZ5CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUNXQi+O6Y+nnPjee8TgMDgDpnmP4VzTvtsVbjib8Z7O6tQzbIZzmFbba//DS904q3FqmaZDAKBcFTXj017fANdz1hjab4Sp7eHdjmu5zN801SVblde5r0A9G71cm5NAAwKw+lckE6R+7fW5FRcmC66WPHenECGGxIjcFGkmcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0auFR2q; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55325956c93so80733e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749733651; x=1750338451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCVYnr2NHXP6YD4R7dCQrJMSmoXGQWCXxHYKeLMW5Bc=;
        b=G0auFR2qLEXdjYxnS9WX54xv/bOdEO9CGe//ke8upTBnp4RpuguQr8m6NPWQXoY+Q8
         vqu6GT3JvXbtSAU/QoBsQo4EGHkHrenpvfUmMW6gHpUFXzSIRTY3xn9Ba34acA7KNv3J
         QMVBdFYHmzsfElzbxkclTK1HvR9f33kVa0eIGMpQhVYHYvrXyvBK7ti5nCWrMiHkqb8+
         8Rh2epcQoRa6/4SJhU8mgVRqJSSv9KqOAyK3upf4EMkrNVyN8mn5hdz/uFwSr3gf6Jd9
         d4iivEP0oCf6x2goGDlVB4PaA12TGR5/uVecESSjouS0UUp2ksSwvQGBhZzct2btTn35
         Tiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749733651; x=1750338451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCVYnr2NHXP6YD4R7dCQrJMSmoXGQWCXxHYKeLMW5Bc=;
        b=G6gzW+vpmX4cWirlFZUcKa7vV9o5vhbVyd1p342KXzK+0qyhAtC7c634kMElM3uYnj
         vVx2UCLnAKV5jeAlUuyOTGLvo2Ojwegkvws2xxLoBZgyYGgOLbQ+je1o4ZFS0MTlyqQ4
         zw2lI89ajrWi8vvJmCoZYv1vlT8yuL5EVu2ErO6ZeM4jOkiGcxF3ozTt3Kf1ab38ETBC
         5WD7IQ5tocNmEAoyN4LFXZwuSo3OmrrmkUbmBcbqMznMwB+pfXT2+c4GrJnex2+DBjXG
         ODFaiKE8gvF3DhOFVCZFDnuWoK+hNptFQDP7a1JditYykI/yWTrc/eyqeEyXn6epyBRx
         t00A==
X-Forwarded-Encrypted: i=1; AJvYcCXdWOoP/SzFFUClmaHUa11elhgcJzVMamsL5BCkZX58fLU5aY1tkZs0ARvBlpDDE44IQM0U0uBFE8SaTcQyxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3sKqgSlepC8AmnGvxhtIkOrh2QtpVTiRfpe+l2FCwgCEplaxR
	oCsEGSa7h9nbUkHVHv4n2bAwLkLseFx9xZ5LOFFtNrXrxm4ELwQPVxMmCJxULXecizw=
X-Gm-Gg: ASbGncsbGLA0Y8Wy0FARqTAYrNB4mS3aQaXrFyphgbd89g7Wxc3FOJiqqHnB9K7sRfc
	uCDHH6IBE52jUAk+UCL5AGBzmcRFxDg9a3dg/y2EZdQFA2cFWAHpDXEYy/ddsYaBB4w01FE3Y+9
	UACKhkUv1HJpeJu18ia9wSenKCLy3s0ojOp18gGsgPPozQ1e2r0ZRjdmdfp5lJ892CMKE6kPfZH
	bZXR697xQNyDnDTQLzJYZQ34tV8/8/VHPIPt5HbHw7W+5D90xQQjsQBBOe1bViOSku8FGujHl0n
	NiXrlBnpKTBU+vu4yCnJ7VIAcdOy88DE5oNf8aVu0O8FJbWHuFWaQYu3i2yreMeieKy+pZniMR1
	e8ihRUlCzuh9wiEEAD31B+A==
X-Google-Smtp-Source: AGHT+IG99wDY0vjvv6M/1KtXYegvp4C3S75fNTyHcxKq9q0WZeCKaCu52C6L42UnkRUNGviHQyf8og==
X-Received: by 2002:a05:6512:e93:b0:553:a889:9f0e with SMTP id 2adb3069b0e04-553a889a14dmr244104e87.15.1749733651043;
        Thu, 12 Jun 2025 06:07:31 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-553ac13f0besm110490e87.84.2025.06.12.06.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:07:30 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: miriam.rachel.korenblit@intel.com
Cc: dan.carpenter@linaro.org,
	arnd@arndb.de,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] wifi: iwlwifi: pcie: ensure RX_QUEUE_CB_SIZE fits bitfield for gcc-8|9
Date: Thu, 12 Jun 2025 15:07:19 +0200
Message-ID: <20250612130719.3878754-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC-8 and GCC-9 emits a hard error when the value passed to
`u32_encode_bits()`. These versions somehow think that
RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) is an out of bounds
constant.  Open code this calculation using FIELD_PREP() to avoid this
compile error.

error: call to '__field_overflow' declared with attribute error: value
doesn't fit into mask

Fixes: b8eee90f0ba5 ("wifi: iwlwifi: cfg: unify num_rbds config")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYssasMnOE36xLH5m7ky4fKxbzN7kX5mEE7icnuu+0hGuQ@mail.gmail.com/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index cb36baac14da..1854d071aff2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -204,9 +204,10 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 
 	WARN_ON(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) > 12);
 	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
-	control_flags |=
-		u32_encode_bits(RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)),
-				IWL_CTXT_INFO_RB_CB_SIZE);
+	/* This should just be u32_encode_bits() but gcc-8 and gcc-9 fail to build */
+	control_flags |= FIELD_PREP(IWL_CTXT_INFO_RB_CB_SIZE,
+		RX_QUEUE_CB_SIZE(iwl_trans_get_num_rbds(trans)) &
+		FIELD_MAX(IWL_CTXT_INFO_RB_CB_SIZE));
 	control_flags |= u32_encode_bits(rb_size, IWL_CTXT_INFO_RB_SIZE);
 	ctxt_info->control.control_flags = cpu_to_le32(control_flags);
 
-- 
2.47.2


