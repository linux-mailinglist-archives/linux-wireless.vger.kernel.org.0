Return-Path: <linux-wireless+bounces-34119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JhlCL7YyGk0rgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 09:46:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1258A351251
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2936D3005150
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 07:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9427456;
	Sun, 29 Mar 2026 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRjdkwLB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0040DFCF
	for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774770359; cv=none; b=u/5J5THRc5HGBb2dputl4mwpw/xtTyflJZvP5IU73YeTXQeU4MuovN+mYvo+dySw2l9NWdcxNDKl1f1VnvewZxotqQqJem8uSla+Rr5GNq5QdZrGk/1uhTM3sbcwg3oRn4iUlcibwXr3qANYgIvtHl7svkGsbQgc4K5oM2s6qvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774770359; c=relaxed/simple;
	bh=BkjsRLTiXFnfsl+r4rhWqg/PjUZtQNs9aEvZb94z8fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gy+ljb8CPPKMR8/QmammRFXZ9RKGoR+8/VjYWv9LkasNyB6gT3iy/VWpKI92oWOAsPTlxEBZelE+HD42D1t6VbohAimyHd3SU3odPc+wk/tElpgEJEORGSEfridFWHvxPyjCkF+U1N+W2h5M3x+NJOYBJLpHF5KweoywccmqRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRjdkwLB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so31196035e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774770356; x=1775375156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKwJ21s4zb9xblr9sm7yvOWm70cOBNidr36Wr85InOA=;
        b=lRjdkwLB5GbD9MkCHZ64Qg+yfarVtsYHBQv4aGyeJgKoO5NGhpPeU8f8tPPFvd/swb
         4l4ZOTIqpIPb9SibjIy3us/F2+hX5LYnf9Ovr2Jw4I1yY0CdQF3+dtETP6EhGVR6axeW
         oUpH8d+ybzT3lf1tL+S4Hto14KY/37Tb81dYeEmLTK/YNxod5l/eYRZogC7rSqFdJFgK
         a6G94w4Yl3lw6czTb4zARr1vTWbboBxEYhE78togGYfCsGWpQsm51qpvChjtfzqpNjty
         NV+uxX8jj35JweAvRXRfkNN51T6454P5IhXJ5dycHcGWXZSgdZRIl7RtLMwiBBV2yNLN
         sKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774770356; x=1775375156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKwJ21s4zb9xblr9sm7yvOWm70cOBNidr36Wr85InOA=;
        b=gANglScigWcJxIh0S3i59xQvtZ+Z6Xici5UbFvLtJ4aBZ3pmqHG2SJOwiXZ7HU7P9I
         Wj10j6mM/slE3lAMO1g/48/c1kd8jYODHpeS/VtAcf5QeskgluioTLicS8fBT+xm+2uF
         6iveJH7frXUblI4rhVgLFk8VOizWiEWbpDmEdvHJNZTiVuXwXXvgKbDUcJz5vgKbFHXh
         LEDo0mrbKoR8oCSOfbmBF2XlTU+zhsEIgq9WAGxJhuNcqC2vGzGpsj5BIIGzOgcGnMI5
         9hIFCCWQ4oGrjfI9BaTfhKVbHxNyQUPtlIXu3wvMdLqRcj5kYx4ObsO0ZsbUw3vfpHd2
         CEiw==
X-Gm-Message-State: AOJu0Yw5jMS7KnleqILGcQoP7nuwQztJFuicboV7qSeOmDCN/fTpRKfh
	OGy5j126Ce4DgFHfQ+EUEVAvBB1nIROfvngW/GraPz/DTIUw0HArvgHU
X-Gm-Gg: ATEYQzy9CuOT5lr9buhSXZeO0I25Vy7IrcB6iSvAVfZemXSRGvPOcjjSAmSNBUHjDkP
	gUD0FEOdTLgEfDHdWFNLnKxIzWXWKoDIiulH38pTFCLBkOSDWUgy2lhY+ljEALvmbtrn3OVT6SN
	gNq2jMTdrMCJqrr7OuU5ItIB+GCUE2V0SznNPFVTqkM+pfo+5Nx8NgJuE3TB9igaaY4krUJz7mB
	iT1CsPOiznEom3RxQkYZ5cRaFDmI4J24fEh0uT1hQXR7Z3lQNX8JbypJbgRhfWVMEQb+uHu55ZV
	2liO9VqoPqjQRDn5RBgeBR82m1nKYf/uZSVEjVxjL7rXd6/Z6opymPRGhJQ12ru9d5xzmSct+CZ
	x2e0gNIFJ8lxmrCJAUJ3aBbKCJzTUUbdf0aEl/FbKJedzMIG1ds+dPf25sl9XSdfJFx3BBulDL5
	fqG6bUhCoXm9y5TxrxmnWmD6DgBEKxLsltVF0LSMxhHQ2uzp1yCNtL/GqqrPa6W0cIjxN4Kfy5K
	3oPZgGCGBBwSOznw/pkAsKosx8bFYASHMWIpveh9RHIgcq09b5YF+VQa4Uof7BHO5PyKDxt0sDg
	1/dXiBEf8i52Q3D49ZXTHz/Nh+626I61QfL+o6A1VNfhWQzuiUGe7hKy1YrKdfeEMBG8kQ==
X-Received: by 2002:a05:600c:1d1e:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-48727f0b0femr138173355e9.9.1774770356477;
        Sun, 29 Mar 2026 00:45:56 -0700 (PDT)
Received: from archlinux.kangaroo-newton.ts.net ([185.213.155.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873ab203e9sm3592865e9.0.2026.03.29.00.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:45:55 -0700 (PDT)
From: Christos Longros <chris.longros@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christos Longros <chris.longros@gmail.com>
Subject: [PATCH] wifi: rtw89: fix typo "frome" -> "from" in rx_freq_frome_ie
Date: Sun, 29 Mar 2026 09:45:50 +0200
Message-ID: <20260329074550.114787-1-chris.longros@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34119-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[chrislongros@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1258A351251
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The chip_info field rx_freq_frome_ie (RX frequency from Information
Element) has a typo.  The function that uses it is already spelled
correctly: rtw89_core_update_rx_freq_from_ie.  Rename the field to
match.

Signed-off-by: Christos Longros <chris.longros@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.c      | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h      | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 36e988277..f683f1b68 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3203,7 +3203,7 @@ static void rtw89_core_update_rx_freq_from_ie(struct rtw89_dev *rtwdev,
 	u8 *variable;
 	int chan;
 
-	if (!rtwdev->chip->rx_freq_frome_ie)
+	if (!rtwdev->chip->rx_freq_from_ie)
 		return;
 
 	if (!rtwdev->scanning)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4778957d6..d500839a4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4529,7 +4529,7 @@ struct rtw89_chip_info {
 	bool support_noise;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
-	bool rx_freq_frome_ie;
+	bool rx_freq_from_ie;
 	bool hw_sec_hdr;
 	bool hw_mgmt_tx_encrypt;
 	bool hw_tkip_crypto;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d6deb44a6..c54b36cbd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2638,7 +2638,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
-	.rx_freq_frome_ie	= true,
+	.rx_freq_from_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5ea7a36ab..1bee56c87 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2324,7 +2324,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_noise		= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
-	.rx_freq_frome_ie	= true,
+	.rx_freq_from_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 197e3f5fb..096016292 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -971,7 +971,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
-	.rx_freq_frome_ie	= true,
+	.rx_freq_from_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt	= false,
 	.hw_tkip_crypto		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 92bbd6e5d..858e6bc3e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -810,7 +810,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.support_sar_by_ant	= true,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
-	.rx_freq_frome_ie	= true,
+	.rx_freq_from_ie	= true,
 	.hw_sec_hdr		= false,
 	.hw_mgmt_tx_encrypt     = false,
 	.hw_tkip_crypto		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index de5d343f8..07ec924d0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3168,7 +3168,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
-	.rx_freq_frome_ie	= false,
+	.rx_freq_from_ie	= false,
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
 	.hw_tkip_crypto		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index f41b66b36..eef039517 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2972,7 +2972,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
-	.rx_freq_frome_ie	= false,
+	.rx_freq_from_ie	= false,
 	.hw_sec_hdr		= true,
 	.hw_mgmt_tx_encrypt	= true,
 	.hw_tkip_crypto		= true,
-- 
2.53.0


