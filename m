Return-Path: <linux-wireless+bounces-24300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED35AE229B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAD37A71DD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80142EA466;
	Fri, 20 Jun 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHQxZlCx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A12EA738
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445987; cv=none; b=dM5MsTq6WnQCBiM+Q2XKa1Df17CDtymV9eY6fKj8Xj5iSDE2nsiaKctmbpE+Mzmyd/hg3k+pGdGXFPVtYkUSQ12XIvheeGjpncreRsqaKfOpNIu777UQltdDfK5aXI8I6JfP+JOiSenihOSHKo4qbYCpNsuzRTlax331CdLleQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445987; c=relaxed/simple;
	bh=lPT7UgNXe+2+mQGZ+O2OFlkdzmTID0pGFbrnOBlpUMA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CZbGyIjW/gcZ7mdZLC9bheR59hkJ5pAPg/k0udK6YEDglpRP4j1uZv4h4NtXpszaoupGJT0DAsPkRdEbd4aQtKIz4In4XnMDbfoM94GggUqzIvdyfYK/yIj6FjcfJSdXx6v6anbxVnXjSqANvbCmYj9v3nUbUlYIodxdNOYnKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHQxZlCx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4530921461aso18352085e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445984; x=1751050784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMw1NuN4txbJObhEt8lG+lssZQKFN9y0NiSBw0A6kjw=;
        b=LHQxZlCx7hWlPJYHhTQ/DOnvqUqEPCQjR2H5A2+3BOWnCBr9b2nmjhNq+FunxsggYu
         oGxe+7jgz2toyl6hrrvjREk8PiFjlowPq1MNoulNhu4ZTm0D5nVrWiZsWGsU/4A7yqKR
         E6AvL9QGPeSoeyjHP+z0Vt9falzzRP3R6ToHQHYYszEHqwGsLsjq0FB81nNNibJWrQY5
         A+GZhmH0fbdI0+msVm+Zm99lAvWuLA3kXj4bmLecZNFnLOyjj3T+BfbRQIClEWKyTCRc
         hLDJAsee44jigiEnnvcgOcegqeb/nFQHlaJGuDMPXMjsO+Xkd7XiPZSDQ9zTYW8se+Gj
         X16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445984; x=1751050784;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMw1NuN4txbJObhEt8lG+lssZQKFN9y0NiSBw0A6kjw=;
        b=n64i/s0BoqhaTea0qcRF5l4QXaTGM09+VkiFjAMilM2/S53jJHS53zCpf2gFVJaCMY
         2tOb+QSwr3ioPhQBkPEw5XiW5UYcScKUEuWl+rTc6JennMkA7jfM9d+pZNWa00oE32uh
         VFnkZ5eE1dmQKuLD1cK3GFlSXyFSHVUM6pHSrhic0Gr2/1rnscxtF1+/gdPAFF7nWqtE
         Ix5Gko86FxpP4zC2LNXe0Hwyf7xG3ymC4c0ynr4LMJWRFDVzdZ1Rif4jJ817TmuI4e3S
         nYjTIvx218n8/UjOes+o/JDdhCR1UfC5y/Jb5QPI5R5SMJr5Dj0tEmXANnnyK9DnfpDC
         /BHg==
X-Gm-Message-State: AOJu0Yx7WqDRlJYnkYutXrkRavJifbCGhzS3xM/yt5pshvriot2AoP8V
	IDWe/XCn+yGUqv+o1K+y1Q3C66Zxe2PkIqWFzu28uFuOQS7JqfzsKlGh6eFOHg==
X-Gm-Gg: ASbGncsLYFIiicmLe1mdOYfYTLp4FR3X0zyz1kP8HuUkka8HuNLiebVlNVOqVCd6A/I
	8a8nwex5cpdd9BfpoHtMz2PKQnABWfZ3ZhYg7ovKDaLxFEzLFKYy8dgBxchnf4ybTpszod7CzGG
	VG2wHmd5xpF90NYKu7d/GTCcei1LSk+sX2+/eOMcHNzj9u8SFbYYd12FoSKTHs6/KGQW1c6Ks3H
	caE3dSWlzbkmdwZvqI2ccaoL+U81YBSNmWG1zkVK/Tx+MYQcVOjGSnr22D3qvqvmbZE6wY87wCh
	1grxLuR/DaiMyv9A+SoGuO0GEjeihRgYe5xom4Hj+8k1ilDkcMfdMRTMoTLoqMqlMuQW2fCCidb
	1SiC+
X-Google-Smtp-Source: AGHT+IEUuxouL3oxexqyUVT/18z3zBxCujwiZ++SE1TR4iPN8OCGFi47vPETAmIIRF4lYuUrhkrhnQ==
X-Received: by 2002:a05:600c:3b14:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-4536539c469mr40691015e9.12.1750445984146;
        Fri, 20 Jun 2025 11:59:44 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e9844a9sm68376425e9.12.2025.06.20.11.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 11:59:43 -0700 (PDT)
Message-ID: <4f8e955b-d728-4aca-9e65-cdb146f58ac1@gmail.com>
Date: Fri, 20 Jun 2025 21:59:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 07/14] wifi: rtw89: Add extra TX headroom for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In the case of USB the TX descriptor is transmitted in the same buffer
as the 802.11 frame, so add the required headroom.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index bc7af6117709..3e53b1f1a35f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5578,6 +5578,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	int ret;
 	int tx_headroom = IEEE80211_HT_CTL_LEN;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		tx_headroom += chip->txwd_body_size + chip->txwd_info_size;
+
 	hw->vif_data_size = struct_size_t(struct rtw89_vif, links_inst, n);
 	hw->sta_data_size = struct_size_t(struct rtw89_sta, links_inst, n);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
-- 
2.49.0


