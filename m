Return-Path: <linux-wireless+bounces-34846-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOzIIqwR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34846-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8FC408AAE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1791F3153FD8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC139C649;
	Wed, 15 Apr 2026 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjm15ymv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518F3947BA
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291855; cv=none; b=QY46jNtL4yPEgmyTGYdddJPA48sLcoH3maw4h2Y+wykVnIPmuZtrQhBXvoWncMOIJQq2+GtKfqrRMwehbX/AYaLjoPyUlH+SFvt2xJZQe1Fx3QOto2hX2juO3qVizpNwqmys4h6sjIoMPKmFEbkiBiu2qFaBBItDhYw+K9lgb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291855; c=relaxed/simple;
	bh=FG4ynTXsoV92GU20iHTgPOQKBDGoeebi289r44xzP20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWqTsNUtpXn56GGbRYW2g27Oc3e2htJuitciVaAejWV4Ba+HXMycyhHDHCJW7Yyq5bSa0WuJLHq/AW/1fZ5bVxMAwXukV/ISxENJ8fKv1Gtz6RKAweNHFbXO/gPwcUA+QbwhEE3LH3nTFkvjztpKmm7Y5tQVyZcDnZ6iMgv2fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjm15ymv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so72256275e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291852; x=1776896652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyhVpWUhRmCqE8V12/aslzLb+WVCcpoPPQA9jie/7lQ=;
        b=Pjm15ymv9vomF+TpSe6QJgz4sZ4QHWVPkSItXX95uAngoIxsHF7IT1/b11hvbsv0YC
         8RDERqD06UGszFTKJCcEF58BOjzTHOItlVtoXsojHbX9NKFtSeoSY7jMuYzTvG/9ng6A
         svZZqiY4ZT5kPnk2EXqo7QPgvZSsHaFtIbk7ih6ChKcag7uG+8B4aQ3GOymEa3F3X20k
         dNAW8cDqepevQ6KbTkcYWuoM0ptwzFkpkAChrzpyJXsEWHwS5eleEz7rsxMeZfkx5tRb
         ZjHR/1eWTjSzWKF5gpZQQdtlWhSJY/UTXQcGXYOhbqLp+v9ZgzBz7X9zBOKfBUdwsj6a
         bgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291852; x=1776896652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DyhVpWUhRmCqE8V12/aslzLb+WVCcpoPPQA9jie/7lQ=;
        b=HzAkwRBjuu2+gzAPfhnL2CH+9yPlIBEh3Al6eu01jkTg5mgp09RFwTG1irD5aIgipE
         ty3pTVrGChvJGhW/f6O1jaj3TAIIpMBwehlu0u4AxOON0/FkRlD84iGI9djxBzkIQ4M/
         zVL7MMYPCeU6QfRzKqboDTqN+EbWp4LzNPV05jNyV+7bsXFd+VkXpq2m2mR8xkkTePRp
         wanL6BLV8YOfNkIWALV64kLQmbQ+J97OIM4fhbL6I914g6XqLUuVh3y3+TuvysrFKIUx
         PQCb+emhuRb7c/FSBFN/GLSDPhOSWgNtkEJDTzqjvBp7hAyhcIz3F5UiRU1lGfZpEL4T
         k/qA==
X-Gm-Message-State: AOJu0YxvPlrRu83XxBO9E1dicJQMmDWIo7MAYr3kpuk0741U/jwdiG04
	7lnGmYJNZFJ631U26do02DwdQNoEqQlQyDu3f0o/4h6YNyvAuK9IlUSIw2WUhi/TsQ==
X-Gm-Gg: AeBDievbJoTU7JiOESCYvfBlEMV8/RpFp574MtDTG3c81gjZOGlY97fyuK0kPk+DWK3
	iDuPY3xCb+RUg6X0dWt3ot+3hziSP4pBKD1jh9XcpCH3aHxvXuFnyF5FeJ4UoIeyTcxCiASaOSQ
	W0DYUUQoJoneJwnbDfaSVCZy/mueuI925umklfW/uJHVkz7GOVt5LHM2ITxXxso5Ix+rj1T1Zoz
	5X9XE+Zp5kPpjv1XmfI/dUk6NFAOPm5DouWowdvEZ6mJQlom5/bq5RBFFkOZj53PfkLMDG/uaSl
	71n12FydNubv0jxJJSyKnbjEYKzLLudImRwgL44ZzgbcSyT932MT940JjQh4NHFeSkWW8GiyjMC
	y0dWFI75kQAqSPJrqdknHAqIKVzH0wYlzKgZmw8pTuSej92sEShmhOoGjEGA7eyto/oVMJePQ2v
	sap5k=
X-Received: by 2002:a05:600c:3f19:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-488d67bbc2amr303603745e9.1.1776291851991;
        Wed, 15 Apr 2026 15:24:11 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm1932785e9.6.2026.04.15.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: wlcore: fix OOB read from firmware max_buff_size in logger handler
Date: Wed, 15 Apr 2026 22:24:08 +0000
Message-ID: <20260415222409.1542989-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222409.1542989-1-tristmd@gmail.com>
References: <20260415222409.1542989-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34846-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE8FC408AAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled max_buff_size field is used to compute buffer
offsets in wlcore_event_fw_logger() without validation against the
4128-byte kernel allocation. An inflated value causes out-of-bounds
reads from kernel heap, with the data written to the debugfs-accessible
fwlog ring buffer.

Cap max_buff_size at the allocation size minus the header offset.

Fixes: 3719c17e1816 ("wlcore/wl18xx: fw logger over sdio")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ti/wlcore/event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ti/wlcore/event.c b/drivers/net/wireless/ti/wlcore/event.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ti/wlcore/event.c
+++ b/drivers/net/wireless/ti/wlcore/event.c
@@ -62,6 +62,13 @@ void wlcore_event_fw_logger(struct wl1271 *wl)
 	if (actual_len == 0)
 		goto free_out;

+	if (le32_to_cpu(fw_log.max_buff_size) >
+	    WL18XX_LOGGER_SDIO_BUFF_MAX - WL18XX_LOGGER_BUFF_OFFSET) {
+		wl1271_error("fw logger: max_buff_size %u exceeds buffer\n",
+			     le32_to_cpu(fw_log.max_buff_size));
+		goto free_out;
+	}
+
 	/* Calculate the internal pointer to the fwlog structure */
 	addr_ptr = internal_fw_addrbase + addr;


