Return-Path: <linux-wireless+bounces-35652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P2bCaPh8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:59:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DE449D6E2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 976D73049948
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14F363C74;
	Thu, 30 Apr 2026 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="jjOrYJ8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AC367F51
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525024; cv=none; b=PZElDWYoewW72UDh1Qb+dru0KgCgkqtFjZjuMJXPIMLnhikYMYN/qXHzaxh1B0M5Ej4IEIoqnmOhta6BPK7c8A1ppLKIeALP1xDCz3cgRaP3AJEWe+awtTSsXbTffEWB61k4ylARwu1+bXMyqUaCPeEkmK51ed8lcVM74+D210E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525024; c=relaxed/simple;
	bh=9TyB8vv5bdZStr/Q1niVBjRaeWUcL3/nyNMQiiUXakk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/8/nPrbCHrS+MkCmratDJo5j8uHs2E1maHbWnFs3gAyTiqqyOvKjlGtaOrRlXpcDGKR4hX+AZK61rVxhEJtkmeTypGj3U0lhtM1RhcScC58S58YWo/Dc4/V+xgy4BUxYD9l+ow9CDSB5kHryeX6qx0LR5qYAHt4yHn/QB9kR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=jjOrYJ8/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so225197b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525022; x=1778129822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVCjz/fVhCFpjcMt+RPvID80Nomp20lkcFEvzXdhCJA=;
        b=jjOrYJ8/+jMN13F12diwGLblWvZyKJgCyWmLYhamQSBOI2UJ4mDNOj0OOSW1UTBs5n
         +tgwBHXhDSjgXG8Yc6Nb9m6o0zuhrCaGMI49Oa2cWPk+5/2sx5saASuH+QmM/+Sq9Qnb
         mnz7pd0Dpc4Jwz1USR5QDkfgLcZPrjtqzyR/Pkukf3yF/NhpDIZubJ2huwrQsDpRRYC7
         znzVzX71A7385b4M0eEZnCObjRdHU4fdHPd6givyE5csuV+l1Zs+WJiBgZpnqkhv6fw/
         k//qRBZB0jj8KQOCSHQqJEQfjM67kScdZiPWCOvh/t6rFzvZnjLtWu4cIswRRnXo+D6K
         BhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525022; x=1778129822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVCjz/fVhCFpjcMt+RPvID80Nomp20lkcFEvzXdhCJA=;
        b=V17KF13G6x/43aBYchXVQunzjSPseiZJRGyOeIRMI9Rmq0ObOoCpMuba55xckMoyJt
         uTvA4nmOwgFZ4/aTBHVxV/K9Z0UxwIpucjOrlPZTc2HNd2u8rQOwnc8FG2K6BBiZUnnZ
         iL9vw2Sl0YZHv7Du95qPGsN7iY8rAEr9a6j37x1OjU6fcYskOPDLBfV710druM3hhLPo
         x4vFBlULY9C/bTiirKVb9nd2VQRJe6GQC5tWxjYoe7uDZAh4mHLLAf7QP64zKuGj4vkU
         nvYj8skg6mvpDmO2e+kt3vku1Asb7NhSOHCw3ohKRlvA96N2WtYwseCOkL7xgM74VhN3
         o2vQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZJqOwRvd2J9AWygkvY9fl+8aH6HcQneI6JAtvfh0NXWUjhLFyZ3aT17vNPz+ouZ4oVcsnlBaD2Hs5vuSq9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nO7aYS9hzWRTaLAiaja7YGUN6sCbrcEONCk/XPs858miwyE1
	QbuuU123dIgCLMWwAaPIcA2CogAj79Vw7ku8fK6sFFmtbv/pSFMB2FC4u1HpKMRG8G8=
X-Gm-Gg: AeBDietP46UEJeWaMVXoXU4cjnpBZszcRU3ld06c1d0dxhXp1Q1CRwJTW8PHKkLWecO
	Ll5e90AsJD6uJXC9tA6VnLVdpl3KnKVSQBY0A3+cmmoPR2YU467H6ntNDwjIdj0W3H1s97NlknJ
	sec/Dvls0es3AKWpbEXLoU0HElz3GZsvgcwyMslmaiLhM8JaH5ALZDdNh2GotfmQKUXx4BJUocf
	tzSGwvAcQDfFqcwfYRWC4UUv9Q7CtaHxF/G9ZGJETHdSW8+s+or8YsG43D8k0komEX7G48KHMTU
	tyQKl+PQ9VOprRoPinz01obarG1O69cZC9ZnVGKdM7o7BYaKEVBWU2ExpaSZCqmLDNh2s0Ktyv5
	TgDa9f8s5tVD5Rwy2vbxZooHtRajQ5cWB5MCJddxvcwb+viUUmHdn7h6jrpZLPH9EtCbLVwPRJK
	knFfJnemAm0DJ8U17T3Ad6f6BrUGHqhwSgesPh5/YcPm5svB9qarmVg7nPLMtXaWFwt+06V54BD
	v+8OtyEeU/qbiIfFMnlt/2lZNtcyO49I6i7IdcO+w==
X-Received: by 2002:a05:6a00:2441:b0:82f:6be8:6c0e with SMTP id d2e1a72fcca58-834fdc8d5d6mr1686595b3a.45.1777525021994;
        Wed, 29 Apr 2026 21:57:01 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:01 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 05/31] wifi: mm81x: add core.c
Date: Thu, 30 Apr 2026 14:55:31 +1000
Message-ID: <20260430045615.334669-6-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 85DE449D6E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35652-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:mid,morsemicro.com:email]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/core.c | 146 +++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/core.c b/drivers/net/wireless/morsemicro/mm81x/core.c
new file mode 100644
index 000000000000..b08f52921525
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/core.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/module.h>
+#include "core.h"
+#include "bus.h"
+#include "hif.h"
+#include "mac.h"
+
+char board_config_file[BCF_SIZE_MAX] = "";
+module_param_string(bcf, board_config_file, BCF_SIZE_MAX, 0644);
+MODULE_PARM_DESC(bcf, "BCF filename to load");
+
+static int mm81x_core_attach_regs(struct mm81x *mors)
+{
+	int ret = 0;
+
+	mm81x_claim_bus(mors);
+	ret = mm81x_reg32_read(mors, MM8108_REG_CHIP_ID, &mors->chip_id);
+	mm81x_release_bus(mors);
+
+	if (ret < 0) {
+		dev_err(mors->dev, "failed to read chip id %d", ret);
+		return ret;
+	}
+
+	switch (mors->chip_id) {
+	case (MM8108B2_ID):
+		mors->regs = &mm8108_regs;
+		mors->hif.ops = &mm81x_yaps_ops;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
+static char *mm81x_core_get_revision_string(u32 chip_id)
+{
+	u8 chip_rev = MM81X_DEVICE_GET_CHIP_REV(chip_id);
+
+	switch (chip_rev) {
+	case MM8108B2_REV:
+		return MM8108B2_REV_STRING;
+	default:
+		return "??";
+	}
+}
+
+static void mm81x_core_init_mac_addr(struct mm81x *mors)
+{
+	int ret = mm81x_hw_otp_get_mac_addr(mors);
+
+	if (ret || !is_valid_ether_addr(mors->macaddr))
+		eth_random_addr(mors->macaddr);
+}
+
+char *mm81x_core_get_fw_path(u32 chip_id)
+{
+	return kasprintf(GFP_KERNEL,
+			 MM81X_FW_DIR "/" MM8108_FW_BASE
+				      "%s" FW_ROM_LINKED_STRING MM81X_FW_EXT,
+			 mm81x_core_get_revision_string(chip_id));
+}
+EXPORT_SYMBOL_GPL(mm81x_core_get_fw_path);
+
+struct mm81x *mm81x_core_alloc(size_t priv_size, struct device *dev)
+{
+	return mm81x_mac_alloc(priv_size, dev);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_alloc);
+
+int mm81x_core_init(struct mm81x *mors)
+{
+	int ret;
+
+	set_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mors->state_flags);
+	set_bit(MM81X_STATE_RELOAD_FW_AFTER_START, &mors->state_flags);
+
+	mm81x_core_init_mac_addr(mors);
+
+	ret = mm81x_core_attach_regs(mors);
+	if (ret)
+		return ret;
+
+	mors->chip_wq = create_singlethread_workqueue("chip_wq");
+	if (!mors->chip_wq)
+		return -ENOMEM;
+
+	mors->net_wq = create_singlethread_workqueue("net_wq");
+	if (!mors->net_wq) {
+		ret = -ENOMEM;
+		goto err_chip_wq;
+	}
+
+	ret = mm81x_hif_init(mors);
+	if (ret)
+		goto err_wqs;
+
+	return 0;
+
+err_wqs:
+	flush_workqueue(mors->net_wq);
+	destroy_workqueue(mors->net_wq);
+
+err_chip_wq:
+	flush_workqueue(mors->chip_wq);
+	destroy_workqueue(mors->chip_wq);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm81x_core_init);
+
+int mm81x_core_register(struct mm81x *mors)
+{
+	return mm81x_mac_register(mors);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_register);
+
+void mm81x_core_unregister(struct mm81x *mors)
+{
+	mm81x_mac_unregister(mors);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_unregister);
+
+void mm81x_core_deinit(struct mm81x *mors)
+{
+	mm81x_hif_finish(mors);
+	flush_workqueue(mors->net_wq);
+	destroy_workqueue(mors->net_wq);
+	flush_workqueue(mors->chip_wq);
+	destroy_workqueue(mors->chip_wq);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_deinit);
+
+void mm81x_core_free(struct mm81x *mors)
+{
+	mm81x_mac_free(mors);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_free);
+
+MODULE_AUTHOR("Morse Micro");
+MODULE_DESCRIPTION("Driver support for Morse Micro MM81X core");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.43.0


