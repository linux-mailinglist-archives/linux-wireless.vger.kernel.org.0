Return-Path: <linux-wireless+bounces-10342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA2934896
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 09:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552FB1C210A5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 07:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97834C62E;
	Thu, 18 Jul 2024 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iO3tKWQt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D58488
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286417; cv=none; b=tRVfDvYPonrtqeo+1DyQHklrSalkItJaTpJseCOokadMCtpr/aJW1S1bpRDfPgnN5noeqc+X0Q1qPGz2bMi92RTZpeg+2KMGTmtVnX3AZD1ydL+tJM+npXra9Q3fZ91nW/lQcwiCXwB3jBKwodg5AXt1nSF2F5a9DN+jcPg38/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286417; c=relaxed/simple;
	bh=ElpgI61lBOzqqNenhwq/2hPZggEfvlZtdEvv7TVBlOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1Uv3xdQ3dVfUQ0oxeeEWEZX+l29jVrO2KmZjEmgepIFYwwGQWY70yhZuK+tq3IR25j6jqA3L/kqYGzgIprDFE064WQscnBFu3h0skGTKsbxMxEmzGBzn40uDep+4mMN0eYGXxJrJKGINR5F1/xNIzfLy3PMs27RY8GQvFaY+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iO3tKWQt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I76q0uA3097209, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721286412; bh=ElpgI61lBOzqqNenhwq/2hPZggEfvlZtdEvv7TVBlOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=iO3tKWQthX0Y9RpGUIW3xDICyVh9lhzkEv/eYnrrOjdVP0rr53P/CXlgMjIy3AFmX
	 q7sBPu2YF44ln8Q22FVdX8hkeHyN7dwhMA2nUhvAXzh/zcU4S1dVfvKeIlXVeIyaHH
	 nYpl27HmrI6G3YScKtYigbP4Rgg+Nh/hPD6PWg5qROPYtFwkPqLqpnt/NWugUm76H0
	 v1m0d9cVOKtkW0MUENXCByHdt52oUnswQZbWyixcoo/mi0VxD0Wln7oliNShUUA0q4
	 2DfEhk97SObjiPkJG9lq/ZvtNui7dJGbwEijsOxvUVYZAgoyHe5fKx5AHdAg8gDSlw
	 +qfaemDPYUxcA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I76q0uA3097209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 15:06:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:06:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jul
 2024 15:06:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/2] wifi: rtw88: select WANT_DEV_COREDUMP
Date: Thu, 18 Jul 2024 15:06:15 +0800
Message-ID: <20240718070616.42217-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We have invoked device coredump when fw crash.
Should select WANT_DEV_COREDUMP by ourselves.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 22838ede03cd..02b0d698413b 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -12,6 +12,7 @@ if RTW88
 
 config RTW88_CORE
 	tristate
+	select WANT_DEV_COREDUMP
 
 config RTW88_PCI
 	tristate
-- 
2.25.1


