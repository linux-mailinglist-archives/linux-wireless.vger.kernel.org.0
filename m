Return-Path: <linux-wireless+bounces-34821-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KByNAd0P4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34821-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F884088E4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35A58306EA8C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2A3939BC;
	Wed, 15 Apr 2026 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUiLKq8c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D095391E5B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291794; cv=none; b=dzBhhpaRRUASUDgeoKW2xGwqWTzekae1EDeL8UTaxbE6iyixW6uYUcEOPJd4vDQzyhFaOKx9k2Xd/cWe80aFR0vL+wg78bo+2HOBLlaZv1GkMW+Leqw84L5RDETs8v3JDSIHvB1i1/Kr7aKL8K79qIk9OUjR6aDAXtiEiFWkc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291794; c=relaxed/simple;
	bh=v+WiWQqP1pM6W5OvLwciNDvzrubRAtU/RrMWCdBnYOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yc76C5YXREajU44CgXxrvF5xYm5J1rRW2ls5muSOP98AvaT8Even1z58cZrJ1IK1/H79Q8y7qajJD05Ie0WkQ+nmO6hq97QE0esoKoEpACHdM4GWSn4V4m/6k6FqgQBwAVgmPAX9scqQkLwZzaIaz/5YBS8NI2CAWNhycG2nFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUiLKq8c; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d73422431so3228051f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291792; x=1776896592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqE2M6wVg51EkSQJTym+lMFIc77vkGU9+ubkmCa3Qdo=;
        b=XUiLKq8cYzYZuGJoF1GD+k8ZEKkTP1BmVc5d1gsUOS57heDJ8HVoQnYY/jeM1HOOzT
         MXBklLjskZMFjpJVweAstZ1PTABapJQCAt1PzKw06nwEgMA5dMBX32d8aYKLvLvHY2zw
         H9jECua070ld+AEs1RXmSo7dPMMdhlB0hKQT7K8JGyG5yt0tNz4Z+l7bRrRasKrwi00f
         ixZBDe6XQKuaTRUcExDuMKa/4Zu7HAQ6BA64C8V5OQNp+GZiUZkTnu//dcAeDetm12w7
         CMLs7ifJQAuz1mvHd27USS9zrukOXOYUQp+N78V4b4YPEr1rD4I0vZ79OsnHjJ1+AfEl
         eWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291792; x=1776896592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqE2M6wVg51EkSQJTym+lMFIc77vkGU9+ubkmCa3Qdo=;
        b=LH4C8eHEmT/HoCSa4XA8rCOAExM9flrkcGusXMtEUIZR9Tump0mT+4ZC+tV2Hre+rt
         R8oUgYSo3btN+bZA7JlgXISN9bMfGMtgSsg2SX0d9sqWIMP8SSQyf1X3/mQSplCTK4hk
         ME7PbtoNa5XGAilf2VZgp6o9AWHkDQXYFSrfVdaj+/pB8ZBQo488BCR6QdbEmiTqcZgb
         /3tiTegW1prjXv0xtQP2swziAsT5ZFXtftPUlnsZS7JuhN+ynRc1MjbEXi6vSMpMKxq8
         AQkIq8IKtpzLK77ucKbmrSG2Z9MOmmfQoVFQI8HO3HUrldU2VrRnlcnUei4ogprfxs0i
         9sNA==
X-Gm-Message-State: AOJu0Yzn/P49GtFMxssPFz/HH+Kw86DbDCwvg4V+DT5mi/621hP47CcZ
	pHMj8aJgVonEntM65H9fhYWdAxZjp/Pd/Ja/uTr7dyeBrghgXyDil1c=
X-Gm-Gg: AeBDievUOBhYIEQQJiYb7wx62OgLAwtpys5ArF2EkrMJ4Q3NsDpvTV/4YJLqBbfMf75
	r1npPVJkOH0TweavsK21WAogO2dmv26/B7WInynE84SH2eBejOkRmjaG3TeJI6gFd/6B79G8g5R
	48w9cB/V0GLSgMnW/1/T/CVnRc7gIDcK6KKC8oOo3cwcbFWIVEgwo20JyQyhg+Zl9ne5gzXoQKP
	5tNkswu5eii78MvlS+jRCVbDSViccoNo1tdEpxkKBKGRQsq+LoPqLwfyop7cWJg9Y7AWjmtySqH
	ubY4RBN7zLXqV5xCy/ZQHU1CDYrTHajRT2G8vWs+wejzMnFsqR5ONt46CBhT8BUbpMjlIj4qys4
	LWQ0wtxZ5nO/EwHFx9hatzDFjQvPRV+0Gsi1AhBZUQHtjUKAte1jCUcATyeJwTS7YKznIQpnR+R
	YVAgI=
X-Received: by 2002:a5d:5d0e:0:b0:43d:b0f:eb44 with SMTP id ffacd0b85a97d-43d642a4d71mr33960287f8f.15.1776291791625;
        Wed, 15 Apr 2026 15:23:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm8662959f8f.20.2026.04.15.15.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] wifi: rsi: fix integer underflow from firmware extended_desc in rsi_prepare_skb()
Date: Wed, 15 Apr 2026 22:23:04 +0000
Message-ID: <20260415222307.1537309-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222307.1537309-1-tristmd@gmail.com>
References: <20260415222307.1537309-1-tristmd@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34821-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90F884088E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled extended_desc value is subtracted from pkt_len
without bounds checking. When extended_desc exceeds pkt_len, the u32
subtraction wraps, causing either a failed allocation (DoS) or an
out-of-bounds heap read via the subsequent memcpy from buffer +
payload_offset. Both SDIO and USB paths are affected.

Add a bounds check to reject packets where extended_desc exceeds
pkt_len.

Fixes: dad0d04fa7ba ("rsi: data and management rx path")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/rsi/rsi_91x_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -136,6 +136,11 @@ static struct sk_buff *rsi_prepare_skb(struct rsi_common *common,
 		pkt_len = RSI_RCV_BUFFER_LEN * 4;
 	}

+	if (extended_desc > pkt_len) {
+		rsi_dbg(ERR_ZONE, "%s: extended_desc %u > pkt_len %u\n",
+			__func__, extended_desc, pkt_len);
+		return NULL;
+	}
 	pkt_len -= extended_desc;
 	skb = dev_alloc_skb(pkt_len + FRAME_DESC_SZ);
 	if (skb == NULL)


