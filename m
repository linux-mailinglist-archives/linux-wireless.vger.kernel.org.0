Return-Path: <linux-wireless+bounces-19709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342EA4C416
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 16:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EC21896A1C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3F21422C;
	Mon,  3 Mar 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPU0XJGi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CE156F5E
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014028; cv=none; b=Vk9JXVO0vKa9F2czN28F3lHNYsxa3qImMLgs18LetljTcMYgjAEJtjpxVDIaX/0Vesnu6pnc4H1EDwZOvbqGTkTQpvrqk/cNhriHPNRPS6IncPzPJGHQR1Nibxy/sCvck16xjqQiXRSLOs+/xVmrRcEPFENeF/HKJ77YoG2iAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014028; c=relaxed/simple;
	bh=YYeGUb3k93KBXD4drA2C9f+vdF4GK7YW6npk41CFHg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b38VZYBRckDT9ItfaxEWwVOyaAP3VQQvIxs/zo980u+gKlv+HGyphwoWMoRzfZAoYuMYFG6Z+FVczDJrd5HVEztgJAULiOZbtI7J9ZtznTxZQapfyi1ve/sPWaE537/Ef1qspVWu1sZi2tBq10VnAF0j1ERfIfCONfIi1RFZc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPU0XJGi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f2f391864so2525418f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 07:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014023; x=1741618823; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CS8fOkB/2o1tqv0C/vSIKz5akXsPp61Y6yRvRf4d3qg=;
        b=KPU0XJGivr7YJE0a0FTD3hXgPa/k7z74xhQRAZrI1qq8tRNDpSh/tu8C+YdJG7ix+l
         L5j82wMWek5f0Sjc0Tzv6CVETw5eqJXDHtnnAcu+edqeBdfuGV7Bbf0iCD5EbRBmGJkq
         ed5TdmXm5BfXYoE897X3Pi3OCx0lQ9M/UmI3vE1VevdVvEPRp2Paeyl/52kkWMM7dpMc
         yRgBQxFCahd7+8bJT89J0DNr2NY4J+0zUvxYs7pMZa0mYLkNf4Bmj9wDUmd37h0Cl4Hf
         vq3w8DDOvnVfEh7l4BOU8dRIKTdgsmGJls+XDi7R2q7JKWjRf4cR1+Qt8IAxMP9h6i5I
         CWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014023; x=1741618823;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CS8fOkB/2o1tqv0C/vSIKz5akXsPp61Y6yRvRf4d3qg=;
        b=kpVtyDLJYBjc06kc5jWAV9c84JyjRsvrIP+UwMmj7XnnU6uAHpnfcIYvokH+uTLWT1
         YUaDWKPCP1sBU8OBp4+9XpRoh7fVKBbbsfXKuXgVd/UPp70YZziDAuw8m1GPneFrTPKT
         w+kVv614TmIXG/xyAPAUIG0S10h5pM5qjEDuw7RQDj9KH6h7GROrr//0vnN3wQg3OEkK
         W7LH/0gG0JiQSbC5Hk2bmmGYmwRCddQJylxI+L30xNHfSvELJn8livSwP3TmTl1STIxH
         usIIx0mbx9dFV1a8A67olXENADw5wKsDpTrtHbfK1IhWm7TrPjeVNFblbp63i9ZVn4o2
         hRqA==
X-Forwarded-Encrypted: i=1; AJvYcCVmJScwLU4uIXxtpqx3J6GCtfkVV3q7NdB05bU/sNwqM1Z0ICGVBxwIoKipIg8uphTlK5aTJICszVPQZKNwWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaCwT0pSxHPgM19RHCmQczP8kf5HQ5FnIML0D7gphGcp6VPny
	B6i726lrHglkFv4rlgohn+ha/HekProIuyiY7iQccSaaJGgtZAc/D5jV7HFxMM8=
X-Gm-Gg: ASbGncvUWKPa2KFuBz+JA+/3HLWQBScaPeadB1GwSKHoSi7TK8gvZEygEtRDap5Sz76
	3g3Xdn/HKG/klF7rRff+h7/21AEALdyKpmP7ITHLuJl2Jy/taUgHlQS+2Ncz6+A7M3YZlbfmLKL
	d6RP3UFHl8T1hu4ImVoCr+EWIcC1TLGCtj1jllKpt6TXA9HzNh390on9W5UWTHEIY5y7PcZdIRt
	0MPCNp6eM7FAaG8KkmTTF4gSH41zOVEZiBvEeTG2kAnJAZaMLXfdlLxNamllNPC4zWo9Zm9GQft
	99UE6di5pGPe5gXCXtqtb2AR1PA+IiKX5j0KVRph8E1sLrHT2xIlxVKYbXrBwjU1yQ==
X-Google-Smtp-Source: AGHT+IGzxcAosUY7UZOkZGBKGsfyOleMjoBQWswmFK4WzjmdOJ8Zb7pyuQRUwLOTwEQbHnLoZZ+osw==
X-Received: by 2002:a05:6000:1a8f:b0:390:ef12:2ee4 with SMTP id ffacd0b85a97d-390ef122f8emr11173836f8f.25.1741014023167;
        Mon, 03 Mar 2025 07:00:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e03asm14985727f8f.95.2025.03.03.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:00:22 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 03 Mar 2025 16:00:20 +0100
Subject: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAPExWcC/x2MWwqAIBAArxL73YKPDOwq0YfYlkugoRJBdPekz
 2GYeaBQZiowdQ9kurhwig1k34EPLu6EvDYGJZQRWmis6WSPrgapDtz4Rp9dCThYssIYP0onocV
 npib/8QyRKizv+wEmJKefbQAAAA==
X-Change-ID: 20250303-topic-ath12k-fix-crash-49e9055c61a1
To: Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Aditya Kumar Singh <quic_adisi@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3032;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YYeGUb3k93KBXD4drA2C9f+vdF4GK7YW6npk41CFHg4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnxcQGiac9YMG/uxNSPYupMemIH+BO2QczD7l4HE93
 pmHw18GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ8XEBgAKCRB33NvayMhJ0Z8gD/
 oCcwjPhgqu+IULIv7xd9PpGqkN/jqJgGafyQmUriQbfj7JnoGNj2DO86DHIKhjb/1vi0+6LC0imcBd
 /EtuQk9MZWgAfqYQYEOCbPVk9UtJnpG5C6osAjU6j73F90p5bF0MZkvU3asA8H6Gps5tNXqpwumVGG
 OV4cXFWX/20HZ4w/T+WZLWh5dJsJ7YFvrigU0x10VtEoz5eIGkS7rcznvKdOARlksoxr/WMQNI9CLc
 gDNltzB1STfhE5y0EnBbfhEs58cHcK1QOrx2IUits+JgXmmRiDmgtplYoMzxz78lDyrMZOpl2aFpfZ
 0TxpPa270xeoyFBppIdyJcoxw9H/T3SuvoPrZbIO2o1XUBmVhUjzapQTiNzHfgkkuc3TKDr3f9vkNq
 wzQIEhMh9+Avtsx7dH/9Ml5zPFRHYJmFe8dZo4XlgNyWvZlO+QbqRyT3yIj+Z9tGONDZX6HpuWNivJ
 +ndvDl/MFsLEcxsyqs4m3eVpyIt3yoNn2mDUNm7qRn2JGuJmqlymvihHGZB4MJ330YYmY/3cgXy/Te
 Z6U4C27bdtZRgyAZvtoKZnvs0rb4fDXK39kq8b2M4YWry/N4+aHTo8UoO/o5+e6rDQVzJfqAeA4iW3
 bDivOa6LJ3bzuntyU+fEf+bDWUWLU+1v+K+lxjQ+mTzfq6uavdLN5BB9r6tQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
the line:
	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
was incorrectly updated to:
	ab->single_chip_mlo_supp = false;
leading to always disabling INTRA_DEVICE_MLO even if the device supports it.

The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
crashes on driver initialization with:
 ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
 ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
 ath12k_pci 0000:01:00.0: ignore reset dev flags 0x200
 ath12k_pci 0000:01:00.0: failed to receive wmi unified ready event: -110
 ath12k_pci 0000:01:00.0: failed to start core: -110
 failed to send QMI message
 ath12k_pci 0000:01:00.0: qmi failed to send mode request, mode: 4, err = -5
 ath12k_pci 0000:01:00.0: qmi failed to send wlan mode off

With ab->single_chip_mlo_supp set to True, firmware loads nominally.

Fixes: 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Bisect log for reference:
The bisect leaded to:
git bisect start 'v6.14-rc4' 'v6.12'
git bisect good 5757b31666277e2b177b406e48878dc48d587a46
git bisect bad d78794d4f4dbeac0a39e15d2fbc8e917741b5b7c
git bisect bad cf33d96f50903214226b379b3f10d1f262dae018
git bisect good 12e070eb6964b341b41677fd260af5a305316a1f
git bisect bad 6917d207b469ee81e6dc7f8ccca29c234a16916d
git bisect good 4fefbc66dfb356145633e571475be2459d73ce16
git bisect bad a6ac667467b642c94928c24ac2eb40d20110983c
git bisect bad b05d30c2b6df7e2172b18bf1baee9b202f9c6b53
git bisect good 56dcbf0b520796e26b2bbe5686bdd305ad924954
git bisect bad d302ac65ac938516487f57ae20f11e9cf6327606
git bisect good 8c2143702d0719a0357600bca0236900781ffc78
git bisect good a5686ae820fa7ab03226a3b0ff529720b7bac599
git bisect bad 6f245ea0ec6c29b90c8fa4fdf6e178c646125d7e
git bisect bad 46d16f7e1d1413ad7ff99c1334d8874623717745
---
 drivers/net/wireless/ath/ath12k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0606116d6b9c491b6ede401b2e1aedfb619339a8..33aba5fceec946fad5a47a11a4d86b7be96e682e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1927,7 +1927,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->dev = dev;
 	ab->hif.bus = bus;
 	ab->qmi.num_radios = U8_MAX;
-	ab->single_chip_mlo_supp = false;
+	ab->single_chip_mlo_supp = true;
 
 	/* Device index used to identify the devices in a group.
 	 *

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


