Return-Path: <linux-wireless+bounces-31120-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDQlNnmbc2nNxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31120-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:02:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E667820E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 17:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1E2B307D704
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F53287269;
	Fri, 23 Jan 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ9aK1Jq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB52DAFC7
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183884; cv=none; b=t1Vjr0HPGi4oL+SJvTf3iqbfrP/QueO4+u6qQMzyd2BQy7oDER9IptLS9vRo4+ySHvZkDYhXohiYXzlMU2CL4yM8FwUD3k7OfNRUYvJW7EGWhVhLjSmk2tCKsadI5RoCfwu/EDHIvgPDCVa1ODO+y50CpIQFTUAtMfVpOu7Kl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183884; c=relaxed/simple;
	bh=5gCzyYhkC0My1sh9sagjLiLTqS+YnqxNJNEuJAxopdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYlU2wGgIsGTVhfQ91QI55GVPwAjUbqrRsNG8C1E1mZlkl+xH8hcqs2LzSbaAvldafOkxNb658M7hYglPxPqpViW70W0NLxRMo7MVwG1D2TZGSQihixraod6GPf7Y3MrfJFgJkdvC3bYF3Kuje02aa+WGNyKdagl7XAJEkYZRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ9aK1Jq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so1674444a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769183882; x=1769788682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzibT8m2ri/6+nQQXOFIdpBUf9O69J4+aJF2V6yb0pE=;
        b=WQ9aK1JqVqyU0oYLBecoqMZKX8e5nRNuV2a2mL0lBioBauiWCavCSfgo6FIDRsuJmS
         Inu75x7wlSTbnST0twbo89SUda0+xVV8mvAM3c0AiXzfoDZoroROBb41NOcQf6Su1hTu
         hK+m1IL8wuNLu//RCuONgm/2FdQ29f+3n2EeUXR3/xj+KuGRy6rKpqqVeKgKyEW2305O
         TJqr7+2OSRDXDzwTpDnassBjt+X6nmXsIk4EeAzksDtL053UgbVijbWIUko1Hir2GCrs
         W+j3AGivBAw+Ilj+H8SHV0PhokKIwFKqDstuuztr6j7xA0WnxfCh/BMYLdgP0PUmpo1L
         7iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769183882; x=1769788682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzibT8m2ri/6+nQQXOFIdpBUf9O69J4+aJF2V6yb0pE=;
        b=TONQchTyRNQwsoIFknVv3nYhFznIZVAHuEEzrpYtyaTL2BXM9XxX7xOPXvfZqdlX9i
         FkU+qBSz6k+sTLYPQVmNILizkt4XwmJ8L85PLEybol+hrzUeKT3tPQQbp6+sM8Mdr4Sp
         3ptloTQuwgC8H68gw38OE464MAGwPcrj6pXkTyBDGogeCpQW+aJfPyfNn9JtdymOtrHo
         O3XwzPTfG6YnjYd4HcpiY/CjoHwU6BtR7mLGPUf8o+6x3L/iqhoQBmp3eb5ZgPeZUmOL
         2sGuyoH+meZwODpBiq4TMydiRiJYJBcTT4Mi6gJO8V3sI3Nxsid5wP6cvoL/LcajRIxY
         A7eg==
X-Gm-Message-State: AOJu0YzWvBL5Bbbsta4UxekKNtUeebJLjHbtEENIbdxV4JYP1xi+FRWB
	vJ2HkqAreT2Zn96dvHBPeGSReLntTUPwdPDmSZdxIx8gK6DqhPOvZUmN
X-Gm-Gg: AZuq6aLo9bdr19522z/vdQb5xNFsCltTCwH7El0ZhCpYLovgOSkgkyI4vIzjpXI0LDT
	gvuFglUEmOrFy3JBZuYT+XFU/dR5RaFaTika/cQNWyUazkx5T8tURk2igj1PUgk4CH4+OQPN6ep
	ORycbmMRK7HloxqhIrAhiLVndDiWoqOyHuLRo47fcoDWdzsMqXjHHRDJocKDaDMn3geC3os2liZ
	g8iwna3UNv9wIsFzt4djpfx0sS6LVXM0L7LWHzeUJFLTvw8qQp2mndsCBylbQTzY64G5nUvVBeo
	p81R1C+1jDW72kM1loF0HCgTU8oBgPmaK/qsGVxlY48TrpgeRNFpj44PCsWLV51sHQto/mVO5pm
	q4FRENLKOdDvsVGG4RUilAACpW4f3krdX2B7wfM9NfXUuEjuMeiUK/BwMQVNcgZTDicfmUSUxer
	l75lmU/SxLIED5xtQbAAZwdvCol/cDP06aZlAQ
X-Received: by 2002:a17:90b:3503:b0:341:ae23:85fd with SMTP id 98e67ed59e1d1-35367025551mr2841157a91.11.1769183882420;
        Fri, 23 Jan 2026 07:58:02 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:dfb6:6b31:aa17:2446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335206b23sm5489305a91.3.2026.01.23.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:58:02 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH] wifi: ath12k: Initialize regulatory frequency ranges to avoid filtering all channels
Date: Fri, 23 Jan 2026 21:27:47 +0530
Message-ID: <20260123155750.6007-3-bjsaikiran@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31120-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67E667820E
X-Rspamd-Action: no action

Commit 657b0c72c4ad ("wifi: ath12k: Fix frequency range in driver")
added reg_freq_2ghz/5ghz/6ghz structures to intersect regulatory
frequency ranges with hardware capabilities. However, these structures
are never initialized for devices with self-managed regulatory (like
WCN7850).

The WCN7850 firmware manages its own regulatory domain and never calls
ath12k_reg_build_regd() which updates these structures. This leaves
them at {0, 0}, causing this logic in mac.c:

  freq_high = min(reg_cap->high_5ghz_chan, ab->reg_freq_5ghz.end_freq);
  // freq_high = min(6000MHz, 0) = 0

Result: ALL 5GHz channels are filtered out and 5GHz WiFi is broken.

Fix: Initialize reg_freq_* structures to full frequency ranges in
ath12k_core_alloc(). For devices with proper regulatory domain
updates, these will be overwritten by ath12k_reg_build_regd().
For WCN7850 with self-managed regulatory, these defaults allow
channels to work.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302
Fixes: 657b0c72c4ad ("wifi: ath12k: Fix frequency range in driver")

Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 4121dd14bbcc..99c26ba01304 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2290,6 +2290,19 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->qmi.num_radios = U8_MAX;
 	ab->single_chip_mlo_support = false;
 
+	/* Initialize regulatory frequency ranges to full range.
+	 * These will be updated by ath12k_reg_build_regd() when
+	 * regulatory domain is set. For WCN7850 with self-managed
+	 * regulatory, firmware doesn't call reg_build_regd so we
+	 * need sane defaults to avoid filtering out all channels.
+	 */
+	ab->reg_freq_2ghz.start_freq = 2312000; /* 2.312 GHz */
+	ab->reg_freq_2ghz.end_freq = 2732000;   /* 2.732 GHz */
+	ab->reg_freq_5ghz.start_freq = 5150000; /* 5.150 GHz */
+	ab->reg_freq_5ghz.end_freq = 5945000;   /* 5.945 GHz */
+	ab->reg_freq_6ghz.start_freq = 5945000; /* 5.945 GHz */
+	ab->reg_freq_6ghz.end_freq = 7125000;   /* 7.125 GHz */
+
 	/* Device index used to identify the devices in a group.
 	 *
 	 * In Intra-device MLO, only one device present in a group,
-- 
2.51.0


