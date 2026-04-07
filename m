Return-Path: <linux-wireless+bounces-34396-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBEyMtZM1GnvsgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34396-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:16:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EC73A863B
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF5CE302E786
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CBE1C5F1B;
	Tue,  7 Apr 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuJ7lmTn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F51A08AF
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520946; cv=none; b=UQ7lSMitG61YRJa3sEbNTgjDDc1UF+jmmmmIjKYng2Mdw/oGC1KnTteU9oaigdovnhBGefYfgFuYLsQSO5pf9svdBGzhJfqXiZm0Tm4eQrfYg1aUcAb7tczGv2/AWsClYCZAZ7SZdqAzMUa8M0CuRrtZLspoMx2BNccfBT91I2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520946; c=relaxed/simple;
	bh=WYY0327PGP6EmPVdxZ/UKxYSGwk28K0MY8yfuwYdQVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfYog6YB3ARMy2eTAzTknvPPioJYz9GUpk0Abet/yZK82MsbsvS1BeaOOqMasYXFBRdYOUDeyIQE4Jy8d59AUP2grCMKUGNu4f+9nTyacpPK5Hzl15haubwRIR/PG3Ofep9XwkyhKq1PvMFG+m7HS1DTHDvryjyic6nP0Tjd6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuJ7lmTn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fc4425b6bso41361127b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 17:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520944; x=1776125744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax4QSQrnjy0pjzWmEl9UqqUoL/S+ZOGYtKORago0N/M=;
        b=CuJ7lmTnjhy+m9/mkw2aTco/SkBdUZOQiUdXZ6YHNvwOsqNeSvdiUI71bwrZVoawNC
         yyRDffyz6rW252tJ2O45y7026JjbpaYGAsScNucs/Jq2BqZSBEURh7Qle0df2tkNy3TH
         UFB1BE56irV7pQeOr023G0fCOy1Iq30rL7gXSyn8LaoZiRWtozUripc+5qxtWY+jEnBD
         vl6ejClo5VpcmG2XcxzghZFdDASRYm3zXLzGQUC4shAwIDO/RPq4k9QQ6eWx9b5/WBqP
         WcBWqtz+yre751MPyyWq7kL6tYt0o0GF3tQaI1E3PLra6z3Zei8hCWLBlMCsie2mVJ4m
         H0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520944; x=1776125744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ax4QSQrnjy0pjzWmEl9UqqUoL/S+ZOGYtKORago0N/M=;
        b=bWuooQV1GPtvby3x+gWphpMSM2j+4BvKCzwJOiUZ6sAqvZZTyFlZSDQmdoDPNd8fon
         IT4lss71wiutIp6mEeN34fbZtU/wl/RunJ9QLRuf6CjoU1JlzAw4vGxlK+JNPYisJWXn
         RUVDF049CSy9cNLwPZ3lmhH3VcaC7x52hyGqQIsoRZP5u0i53ii2b9pPTrrGTW9tOWZF
         MmsIWBmc6Awi3YC9dbxDBnEG53c3lym26/0Xu4GRqg8vxJqr2t2ayGaaVQ3X7oiEg2U3
         oaGGLmyAAXpR3Z2i5WC55RL9LUGlwxt+rN3xpcWISM7koHw1sE5BZxa34/qB3HZnC3G1
         ergw==
X-Gm-Message-State: AOJu0YzO6WAZWKInwSRGC+2OZmrWwkDKPFE/t3Q+2cExWioNcJl0Jcl1
	bFQgTveUqcT8+Id6qNdmWshpfBUxoOAG96d/LuoZ0I3SWm9l2BzyV+yuxxRVOMo5
X-Gm-Gg: AeBDiespEkUhGNyybYlR+kmgtVHYLgqg1fQ3/2U9PY0DMAoDrnjw4qs15dPlM9s+rAv
	y8zGKq1AangLKsWt/ob3ChCaTasqD/4YYadUXIWBcuBE90ZDRJoOBraJRrs2wGRsv84THxrzuqB
	NUgk7dGN7zBeTuGnjHxInVXhQm7MNdbuyv4uV3ZxS47jkkG9jbY1sY/N0IDPCrrrxcXH9PEWXiE
	hX3JzP9aqhIiYpLkjV0WJk26pjJ3JqNufsoZebJB3Mxf9xWLmlDz3bgMasaO6PBHJIrcoGb9F28
	edzIz/pK/YQnxBxTNMMIMJJWYEQ3JJHrtdfgReNl14dmzVrynYiuT4K28KQkYP6SnP+IiKRLX8i
	SfRr3zgpiAfwW0/88ELAE63wi/l0SADbPngue4oOZX1T/4ySHDJpiXq3G4bi0lOpYICu1fdecYi
	R1UUyIWm7OlYci81rVlvsb1NheI8jR/9m3xi87s6eL3mXkzAuI2WT9qwXOLwox7b3dcodHpB4=
X-Received: by 2002:a05:690c:e3ec:b0:79c:ff02:a03d with SMTP id 00721157ae682-7a4d35d5df3mr150303367b3.10.1775520944129;
        Mon, 06 Apr 2026 17:15:44 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e320670sm59858877b3.2.2026.04.06.17.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:15:43 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 2/2] wifi: mt76: mt7996: clear cipher state on key removal for WED offload
Date: Mon,  6 Apr 2026 20:15:31 -0400
Message-ID: <20260407001531.31207-3-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
References: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34396-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50EC73A863B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same issue as mt7915: link->mt76.cipher is set on key installation
but never cleared on removal. The WA firmware retains the stale
cipher in BSS_INFO, sets the protection bit on WED-offloaded
frames, and drops all plaintext traffic when encryption is
switched to open/none.

Reset link->mt76.cipher to zero and call mt7996_mcu_add_bss_info()
when the last group key is removed.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f16135f0b7..d464fc3d90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -249,6 +249,13 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	else if (idx == *wcid_keyidx)
 		*wcid_keyidx = -1;
 
+	if (cmd != SET_KEY && !sta && link->mt76.cipher) {
+		link->mt76.cipher = 0;
+		if (link->phy)
+			mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
+						&link->mt76, msta_link, true);
+	}
+
 	/* only do remove key for BIGTK */
 	if (cmd != SET_KEY && !is_bigtk)
 		return 0;
-- 
2.43.0


