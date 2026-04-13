Return-Path: <linux-wireless+bounces-34695-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHiLNoa/3GliVwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34695-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 12:03:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958653EA2AF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 658A93006781
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67154346E56;
	Mon, 13 Apr 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlWNaKTv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713935E956
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074627; cv=none; b=NPEyfn9VOF9Scw+h39W4imXLDQ4mi/ppgoSUwi1YOx7ZM+haHv55Vf53t5YVbEmHjmP6KW8wt3VYTruy+zQjMbSBJQ7uz2EceCFLB+pApjQ7vo+bIxz9vjHl5z5FU053iYxzc/T239bKdD36XITo42LMg7UVLoThoqINWDTk/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074627; c=relaxed/simple;
	bh=BuhFIen6Ac+1GUTwLrQqUksTb5n9nEh+t5zfBzL6UO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUEF/0PJ1w70tFkUHbrEltVIIpvsnuezoFh/wcwRV98B9m+Dvyab92z7Czv79wyBDJEpw9HsJF2PytaK5Nv8ya1coG+xo1JcDndm+3yyDkwCOmfsB8hBNpxBz6n6mvaWpVzQeqoyiYQjhY1gNFVWR3KSBpNvU1/GMP0knM+GyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlWNaKTv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d734223e4so689504f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776074624; x=1776679424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIXni/q1yaGi0fWHIAsT7aMdfrlQ/oqixUPYn0EFfik=;
        b=IlWNaKTvwQprfVcyyZY4lEwPHKB6vT2ujSNjRj0ZEwZ1gGfBybBnxAylgG6+9KLmb0
         dZRx5j7/wqIIp1AZbenym9a7SC3mgeYb0J2H13p3NFDB7rcgSFv58rFRIMEb4prMfur9
         J6jYRYzlM/lZlfBSBNES09W8nQjF5K9611reMPpu6/N5E6AWXab5K4GAgF3qbC+cwUvo
         UcWvofgOvPARikk0p4qYAIiK2wE4k1OJ5Ln+u0nrj57MAcZZAkXapkMHFTo1NIHB2G3s
         Vw7Q3a1mPr1Ya0SdPFZ74YYFeWBSsb8puCstdeG5zN4PrJaIoCcbdS/I0FzbXndejWa6
         c60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776074624; x=1776679424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIXni/q1yaGi0fWHIAsT7aMdfrlQ/oqixUPYn0EFfik=;
        b=pdPZuC6r6QcnmHcezDZyylZuswR5UoLkGuowHFQKuVotX9FbG1uGWrQcEVkseSDLvf
         Mtbz7981vAOPRHOfs+am1TsDTe7wGJYNTgfE1gCynrxYsmabYSDvVZnPEn1cx+QH5l8q
         P03JE4OY0+dxpnBhIX8xTpcKgwW2QDOcy85uAp7U/kJUIy6XeeQPsybfw3UrYwulJL5C
         ukCOtZBGYwatUDjYe1cpZjhXYmVlfEDIltOzP+l2rTOd9MdQEtxgC5l1ma8Po21eh/eE
         glSYcH/mGnJoPEdJfFb9XUUm5DADfKe3s6d/vvgeVS/41PqP+zfaLfWaX+Y2W2r+PZ+i
         d2GA==
X-Gm-Message-State: AOJu0YzvReF16p3PZSuXPOtosSMOgXD9QaLzPvGo3rk/5fwON1JWi6Ze
	orytM0eNmwxf6qYY2lxHE+3yPuXHX3K0a7b+FbDYKE0sKWjSe4Yd3xWI
X-Gm-Gg: AeBDievnrS/ZtbzMXY0VISd2vCjtxBibaLQzvbKrWxTp4YLpD6IBymLU3zq7fQ0sXoc
	eCsHZVAqlHyDuk0MTwR53ipgpmUtsLFHquOubYRnn5ireD50yatGK3l9NhERX9EMiqk7lqORLcB
	JUldhaZxk2bJrBOZJpD4X8+K4H3w/pnTbzqt+jV7kspsvbk4/Epxs6eqhCQ+tGB8ikC8ecT95Dr
	SMwKSmfNhKYkmJFLz2ANuXH3RalXCOM0wqLjH1wdtXc2CK6mjmfg+my5p2XzeOrGWdOZ92kt1NV
	ZSJY8I8Z/GUg7pVqqNfHMxakCk3QNsSEfeLy/B/3uV4fXn3bMBwNT3N6rFzQQn7L9TBtXQroCMd
	LIx3vGhYy+eCOttT+zyxs4cqiz1O6pES5Rf9ml7I+HBNWy534S05/5nrWkBhhr2ekU4ueHLtgob
	xKWJk7+Rqdz+4aGlLMQu9RScfSiNADBS462MT9ZF+zWOnrk8ybiyktni16kckgd7mrDuTMxdsHv
	f+XaF83
X-Received: by 2002:a05:6000:2401:b0:43d:76dd:269 with SMTP id ffacd0b85a97d-43d76dd0365mr5733100f8f.29.1776074624021;
        Mon, 13 Apr 2026 03:03:44 -0700 (PDT)
Received: from fedora.home ([2a02:586:e223:fc00:fc13:e2ba:df80:5e4b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a53sm30995042f8f.5.2026.04.13.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:03:43 -0700 (PDT)
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	goainwo@gmail.com,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Subject: [PATCH] wifi: rtw88: Add NULL check for chip->edcca_th
Date: Mon, 13 Apr 2026 13:02:49 +0300
Message-ID: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34695-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[npetrakopoulos2003@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 958653EA2AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It was recently reported that rtw_fw_adaptivity_result
in fw.c dereferences rtwdev->chip->edcca_th without
a null check. The issue appears to be that devices
with the 8821CE chip don't define edcca_th in their
chip info. As a result, when rtw_fw_adaptivity_result
tries to dereference it, the kernel triggers an oops.

Add a NULL check for edcca_th before dereferencing
it in rtw_fw_adaptivity_result() in fw.c and
rtw_phy_set_edcca_th() in phy.c.

Tested on a 8822CE chip which defines edcca_th, so
this issue is not present on it, but it still uses
this driver and I can verify there are no regressions.

Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221286
Link: https://lore.kernel.org/linux-wireless/CALdGYqQriS7mP0vj_rm_xvisfzFVh0hbpy+---48r6bodZO7tg@mail.gmail.com/
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c  | 3 +++
 drivers/net/wireless/realtek/rtw88/phy.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 48207052e3f8..c4819ef6d54d 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -284,6 +284,9 @@ static void rtw_fw_adaptivity_result(struct rtw_dev *rtwdev, u8 *payload,
 		result->density, result->igi, result->l2h_th_init, result->l2h,
 		result->h2l, result->option);
 
+	if (!edcca_th)
+		return;
+
 	rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY, "Reg Setting: L2H %x H2L %x\n",
 		rtw_read32_mask(rtwdev, edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
 				edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask),
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e2ac5c6fd500..c10eb28e54ad 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -161,6 +161,9 @@ void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u8 l2h, u8 h2l)
 {
 	const struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
 
+	if (!edcca_th)
+		return;
+
 	rtw_write32_mask(rtwdev,
 			 edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
 			 edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask,
-- 
2.53.0


