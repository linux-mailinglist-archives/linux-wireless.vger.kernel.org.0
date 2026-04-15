Return-Path: <linux-wireless+bounces-34843-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO8ADV8R4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34843-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE085408A5C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F19313879D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699B396D19;
	Wed, 15 Apr 2026 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpYq4FNh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6443947B1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291844; cv=none; b=WhfbyzwEPcQW8Qu/gFyonWH/DDIzpaK0+IS22ibraZmu0snoF+Mhyi/zbliHZfHCCf6cclxHL9gZoiaq9ZGTBhaqHM2lLDrH9GVrONsiiPoLYqiwc4WwbY7+gPuNLwI8BWZ1vOewcwEmuvC3dYs0O/74ejz0lQkPw/jMredmA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291844; c=relaxed/simple;
	bh=eLK8vtWrqe0f5ic7w+UWvm0VTGYRxuEc41R0Mr5KBso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmBMJ8jkbrti4uwoaAHwrFRTlCofaBaa3fZDdhp1PWTio8+0XzFk6aBVUC8RETkedrqyqikGx3cByArmsFUqLZNU9EMpbKWrMlgr5GtEJ558UL6wDGaOGeSk/7ixnAJsNZuN3FukTD2o+Kt5AhNnQKwfzPBYMVEM1V8eRLs/cOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpYq4FNh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso88709425e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291842; x=1776896642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWcnH4m44tyV9VYzXrBOMrFkiquZg1n+VHDLnpCe+x4=;
        b=hpYq4FNhOj7ISUCMspp3L5xen2dy60OFPS/h775RntpqG/K2y1bEr9OFz1SqYbGJ3P
         dzLcIgymLv47bFV45ihCRpltLdO7kYlxeT1i9g+6UrlNdjvu7ZFIMz+yhL9BheLFhyCv
         d3EYhrnRWHSfpxS4Ub0Q/rJDjv/iAnm7F7Ozkvt02REJpoCR9awQ7D+GHHmD9uqTguEm
         /xu+bFhY0N3t3d0KfVE5qiFJJMkjwPpff7kn2uU0npoEAQ+qU6u4mxEd81u81DjMYie/
         BX47AgQNXYw+Sv4aFCH6CUsRJD4+/tRqURHNAhHOH6v5OD3zeBWIgbsNZFaOk3Xd2tHs
         EuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291842; x=1776896642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RWcnH4m44tyV9VYzXrBOMrFkiquZg1n+VHDLnpCe+x4=;
        b=sPwrIgfpu7FdHkpc9I/0WTlB0CIaiiIE3dN6v1T3uQFnP31/1iTYWRuk3xKO6odduV
         0RQjSoXbz2/XS2kykL8QZ6yWeIUnoIy8IV4qx2rfNN4/QUN9yGnL0wjeEarSJ0hOrKyV
         0Gg/LfCUGVcsPQsFHV3ov1qV0642PA6ZVshxQxmA/P+Wbg+Sxqgurg6aD7OJrIl0LSKi
         m4gLqWhksCxVDpbxC0+FG7/5L4Z60q63L5+LecCpCL2NJWMUYNHuBs0UP/v8UkKzjpbD
         2sXcaEcta2n3RT98XKF3CvgXJF7SQLaw5rHaoHFR0ePBKWmN9ZC0d0YAk/qxL6hMN351
         +WWA==
X-Forwarded-Encrypted: i=1; AFNElJ+F0Dnj/9j4YEU9bMrLAGNiKgiK3IJS4H6LKvd7rZ87LHtJEstFVnqQ0ge/5bTztGfWFYIqi/qSPnjqmigiiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xiiTMRIfndXoCiMcgylhVyPndu8RC97a/cVbnBh+pZOD2wQ5
	jmGlwGBLzdtso4F5yAgpyWoo2wKclNv2RriZuP3aj34qxGboEpIJWd4=
X-Gm-Gg: AeBDieswaKJIdfD+FHdyg7glLwOZL/Vi23pVSWiiR8IdP1NqzdT4PrpG1Vl6aFkrq06
	Sft7hCjU2GRRsP/MM8bseWQFfWpMqemOWz0YSQ7qMKqVAhzr2nTQLY0Odt5skGM5i1glD2hZgvI
	Gnf/evrqOHefKK6rnnrTMhZYZFR3QjG4EouEBjdpTY/PCy9V2U2XDdU7VQLXXQzgHgRLGb99rrc
	mxPi0M+wGtRgSluopKY9sj1M19XAYQebzyIZHAnpO6uhaPTLlwVefCehAUM4H749s2Jwp0in+cx
	PSjie3eypyy3bBA0NvFNG+O/NrGh+WBJ8VhVtgdcuFvryuHViWX+QSlUThPi1ZuBWSJugVEzFMN
	Y97MiBSofy15MsolU7LY2TbgqMLKkoRJY6R6RnmaPxs8PK6XKiWYPdhLUcCWKAnCce5wcVPnikC
	M7aYg=
X-Received: by 2002:a05:6000:2305:b0:43d:7946:badd with SMTP id ffacd0b85a97d-43d7946bb95mr20836550f8f.35.1776291841970;
        Wed, 15 Apr 2026 15:24:01 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3dfff3sm7613861f8f.26.2026.04.15.15.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/3] wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
Date: Wed, 15 Apr 2026 22:23:57 +0000
Message-ID: <20260415222358.1541983-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222358.1541983-1-tristmd@gmail.com>
References: <20260415222358.1541983-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34843-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE085408A5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled rsp->count field is used as the loop bound for
indexing into the flexible rsp->regs[] array without validation against
the message length. A count exceeding the actual data causes out-of-
bounds reads from the heap-allocated message buffer.

Add a check that count fits within the received message.

Fixes: 43efa3c0f241 ("wcn36xx: Implement print_reg indication")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/wcn36xx/smd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2803,6 +2803,12 @@ static int wcn36xx_smd_print_reg_info_ind(struct wcn36xx *wcn,
 		return -EIO;
 	}

+	if (rsp->count > (len - sizeof(*rsp)) / sizeof(rsp->regs[0])) {
+		wcn36xx_warn("Truncated print reg info indication: count %u, len %zu\n",
+			     rsp->count, len);
+		return -EIO;
+	}
+
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "reginfo indication, scenario: 0x%x reason: 0x%x\n",
 		    rsp->scenario, rsp->reason);


