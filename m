Return-Path: <linux-wireless+bounces-34836-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBt/F/cQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34836-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5054089F9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F3CF3121202
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF7E3876B8;
	Wed, 15 Apr 2026 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPUIMK0X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F643939A5
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291827; cv=none; b=qyhpofR6OmbirUsPPh7eIsnuPM5Ftivpn3iTK06P+RSAtLRzqJxUrdyCj367LwDTB1IeSO6pyuamUh1n6LddddgKQcusiBztKTwFy/tL1nL8b39eKzr49gkP2It0rFc+/M6OprbicrfaPe+x8i1K1HNl4zBgYkZ2+bIz1BBIF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291827; c=relaxed/simple;
	bh=094hf+SxNKij/EcIVMTNsyylOlbCL96vuqQW3ZyI/cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJHEsljjZ6TXUATE7eCyaRGONKuLl0IHDUAUN4IgR43w1eDqps/+wue0+GQXLrjbVIRE+jQYT1sCG00pGvddmRyftiztnWy5/A2JU96nwxDDIuvVQEUEZCOeCAZs5yZSLrQ7kekjBwurpeo6jkAr5h/leRmIIygtqx146GcxjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPUIMK0X; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2744274f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291824; x=1776896624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amc2Ehb7SVgpc4uTqGRizbzqDHMttSTOcHk8LAOrPsU=;
        b=oPUIMK0XQZ7LEVU57dqoLVTKg0UCCW8ItpStISOYJV7Oa0k8fRPL9LSTYbeemFnaOq
         SpAe3mhjRrFtEsizJoFsuhG5kstyAPgB70h0JSBFHGyXBptag3T3J95+acAm3HoI+QaC
         7wygSNU38iZeca2ccqxbY0hZr0jcY3mQhs6R1bCs6vF4gtnZveJg8r/Gti44HcZwNGiV
         dIMUyk9X3Co08xNMH73SjVboygVravnyB6kvmeWT2R+5/a1igM6qOgEd6kR7WxqZ0xhX
         nNY6wJukwo8JkEw6DvU87rt4eysKuyCenatTNZMFckst+S3uHoQaotk3z3c5Kt3pIu1O
         38Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291824; x=1776896624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amc2Ehb7SVgpc4uTqGRizbzqDHMttSTOcHk8LAOrPsU=;
        b=CdITyq6m+6QCL3gMDrcKq+3oPc5M52YON0I+G++9P4j5Wp8PpNmwNWu/Svbo4g9DxR
         tX9XL4/FdU4lnU6zl9jyMUDs5aU51MJ3jgDiAaNEiQrzzzBPVkfx/D4vMr6S941VT3d/
         P1KKDAAOOWiBQcFrDku9oktKr+/vPmydJkMTuNcTUgzZS9xlThfaCCC2pLjOEGvAGLYj
         rokI6FfMIWBH1RBX50NtITmdy500qTN0nMOSoBZjn6Xu0q+0zFBTJj9hLpGZYrCs6Z6N
         WC5xjkaYv/5Nfjjkb++PbOHlPZhqxb1IvzhqF2RQwFNMKH7g6SKIDUmFsEic9WbhfUYP
         PTWw==
X-Forwarded-Encrypted: i=1; AFNElJ8pHa9VqI0uJlqg/XqyieR+IgjTw2jm5Crs2LA9F7+smbSZhG/apDzvJISBwDC/Y3kf283vRCxv8YcLeWBfXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+XZkMO7eE1yfeQM0iwhHotYhIqOcuAvFzcqiVj/IzQ9o2Nns
	NUPhdGzdCBnCwiuVUtAuku4BKy2HZfoCCyP8Jx82fAdyYUgd260WS2I=
X-Gm-Gg: AeBDiesCAr+4g4FeeSgR1ORmasijcakTz7llxsVUKoyHDRERhmD36RjoM0WASS1q5HL
	MW8XhUyn4xkVaPmF1roZxYMejJYW0Udl9pe1YcjN3OrXj3w4B6NHaFqYJHy7GCeBfKYoVqqdiWW
	cJ94pr6SNAZjjD2aE2RQQdshqgFgVp/w2bgp6WEgW9NphPfR5LK66gS+ViQdxYjTVFprvlNAJcw
	+fFuNAvY3QdZZNY/gtqfHablKp9VcrtEmZzVASSkHEbqaICy3lxEwHVy9nth+YzzHPugVEPitjL
	u0iXkC7AyJL2icYHASixA7cI9rabvpvMXSQ0FM7rk0QxNsKT5Y1auhQsAfneF3k6LLWrgLnFVvY
	uAOBOtWEXVK4zNGSEXrrf0FhI/o16T581J6cniTZEV7afsZM52oInDfMWR3BKT81FIx4JO1zOeY
	nqzAs=
X-Received: by 2002:a5d:5d03:0:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-43d642d1d17mr34903443f8f.42.1776291824418;
        Wed, 15 Apr 2026 15:23:44 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e00b3sm7803345f8f.27.2026.04.15.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:43 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Toke Hoiland-Jorgensen <toke@toke.dk>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath9k: fix OOB access from firmware tx status queue ID
Date: Wed, 15 Apr 2026 22:23:43 +0000
Message-ID: <20260415222343.1540564-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-34836-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: CA5054089F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

ath_tx_edma_tasklet() accesses sc->tx.txq[ts.qid] where ts.qid is a
4-bit hardware field (0-15), but the txq array only has
ATH9K_NUM_TX_QUEUES (10) entries. A qid >= 10 causes an OOB array
access.

Add a bounds check on ts.qid before using it as an array index.

Fixes: fce041beb03f ("ath9k: unify edma and non-edma tx code, improve tx fifo handling")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Note: v2 resubmission -- original sent via Gmail had HTML rendering
issues. This version uses git send-email for plain-text formatting.

drivers/net/wireless/ath/ath9k/xmit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2755,6 +2755,11 @@ static void ath_tx_edma_tasklet(struct ath_softc *sc)
 			continue;
 		}

+		if (ts.qid >= ATH9K_NUM_TX_QUEUES) {
+			ath_dbg(common, XMIT, "invalid qid %d\n", ts.qid);
+			continue;
+		}
+
 		txq = &sc->tx.txq[ts.qid];

 		ath_txq_lock(sc, txq);
--
2.43.0


