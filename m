Return-Path: <linux-wireless+bounces-373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A055A802E3C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 10:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EEAB20969
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9F11718;
	Mon,  4 Dec 2023 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNDJvDno"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED814CD
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 01:14:25 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so56170071fa.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 Dec 2023 01:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701681264; x=1702286064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4xxujmofWxEQvFwC/3YQS6TR/Uv0cAMVegQiWNYCdZI=;
        b=iNDJvDnonGZjxbb6dNbfa3hfn+IIYEi492XJjE1QwKtSqmzxuqGfTBVaq2P8OZX39H
         WdcLSFxhc1+Bgbi1vJkEzSfFCKHXHe1s2kKsZIfFuOXoUhJp964CISBEbax2iEUaZK6x
         JUb9x+zY4ozYcrx7Yn8aLlQ0Chh+kDJL/SZww4Kod5WxVwCEiCtOcoI72ND/92yli7g3
         cnO9unaxHzPLq9Gk4fRdLSshOIiZ07Fua5DicVTGyrZAk5S5VnREi9e8XGBEKs+uy+iT
         XdBfQ5Y3LHSUu2ovAKlGr9RQJKNOAysCS+FyAEOHg4w9UhwpL3Bz6g/bhF52J9x+3+pL
         6h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681264; x=1702286064;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xxujmofWxEQvFwC/3YQS6TR/Uv0cAMVegQiWNYCdZI=;
        b=vfen2UKaUUNVK1XGT89uYCKVAZB+O1xqaf/irA3vz1jwIMo2u3yX9904yX5HCM2Q0T
         XrZ0dhX6odCc0dwv1Bva1gHMigQKdLlAMSGY+geDaYZEkUQaL6I4kabhNdf2x6p/tJQU
         vFviw+q0mBPbr0Ud3srKbxiHMYKJb/TjuJFHFJXuVISACOk/hYf4Iw5MgGYfjrLa35Q8
         WmbJEiO5vIoPHfLKO1T1IEZYdG8tVTi8hKOBSWQYAhfvuaiHfPgZstgTQ5w0i1DD4foS
         C/gQtGP0ie+Y3QPqfVKeT0gI1lnzN1zT2rz7tv2DAcQzniV/DxUvrYMsck04LuT9V8Ix
         Tgog==
X-Gm-Message-State: AOJu0Yw58wukI+Toi/JiqwLb8xQ2S/JzUL8g8pJvRggU4xPg0+GAwPfk
	RaAAPC+IH4r2BgWO/t0DkzSxm9+Mfe5hMjLJ47MWlzvNQSn0cg==
X-Google-Smtp-Source: AGHT+IGb8wOVG08rSpwuYICimqQES/PbT0iSm0SNPPwVZ9fVoNHKk/nAX/WdzDZUsR3+pOSFstPesf6kqVtvqNDxl7I=
X-Received: by 2002:a2e:3814:0:b0:2c9:f71f:c00f with SMTP id
 f20-20020a2e3814000000b002c9f71fc00fmr1115485lja.30.1701681263898; Mon, 04
 Dec 2023 01:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Weng Lin Puah <wlpuah@gmail.com>
Date: Mon, 4 Dec 2023 17:14:12 +0800
Message-ID: <CAD73Kh8_Ks0Fb6EsG6ks0oKKONfwr98uRccV5bbmEb15PLPvow@mail.gmail.com>
Subject: [PATCH] wifi: ath12k: fix wrong definition of ath12k_hw_ring_mask_qcn9274
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ath12k_hw_ring_mask_qcn9274.tx[3] does not match with its counterpart
wbm_ring_num. This will cause the corresponding
ath12k_dp_tx_completion_handler is not entered. Thus, some of the dma
memory is not free and eventually runs out of the dma memory.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1

Signed-off-by: WL Puah <wl_puah@compex.com.sg>

---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c
b/drivers/net/wireless/ath/ath12k/hw.c
index ea3eda1f1948..2b35c8aa6273 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -536,7 +536,7 @@ static const struct ath12k_hw_ring_mask
ath12k_hw_ring_mask_qcn9274 = {
         ATH12K_TX_RING_MASK_0,
         ATH12K_TX_RING_MASK_1,
         ATH12K_TX_RING_MASK_2,
-        ATH12K_TX_RING_MASK_3,
+        ATH12K_TX_RING_MASK_4,
     },
     .rx_mon_dest = {
         0, 0, 0,
-- 
2.34.1

