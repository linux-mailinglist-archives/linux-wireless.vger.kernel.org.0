Return-Path: <linux-wireless+bounces-30257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1759CECD79
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47B9730050BD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD17220F47;
	Thu,  1 Jan 2026 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7urXbuq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEB21638D
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248718; cv=none; b=Dt/zRk1HqOVmpexDThhhCtRUdrSjXv27QpR7p4NJq5CpeekVnJwxdKf1p/4ooKdBtm4jwowM++CkcDmrXJl2rz+fw8mRC787T4axgKkLJRuN+ByRmm+YNrSMp993U/nZA1+4nsmNvNhfLQSUeq1uNoULjFaM25axCtGyKfRXU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248718; c=relaxed/simple;
	bh=Znx4XdDFbaaXsvMzlTu3lTOEC5ZaP1cW720DRtkMXuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnFNviZquL5VfqVfY1Tk62lTarnwzkeZSxpPpB2ss8NhZ0/FAgcJPm9kGrZ1qBVi67oLJiM1fqWSSAGKA05pL6m0MuVpGOSHL2bcOqDqjg+NQ47jKGcAwDQWjC/V8CmaM5/8mjCVdFrMDGvUc9pON6aJwcdrVk/kl2k7cVkdVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7urXbuq; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11beb0a7bd6so16167210c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248716; x=1767853516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qcRd9h55YHEi++sX8o5tkpOMIfr4fzGABHLci1bhHg=;
        b=B7urXbuqyEZ4X4m5nrrNyzaeA5BZh510LrXIvwI2kW42dVAkbn5y2ip0vYsdNby+mJ
         +L2hH5apgYdoSg9cfkFYfm/BDzmMpNBsZYrH9GUsC+6uFLjPaUET82m6hCuFE2SLM0pE
         IkxFFsRAz0rQjGxBOEUzroFzb+qiLLiSklYHrwjasn0quZ4/6HQUh+XaPiZ+e5s9+QEN
         O1u8RaC2n/OzQoWqnNZkJeJiCnOaHuEBrfulK7h+a3U7WkiiQPS1t1oiHcbrr06pZohv
         lecjzeW0N/hlyj8K1gH4Vuz+wDcAtJNzmb+cD85Z8UItguGn2sFsMaIvep8KuYGGL91X
         9eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248716; x=1767853516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qcRd9h55YHEi++sX8o5tkpOMIfr4fzGABHLci1bhHg=;
        b=aRFNIEOLiQG/qHwO/amlIRH+Wrg+wHA9T/9EQytY4zUi6AFzg1yBimkDXNwi+9EObo
         IF8VnnYgcIKfcPVs4VKDfR/K1jRoJD9Oqjk/3urFjEhNLDY0eTQKoriyDv6QB9+Nt1HC
         z9ZgMl9j+br+Jna1K4jbXfgMujkNhXwwMx89STzluP2gf0ogCfHeWoG0I3APkrDJpGCB
         XgHuOosCVqzFnDh2n4g7UJPiEdKDyK/4yEj0i72mAOr5gpcDA58GTzl0L2wPqi/IN9Ip
         v9chtsmtDAmpBiVZs8qj8n1YTnjEZvQ0jvcc5Q2Ah3+gdqmFzjRjZKzAG05gSAWBwvAQ
         fpKA==
X-Gm-Message-State: AOJu0YyLSustWPCtinGWkleQp/KNoKhwquFEU7gORap+z1CnLjg6ZEls
	GngVUYIUbk9S8h/ik0xaF+7QB3Z7aMKoXXOtNSWzPO81N1hdxYz7pfgO6WsXjdvF
X-Gm-Gg: AY/fxX5S6QW7BIEX4E00eKLyuKwT6AEa5ljlivxrHVGZes1+o3b43YRvdqPXHFZABnO
	5zoL1j4hZtomfMIwqHdmBVCdfH2E3uX57y2uHxzP84ry23PcJvRlBpesO7XLamWIwDLk9h5FVw9
	PlMGu5T9LWRvU869C3OvLYRkJVpCz89tJ6ySan967r/7xhduLKASJS24OcPowth8bXtb3lHeXLc
	Vsr+2GtZpAIKSvpvoKDnU7fRtFKPmbAizwI/glvyudwqyqUTj+KXru8tG0nzzA2rrfuVaQo8s9N
	gzI9vJzQwT33MUfXbR5tZM+ng6Im9Y9FWgGUu4oiQ6TALr4wz5jXzKlj+ObyIK0NPpJsCPGkVv6
	kvJhgKoYN7Zd6m5Cf4FrvJxCZUGX0suZCzDZ5pdqoGy3Cb0CVUGPnljTOMU3H0W8mHPFkEDAUtQ
	5DFAASu8tjtyMxnVrpI/yySObCQWwN2RwOp+ILchomAMB0f2GL/CaY/vXgn/Ov1Q==
X-Google-Smtp-Source: AGHT+IGI0NzXOXAhA1nrJHqTrlZtGjQqV+6cghOu1VxjpCmy0fuuxWMffXBXRLlyQigtisP9qZeZuw==
X-Received: by 2002:a05:7022:698b:b0:11b:9386:a38f with SMTP id a92af1059eb24-12061991877mr37384173c88.22.1767248715711;
        Wed, 31 Dec 2025 22:25:15 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm147035158c88.17.2025.12.31.22.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:15 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7925: add NULL checks in MCU STA TLV functions
Date: Wed, 31 Dec 2025 22:25:12 -0800
Message-ID: <20260101062514.186040-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add NULL pointer checks for link_conf and mconf in:
- mt7925_mcu_sta_phy_tlv(): builds PHY capability TLV for station record
- mt7925_mcu_sta_rate_ctrl_tlv(): builds rate control TLV for station record

Both functions call mt792x_vif_to_bss_conf() and mt792x_vif_to_link()
which can return NULL during MLO link state transitions when the link
configuration in mac80211 is not yet synchronized with the driver's
link tracking.

Without these checks, the driver will crash with a NULL pointer
dereference when accessing link_conf->chanreq.oper or link_conf->basic_rates.

Reported-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..d61a7fbda745 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1773,6 +1773,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 
@@ -1851,6 +1855,10 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 	band = chandef->chan->band;
-- 
2.51.0


