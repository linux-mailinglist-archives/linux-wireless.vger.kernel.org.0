Return-Path: <linux-wireless+bounces-34840-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG9QOj4R4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34840-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0236408A45
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61CE9318C5F7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764E39656D;
	Wed, 15 Apr 2026 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luftM5A5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248239EF0A
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291835; cv=none; b=f84nWnbgIYmKSA+8wf3oWJAfmHk0qDJKBLiREHmcttaeTLVUtEMWQ/N3wCmsTqf4mRAxS6SpyoTaSvopgIEUXI2FdU5eUwDdLeYq2d8y9IXLe1RLL3wYRYr2DWZvZp5Ccd7aJ/kkE4SF9IfU2b7FiACSzzbC9vdu2lsI/KiPATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291835; c=relaxed/simple;
	bh=5KT4zftllyjvMTucsE6urzjf7XJ1mXJBzMbbpQp/Y3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue5srjvSgHfmYN/Ya4My9mkOXc02TV2dQToky3+VTrNbBchy/E/LbIAHxpJ+GCJEo3NPxhckq3mF93whV4EH76mGSXsaO1IrKsafSLZ26pHHoDk4b1UAAyLdxqpuXAqQLNoKZIXUN2eHkT83uOXYMW75uzPPb42jQDS0d5QFE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luftM5A5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483487335c2so80678845e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291833; x=1776896633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX0Glenf7dhcpBF0K+wa69LSV3USNbfawO60wMsqyo0=;
        b=luftM5A5ECMI+/B5ZkbQyTh7ZjTCc4Dy2oQmtmllAqOxoRjboxLp1dATCrXZOkl7IG
         bd+nmTRf7EPHpE/n2f92/Aay6BHwF7F8tvW+wOMYf6N7nbaXWiKJOCuji+oEoEi3v7pZ
         TEugTRGTEH87Rx9hxqcnZmrheO2RVjT6O4z6XQJ57RlR90zoDlWeoYl3si4PischvjJF
         p1a8sRjXs2einsgmhmUFTbQNWhGcfd5bRY8gXnVoaWkRzjpNSuUwomjbjgNpitcUYw27
         oObkE3nWgr+WgegF50BWbEAB9y9mPMDU14Of6qjW7OIY6YM45sfLVJZQx/U9KCSxCaPx
         kZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291833; x=1776896633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eX0Glenf7dhcpBF0K+wa69LSV3USNbfawO60wMsqyo0=;
        b=la9LEtxMKIGymGVWaeSSDUTHuZjtYXu12/6wfHFoFd53FSRSpgi3c7lSSB+EtJsdd9
         K5CrzBWHv0n6Z4LxRFZM12DyAtqW08SxkDbGYx8F5A8clDYpT960AQmVjTAPBigolziD
         MHGZGj3+3ekEBtNnpt/Y7W6dModhqTarPnKVxdf5sLwAXlSuCqo0K+KCOSgF5y2a1qtX
         +oBX3bMQYgtueJ0EjYi4kBdvqgMcEtSv73x4hyHWHZwM8oADjG19q92U2e8zBCCQta0I
         l519L1xzBBvbBjOasnH6TkKdDO8h816y3/xe8USEG6pBJiIULHhqHk+KvjoBUydfpmJw
         FfRA==
X-Gm-Message-State: AOJu0Yz2BRhbPCU8MnG7PXfaDSNSf5MY+Tt0iwh8C8Yu3/taF9UioWyR
	qJLjzJ+w/YQo0M4J+m4Eqy+mSidxWKji5rvJp6l2NhgtqsYYW0nRjpl5gzlUaXXZ+Q==
X-Gm-Gg: AeBDiet7jgF1eH/5QHItAi6LqjiBGS1WFxw4qO/EcitA3XJyih7ltgK4DQAUMJa3rW0
	5lIZZAzeQ3pDuWILsPPgyENVc3VPxdA+g1zn+sOPFnvZHk5ubz5yT1v0FEz7WC+vlSpFJJUSKTb
	GWa7SpUfpynua3hId5asXzhEkUMvfAcYpTsTBtoEswB73FBthcO1lS7n5xrQseNDgO5SW6cKN3f
	SekIWFd0QbmxnJhrSzm7HmLct3uu3ZtUtXjEvCg4Lxk0nVK2cicsXGxr3QxfK0OjpjKVG2rUQXy
	KHqEIN+b3JVOcb5Ut3LQB+BTFoC9TFfijUlC7lULws+5K+s0eVdo7SCPbQQMxj83Ov3LQZH8oiT
	7f37rGB6J0Sp4MrnUVS34Pk0ZYVyap54A1cSGfuZH5p486eknmQQzD0jae2De/ZLyMHtDE812P5
	zA6BM=
X-Received: by 2002:a05:600c:8709:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488d6655adfmr318872155e9.0.1776291832950;
        Wed, 15 Apr 2026 15:23:52 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm8339591f8f.37.2026.04.15.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
Date: Wed, 15 Apr 2026 22:23:49 +0000
Message-ID: <20260415222349.1541181-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222349.1541181-1-tristmd@gmail.com>
References: <20260415222349.1541181-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34840-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0236408A45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled num_msg field (u8, 0-255) drives the loop in
ath6kl_wmi_tx_complete_event_rx() without validation against the buffer
length. This allows out-of-bounds reads of up to 1020 bytes past the
WMI event buffer when the firmware sends an inflated num_msg.

Add a check that the buffer is large enough to hold num_msg entries.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/ath6kl/wmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -485,6 +485,12 @@ static int ath6kl_wmi_tx_complete_event_rx(u8 *datap, int len)

 	evt = (struct wmi_tx_complete_event *) datap;

+	if (len < sizeof(*evt) ||
+	    len < sizeof(*evt) + evt->num_msg * sizeof(struct tx_complete_msg_v1)) {
+		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d for %u msgs\n",
+			   len, evt->num_msg);
+		return -EINVAL;
+	}
 	ath6kl_dbg(ATH6KL_DBG_WMI, "comp: %d %d %d\n",
 		   evt->num_msg, evt->msg_len, evt->msg_type);


