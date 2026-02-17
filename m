Return-Path: <linux-wireless+bounces-31917-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI4ANevSk2nb8wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31917-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 03:31:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E071487CD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 03:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A46923015885
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA214E2F2;
	Tue, 17 Feb 2026 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI3A592H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386B199FB0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771295464; cv=none; b=mZA1cb4XYtrJ2JdB/o9k+eUHbYZBvH40risgXMvWTstT6+tT7FFf/ZqbNHbEaRVhuqb5ak9IPXu29twrF6u52H6rC3QAG6B7rABxQT5r5GItrHxMSh4PFU8EXWQyYCgXFsKIcQgeNOhhlm+jIf0Q3GmLe2VmPgTnb2pcy4+vEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771295464; c=relaxed/simple;
	bh=kObS168gQBNE3xpbI2vaprxcEmPUWL2LSLVxVbKppr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlGUaOhQmnxX9u4R+IY1SDKP7k8yxzymrCrSKcLaZpmdiU8z1f8f5I/tcp7uS+Tm+YZIns6gML1qFirkKtVVW5EA4/ZOPWhYCZIYAFyu6lwXFUliWnRWoNw927mH3+SVZyCwMSf4/Q2fYAzfiF1t6kzgMIFA2YB4sii2iiTWBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI3A592H; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797d36fdb96so13828877b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 18:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771295461; x=1771900261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1fworB1P/Jzlnt8opUorAnuBCM+SRM92++aaBkD5qF0=;
        b=eI3A592Hj1vFCSBKcwrw0jB9xsAgW4ZDNQX34ugMeChWPUm0eZW6gZKZsc7P8CuKHT
         QoFK9W4j2XPEHrb7AR0IaKfx07yOWm+UBN/ysFcKz9rv33DX3+OnBkQcY0I2QXG3s5El
         GIpIzuR5TceiRq7T+PukVDnoWDwyLIAZKPgX3iEGYGU/aWvRaL2Sn3l0r1sVmzJcNhcI
         yg/c3jdQ5AugKbdklxX9ely/JaAlPQRynoHgUJy/pw4sVuUSzRjJ3JjDoRue7MVsQGC9
         MBXvxBNvq3euG7wdsBfeIGU/L2f09J0fxsH8sL4po0XTuE2lr1wxbM7yuWXinh0ZsWXJ
         P7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771295461; x=1771900261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fworB1P/Jzlnt8opUorAnuBCM+SRM92++aaBkD5qF0=;
        b=jc4e/hWKryf2HfovIZeovN8v/aNer7RqUpDcmIBlkA/49FJi9MjfsiR8JEaOnUo6T2
         59jdOm2yxTbySapbZ2nNAflYkSQc5bVq/aVPlRSb3OdVkPyhyIdDClrPLtJInZ+bn3Am
         8bIM64WYXWb08VUCwPBnL0TFYq63hU7d5F3XzBVyrKl55kJ54Ofm1M7KW0gutoxFaT0J
         YGPM5eozKOt1WnDh+HPeivKBxFYffRhHdR0h6iHd4v+0QyPWU6niJbey8MQnilYKxXB4
         my07hY/VlD1AevLNJPP9iqxizzeO3Fn+tffmDffBrE0xmgLgS2tx8eVCcT+z/ZbY5eEm
         rQ4w==
X-Gm-Message-State: AOJu0YyhePjFsngj4YuZ6CTSFu4AldpCGXBoGmDEWJm6somHktmvrjYB
	PlrX/uGxeP3YjMulyp8/uNHL+ip/3ak8k5ht3l6Bg1o0QzFUcPVAotKx
X-Gm-Gg: AZuq6aLkBhX3/W79T40XmNiOdc3hJqSbkdTAHSQoQ5Thpd9i2GhxgDtQSvWZp9PvD7m
	DkRTWDhX8vlZoOx6jrLnwSRiZf22bJoQzfRv/GZKhSpDrjjvlZo68c+64dL6BVZv+rrtzwl+kmn
	s5cwxTs36oJGNQEHvzuV/TFaAa21DyYWbsShbMbcCvbtY8wpn0wuQY5ro6lrN+4ZLWRh9aO8u6/
	TVsmqYKiiwboBle7PG1ocDBitf8jtz6WAgQD0ga8yTuD5eZaF/oBhgCAdpax4kESxrO7h+QU+ZL
	iua6ekTImRd4dm+86axXD3No7wIlCMLipozLnFH+Wi9+UxtaEX+KeCuTS5JDzo53tTDK8bcPs+D
	MWQ8a670B9lY87fPTvZRgVhBbfCwjNs5DjFW7+od5v7uuvTvlnth4Q5ZiVnVUlVSqQaWvRmj/ij
	bae06NYElq3ylLv7FxxMquXeYg9rX/ZsQ6ok6FSguhkwvp5Cwr05OeHb9p8liLLjIeu2ybwaUXi
	euw5j0tuhY0HfqZe/4Rgqy59Gyk8efzUEBREaOvGoQ=
X-Received: by 2002:a05:690c:67c8:b0:794:c04d:bcfc with SMTP id 00721157ae682-797aa851693mr89684017b3.13.1771295461531;
        Mon, 16 Feb 2026 18:31:01 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254daasm106806247b3.44.2026.02.16.18.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 18:31:01 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	johannes.berg@intel.com,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] brcmfmac: Fix error pointer dereference
Date: Mon, 16 Feb 2026 20:30:43 -0600
Message-ID: <20260217023043.73631-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,broadcom.com,intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-31917-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53E071487CD
X-Rspamd-Action: no action

The function brcmf_chip_add_core() can return an error pointer and is
not checked. Add checks for error pointer.

Detected by Smatch:
drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1010 brcmf_chip_recognition() error:
'core' dereferencing possible ERR_PTR()

drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1013 brcmf_chip_recognition() error:
'core' dereferencing possible ERR_PTR()

drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1016 brcmf_chip_recognition() error:
'core' dereferencing possible ERR_PTR()

drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1019 brcmf_chip_recognition() error:
'core' dereferencing possible ERR_PTR()

drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c:1022 brcmf_chip_recognition() error:
'core' dereferencing possible ERR_PTR()

Fixes: cb7cf7be9eba7 ("brcmfmac: make chip related functions host interface independent")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 4239f2b21e54..dcd8a296de10 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -1007,18 +1007,33 @@ static int brcmf_chip_recognition(struct brcmf_chip_priv *ci)
 
 		core = brcmf_chip_add_core(ci, BCMA_CORE_CHIPCOMMON,
 					   SI_ENUM_BASE_DEFAULT, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
+
 		brcmf_chip_sb_corerev(ci, core);
 		core = brcmf_chip_add_core(ci, BCMA_CORE_SDIO_DEV,
 					   BCM4329_CORE_BUS_BASE, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
+
 		brcmf_chip_sb_corerev(ci, core);
 		core = brcmf_chip_add_core(ci, BCMA_CORE_INTERNAL_MEM,
 					   BCM4329_CORE_SOCRAM_BASE, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
+
 		brcmf_chip_sb_corerev(ci, core);
 		core = brcmf_chip_add_core(ci, BCMA_CORE_ARM_CM3,
 					   BCM4329_CORE_ARM_BASE, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
+
 		brcmf_chip_sb_corerev(ci, core);
 
 		core = brcmf_chip_add_core(ci, BCMA_CORE_80211, 0x18001000, 0);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
+
 		brcmf_chip_sb_corerev(ci, core);
 	} else if (socitype == SOCI_AI) {
 		ci->iscoreup = brcmf_chip_ai_iscoreup;
-- 
2.53.0


