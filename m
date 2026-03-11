Return-Path: <linux-wireless+bounces-32937-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFVVFUm3sGlvmQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32937-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:28:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9509259CAF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 01:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BFEB307DC7D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 00:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699635A3B9;
	Wed, 11 Mar 2026 00:28:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A01A6814
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188918; cv=none; b=hgXEIZbpBYIck2o/Dub6L6uk9QSafGSTLCPqp5bCrxAw6oo7XiHspinjRfbHidXEBZe5lVH8BhVLzH9qEN1YYl5CV4W+rw05NkQT29rFRf5zXKT+ZThQLNyR+0lUSYnds8h2lyf+82R3qOhOJx0LlgVvVRXGs+7mrHucv/t4M6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188918; c=relaxed/simple;
	bh=OkEIBxc3yBY6QPzdTqn2maD1OuzaedMvIydfn3q/lLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMOU03rSxCVwJElZPCPLdfeNnY6pWBCC8E7APpH3war9mb0y9LlVoqjdhnzr+1iuy9XuDdFJBcph+IPSdXIXEyYaoLyJtDTNjTBHJOdA89y/ltF1DWP0Mdsrmfl++Xj8TqbUcg3hs5PfPqsV4+IZ9PxPOEpjI6HtMw1e9MIo5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4638e238094so6920803b6e.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 17:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188916; x=1773793716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uV7lH3FIJA3CkRWr9ZibC3b+y2jhZmrH7643sTDjV0c=;
        b=t7WjjXXfF6Idb4OuaahtERtADfutg17rGvob+eW6lsd5KM3LEULldYNXtoobaJfap6
         k9Xn60IZl4eZRZn8RVOLr8FNWYH3bOChVsm8Hv9kREB+9I2IymxMQIB8l5ebehYK2KJH
         homHeynaOj5hj/wfVYhV2w7TObQEJR/JZdxjoJATJWprmJWykGrxIrTNtUhkxwJSyboK
         JICECKJ9o2OCYhPEMFUuUS78O2T3mXLWiALALoe9lahsMwAHbMBxBlxKlynPW6/GtzXb
         vqJD/GciSKBB5wyGer8OFC6Ffdj+IAMruEabP+uNc4pYoxbAnYBxwKgBT0WT6HTF3GkM
         XLpA==
X-Gm-Message-State: AOJu0YxjDsSWO3ifhyM/VI1xizrcXyY9ErdZUP19k5+Bbz36xfCn46b7
	O6ro1jP8GDJigRGkj3cPS/WvwtRhBODwNEgUGvSoZNX41w6Du5xorOFmNMJGYg==
X-Gm-Gg: ATEYQzx/KI28roSbfk1vEqoMMGc+HUyONxbv4rkQA5ZwhNh/XKvFUNsZ1hjhmOdYs0V
	c6Rf38ZOO6QaVz89eym9LIIZBfAvMINJYJ442MKDMAXapJsy+618kwe2xXFT1f1p/yJgpDH7XNA
	i0z7m3b2JBkgIz6tS4XsWrROGOqTZh+6429d/BhUZxslJMl6oYYw2aeWmQRhYseeUPQ7H83n0RI
	VRa1AFE3pqQwyh/8/vSLzOZfG2Wj2uTMZJZB2/hfwGJTZIX0YBFe41Sp3dxsi+2oBH5PxCfgIbo
	r4nenFv7uxxvpuNhZr5o4dbhsKdPjSWme3VSM9q9iz5JA+le1INp5ye7LIVWwZgqHzJlqcX8hhl
	1qudY4sBoCxL1n/wxXpZFK2YEu5qLgzrlT9xMR36HRs15fs2wSHKui2QvB3ylt/fS1TdEwTIjpX
	0Aa2d7BbhbNB2DmAnE2z+TOIxKW22Iqkp9tKEfKKZQTAd/R4U=
X-Received: by 2002:a05:6808:178d:b0:45a:9068:642a with SMTP id 5614622812f47-46733506ea9mr429126b6e.35.1773188915884;
        Tue, 10 Mar 2026 17:28:35 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e72b40asm516497fac.20.2026.03.10.17.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:28:35 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mt76: mt792x: fix mt7925u USB WFSYS reset handling
Date: Tue, 10 Mar 2026 19:28:25 -0500
Message-ID: <20260311002825.15502-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311002825.15502-1-sean.wang@kernel.org>
References: <20260311002825.15502-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9509259CAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32937-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

mt7925u uses different reset/status registers from mt7921u. Reusing the
mt7921u register set causes the WFSYS reset to fail.

Add a chip-specific descriptor in mt792xu_wfsys_reset() to select the
correct registers and fix mt7925u failing to initialize after a warm
reboot.

Fixes: d28e1a48952e ("wifi: mt76: mt792x: introduce mt792x-usb module")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  4 ++++
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c  | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index 7ddde9286861..d2a8b2b0df32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -392,6 +392,10 @@
 #define MT_CBTOP_RGU_WF_SUBSYS_RST	MT_CBTOP_RGU(0x600)
 #define MT_CBTOP_RGU_WF_SUBSYS_RST_WF_WHOLE_PATH BIT(0)
 
+#define MT7925_CBTOP_RGU_WF_SUBSYS_RST	0x70028600
+#define MT7925_WFSYS_INIT_DONE_ADDR	0x184c1604
+#define MT7925_WFSYS_INIT_DONE		0x00001d1e
+
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index a92e872226cf..47827d1c5ccb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -224,6 +224,15 @@ static const struct mt792xu_wfsys_desc mt7921_wfsys_desc = {
 	.need_status_sel = true,
 };
 
+static const struct mt792xu_wfsys_desc mt7925_wfsys_desc = {
+	.rst_reg = MT7925_CBTOP_RGU_WF_SUBSYS_RST,
+	.done_reg = MT7925_WFSYS_INIT_DONE_ADDR,
+	.done_mask = U32_MAX,
+	.done_val = MT7925_WFSYS_INIT_DONE,
+	.delay_ms = 20,
+	.need_status_sel = false,
+};
+
 int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 {
 	int err;
@@ -254,7 +263,9 @@ EXPORT_SYMBOL_GPL(mt792xu_dma_init);
 
 int mt792xu_wfsys_reset(struct mt792x_dev *dev)
 {
-	const struct mt792xu_wfsys_desc *desc = &mt7921_wfsys_desc;
+	const struct mt792xu_wfsys_desc *desc = is_mt7925(&dev->mt76) ?
+						&mt7925_wfsys_desc :
+						&mt7921_wfsys_desc;
 	u32 val;
 	int i;
 
-- 
2.43.0


