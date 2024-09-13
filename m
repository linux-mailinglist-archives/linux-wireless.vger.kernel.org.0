Return-Path: <linux-wireless+bounces-12842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE356977C76
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3408DB24AE1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E11D6C6B;
	Fri, 13 Sep 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ/KImvz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184901BD00C;
	Fri, 13 Sep 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220619; cv=none; b=LVnx7UdFDz/XF9OT/P4KNzSPa2ZZYlyCmyk+x5kz1PFUkS+0XMkSnI+cNGCWka4JqvcfshXu0Z6IeVnuAwDmSZT4UYNGm8BFEFNp7q+508zzf1Esc25O0D1f4LMz3GW31DOLHXwZ0I7zroMjRT7ecXYqfRjcEZMHCwmIJSigN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220619; c=relaxed/simple;
	bh=NNM6NFpc00s5ibSztPzQ0f4egmjl3EyQzE/l2jhgxas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfixcjdbVWIgSMBMplpOJI9o7MUFO6uiCEcfze8/SmTjRWeGZY4b5khyP5UBz4MKRJlQrN2brKkkxgXnOuqZnv/K4p7R/GW2NR398VHJpWmZ6YHkmnC0ey8xvIRGxGoKPxkSKJ6NUXG2IQd9LghxPTWSA4HWLKyPwLBKotPelz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ/KImvz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso17623675e9.1;
        Fri, 13 Sep 2024 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726220615; x=1726825415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+LszOSkNNFgaKX3BXxyztS0BS91MBez+e7KxoIOAVE=;
        b=mZ/KImvznvN8x2P6qti7Sr7fXwFrca9w6Ovd2M7PcQDaZMKhMpjBuOcmr+kvHjOLQN
         ELIZGKBl6pwH0BklWNZs23VCnuePVX39LELa5blMpjOIIwXsYHmQhxm11ixji7TylFiW
         19FEYmCtKczFD1wqRHtHSivRVXErZsbyKYiWp2NvX04n6IqThdGqmyhpItzqfz/YexCa
         7Lm+2mlJJSRgdeMu6GHCPHS/hpKWMvu/wnxIK6rOiuwaubHYqPzC3UH8hkCt9IGSFbFH
         N5zUtPoQWbIOKj5iif01okBK5/4j2r7XVkJVvXWn+VgkJgGO9P74yHV8N7J7XHEVxBFx
         rwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220615; x=1726825415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+LszOSkNNFgaKX3BXxyztS0BS91MBez+e7KxoIOAVE=;
        b=iGiJuYtmmbd71wRDkX47jN9losUWYodEkyzEiJDsuZLLRE0x3o4BzRLWYay94SV1Rb
         REnrEkKxFFwW0ljlZEt+WBO/RFCKLrJglDLuBxNMYKRtgbVYZ9Hou550pJffVTxWO9hv
         8dlkYHndAvq4F5oH/Eq4NUMHSUfVfzCYy3OBaeF3BTB0B9ecZwYDAkNypopEgo4m+nrj
         asJDdYb47eyehgwh3I5DhXOWTjJ3jsYth7knhD+ITKbJpNQ8jGb/p5QdZVUQa2EuauNE
         P6dT1MzLK1/HOt4eOu8s0qo0ZgFxz1/Li5FGmMjoz7/3rpsVrAR3cmDwvxAzJlRl+kIR
         IXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2/g9sndMVHvlgk+QRcbg5oYNNVfzSq085waEEmrllstYQluQB9CsUYj/QdWLJz90WZEFcpiHLpPYzzPwB@vger.kernel.org, AJvYcCW4OD66GqmFO85CwM7/s0FQdNhwA7kkg95YubrYQV3Il7vSCuw0OmkA6Oy+esBlgafLUh+yyqDlrb2eE+L2WoQ=@vger.kernel.org, AJvYcCW5M7+9OL85NsuTfnpq/BEF26IKtcOlGMI4I8vN63z/V0Ysy5y2rtEDPJ54iH2nFnCDql0fuCm6He+CgEfMc4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgbdLt9/2CiDie305IjDM088ANNSUwj9EEwn4vwtgxWSCBteR
	ARBAoLWn5C7zOsGsyBSNZ5I8BRXJbPgNdkvKFNVzXxonJMJo6rtL
X-Google-Smtp-Source: AGHT+IGYG+SImZloXijYbltE5rVdzNdwV+Adbn8SFOU36KV8fBrL+SjzcQUp0Wnt1jy1zzV7zxVQGw==
X-Received: by 2002:adf:b30e:0:b0:374:c33d:377b with SMTP id ffacd0b85a97d-378c2d5a7ddmr3562864f8f.45.1726220614583;
        Fri, 13 Sep 2024 02:43:34 -0700 (PDT)
Received: from void.void ([141.226.9.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895649733sm16388057f8f.8.2024.09.13.02.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:43:34 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>,
	Kalle Valo <kvalo@kernel.org>
Cc: wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] wifi: wcn36xx: fix a typo
Date: Fri, 13 Sep 2024 12:43:10 +0300
Message-ID: <20240913094319.13718-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index bccc27de848d..7ee79593cd23 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -167,7 +167,7 @@ struct wcn36xx_vif {
  * @dpu_desc_index: DPU descriptor index is returned from HW after config_sta
  * call and is used in TX BD.
  * @bss_sta_index: STA index is returned from HW after config_bss call and is
- * used in both SMD channel and TX BD. See table bellow when it is used.
+ * used in both SMD channel and TX BD. See table below when it is used.
  * @bss_dpu_desc_index: DPU descriptor index is returned from HW after
  * config_bss call and is used in TX BD.
  * ______________________________________________
-- 
2.46.0


