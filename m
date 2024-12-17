Return-Path: <linux-wireless+bounces-16473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D609F4B5B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 13:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FC57A40DF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A741F3D43;
	Tue, 17 Dec 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6qmMKjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD71F03FC
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440154; cv=none; b=sc9RJVBnTmZwgVFDIQWBGqVnMfDhja+xJX23GwK6ULXmZeV/K2SDd64D46s1mLG8kjsBJMOLBohQz/bO/Mbdi/CrX4dB0phHFqfjeDuzno+FN5ovYz49AD222OopOb0Kt+a6RAe+Xcb3tp8fVRvG9RXTR/ymLQdXwyiyvRfy35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440154; c=relaxed/simple;
	bh=3CKnHNjH+jwH5zwLJfrFBP0tmerBCMeB7tmsQ+JP9YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=APRVXuLgHYZ1j/GTVkoCpk+t7/p++rd+9vqeESoYPAT0LJmPMZ+cpY5sVMWikbNIiV0evVSOSIssAwbP/ljj8y8EYy4PXekyVCNtohkd/CCFjSwYnXEfQsHKr494CdFqxKUV5SCahHpFQJi6+adgFBaHYOVJnSB+YSuIwo64Hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6qmMKjy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so711989366b.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734440149; x=1735044949; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgZd//oGB3D0/SHnIuOr6EaXxeoNU4PXKsD5sDU9eng=;
        b=l6qmMKjy1Nx8j7FS8+4zg11AiQbKj2jRauVENOYlwqirRSQMW+sN1POdS0zhK6Z/V3
         vSEAJinymgUp6lhUlqIBJJrywzVN7E8rv9E5J03tm79YiWwZjr05gxLZFym5r/idZAUZ
         IOoXgFJ9LUTYHk/IKB1B0k2LV13rYIe08cAX80TQcGtvcamTtFHGRK1v2ByTnzxIj4KN
         K1Ac84fRs5iZyF8DaobsmLybtfCNs5lUYyymTlsb4oSiH1Lnswope2rf8zGpBsEsxX/A
         z0F5KdctahZC39RnFq9TtX4+fAv/eEhklWR8UQnzPKoP6mme+Y+fCTr5LqdWLvbAkBgk
         tbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440149; x=1735044949;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgZd//oGB3D0/SHnIuOr6EaXxeoNU4PXKsD5sDU9eng=;
        b=KGthubGiVd5D4EX16ZwR0gvgtQjT1asHR06Kj/K9U2jcHnTbph367QJ2TNigcyqyrs
         gyeHAv/79k1dmNsfQgD3ezPIieJUpfnQQvEZ1dDndtOT1STEzS6jcHbEPIbUj71P3XMI
         CJChHp9z7UE7h6Qvlf8pZkhCk4OnAc3LzTUNUHyc7/QyUH2dCQOyqrf6J0ibc9kMvA1t
         wvHRZGfbfmEZ1jU8+nWyjZeYPi0+c7lm30EB6DV6BGhY0CQ0TJKOh13r96wiqB73Bijn
         pNuRWIiVGhsYNrCZDoj5+0G97sZBgosxgopxHp2JffG8sCgEvckSZBqC5Xdym3c9EQIg
         Gcdw==
X-Gm-Message-State: AOJu0YyulS8Ff+g0aYmz/2tCL6nmx+Psa5PZQvvyfggRT28+YGyb3n1v
	+yig0oXjoOtXSFQKOEl6YE/8oAcy5zphRi5kXTYzSbi9Lc1eFFtJlKzNEktBXak=
X-Gm-Gg: ASbGnctj37iQ0VWszHC9VgSYaZ7BbGVQuoHY+2csH9bfp+QWdXR033gQqV2s7nQp6ct
	B0Lfhr3Une6Wak0rsZ2dqtPK7/GIod+wwY5yw6uUIBTWOPYUjFEVksrAU8WaSZXvYs7FkaUtygN
	y5BFhQ4GHkPam+a/YdfMci18zfs0UnEIb1DUq9dwzCfODtMwciII8ArmvJ3PDkpOnyukVU4jVAq
	TuVb36fgZlCDLbK692/CXXQnmI3b1+s3DBTqKhebUY1+qcrLVZH76Ol4S2YvahNeJE=
X-Google-Smtp-Source: AGHT+IHy3wTLEBYa02eLhJwDwxGpeyqkNg2ZTkwe4hozyHj/eJSkGWPwUopusDKgYBQ/2qDVMAUv3w==
X-Received: by 2002:a05:6402:4499:b0:5d4:55e:f99e with SMTP id 4fb4d7f45d1cf-5d63c3405bfmr43091113a12.18.1734440149347;
        Tue, 17 Dec 2024 04:55:49 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963892c1sm439921366b.133.2024.12.17.04.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:55:49 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 13:55:48 +0100
Subject: [PATCH] wifi: cw1200: Fix potential NULL dereference
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-cw1200-fix-v1-1-911e6b5823ec@linaro.org>
X-B4-Tracking: v=1; b=H4sIANN0YWcC/x2MQQqAIBAAvyJ7TnCX0Ogr0UF0rb1YKFQQ/j3pO
 AMzL1QuwhVm9ULhS6ocuQMOCsLu88ZaYmcgQyMSOh1uJGN0kkdH6x1RQrZTgh6chbv+Z8va2gd
 EkCRMXAAAAA==
X-Change-ID: 20241217-cw1200-fix-d6a722f1e68f
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

A recent refactoring was identified by static analysis to
cause another potential NULL dereference, fix this!

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411271742.Xa7CNVh1-lkp@intel.com/
Fixes: 2719a9e7156c ("wifi: cw1200: Convert to GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/st/cw1200/cw1200_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_spi.c b/drivers/net/wireless/st/cw1200/cw1200_spi.c
index 862964a8cc8761bb412b15addef562d61811440b..52386dfb5f4aa9c1f3e12e2a4002241d9ece72ee 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_spi.c
@@ -442,8 +442,8 @@ static void cw1200_spi_disconnect(struct spi_device *func)
 			cw1200_core_release(self->core);
 			self->core = NULL;
 		}
+		cw1200_spi_off(self, dev_get_platdata(&func->dev));
 	}
-	cw1200_spi_off(self, dev_get_platdata(&func->dev));
 }
 
 static int __maybe_unused cw1200_spi_suspend(struct device *dev)

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241217-cw1200-fix-d6a722f1e68f

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


