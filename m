Return-Path: <linux-wireless+bounces-30429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A7ACFCA63
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 09:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7645630024E2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEBE29827E;
	Wed,  7 Jan 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImVVA0wv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287F27FB3E
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775339; cv=none; b=MOFTRxBPx1frmIuv9ld6Bata+Xw0TepE+znP7/KVusieoDgc7dy2QN1umRHlrW9J6++xm6WJYipq8VaKFpluVOgibt+Luaoj8E8V9omu7vaN93Rjqdid51OlwZCIa9Hd9Nf0J5QhtAK0ocyKtaaPqDpm7Vm7iq/VTW8eQwJ3sA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775339; c=relaxed/simple;
	bh=klJtv0skWj5s1KSDKEqNzbwBl5YvfN22u23GjjY4QUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/j/wVJe9+x1cpImATDKeecDEFGI169cI9i5JmSJVsEGF6xtj7KS0GQrHa25CkOe0xichSu4dmzHowlm3Dg4gAsRzvW8j0/TfheXAcAm/aUQB6RjqSd7JzKxAZtwAjgP9/weXdkGliXV40JjY8Ma03oC4ceN3r1I61LQ/FyC2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImVVA0wv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so1353505a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767775338; x=1768380138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kq4DgEEPcGBcWcgZluwbIC/FOn5tUqMqd4zV497dWo8=;
        b=ImVVA0wv+uou42SVoQeFbLPXABQEOeVtCgQNjizvAcI4hObfYoPrpVaKwU2eOSLdjF
         BoYIxJsNjkepoknbfp77FmnOGseqiZF1rpJJ8AB7WcxgaIYu+ZriCb2oDyz8ae0qJYZe
         bVTXbM8dtHIGROi8GLIdSW+gfpI/gj2Uuo8Wq6wPDUxEWUuHvT/1xOD2ObE3j5wZh595
         br/U6TuFnza5k3Uj8mB/uPLg2GjaC5om8vxjez7DnGjDmry+1xoAEPIpKeR6+9uY5wQJ
         m5fKqg/+Q9ewwd0O6rjReIqP8n8hpOl2siSSLlRxIahHi19QT/QLd7wuLxparfMTeOiX
         bjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767775338; x=1768380138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq4DgEEPcGBcWcgZluwbIC/FOn5tUqMqd4zV497dWo8=;
        b=XSX59FRcr6AmGQ24R1KuqpuFciIhqwdJI609+bJkETczQnXGLJ2R44vpniDyjzYH/6
         SKtEvzqyOluYyPBK99wqEMlAGa53lLiNTjJkLuBtr1gEOBXD2RxUdCjzDWCnIBhZ4TEO
         4gUZqGr6yy1Af5glvQlopwEeOQHfuYNoWrMbvwJvl8Z1DwR4SlH7X2iGN2eYXbMeanF8
         of/oiEEsh7e3oM0HARPk9HP+7Aa8D+SqtQnitw5SLcAS88+u1WpLxHfoODJxncyAjNs2
         rNPUWWaTA1v4v8Wynqc8EyfrTkDU7Kz5u1fF+WZjvDkBt9zveARzGV9wHJMAV/RF2phl
         OcDQ==
X-Gm-Message-State: AOJu0Yyuo8zPX1NoSIdGe+zuOKfeVJT4jFqKMK8e+03YZNggWq46H/fx
	msOs08lyEv4pLayDu/aSNwSO5SahT5lul34stw2MhctPk/pTTosiV/+y
X-Gm-Gg: AY/fxX5v+omd1Z5Ml9+kXrCB0yLtDAlSQYxW+BFTv0pJr/swe1iCoDE0D6z/O0RC8+I
	W1KFqIICqrdC9UMl/3dyRAnq1WXP3NRBdHLeJ7kzbUWno/GXeZe6i8VK4Hio0NrYJQLTgc/0cMK
	y4ztLDmjHSMMDoxGb984EUGMqndhFTsVkM1ZEGPs5oAVsUmHxAUacM7dsQhEOSFOFe/SxSo4ZVU
	yX4pLJtYOpC7Bl+rKtJOFziHdEobrAcBgmSt7R3j0vBsd4jcto1uc+gxLROIesNfqA6Oi0fbKRY
	oSke0J9L/UO/nyhx2rB+u0S+DmdBOcoFn5RICXkpirMenuBjnr3SJw/rDLp73p58nsLpSVZTzBU
	bePDa/D0Ij26oKaD6GRnd/qq7AgMbDtMSzN6PiWeMacbbwoCY3F27Gp+/i8EO7Cz/kSyw1QQ=
X-Google-Smtp-Source: AGHT+IHliq9/BKbXKFS8jUH9l0mp8MZOWjAiCglIwf0kezPhz5HU7s7XfPwPafxi8/Ixh313yiC2fQ==
X-Received: by 2002:a17:90b:3149:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-34f68c0228amr1591307a91.19.1767775337710;
        Wed, 07 Jan 2026 00:42:17 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8afba8sm4323876a91.13.2026.01.07.00.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:42:17 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH v2] wifi: iwlegacy: 3945-rs: fix possible null-pointer dereferences in il3945_rs_get_rate() 
Date: Wed,  7 Jan 2026 16:41:49 +0800
Message-ID: <20260107084149.173289-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this function, il_sta is assigned to rs_sta, and rs_sta is dereferenced
at several points. If il_sta is NULL, this can lead to null-pointer
dereferences. To fix this issue, add an early check for il_sta and return
if it is NULL, consistent with the handling in il3945_rs_tx_status().

Besides, if the STA il data is uninitialized, return early instead of
setting il_sta to NULL, consistent with the handling in
il3945_rs_tx_status().

Signed-off-by: Tuo Li <islituo@gmail.com>
---
v2:
* Return early for uninitialized STA il data and align D_RATE messages with
  il3945_rs_tx_status(). Add a wifi: prefix to the patch title.
  Thanks to Stanislaw Gruszka for the helpful advice.
---
 drivers/net/wireless/intel/iwlegacy/3945-rs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 1826c37c090c..c509c89bba00 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -626,10 +626,15 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
 
 	D_RATE("enter\n");
 
+	if (!il_sta) {
+		D_RATE("leave: No STA il data to update!\n");
+		return;
+	}
+
 	/* Treat uninitialized rate scaling data same as non-existing. */
-	if (rs_sta && !rs_sta->il) {
-		D_RATE("Rate scaling information not initialized yet.\n");
-		il_sta = NULL;
+	if (!rs_sta->il) {
+		D_RATE("leave: STA il data uninitialized!\n");
+		return;
 	}
 
 	rate_mask = sta->deflink.supp_rates[sband->band];
-- 
2.43.0


