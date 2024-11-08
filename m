Return-Path: <linux-wireless+bounces-15151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD33D9C25EB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3A61F22552
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58B91AA1D3;
	Fri,  8 Nov 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="gkdWTqQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1E1A9B23
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095719; cv=none; b=Tl7cmSKA5PX5KCFu5DFbfBhe8JMkec1sJ4lJiqKaKL3BYkzbv3bHsuZLUzD9db3H5uGG1JkVgHCYa7pqcGQk/ihjZ0yAc8b1d0Uyg99z82WLPTVPa57GK9BFd9rJ9DS3cWxX8VqzeNZ7pjYBbjif+bg7zXqI2ZeYlPlvJgJTxvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095719; c=relaxed/simple;
	bh=z8JVj+jiJzGhOJpOFyDVu/N/sPfskhY8s+0TKGXnzQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AyIYOEi/cgB/BhgnBqtAUZ/tJZQiBJsTVEgt7y2J8ZauT6H7XgHAVX9gLcPScQwaqLDQUAEYDw1A/m2BVczgbjxPxHbO2ArnF9UpLBcB10hBzDUOsG47hutbUejCeYbUEY/Od+bJK59ADJukMHUu9RdfdZjMarUN+ZaKmWqLb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=gkdWTqQi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315baec69eso22658005e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2024 11:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1731095714; x=1731700514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Nk3wU/ChDDhq/bQy3IPDD8DS/jLcdCvsHP7SN0pW5Y=;
        b=gkdWTqQiFfF/l/pyUIhr2KqVVod9OCSIK6a3I33z90T//ag6/O+nDT0LhsK6V0e0TC
         ZtaHbvKKSQYFrQH1ywvu5X31XgDBnokoN98dyGj8aAtV5tDsoPt34yPcaI+VNuB388XN
         L36q7X+g73njeVEqj1H2MO6lH3hk24sshP7s9jLlEiM3dMCMulKBEJXe3BNAC5AtQQyz
         OO68R+osDKx7HU0zfPpyZFGX9n2U5gSpmbhZ7sTdAE9b3JPqLoZKJsT61bNDfGrUv5P2
         tMrAbhiKvs8QyLrA4Xb1sIgv/m+ThLEnRJeC710dN0JGQUEZpbxLZqYIqbZykT3l/gkc
         je3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731095714; x=1731700514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Nk3wU/ChDDhq/bQy3IPDD8DS/jLcdCvsHP7SN0pW5Y=;
        b=DhfUJJ+cTviCLviSy2i01L/NWlnTalDMK0SDbhFc36WsE2kGaW+th60N9hMDIMByV9
         zDrqn7By10phryRA63cHwKxsVUNg1QGvDBAZikiVparbOZzQknwNVWiQJcxIS4sqf8o6
         7KsQejO7jkmAx6O17I5V0sxc2Q/MAN89uwfPSL2Q8TG53/tijeRpzgpjWB4xzrM6gFKS
         hAeqfIE9mOTMhu7TvT9WsV65/x3PHAu0oLz9H/E6cbP29EfXVZXu4ojIHq9gyPLJbGyt
         BHAiUb3/sV2FNZowAz//B8BHGJs8A1n1BwFLkxGT3/CYfqlbhYvtc3RL80XyBi5CgUBF
         X+lw==
X-Gm-Message-State: AOJu0YzZsxSPTBn1tz8jkJbpzeGonAcAPP0ekIJNsywLRKOYl8zltVY7
	St2CO/P+MWIh3YJ0EVwBFhZshjB8M0+gDof8jIrfKpF47pESQG/Pp42FR62GZcGaHut27BgYa8+
	8
X-Google-Smtp-Source: AGHT+IGxw5jlxsbIOrsZCy+JkyHGBHZ2uK8I6T3m0kaxCaQvX7Ww9ux9bClj7ZQPZUkiBXHiSUXjag==
X-Received: by 2002:a05:600c:4510:b0:431:9397:9ace with SMTP id 5b1f17b1804b1-432b75034a1mr33981285e9.10.1731095713825;
        Fri, 08 Nov 2024 11:55:13 -0800 (PST)
Received: from fraxinus.easyland ([77.109.191.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5871sm81285015e9.37.2024.11.08.11.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 11:55:13 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Reto Schneider <reto.schneider@husqvarnagroup.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Subject: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
Date: Fri,  8 Nov 2024 20:55:11 +0100
Message-ID: <20241108195511.1338147-1-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

This has been tested on the AT91SAM9G25-based GARDENA smart Gateway
which uses an RTL8188CUS (product ID 0x8176).

Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---

Note that I was not able to figure out how many clients the RTL8192CU
and similar can actually handle, 127 is a wild guess.


 drivers/net/wireless/realtek/rtl8xxxu/8192c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index 0abb1b092bc20..72918fe621fa1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -644,6 +644,8 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.supports_ap = 1,
+	.max_macid_num = 128,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
--
2.43.0

