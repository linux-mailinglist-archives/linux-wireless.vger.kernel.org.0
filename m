Return-Path: <linux-wireless+bounces-38857-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4TLQIuc/UWoFBQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38857-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 20:54:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F307D73D721
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 20:54:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=o42e7189;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38857-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38857-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14474302A4E6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29532882D6;
	Fri, 10 Jul 2026 18:54:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655C3803F7
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 18:54:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709665; cv=pass; b=QH3bHQQY1KKhSDqgbRk5ur44COaPeZspl9ijMNaHDUAdT6gJA3u7d/e+QkZ/QWD9ohzQxDLingItvnCQt1Vq/9/dc7F1b5cs6WOj4fYv4WF1Np1/xYHJcTg616LznqTPfbKJKTP38BKDQBIJU+R1/2iDTdj/iqmHkS7tp8K9c1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709665; c=relaxed/simple;
	bh=LRAJT2Po2j5jCh9NWuBWia9Uw1o4w677JrToogmZ484=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RCXSuUl+rDaAqgJ1PKAX3wD1BXuKpqBBo5WS1s4vT5h6DLdr5e5eVZu90Y4B8ra4h57aEutOOzfSrD/Azh82VHEBpsGTpXjHtYEtFHMxZNSHuTYCKwvh4OzvZt6Apm58/bQr8C8yRHQJrqNg6tBo5GnZI82Zekvrx9seJo2bRTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o42e7189; arc=pass smtp.client-ip=209.85.222.45
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9696570e34fso825294241.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 11:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783709663; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDHHc1IoD5PnhuzG9okYXYmfGadUYDOyuDcjd5YD0riPoKpez5F3eRjTXkJYuF8Djt
         AVvlq7yhYJl8VFoThk/d5kOvzts18bbfMLQkyIPlGN/b3P9klk5lUu+Y+q4k/Yt4vDDm
         U0D5gon8Ts7pQ5wH85iCA9BkiibRa2KJCXjT3AVaMufgUs064j91l51klGApmRA8VGAa
         WksXzpwYWjUDdHXwLxNRqEHQny8+y99Chx7WH+xn/aqrRNAQnCzqk+Q/rl17yTcBjeaM
         fznrZ/LcctsWFdVijZl4T3iZ8scjNPEU9YAGL27WXuORr+1Y6sVPJUgMcX7/6HLL6PQg
         Lwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=U1803zTu4Fg0CP/BNLJ3R5b7AQt4yDNGDjkErQd1zms=;
        fh=Bidx7QBc1a8GH8Lwa/SpKcXw4qdTrFobXrXIOn2U0Cc=;
        b=UtrwVErzL5Pyne4ZBMd2xF9SGKrx1HZFW2RlBrkY+0DnQvR9ov7J00PVVProacKPAj
         STPp3DURRaQGBhBWSO0T7E54FdkMv5F7/3N1O0r6KvJMvXM8ckx0WRuc0JwjRpLYS9ey
         5Mj5L2YRueH/akCRX9L75U9cWM5V6TqOXJS9vsFuIJDZAQ7CMM2WjC9kee0LWAI0+rrU
         8rV1XSy8qx1r3/o6YUQfhCMwcZ/72mG6COcMgFW5kgkSqqAf2tM2llp1FwYAfi+cP7ig
         X9I/1H8X00WEzTQ3UOVn5BSL6nxuBz5hdPHHPUrj0JSbYtG2zjHd7dCvFjInpzTj4XGN
         3Ljw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783709663; x=1784314463; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1803zTu4Fg0CP/BNLJ3R5b7AQt4yDNGDjkErQd1zms=;
        b=o42e7189fXMMP76AYN1Q9NMsymJr7KjBgFLrhHWSO0qyhKZYNe6gGIL0yJ/k5kJItQ
         cgpiC/xKkajls+CbZMwltQ/1pSXKsQLDR2witTlM96ilUJtl84gt75Rs0V5b0LPGRkdU
         FVmIts7P4t+FZmNNPrMgpHRw27NgCDQ7Fl8KngBHk6FQTkknH67gOi37PVLrXhKdhkug
         eJgcu6GskYQDgnr+LkGWPpdSPKxNPhWWUVad+JHmOpl8kah8G9EzYQ2vUeorbROUN+ZE
         0aBK/efRFjIu3X+vboEb8nukvqfblkb2yGuEtK5FllOLPatyUKPw1jOfVIChbaOgEBmk
         7n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709663; x=1784314463;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U1803zTu4Fg0CP/BNLJ3R5b7AQt4yDNGDjkErQd1zms=;
        b=WZlOlO9FgTmMrX1VOjQ/Tl+NSvNpXuvSmjtv47et1CMq9aj+gV3xF7Zi/W34B+Cs7T
         Dd5yBYPqkuFY9hi/rM/LQNwDtiRAlAxCCkWr9HEpZyUahVSHWE3U+XJ/xbtjzT7rKIJG
         zDY5XQTfBFWIYyLVp7ykQSy8HWMN9zpgbNkJT7zQKnFwnSLltDhidefqhq3CbW7rKJjW
         CEjZOnUBdKQWwbzTXtCDrn//ttVVTCWpIFfzKOw+wbfC/fLr0Iqci2eZyMre4vUwxjNG
         Mjw7LmWXxk0HBO6nZMnryfewD6b3OLwtaMhUzoL7m2h6EjRDNJBN2k9afUHvXLgzKr24
         TQTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsEtKRu48xLl+flxTJcl/+yx18hGOa/NNZ7u7jqU359wxca8UMUFmePAOgaQSXh5Q+GCvrOG+9HNSvTC9K3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVb/JjQVUThIi8wVp79cZL18mzQ8XHObgniiQ5yxGZqeAku8cw
	4LufawnB8RRwny3PX0xcaxfHIPpVuG4Z1Jp9bLIyw9aAEbXVHvEJQDdsqbaQpSHuhcJUxQ+/VTQ
	qZPAeUBpP8UvUstsE3OjWzCL+HbIsg0fhsHmR
X-Gm-Gg: AfdE7ckDQP5DIIZl1YfWw9usujRexoo2g72NRcPr3JaH9T4KlNnYFaeR4tuxvVw17nN
	WcPk8QkW4gLZM64Xt3OZYEyJd5l59uL5+sTW1uSud0NLbmCo1GPFGLEj/TLMnF742Xvr0Q6LBSM
	AXHfeXmG8NHcToDEoQOFM+2zY/Fq5vWd/qz5towDyFWNjm4ZBhofJk9pvzrIdcAu854k4ERUlWS
	MsL8kB0yMqZJYaTpiuD68I25lP5yxfj1ZSBx37e93qzQUN7Hz6xZeJtA+rg6UnPhzd4jSg33Q==
X-Received: by 2002:a05:6102:390f:b0:737:b102:c1b4 with SMTP id
 ada2fe7eead31-745367c8d49mr2858137.7.1783709663290; Fri, 10 Jul 2026 11:54:23
 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 10 Jul 2026 11:54:22 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 10 Jul 2026 11:54:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Fri, 10 Jul 2026 11:54:22 -0700
X-Gm-Features: AUfX_myFkMhQ48S_ET5-Cax5aTFnmBM1HO8JjqsVC_qYlOgexphFEfB2trXuj0o
Message-ID: <CAMyXUJmh=WfwC4_KHupNxYR5e2Gy5QhBDL5TSG6XEW-XLa+X4Q@mail.gmail.com>
Subject: [PATCH] wifi: mt76: mt7921: validate CLC firmware records
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38857-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[acharyalaxman8848@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acharyalaxman8848@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F307D73D721

The CLC region is supplied by firmware, but the loader trusts the
region count and each record length. A malformed image can make the
region table pointer precede the firmware buffer, make the record loop
fail to advance, or index phy->clc past its end. Validate the table and
record bounds before dereferencing or copying.

Fixes: 23bdc5d8cadf ("wifi: mt76: mt7921: introduce Country Location
Control support")
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 28 +++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 25b9437250f7..564dd836e0b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -415,7 +415,8 @@ static int mt7921_load_clc(struct mt792x_dev *dev,
const char *fw_name)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt792x_phy *phy = &dev->phy;
 	const struct firmware *fw;
-	int ret, i, len, offset = 0;
+	size_t clc_len, fw_data_len, len, offset = 0;
+	int ret, i;
 	u8 *clc_base = NULL, hw_encap = 0;

 	dev->phy.clc_chan_conf = 0xff;
@@ -441,13 +442,21 @@ static int mt7921_load_clc(struct mt792x_dev
*dev, const char *fw_name)
 	}

 	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	if (hdr->n_region > (fw->size - sizeof(*hdr)) / sizeof(*region)) {
+		dev_err(mdev->dev, "Invalid firmware region table\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	fw_data_len = fw->size - sizeof(*hdr) -
+		      hdr->n_region * sizeof(*region);
+
 	for (i = 0; i < hdr->n_region; i++) {
 		region = (const void *)((const u8 *)hdr -
 					(hdr->n_region - i) * sizeof(*region));
 		len = le32_to_cpu(region->len);

 		/* check if we have valid buffer size */
-		if (offset + len > fw->size) {
+		if (len > fw_data_len - offset) {
 			dev_err(mdev->dev, "Invalid firmware region\n");
 			ret = -EINVAL;
 			goto out;
@@ -464,8 +473,19 @@ static int mt7921_load_clc(struct mt792x_dev
*dev, const char *fw_name)
 	if (!clc_base)
 		goto out;

-	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
+	for (offset = 0; offset < len; offset += clc_len) {
+		if (len - offset < sizeof(*clc)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		clc = (const struct mt7921_clc *)(clc_base + offset);
+		clc_len = le32_to_cpu(clc->len);
+		if (clc_len < sizeof(*clc) || clc_len > len - offset ||
+		    clc->idx >= ARRAY_SIZE(phy->clc)) {
+			ret = -EINVAL;
+			goto out;
+		}

 		/* do not init buf again if chip reset triggered */
 		if (phy->clc[clc->idx])
@@ -477,7 +497,7 @@ static int mt7921_load_clc(struct mt792x_dev *dev,
const char *fw_name)
 			continue;

 		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
-						  le32_to_cpu(clc->len),
+						  clc_len,
 						  GFP_KERNEL);

 		if (!phy->clc[clc->idx]) {

