Return-Path: <linux-wireless+bounces-7447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B38C22B3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7ED284743
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0077F16D31E;
	Fri, 10 May 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OUZSqGm1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31E150992;
	Fri, 10 May 2024 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339114; cv=none; b=jYutWZKMr1o9U5W72EO97rCArGWGW88eKNPwDpgcA8FJrgswlPQ/mI+OBT0WHN1hLUGmvvrvdcM6pMqTmEDX9aBtILU5R3EbU/GPlqJC4D6EXzEdfmFU1TcXdjwxe+EFyPPRfmS/1AtOCcT4Xkb2EsqpjJ61aFsRWBYEfZxSdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339114; c=relaxed/simple;
	bh=tydwP5A3OPrgNyBAKfKX/KIV43KM+TOnhyDYU5r2RY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NWtJU/0nyB9MJGmOQOIE3Edyi+xEttY0FvH12e3kwzRlRD9AVjwvRxk99JQzDEUB+BCCa6mpgRRdA5MNTJngm6HEVHKX6gK7WuUVGoI9qqgKzwboQlIlP0Q8BwLti8KIN3bXIl58UXvM1hwPSAzaisfLAuDqKrprqZ3mWAM+ezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OUZSqGm1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2CF7B1FE20;
	Fri, 10 May 2024 13:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1715339102;
	bh=n+vro3UQ/j2LdI39fnWzlmxREsNKNpHEcj7IkmRy0HE=; h=From:To:Subject;
	b=OUZSqGm1rDswBuxd9yZuLD302EQO6bkAO6NinsrDgIB+xrBCHmi+N/xq6FtbCJmU0
	 VHMIySZQKQ0LjWRrsqL1rO20m/cu6cVRFzTYZJ2rCQUP/c+J7F43ZR4CGxpMKQNs5f
	 PJThnA2ywtyi7HCnjUpGXAt4FcvlQt2588X5jIGrus+8L+Q8iDP+D+u3IEixT3ti3p
	 YZ3+TqiZQGlzo/uOfKJsxRjbxdDTeRi+2mlmrKIzL9GaxJOJW0Mvf9hRKMgaXj9zYN
	 t4qCAjedETI2sfpVAewmxl4eeu10TOEhxlpumTGacNxu4qVbbWO0t+YNxQ5o69qYV9
	 vpPoP6bWVkR/A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>
Cc: Rafael Beims <rafael.beims@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] wifi: mwifiex: Fix interface type change
Date: Fri, 10 May 2024 13:04:58 +0200
Message-Id: <20240510110458.15475-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafael Beims <rafael.beims@toradex.com>

When changing the interface type we also need to update the bss_num, the
driver private data is searched based on a unique (bss_type, bss_num)
tuple, therefore every time bss_type changes, bss_num must also change.

This fixes for example an issue in which, after the mode changed, a
wireless scan on the changed interface would not finish, leading to
repeated -EBUSY messages to userspace when other scan requests were
sent.

Fixes: c606008b7062 ("mwifiex: Properly initialize private structure on interface type changes")
Cc: stable@vger.kernel.org
Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index b909a7665e9c..155eb0fab12a 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -926,6 +926,8 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 		return -EOPNOTSUPP;
 	}
 
+	priv->bss_num = mwifiex_get_unused_bss_num(adapter, priv->bss_type);
+
 	spin_lock_irqsave(&adapter->main_proc_lock, flags);
 	adapter->main_locked = false;
 	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
-- 
2.39.2


