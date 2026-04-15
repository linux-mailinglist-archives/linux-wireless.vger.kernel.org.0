Return-Path: <linux-wireless+bounces-34835-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPoBNTgR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34835-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C5408A37
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827F9312EABB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292DC39D6C8;
	Wed, 15 Apr 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc0WheVI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB7396B67
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291821; cv=none; b=stkjNzzkF3P1I8fB5zQnakxWZpFRurgazQg1ioLSSTKFKahnaN8aJcN1UFCoWDaCgwTRDzIo9Av6jk2r1iHDnKXmBfrN6H6kfzTSiellJoVMt45lRJ5OUogy9CzMe21MR9/deI82wQ6uiMtKBB+o30g2Lz1E4nzPTxsl+OW4Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291821; c=relaxed/simple;
	bh=ZlZT0JJb5fcHHM0QCTIPf9Bbr5YK0JxpJ/C6fjexs+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY6kcyCNsCEGK7fxF01TLscA2TiUv6BdhiIlkPkg7eoumWu9vxVBWH3MRy9Ij877Go08Dm72e9tHgBjVdXxlKlUDQFKbI7g+Z92FPKZRNKTG2M6EcfUU8dnzhZduL7C1ylxX9pjsBV783KyCYzBk+RhvOBjtfcKJJ7VgsNaeLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc0WheVI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so352245e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291818; x=1776896618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDiHJtKHAA+Rixyk1EF2BIEgn7PGOoGfU+wLTucg4VI=;
        b=Xc0WheVIer1DxXO5yi8FT8p0uLe58wrvOIiyUhWPlxBLsIpZ3a59Ybrz9zESzGcTdH
         ODYA9imcpLF1fMfpa2ifeIPg65NFiAKNpnAEEDBGGhBcBf1yy7iP7fAzYTnCqhr7AnB9
         BbP1Yr/xidqNpd4ZBW1pOZcZuSTYZkI5Met6LHSEYh4fbyaHWcr8Mrkmej/NIKIJU0uJ
         SnpaqeVbzOzS74PThGCUfyupvAk+JlLkT2avd1goMNfRJtz6b649ntKTC9s7BDHD4QcH
         86a0hxiccrp4P2IeldAiwCmeazB6zOdBT2j1p8k2MRFrvSaYqxAolezYvO0XaMm2meWg
         TSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291818; x=1776896618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDiHJtKHAA+Rixyk1EF2BIEgn7PGOoGfU+wLTucg4VI=;
        b=mH6SOvS/GZuIsGT4jHcO/kuRQtDinwTqmFht/X2IprmwuSR0CArk3XlpImMgETtGCp
         sF7I+oN0MmnOPiTY8EVBZkLyyXGRGLOB62H7v275mnOUb12jaZ+1CRcQWNo7Lzyh2yxN
         GEkGG7vkA8yEgl8QEKD2z8HEzrCHcrj8sHMzhKfLks5zWPOTUh0h8G9jMw9KF1BAuoNP
         EohLcU1AhnRw3vVXC3f6M3DRxMo+F1lbFZ+jy3giOFqjStNOehzGSll2IO020jB/XXsI
         dqhey/TPsJtkxeHmkTGUdJ+L4tVwW6uzYybGxVUH/qIyEtWwQjx1PXTl8gh8sBi/bB7b
         /lFA==
X-Forwarded-Encrypted: i=1; AFNElJ+xCGB6YDcZhf0BrY2s2VR5Xgpgwu0wtoje1vU46QW8RRtdOOik45UQnz+O9aim5AWEV2SReZcYvYIX+zOwPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93B3aT3fgai/dpC56QzT3KNTPt0XGwp3zHaMXMzLqsUmyF0Wj
	JcOkOSLPKjcoG4rSDkEALQHjqCeeg+XEHj0+wMcgqBkeE6ZLg1e52Z8=
X-Gm-Gg: AeBDievjwpTWN6Q3Y0CCUCE1tYRL7QVFvyNZ6jMCX++iIrxjC4+ynaNusjvSx3zQA0Y
	Vc6zxQwdKVt+P4YltDTJfN9G8I2WNerepHApNFbvexq81k1NaEQzHdOLODCXnbve1yqIJsWJTMK
	R6tDoC0L4bj1qN3bqaCliWuOMuJQKurNIL6AU8PyCDPiIhWZa/qDL87pMpqZli9KWcN34snk2E4
	uFOG5LsjZ4L2ypcduad1Ha5VPEHxhFiJY8MmkIH2DUIX7itjAuzbLO07BqAoUhURh41DCbiozhl
	5E1VncvPnJ+5sjlzRGsAW87ovaiNKoEYqqsY2lFdEWqXya2nGzUwvwUNRCnFG4dcgfcu/yr+g3J
	JPpgGULCcoDlZpmgSM8MoT7SP8CKsT8icWkOtZLnygv+lj5HfnBfu7Kjomi4ihiVh4YnNt6O0Wt
	IIwZU=
X-Received: by 2002:a05:600c:6296:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-488f47f2935mr15580615e9.9.1776291818101;
        Wed, 15 Apr 2026 15:23:38 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb3842sm30160995e9.24.2026.04.15.15.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:35 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] wifi: mwifiex: fix OOB read from inflated TLV length in IBSS peer event
Date: Wed, 15 Apr 2026 22:23:27 +0000
Message-ID: <20260415222327.1539269-7-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222327.1539269-1-tristmd@gmail.com>
References: <20260415222327.1539269-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34835-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 420C5408A37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The IBSS connected handler replaces the buffer-bounded evt_len with
the firmware-controlled TLV header length. An inflated value drives the
IE parsing loop past the event buffer into adjacent kernel heap memory.

Cap the TLV-derived length at the remaining event data size.

Fixes: 432da7d243da ("mwifiex: add HT aggregation support for adhoc mode")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/marvell/mwifiex/sta_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -46,6 +46,10 @@ static int mwifiex_check_ibss_peer_capabilties(struct mwifiex_private *priv,
 		evt_len = le16_to_cpu(tlv_mgmt_frame->header.len);
 		curr += (sizeof(*tlv_mgmt_frame) + 12);
+		if (evt_len > event->len -
+		    (curr - event->data))
+			evt_len = event->len -
+				  (curr - event->data);
 	} else {
 		mwifiex_dbg(priv->adapter, MSG,


