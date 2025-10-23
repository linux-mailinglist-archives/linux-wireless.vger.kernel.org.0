Return-Path: <linux-wireless+bounces-28187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F03C01415
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 15:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5EC94F525E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513A2FD66F;
	Thu, 23 Oct 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRDPy2MI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B54307AF5
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224693; cv=none; b=K7L0CugUTJ0O2C8iCheZAud38yhqYTsNciS4pjIvO0XiIiurOrnsegkockoJySDzgHiWfnfS20/ZfXa9vPviMo++h/DfvMqvtaWVXISzBpbWHGcKK/YOeoxDYb3kXREKNoO+XOmBrz9Vlr+deIc4guF0AoVB2CEAe640NtOJ1BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224693; c=relaxed/simple;
	bh=MZntrYzYxpIKR4lTEuQ8vg90cnWJfjxVo3eqGMp0mdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X2IWMUQVmmbXTAnJqLkRjbIHX+7yu0E6eUxOlGSeJFNE2ms3Da/dTv37angLI8Ee0No401dYOerOFAzRfx1CiDFxrEwahM3y735d3YGAs1VneU0SHK2LdD4HlgdwQaRxRBq2QqQ8LaMGGsgoA8sublFt0nghqVt7gwGjDXORYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRDPy2MI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so910697b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761224691; x=1761829491; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=id+wIYbTFy4GJ5sovEHifiUi3WKFfS9SlpVUAwl/jlY=;
        b=XRDPy2MIfvKe3KdQ0elCbYt/EZ9FxkDveVOsmuBftxdASGrbQMlv/z3EExxk+VLHbu
         oBpxOE3WNtRlk4z+ZamqPJlXfdV05Fni7Qy47zuT9q3b35dJNCj0n0semYS7JDG+IAlo
         fUaZ/Ps+16lb7fwpm4RkG9ZUmHhiVLvEQzwv5Hbrn4eh9nNCqqgud+mClCZ7tZ3bk5Tp
         o4Q5xDfvGc5ZSE/IiEF8YC392HcCdFwvKOBN2edBCJricVMmQ2CSLMksJ7yItaC5iftV
         unMMPZTM3IkB4yidd+it3nUnFIq99c/SKsLOlLNaIyFnNe3VMZTm8SN8rctOTI8kQsTC
         RQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761224691; x=1761829491;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=id+wIYbTFy4GJ5sovEHifiUi3WKFfS9SlpVUAwl/jlY=;
        b=nS3ainzzdIvdnSYSq2QYZwBXW0kCUxwXGfn4uzy8rtqKLP6uTjXyN46L9SUKN6cUDG
         /zusiiHV6aVOJ2YlKcbxvoVZsb4sddTD/Ekya/ElFhELuzu/fQB5bp/KnWDBgmpcFn9J
         qkQ5sLUCstkKwdQkko6oUVdF3rJHvhDIzV2Cz8f337mb3in7s3L4oLptjjBMVdhD9BLP
         fPPKCZFRBlGm6yUec6i8Ep8JKhK9EkyQbH/Ra7EFUKWWglL/WasvKJI62vly6M8yyW43
         2ZdlLKMCXBgf9tJz2sywCqmW+71LrI/kFqVBFfLYXaSSDbL8eKvwdMZKHb3xsPBXd7m+
         OXtw==
X-Gm-Message-State: AOJu0YzCab7uREE7zXDkbKrBzlGr9svij1Bjp5vp+QIKsYSkBp8PwUwu
	NQr2zMztzaVSjk1r40RWa4nITYb74mvXw1WYQiKnZhyDx2TJv0OamilV
X-Gm-Gg: ASbGncvEvSXaUr+1rff6GfVWKhp6gXs0PkPJirjWz74ZChp1fhOD2zblDpZS2tpLbaf
	njm+i7NdpBKyTjtnOFucg54oeTCLf9Q3uu2k5LTeD0IYyj3xQRWPKvNEJrftDft30991XC22fHx
	pUJarDDnZ7B6/hcuuo15oJHW2wp8IgL29hL26rZwinU6ajnQMEqA7gi5lPJU6agnlg8nVLmrKMr
	qDJLvIfdjeRs/QTFLD82CwN0WImt1uNCWeGMoI4Hcw8ad5AulS61cLEoD6YT0XZH24zqRzdK8AE
	c9VPrQoHNBXwZ9uk6IXlfVb5ANOWs3H/FFd8KIiMQJqvUGtFPm2iMWV62jwKSpdPTjJvyKu6/0t
	b/ab4Vx+1TMHLR/sTt5Ow3Z/lg49hRl8Xk/t7VfM6pkAMxKrw7dA+DGQ7u7OVs62PDM/+cx9agY
	tLTXLlOAgR
X-Google-Smtp-Source: AGHT+IEcdM7hV7nizE7lspbXruEQ0gaeKJxvv0wIeUknnaa/wTQkABYZuABFdsJHbIclfJ2CGnpjFQ==
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr30485012b3a.14.1761224674688;
        Thu, 23 Oct 2025 06:04:34 -0700 (PDT)
Received: from [10.248.7.103] ([2409:40f4:2040:16ed:f15f:ed0a:f0b7:34d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b291sm2509346b3a.42.2025.10.23.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:04:34 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
Date: Thu, 23 Oct 2025 18:34:13 +0530
Subject: [PATCH] wifi: mt76: mt7996: remove redundant NULL check in
 mt7996_msdu_page_get_from_cache()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mt7996_mac_c-v1-1-580a3cbb2678@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMwn+mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMj3dwSc0tLs/jcxOT4ZN1UQwMLS5Mki6SkJBMloJaCotS0zAqwcdG
 xtbUA48HPY14AAAA=
X-Change-ID: 20251022-mt7996_mac_c-e10894b8bbb4
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rex Lu <rex.lu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 david.hunter.linux@gmail.com, khalid@kernel.org, skhan@linuxfoundation.org, 
 linux-kernel-mentees@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Rakuram Eswaran <rakuram.e96@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761224666; l=1686;
 i=rakuram.e96@gmail.com; s=20251022; h=from:subject:message-id;
 bh=MZntrYzYxpIKR4lTEuQ8vg90cnWJfjxVo3eqGMp0mdI=;
 b=jgYbQsrBeTw7tVtVJy36z0p2uDhIq4lvHZ86UI3xTp4Zr4APqXvIxFrHqF4MZMKViKRawY9Ky
 POX/j+CfAclAH0ZtDNhHsqHPK1379DlAhezZtod7if6PDUPry4Wh5CG
X-Developer-Key: i=rakuram.e96@gmail.com; a=ed25519;
 pk=swrXGNLB3jH+d6pqdVOCwq0slsYH5rn9IkMak1fIfgA=

Smatch reported a warning that the NULL check on `p` in
`mt7996_msdu_page_get_from_cache()` is redundant:

  drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1651
  mt7996_msdu_page_get_from_cache() warn: can 'p' even be NULL?

The function first checks `list_empty(&dev->wed_rro.page_cache)` before
calling `list_first_entry()`. When the list is not empty,
`list_first_entry()` always returns a valid pointer and can never be NULL.

Hence, the `if (p)` condition is unnecessary. Removing it cleans up the
code.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510100155.MS0IXhzm-lkp@intel.com/
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9501def3e0e3e20132fdbcfe0b1f489694afdc5f..284f2eea71e5bf0a34c7fe84084d998164a31a05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1681,8 +1681,7 @@ mt7996_msdu_page_get_from_cache(struct mt7996_dev *dev)
 	if (!list_empty(&dev->wed_rro.page_cache)) {
 		p = list_first_entry(&dev->wed_rro.page_cache,
 				     struct mt7996_msdu_page, list);
-		if (p)
-			list_del(&p->list);
+		list_del(&p->list);
 	}
 
 	spin_unlock(&dev->wed_rro.lock);

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251022-mt7996_mac_c-e10894b8bbb4

Best regards,
-- 
Rakuram Eswaran <rakuram.e96@gmail.com>


