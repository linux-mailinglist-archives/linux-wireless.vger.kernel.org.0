Return-Path: <linux-wireless+bounces-24047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA7AD6BAB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC451898F7E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E5222593;
	Thu, 12 Jun 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVbGupnt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F241CDA3F;
	Thu, 12 Jun 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719267; cv=none; b=K2CV36aQ/dc3CWGPWBMmhT/z8Ab7uaK6T8gIR+Ua/x4rCqVVhWRcbd006ciOfeNFlJefH9qx7V5zQ9FVhUhyXpwIHCyi+m/E+yPHj808uMkr8jSnsYqCJM3n0KKhXK8yz2as48l0T1BF4uinHhCXDVhuPf6fE1qBvDbmWeELDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719267; c=relaxed/simple;
	bh=nPaGWMZ4NG9UTsgXyf6E4c3wv/YhKDdZPZghgszys+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRSUf0sEPYWenIkYiv/QI9e+/EajmqdDw5GtLSkCPRtb7q/NwYsYsUi3qnaNdYIgka0jGq138XOeDBs3kG0ihNKngrO7gOIoWYTmN2F9QCFfIqztwpLBxhiJB3QoP2VRYlaQ+hfRLJEwX4MLkld5fWTUDsiSSMkWDYB3TcKJJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVbGupnt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4530e6f4db4so205065e9.2;
        Thu, 12 Jun 2025 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749719263; x=1750324063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBWkeK6hGx5OvRMWT1USZjz50+Of77xDqL2XQmoejP8=;
        b=kVbGupnt6UEYFqwZUuhNICMrztf8n0YE8PGJM9Mb2WGzCRcxqjhdkEJ5GpoJkCjJ1i
         V31esfRuCRWYVR5IZDzwLvPwnHbJBMtojhq1cyvIt+W2feEYo9IQkGcbUJi7Oq6BnyXa
         tZvr/HEefh/dAV+MROsqAwiWtAnkwhBnnQMGpmMuVcOEP9m42W2/hGbWI/8u5bj6Ydkw
         U15/pRRv4kxB5j3G4pfU190ATgvoFxaFJkNL4kmkMCxSoMijG9PgMarkY3QE70VSq/oJ
         xsuqySaB1NDEJw9HnMf/AQi0jgHlKfJG/fsN/301N9XMNXsBXuGPv/pfqeTyDKjW2SC9
         usMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749719263; x=1750324063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBWkeK6hGx5OvRMWT1USZjz50+Of77xDqL2XQmoejP8=;
        b=h63R6EUydz97lJuBYtkoGOyQLWuSb3I5ehhUGGUms5aoWsRn3R8DDRz4f6B/MUCSi1
         yX+FFhPtD8b/Tdoy6qsdB+cDLxcW1FnS+ABDKFVZNhTehNeKTPjCvXoCFgeVWacpiDry
         jPweSF+z4puDJxM/W5NwgTjCG6OMcGvimfx40q2NP4UYr6ZgXAeoGGzSU8Sn0j5bHZKl
         G9FNAKOapXc4GlIoevlMExANRpRDg0qsRL2wgQVGQKGQeY8OkQ7gjjB0unboBZxudmzp
         osmwiCiAp48wcHS4+VltDCGt+lRLm6FONeDxUpUU8VXlLUoxmRB3VVmjSl2ZkXAp86G5
         ebaA==
X-Forwarded-Encrypted: i=1; AJvYcCVC5BD5gKLqUGq/7MgQqg75eLqH7oIx9P+QUOlUeAtwPuqERmlBFrN3s9UQnxyEESOgXANBdOf7ZpRuPt4=@vger.kernel.org, AJvYcCVuQsmKZZTkzCvnNqc7rAc5G6CTGxnrjyl3qPbWubr55mqI93Ag3ZlquZoeu/4u9GQJkFftkASSZ8+N+UHI1gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/knC3scRBlgoW2cZJaRWNjrpU2OKq1Ktgi4s5Mk3eo3zpC8O
	Op4hi7u2ORdTwroPsiSQroRkZzC0Ofx9Yz3BWXNJuCkP/6A52exjgIjl
X-Gm-Gg: ASbGncsMr2xTKecIzoqJt4BfENYVmgw0xo3fjgjW1TT1TcJtAKLgHT1O/RGaYTA8YSg
	CQOBcoF45bgt/bRapWEDa0hmjumEFQ8MHxqEBNLtPQVeWNCkJjP7IetFGnY4bfkkTzVpPdsKnYZ
	GN4R9Sj9toXDTXQz1sLKAh5+agtirT0jkYkAVjyyBu99g+NEVvTqx3bHTJvHVyFgqqS4XoSyXHi
	qIU+BShLTD13AwsImIA7dOebqrNxrLR4gCpoPrHKQrVQHjni3bu19QxTzywPInxwlVJHEuzpP2Z
	5XRUSXm8RO6BeCuZgzEDlGn/NGuoK3AEJfZaAxYxrHWUs0v2025pS9BNVdflvlCvkRk9yptATTs
	DZyeNMM8jjC3J0H8=
X-Google-Smtp-Source: AGHT+IGHbfxT2141g/HEDN48PqEbgPnWCfTrql/YAEm6ytjb6sLkgf9FfpPfKwqSms0MnVYa/zy/Dg==
X-Received: by 2002:a05:600c:4e0d:b0:439:9fde:da76 with SMTP id 5b1f17b1804b1-453253b0905mr21982685e9.0.1749719262297;
        Thu, 12 Jun 2025 02:07:42 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:b893:ade0:c175:b695])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532e2522b1sm13756895e9.25.2025.06.12.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 02:07:41 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drive/realtek/rtlwifi: fix possible memory leak
Date: Thu, 12 Jun 2025 11:07:19 +0200
Message-ID: <20250612090724.17777-1-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `dma_mapping_error()` is true, if a new `skb` has been allocated,
then it must be de-allocated.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 898f597f70a9..f754f1c3f783 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -572,8 +572,11 @@ static int _rtl_pci_init_one_rxdesc(struct ieee80211_hw *hw,
 		dma_map_single(&rtlpci->pdev->dev, skb_tail_pointer(skb),
 			       rtlpci->rxbuffersize, DMA_FROM_DEVICE);
 	bufferaddress = *((dma_addr_t *)skb->cb);
-	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress))
+	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress)) {
+		if (!new_skb)
+			kfree_skb(skb)
 		return 0;
+	}
 	rtlpci->rx_ring[rxring_idx].rx_buf[desc_idx] = skb;
 	if (rtlpriv->use_new_trx_flow) {
 		/* skb->cb may be 64 bit address */
-- 
2.43.0


