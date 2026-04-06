Return-Path: <linux-wireless+bounces-34390-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WpkrFGlG1GnvsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34390-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:48:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C733A8511
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A411E305DB93
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435733A2550;
	Mon,  6 Apr 2026 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFrRhbD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2A39FCC1
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519273; cv=none; b=o6Makc5Xd6MIxFCiijruaW7EDkoJA6ZGKWTmb4BfUQ6F4gWDoRreMuI52mEDRQFSZqcqo9nvZE7ugbPhJvioEwlDte6FjPc8OU6AiZa9LsHgkwG+Xr3AXCL1tKey1o7e/upUWX0W1WgjB2oC2h5Dz5yhjVCLKBChonYLLYYyd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519273; c=relaxed/simple;
	bh=TAPzuaW5AlDW+othVr5o2bBlmoV+im03JSrJdzDaQdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+UhxWC1VTPOdOrgn/CJr1mcn8RipaE3s/zYfKf9RHizU5kGMxZcshlUAhRRcswKQ3stXgOE3ULfP5idZPvv8PO/SdFHCzcYi/p6hQ9WTgOJay01y334YvUnHif8MQgFyDb/nCq1l6g+11GIOb7nz/bu1ZDIDXAhUsWnWD0hla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFrRhbD3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7927261a3acso37150497b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775519271; x=1776124071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daA/SDL/He3KnWtFLBF284CvHqGYJ/f/DA6iaNDSago=;
        b=LFrRhbD3p0hKZVKABNG0HVt4/RyIlg+r6iXfBw9k74L81a0bXfkQ0Pbz4CSUZVzeSJ
         cgEBBtfjOLj3nuDI3aV48LUylGLOZuDzZyDuXBt9rOmRsWQYt03P1vHKsdWdiEZTI4i5
         jN7JGH9Qr3V3+M8yJSzEQZ/nmzw+itHgEBKsaDqPsqSd+JFCRwbX9EJeNJ6R/dqQeh49
         hOgeer5KEmXgVF/sT3hiVbfUbTq7VsSzlkkAXwpRRrOgNUUOs0rTXTlD8owdtq96NflY
         xSNWNO88nO39lmYb/3YoDg2+26fq8+bfmVCBLxYeGOkxRjXsZGABl0y5o3CnI6uWkAsC
         K9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519271; x=1776124071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=daA/SDL/He3KnWtFLBF284CvHqGYJ/f/DA6iaNDSago=;
        b=BYjkTnXtwriS1t9XRsuMmlfA770WbihZaXebR8bwisjDkKudH+zDUwuCfmWMkDqWOK
         JwdMHrDJ0RCMVKymQTJaDga158deFgR3u6s5vGQ6N19tbKN3jymiU0JZMl77WDkha7hP
         aqIJ6mZtVgmOvKe2nDaWIsxJXBNBJm+ghEXLplus2uGMcPf00acnLHZvrCwjVvJ4lOkk
         sYBfskGqvuTv0S4lPVD+eq3zrIdADKwrMmLxqdMq+4xiOMdmhe4M90zhKEPwVQWphUmb
         Xm8iI3RRgsXiV6Hzjj+4HXDxLheG4sNy3kc8oMilNR6Jx6NUhtetNV5yF+Yei/ROT/jr
         ys6g==
X-Gm-Message-State: AOJu0Yw6hYLJHsQy+Axrul5MWmbQPw0EhH7D16714OBa0ggU6Q7krfIB
	tN4r5Fsi9CSuiO4kMyYqq2RdZ0fvjcwW0Syx091Kr90Xo7vHvrEcJpZgunOmu08j
X-Gm-Gg: AeBDiev+Cw2m0Sf7d74ag1ufL84mZ3KR0MPexU1UIvgqUWbE58rSfy2GZqUnn7Pkg+J
	EbF9GffmM1Ir8EgAFY/tfW3gJu8CQ3oz8swXrTV9PIv+VviumXFt/rMnDWmT/GQ3+HSbtAh1mLx
	4WBNIu8J3A29BkJztshDXipkTCPodAQp7M/3i/EuF7TRZ6l89EPXkP5DuHhTa2BPjyxiB599eHj
	mfL7IBugYJqklLws4sjPT314VQvQ2hTaCBIuJhp6Mp0LmQfceSniDBhqZ17o9+8p9nbORFyQZ+w
	/4pGtlqjrhxsLuEk1b0GxCzxd4YNlutfa2LnmqswOIX6czf4Dklb39SjaZ7B/vo5wRfs2KraYzp
	pc046xhQ+VX1NkfJhyYIgE6Gjxd0zVEBLQmDepzIziaORBsX3okHVH16rzicJtj8YCzlkOBSgHo
	nFsBYSUML3tt85louQyem5WG7ptlvs3L2OzsTdLQCgX644uIl0lq1yCR3c1l+M
X-Received: by 2002:a05:690c:498f:b0:7aa:451d:bf9f with SMTP id 00721157ae682-7aa451dc2c2mr16718657b3.5.1775519270856;
        Mon, 06 Apr 2026 16:47:50 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff31sm59350177b3.6.2026.04.06.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:47:50 -0700 (PDT)
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
Subject: [PATCH wireless 2/4] wifi: mt76: mt7996: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 19:47:37 -0400
Message-ID: <20260406234739.29926-3-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34390-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E8C733A8511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
for the fourth byte, consistent with the other three chains and
with the RCPI3 definitions used elsewhere in the driver
(MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).

On devices with fewer than 4 antenna chains, the corrupted value
is masked out by antenna_mask in mt76_rx_signal(). On 4-chain
devices, this produces incorrect ACK signal strength readings.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ca2305ea7c..ab47118fb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -205,7 +205,7 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink = rcu_dereference(msta->vif->mt76.link[wcid->link_id]);
 		if (mlink) {
-- 
2.43.0


