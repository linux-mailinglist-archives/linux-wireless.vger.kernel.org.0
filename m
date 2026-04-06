Return-Path: <linux-wireless+bounces-34383-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CV6ILv/02lypAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34383-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:47:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28D3A65C0
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 20:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 994953031F1D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 18:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0F39769B;
	Mon,  6 Apr 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+D3/Ka3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88E396B7F
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501181; cv=none; b=SkGH/Fhlvtiqg1q67HMbmmMhtNrUn8ZkqCa8SaI8a6OsemEYrBZtkrUvXKp711yvdtK0JKj1lbP3AAm+BMjtbM+M/TdTnLnAUzfGes68Qz9o16Y1NxLWlL2Bnn4UVAFMZF/k+YuhAf0wjPhfcFNOeQt+BKg9J11exXFdbo35KWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501181; c=relaxed/simple;
	bh=TodaMl53UO3CirNfBGxleA7KOIefYV/SEGEFmuQG35s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lziAqKzfdVe+An8z23t8Qgfpm90yRJb6k+VceVu4U5fipSI+PGCkzzXJzxPX4AgKCqu3KkTREVmt3YzJQh5Syy8EQASfl7BL1h6JLD6kDApE3rvBpjUKjtr6Nla8yeev9y8yYZz5H2Q9leJB7SrlRfVoAQUwZ2M4/ztI36ahpmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+D3/Ka3; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79853c0f5b9so70275127b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501177; x=1776105977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZPzCplQeYw4HrNPe0mY3COLB2w8pgJ3gstqK4owbOE=;
        b=I+D3/Ka31lJe14KNDtXtxVBdyUZGN3IngJkpE/lGeZpLAoeecfnwGHyDunixTtSk6c
         Xir48p2sPXV+8HKU5W5pvGvy1+BlyBBvmVYpBnZdaS6q1/Y4QMGub2VHN1zC4C3a/vPu
         vP4C3drzg3tkRisCwiFtkSfoHv5+VCAAr1u0wO8YdVtBuaQcL2YNw0hp7DaskXZ6/zwK
         uZUb9UWjFJYF4u3+7eeHCX6nD8zcxelz1j3/04XYfz3czPe+MMjPk/8b75Qe51MUHdAL
         l6orLGKoEk9rP7QOthvd/ZV7ZDF/CLWDVRofgiov8h/cTQYVnAS1jxEWoARbVn59DlSR
         El9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501177; x=1776105977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZPzCplQeYw4HrNPe0mY3COLB2w8pgJ3gstqK4owbOE=;
        b=Os/K96/WI4K6mM+bBeIIpWvGomBiApzfff0cBBjsFBN/Ye80A0zJWv4x4N5ysBRnCu
         AYPO0gqTUoeNaBWW/SmFw70TsRaOpO2SdC5E6H5Y1AHIXLWeVnxFIPMr4QaMFkFDIYST
         QcrK+KrlUv2vJWi4ePYVU45gCyl0SJ17WGLjGBZRjkOjYSDcIK4ZLq0aBCcYjx7cI6fZ
         c/ESgj0ZR8o6kH/xuE/TUVvniU28nEw/K88smhJbJmYf8LjL4ahvnUZ+7dwlxwtegWkq
         FHwNrYW2ucfaReaqm+tJYt3qINvkuUPi26lg3jaFWPIT57YLGq4qpkrfpZCl9B3yuws3
         Dtkg==
X-Forwarded-Encrypted: i=1; AJvYcCXqwEU1RJHMKcr7JcUzy76WT8BwXYZOMDlG/+vdg5btb2ERCj/ohqY/QYVsHmZoepVYwgKYkQVU76wp0rkF9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50Qrj/tepuxasyw6emdTNA9iL9XCfoyrw6KfgC8jn5h8S9NZk
	51CfFWVFg3635rsJeEeW0BKcKGO4gK2l2aD9sv4giN0oqrJZaC82vjss
X-Gm-Gg: AeBDiesEQVMbI4Ghv5coWxLk6wcEFle5+MY7E5vXkvbGDKbEST1C6AjAGCaH1AQyks1
	NL0Qek/iCYbiphCGhSo9DN3hQKBMhmO0DtTvBugZqv1b80oXsmb88hFqKexZDq0xSKd/G/hs8JF
	EyB2BsCGO2enWKPVPVvBp30jjPdgRdkg5wLv7/6sI5HNWyOyQCB/h76LaYSP3G4OSx8jwNb0jRI
	vSxTR6E9ItJWy2jqErSNA6QSH/Ex/cynW8k/jgO26dMUpC3E2O66ai3n1H7XKtvyvJpaOeoFEjt
	duQg2XZgYLwkBuwPYQ7n5lAyjl8Wg74VNhkk0GsS3gXESfJaA/vWaypwkEG094C9SA+3b6kjJl9
	CEbvqCwRxKm3fhpcdW1jzrRcHpOrzODoM1Cht7ZFQrZRvN9flVZRhaT8Ydh9mQ4xEN292XbFkfn
	XB7zMM+Hgwli2di9VvGHZTE8bS3icZrr3M6m0TPH0ozwOnnpYdeVLoT0M8vUck
X-Received: by 2002:a05:690c:dc9:b0:79a:6751:1489 with SMTP id 00721157ae682-7a4d5c5bbf6mr138049557b3.38.1775501177568;
        Mon, 06 Apr 2026 11:46:17 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e8343d3sm56288377b3.16.2026.04.06.11.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:46:17 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] wifi: mt76: mt7996: fix DMA read beyond mapped length
Date: Mon,  6 Apr 2026 14:45:56 -0400
Message-ID: <20260406184556.8245-4-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406184556.8245-1-joshuaklinesmith@gmail.com>
References: <20260406184556.8245-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34383-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D28D3A65C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same bug as mt7615/mt7915: buf[1].len is overridden to
MT_CT_PARSE_LEN (72) but the DMA mapping may cover fewer
bytes, causing SMMU faults when hardware reads past the
mapped region.

Cap the firmware parse length to the actual DMA-mapped
length.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e2a83da3a09c..5c03dc163547 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1171,7 +1171,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	tx_info->skb = NULL;
 
 	/* pass partial skb header to fw */
-	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->buf[1].len = min_t(u32, MT_CT_PARSE_LEN, tx_info->buf[1].len);
 	tx_info->buf[1].skip_unmap = true;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
-- 
2.43.0


