Return-Path: <linux-wireless+bounces-10366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AE937141
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 01:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7607F1F2217B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 23:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A423B0;
	Thu, 18 Jul 2024 23:46:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AF146D6E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346398; cv=none; b=WKYCL8XsgR5XhuCxdTxEWGQxOtwqKvfPkX8XOn/2HySv/Wc2RXmCRqWHMy3B5pQDXhEZDBn6KznQN5YLM9Ch0Wjg/RTDf7wvKs7mT8YRwTUvUTdl6EfPQSSM5pOCD+7KkYjijNseaO+7CDTnBk7MRqY6x2KQZPiTcKVDtGqTqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346398; c=relaxed/simple;
	bh=O15ldoM4uhG+C9xTtWNbYILdLmU+t1Rc5NHJPAydHrY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmUTy/Fe8bfWfZvrGJH9R+8Pa6N9KLIJaz/gD2U7PfCuwBi9ttwWobno0atNacpwh/D0pt8sXsvCw/CUhtj7Mfxofbu2eLSSetAZ5uiv4WEtPscjkY/1oVKKUP8n0WI/yX1NG7C6+9db7tuFh5QvcndGX5xc173C9UprGANsBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2610c095ea1so13606fac.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 16:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346396; x=1721951196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kumYOpt90WwIURjW83CrBNCxrFrm56wRKCJC8GtXD4I=;
        b=TapLjAMeli2C345GFzpDLkme/wqkkNVe9ibzJDC5LOk2Ch4/Y9XCIjeKkvXKhzzlCU
         zcUIDdZ9AN0HywHCoL9HUhHgWL4bpCmlK1kZAJM4TdiUbzwvufmjZmRwSo0Nk8RXSUnB
         lyPINowLltH5bhPQaZ9pixTXC1o0TPmWOeV3BKeoxb2VDEIH+pfs3YSopMEX9cuhhqhl
         z+/KTJ7G1aRonJ2vZGlyfV9Y66r0rYIeCEjK2RH0TfGeNv4Q4oXCqmW3n8SjcrdmXltW
         YrO29bIcs57eQjcy+rezI1hStcRN3tE6Lnwfa+sGmOXxVUTy1idrzoEFrD4Yy7L20Pjv
         jG/g==
X-Forwarded-Encrypted: i=1; AJvYcCVCBBS6x5WA+pRwDKrOPr72Lv08x5sfLYuEo3Y1oApz1ZaLWPVr9uZo/q+LBnOAWt1lh6/KyIegwgO/k5zcNrFW9KnupsaLXnz+Nu/hBpg=
X-Gm-Message-State: AOJu0YzmkCoGiUZWIOJkqYytpxwdxPr6+s8QTsgB1XbDtUbi8nv/ra0A
	IPpYz/MlKBJNAVh8fmP1su+7z7lQv4Dt6gJSmqfshH7EEtRcdWVY
X-Google-Smtp-Source: AGHT+IFRf7TjBSxNEPCzpgioy5JjkDTiqmmUFLR3bozjk/syGEwERkAtjw3rXmpWtwdoOUzOIwQD1Q==
X-Received: by 2002:a05:6808:10ce:b0:3d9:36ba:2ce with SMTP id 5614622812f47-3dadf4dfc21mr768420b6e.1.1721346396099;
        Thu, 18 Jul 2024 16:46:36 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:3c59:65c4:19fc:c2eb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae0978889sm70677b6e.13.2024.07.18.16.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:46:35 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Bert Karwatzki <spasswolf@web.de>
Subject: [PATCH] wifi: mt76: mt7921: fix null pointer access in mt792x_mac_link_bss_remove
Date: Thu, 18 Jul 2024 16:46:33 -0700
Message-Id: <20240718234633.12737-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Fix null pointer access in mt792x_mac_link_bss_remove.

To prevent null pointer access, we should assign the vif to bss_conf in
mt7921_add_interface. This ensures that subsequent operations on the BSS
can properly reference the correct vif.

[  T843] Call Trace:
[  T843]  <TASK>
[  T843]  ? __die+0x1e/0x60
[  T843]  ? page_fault_oops+0x157/0x450
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? search_bpf_extables+0x5a/0x80
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? exc_page_fault+0x2bb/0x670
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? lock_timer_base+0x71/0x90
[  T843]  ? asm_exc_page_fault+0x26/0x30
[  T843]  ? mt792x_mac_link_bss_remove+0x24/0x110 [mt792x_lib]
[  T843]  ? mt792x_remove_interface+0x6e/0x90 [mt792x_lib]
[  T843]  ? ieee80211_do_stop+0x507/0x7e0 [mac80211]
[  T843]  ? ieee80211_stop+0x53/0x190 [mac80211]
[  T843]  ? __dev_close_many+0xa5/0x120
[  T843]  ? __dev_change_flags+0x18c/0x220
[  T843]  ? dev_change_flags+0x21/0x60
[  T843]  ? do_setlink+0xdf9/0x11d0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? security_sock_rcv_skb+0x33/0x50
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? __nla_validate_parse+0x61/0xd10
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? genl_done+0x53/0x80
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? netlink_dump+0x357/0x410
[  T843]  ? __rtnl_newlink+0x5d6/0x980
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? genl_family_rcv_msg_dumpit+0xdf/0xf0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? __kmalloc_cache_noprof+0x44/0x210
[  T843]  ? rtnl_newlink+0x42/0x60
[  T843]  ? rtnetlink_rcv_msg+0x152/0x3f0
[  T843]  ? mptcp_pm_nl_dump_addr+0x180/0x180
[  T843]  ? rtnl_calcit.isra.0+0x130/0x130
[  T843]  ? netlink_rcv_skb+0x56/0x100
[  T843]  ? netlink_unicast+0x199/0x290
[  T843]  ? netlink_sendmsg+0x21d/0x490
[  T843]  ? __sock_sendmsg+0x78/0x80
[  T843]  ? ____sys_sendmsg+0x23f/0x2e0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? copy_msghdr_from_user+0x68/0xa0
[  T843]  ? ___sys_sendmsg+0x81/0xd0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? crng_fast_key_erasure+0xbc/0xf0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? get_random_bytes_user+0x126/0x140
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? __fdget+0xb1/0xe0
[  T843]  ? __sys_sendmsg+0x56/0xa0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? do_syscall_64+0x5f/0x170
[  T843]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  T843]  </TASK>

Fixes: 1541d63c5fe2 ("wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS")
Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/linux-wireless/2fee61f8c903d02a900ca3188c3742c7effd102e.camel@web.de/#b
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2e6268cb06c0..1bab93d049df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 
 	mvif->bss_conf.mt76.omac_idx = mvif->bss_conf.mt76.idx;
 	mvif->phy = phy;
+	mvif->bss_conf.vif = mvif;
 	mvif->bss_conf.mt76.band_idx = 0;
 	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
-- 
2.25.1


