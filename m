Return-Path: <linux-wireless+bounces-31998-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNzOBQVclmkdeQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31998-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:40:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723915B341
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 584E930360AB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162D2210F59;
	Thu, 19 Feb 2026 00:40:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C051F419A
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461623; cv=none; b=rKSgNBUhVquInP4KYxbFrflcchyIJ8djQxcIy5nYGTLKpDjrKeVESNdsNK70icX9hZMHqSvXPxjS5I0rVBxpKlu4wKbXyHwUa/GE5bv1SSD1PO+qX5Y5KIxiiMIWgJ/UCYs4zfFWlFlKB8psaOUla2FGrZlKlBCYhCnhb99IinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461623; c=relaxed/simple;
	bh=5AP7+KaIqR521ARLdBlzVBlcDnNibU+nbtqh0sjH7Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuVYiIOoJ8ml2Mfp4jtUMccFt2A97kGukHiF794Uih3MD29ktdtSQ7qM3kBe/Y/Wi75tT9vf/L2ZbJ82BK+mjW2yiw5SNgH94zfHHYJk5jupxrRbhNKKdeyN2utgMuPoi9SP7Db3Yb5XxEZOphX7x28UExHlVKs49JNJEGS2ZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40f387a688dso293689fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 16:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771461621; x=1772066421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXfVeHyX+vnFiRwnw/g9U5y3U00iL+2V2iXWuqTDgPw=;
        b=hGqdbLytLUiCM7q0jutytR8qWkbKoWRJQDLEU+g+w9Iz6Pk1qIU1OG4idgnFCzP48E
         OuJlJAXX9JqIAZJW5vuQeOOiUMeYTXQxqmu2YSbIjv2OIPvQVUeZlrHHcSkf3mHL6lz6
         quwsgR7ZVFsYGi5OYRBFJQazqdZGWZTO9NPPsd2lqQR4h53BUbIf9+OFpoEvfyTm00E7
         As3iatp/z1wQznbyX/kOvc9bB/CEyDKk8Lj+eIZNPc1S73RihrXaU1Wxc5W2yLpN2oAF
         ddlZQl19yoZtKugeBdwbao0G6XV17K3/mx1Oiac6xllz9vC8ykIVz1ACOjg6Wf1C36ps
         GmNA==
X-Gm-Message-State: AOJu0Yy7pc74qlx99va1s1tvyZS/R13legbbQxrJL4OaziBQl4rvTUWI
	Z/X0ghKPH/HUFwL9uluJr4xgGzCPfoUQtcmlapX66bOuasacsx2ccGCX
X-Gm-Gg: AZuq6aKIhpFJ5/315JfsibcHrLSsC6KQ/AD6jcn/v+DvAGl9lc31JzElx72CC2i3Ml+
	02vh7ISvzqSyL6dWE39Jklv8JC5BuYfFUiMwKng8J2GXDtLHK1nsjmvdp3Crjbd8u5kIVMF/J67
	QLrBKjVgVLcFAhgp9kxvLy63blfGx4IwhDPtdMzXGj9Mp4eTrWufG0QxEC9sajO+HVhvQKsCdCn
	xPlzp84iIjuaZRHfaPDcMyK3a/iL9CA8pUyWj814dLXED00ofQYfF1gCqH9B/OVysz62GGWzpAI
	kUBLFNWYSmvDm/xkYdiMIAmc8BGIBfLtRNXU+QJhvgvRoAjEpP/rtcmtAoUc/wvdUXK1y7XdHdy
	C39O8H22NXJ0pVWjg/BGMokqbPVqvBcmaDsF607sngDh5xn647PMvqKEWVs2ncnViPZA2ezk+oC
	4Ca6hoqgTFi+RwrnKTcmLYRp302yRqrjKPIY+8KvKfBT1Phvs=
X-Received: by 2002:a05:6870:1741:b0:409:7fab:e3fe with SMTP id 586e51a60fabf-4153a148ad4mr615569fac.50.1771461620588;
        Wed, 18 Feb 2026 16:40:20 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm23477659fac.1.2026.02.18.16.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 16:40:19 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Xiong Huang <xiong.huang@mediatek.com>
Subject: [PATCH 05/11] wifi: mt76: connac: mark MT7902 as hw txp devices
Date: Wed, 18 Feb 2026 18:40:01 -0600
Message-ID: <20260219004007.19733-5-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219004007.19733-1-sean.wang@kernel.org>
References: <20260219004007.19733-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-31998-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8723915B341
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Add MT7902 to is_mt76_fw_txp() so it follows the legacy TX descriptor
path like the other connac2 chips that return false.

This is a prerequisite patch before enabling MT7902 pcie support.

Co-developed-by: Xiong Huang <xiong.huang@mediatek.com>
Signed-off-by: Xiong Huang <xiong.huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 02bea67d37c3..d868bb7c7ab8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -271,6 +271,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 	case 0x7961:
 	case 0x7920:
 	case 0x7922:
+	case 0x7902:
 	case 0x7925:
 	case 0x7663:
 	case 0x7622:
-- 
2.43.0


