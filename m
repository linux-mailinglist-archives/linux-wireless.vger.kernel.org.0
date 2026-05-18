Return-Path: <linux-wireless+bounces-36613-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGe/E0CCC2oNIwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36613-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 23:18:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 105DB573BFC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8987430391D8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 21:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C209397E91;
	Mon, 18 May 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTzT0fqj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BC393DE0
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139128; cv=none; b=TKaf0uaPuAJNnQ79fINavtELdDrJ0K8PuVC2tUKY/CZJC3vodE2POQQm+kmKaiKRGTHyXYfzbJdxrbuT0lRtVOxeGjsB6V8aCLFsLsyTOVMUgzJl0RziIpIapsYBzikNXLozYM4Z4VPBT4LfUMRvyy+X9OmUED23ai8g/PEp2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139128; c=relaxed/simple;
	bh=g/xJZ+OYh1mkHmn3+sQ2z7XA33HLjy2TXP/ltrNVdjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giqZK4gAOL94p0OROIxaTTiQV6IFXUzaHZ6jTBkqsdZEGqH1DZ5Ngg3jXugBbjQo4yzOLEnzJ2fS49VSSO7fFgrKMX3dvqKDWI4H+XK6QocozFk6mMJm/wN9bAxMJZLEsJPqKE6m5/0mG14sfZ2XkhQbCYHSg3Zn7GGTEhaAH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTzT0fqj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so2861726a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139126; x=1779743926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYl12Kfn/OxyVfyG979gVQDEq7mBiScEt37GaLdil1A=;
        b=QTzT0fqjDQ4fTAyk9w1haDp2lZCCvtTO7OejfYejXr4K0qO4DM/9DdZsgTStecQ33L
         D+AYq+1pzMi0nWRnAPeoxDxqeJx6aqaCcLtoAOrcUEF+uAStgBwhX7KhYHGSywcnj9vg
         vxmn0XDQDOsiupxpFGyYnEfxw3Y4W/xB0NnAGmQo6QJcRPDAiNhvCmdZmRLCJ+Uj/1uU
         iN1p9joGHtNmKqt8D2yM1aVPhGSPbX6acurkcEh68Ow5OYNEqDzDCHtcx+EQ72vjQsoE
         vqnasDsmBLj6GAFAg+0Jxur20JwRT9GMhb344dAnvHE1aVklxmxPz98md6Ot6HnnzVeB
         65jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139126; x=1779743926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYl12Kfn/OxyVfyG979gVQDEq7mBiScEt37GaLdil1A=;
        b=JVt77trg4yCNVTYiWbZ9tS3Wp8MZOhn8DMUP2A41FCfk+70EmOwkF8r1nRbxlZhf4q
         UGIPU7usbdm7YEsG/eTTv82EjClKVTGd+qnDhlWmnQoXfvNdLtZkoI8jB0DZwnSsMi/1
         94ukc8uF6iSO5RF7gxx+M02DYRryV62PrgyS9VL0vHq+03I+4rbxPieJAaxKsxcRU8DH
         4km97EnMVwhwftbsj/qEjYlHK6pWgF0dZ55M5boVjAFgmT7AZcipntyuNetapc24yRmW
         Q+dyocuYFKH+H5XTV5KLseuZVxqIfxzoiC5WfZih3NdbxTzY/0AYD/2OYGrx0AfAT/9X
         cl2w==
X-Gm-Message-State: AOJu0YysUbseeAnYFMcYbKFp0t9OL9HHmOaDTUUox7V09D2TCFo6xdLx
	PrpbfHgXrCNCczPfT7J9sQQnj1cpXgy6rV2JYtw1ULkW3IPiXrap8fmZM/sT/Mi3
X-Gm-Gg: Acq92OEsd9GKGo9uRpGzLhFsfGEBznHkrMspnbuBAumjPw3DbkTleiNAFHyg63Tk1Pd
	aJJ/0dyLsuuWC+FR6fPUPFaO4vh6iUKsEwlVQLByOLO48G50Yf9BpsAtRWFwWBOCSnO2TL0bbzZ
	gNIhTs7d18+we5K9YfYA2HQkSNHEjlDcLG6RhvANBgL8wwPDn7zHnsi5Y7yJMhoxbv57UdNomqK
	KxEBFItAvQieWEzmvd2fPtjkfn3G+bVHqD8VBG8SlusTIzTrxiGkNV5uwU5Lcrnug/UUfRxbSY9
	lDbugplAoXfmZue9gX67sMePkKqf5Syy02M7ERJ4Bm1IgZHwtkfh3ah2QlVLRf5BtHdz1wl1UmA
	3LGs9HykOb2EC1GZqNYEBkpp6Fh4UViS1shBdxzMKiDAI6Y8VRR6UysEgYscIPPQYrHDw7Nm6LK
	BFHFvYUYOSDxkPM3cO4sj8w08kx1Axhop34Gcdny+DKs3HlbDmn/sjMWLoomM8xOY3xezWNBCjN
	fsBd3SfoFldAF1Drz2wji5TRSrRzenMf1w=
X-Received: by 2002:a17:90b:4c50:b0:369:d7c6:450a with SMTP id 98e67ed59e1d1-369d7c64a4bmr4286889a91.0.1779139125662;
        Mon, 18 May 2026 14:18:45 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157d963sm11466999a91.6.2026.05.18.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:18:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH wireless-next] wifi: mwifiex: Use flexible array for RX reorder table
Date: Mon, 18 May 2026 14:18:26 -0700
Message-ID: <20260518211826.11245-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36613-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 105DB573BFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Embed the RX reorder pointer array in struct mwifiex_rx_reorder_tbl
instead of allocating it separately.

This ties the array to the reorder table lifetime and removes a separate
allocation and cleanup path.

Use kzalloc_flex() for this and move the counting variable assignment to
after it as it does for GCC >= 15 already.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 20 +++----------------
 drivers/net/wireless/marvell/mwifiex/main.h   |  2 +-
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 610ec8302adf..a266f09cb763 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -213,7 +213,6 @@ mwifiex_del_rx_reorder_entry(struct mwifiex_private *priv,
 	list_del(&tbl->list);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock);

-	kfree(tbl->rx_reorder_ptr);
 	kfree(tbl);

 	spin_lock_bh(&priv->adapter->rx_proc_lock);
@@ -329,7 +328,6 @@ static void
 mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 				  int tid, int win_size, int seq_num)
 {
-	int i;
 	struct mwifiex_rx_reorder_tbl *tbl, *new_node;
 	u16 last_seq = 0;
 	struct mwifiex_sta_node *node;
@@ -344,10 +342,12 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 		return;
 	}
 	/* if !tbl then create one */
-	new_node = kzalloc_obj(struct mwifiex_rx_reorder_tbl);
+	new_node = kzalloc_flex(*new_node, rx_reorder_ptr, win_size);
 	if (!new_node)
 		return;

+	new_node->win_size = win_size;
+
 	INIT_LIST_HEAD(&new_node->list);
 	new_node->tid = tid;
 	memcpy(new_node->ta, ta, ETH_ALEN);
@@ -381,26 +381,12 @@ mwifiex_11n_create_rx_reorder_tbl(struct mwifiex_private *priv, u8 *ta,
 		new_node->flags |= RXREOR_INIT_WINDOW_SHIFT;
 	}

-	new_node->win_size = win_size;
-
-	new_node->rx_reorder_ptr = kcalloc(win_size, sizeof(void *),
-					   GFP_KERNEL);
-	if (!new_node->rx_reorder_ptr) {
-		kfree(new_node);
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "%s: failed to alloc reorder_ptr\n", __func__);
-		return;
-	}
-
 	new_node->timer_context.ptr = new_node;
 	new_node->timer_context.priv = priv;
 	new_node->timer_context.timer_is_set = false;

 	timer_setup(&new_node->timer_context.timer, mwifiex_flush_data, 0);

-	for (i = 0; i < win_size; ++i)
-		new_node->rx_reorder_ptr[i] = NULL;
-
 	spin_lock_bh(&priv->rx_reorder_tbl_lock);
 	list_add_tail(&new_node->list, &priv->rx_reorder_tbl_ptr);
 	spin_unlock_bh(&priv->rx_reorder_tbl_lock);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 27559e2ddc31..67da5daa48b4 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -708,10 +708,10 @@ struct mwifiex_rx_reorder_tbl {
 	int init_win;
 	int start_win;
 	int win_size;
-	void **rx_reorder_ptr;
 	struct reorder_tmr_cnxt timer_context;
 	u8 amsdu;
 	u8 flags;
+	void *rx_reorder_ptr[] __counted_by(win_size);
 };

 struct mwifiex_bss_prio_node {
--
2.54.0


