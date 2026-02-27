Return-Path: <linux-wireless+bounces-32254-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDaIHTUaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32254-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:14:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 575CE1B28F4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6EB5305A840
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC80345CA1;
	Fri, 27 Feb 2026 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="2+fXrjfR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC91346A02
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165603; cv=none; b=OSGWkk93pYM6AzG+KgILm/RhS4ljuFHg0vOx/YAK5ZlNYuO4w7K4Pb1y7cXIx+H/me2X10FyyG2ZVbjeUC3Fu9RH6xD5FkKUX6q5gV5JBsLnyqvaHLl1LfheGKdbvCBOGjGJw59xr0XNyzaCn45UU/NQlvTdseaYRTYgh+KEaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165603; c=relaxed/simple;
	bh=dIMzBdG9guVNVeykWA+XSvLHadW/qUWAAao79xxOJm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHLbQWx5EVJO7aozrcf/DDw+TPSoZ/js8HB4GPuUwpfNGMZMuAmwsgQVcXJ63Gg+b4/OGuMVXsDkQ0tfvnt5CDhn0RV+T+P60n1jElqMfawu7zqsdv7gbK1MbK5NtM0VaUtIsn3aRlA7CuFWkA7TgJYL7UxtTXGRbDfoYhasUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=2+fXrjfR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adc1d9ec56so10950115ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165601; x=1772770401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT1jTRNPU1iGn5GPaWA0zPdi4nqppHZOXHEf82I6a+E=;
        b=2+fXrjfRsKenJsfkKTwKhjjyhZoCnYONr+AcqgTBy13C5oGL5c4ClP1Cv9sw/n0Yj6
         esnnq5JPM12deoQ10mSlcUHQIbEG+bdyEWmFeBR+FIM7ZoXyH9iU8B2PM9lSjUImgiG3
         IIB2OPTeqBLSVu1lKvjrh+I+3Z4w5zfchweEJyxVLv4cLo9sXXcEwQu8owNdlHATKtIV
         OsY2Gc5DyfRGgh7fNiTZSTVJYlEx2m51EDjIdgeNxVI2H6g3wSMZ3MTLrGUUvzXv9naD
         da8Ky2u42eYpcWbuC9Cu9Ri26Ba3HXr2LxHv/kPEbMGYqaqPrYx+TeUo5z3QLoBABA6W
         cs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165601; x=1772770401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rT1jTRNPU1iGn5GPaWA0zPdi4nqppHZOXHEf82I6a+E=;
        b=RTHxCKtceAQpZ8uJSQYKe27kgIu86fdPSiXH5c/ZtEGDk+o9/Ea1me/6h+dAoQnzXa
         iKlRWlJA/t1u8di+LYRpGLDWTnlh38yE0wwk6cCn9qvqr9+7MJZX2d0U0G/SQorA5Qir
         zBdpD4EOnwjOGboPeXKOFK+9iTleYsii49TzdcCVJ8yFfjDUzYlX6L2ph12SsAsbkknv
         yHCBpvb8GnMurQCdL1xeCEFg8QagksDJRzU9upg6R9ScP2iephJZcOp4n4M4zbitsWoq
         oVgSTTgu1/u11v4plRirQLOAc0oXg+RXt9AGjQl7+mBPR+6ecyBCMYosZTcYyHv2oSQs
         TRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSrJx0x85HUZyvYl336+/1zMr65q1YkHKpVqLlUH5orVwZIMVx/icboTP6WI40ZbDxMlg63EzjSoshQP17Rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRwVlL8bRJMTl3B90jb3HbCadIWVngNYsZbKmISAZnIducl35
	I4xU5icegq04saLPnCIC9UGFM2mJWgOXLFEJahzpYTUN/qN2p6vcqtO4O1jrvyLc6PM=
X-Gm-Gg: ATEYQzyA0/vAEbTo82EhL/QhZkpgcZ3Pr6yo7Rhasn2HAIdlOuAexTgBxIjvPfAAD9n
	Z4QkHUt+AwYn00gz7F6BekGs6fUsY4mxuN7QMXFlBDwIc14LBlo6ZtZo9uE4GVv9aKPmFUY3Jkq
	TyDqNwxgFIbMTCIN5pr9jobKstm0ppTuVboDBQVV3wJtj3vAvJrldM6z8HQI6hsI48o7MiI9Xdq
	VgYlEkvVlBmb/6BaGrbrlHp398HPVjyFMreE5XQflXxywpX+sadn9HeWJ4rHZyJhCtida+FAUAE
	NCY+mSGv2g2MlaJvil9cp0pX9SMG6NgbTxZ0VAgxM5qXfw/eA6iuVxgyQG4KFRkBgWui6WZeJnP
	RHAxD2TSo7FTTswXF2BPZM+LUUE//uBgk11yUzzWOMJfgGXIuRxsphL2+8OdGvZYZPuPQ1Km+fF
	0/r8wVXu4i8U4TEd2hitN2ct5wnmh6fqbrEJf5i9tmNwJRn2mw5J5Esw8JbqnoWo34By2oxxFb4
	SjeTIIj3lFNgApbwHAuAQkWWO8LARA=
X-Received: by 2002:a17:902:f0d4:b0:2ad:bdf6:6405 with SMTP id d9443c01a7336-2ae2e496beamr10496275ad.32.1772165601656;
        Thu, 26 Feb 2026 20:13:21 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:13:21 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 15/35] wifi: mm81x: add mac.h
Date: Fri, 27 Feb 2026 15:10:25 +1100
Message-ID: <20260227041108.66508-16-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32254-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 575CE1B28F4
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/mac.h | 69 +++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/mac.h b/drivers/net/wireless/morsemicro/mm81x/mac.h
new file mode 100644
index 000000000000..6e27ddf900b3
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/mac.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_MAC_H_
+#define _MM81X_MAC_H_
+
+#include "core.h"
+#include "command.h"
+
+struct mm81x_queue_params {
+	u8 uapsd;
+	u8 aci;
+	u8 aifs;
+	u16 cw_min;
+	u16 cw_max;
+	u32 txop;
+};
+
+static inline bool mm81x_mac_is_sta_vif_associated(struct ieee80211_vif *vif)
+{
+	return vif->cfg.assoc;
+}
+
+static inline u32 mm81x_vif_generate_cssid(struct ieee80211_vif *vif)
+{
+	return mm81x_generate_cssid(vif->cfg.ssid, vif->cfg.ssid_len);
+}
+
+static inline u16 mm81x_mac_sta_aid(struct ieee80211_vif *vif)
+{
+	return vif->cfg.aid;
+}
+
+static inline __le32 mac2leuint32(const unsigned char *addr)
+{
+	return cpu_to_le32(((u32)(addr[2]) << 24) | ((u32)(addr[3]) << 16) |
+			   ((u32)(addr[4]) << 8) | ((u32)(addr[5])));
+}
+
+static inline struct ieee80211_vif *
+mm81x_rcu_dereference_vif_id(struct mm81x *mm, u8 vif_id, bool rcu)
+{
+	if (WARN_ON(vif_id >= ARRAY_SIZE(mm->vifs)))
+		return NULL;
+
+	if (rcu)
+		return rcu_dereference(mm->vifs[vif_id]);
+
+	return rcu_dereference_protected(mm->vifs[vif_id],
+					 lockdep_is_held(&mm->lock));
+}
+
+int mm81x_tx_h_get_attempts(struct mm81x *mm,
+			    struct mm81x_skb_tx_status *tx_sts);
+struct mm81x *mm81x_mac_create(size_t priv_size, struct device *dev);
+int mm81x_mac_register(struct mm81x *mm);
+void mm81x_mac_destroy(struct mm81x *mm);
+void mm81x_mac_unregister(struct mm81x *mm);
+int mm81x_mac_event_recv(struct mm81x *mm, struct sk_buff *skb);
+void mm81x_mac_rx_skb(struct mm81x *mm, struct sk_buff *skb,
+		      struct mm81x_skb_rx_status *hdr_rx_status);
+void mm81x_mac_beacon_irq_handle(struct mm81x *mm, u32 status);
+
+u8 *mm81x_hw_scan_h_insert_tlvs(struct mm81x_hw_scan_params *params, u8 *buf);
+size_t mm81x_hw_scan_h_get_cmd_size(struct mm81x_hw_scan_params *params);
+void mm81x_tx_h_check_aggr(struct ieee80211_sta *pubsta, struct sk_buff *skb);
+#endif /* !_MM81X_MAC_H_ */
-- 
2.43.0


