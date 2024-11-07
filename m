Return-Path: <linux-wireless+bounces-15113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277A9C1023
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 21:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF111F22E31
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75B4218330;
	Thu,  7 Nov 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzZzpCKG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC94217F51;
	Thu,  7 Nov 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013092; cv=none; b=Ronb+g5ilIR2AwPLMMocIQdBfDmgxEhtnhplvyzxjA1rk+9hNrTn2JmSwfbyfglTaNTDotgPs7vF1B+z7o+L4Zi51fko4yDAVyEjsY9Q3MBVsW7JV24vFFsGZ1PiLUczvsTq/95cZKUGPgHlQverQf8fONASn0ZenxoVNLOiunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013092; c=relaxed/simple;
	bh=1r6YZ6EcAekxlM8K6DQ7ifFc85VeXGRJ6sfinw3tLBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0MT0yW4y+ZIye3XOC6YzYZV2peDjL7zB1UKeLmoZc8v5j8i2uUDKSXkFikOIFX/vTzVKI7q/LSRIxaGldgZumS3TU7AZywQy3sQV7K6uDG0diQ1eH3N+2dX3IUndPdJbZUWaQnD6yAv2sKvCdB87KoakoQpCmIMj7V0Lv/9Aco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzZzpCKG; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbf340fccaso12643446d6.1;
        Thu, 07 Nov 2024 12:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731013090; x=1731617890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1uYY6LZISFdl5bLdCORh3WiLBX5TjL7MQUKS8/AqOk=;
        b=ZzZzpCKG17rzvpMNOVLPVfNq35qBhIUi/cY3sf11KHAhnmkbyupYRhbAg0Hr5sgfp3
         YIx79HSrlpgu6L8bk0psVa4/M9TqS6Or3Ke7PjoTVn3Q3RqSYFypUmRPcTz6s7LGmkAo
         i6ThZsmBT8EE8R8rabc3mTt4Dvt/KAYXrLy1qCtEWzsQFK2L0muaZB3EZ4glfCKvcmhN
         qYhXHCrgnPj5LQJaEBGdqR0MvoWQTYKaZu2MsnbhjFtG5epwQWhdKLsRU9Bid02CLYav
         r15hF76BQu12snWQD08UVCSYT5ghr076v1dtEMjXhfD37gQyHHxHbrbT9+ODBgn/FySv
         HXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013090; x=1731617890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1uYY6LZISFdl5bLdCORh3WiLBX5TjL7MQUKS8/AqOk=;
        b=HZpvvZG13eMEVrA7jTvY4uSFhxFCRpg5WcpGbYc9aOBB4NrQBcAHlFi+w52kKcXa7S
         kNhAyhNK/aVCVjbTKeA6OlLkF3JBOU47EWV7/x4sUZGERotZjMeFKaDBZS1ZWsncpIK5
         Cdf++04XcKIBo5lfGEPiSdhWL1DG9W3HwJZRw1Poy7kRdEAOl1wTL9Yg20/pG8AjgJ5q
         hK9h/kCtGqii1Rh8YZSjzTjqgeaHRJ3hSEipf6qVmMqaLH/RcHkHpjnRO6wHvVydTjz/
         tfPLXvQQDFqrqr0WwqoGlDaZdGjhdMib5e4QmEX3t/t8+EKrtObLCkDuselsQHb1xSDR
         qT/g==
X-Forwarded-Encrypted: i=1; AJvYcCWdT4r97j+yA/ZkKZMBgqrwsvXUB1LzkfMqSVJb720xH5Rpc4aUZxVTXAvJlRbEGnQ+1un1mdimrSdGWZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhzaNZZdavvCLqVhpe8prPcQqDzzSgT/fiUDCOvrJoe+YUYcB8
	6Dkl/JSGfJq9/h5IPDQaLwLFBPWXiNhpC7OfWcBIWwP5L+8AC6s8MSgoHoeg
X-Google-Smtp-Source: AGHT+IGop+xxmhQASZ/DFo/b1qZ9Tmwl/texf371HuaO0E4jN0ptYI+BVdN3tYj7CubX9Jqe5nF3Ww==
X-Received: by 2002:a05:6214:3908:b0:6d3:4a7e:7326 with SMTP id 6a1803df08f44-6d39e50800dmr4365456d6.14.1731013090214;
        Thu, 07 Nov 2024 12:58:10 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396632a57sm11326636d6.123.2024.11.07.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 12:58:09 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: johannes@sipsolutions.net,
	linville@tuxdriver.com,
	rklein@nvidia.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] net: rfkill: gpio: Add check for clk_enable()
Date: Thu,  7 Nov 2024 16:01:55 -0500
Message-Id: <20241107210155.1383802-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
expection.

Fixes: 7176ba23f8b5 ("net: rfkill: add generic gpio rfkill driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 net/rfkill/rfkill-gpio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index c268c2b011f4..a87bb99231a6 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -31,9 +31,13 @@ struct rfkill_gpio_data {
 static int rfkill_gpio_set_power(void *data, bool blocked)
 {
 	struct rfkill_gpio_data *rfkill = data;
+	int ret;
 
-	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
-		clk_enable(rfkill->clk);
+	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
+		ret = clk_enable(rfkill->clk);
+		if (!ret)
+			return ret;
+	}
 
 	gpiod_set_value_cansleep(rfkill->shutdown_gpio, !blocked);
 	gpiod_set_value_cansleep(rfkill->reset_gpio, !blocked);
-- 
2.34.1


