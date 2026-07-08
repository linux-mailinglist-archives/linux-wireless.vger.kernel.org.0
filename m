Return-Path: <linux-wireless+bounces-38781-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ROOYAM8ETmoLBwIAu9opvQ
	(envelope-from <linux-wireless+bounces-38781-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 10:05:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49533722F41
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 10:05:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eyQhiXPz;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38781-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38781-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD2D319CC29
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36D3B0AF8;
	Wed,  8 Jul 2026 07:56:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2D296BAF
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 07:56:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497367; cv=none; b=F7IBu8CdB7MIDVXBY2InTV5TUfXLes9fD2Wan0Ft5JoEynQS9nnMgUaRDrplCqKWq+i3NyP45FMzhpxmR9kIWKSqJAe0rVGeja/C/KKIMx2lkOgWalFhyq3bKqV1OiTzzEOC7B8LAgtPivD23gDJT6gjzztQ67DKCsUIkQtr1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497367; c=relaxed/simple;
	bh=ZeXzvePH9oZZ9twgZEIFCMz/2JQVf3A/LUvz2ytug7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ex6raEgmfXNGt/2YFA/LneyU4HMfpeZzGju9l2LhZOmpLKKgD/shZE2hP7fNijqIZaN0BEyWzSmrvxGwY75s8G1BZrxBieRFcarQ5WCM8PTAdk+S41htMdxC0d9gI6mo5OWnc6rlf2CmAd+H1DhkJHTttuCKN1XLdQBADmkgerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyQhiXPz; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84830c774a0so344789b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783497360; x=1784102160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u7omd6J2J6sDKoi1bxgaYKfVCN67GZzKzySVfWVBIZY=;
        b=eyQhiXPzo6oyeoPEG95oYpfc5PqeGWyQtEhjUHPw+MO9fdyF8aivm6GVIqPwzr3mP5
         D+8M2aMKN84LdQKXt7vHKh5mlYKtoZ9KXOFNxP/XQQ7L7rjQErKv9HIX8SgorZA1njCu
         QhDDgcL4Cb094HAY+qq0P3CtD+TjiLxUWHA76nQcF97968rpevQzW8jVKBvlYU5urwn6
         Gmqi4Mfet8VRG03HiYTgauTRWpj63guNV3LykmrvIO7aCPH+Wnm4VGleDW//OobQ8s4G
         VTPjQoI7ShShgFv27BiEBZO3ZB0jOd48yHM6JCMzb7qQP2eKMSReQjIlc/Q9iozCNFgR
         n4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497360; x=1784102160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7omd6J2J6sDKoi1bxgaYKfVCN67GZzKzySVfWVBIZY=;
        b=LLPodOLa1op2URVKSNIRgwRQdatPD6mMyc8vgYhXB895vSFoTSlccHGiMUbNWVPDvk
         g5vRADrvyixEDM8BNvd0wefX1l+XS5cPGQNixlz8MxYPK2azPLClW6RFr1+0O/95Pshq
         eerLRqGpxn9AP7RFg9k1vOd+cxAQOHqxQY17R2yD9C8DNfxWPW3zvXh+4+LQDAxj4Vun
         RKJcxmB2TzHJSXMo2AmtPj47JMTB/nWlO1DMpJa5KNbuEL/kSq5T8rv6vCZtVzY4POJz
         SJRomsQXUgH5OwHLYJsAHq+scpo0xObXLaIHd/XEeUS5wfw3az89Z4WTj2AVboJM2SYf
         +5wg==
X-Forwarded-Encrypted: i=1; AHgh+RqIeeu3UnYUbR+PvOQlD8oUsJ3b/vT/1mEpvJJ2ZqvLMiGa44PtJTKep3imaQOcign5FsHO9KJVqZtKogbEBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fh8IxasSA84PfWEZodTMVKzL5MTxDefdrNZ5vHpEMD8M+rPg
	s3Ft4eEj+jbKp1+cEwU+OVQkARIeg11i6dHJ3B0b3OpMfXsZ4LHqkUG2
X-Gm-Gg: AfdE7cmcy5o/fSeivr0mbKPapIFylFC+HQhWZjBGSp3To4aRHOADjSzTyHMCLVicLbh
	rOZqg9NAHwm7cyZj7K+LbY344ZeD+YQM2Vd9FX8SqZp31Z+D2azrUbXgUEwpbfoyx8Jre5Xdkw9
	UacuVRpdNeJuUCwJficyD5OEL9bfmEjyKhZFeyRuD0F/XWB1qj+rUi21aiDaKNiE2ewRQhrwecc
	kC+cQeD6MTyzNOcyCZMTBcDxu/GUXKKkHj3vLzI6H7i17tTbI/fNpLrMMbV2lJ4/t72eFKEMI8t
	yXrRa8sUuD1k4Ch5GllctTgt5XXgNkm76L7rkT3XuJP/okO0d85vGZpoO+SSXjinZN7TRSCnkmM
	eKJRwEc7EHosrzxflaUVdwJYYZu+WBYIut2jCsfnxEmyq3sHVkMytGoM8VK7nvO/QmQ1xZ2wB1T
	UxCP8jHAWAgQ==
X-Received: by 2002:a05:6a00:928a:b0:842:4f20:53ff with SMTP id d2e1a72fcca58-84842f9f153mr1982201b3a.42.1783497360063;
        Wed, 08 Jul 2026 00:56:00 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d496besm6668958b3a.36.2026.07.08.00.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:55:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Javier Tia <floss@jetm.me>,
	Leon Yen <leon.yen@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] wifi: mt76: mt7925: guard link STA in decap offload
Date: Wed,  8 Jul 2026 15:55:39 +0800
Message-ID: <20260708075539.726200-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38781-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,jetm.me,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:mingyen.hsieh@mediatek.com,m:floss@jetm.me,m:leon.yen@mediatek.com,m:deren.wu@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:lgs201920130244@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49533722F41

mt7925_sta_set_decap_offload() iterates over the vif valid_links mask
when updating decap offload state for an MLO station. The station may not
have a link STA for every valid link of the vif, so mt792x_sta_to_link()
can return NULL for a link that belongs to the vif but not to the station.

The function currently dereferences mlink before checking whether the
link WCID is ready. If mlink is NULL, setting or clearing
MT_WCID_FLAG_HDR_TRANS dereferences a NULL pointer.

Skip links without a station link before touching mlink->wcid.

Fixes: b859ad65309a ("wifi: mt76: mt7925: add link handling in mt7925_sta_set_decap_offload")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a9059866b701..2b6cc8e253c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1713,6 +1713,9 @@ static void mt7925_sta_set_decap_offload(struct ieee80211_hw *hw,
 		mconf = mt792x_vif_to_link(mvif, i);
 		mlink = mt792x_sta_to_link(msta, i);
 
+		if (!mlink)
+			continue;
+
 		if (enabled)
 			set_bit(MT_WCID_FLAG_HDR_TRANS, &mlink->wcid.flags);
 		else
-- 
2.43.0


