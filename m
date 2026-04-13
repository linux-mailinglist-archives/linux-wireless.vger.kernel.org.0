Return-Path: <linux-wireless+bounces-34679-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF7UCjtk3GkMQQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34679-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:34:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBE3E6FEA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D473230067A3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64A42FFFBE;
	Mon, 13 Apr 2026 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3878paD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733F305E1F
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776051248; cv=none; b=TODwfh9+tsAt49lD+kJCX3S7WAlkRh7ihSY70/OQCAdS+NO8A+GXnou/w44qBGWfT3a4YaS3IzXZ9CtEGf/fPfS/1iz79U+JOqjgBIP1RK8A8O3WZ41y5Dw5ePbz3NYFghb9Iv6nilVfRfsoMLVlNVmu7P/B81RzGFyu6Px39RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776051248; c=relaxed/simple;
	bh=hatqUmhWF4/cUo8g2UwAbqFYgCgkJlNHohRFiygUR/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K62kuBe/LXL2UFvzlicgdSoHW5EkN7BUNOJnO8UJUcYNBhiJemQDp9cdwq6gNWfMr0KFY/H6UbFZmbBcil4Zg3ITNF+O8zGiEkawGAOzXsAQoGmDnfV1fJnw93MMxx4N+p1QfNRQ01336aaVXz0L2rQydDhu03eBfoybnAHrixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3878paD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so55054495e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 20:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776051244; x=1776656044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWai8sQZcAy73MJVvJe8OyZCghHwHKCcS0IqPiTlaK0=;
        b=h3878paD49SoOeofWWDLfqRq9t1cLiEtIjH+xrjeGXjWhdDdXIUvavYhk6iUCXstZw
         pwnU94EOhdEWu38spfPfvu7L+Qfe+wRHiDPRm1COCZEOwgOPHiCr/+CIznGzSTmN2srg
         IkJ6MoNleJ4/yoLw1z6Rx/yzqp72X5fgwb9Tkz1WciGoEwMBRedakResycIR7gznfaLb
         Nws4LMO6PL1cxYHHSevWnGFcAjcU9CgllVrVro4X3Bx0lw8RLimlA4jv95q/kL/F8efh
         clKwUS3w1S/NOwlTLIbDtAv8uueFhFcUz6huoVFkpvstu8pUcvi45AE2KRV99BDgsjHM
         0J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776051244; x=1776656044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWai8sQZcAy73MJVvJe8OyZCghHwHKCcS0IqPiTlaK0=;
        b=KfWj/FC56eET2B4jQSfVhUZfR4MuLgzKNWDAVvH2o5/ja11CHbp2VnpE0J9vkkOg8+
         kwLcGCMQnQDu6AyxbVsSTpfVHlPxzut/farCo+sE+EpTBkxcnxRgcU4YMFQ7+LcZy073
         qHOs1/t1DEgsEETJbg5JoioGtZukG6xuB1roM/NWVFFZ/Y5KfDQLtuxUP/yQJ1bEEvmC
         u2oLI2yh/9iFDq0sRzWc+SA0qz+26AAdBouf2PpZpdoM7Hoj7l7nImO6Q2s6H49cOk94
         FWynbXY7YBv2Fyn71CCwlc1rbuzT6Rz/deSEkgXatCk7QBsmLBAm4NQ7K+nsTn2A2Ak6
         r+dg==
X-Gm-Message-State: AOJu0Yw9eEYdfhOMiOpY4ZJO6Idk7mJymSjvX5UEmlB84WczS6YzbNZq
	xaHZLXtbOCYscpJxZQCPZ8kgTFYar9ChEtKdIaMm4J/9V9++0uI0XKM8Z154JpSG
X-Gm-Gg: AeBDieudcjatEpcWUWKAqDo3UqU4h6QsgioxQP+1QDGcypE7TT2YjS1zuY7S2lLEmYo
	4mNE9+0et/gVfV4R8/RvvylKXO2s6Yd8iXv9snXDCcM0dCKLROAc3F0WDPIWhozrjRIj4QrtVQ7
	s7BPfm5EZ0mZWinfWTq/5oiPCEZRuYL0BTZ4boXmqmPN2jQPoLAgKLVxRO4AwpsOBnpNabbyLso
	RxhJEiBPpErxKe8jhDKONJN9pTp2isohxHcFvVThzzZK1E+qVDJzVn+NRyYTGpDylzBsN6jazTx
	Xnx4o1LbhEDua+gr86lSVXKmeMH8eIiH9CipsM+sUkE5UjnGSpMwlwRD6K19Z2WNcJu8NCK+CAC
	BUqQUmJYssmTRefpoIOlkN4NNdN+1LKLCh4+VPECUmHCMPcJu+wcuJtlQD+F9FGvTNi6D5Ag4P3
	n3tiibyvgm4JBZUckySh1+jCO2BAOdM/sWScre4Wn+2zyA5K8ZVVU=
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr163123525e9.2.1776051244197;
        Sun, 12 Apr 2026 20:34:04 -0700 (PDT)
Received: from localhost.localdomain ([87.71.34.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm114039175e9.1.2026.04.12.20.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:34:03 -0700 (PDT)
From: Aviel Zohar <avielzohar123@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	sean.wang@mediatek.com,
	ryder.lee@mediatek.com,
	Aviel Zohar <avielzohar123@gmail.com>
Subject: [PATCH 2/2] wifi: mt76: mt7915: validate skb length in txpower SKU query
Date: Mon, 13 Apr 2026 06:31:35 +0300
Message-ID: <20260413033136.5417-3-avielzohar123@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34679-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77BBE3E6FEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mt7915_mcu_get_txpower_sku(), the response skb from
mt76_mcu_send_and_get_msg() is used in memcpy without validating
its length:

For TX_POWER_INFO_RATE:
  memcpy(res, skb->data + 4, sizeof(res));

where sizeof(res) is MT7915_SKU_RATE_NUM * 2 = 322 bytes.

For TX_POWER_INFO_PATH:
  memcpy(txpower, skb->data + 4, len);

In both cases, if the firmware returns a response shorter than
the expected size, the memcpy reads beyond the skb data buffer.
The data surfaces to userspace via debugfs (txpower_sku and
txpower_path).

Add length checks for both code paths before the memcpy.

Signed-off-by: Aviel Zohar <avielzohar123@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3532,10 +3532,18 @@
 	if (category == TX_POWER_INFO_RATE) {
 		s8 res[MT7915_SKU_RATE_NUM][2];
 
+		if (skb->len < sizeof(res) + 4) {
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
 		memcpy(res, skb->data + 4, sizeof(res));
 		for (i = 0; i < len; i++)
 			txpower[i] = res[i][req.band_idx];
 	} else if (category == TX_POWER_INFO_PATH) {
+		if (skb->len < len + 4) {
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
 		memcpy(txpower, skb->data + 4, len);
 	}

