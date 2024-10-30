Return-Path: <linux-wireless+bounces-14740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA729B6B18
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 18:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A5FB214E9
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752C91BD9E2;
	Wed, 30 Oct 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaikVopJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E071F1300;
	Wed, 30 Oct 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309695; cv=none; b=B2RhEMg7R++zhw+NAkaTJubc/ko5BI+JW38/m9klhK9UPNX0PXtzS2crEbjeWCyJm0fa4xIvHS7WJdcZqmXpOU6QlLUWNbqqV1iZayicYYKhe8NaCIoGlYWA/6o9AmX9CIMXECAqWSH7zXuYE+beorOt7VkLELWKDujiSYKkyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309695; c=relaxed/simple;
	bh=U+3Wgt1if/u0aXBUytY2a+1FtlEk1JoYz05UyPfz/Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PlcBGlzrWqBwhTdooMg9i1XxveOlkWKL90JZNhD1EHDKSQ9YYKpQKj3QF6tdXjdJHyScRz+2tCvPFL+U73pgTyMZ3K7kKfa05voowJDDOy8EQR6kDPkbtUrs+CT+lq723y/ETbqJ6/ZJVVTJGI2wv7EA5tfL+gWrvP5PHEIjMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaikVopJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso86334e87.2;
        Wed, 30 Oct 2024 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730309691; x=1730914491; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Juisjn4hdg5t7CbimbozNWZ7Zs4lqTjFGMYg1J1CssY=;
        b=BaikVopJtkJOVl0d3aBsXHNGSprqfJ+wva8BwBmglyV4P39kcuTqjxoM74g9iQv8vZ
         pPeXX6P8t+1UYenGDKK0WL2TKKU9O8YhSRDi5y6Xw3mfi6SjLujBrovmQAJT/5PtFijA
         I1bVeYMCgF/v+y8Nz7QRx1csOzit0kB0fSxwm8nTpAYZQmQvQWk5NuUV1xKy7cdzwTS8
         yS8WvDoBxxKXWA0gLVlaGuN+nJKMQVBfpBp+Pue5Lgh390Zvdlwgnw0IDW5WRLaXL/jZ
         YU5k37XpeHESy9jAHYf9z0Bs8/fPPKc9M+Xc76PD8gaZH57/7Jz11ouavolYkQB6qx5V
         gNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309691; x=1730914491;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Juisjn4hdg5t7CbimbozNWZ7Zs4lqTjFGMYg1J1CssY=;
        b=cLvHHdQVWJAw2sHz4T/YM+P94XFKCBYUJxlCuUzubXNuG7CwNK+Dl8Ey7hVmCJL/fP
         9HPB7ZCmpZQ0d971XHR2FgSQyHxZsL2dUPZDwDxJ981mMVTe3LJEUI3XtUz8HFwmM55h
         OaNg8llBR19rAGtZRMJzbM/T8QmkbL4QHRWzPsN+B027V3CQqZNFw2thTg+3Sd1+Bxlt
         7nL9//BYJGzz041AHdJ+rglsvVDJR6KgN1zQjwiv9J0G5R97WcL4+u761yjUJevM3d1k
         wRZ8q7sg8ROB7nCugdPDPxUDpqzhnIL4tZKxoIOfWWD7wPggPH1YFJoT8D3tUtqxNYcA
         NXQA==
X-Forwarded-Encrypted: i=1; AJvYcCUsYMx1sUmVXJ7XcATZcAt1O20g93BTDQIzX9KU28Q7th81oj/EqAQYd2DFzchvzCWzxxYtn6gn@vger.kernel.org, AJvYcCWkZFcoGW15T2o21dW+5qTrL7A6mPGQ67G8pUYVDmQfV7T1NMgEKfKQm0l6DSWop3TMm9RauLmi6ygDDLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1b9x5cz9UWnX+80S6c/rdmZnI7is96BSWSNsuK8fQhCRvn8OL
	bgiV1OWL4Twd+nlmgsYVi5s3aDTQ1evEzNOwB/s7cOtvornYLUPS
X-Google-Smtp-Source: AGHT+IGZkiA4a/Ypkf0OY1ZbPq+XcHKy5We3bZ+vHCVaMRhq7cotMHd1H8WYoRYbeNygdCs1IVPxSA==
X-Received: by 2002:a05:6512:68f:b0:539:dca9:19cc with SMTP id 2adb3069b0e04-53b348c1719mr8674104e87.4.1730309691216;
        Wed, 30 Oct 2024 10:34:51 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fbf3-0656-23c1-5ba1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fbf3:656:23c1:5ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9cab13sm27566765e9.48.2024.10.30.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:34:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 18:34:45 +0100
Subject: [PATCH net] wifi: brcmfmac: release 'root' node in all execution
 paths
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-brcmfmac-of-cleanup-v1-1-0b90eefb4279@gmail.com>
X-B4-Tracking: v=1; b=H4sIADRuImcC/x3MQQqDMBBA0avIrB2YpF3YXkVcxDjTDjSJJCqF4
 N0NLt/i/wqFs3KBd1ch86FFU2wwfQf+6+KHUZdmsGSfhh6Ec/ZBgvOYBP2PXdxXJCLh1zBYswi
 0cs0s+r+vI0TeYDrPC/mzUEJqAAAA
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Kalle Valo <kvalo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Hector Martin <marcan@marcan.st>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730309689; l=1632;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=U+3Wgt1if/u0aXBUytY2a+1FtlEk1JoYz05UyPfz/Y4=;
 b=K24pC7iwnYW7V7S9srCCEP2xQc23aicQ1kjH6fe/uHGFY3ar++CWb5cVFD6U2FL03WZxNUdIv
 8hVzg37hf2iAMROCaETj6izTXZqXmrBSoQZVto/T+sWumcuFgCIQpnS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The fixed patch introduced an additional condition to enter the scope
where the 'root' device_node is released (!settings->board_type,
currently 'err'), which avoid decrementing the refcount with a call to
of_node_put() if that second condition is not satisfied.

Move the call to of_node_put() to the point where 'root' is no longer
required to avoid leaking the resource if err is not zero.

Cc: stable@vger.kernel.org
Fixes: 7682de8b3351 ("wifi: brcmfmac: of: Fetch Apple properties")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Note that a call to of_node_put() on a NULL device_node has no effect,
which simplifies this patch as there is no need to refactor the or
add more conditions.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f65756105..af930e34c21f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -110,9 +110,8 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
-
-		of_node_put(root);
 	}
+	of_node_put(root);
 
 	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 		return;

---
base-commit: c05c62850a8f035a267151dd86ea3daf887e28b8
change-id: 20241030-brcmfmac-of-cleanup-000fe98821df

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


