Return-Path: <linux-wireless+bounces-32717-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PhiEJEJbrWlM1wEAu9opvQ
	(envelope-from <linux-wireless+bounces-32717-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 12:19:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D022F6A4
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 12:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42DFB300B76A
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2026 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A81B532F;
	Sun,  8 Mar 2026 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHDL7xXm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8591A9B46
	for <linux-wireless@vger.kernel.org>; Sun,  8 Mar 2026 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772968767; cv=none; b=fK4sY0Y5WTZWtWnLXyZo+vAGB39k2zNyiuAKtKQknF2SBhNxjkhJ5GXFZGbH09DVoXnVYVoO2i4YGakmkx2Av7yjUpngpYlgSj6Nn4ZJVFf9FOJQLh6yYHEaoLfDySmAczBrB+PnNf9g5i2IimBWon2/KtATuvh6BPq+vnTJjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772968767; c=relaxed/simple;
	bh=MnSoOliZms1rtJ36r7EV20BbtHfY5/nN/RKpNxkf4YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2B3weyMgCoh2EbyhJnVgQNN+HpSIdtw6K2ys9ucE8NACmiM6IB4yHXll80LqULggRDTRGGH+9aB2ADJCbf6FVhNJ//5veaRxIoH3JXi9IGYM2CSvOKe+Ag47EL5BniT3gEwWFxjEANYNQBgVL8TjBSnUlG4FarMRIRiXVUytY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHDL7xXm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-482f454be5bso108486775e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2026 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772968764; x=1773573564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Df+aOhmzBiXa/brXDdA6LDkpO7lGgAfLqr24RFS2w1w=;
        b=DHDL7xXmKU7bbtGB+egikLr9tQzjwE4FYbD8mCWB/cIzmjk3KLjhqVSfxz9q38DST0
         RCdX0tKSr9zMTkioxa6ZRK67gEeUMGDvkh/V+pjWnWlZElc+pV9Hg0NhIhBF8ckksBDz
         A8Ezv0G4su1NRK2LhuGHM8J9UjazvTZl4SHQp97Ij7BCoLaDC1rfbzoFW9Rt0G6FaeGz
         gJF7UX6FNUmRT8ITSklIM43KyMOlILiOZJ3U+oA5sR3RKj4a44pp01+6tduRPf6I0q4O
         AxsWsyz/rlYRPP2Cs0Hnnu+3ojAkAHMBFmaBt31xWaq/U0Pre1iF72aBdYMUGtfOr8nx
         vMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772968764; x=1773573564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df+aOhmzBiXa/brXDdA6LDkpO7lGgAfLqr24RFS2w1w=;
        b=hNR44F5FX45ALQhUVTLNDus4t56zOUwQfcSDWVC/GZmBAs9NGoAxSaWSWfQ5vWLJl8
         79N5F5LFDvd2JQSF3CZFLzJfEAxFha7hoh0wqINyeWeQWKfd25EH27j6RWZv57rpxu9q
         aMXRq44Uvsr2FZFhZJRS0Jz6gm0KDUZfXbjpq/5XJ67SG+x+ytarDQs9+L+kB3AG+rCU
         tg8hECneGLT6ZitSGQa+mOIeGwNyWQSJ5dUnmvL6Dei64PXRmNf9dge6ZFZLfZ8XNvEd
         UokjFIk/jqhiXnXvAyP3tyc0EE5NxeRTT0UhR0+RCQcabyU3axBpjPqgYScj4vcdrH5S
         YO9Q==
X-Gm-Message-State: AOJu0YzlWxeieNTjMd1S6dgo32zwlgWPzsnRatMhUkr5XjOoAGIft6FL
	FTvjKwtS4MREleOMorR4CYaiKqoYFthHogYUrSjI6zY4fH+Pan698TXH
X-Gm-Gg: ATEYQzz2bE0cIT5wvwS2wfPlrHPORxbZfLUb8CmyrdwuAWLCtlRXy1ywLWOIMch/3MA
	43RTgu++JSSEUD/ReZb3EaL6+cMTM9N0KhC8+D6GORx8+PsOjOgnme9FtonsbSf1GGMcv1Dathx
	z2TaAAEb3n2OkvVNhMvarEtIfDABmlzECAIC774suhDV9ryIToJ/b9Gnw3JzzM1QkB24OLyj9cp
	TEcYS+ozAZgSGTvAN8up1rpcO/dSNmpmQvFBVug1r1FZcdY6Eqb9balvOr8ultJbdDOo1fRtMF4
	wrWayA2WAY5AvPsgIyJDNUX+RkQ4Rei/NsGXDjFX9TVza5aewPBNPOipWeT91DIbjCHI0kcUaJi
	EVcOp0QwQ9ffKLx9VrSE3aeDrysJgg6WZEAspVGjWVoOknviBS5G3Gzw4gnikaoMld2/KcKPA5A
	l2GJqRQzmRPXJ1G2NCHNRGzB8k
X-Received: by 2002:a05:600c:64c7:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-4852671d9c3mr128290015e9.8.1772968763723;
        Sun, 08 Mar 2026 04:19:23 -0700 (PDT)
Received: from localhost ([37.228.227.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae538bsm314413365e9.7.2026.03.08.04.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 04:19:23 -0700 (PDT)
From: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192d: fix typo in H2C wait counter names
Date: Sun,  8 Mar 2026 11:18:50 +0000
Message-Id: <20260308111850.20420-1-jaime.saguillo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E64D022F6A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32717-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaimesaguillo@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Rename local variables in rtl92d_fill_h2c_cmd()
from wait_writeh2c_limmit/wait_h2c_limmit
to wait_writeh2c_limit/wait_h2c_limit.

No functional change.

Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
index aa54dbde6ea8..a255a5061d77 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
@@ -212,9 +212,9 @@ void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 boxcontent[4], boxextcontent[2];
 	u16 box_reg = 0, box_extreg = 0;
-	u8 wait_writeh2c_limmit = 100;
+	u8 wait_writeh2c_limit = 100;
 	bool bwrite_success = false;
-	u8 wait_h2c_limmit = 100;
+	u8 wait_h2c_limit = 100;
 	u32 h2c_waitcounter = 0;
 	bool isfw_read = false;
 	unsigned long flag;
@@ -261,8 +261,8 @@ void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
 	}
 
 	while (!bwrite_success) {
-		wait_writeh2c_limmit--;
-		if (wait_writeh2c_limmit == 0) {
+		wait_writeh2c_limit--;
+		if (wait_writeh2c_limit == 0) {
 			pr_err("Write H2C fail because no trigger for FW INT!\n");
 			break;
 		}
@@ -278,8 +278,8 @@ void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
 
 		isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
 		while (!isfw_read) {
-			wait_h2c_limmit--;
-			if (wait_h2c_limmit == 0) {
+			wait_h2c_limit--;
+			if (wait_h2c_limit == 0) {
 				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
 					"Waiting too long for FW read clear HMEBox(%d)!\n",
 					boxnum);
-- 
2.34.1


