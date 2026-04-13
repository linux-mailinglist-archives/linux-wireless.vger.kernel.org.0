Return-Path: <linux-wireless+bounces-34678-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPr9HQxk3GkMQQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34678-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:33:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9043E6FDB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7675A3002B3F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 03:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A628CF4A;
	Mon, 13 Apr 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5NoowPM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6927F4F5
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776051208; cv=none; b=ok8n5oWRpD2snDVXMWsSs2LXxU+oWlygfcwja5w9SSXBxYs3lqu20hFXfATHP0mAMzDA7fQtZc35Owa2T56faZeHCfgbZS4fceVsGe8JdkPwKRFT6j99H/soMrZyLfc6K8Fk6/9NlEW7B1L9MYEeFyGgq8zV/mAvcBVWdjU12GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776051208; c=relaxed/simple;
	bh=IquXKuL1WSHvwtlc+qo372Er5wP0l5nBUjrlQZ1NTaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2+E2FDFetWKxFCczqBdSjG0VYypyZCrqA0VeFTZyvlDOtVEJYlAINpweiPdGshD3h/pLCEJzEoy91XDUvP6By1+gF3ekzeesrlANT8ceSg1KGYyJNVOHy4BRnfZw3PYKndYPmIcBpsF7W//DvGb9Kjwqck5PW+ZxvArfAot6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5NoowPM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso45765795e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 20:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776051203; x=1776656003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZQu15h0T7n1r/lM2eLKIfO6SWwPWy/aPZ0wiJ3s708=;
        b=Y5NoowPMbnLJe2rF7LkBXfyeOaAbeerf1S+QKiaLCrzwQEA4KoAdDIzoKTm1WBEwzx
         nKI/EHsfioZMq6uj24YTJguRVhKStE9zHXWSnrWKStDR9aJ80QNzE5B9JUWSkqdvh+kz
         EQONFj1haQk9cp6L+DVjhwxx7LU5yz32he9K35YfkchjFLZ46dZUOEUvOJMh4dNRdrs/
         kl5De8pLhcQavm5VFoNZxSFeV11ceL+LGQvJGjNWFHSpZmQccg04apDKD/XmX2tQHwYN
         qM1E/M1GvLxg7XjHF6EfpIeBaQG44OyH8EKTxfiNL4MMIBz4RWSn1tsJY7gMdHoijnCa
         97Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776051203; x=1776656003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bZQu15h0T7n1r/lM2eLKIfO6SWwPWy/aPZ0wiJ3s708=;
        b=INr8IjWna+u+wyPF89I7tOP5EBSX07xZDlSa39aWuPGXFPUBZmKw8Qqj5GFOvN9RQR
         oLxYLjh/DRkXPGGwYgkPlm27BLImE3NH0JNRULhm5P/rYplagrTq17Wt+Oq7Tj9HMQSd
         ebc2ZfPFKsNGronelKdYgISoxug8cwwWefq4iorg9dZ5dYO5biMoZ6kRUMJy9E0Tkjxi
         dFHV6qN953JKfgPGCPJesKOJcQynV86SAJr46WsJbkSO0q4geSI0WDbk4y09r3WFOkws
         Cc4OV//2zzxwcsVWQvxNdI5r4Jo/970T5MgtShipGPHrTgUjsbUF3DzKKzfOfCLnTn0k
         uKBw==
X-Gm-Message-State: AOJu0Yx7mYUmX5oFcwsX0XBIoRpwp8i2xkSys0r/GLZ+yj1wBqzxJTzj
	LITJafGkyYuQB5Sg5AzYf+I32lnnHNA3CfMEzkCP5lmXouW/1TIW0e4lmUWIcYKZ
X-Gm-Gg: AeBDiev/AkLpBuRJxQ0fP0RdrNJB3NZsc6XZU4BeTK+r5gn+dvYbpa5W5WIW/F1mLu0
	8DVwZPlr9289xZKfaebiUkNzxQbZWqgY9LFJp4MBoxg/uTW6zCgjEPWhUwskxqs52UfUYcwMuCc
	AUWETIq+P8VW42ZYw1f44bqhg6KGmY+ZlFxSBfsx2Mxjmy04oIwOO19HVndBhz9t5/c4p+W1t+I
	gNgChX33pYaw9sA/uUgSaoNPVpW3GMdLqmLM9uXeuPy/AQunBw15HPCEJ3iqlxeIxrLOwS0+jeA
	Zeboe3LH+Myn5/q0lj/9gm+vP676maXixr9LrWXZsRC2XoCnkQvnOZBpUWmV/ktb+XTpuOnfpVn
	BH1/zDLtvGG90R9iY4gTzAJf594rjMW7FuO1gHK9SflabcV3dac0M6cVBHfpvX4Wwmd2ySw7h6L
	4G6YQLmRuYak8z+CR1O+KblU/NkAjHkWSd/d4ctEnZ5ZhUOFl0V2g=
X-Received: by 2002:a05:600c:34cc:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488d67d882cmr165716615e9.8.1776051203129;
        Sun, 12 Apr 2026 20:33:23 -0700 (PDT)
Received: from localhost.localdomain ([87.71.34.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm114039175e9.1.2026.04.12.20.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:33:22 -0700 (PDT)
From: Aviel Zohar <avielzohar123@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	sean.wang@mediatek.com,
	ryder.lee@mediatek.com,
	Aviel Zohar <avielzohar123@gmail.com>
Subject: [PATCH 1/2] wifi: mt76: mt7925: validate skb length in testmode query
Date: Mon, 13 Apr 2026 06:31:34 +0300
Message-ID: <20260413033136.5417-2-avielzohar123@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20260413033136.5417-1-avielzohar123@gmail.com>
References: <20260413033136.5417-1-avielzohar123@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34678-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avielzohar123@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A9043E6FDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mt7925_tm_query(), the response skb from mt76_mcu_send_and_get_msg()
is used in a memcpy without validating its length:

  memcpy(evt_resp, skb->data + 8, MT7925_EVT_RSP_LEN);

where MT7925_EVT_RSP_LEN is 512. If the firmware returns a response
shorter than 520 bytes (8 + 512), this reads beyond the skb data
buffer. The over-read data is then returned to userspace via nla_put()
in mt7925_testmode_dump().

Add a length check before the memcpy to ensure the skb contains
sufficient data.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Aviel Zohar <avielzohar123@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
@@ -105,6 +105,11 @@
 	if (ret)
 		goto out;
 
+	if (skb->len < MT7925_EVT_RSP_LEN + 8) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	memcpy((char *)evt_resp, (char *)skb->data + 8, MT7925_EVT_RSP_LEN);
 
 out:

