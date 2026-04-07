Return-Path: <linux-wireless+bounces-34400-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAh7IHFN1GnvsgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34400-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:18:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D502E3A8693
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1692830AA7C9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448F1B6D08;
	Tue,  7 Apr 2026 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjVTSiGE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68C19D093
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520971; cv=none; b=OGPdY9x5FjsUB65jccPfTH7FlP287APFjjAo7bitERrf9oYRCt9aDgh1dg3VRRnqXesXZRO3xzQhEMn47T84G2vV6ac1cEThgGutnYGEODQTlr++71/J/Hhl2RNa6rYG6tGtHgeT4A9pxvnYMEQHl6MqMyOFglWbLnsY+hX0Bx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520971; c=relaxed/simple;
	bh=Nysgk0uciCPiocl22DBJxD3R6NfAICtbGv+6Cp+q9CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er6+vn76wGr75ct3PeSPcpFSB0xWFkS1VJL93Pm/xNeHt8FTxymr9eqyVjGEoFVs7Swow615qG8CNRju+kiwhwmBdPEJ7bgq5htBt4FuU9uE96Ca7Yn/UXeGYbtQWtUX9ItIFwA81ZyVyhxeSQxtAGwZrBM0XbsmhVotQ2VdVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjVTSiGE; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-650182d19e0so5026806d50.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 17:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520968; x=1776125768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRqvQs6ivSDyEsQUNGAHXVReKeGYQz/kj2ZPLDDhbBc=;
        b=VjVTSiGEHwbxRA3LxPdMPj4UFxQca60eFzukPMNGNEuMZvCEtoqFV4w+iXHUr5X7Eg
         FVXz4/ailyp5Glbqx3IaNG+URZsbnX/B6xGmFaYPB0jhi7kCnGX59svnJyqiUE3dtyeR
         YMALRVMq3Rcv4s2pJjAn7QR2dRf2x68IcBN07fs2o5ZI24hpdgDW9bU4Mr4LSjXM5gdu
         pkvvK4rwtRMz/eImO/pM1GjV0+HhBypz0Lam4xoJdIl2N4JfALfx0sFjkGO2eer6k8BT
         /YozR5ilZKa+P2GJe8xzAgecEmrgrO/CP5+XQASgs1kJsJdaRPp/0UL8hcIctn+6Pqdv
         LjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520968; x=1776125768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRqvQs6ivSDyEsQUNGAHXVReKeGYQz/kj2ZPLDDhbBc=;
        b=c9RUzokFStL86CfrFJH3FZDQc06FDh3xkDhtaMnGMCvnHOMBnYtX0POvGcYX2DCYKs
         7WHQGdIuzB6JtTNzDjRloT+gLD934kMlI+ERZoAHqJe4MHQr0YgRoRGOPi56QIBBi4LM
         lgNcAs3CwhQSw/MCvmFlBiwVcGVJf5cGxmjw36YSZXNNPuLudYkrzAYY51jEZ8nRYtuY
         qqqidOdS9rbMpjZDdN3GS3Eh9NaaDGTDKQ5Fp4wpgpZqDPYPFy/Tr3Yv+ECMbBqKtQH8
         tmJ9Zh4HB/E//Iiu+mr5snYaMpFOKIXsqbPyYxZvl8vn+HVOFXE8OwyOUSGiaQ2He/Km
         Msfg==
X-Gm-Message-State: AOJu0YxMIsli7J3lpKPnjVPWvcfxOaOzz6JHPkRUntAO0FNwIv6JCXgh
	IOxejOccVHT176srbdcbryIFJ4T3AQMkyBfDRY0HLtmX1jqbyEOuRM6/bPvuWS9F
X-Gm-Gg: AeBDieuQBd8lsJ9jdIihGpjVDFO9BBUyBs5BIsnqByN0SrMs3vwGpeOZ0mcJULxoBPg
	QTDeLvosxI/MGi97CDfx0VzQcxNho1ELHJCkJ/nfvN6DKQBIXPvVNzNElOiwFlbc448ezHUXX4K
	6ATCs0sUJSSZmwYNgGAPCF4bDNkQd6oUXPJAbUoF1WCYQwPSVuVedyW2r3EIg6XbB2ff7vKow4d
	ZV6Jp4N71YbhdIban2awXtCucMgrXfdj4YHqlUWJ0DWW/UBP+shAB246pRY8CW4U95ZS8Y3WkMO
	zMGwyy3WE4awNrqRVTW0+oesxMLrboxRTHmmANzSeyHIG3BbxxDmBZk3BiqjeYaF9Ik2NbaovBF
	S95DsnRRW+2TCu3336lMo0v+FIOwE9ddkmMHxr54pTx+PGykfxozkht2r+IuTaPxt8Z5HCJOZ1S
	tZDQ1sbR5DDu9G41ByjG+w64hRRkBz1Fdv8tVEQWJD74KshVb3fUKAuCmB9Ykg
X-Received: by 2002:a05:690e:1302:b0:650:f54:69f4 with SMTP id 956f58d0204a3-650486bf223mr14232730d50.13.1775520968649;
        Mon, 06 Apr 2026 17:16:08 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:08 -0700 (PDT)
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
Subject: [PATCH wireless v2 3/4] wifi: mt76: mt7921: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:15:59 -0400
Message-ID: <20260407001600.31234-4-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407001600.31234-1-joshuaklinesmith@gmail.com>
References: <20260407001600.31234-1-joshuaklinesmith@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34400-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: D502E3A8693
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

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db7..fa5631b879 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -155,7 +155,7 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


