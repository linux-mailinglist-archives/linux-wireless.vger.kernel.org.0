Return-Path: <linux-wireless+bounces-21693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D21A92ECD
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FEE16D606
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B86250EC;
	Fri, 18 Apr 2025 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHn9yOO7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86480442C
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936129; cv=none; b=H+bk9vLShuzO2cAgu+OmO6PjvY3hkuZx8Bn8r1tMHU9KkrmFcHftHVPSMxfUd7UvpC0jOu9cLngwYAzbg5BFG9ClhWFRJk0dRtsEZD++jN+zTgOdVjs5RZ4yo3fJeOAeeuWxF01TPhJ3JorTo45p9NMY+0ZMEK1q4KxFQsGxARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936129; c=relaxed/simple;
	bh=Q+mPfuZuFJwVP2Il0e1qqhbj1+ZmP/dlM0ZIAB2YRhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbZ0Jj4RA/pWVkUUzKC71IZt1SYf5GY36dmFl7a+y+Dft5DBfFDD7GCQsnD7/KAO9wUoIx1FycHb1KAey8DQ5OKDRj9C9uxbccyyQO4Xy/W9k+PJni7nDJ+NhLxMpXXX17dZMnYug2LIF/nOBC8JLKZ91J3kdxZ/4Qezd7XsJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHn9yOO7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f620c5f7b9so1034909a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 17:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744936125; x=1745540925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPXhzsua/hTFXDoNNRFJr+3lA273TIAGX+Yu/DOMuu0=;
        b=HHn9yOO7ydXOJh92CQBNT4mFTbkap7K+RPDqNdaggNCvd8/6cvUUqKTzcDGCXFfuKy
         HcXkitQIrDPdxZHNrl2T/j5X5fVG3YdZmXVTT/RGBipKx+g4OLuruowiItnT3uQhnXCj
         1ENuPlgYt467U96pCN9MPm8wXYhrZQ53Pi0kfxp0Re6SHFqmLXKxxuSnYJ7gUrJW77ak
         bmP8075Vz7Z3bDxi/wVD+P2grlqmbliWMmWMdvM+EWYDu9phsVW9KQ/yK2Nh3tYEvPI9
         9nb9EhamkxOkd78AMKeWcO9kWhD05hxiTfUAadz1J1pkBBobptwPKT7DTmOF2+cNzK//
         oebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744936126; x=1745540926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPXhzsua/hTFXDoNNRFJr+3lA273TIAGX+Yu/DOMuu0=;
        b=L3bK4ARoKgrgE9KrkNmbCXL+ew002DrpBl8FOeX8pGsrn4sZcwPGV8TxEZCnM8NwQm
         v1eRU6k0lxkfYk2OPARmKaAvMtLip/gr//ylR3BvGnJXeLqsnxQs7eTcE1F1/RsWN/zD
         P+8tX2BxSgyPYnW3I9CJJQk8Jsa+c1SbTv1X7LUQLS6CAwDMC2DTOBxeYz/X+gDBSlQ5
         z2glqDghi36aDKXG1mE2iuAnRGHW4WNBAnjKbmd/IOmNr3GoGmlSy/wrCqMDSd5A05Ro
         VRiIOqcrcXW5f2Z2TlZevcQl4+xIh2CkbcEXvQKN5dRM0quqFE8Idh7MepAarokI6/mH
         6EAQ==
X-Gm-Message-State: AOJu0Ywd1/9ue8iDXIHqYJhcB+EsH1UxD0Vg0TlesHL2mGEzPq4yrKP1
	1ACxaj9IFxk00EMyK4TBSqCoQOzCRgLCJkdNF27StnrOwoeInfZVOqvY/2at
X-Gm-Gg: ASbGncuHIp6C26sGfUmaIvkizpNi0TJ7+mVjpeFODyNgUkypi8u3+bdVBOUNn9yhXVs
	x2QXD5j4MPwePpmQio9TRn6DYOn8XIiTm3LKpxp0BE4k45aWkLLNfjJ1rFXiEQuBojmel5PlKU7
	VC1U96kdnqSNzxsAdOoruNQ5yOzD3cYdYHYWrzOMpAY8ekxb/hDCXax8g1IKWg6DBoEUqI5UP05
	4bcomQk1vI+HPN1QO1pL9jAJy23QnUPjZq14oGgYjHy1HyOuBOn9Yys/kJM+S47gHbrSTxsRVH/
	4c50VUl/xOwYXBg/8/f3Uk7WkduhMB14FTMed2y9rimvF4DDtNZSfqGJT6aQjOEtZxCGpKlXXji
	Dux8dvGALHw==
X-Google-Smtp-Source: AGHT+IFN48qt23nFo4QquFGgsTID019bHU9vPaAubiVFw2OmQQjZY3dN3MziivyZM8PY7q1ROCjr2w==
X-Received: by 2002:a05:6402:26d2:b0:5f6:23b1:ab43 with SMTP id 4fb4d7f45d1cf-5f627c1e07fmr639582a12.0.1744936125368;
        Thu, 17 Apr 2025 17:28:45 -0700 (PDT)
Received: from systol.god.lan (157-21-254-92.ftth.glasoperator.nl. [92.254.21.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f62583d83bsm395893a12.52.2025.04.17.17.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 17:28:44 -0700 (PDT)
From: Henk Vergonet <henk.vergonet@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Henk Vergonet <Henk.Vergonet@gmail.com>
Subject: [PATCH 1/2] mt76: mt76x2: Add support for LiteOn: WN4516R, WN4519R
Date: Fri, 18 Apr 2025 02:28:26 +0200
Message-ID: <20250418002827.26806-1-henk.vergonet@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henk Vergonet <Henk.Vergonet@gmail.com>

Ads support for:
LiteOn WN4516R
LiteOn WN4519R
Both use nonstandard USB connectors.

Chipset: MT7600U
ASIC revision: 76320044
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index 84ef80ab4afb..96cecc576a98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -17,6 +17,8 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x057c, 0x8503) },	/* Avm FRITZ!WLAN AC860 */
 	{ USB_DEVICE(0x7392, 0xb711) },	/* Edimax EW 7722 UAC */
 	{ USB_DEVICE(0x0e8d, 0x7632) },	/* HC-M7662BU1 */
+	{ USB_DEVICE(0x0471, 0x2126) }, /* LiteOn WN4516R module, nonstandard USB connector */
+	{ USB_DEVICE(0x0471, 0x7600) }, /* LiteOn WN4519R module, nonstandard USB connector */
 	{ USB_DEVICE(0x2c4e, 0x0103) },	/* Mercury UD13 */
 	{ USB_DEVICE(0x0846, 0x9014) },	/* Netgear WNDA3100v3 */
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
-- 
2.45.2


