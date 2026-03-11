Return-Path: <linux-wireless+bounces-32936-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIKGG0S3sGlvmQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32936-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:28:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78168259CA8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D7C43007ACE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 00:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F99D35DA61;
	Wed, 11 Mar 2026 00:28:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2535DA57
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188911; cv=none; b=spJJryi9+qAAvgiDIJeuC6EJx4El7/ezzScSi02//LXcJu/QJ0DxsIoNK3OsuCU1I1I6go/UicgVJ82IR422hbgZtHvfMxMJ1SrDdtVAr+JADtJaTbxJmZEiJcHgR56hStA789jS+cnaV0lFuHiSB5AAfnQxJW+SeVU+I672RmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188911; c=relaxed/simple;
	bh=x1I+/ISL6OTVcLYZHXE7V55D9PZLbfhUCQpcI1iNIIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMf5q6ROn9jhIGnez1BzUMuvZDh2cfVwa6bRbKeH+rSh8+jmTI1vUj8ErSlOqw3gpVr9XajzLmwQipCc+l/SZ1XBzsGhWZgouaao192XsLLmfn9broYtVOiOw4wySI47q1UKuphfCqtE5ZSBlAuFMeXhTtAcofwHISr9xm3fxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-464bc03efd8so7998878b6e.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188909; x=1773793709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ATRiGzqYc/km5OI3xmsPtelJTLro5lPbW2iw0ZmTlE=;
        b=WiZM6XnN6VQ1c3Ge+vV/7PKPgLXvbMwdRRfYBDt65vU0LIGKtMqJq/3K2QR5duxeQJ
         W9Wb1ovMxRgvoIiM0F0XCXa/sVlHCkkZ4pQ721trefYoGb6QmA2kkFbQXEDg65KN6/U3
         u8r78Mxjeg3Vm0FM5TxvNNLZkpoS5KaOFFxtXsDplxwqiNkYsoHZkreQYIvOONVtLZl5
         wg5LycRGtahPRyaj8zZK1l1wwxmchu+7ql4SQCu7HMVI333gESCRM1iCSs80m2e6nSQC
         /SSktJSMyPTvwembXvoE4bwoohzlhmUEM3r3E+pm77rAvXLnK6O8diCZASO7V10ksruo
         l2jg==
X-Gm-Message-State: AOJu0YwS/pRHK5ql38w+litbpc+ocr5cjrWSKLt7QA5EfYKTqNInQv7G
	TquQZ1Fl/s0JUgxfe5FVJCc+5yj82UPOlaHL23XJzs7CblBp1pfGCZHg
X-Gm-Gg: ATEYQzxMWApWRmURohjlQRAEbKQJzUh9FwSGDDE87zSgdgBnXMzccCd3bPGc3txh71z
	ButX7HRTYKBps+B2T43nq6WJr3hRpOdA8ElzIIjvgIVoxdIGHqIaoktLsDdTwv9GkWAZsp6W+9p
	RpvlqoRdrYBfe385w/W0kTuhAJVmUVgFp7OFoBcQg1TwtUFix1b72XODKo/kEnakJXLKLbLZ5Q/
	/UoVg1nRKmXpRruCsm/qwq8NJOv/xWlR4JSN3e2W6N9WYCTOPyDQ7lFwdTYRkPyYaM5DsDY7FZc
	Gw3obaGBJxlOMxyyrsbTLjNDhTNXQgfxpRZG4O3jYpEO+4X7cFqECA+5ktRv04rsQDj1SAgE+v+
	YvXs1UBMzawPOXcGmhWY6Gw8eyu36zLppNE0GBa42IjZFKFO2PZ4G41raEVrpneaiIyYNWBSfP1
	f7tsid0NpPPzutBX+nTV4fHvF69UdWfEExzL0/qFgH7RUZYvg=
X-Received: by 2002:a05:6808:13c1:b0:450:d471:dce5 with SMTP id 5614622812f47-467333f0844mr413343b6e.6.1773188908872;
        Tue, 10 Mar 2026 17:28:28 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e72b40asm516497fac.20.2026.03.10.17.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:28:28 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt792x: describe USB WFSYS reset with a descriptor
Date: Tue, 10 Mar 2026 19:28:24 -0500
Message-ID: <20260311002825.15502-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78168259CA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32936-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Prepare mt792xu_wfsys_reset() for chips that share the same USB WFSYS
reset flow but use different register definitions.

This is a pure refactor of the current mt7921u path and keeps the reset
sequence unchanged.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 552808458138..a92e872226cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -206,6 +206,24 @@ static void mt792xu_epctl_rst_opt(struct mt792x_dev *dev, bool reset)
 	mt792xu_uhw_wr(&dev->mt76, MT_SSUSB_EPCTL_CSR_EP_RST_OPT, val);
 }
 
+struct mt792xu_wfsys_desc {
+	u32 rst_reg;
+	u32 done_reg;
+	u32 done_mask;
+	u32 done_val;
+	u32 delay_ms;
+	bool need_status_sel;
+};
+
+static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
+	.rst_reg = MT_CBTOP_RGU_WF_SUBSYS_RST,
+	.done_reg = MT_UDMA_CONN_INFRA_STATUS,
+	.done_mask = MT_UDMA_CONN_WFSYS_INIT_DONE,
+	.done_val = MT_UDMA_CONN_WFSYS_INIT_DONE,
+	.delay_ms = 0,
+	.need_status_sel = true,
+};
+
 int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
@@ -236,25 +254,31 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
+	const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
 	u32 val;
 	int i;
 
 	mt792xu_epctl_rst_opt(dev, false);
 
-	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
 	val |= MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, desc->rst_reg, val);
 
-	usleep_range(10, 20);
+	if (desc->delay_ms)
+		msleep(desc->delay_ms);
+	else
+		usleep_range(10, 20);
 
-	val = mt792xu_uhw_rr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST);
+	val = mt792xu_uhw_rr(&dev->mt76, desc->rst_reg);
 	val &= ~MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH;
-	mt792xu_uhw_wr(&dev->mt76, MT_CBTOP_RGU_WF_SUBSYS_RST, val);
+	mt792xu_uhw_wr(&dev->mt76, desc->rst_reg, val);
+
+	if (desc->need_status_sel)
+		mt792xu_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
 
-	mt792xu_uhw_wr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS_SEL, 0);
 	for (i = 0; i < MT792x_WFSYS_INIT_RETRY_COUNT; i++) {
-		val = mt792xu_uhw_rr(&dev->mt76, MT_UDMA_CONN_INFRA_STATUS);
-		if (val & MT_UDMA_CONN_WFSYS_INIT_DONE)
+		val = mt792xu_uhw_rr(&dev->mt76, desc->done_reg);
+		if ((val & desc->done_mask) == desc->done_val)
 			break;
 
 		msleep(100);
-- 
2.43.0


