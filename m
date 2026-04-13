Return-Path: <linux-wireless+bounces-34677-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEumH/1j3GkMQQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34677-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:33:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8533E6FD4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 05:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B96E3006F29
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 03:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C827280A;
	Mon, 13 Apr 2026 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOi02UMH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B3277035
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776051193; cv=none; b=I4LYGDuncQRasSLZ1mSyi3WMCy2JN3LVpfMtP1mJ59aLc06i6W1ko354LdtC5boGsTK1tHMEYA/LgiMY37n/MBVbKZZdQW1IXamKFIrn6LL0wPhntIMPYAq0qwkUnE0GUFNs1m/qv4sJWESXsTQtjugYEjOfLxPoJo4iBZCj4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776051193; c=relaxed/simple;
	bh=dAqMLNYiF5bzyZmVh9Nn7kuOU35pn5u5ePA3WzynTbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqkJdaBOdfIsr73UpiqQEC9tpFSh+nvowSCSi6F96ORsbBlL1HQHYv/gsPFWbcPsJq49rRGcG9HMwAdbfmD0x/g7j1kSItS9lNmxBLvuTPni+uUyNeb9LRtD9rnJW5DlM56OM0NAdICerjTkcBCFWiyS1qNNkTnT0+4x02RYnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOi02UMH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso41530715e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 20:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776051188; x=1776655988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jyXknkEQRieSm0PHmWno6BYuEQ3h0sr9KS+KjU9LA/o=;
        b=NOi02UMHjGGxv1WPlewpcalhHuhPIDh6lTYyGez938VcH/KEpZ9VCjeqDr+TZrT+td
         NajMxB+4xq6njlSNY/d8TZ0hQuNEv2bzdfdjHlvTCtwUtUudZCxONDjqDKjRK7aIyc/3
         UZP09zi5r6EcFcrSQFte8tlLyn2/lhtdaJ1CxwedSS8bzya9Ka4DYSwL/rizah8INO3Q
         oJeTCipdv01AnWLnzkw034JGB8k60jq9TJI2OTsiWawhZUPsPJxa4jGIxb/yWY+4cH9P
         Lj6yzGJwZqzAmUgkTRwscuSk4nJXx8CB4MIGhDMTffUqFy/KXsrWXUP9z2fquAodWaAW
         5T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776051188; x=1776655988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyXknkEQRieSm0PHmWno6BYuEQ3h0sr9KS+KjU9LA/o=;
        b=oguAQ3S1S8L0JWlWHtXssHbo3SdGrxQhQypIQxzcE6I4dS6ro8FmR0ysFnfNIllL3N
         MeEphUUSKJqjDDj540dizd8II3UqvO5/mBJiRXry9Tti0J+J3Ndnuv4SrS+t79is8yAz
         ykfAH9uQ7Uq+/iQGBT6smo0GtPNE6A0XHQOHYm0fQxYhDsjtqilTdMqMdnaCUkkXRv3+
         +dXWV3m38/iszGvxhUz24EG/AGK2LzpKQn1sQ7vBLi49lp6SEQ/+v5gVy14tjXRRg76h
         5dXM+vXk5HY3my4s9AD2934uGSRRcGCVT0B/biFmr/IGQKAzY45MoCMGhkjUCZ+t9uiW
         ftVw==
X-Gm-Message-State: AOJu0YwWLD3fM7KJ2LRNZwXM79U49vlCN0XYCAUgkHfAIFa5pCZTlew1
	9J52I4DFKgHG3RF1X0o+Owba/tID/uJ6z9R+Og7xAZGpsfZZ2AUk4WSqZc83GHll
X-Gm-Gg: AeBDietjfadjbHbAslsr1v3Whl2eOuyo7tyygYGzPfN+oWEBvRkNgBaJYwmQ8ltrtrH
	Q4MVXbqxF7MP+KXGne6dW4n0B1/9DTn080xRR/8kAzWWVMUgd/G9v3I4bRJWOMkg+VfN5XF7h2Q
	xGKxfiE6kK9coUYgr6xlK/pVi/3GrO6c06rlAmd1aCd5E6lF16C1qXb2bCAxQtFXnjJCrKAzVaj
	3rYJ+fmVbTVw5ZVC3uj52m61ymetstmA+qV2XAB8EKN4F/6nJss378usaO51OlXvR9/1UhEj5qx
	68fyW4cTRAgIRVwP0WXnJGSt/XiOrUGR4AY0ipiITUMhp9Z7QDSkWkr4uTrZxFmhgUcp9zynwfV
	fxX/CwLzxv3rKsQLIbH5mNO55UZbypcAqlQc/MjnDFX5iDGjOKOaZiG8fQUoHWtaCxT1qcygwFM
	8LeaB/j1ssh2rJFOw7C1SMBwNlm68jn8wLagqJl5DDGd1eLz9I8EI=
X-Received: by 2002:a05:600d:8453:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-488d68ae9b7mr121137355e9.11.1776051187989;
        Sun, 12 Apr 2026 20:33:07 -0700 (PDT)
Received: from localhost.localdomain ([87.71.34.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d6ee98sm114039175e9.1.2026.04.12.20.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:33:07 -0700 (PDT)
From: Aviel Zohar <avielzohar123@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	sean.wang@mediatek.com,
	ryder.lee@mediatek.com,
	Aviel Zohar <avielzohar123@gmail.com>
Subject: [PATCH 0/2] wifi: mt76: add missing skb length validation
Date: Mon, 13 Apr 2026 06:31:33 +0300
Message-ID: <20260413033136.5417-1-avielzohar123@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34677-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB8533E6FD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses missing skb length validation in two mt76
drivers before memcpy operations on firmware MCU responses.

In both cases, the driver copies a fixed number of bytes from
skb->data without first checking that skb->len is large enough.
If the firmware returns a shorter-than-expected response (due to a
bug, partial DMA transfer, or in the case of mt7925, a malicious
USB device), the memcpy reads beyond the skb data buffer, causing
a heap buffer over-read. The over-read data is subsequently
returned to userspace.

Patch 1: mt7925 testmode - mt7925_tm_query() copies 512 bytes
(MT7925_EVT_RSP_LEN) from skb->data + 8 without verifying
skb->len >= 520. The leaked data is returned via nla_put()
through nl80211 testmode dump. Fix adds a length check before
the memcpy.

Patch 2: mt7915 txpower - mt7915_mcu_get_txpower_sku() copies
up to 322 bytes (MT7915_SKU_RATE_NUM * 2) from skb->data + 4
without verifying skb->len. The data surfaces through debugfs
(txpower_sku, txpower_path). Fix adds length checks for both
the TX_POWER_INFO_RATE and TX_POWER_INFO_PATH code paths.

Both fixes follow the same pattern: validate skb->len before
performing the memcpy, returning -EINVAL on insufficient data.

Tested by code inspection; I do not have the hardware to
run-test these changes.

Aviel Zohar (2):
  wifi: mt76: mt7925: validate skb length in testmode query
  wifi: mt76: mt7915: validate skb length in txpower SKU query

 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 8 ++++++++
 2 files changed, 13 insertions(+)

-- 
2.34.1

