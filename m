Return-Path: <linux-wireless+bounces-25222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EAFB00CBC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20BA95A675E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF520326222;
	Thu, 10 Jul 2025 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4sa183U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D582FC3B3;
	Thu, 10 Jul 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178105; cv=none; b=tis3sNAfrJ2fYFWabC/KWnGfCICXIE0DwKS44qFzmlFp9KyHCuwAe+KR0iTPxw5Tug4PBEdjF+kNqeuIQYuLe8ncShjyx39/7AWjAEqfJnJLGbyY/CmSiecbFCVHGSPMD4TdvXbp0YCuesqO5CaBhMCwpM+tMVo6es8yiZeSHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178105; c=relaxed/simple;
	bh=YCkNNYbUlQ1yp4wyqrMiVxx4dJja+wuo0vcVuYc41DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLaRIkOdX8HKvjvyy9ycwYX0WRry612Jjir0asZkFhHWKYHLkj4lVVkSIGCV3YMuYyoyxiIQMSzJCq58VbpK+VPJff3PbEYrKWQ1WWinZOdx+3YofScdB04/ayecuLm09dPg0zEiXIUEd/pu2iWnyyezmj9ifGds8p+5lqFblLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4sa183U; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7490cb9a892so919744b3a.0;
        Thu, 10 Jul 2025 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178103; x=1752782903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scg75GovixsEvdVxNi0J1MYQaQj+4lzopjkTkcLZ+rU=;
        b=G4sa183UsDl3CWP1D6//RF/3zgovnFWaFF4offnhfQT40GAJlA3oRz+p5gjgGYl05r
         Q+X3wprWUbSPvIVLpndxMvvvbkowMkklv24ZUm6FDB0anX9p4qztrut5vMu4SB9nLHNr
         l8yZCGCCweg3RTNBnfN3e8bvZ4oBUeKAc7ns+3sw/GxdTImNKn/l8xf5qOoYSbVJMFVn
         VWNO+p7HIaK29cMygTBJBLqBk+SpciXIRS3ZHVG5ZEg+QZDUK329BYFkX3VSTPm7dtO5
         vU+zYS/XENsge6Tb1lFkepi+x4+EvPr5Ay0DG7n1z5ZapHf5cMfw68UUPBq02JDqEs3X
         WZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178103; x=1752782903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scg75GovixsEvdVxNi0J1MYQaQj+4lzopjkTkcLZ+rU=;
        b=ERZUaUhcAjCMJJIT0g+/YHV7+qVTpeXo6K6W7GN72aeJxXRisAIolyuKYbU0dEsIfr
         hGdae0ZRwJTTGn84Pxg9wcMNsuUX50MH/Yz9vPYJseTD5/61Y1x8H9FAKGARrvLVvmvW
         rQgjFV2Sd77AkD5fBjOPkBN+slnE0rt4VRdfBqtw/noDaQX4wRZWsumimh8sCCk6Hqln
         XfIQgTGxXXbox2PuFTAT7UnVo7h0aZT6aRu7jH5/w96Tpde+DMouUu7vLjumtXA/qSVO
         jzt0CDrb6HNs7PcD5rNz5J9FqzLlcxnySWvn/ez+UnxOQnpPH9KBXc6FluzNjRbbCv6g
         CKgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+DVJHcY3D3bw+6W1PYVKjsxOtE4jfYRpsqI/3XXLWraNX4oYSpX23oV6/jUiRg3FfgQFA6Zpbh49d@vger.kernel.org, AJvYcCWOwd61NzZGfJ0UZoO0iXskiMGd1zc1vwaq/h/wRjWDxxq270CzP8rlVNl51h8mzymwB7VM1W2LLv4yMz4B@vger.kernel.org, AJvYcCX8iEiALq22SVR7f6BE8gffMV62RzQHP8EFmbulhn3mybLv4FcPnzAAkAki/TTwPOmyt/JPKYlKLGwD5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI1vK4zkKTjk/P9IwULmEnsxhuVL0xXu2b54tU3XMKtI7CAg5l
	45vggSerfJxzNRnrcCs/dSZvcb2Ihljn6SbIW4HEzIuUgnFh6Kf+/4gKATURikC8
X-Gm-Gg: ASbGncvJhksFVt2LFuRrfR2at80JW7LiWNuSM7r7oCUs+R1h2J6Sh+d3KDAtRFVurko
	xBIgIVY+xgjDO8PH8nSAytqRrBPa7nt6DX0Ml8eaCIll2PVrOpE1jJTKZX3SuPmpwQ/Cwot6A68
	6XzA+SBVB6yGKAht+8eckuQ7cJCBSrj/yiO0//Dx5Q6i1Syj/A/pXJu2oosq7t7gnEOCVtuB+B3
	HaMzlHyGeOFveyZ3zuU5V+MA7wg2BcR1xOf74FDji+7zGP5lQUEGOkMAtyVDx/ht9HHvrmHSnh/
	6XTixQg0nCPvWvd5Dz2OvzNtDzbAVpwXa8LpznOZy+Q=
X-Google-Smtp-Source: AGHT+IGk+CvEH9fmt2OXqR3GTJo5v/lWWaa+7STAsMYtu2xeDU7xQb1KOYuq7AJg1ahGYkxKyQGvwA==
X-Received: by 2002:a05:6a00:807:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-74ee323a063mr442065b3a.19.1752178103355;
        Thu, 10 Jul 2025 13:08:23 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv3 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
Date: Thu, 10 Jul 2025 13:08:14 -0700
Message-ID: <20250710200820.262295-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710200820.262295-1-rosenp@gmail.com>
References: <20250710200820.262295-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this driver is for a specific arch, there is nothing preventing it
from being compiled on other platforms.

Allows the various bots to test compilation and complain if a patch is
bad.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index d1fd66d44a7e..3a32ceead54f 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -202,7 +202,7 @@ endif
 
 config RT2800SOC
 	tristate "Ralink WiSoC support"
-	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620
+	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
 	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
-- 
2.50.0


