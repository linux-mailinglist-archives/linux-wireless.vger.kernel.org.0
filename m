Return-Path: <linux-wireless+bounces-36029-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BmzJ/hF+2lPYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36029-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:45:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291C4DB427
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71946303E102
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F547DD79;
	Wed,  6 May 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DozI3dGV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025147D940
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074965; cv=none; b=UkOxCLt+XqbODt2kS9bBypmZEuRa5XP0BZD4Iu7HkJs3tiV1JaOJdBV8P5OUxVof+b4cy5E6+R5PujPgYSAICeT0SL+dcOs8XcBTt9YAVK/EDva99F9H3fUvDY4jlGSktwFerHpLTmgzX2kCUQWsDzAiBV2k78mpkl0NnNI6NMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074965; c=relaxed/simple;
	bh=2HD94H72RjGn4lcV3GURKilahi3Zzww/UQ7dV/6ScAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg5E5WtiOJByzv270qz5kdauukQB2XZ3DzNDv/aSs1vUMyRo93St6D60TkMiUVxBS/+HoiMuO23ij0fJETYR11yRFMpIHYVXnK8gBU6pCmLU0L3bCdtVcEMKvN0p81qOOks9TTJK8rru0kq3f/3oxJpeJPcv6MOLwzq7aJAL+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DozI3dGV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so5208675f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074962; x=1778679762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=566swxN5CfK8+IAC0jG77Ukl7ynr7hgeiWhy9OmUy48=;
        b=DozI3dGV0wn8QpzTHOF/c8yPn1lfXC5Dg4kBHpJzZtXEYq0wJnsTA6/OruV2xpY9fs
         xOriaixmJdPYnJ/gplAJuDgc/7S+NMx2UyzzvZalTLvBDZKp2rsY2jm1eR03nvMH1xs5
         WSvyBLCSZozxCD0P1hwOJvTzWORRjAqm012VtdS1zD1z9z4FDmOjRuk+TfrDoOSoZJuD
         xQSs70+NGSrm2VVwrUeFyAXB4G3CDXmH7F1z1ZjTMLeaP8sS9Rf7K5mVC8kR4asnGW92
         JpAhkU6uLizRLSWnLlagmdEyQ26P+olTM/XcXDM/6YyMk7m9LubrrNhOJ5hMxBwKCD1C
         R8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074962; x=1778679762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=566swxN5CfK8+IAC0jG77Ukl7ynr7hgeiWhy9OmUy48=;
        b=bqHP9solYsU22cZHb8F3j7b8ZcScA7hziLn5fgdms8lbYcPe5OAaM4wuNJs7fYO+qV
         9PtpgO4bENAyYdBTdj0x6z67U+ZwJfsg2nemGL1WZTZYI5coZ4XPXTfwBN8aSxnzL6dT
         pioVqa9xbi2ZkAXv2M9GHPmj0YMbK9S103sOBnQ8JB5m5zD1RSEykPrNL+bBlYqm+U3j
         eSyfDDeU5rV1sVEA6+ARhXFNYnKiSNuip/ht4MvY5hIvBDTS5IVM22uII8gwhaMlDX6R
         olnvyFnBOZ9Iq4BHf7lOCU6lrLCugnXLNwVRgq5XXn7aaaAMABBzVKyCXLnCUsGtnIBi
         4Kvw==
X-Gm-Message-State: AOJu0YxItULPpdetArmwlqPD04tWTJGBqSnLb2iAMsDAVLGltvFWSSME
	12fj8N0LRoiydMaAlSRxlW2Hqal+kI7HqCR/F6NPNdFq46AojlYxbo0J
X-Gm-Gg: AeBDievPYd6Lq+Xq+ApGJQAqQ4+gRuk3Elo0Ny2hKu1A+XFFdDouba46PIBKNW+WLfQ
	ZXARblsgWv65Btz4jvKuxGiDZVjFr+K6a0jv/qi+vEW1zGqRFPlFcZmORnrMenpyRkVkJZTkcr/
	P94/b1WW4bNe3DPMw82/RAP6dDKeVE0L28m0KdEytqePIMKec6xkdt0MsqgEmb+8NePq3PHL6nf
	+945+X2V6X8GdoO5kSBQHj5oqltRPz3BekR9RV9+ncfToSpEBoOMaBfHO43wUv7u9ex+zEA10qS
	mRgnHxunzHMZizHDCp+leCVlvbSZ7bTlhUxGbblVYqWrYuz97ibC8i7jJEJONIRK6oaziQqTiqP
	kLwTLFlvUi2NNjpaQ08ObQ3o1PVd8eq9WZVYbRiWldQHyg7HWZUNmrGO16yKhV/7vhu5RUNzdL9
	YEMpt4IJ9gl3rfW4FyKE9MEtPUCDqNBCT9zNTa9b9dU8vt5RyIRrkCGLG+6HO5dHcnL/Y=
X-Received: by 2002:a5d:6282:0:b0:451:be9b:5f79 with SMTP id ffacd0b85a97d-451be9b6047mr3058918f8f.2.1778074961723;
        Wed, 06 May 2026 06:42:41 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm12542182f8f.7.2026.05.06.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:42:41 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/3] wifi: ath11k: fix error path leaks in some WMI WOW calls
Date: Wed,  6 May 2026 15:42:38 +0200
Message-ID: <20260506134240.2284016-2-nico.escande@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506134240.2284016-1-nico.escande@gmail.com>
References: <20260506134240.2284016-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6291C4DB427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-36029-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Fix two instances where we used to directly return the result of
ath11k_wmi_cmd_send(...). Because we did not check the return value, we
also did not free the skb in the error path.

Fixes: 79802b13a492 ("ath11k: implement WoW enable and wakeup commands")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 40747fba3b0c..024c2aad9fb4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -9332,6 +9332,7 @@ int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
 	struct wmi_wow_host_wakeup_ind *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd);
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -9345,14 +9346,20 @@ int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow host wakeup ind\n");
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_wow_enable(struct ath11k *ar)
 {
 	struct wmi_wow_enable_cmd *cmd;
 	struct sk_buff *skb;
-	int len;
+	int ret, len;
 
 	len = sizeof(*cmd);
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -9367,7 +9374,13 @@ int ath11k_wmi_wow_enable(struct ath11k *ar)
 	cmd->pause_iface_config = WOW_IFACE_PAUSE_ENABLED;
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow enable\n");
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_WOW_ENABLE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
-- 
2.54.0


