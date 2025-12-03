Return-Path: <linux-wireless+bounces-29465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C9CC9E1E2
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 09:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B53430BE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D75828CF52;
	Wed,  3 Dec 2025 08:03:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5423AB81
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749006; cv=none; b=aACWpu+s1vHkAI93MV8mdc8AmB1hGm/gmoa+J9ACTfObPnlaHfh893gK7pITSfEuMSPWUdcQDsGuvPmwc3dokxIFeSamUFe0TojYm/KVLrf+rj7BnOYAgBcn0QB736jh1b71KRDzjg5tp0XqXNTbHLPOELt7c5XbldAw7dQTAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749006; c=relaxed/simple;
	bh=tdPme/ThRxECWR8P8pMIEkM6u+EOQIn6IVsS+g9RfJ4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=d3hmDb5von4lOJb6duo74pjrJPccPTSLQlSJWeSXwJ3OFu30lXmv7IszybpAD2+ohXefqQSv9QBCIJoz+UEXh7xw51g995Law/4GNpV2ffIvnuWoKHTUL1LHdptJDd1uuUscXHqlOQA9S5Bq2fH3Sbtxaz3ijgLaOtSbIsmRZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 4C0F536E7
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 08:57:10 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 400F73669; Wed,  3 Dec 2025 08:57:10 +0100 (CET)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from sara (h-62-63-215-216.A163.priv.bahnhof.se [62.63.215.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 174523668
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 08:57:09 +0100 (CET)
Date: Wed, 3 Dec 2025 08:57:08 +0100 (CET)
From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@lysator.liu.se>
To: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: wlcore: ensure skb headroom before skb_push
Message-ID: <097bd417-e1d7-acd4-be05-47b199075013@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Virus-Scanned: ClamAV using ClamSMTP


This avoids occasional skb_under_panic Oops from wl1271_tx_work. In this case, headroom is
less than needed (typically 110 - 94 = 16 bytes).

Signed-off-by: Peter Astrand <astrand@lysator.liu.se>
---
 drivers/net/wireless/ti/wlcore/tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index f76087be2f75..6241866d39df 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -207,6 +207,11 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	total_blocks = wlcore_hw_calc_tx_blocks(wl, total_len, spare_blocks);
 
 	if (total_blocks <= wl->tx_blocks_available) {
+		if (skb_headroom(skb) < (total_len - skb->len) &&
+		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
+			wl1271_free_tx_id(wl, id);
+			return -EAGAIN;
+		}
 		desc = skb_push(skb, total_len - skb->len);
 
 		wlcore_hw_set_tx_desc_blocks(wl, desc, total_blocks,
-- 
2.30.2


Br,
Peter Astrand

