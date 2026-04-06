Return-Path: <linux-wireless+bounces-34391-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDv/E4xG1GnVsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34391-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:49:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E250F3A8529
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988F33063D5F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB73A380A;
	Mon,  6 Apr 2026 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUp2rByL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90D3A2548
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519274; cv=none; b=JSVWT7F3EemuMdwVoxjMBAOyVLqYzPAah2Nu1/MvgQV9820WJAoz9Mpy6mJztYb7/MSpHsq/eOOfp26Ekf1u03RToQz7/lwF6KmhJrtvXfH/9nnJ3iQ6Q29WjYfQRFh8XBbZTxmb55q3SIP8lOgCloTeKV3O113hgnP1sX0cJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519274; c=relaxed/simple;
	bh=jcpF1sZHHWf1OwVn8dXWeZm3vgEO/wJOncyayRAHT1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9ZCG8zfthy/LpaXaKezHRRrq7WtcPjw9jBZz+CCCGt9dq6rk4QC1iqp9y6hByb83eGWYJIcUdtEuksFZnOw3TJr4AxI3jarzS91PEB3ogLdON/WAU0WogK/9FSfTRrXuSiMoenhRZsVEXrHzyXpA2faoCn1VK0YmSVN44D7pDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUp2rByL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7947cf097c1so40250507b3.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775519272; x=1776124072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxwuaqOVriBYwsFBn6+xbKIu8945UDO3QfFnEekL/38=;
        b=RUp2rByL4R8G3w/V5XAQ0swoRqwik/amTIZppvp1RKdPgIO6tf1OnaKByMLKvgK7Zj
         h8vOmmv0ewhDiu1LDe3Nn4uMuhdYEcT+Ob++vkHqlpRCi0oHGTj31YpgxcWxFXqsSYn5
         3rZ16Z4FCUX2tHsEQvx888r5yrHwTTO1pIuqkjXHAZdplhhHtHv6WgmhDLEIRH42yyM4
         ROzesdenmvnCPCHXIt6R+dpPR+atugmizWz2E/D6+JEjwJT6A1PyDCMt8SLNoPI4GmM3
         6eRCR/6ytYkqeijYDUcEx+7FP1fsaPDmhMbASd3gJ0WYiiAldam+AOnDu+87F0aXEFnG
         n1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519272; x=1776124072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YxwuaqOVriBYwsFBn6+xbKIu8945UDO3QfFnEekL/38=;
        b=W4Da1qwV6OAhgumWlQa6Hd+LxGCybnJVRggC7AHnzpbitdSJpdIyX8kyuRdC0OzNf5
         C8uBNSMmvv3Go5TsorLQYitJlVsuxu4cT9Aojz9tJn9hEAHbr/EoPlFkfpC5NDf/QM7y
         ImjHtyvZv5yL+f07s5M1uOl3B2UnPCg8lLPXUPQCnw/klfjsV6lxmCZFBjD91AYPvjHK
         R4xeKTj3fIJBH0CbXZuBKMJ1yF1GUl8i9XnMOfiJA1DIrjGJUswcz31+xu1CPKe9piSZ
         DyIYkZQSzdXJzbI6j1d5hZW2Xg9AsOXbgKf/DQNO0shZ7kRPAVAWtSZqbQw85kEyMn00
         vwxw==
X-Gm-Message-State: AOJu0Yx2Qv3vZx+zFU+eY43Ql9O6/g99fdJM115TicIQQmurz+b0gBl8
	aQgM7JkpchXoEhFVjA8foj8LNGMELg9rGFJHOOTSPJ3QrDMxrWYsbBH5NBW7NMbR
X-Gm-Gg: AeBDiespZD5IvnC6CfkmvQN/aqWKBZ5MIWkXYMsuJ5ciVpv7r03F75oV3AcMp92ZXEs
	Fy4h/u0dutI+Ow64JaV6clNKVbPKX+NnV/oafXtn48YaQQ6QDrXT9zngOOziV4RsTZIvn0bStfv
	+KrQ2W7YI3vGKU5UGxz3SEs90cwFwaafava1O6SBcU6gNH47Q0rwM95u6kNRh+Qxzg+0Sv5YIRH
	i+keBQ4TOqPSHjrwjL3EbziAeVZCkqtlpB5N+bApupjLAJ7o3HMOYpT9JsS/s6/pRN8FuDpDwqC
	wAAIbMfrprlqfuFm2f8t2YJRC+TR4d58YL+oTQbCZZN/+6cnc18vOHmokVeqg7ZphfKyBzpXZz1
	ERjIZjgLzf1HfAdLkQiM1STedh8vtKD0ARZuaiL0TCyocVRYkdx9NdwqBmhsgHRtTtLl1ZQDT5g
	dhxZ5HV2H2W5jMeKtX/H8TTI8uwo5M6FyZrYE50sfEAN0mxeazaOFtYcp8ZDDu
X-Received: by 2002:a05:690c:e3e8:b0:79a:ac83:ac84 with SMTP id 00721157ae682-7a4d5d5aeb7mr151996137b3.41.1775519272091;
        Mon, 06 Apr 2026 16:47:52 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff31sm59350177b3.6.2026.04.06.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:47:51 -0700 (PDT)
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
Subject: [PATCH wireless 3/4] wifi: mt76: mt7921: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 19:47:38 -0400
Message-ID: <20260406234739.29926-4-joshuaklinesmith@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34391-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: E250F3A8529
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
index bce26389ab..7a46b50171 100644
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


