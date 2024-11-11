Return-Path: <linux-wireless+bounces-15183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2B9C3FA7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 14:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ED31F22892
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FCE19D884;
	Mon, 11 Nov 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="O8PY86N9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057D55C29;
	Mon, 11 Nov 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332455; cv=none; b=aObiklIwSLNGa82Uq2OUY0JiCD3K4zcAd1j6XoyNsWQkodve7hbevEwhSPXYVR/9Oxl2Qu1N/cjEqTsr+T8jOip4ReUpMIWjyn5uIVafzuzOmxxGXgIs2ALb+NuPg3cFWpqWNYqKbm1ARe9yiCqNSXfdIKkBB8OqR4h2+AGPMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332455; c=relaxed/simple;
	bh=/lRgHsdUwoCuJ9prqAOMcFVLNmskl71F/Sic+hVnauo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjI3y1sjMTB08bjOIJlC/+nfLSk7JHCMm7kUkMQVXvlBkgQCwmDPZONsihN0CUNZunUzNvMbaF95vhlVRfxK/WIcf3gvWtUejizL/q0s+MdYdRm3W7tDr6/zwejTXH/R4lpsEGPJrZc6jxqOXfhnEdaYo/PmEyBMKOwRGK1vBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=O8PY86N9; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id AUeotDgOMjazzAUeotYuEf; Mon, 11 Nov 2024 14:40:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731332445;
	bh=aySs7bPSbKHWLCsqe0IIm6YT4GwJ1SdufWSYkYaSwbI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=O8PY86N9o1YxVmAvOi+EPQ182u26D9pzzm1S1y6qWETG6+O2hE66wviD3oAwa2Gt6
	 9nIIMvC4ADzLn1TvnNYhVDo//mJuQAavXJjQC6yx1YZjwPgmeVckyMGIMtLCLyVh25
	 3iHLtI2DuUTMNTE5pt4ejl8e/Fwe4XPqrmKXA+agqkg2S+0uIO4dhvkaxH3VwA2X/M
	 RumGr+FGQoTQ6ePSEu5YlXfHNydANZ+b0jeS/GU14Twiu4J8nLBOAruIITf/XiHhxo
	 SDj8578AqRNmy7e4E2VJ4OK5xTwtsHVtDGINf+5TS3aWJI9Q3Z4W7h+nr9KyDCuuq7
	 bbGJtXZuY83ig==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Nov 2024 14:40:45 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kalle Valo <kvalo@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] wlcore: testmode: Constify strutc nla_policy
Date: Mon, 11 Nov 2024 14:40:35 +0100
Message-ID: <78810e3ebb74ddbd3a4538f182bf1143b89baba7.1731332414.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct nla_policy' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   5062	    528	      0	   5590	   15d6	drivers/net/wireless/ti/wlcore/testmode.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   5178	    404	      0	   5582	   15ce	drivers/net/wireless/ti/wlcore/testmode.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/wireless/ti/wlcore/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/testmode.c b/drivers/net/wireless/ti/wlcore/testmode.c
index 3f338b8096c7..fc8ea58bc165 100644
--- a/drivers/net/wireless/ti/wlcore/testmode.c
+++ b/drivers/net/wireless/ti/wlcore/testmode.c
@@ -45,7 +45,7 @@ enum wl1271_tm_attrs {
 };
 #define WL1271_TM_ATTR_MAX (__WL1271_TM_ATTR_AFTER_LAST - 1)
 
-static struct nla_policy wl1271_tm_policy[WL1271_TM_ATTR_MAX + 1] = {
+static const struct nla_policy wl1271_tm_policy[WL1271_TM_ATTR_MAX + 1] = {
 	[WL1271_TM_ATTR_CMD_ID] =	{ .type = NLA_U32 },
 	[WL1271_TM_ATTR_ANSWER] =	{ .type = NLA_U8 },
 	[WL1271_TM_ATTR_DATA] =		{ .type = NLA_BINARY,
-- 
2.47.0


