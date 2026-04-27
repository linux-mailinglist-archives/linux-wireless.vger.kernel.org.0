Return-Path: <linux-wireless+bounces-35333-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGn/OS7x7mmm1QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35333-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:16:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5262346D22F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2E3300B636
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 05:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1707358372;
	Mon, 27 Apr 2026 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un6RN+g2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988531F30BB
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777266983; cv=none; b=ulh3Z+6VpuVqXGtaS5ySJv/DPwV34VhOdVWO6yCmixUGVoYq+DssJJ72dpkEQRgS3XZ3+oDlRjQNNWek4Td/OqdvdB4qVGxHDicB9XARwCNHlFL6Ex9J5FpCA/Pq0JtAvTdzl7f1he42NpJV4V1q5fF/K9xXFW/1i2TwpFd1tQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777266983; c=relaxed/simple;
	bh=SIgsHZc0c1Yvp5AexZ5YnZA5aW4tHda22qDgOUpXYbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8BNwmLFDemTUw6rAAHUdsHjfkhtvmYPArQtmj/5XwTnv9RGbYo8IX1q0XOHBdGi6KsJ9jf7IGabKV4g89Q6VBc4np+YyOW+UtwnJ1upeKp5oTaa2pZQzsinhFuu0VT2kcjOCBLR0FhuMQlkIf0tNXRmbUO4WD6DhdpfGFfkXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un6RN+g2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so6356589a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 22:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777266981; x=1777871781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEjsVEKpoc2tSFqCgemiaKP4DRSD8yZ2Ft9223GxMWA=;
        b=Un6RN+g2yiReyEYg1Fr9vDunxzQrXdh20NlLLhJFqNdPV7FFLfIvh2d4zh2UwmqyNx
         uFCXu1MngFn/qahv3xvQ6lh9jivCNYwpGKOHhyaqij60/LATKpl+rNTZ7Ge0+ZeQJ3Xw
         6dDWOcTCuSBo4XZK+tPyLQ/0rJEjbr9GxF9hYa+4yJxFGSTFFPSGb4h0TIyrO0C0VA6q
         gaHpCW31YSU8rywEwc2Pt/R896UupLvOlpUb6DEKkuds/vSQPPV0VCGR4jkuzOG8FB9g
         AUXHMhj8NMqrYUAWo4710YSa6pfLaoJBwbLBqAGsYQT27ogqvLePvgz2UgPRqTT/U22E
         lkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777266981; x=1777871781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEjsVEKpoc2tSFqCgemiaKP4DRSD8yZ2Ft9223GxMWA=;
        b=ZV4z0RvJbCAubalijHJ272c8TZPHEW9CojoOJRRZAmL9d7ks0bVnGdVBrgiWiErO+7
         ka5EI5+RAujEI8iBshXYY5TQFv8sTQdkRwRszByjZrgPdq6jNI3JZfwxCL3zJbYyP7Pd
         TjkIMmzCvpO2wZwM+Okc3RT9Lqc6VGifgr8eqJNe4GuwjjcTeo+0hC6igJVcXr2q7UrK
         1HJtLzfaqfooPqn3D7srj6+Wu+J0HqPUcgMi9aS78UyPT5udTAY5/zA4RRbBPZfp7WXf
         mZm7I9pL3ODe6uH8jkmyXdqkB/UnC3X78LLiKBeBNHpJzc7RWhU3wlhwlr/34zm1s8BF
         PzWw==
X-Gm-Message-State: AOJu0YwB3FDj5FKWGb2gX2do+qtsWHTtMI+euhBYzc6+bwEyd5rdophA
	bg+xVCfWCdCIYZCizuG/nyGOa/TFTMYZ/KWo4vhvlgjDhuPa3IByg0tMIcrOiA==
X-Gm-Gg: AeBDietUKgX9jo1l9NHWr6dTGgi6gc96QqMJGSLtmxc7uOr2K6pDD4ScvFbYuHTbzsc
	o2nFl/0ghLLZhMCtTYLD+p1BblnTzjAfeU3YQZkZx16zP9KaelJW1kolAgWzWL9VeuNt4CX6WsJ
	I/v/dkq+zPs4vmFiNqpaxNU6SCCkF7Grjdz0eC9VxkXmNxF68tKTYviYkXRTbroAUbDVgKny+O2
	JLpD4y7GUifI5ue7wWMKWPQIYskkGCfHnIpnazw7WjWx22OjGvek2DhL+5FnrOouWQ79TepVKRK
	yxrJ2R6cQ10yLeJpAuIYnO3M32heccsIFI7/asnwKpCfT9A6oLL6wH7krSMiSHNBkPRmp3KWiB/
	Q+HO9ckcJzidTS1F1myeesGzXEux7GwOcQm+dhcAarI6/KG7U9w0TuAUnkgP9ioPjxxxlq3BPyY
	+KO8icaJymxuTX5OOczWznKh9QE4EXmQQn2EQjLvgQ4APCJ1LLZROfKfgOQV6nBqX4KQTY0wH9V
	cBz1P8xfTXl3xlOK7tCdsgd5w==
X-Received: by 2002:a05:6a00:e1a:b0:82f:5e92:c642 with SMTP id d2e1a72fcca58-82f8c90d15fmr45566079b3a.41.1777266981506;
        Sun, 26 Apr 2026 22:16:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9fcea9sm38266874b3a.23.2026.04.26.22.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:16:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] wifi: wfx: handle EPROBE_DEFER with of_get_mac_address
Date: Sun, 26 Apr 2026 22:16:04 -0700
Message-ID: <20260427051604.953450-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5262346D22F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-35333-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In case nvmem gets used and is not ready in time for probe of wfx,
EPROBE_DEFER gets called. Return it so that a proper MAC address can be
specified in such a case.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/silabs/wfx/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index dda36e41eed1..dc40a9bd986d 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -445,6 +445,8 @@ int wfx_probe(struct wfx_dev *wdev)
 	for (i = 0; i < ARRAY_SIZE(wdev->addresses); i++) {
 		eth_zero_addr(wdev->addresses[i].addr);
 		err = of_get_mac_address(wdev->dev->of_node, wdev->addresses[i].addr);
+		if (err == -EPROBE_DEFER)
+			goto irq_unsubscribe;
 		if (!err)
 			wdev->addresses[i].addr[ETH_ALEN - 1] += i;
 		else
-- 
2.54.0


