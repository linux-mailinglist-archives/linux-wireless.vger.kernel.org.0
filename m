Return-Path: <linux-wireless+bounces-34389-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NsBLyxG1GnVsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34389-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:47:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8563A84D4
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 020EF302C370
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 23:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7F3A16BD;
	Mon,  6 Apr 2026 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTDPZoNm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2139E192
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519272; cv=none; b=kFmywUMYX554alwRjfkCkrc/uRxCJIXnVCWhJn/PszrDLVcUD+8oB2ef1ekJBS4ezenz8ZXd8FXb9T+dDROVAg9i0oYdO5L860RoWxZyWBgkkRFUL4/bjqIVZkhVXuzuKp9gmyUZwvfrrS0tHNehriCR0mgMloKgCg7kanE22h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519272; c=relaxed/simple;
	bh=ZrPPXo/ApIPPC+cqw2mGR6rvX9gdyDuvfG7CLYkJ1v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOKEz6V05hNLFFCoO4U6GtWY1TkMQcOkCKmY7M7F1X7b0kXYNaXpegqb6z/zIQhoH6j4xM9io12N1YcwhiHRnI/Q+64tuLuleZ0MqDn0RpUIQMmfrVjNPBMb3J/hDLbLXMAObK1+gs55RRDyKOhmJTZv2wkk2dr2hffnlwem5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTDPZoNm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ab5fd969aso43430317b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775519270; x=1776124070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGFKokrs+E6BpbQjbbjTYkzD/AIdw/D6owYfFXIKI2o=;
        b=cTDPZoNmtqr9WrAG9foxM27jbmQx9Vh+nwkcUqlkzjUAR/G+ti9qXFG3m5d4zdQHBD
         pCAR5ouLtM37o8zB+wvmR7DNyVR+0ytFRXCAGswOa4S+5b9gIrzsBj8xfxsnHd65slii
         PA52aouF2nLPxewK8qzLeA8FdD6n8LmTW3rUZxOmCq0wLxwDlehmNnjo1a2VVv00p5Gf
         COY/Cy0LBPIoBlOodlq8cOFZ25HI4/oqhkjITb7NEsmDCA5bnQiwJVLNt/bwASj+3Jvs
         b6jE+KvryQBVmdzq8XHelXIfT5JiB/NC6r5nND2/GXp+0634SKuSDZAFvx6oDg6orusx
         RhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519270; x=1776124070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGFKokrs+E6BpbQjbbjTYkzD/AIdw/D6owYfFXIKI2o=;
        b=EIIK4+sJmiPXK+B3A7/2fAA8SaV26WqOIJTxc6jPYS2pAXZ0eA8JqW0UClRrDg/+Oi
         0F0PGeh3ZNJ3Zk41ChPg2JMfIyPQqn8AUAPzgYICB9FYKCEcTl2D1U+F9bcBLXECFn6P
         ShYDN0Lc3wOSgIFI6PA/1gwoiA9tzlow18cc5r2ufmb4cZPnf254F9+kb7lL8OGc5aIw
         J2ummm2v7E7aMjkFaJCOHKGI4qz1b9vW3pD+QGsXtQg6rIipSqVokFTwHCzZKxZG9f50
         KPsJjYwFeM7mS0YawKYF0lZtvFNCRbjEVNmhGLrVkGkZ51dD07zEvYRgoks61hJ2Dnyp
         XYRw==
X-Gm-Message-State: AOJu0Yw9pfdvSiXumwEwmru/xxpJiaotbImcj1WQevG18EbwecmfKlr+
	IyGA7m+4u5904ZUleKlLkhVtyHK4mjRniV4LItEDeOZ8WnhjdyvERoljzpFbsuM8
X-Gm-Gg: AeBDieux8hED2P71aMukGIvuiE3PFQuBCtVLNyzfWDmtTy1IW736002T9GKFHVGmQv9
	tjeS/gKHW4QjVQ6E2Xu9sOzpNot+8ocOr7Gn50i9HT+KLkgBNS0iXsM5+qUhsDQg86g0Q4MLX2y
	cHjieH9iFpKZwUKN6TWXp1eaKizlvoxOffjMLDRa2IW0yrPi8QNFVntrEdxeCMay5mD90o7n2q/
	AOQC8uBnNoHaWpHFZbV5LYNtybOToX5dWJCRguAbLV9ITd5TDpRbcnZXvCTnkBBoFR48qMaFi5M
	I4rVSe03UHdJNqR9r2WYVlvEOdPC5DtMrALIBofcc4TRCOJ7veszZQ2flxV3XsKZbaNZSLh7GS5
	Xh781yJDRV+Pin269yOvbjv3h7KzgYi2UYC6/ZYePkGlo4AsiTLXBexqfYmSpR0LQhfSUh7H7K5
	/ddIfN9FicVMc+ItB9MdNKJKX1CogtEI9FY2NxIoN7guYArglSGarKkzYJU4Cv
X-Received: by 2002:a05:690c:9:b0:79a:b983:b44f with SMTP id 00721157ae682-7a4d31e86d5mr152606447b3.5.1775519270045;
        Mon, 06 Apr 2026 16:47:50 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff31sm59350177b3.6.2026.04.06.16.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:47:49 -0700 (PDT)
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
Subject: [PATCH wireless 1/4] wifi: mt76: mt7915: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 19:47:36 -0400
Message-ID: <20260406234739.29926-2-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34389-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 5B8563A84D4
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

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1c0d310146..946d2bd0d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -221,7 +221,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		msta->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


