Return-Path: <linux-wireless+bounces-35316-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FwHEGgb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35316-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:52:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D115E467962
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B78243019C86
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405F30AD15;
	Sat, 25 Apr 2026 19:51:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66532303A0D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146719; cv=none; b=r0G8ucfHccwmlPaSPnKlEwAGvONFvig8YLrJf+CiCl6hEtrGSvfPgjMio3qnWbvSByElhzKZK78CX6xoeycK2hJCEdscvOiLHZAuwYYFKv3xmIpX8/VaJeDgciJadpLKHvmE3aWV77Q5b7ET+Qc3sPagKYASPx81WUGCp6IbwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146719; c=relaxed/simple;
	bh=l2w8iOQSDkvY3bSVuK7btxT7GfqyA/ZbGqAmRvKNYL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URmLiXmWyK5c0CZS1DWnpNZmijMB40/Vl1ivrmk9VeDF9veUExfFw+tSCHLOfxkmMrbZD6/mSRIh5xagkGZhdI0Gvqd3l8FHCqw6UyxoOunNwzfJXWDMAx6uYxiHgV7+I8/hDJbaVZteNQSAhN8jiPERWyl1TgLaKEYCTDpKfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7de44ed7a11so3344828a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146717; x=1777751517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHRklaiLJOy6i2kgynyc4q2QMlVjNfm6VGRRVM4/y14=;
        b=qpqV2LTzD3ISIyYATzWSQ+eFdLrTXokkZDXSJl6Cp8SYX51cgWNYFfjnbKIX8vHels
         PPSeskisdcC/9FsCAcApQ7YerJ7DmsjkDF7co/bRiguymyy8a/qg/WMseP3yTFIvghmR
         YJsWDm5jUpdc3qi3D9rUhpapb/x4PPUyKNZ7t4atPeLO+LQYxs8eQd41cJ2l5eiWqZLC
         lqx2xW7Va8uhOGHcm6S4qIRCi4Uxox+daWjJcyl2EUf9ZNnkg90boHZ9llh3Af+A6sis
         vvJa4U8fbzJyuqtZsii9OK0nFr2ubCPSEbIoP8B3HE1qbMAH6x8xmWt5+F3uNc4lcaLZ
         wS8g==
X-Gm-Message-State: AOJu0YxQ7rLBWAcHlcjXzGj5kxiyHr41qGfFinyFN0lUbUoHm9byX9k+
	iBOfP5wRS5Eywgwi2DeP2mEzu+b7nnADl2vtNcg+J4/FGbnWa8bMNRc6
X-Gm-Gg: AeBDies+sO6Zt9kWTqFaDdRWewEjsug0P02BmGxb4V/w2yECTy+4FOilTEsft075LYP
	hRjqSAtWaeSHTRnmQdTA5RN8m0Wq36iN0fL94KHhwUHNvzvrGFqOp3N7L0q8kT64bDE0l+xJmfh
	qQaW085mTVLoi9xvCnjP8MS28kghphYTG/ZRHoIBh8/MVLM6kc844gSQnpNAGIEGcjmNwaRXI31
	Gzgz+q9PWc0Jn6pjKfr/r0wXgDgFnRcMvyxV+8TwnW1J1r4kx5TMMSGYLm316lKK2JM1/mFO8MK
	pj+QjOeZ75c0LsxAIoH/+c9ceZdlEfP/j6IESoU+S8x+O2X/K5BwOVd7m/FcOCHs9Vko0tBOO2+
	7GeY9biLyckJph0HTvOQUV0OWvA3xspxA7AlTkfccuIeFcKzMWzai9ZQFq7N485NqlGtpAuI0E8
	NFp7ZTd+CH1eTSxYM99Q1WtrvmGYpUH8yYd+FY1XtxwgpAY5lz7DixHwdZRTI0RqCnyTmw1IMBM
	DohVR7CGAyQ
X-Received: by 2002:a05:6830:388a:b0:7dc:cb67:cb67 with SMTP id 46e09a7af769-7dccb67d5f6mr18661336a34.5.1777146717535;
        Sat, 25 Apr 2026 12:51:57 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:56 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Javier Tia <floss@jetm.me>
Subject: [PATCH v5 19/21] wifi: mt76: mt792x: enable CNM ops for MT7927
Date: Sat, 25 Apr 2026 14:50:09 -0500
Message-ID: <20260425195011.790265-20-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D115E467962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35316-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

Enable CNM support for MT7927 so mac80211 keeps remain-on-channel callbacks
available. MT7927 needs them at runtime even when the capability is not
advertised through the normal firmware feature path.

Co-developed-by: Javier Tia <floss@jetm.me>
Signed-off-by: Javier Tia <floss@jetm.me>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 152cfcca2f90..3fdcd0599ff2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -759,6 +759,13 @@ mt792x_get_offload_capability(struct device *dev, const char *fw_wm)
 	return offload_caps;
 }
 
+static bool mt792x_needs_cnm_runtime(const void *drv_data)
+{
+	const char *fw_wm = drv_data;
+
+	return fw_wm && !strcmp(fw_wm, MT7927_FIRMWARE_WM);
+}
+
 struct ieee80211_ops *
 mt792x_get_mac80211_ops(struct device *dev,
 			const struct ieee80211_ops *mac80211_ops,
@@ -772,6 +779,10 @@ mt792x_get_mac80211_ops(struct device *dev,
 		return NULL;
 
 	*fw_features = mt792x_get_offload_capability(dev, drv_data);
+
+	if (mt792x_needs_cnm_runtime(drv_data))
+		*fw_features |= MT792x_FW_CAP_CNM;
+
 	if (!(*fw_features & MT792x_FW_CAP_CNM)) {
 		ops->remain_on_channel = NULL;
 		ops->cancel_remain_on_channel = NULL;
-- 
2.43.0


