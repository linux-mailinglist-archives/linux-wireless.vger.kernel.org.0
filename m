Return-Path: <linux-wireless+bounces-21637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1398EA91D9E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03135A496A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA724633D;
	Thu, 17 Apr 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YW4dexUM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWjWBKcp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BB241122;
	Thu, 17 Apr 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896033; cv=none; b=KA0Zpu9fjDkC+hgGhgEmfnFF2kYLLNwPiva1B96k5SD2/F+HhEdVdaqki3cxGELJWntWopYCajoK77CuH5Vqgl8OT5dLai17TwgLRmrhTp8RUml5XsivBO2MlXLCHv6MYPMuw66/X+oipH4+sQgkITWjYCD8xowpC4W/8pMrrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896033; c=relaxed/simple;
	bh=TTY0OdEts5CMGR4SkSsgwcX6nSC4Z23DkwaOHjZ9iIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLYw1cCgIGLk1UtAnRUw7H0OqRjqbJ5qxzmKHFwthfLxUdAzyEmiY2MPwtBVPSCAZAo8Fh1npijn+1Umw4Xs+GrmyQ16o8npgoKmEMgYH5AnLCaGT7rKda72F8Fnvqg0cP0csljD2xiBpM2P8WCBxvl5WEdFA719UAtpjAmO+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YW4dexUM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWjWBKcp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpuwoWN6mbA9oZ2QFKD0MvRa4oPxeEBdptFek4pK4S8=;
	b=YW4dexUMujxhI9RsX4x7e2elK1th4IpqxAipylBDIV8u2vFkCMVaIfxqtpk8zJw4WPsavJ
	ziKnj1Sbwm3E1hTnPoKpj6QKTdUltTha+HxCoX3crpuzS9JR7W7Qctl6JCQcu/iAPFVaXO
	eoOYsLpRVZ2hHJKzoyVj1lEiibuynlJWF2AtBMMjSiC4e5uEPGbnyHn+Kte2ItStvnQm/2
	9wWY9buEPv0qsuiPXKPy7+MaFBx/z/QuSHjRUAz+gpVt5so8GU8DNun3Jzool9P82lww/R
	FCfRLs0Hqj1Ai9bt8qMiWkVn1zC9TzBh/k7d5O3VIfQu3Y0mrp7Gt2RGP/uD+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpuwoWN6mbA9oZ2QFKD0MvRa4oPxeEBdptFek4pK4S8=;
	b=XWjWBKcpMSPa61yH7fgPD2/6e0pH02J06KeHixSvn25XVLO2gDia2o71gDihTb2qbHsnug
	pKfiNxqb8/2EUwBA==
Date: Thu, 17 Apr 2025 15:19:09 +0200
Subject: [PATCH ath-next 3/4] wifi: ath12k: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250417-restricted-pointers-ath-v1-3-4e9a04dbe362@linutronix.de>
References: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
In-Reply-To: <20250417-restricted-pointers-ath-v1-0-4e9a04dbe362@linutronix.de>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, ath10k@lists.infradead.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744896028; l=2078;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TTY0OdEts5CMGR4SkSsgwcX6nSC4Z23DkwaOHjZ9iIM=;
 b=6r1KIK7Old+1LXqWuk2M0JkIPIqBlAOJFQOpKm+FhYnzMqaj1nT3xp1900DFyDmWDfN8V3Ldn
 RvGlN9nendpBnJSC4wnuynbmYXclbpbLGsH4bQB3ZUZqyPxMHr1BgZn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/wireless/ath/ath12k/testmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
index 18d56a976dc74c4f6eab87e358c14d4faea648e2..fb6af7ccf71f44ae4bd01cde53fba3527eed0d2d 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.c
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -97,7 +97,7 @@ void ath12k_tm_process_event(struct ath12k_base *ab, u32 cmd_id,
 	u8 const *buf_pos;
 
 	ath12k_dbg(ab, ATH12K_DBG_TESTMODE,
-		   "testmode event wmi cmd_id %d ftm event msg %pK datalen %d\n",
+		   "testmode event wmi cmd_id %d ftm event msg %p datalen %d\n",
 		   cmd_id, ftm_msg, length);
 	ath12k_dbg_dump(ab, ATH12K_DBG_TESTMODE, NULL, "", ftm_msg, length);
 	pdev_id = DP_HW2SW_MACID(le32_to_cpu(ftm_msg->seg_hdr.pdev_id));
@@ -227,7 +227,7 @@ static int ath12k_tm_cmd_process_ftm(struct ath12k *ar, struct nlattr *tb[])
 	buf_len = nla_len(tb[ATH_TM_ATTR_DATA]);
 	cmd_id = WMI_PDEV_UTF_CMDID;
 	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
-		   "testmode cmd wmi cmd_id %d buf %pK buf_len %d\n",
+		   "testmode cmd wmi cmd_id %d buf %p buf_len %d\n",
 		   cmd_id, buf, buf_len);
 	ath12k_dbg_dump(ar->ab, ATH12K_DBG_TESTMODE, NULL, "", buf, buf_len);
 	bufpos = buf;

-- 
2.49.0


