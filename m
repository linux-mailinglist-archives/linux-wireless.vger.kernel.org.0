Return-Path: <linux-wireless+bounces-31027-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCDDIc/rb2m+UQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31027-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:55:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12C4BD23
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 688334EEBCB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BD352F99;
	Tue, 20 Jan 2026 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkNM8VRv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A83A89CC
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939856; cv=none; b=mYUiXLCsoAEsUHzpn9jF1BWor1akFM39TFFwVwmYc0YD50bopiZKpDx7PPARBi9wfwjQwDWIvxoFrHatWy0GKOsdMdSnuja/l0gktRXvPReGbE1snIo8bFI+0uajMP3tuAN/0khM4HNjRZBcAkVpd8Avd2ENWYEtpwP2ceg69jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939856; c=relaxed/simple;
	bh=2+HHCsL4CHpvAxtcpZ+oNfJ91XAAY5ApArx/L+V3+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIj6QUoGsCjOFiVYslGTGq13JoYFm5aCuigo6B/Z6LxLpzhdWAHFVbMrcNmGEeQl3m0Xhr6UbTTY5a1bKhv0y48zVD+xVZR2v+U4pW7gojCYmOGXHZtprYjrWo2jOKoQP7CT2FHUhyzVnD7a8kN7V5qYcualPXu1wwnd6KTE/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkNM8VRv; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233bc1117fso160046c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939853; x=1769544653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZqhvQUqHyPjd5YwFiryR+es7m9UdWSAqM9hdcVMAYY=;
        b=nkNM8VRv7TyVBBJeLBeJ3/a/PIaCRvf23tD6jTX0exvKijTX20GI3fPZL1z2MkpgCJ
         Bj1zxv8N5695jVuUms6JIt8UEgGyj5dTZwSQDieQd3EWTKrj56RP3uXnQKp0Rmym9CLW
         BgIu1zDnPGj3kUrNh8+SRH2cOHrUjaLvflsZYPd0d8aL2AM8RC/k68Cz70Mxy0W4qf/v
         BXtVAcIXT4rCB1Xddz+IH/jFJAVderEXHuni973bbqQRcRGydd9RH0GZPuH/vr9kpeu5
         YAMZBe/q86rNKJI9aLlSh33sislN2zzemUTUAbkQbqdeK/T3EEluOgy7bP07cyX57KLh
         MZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939853; x=1769544653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZqhvQUqHyPjd5YwFiryR+es7m9UdWSAqM9hdcVMAYY=;
        b=vmz4GOGL21Ne1M3JNsKZoWkFxivyj84+F61CxhGRk54gf6LnnNJ/cteNedbhYEixMp
         WXVXKQSj4GTIwV+6hESTtemdVSQHJgxn50POHciF7ib8sqWUyq94y6CFy8+22+Oik1Dt
         Aa+CNB7AsNOPM5P6RBGRp4WPPqfRhdt4FSQQ5I5VpKDZzB2iLGap1dQLJzZz4kYj/rJV
         L864ZeAaRCCH+EnoN9v1T5ecB8ZpMQ2yaSxfD+M26NeaD62VXsAbqdXkwW7/sPiOj0a2
         6vFo1bkDRJS7lpXGo0nao4m71sDyTUikzA2aYCFdH45foMDwnhnmSyy8Q8AKwdWw9iuS
         YROA==
X-Forwarded-Encrypted: i=1; AJvYcCWcHXTWXDhdeEokNpd91SpvfctpAgOYAkRYEsxOgbKjD+Yxh5harBNkQB3WvHOJh87pxSiUTUU3CHvj5RgFcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXa1uYT9Ijf/DZUSP58hLMVpxLlYtyMyA8L0HrFvYytJkhtXxp
	bTk9kqhSgH7rjEWzymXR5vAbcrTpj+S0ycmjPwxm+X9J1gQ9HS7ipkRV
X-Gm-Gg: AY/fxX5Cey0kYLPk79COBHFtgBC2YIoUqefxiJcI3cJXs7EfCFIzM3+SxoKKmA7O9Ha
	kpcMW2rr771hHfVJ7515BI2QmcIrgX8fHZKM49X3bPtQaAaklV672P4Eo9srX9lyEqwdUF3gqfz
	UwqaEFzkhb4/f8wOh8dn3t3Mbp1cQWRwL6hJldQJdxeKrsNjN5lujvc2JR21d5SXjF6Zcoyaxty
	H+Q3cw+eeYDVl7Gx5DwqvexCkyoj1CLaorXe/AY0kXF/zL5U/LhOPkJP6hAIMohZfRvH+FNahAH
	bfUwGf0T6813EL02964JSYAJAEsY2/C8gFE23yf5m372Ux91IE838X4OlQntFsNn3h3qrlOVbVY
	0hCYan6CRb3xP3ZjxnYHUjuT6GdwckUDz+armRWIbfdcwdttDnBmJl+2Q6d8mpN6TUqQfIXjwss
	IYuJefCJHQ+FZOUjuaDUNUBpf2506crxABCh/DynPuQFJmwYAcE0LiukPEBlntSw==
X-Received: by 2002:a05:7022:ea30:b0:124:5760:1e18 with SMTP id a92af1059eb24-12457602302mr7361158c88.14.1768939852393;
        Tue, 20 Jan 2026 12:10:52 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:4a3c:9f7c:8037:90c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm21982990c88.7.2026.01.20.12.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:10:50 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH 02/13] wifi: mt76: fix list corruption in mt76_wcid_cleanup
Date: Tue, 20 Jan 2026 12:10:32 -0800
Message-ID: <20260120201043.38225-3-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120201043.38225-1-zac@zacbowling.com>
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,nbd.name,zacbowling.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31027-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:email,zacbowling.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3B12C4BD23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zac Bowling <zac@zacbowling.com>

mt76_wcid_cleanup() was not removing wcid entries from sta_poll_list
before mt76_reset_device() reinitializes the master list. This leaves
stale pointers in wcid->poll_list, causing list corruption when
mt76_wcid_add_poll() later checks list_empty() and tries to add the
entry back.

The fix adds proper cleanup of poll_list in mt76_wcid_cleanup(),
matching how tx_list is already handled. This is similar to what
mt7996_mac_sta_deinit_link() already does correctly.

Fixes list corruption warnings like:
  list_add corruption. prev->next should be next (ffffffff...)

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438..d0c522909e98 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1716,6 +1716,16 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 
 	idr_destroy(&wcid->pktid);
 
+	/* Remove from sta_poll_list to prevent list corruption after reset.
+	 * Without this, mt76_reset_device() reinitializes sta_poll_list but
+	 * leaves wcid->poll_list with stale pointers, causing list corruption
+	 * when mt76_wcid_add_poll() checks list_empty().
+	 */
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (!list_empty(&wcid->poll_list))
+		list_del_init(&wcid->poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
 	spin_lock_bh(&phy->tx_lock);
 
 	if (!list_empty(&wcid->tx_list))
-- 
2.52.0


