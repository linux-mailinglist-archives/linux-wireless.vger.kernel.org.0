Return-Path: <linux-wireless+bounces-33666-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHCWIGXzv2kgBQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33666-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 14:49:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 368652E9839
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 14:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13970300C80E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2026 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D26A35836B;
	Sun, 22 Mar 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1nF+SG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1D1A6830
	for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187362; cv=none; b=PoRiwO+RzrMnb0sy8l0xwSb44Ogtyt/MkQOwbglslkxs5wV0UmqndJ04tUABFKjh3nCq4RyLjg+f5uLTVHOJT1/WCgXf0kcQWxkyO325h8y+f3GA43lSyu8PnFOJ1MTmDEaFCI2dtZHDeLwIylzF4T2VpGdTunpuQ/loNgJ5ZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187362; c=relaxed/simple;
	bh=L188qcy4INkSuoynTyGrYuPGhudwO6zpDZwKpyWWUJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu3c5liespK6oYoRfNm355tUGWF60j++oS51MfiUNZwDWAllq4pOCBWlnqNgpVwO2KN0eD57yGXDSlQRF8nDGA27tQSXsS3a8EQa/owUlXMyO/rZL2Z3WNwc/eRxq0rP96cmFLnbQrOSkKWdJv/bCmthJ1W0hcaFvHjVkjkLi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1nF+SG/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso40222145e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2026 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774187359; x=1774792159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVx6+9D0T+ApnWRp1SbXG3Z0dDSdc75tY72kqtXBbSI=;
        b=h1nF+SG/GR0Z5w1KNppX+waw0EqQCovWkOysrop8OJ9UWcDWVkQTrgyyvdxmzLqa9p
         DqGP324QHoYUj8c3NuYIq7qbUAAHlQB44PY68wtjMk7HCGya0Wx0yMTKUFEEze+RL7L1
         P2urwAnpOvdhP+d0lhq///LT5A+yaon8+NPwATjhpGhb5HUgIok5k11pUhIp8mlTwRpU
         72uhVt+y3nL0pP2tUEXmlDeilntKNbRs8SEseKSOdVDtAX/vEdaqtmBtN6IOHdo6p9vw
         b67/7HhB72drXnUCVqOxxqchEPlsZQYW8MreJHdxnA8HMVBNfjaAiSdw3u6MW0bwI9oS
         ea5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774187359; x=1774792159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVx6+9D0T+ApnWRp1SbXG3Z0dDSdc75tY72kqtXBbSI=;
        b=N/hP1UKehirzM1qzqSv3RdWdPSJ5CyFX9SpRoIDxv/kgJ83AxpXuFOmAXzUX7LN66C
         RYbrR4U53yJN0LdlvkyyMgiqFry5EqP7GWCO/lC4RYuhwHD0DxP+fVxplPEOScIUUz/W
         BD5VGYUh8qjjX1gO7I6IiUUQNFcn9s9e9eSiVy3ugSFOXRD5svkOKTgUrLNBmMo3QRP4
         1G1wRA+4f3XFFsmEiwACwzCvZ1db/2dFD/UZXTISxChAH+pSbcWByY0JAWKidnRkqkCI
         M68oLTuw9PLi9NILqprBNzB+hTXLLDSV+B25Faff+fxHZP7fE5oYbs3BWjaWSVyctggZ
         JILw==
X-Gm-Message-State: AOJu0YyJgqCnJmBwpB73fG8XQnkNVK+far+RE9g4aqx9DJgkOr/ocN/d
	+xgTmim+FnLOVGEsRC7h3CkWMtwcsYfjpQFhqDW1xdIdAZ3pQMdifru+hqrMec80djU=
X-Gm-Gg: ATEYQzyQ0FydZ1SrNIg8offct5120xFtXDlOFpO/NzCA0uN45ZF4jcXNfgYSpBR5Y0l
	pZLUG3YzjjqfsXbWGLbVZDtYjEWkGmst0RPWkCLhTHPFD0Dd9os62s131VhnIPG3OixJXC7RLtt
	cEdb72ltA9J2pt0O/SYu0JL4h1hzfk0T9aQVmPRIb89LYhbTXANvhE8Z4DnjZ4icmQxdhwtQl6Q
	6t/b8R3Uvr44YjTxSI0Z8Y5+tYf9nUsVIg7xavIjzJfGQOfNZ9tzL/Va3ERInIJvH73euGSFwRm
	MTai1l/xkX/Oc24GLzFzp6bpNUlKtEVw8QjdsRavCbYqlbAwt3UQVs93a3TJHogtjZJ1NrEMx0P
	H8P0AZKqXqJMnRseVKjvMxdn9j0dzH4J7qe1WtqIni+TwDYx+DbKrtgrptzv7nglU52fdLY4POH
	hfxf1xGLAtFcz7qvDh7Su9lppDtGQffJmlwEQnQHm4TY53+7ZZ4FtRc3J9WOXIz9p4wHKRDxMEe
	OniUTX+vTIZGIY0bX9Kmz0dFA==
X-Received: by 2002:a05:600c:3e10:b0:485:3428:774c with SMTP id 5b1f17b1804b1-486fe8b0073mr140863515e9.4.1774187359319;
        Sun, 22 Mar 2026 06:49:19 -0700 (PDT)
Received: from DA4-DEB.fritz.box (p200300de871aef00290206c667fbb9b3.dip0.t-ipconnect.de. [2003:de:871a:ef00:2902:6c6:67fb:b9b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700658441sm268260335e9.4.2026.03.22.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:49:18 -0700 (PDT)
From: Malte Schababerle <m.schababerle@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	Malte Schababerle <m.schababerle@gmail.com>
Subject: [PATCH 1/2] ath10k: skip quiet mode for WCN3990 to prevent firmware crash
Date: Sun, 22 Mar 2026 13:48:21 +0100
Message-ID: <20260322124822.230492-2-m.schababerle@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322124822.230492-1-m.schababerle@gmail.com>
References: <20260322124822.230492-1-m.schababerle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-33666-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschababerle@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 368652E9839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

WCN3990 firmware (WLAN.HL.3.2) crashes deterministically when the
quiet mode WMI command is sent during ath10k_start(). The crash occurs
at PC=0xb0008e20 in wlanmdsp.mbn, ~17ms after the subsequent
vdev_create command, and cascades into a full modem crash.

Commit 53884577fbcef ("ath10k: skip sending quiet mode cmd for
WCN3990") addressed this for HL2.0 firmware by gating quiet mode on
WMI_SERVICE_THERM_THROT. HL2.0 did not advertise the service bit, so
the guard was effective. However, newer WCN3990 firmware (HL3.2)
erroneously advertises WMI_SERVICE_THERM_THROT via its TLV service
map despite still being unable to handle the quiet mode command.

Skip quiet mode unconditionally for WCN3990 using QCA_REV_WCN3990()
instead of relying on the service bit.

Tested on OnePlus 7T (SM8150/WCN3990) with WLAN.HL.3.2.0.c2-00006
and WLAN.HL.3.2.0.c2-00011 (both crash without patch, both work with):
- wlan0 comes up without crash
- WiFi scanning works
- NetworkManager recognizes the interface

Fixes: 53884577fbcef ("ath10k: skip sending quiet mode cmd for WCN3990")
Signed-off-by: Malte Schababerle <m.schababerle@gmail.com>
---
 drivers/net/wireless/ath/ath10k/thermal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/thermal.c b/drivers/net/wireless/ath/ath10k/thermal.c
index 8b15ec07b1071..33f299f414710 100644
--- a/drivers/net/wireless/ath/ath10k/thermal.c
+++ b/drivers/net/wireless/ath/ath10k/thermal.c
@@ -136,6 +136,16 @@ void ath10k_thermal_set_throttling(struct ath10k *ar)
 	if (!ar->wmi.ops->gen_pdev_set_quiet_mode)
 		return;
 
+	/* WCN3990 firmware crashes on quiet mode despite advertising support.
+	 * See also commit 53884577fbcef ("ath10k: skip sending quiet mode
+	 * cmd for WCN3990").
+	 */
+	if (QCA_REV_WCN3990(ar)) {
+		ath10k_dbg(ar, ATH10K_DBG_BOOT,
+			   "skip quiet mode for WCN3990 (known crash trigger)\n");
+		return;
+	}
+
 	if (ar->state != ATH10K_STATE_ON)
 		return;
 
-- 
2.47.3


