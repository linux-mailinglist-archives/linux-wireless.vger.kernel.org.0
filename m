Return-Path: <linux-wireless+bounces-38144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1iWClkfPmpcAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:42:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B776CAB7F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:42:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=Zrq39Evn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38144-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38144-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41DDD30E78C5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9F33DCD8D;
	Fri, 26 Jun 2026 06:34:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A662EEE65
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:33:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455640; cv=none; b=UeHVesofW5ZgWQOXjPqYf7T04o/y9WRaIDrWkPEYFfvQnQGTtnMsyNaslJ4N7XNdJ2uxw/eyaMND/pGd3WEm0yNntmtjMu0tQm/W2x3qvxF3NZhmO/7jAEr0Iaob+uBptQHByuFIy8rFKONMAYvo3E3e+KV3pIwTyb62eu5JHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455640; c=relaxed/simple;
	bh=Dm/PP8rO0dJmMC6YD4W7dea1EhJBUxWvOBAqLNS4onA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW51bW4ilBlaOXj9+CII24PQf5sP/Rd976rMqpRCZJHop4lcleUOj0CAVBnftRij5zPZV9qu1eFBq0Aw6RWLrRdXWTqPSXSH8SrSDwiNeTrRbuqAP9BpwvwTBFepTYI9w593ZzBEpKx0rh6oI4h5wZUzcuVJqUYSy8UervbGjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=Zrq39Evn; arc=none smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363fe80fe8so1423677c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455638; x=1783060438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9V7dpsteJDIU/xQ3B6Kh8Wye+1b/2UzWAzmN5t0Etc=;
        b=Zrq39Evnnx/dxAhKMmx6NctFEvxWDFooGwR5jZa3QnirCEFh1PUTPNbZB4THmmwhGI
         n8alCQgsTPqjIpqW8CUEA1HWDqWfPRF9L6LGCUiCLkcJPNTuQlQxdxuGXj4dnNJcJlhL
         V74c15iPALckWfW5TvVb3CUcRlVPv2tyWlsBQHdbSMquIan9tcQLfKnP1/6nhwdJ4zpJ
         oGoiJJ8HKEul4tnkKZn8U3SvO1npojKntDXPbEenzy3V+skWli77MhrAHNkt9rdWqHh6
         ioQ11u7gBkoV+tBn3GUq2pfyW78J2tEp+Tr2tmLf5oJqkLFlGMeDWQuCYILDaZRwzBt1
         N++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455638; x=1783060438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9V7dpsteJDIU/xQ3B6Kh8Wye+1b/2UzWAzmN5t0Etc=;
        b=irYlNY0oid8QtykouxtkISC4yO5l3dgAGJtoJDA20sdZ05Yxc+j/YyxrxFNsd0AVYs
         QAL1jMNYNrhJUG4eJwkp8AYG0iXItOoUTAkUI7ILm1T5cOpG7hBbZdXpxR/omDuSpRhw
         zOyr4/Nwe/6/QQt/RRNRZTAPQ/PzypfM4qCPCDOVMgOg2KLrmvPo+inC2K1QoFxhrUsY
         xTtR/iYpE+EydVHflTbucG9k1mY2dXzLsamc5SoIRG8haC6qEm+CP6Tc0i+She6gbPII
         Ci/yS2O2eu0ZBAuNM8Za9a0cWcXSHQh7FL4Rj+rQj48nEQTxXISNJPmWJeTaVr/bp3UX
         Yucg==
X-Forwarded-Encrypted: i=1; AFNElJ8DaFdnB4mRxEEiSqov5mOFu+rb5nHS9xWXKPjoVaY9xgCI3PYaJxV8Vq0p9P+/vR0Su3N29Hg1ohEVQbk02Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnQCB6v9SdqkVBHr9keE0fDp9zL2AhMNujzx3Eg9q2lkcTJA4
	y+HObg8X92Wr4pP+ZSRbVCgWJ0eV9xggEok1iYS+bnfjcnEy+B0snONjQ0Uq0RxVKc8FwPsCQuU
	UNRUVyWY=
X-Gm-Gg: AfdE7ckeNBGhpOnMxPXE+1zsiXKC3mXeNAGugzSz1J2PIaEO1u5WEfG+3czo5leKO2g
	X4xzCW/nmIbbM+E77ChFQ+sB1K5TXPdXt9Dkdl8dF3XXvPkKIcKHz2HM81wdO8OpjKLzNWp974o
	IK8kaovk3AAI2IQu2E052fMvF50piw9LLB1t+S0BQ/B8y9mbcIqbY/E8HTL9+/w8nIi6Uvr6Jih
	80MwRQfIB/tUuYJ+9ti0P+8Ddy4rb+8vAs22II2Vom7uSSGBjxOmy+rxq0QFIQvhBtYzor3hz/z
	FZ7rrFsnXy38rPM0iEvUW8oq/bbNz7zQAx+/xObD3GQ8/aYlQPbuac8R1XForuDzMgfLT+IL3Nu
	6YPqRdPJl/ux2AyOm8GeJ6bV6xXS/md5NkaDPhI8m19isDX82To22yXrg8W6P6R8ohC4aPHW5a7
	hlRUsUMjccRHn08ywjVQKIj/WLNlmgpczbNfNWD76M+5McRzQpK4SlPf6s6cN9yK5LJyaFuACuZ
	8EBmWMVx5DMMRRqgYJy
X-Received: by 2002:a05:7022:91f:b0:136:b50c:c0e9 with SMTP id a92af1059eb24-139dbaa51dcmr4422475c88.21.1782455637638;
        Thu, 25 Jun 2026 23:33:57 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:33:57 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 33/33] wifi: mm81x: add MAINTAINERS entry
Date: Fri, 26 Jun 2026 16:29:29 +1000
Message-ID: <20260626063014.1275235-34-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38144-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:lachlan.hodges@morsemicro.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7B776CAB7F

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb8cdcc76324..d5639668f3a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18012,6 +18012,14 @@ F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
 F:	include/linux/mfd/mp2629.h
 
+MORSE MICRO MM81X WIRELESS DRIVER
+M:	Lachlan Hodges <lachlan.hodges@morsemicro.com>
+M:	Dan Callaghan <dan.callaghan@morsemicro.com>
+R:	Arien Judge <arien.judge@morsemicro.com>
+L:	linux-wireless@vger.kernel.org
+S:	Supported
+F:	drivers/net/wireless/morsemicro/mm81x/
+
 MOST(R) TECHNOLOGY DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 M:	Christian Gromm <christian.gromm@microchip.com>
-- 
2.43.0


