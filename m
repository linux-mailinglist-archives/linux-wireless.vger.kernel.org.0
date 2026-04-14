Return-Path: <linux-wireless+bounces-34745-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MhVM/yZ3mlrGQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34745-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 21:48:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C073FE17F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F74303C009
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED942F1FDE;
	Tue, 14 Apr 2026 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azpE6OUC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312030BB9B
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196089; cv=none; b=MXZsP18F72XuPyba0p2EWCNW25DxWgmOAaiSBYCx7CDfxQa2c1GjPPR77XOn1g6R6RzXcNkPh5w5h+d3ElYE6yeLkzaNJJeBd/c/NUhiDPEqym2DaqppSFGPKb0CemWx0nKMy44HpiCOBGpARtXGXCDtOGwtwbN2hAJFtVIClWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196089; c=relaxed/simple;
	bh=e8g/AI4FJ8p7NUYamHZbHF/TeV8/GkPGlAOO3Z1H0VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lC4Be/W98h3GlEE59mlozzT/7qewFm0Y5+tj4bRCqSAffB8BOJLDEvxk0e7B0yrT8YCkjN4BiZnxsR7+ENSIdrpW7olJlG8n7QdcTDF98TABSGRJPGsZqPoti2tLJvLmwicvDkQKEyzfBBY5yQrYVjB28QGXbCnZTRm5DS0s/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azpE6OUC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488afb0427eso72948005e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776196087; x=1776800887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTbrmREgIqFspcZJEJHoOzGkDNDV/nNlxzaSlt07LQo=;
        b=azpE6OUCO1a9BZyCJtDx1o51+O8xdNeLU7diYVvhSTrnixQAjdNF6dxFh3olPfd+gU
         YOaVBNblyUsJTe7TeJFCoLxudD1Dy1ZJe9AxqtWKU1fXO4n/AnjUThXZAnDykiXL4kjl
         pu1jqmck1x0tLBNgdgeaspR2KjtDanrHSQxotCf85yWHKvSkWPfVr56GUAENls6qNy4i
         G16Gs9aYkBwndEBDj61ybtRhfCEPYAZQF663N4/fqBW8d1EZEE3mujOUH7PEpxxa8KPF
         GtiwCE1DhBEbTDOAEq1/OWD/MSP9YhlccwyyQ+A4gcfwlvDF6XJ0tOlu91mQrw9s/AwD
         HbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196087; x=1776800887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTbrmREgIqFspcZJEJHoOzGkDNDV/nNlxzaSlt07LQo=;
        b=NkXfnY20eD/74Dzm0YhcI4pCajlgWQZC51uNVkEhNAQoG1lLeRLIexA/q16kwe+xHu
         cyg2Tiugk/wDdTzddakbe5fq5tnKBjA9ASNjgPZPE6xVkDFaZjq9lDk72QINIgZUfuP4
         eYke/Bwy2QrpNynQx9CX7vgvxMbIzH0dD1VDg6v+goO2KLscnIHfe0NRrJhJ2EDFeq5C
         Vmi2dQNeXBRr/9GJJweii58rGYgS5JBFMmZFoN7KgdsG0OC6cW6KN+4Ket3IuRlCgbH+
         DOWeyYfzXZd2b1tI8DXOsvU11+0tAxD0Ibi6ycyEUdjpZcsRQ0RCOIp2Em1r2y5ksQkh
         ua4A==
X-Gm-Message-State: AOJu0Yxl/alJfEsMqy1KaWGUSDT+8F/eyDxHPfcEbUuEwQ5DfbFkprD4
	jDyYJTAmNGXVjB0MXWCtE4hZkH5mRDYsCVx3Ba3BbTDNdO5Fc9ZVyfzU
X-Gm-Gg: AeBDies5ntJWEBwMLVrtY26l8183adVPzfuddjMLB1CttqyepO0FiqMAY4UoBzzOIzZ
	JVgYOT2o21ts7QXK4fHxrghrsfXFuRdm3NqD0aB2zbFSu7/URtICIIS/7HZzLrFwT4TruHdS3EG
	qubktIuYtWvuzI2IaDCh9scOuVQDDzqnYsTCIzJnD7j7aR0phnA8znLwgRE+so9M9JRvPPfE2ns
	EXMzlefHVPKTDWL7VNEZbVMCA6e2eXbXFI3uoXDGL4DrsSevMxxzLFZ/exq1tTdXxhkPmp8iC9h
	gQa2GMs3mhF6cOm7q1Y/1LA2I9Z4jAysu4HpMmeT5A6CAGxu9URS9XSmwVLep/fvzj6uuoZ8XR/
	lAsn5rPeRKC/DaYW9dMrtsW6uSB7ttRS3VpHtcNKX7o7BbIGHChIhTKsqOuixNVR0MgmKCOArcM
	oLSWAnzBOkpOLyRxu3V5e+1HDYMdGrazMuF6rVstG6J80gFThXRYVtsFm88VqGo746Yx7GBTPqi
	g==
X-Received: by 2002:a05:6000:24c2:b0:439:fd13:5c4a with SMTP id ffacd0b85a97d-43d64297b74mr28166740f8f.6.1776196086514;
        Tue, 14 Apr 2026 12:48:06 -0700 (PDT)
Received: from fedora ([2a02:586:e909:37df:ce84:3a77:87cf:ccf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6fc9d525sm27444924f8f.36.2026.04.14.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:48:05 -0700 (PDT)
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	Oleksandr Havrylov <goainwo@gmail.com>
Subject: [PATCH v2] wifi: rtw88: Add NULL check for chip->edcca_th
Date: Tue, 14 Apr 2026 22:47:57 +0300
Message-ID: <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
References: <20260413100249.28618-1-npetrakopoulos2003@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34745-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[npetrakopoulos2003@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 14C073FE17F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It was recently reported that rtw_fw_adaptivity_result()
in fw.c dereferences rtwdev->chip->edcca_th without
a NULL check. The issue is that devices with the
8821CE chip don't define edcca_th in their chip
info. As a result, when rtw_fw_adaptivity_result()
tries to dereference it, the kernel triggers an oops.

Add a NULL check for edcca_th before dereferencing
it in rtw_fw_adaptivity_result() in fw.c. Placing
the check at the function entry avoids logging any
garbage values.

This change does not address the root cause for
this behavior, but it prevents the NULL dereference
and the resulting oops while a more permanent solution
is developed.

Tested on a 8822CE chip which defines edcca_th, so
this issue is not present on it, but it still uses
this driver and I can verify there are no regressions.

Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Reported-by: Oleksandr Havrylov <goainwo@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221286
Link: https://lore.kernel.org/linux-wireless/CALdGYqQriS7mP0vj_rm_xvisfzFVh0hbpy+---48r6bodZO7tg@mail.gmail.com/
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
---
v2:
  - Move NULL check to the entry of rtw_fw_adaptivity_result() (Ping-Ke Shih)
  - Drop rtw_phy_set_edcca_th() hunk; all callers define edcca_th (Ping-Ke Shih)
  - Change bugzilla reference from Closes: to Link: since this does not
    address the root cause

 drivers/net/wireless/realtek/rtw88/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 48207052e3f8..945fedcd375b 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -279,6 +279,9 @@ static void rtw_fw_adaptivity_result(struct rtw_dev *rtwdev, u8 *payload,
 	const struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
 	struct rtw_c2h_adaptivity *result = (struct rtw_c2h_adaptivity *)payload;
 
+	if (!edcca_th)
+		return;
+
 	rtw_dbg(rtwdev, RTW_DBG_ADAPTIVITY,
 		"Adaptivity: density %x igi %x l2h_th_init %x l2h %x h2l %x option %x\n",
 		result->density, result->igi, result->l2h_th_init, result->l2h,
-- 
2.53.0


