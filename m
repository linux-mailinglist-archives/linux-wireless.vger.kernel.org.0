Return-Path: <linux-wireless+bounces-31121-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOYiMpKac2nNxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31121-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D234A7818A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B85C3006203
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779C1DD877;
	Fri, 23 Jan 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbtqZtir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9625A642
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183886; cv=none; b=ecTktfDK0LQ2WuQF80UwhevuWkXyO8WDMyJXTYadAc8Ic05YZAnusoBwRpza9HKiVMXHJ2RxbSYYj7eXR6eb7DAVmevisHR2WvIOUfCcfhwxfs294I9/382c/nzi36G39l7RKLPZfpP2TdnvQqIcDwlui6fQDGbGrqtOXj2JisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183886; c=relaxed/simple;
	bh=Dl1pNuIyA/9XuvTAAfN9PgDr66VvIBhi/wej/aJJsgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZGRM2O2qvbJm/2LBrZa7gytHGO1qv2bwGRSwPw0ZVJ59QVKfgNystvrp1g3uN5nt17WZ5ab2eusBSR2x5JI/8ElMrGDGpGW0kK2JEZ58Tp36+89khA9Xly9CVbTWk75SotWiMmm7QCCe5/QzCdmnPWtGqHsfkRI8kd38kR48sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbtqZtir; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81e93c5961cso2137608b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769183885; x=1769788685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om9q+srifk+m3/ipW1COktkWxrQuXTLgvLJtU2pt4s0=;
        b=ZbtqZtirIG7lWIWMt5R/qpugKIk5gaLEyBqO1vsT7xIb4npPVeikz4Efyc/mDaa+wx
         nGrW0Q/NvGwtcBnf5cWo+2z4FFdjLoYSHbv1/b3Yx9wQc5zh8IeaYqfcV6paBvWKGnH7
         jdkqLutJfZmmsffhDPLjwTRPPPnqgkSjWNRaUdM/jtWMCli5GfaQFIlF5yCNLVJB8534
         RAHd5UdhZN4W1ucyec1opWYSNcJ/uqQ7ZnLLQbEtc+TAs7pBfZA1Irub62pfvhXf3UVV
         BbPOxir9Uso/QZA5u3s6mfndEoj6YjfRQqViChtGZAjfJBZ7g5MWs5PsLakKfwOXqwTe
         9bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769183885; x=1769788685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=om9q+srifk+m3/ipW1COktkWxrQuXTLgvLJtU2pt4s0=;
        b=pmpDXtxJ23wZRBvPqAcNLw+GT+FSUcBEaXHu1V8IXl4YvmyHn/ucSSofS4H6CBYcI5
         s84bK5ilQSfOi6OeU3znsXnI8WKGHvH8oVTEsAXcokXEjkt50TZ6ndWEz2QIlgRXwSwu
         W9tBM3H2hz9GXVeKMeVnaJIwkPgcM7E7eLk6uDz8r6FAaHVpj/fPB6v9wN/4hkRFua3o
         LVbmMK58D6pqDz8adONwVoRQDB89SvB8pxcvwPgFcR2vxXLlJ5RyF1kASomhgvC6xEkf
         w6O3MKIZXLLEhopo+Y2Fz+sK3zUy+I16KcFMCfeqstOS2nkBPyfNfXfQc9XIliA3vsc+
         8SRQ==
X-Gm-Message-State: AOJu0Yxfl2LGWGTPE5TVzS1jhjsZDe+bEQBUzcrijK7h6qbd7bEXBrsJ
	b10T0yjrc+8EkI92sGqZkN5xW5nios3w8eszjbT6gXIee1c+OL4E0CxP
X-Gm-Gg: AZuq6aL2/fPe5nmEMrPBsUjoZBvCLNjTJjL/Z0YbsCvK0eCtmHlgyREyM3/Ur700Aqg
	378nS8qlOrmQ2PBmFpv0YEivUaRZAPjZ51ApKr+QHSB0ps+NR3ND0SKLdQrouwwRKuVC8pwUKWR
	3fTUerW4+Z1GdsiyorfXdr54haJgePFitQPk5kaORjbRMdtcAiSIhukJnW6jVfuYPd8MrPgCf9h
	zo72jzz9sKjaaUdKnzWTrGoM4owQwWOxh6GmW3RUZXc3nc3ie5UZi1RrueAqSPUmYnoYZxswrBs
	jhpdJz37RYsk309y5UGbSScLb3c1FZmQAJB3QTwcDD1cqIKQp6fxCCfml/3SstoIKAq0ZKS4XdM
	bcp9HMa+qyMP5MMs7RMNqP4RE+cPnQdHnaBJTLi8rYingnN4TYA9yUx32UaYbtFomxEEaA/O1D1
	sqw1ka9O0KIR5/z3bEgpmKm44vWnq0odI5p2VD
X-Received: by 2002:a17:90b:5625:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-3536894d3b5mr2930051a91.19.1769183884674;
        Fri, 23 Jan 2026 07:58:04 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:dfb6:6b31:aa17:2446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335206b23sm5489305a91.3.2026.01.23.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:58:04 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH] wifi: ath12k: Add fallback regulatory domain for WCN7850 without SMBIOS
Date: Fri, 23 Jan 2026 21:27:48 +0530
Message-ID: <20260123155750.6007-4-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123155750.6007-1-bjsaikiran@gmail.com>
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31121-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D234A7818A
X-Rspamd-Action: no action

When SMBIOS doesn't provide country code data (common on some Lenovo
X Elite laptops), initialize with world domain (00) and skip sending
it to firmware to let firmware use its default regulatory settings.

Without this, new_alpha2 remains uninitialized and firmware receives
invalid country code, causing repeated regulatory update failures.

Note: This workaround doesn't fully resolve the regulatory failures
seen on WCN7850 hw2.0 with firmware WLAN.HMT.1.1.c5-00302. The firmware
still rejects regulatory settings during early initialization, keeping
the device in passive-scan-only mode for 5GHz channels. Further firmware
debugging is needed to resolve the root cause.

Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)

Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index cc352eef1939..4121dd14bbcc 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -800,6 +800,18 @@ int ath12k_core_check_smbios(struct ath12k_base *ab)
 	ab->qmi.target.bdf_ext[0] = '\0';
 	dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
 
+	/* If SMBIOS doesn't provide country code, initialize with world domain (00)
+	 * to let firmware use its default regulatory settings
+	 */
+	spin_lock_bh(&ab->base_lock);
+	if (ab->new_alpha2[0] == 0 && ab->new_alpha2[1] == 0) {
+		/* Use world domain - let firmware decide */
+		ab->new_alpha2[0] = '0';
+		ab->new_alpha2[1] = '0';
+		ath12k_info(ab, "No SMBIOS country code, using world regulatory domain\n");
+	}
+	spin_unlock_bh(&ab->base_lock);
+
 	if (ab->qmi.target.bdf_ext[0] == '\0')
 		return -ENODATA;
 
@@ -1522,6 +1534,12 @@ static void ath12k_update_11d(struct work_struct *work)
 	memcpy(&arg.alpha2, &ab->new_alpha2, 2);
 	spin_unlock_bh(&ab->base_lock);
 
+	/* Skip setting country code if it's world domain (00) - let firmware use defaults */
+	if (arg.alpha2[0] == '0' && arg.alpha2[1] == '0') {
+		ath12k_dbg(ab, ATH12K_DBG_WMI, "skip sending world domain to firmware\n");
+		return;
+	}
+
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "update 11d new cc %c%c\n",
 		   arg.alpha2[0], arg.alpha2[1]);
 
-- 
2.51.0


