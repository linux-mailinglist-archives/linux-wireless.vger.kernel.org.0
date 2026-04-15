Return-Path: <linux-wireless+bounces-34748-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N6kHKIi32ngPAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34748-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 07:31:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F824007AD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 07:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E057A30492A4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 05:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC62ED866;
	Wed, 15 Apr 2026 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxCNvpmF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761113C918
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231017; cv=none; b=Qqry+zqnYBp4DWR7SQct6lLgSG9633e1Q/iBF2RX1YSS9m7HkfqoZQ+drVQk9CLZr36vSVarbtsJYVgnkSQNUqznod7TnUmr5MmwD0Ir2/4UbivVxuvn3kZrvbjRcE+eAHwXu0LyTlDkqKLnPNdAm/+Q6Ma2SiIz5wNCrnOSfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231017; c=relaxed/simple;
	bh=wLLWYEFqt+FJLfvcGVsit2J7EjFN3EVKL87WV42m+QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlMmmLBTI8pjenf52sryy1zU3//qnbZVhwgehwku2Pr3vapTdEQG+evUUDYQjVPJlTeAYc2f5XxPh+hIX8TnOv4kK5miXQMga72/7uCITi/FYkB+O/QovxssrmISHWE60ACTidq3PJLY5yXIogquCSyDoDJN5DNydeXar2uIqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxCNvpmF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso65389335e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 22:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776231014; x=1776835814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SatMqVouQ7R9Sd0lDzaZdtrthYqaYAig5hvObxVfkG0=;
        b=IxCNvpmFbBVF2O/7LsyeGNEFcVyg+n86GGKr2d6BoAjku63vP18zElopIN0ekZpd41
         lrypm03sq7LlE3vhfo2FRnUmqDWRtCSmrgI4xR5umuV0DexRSDpbsajMVh0+CrVIftf/
         yLyejqi35V95KNw6GI352l2QbQyXNu0SbMTdcXYN8IW9fl0czLVCl1fObZeYdMhs1l9A
         QCorJ+e+kkQY0PW15jBj2JrB0e4MTJBIjj/bb1IuiXQSP/n9qMIvp7lUiUHXZfbFSFtz
         urSnLH6wQi/L6zq2u4VWq+0sP0GU1wAG5MDtTh11yTo2F5GZuJ5PWqXBFCXPZ9k/Y/Gl
         XsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776231014; x=1776835814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SatMqVouQ7R9Sd0lDzaZdtrthYqaYAig5hvObxVfkG0=;
        b=jwGP7jLpFHGtTEgZwejJfNcjagQw5u7jMfm1Q6cOSQkD7TIUAxtkrj3NsAUYynEakS
         KlOgI8KcvCPmWGUMXw+7Fg+0Gns2lhRKAXVw1E6bqDWV43BdfIDRcbaxWeMfGrodTEIf
         glyT1Ko8w3HtqnNQLINOo2fYMvu72/6uO4mNSnJOExr8/FA5dW+HyZQpxaIE6M9rSvkb
         Ve+ep8ShyAJbtN4R462UL3AmLluS2UebBPtzRlpjgdx7VU3DlMJ6q3xp+Io+u18QN7M4
         kPfgmF73EPVTe5OKwcir0Nft1PXps2WVJesTiAtFBFLYUOJ/lkf2UfJIZK/Oalp3FZjT
         Hqrw==
X-Gm-Message-State: AOJu0Yws3OsDwbZjL2+RLLWa1fbolPLpR4a7Zb/nIgBR7Amkozcj6e8+
	hXkNpHLOQYCBM0JpwjOv9r0xivPABomhanmEFPFIEcP1jSkwVSzyxp4X
X-Gm-Gg: AeBDieu3VMqunpjBH20oNsvjh6/9TiHYQEjLU6FeCn5bOprFEOy6Z9/yfItzy7bgMu9
	gkHx6Dh8cjVhUMUiPyl9Z2yxwHE8hL1sPTITqHR16lkO+H9RZfbj+KKLm+/zf6cjNjs5EH9DZqA
	Bibep4s96kfdcVjGhIGbbujnEmrxqRjlMDvlMT3/8y/wglhwLW0g3X+8wo5yHkPAAJhYpWwvPeO
	hjr7GcYTHM7fI0XRJDX8obaDnzHxK9S2SuvVn9cuHx8SQcxo+33oGmVTOGgAK31W5V3FQUmTQdc
	SNy+poIk/ZCDHO6l5PzTTTMs6a1WZQYlp2xOI7Yh2anV8w8K/tS0BGxvP9S0WQYpocQUZHjPFLw
	RYo44150RdWO3mzfItgXl9M8dKNsZZo3HuB7TSpvo8uMlkBl6cYvQQF8Rq56rK7kMNv+9aF597o
	7rq1v3ZCMWuXwr9TgBafpb1wcpyrjfNQmLTM6brEm5KiqnGH+uCLp/YriQn+y/xrgN
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488d680079bmr266148155e9.13.1776231014134;
        Tue, 14 Apr 2026 22:30:14 -0700 (PDT)
Received: from fedora ([2a02:586:e909:37df:ce84:3a77:87cf:ccf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ec6cc6sm10737615e9.29.2026.04.14.22.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:30:13 -0700 (PDT)
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>,
	Oleksandr Havrylov <goainwo@gmail.com>
Subject: [PATCH v3] wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()
Date: Wed, 15 Apr 2026 08:29:59 +0300
Message-ID: <20260415052959.14844-1-npetrakopoulos2003@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
References: <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34748-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[npetrakopoulos2003@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4F824007AD
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
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221286
Signed-off-by: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
---
v3:
  - Include function name in subject (Ping-Ke Shih)
  - Restore the Closes: tag for bugzilla (Ping-Ke Shih)
  - Drop the lore Link: tag

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


