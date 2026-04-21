Return-Path: <linux-wireless+bounces-35144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIeeKO6A52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6E43B8F7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53571305D35F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805F3D7D69;
	Tue, 21 Apr 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvMm7oND"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AE3D7D6D
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779367; cv=none; b=K03qiMjq6jBMNjm67kH0KknOyGBXvs7BOr3Y1S9eV2eCCcSODnFuAkSSU/7tznAcUlm0F11M2i1i+Cng0Fk4xHSsauKCnp5fCucFVAZGegYe8PohymF9dZgh04eDmXzrJlbu3bDIfge+OSnNEG6cLte6wbCm1vQBiRH4hjZn7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779367; c=relaxed/simple;
	bh=PaaN7X4kpA2fzuc+4c4ayodn1OKvMD8cJoE/qEH58tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkmO/c35lQ5Gcn4vcFTZyCDVKcIfmXLqEhVkgiHKyEYuL3vTH7tEhs7wT8CmvS5vHhh6NmnHzcS3IMGYRh5rv1T3oEWTSkTO3QlLECYyUURMLyoFLb+EP18WTuP33H6CO3xM5CYBNZBNof5uJUjXuNmHjMDyG+5iZ2W19u4Ddv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvMm7oND; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so27488185e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779361; x=1777384161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zve7Gyp4Zz+PrlVWRcf0nkkWE3kcw0uct7Gx5kEQXf4=;
        b=YvMm7oNDqvU4Q+KqmVmJRjwFupN19addsCAn73ldbCkIqCVQzDWdMlJDg8Jneak0tI
         BO3phSwXJ9E54qwSGk7zunZfpNrf+js+8Bmltm+pieTyJA8rxeLSF16d38peoV7Cij14
         8sZP3xv4GdetblDUsT/fxCHBtdPz5oxMHeLIXveHWH4Lemkc6z55IouWAxraYw03Ob7r
         XeEWfY304Wo7OFaRgqZ9aYFzE+QK1KcsTAsAiHKhfsou1aocCxP3YeVknUqVF0dgRLPE
         AyCaxUAD1G8cJlSZ6sEwsh2ekFT1cVeYaSRGYhcOdwWqAYQOMMs3VxDAGnkHBVVak6W4
         NBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779361; x=1777384161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zve7Gyp4Zz+PrlVWRcf0nkkWE3kcw0uct7Gx5kEQXf4=;
        b=ecycEq3yzgHl9ywX0R7MNF1X2tS+ij+P8qEaQagfcg2YwD4jCL3pZu6uP2oxmYeg5e
         /SL7QSIhh63FON03zhg1tOAYFwa3eRXfSpleZxgEBmcSqmQhuaR2aAx+apmEkCcEBtbt
         UMt9ylRNG/b+/cq0EuALeS1APriPxF9KCxCPPLVs22MxbxTqE5b5xLZCedPkLV+QQoZu
         3mOeNyc5dWiGrijtwQ+P7cF/ZamJnxt1BlvVlzaanJMBPisDX0HgWt9F8RRJ0Y5wrvwY
         J04rpWCL/QS37vscCO8J0LGxGazTac/STwQhaKnmhl/j7a+oP7e7Rt7N0MZZS0o8yxr+
         zQxg==
X-Gm-Message-State: AOJu0Yypov6HGycMgeAxHe687th+SzKC5eR+w8GrggIPNKwLAPA+5mgf
	LvCtntGYE6036q0MjMGNStIxwkeztFfQ1MDhagrTIP2GUlRuo1nd4G8=
X-Gm-Gg: AeBDieuKtcvYHVgELkonit9rWTwPvh1QY8nH9IWw3hsmpL1a56Gc37PMuwGETV4dRqb
	Oq95w1wOoa1AH67aRpyc50Xp2RyqT22WeJt8GAj6kcWLyJSIBjkvtueErSQW4/xKt8DjbEBQf+N
	bRUtYmh5tevKrH0iZKBBncYaVNabZtteraFyRxW/d02I2XZUOgIPuIu41iXIZq1THsUDwvUgYe+
	+UEJFWqWp9IRaOOM+yluNOB0tTwTUEugSra8yI9jDf5sPsYJv4mHxOMp6ywNkcmmCFdhTPtd/T0
	HfeNioZghSyaWB8gFu1qkKhnbko3cz/iJKUU6+AeM8Aym6VgjBHyHep7cNB7RX9zp6wYGikOPNU
	ucZGVRaTvjF5hFqg9M7CP3kWjj9PFh7F9nG6mMOCCyvAGu2RA5gQf7XByHcBBr9Ivj8CMATtrY0
	8z3jE=
X-Received: by 2002:a05:600c:c4a5:b0:489:96e8:1ef0 with SMTP id 5b1f17b1804b1-48996e8200amr104229045e9.30.1776779360726;
        Tue, 21 Apr 2026 06:49:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm134028065e9.22.2026.04.21.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/5] wifi: rsi: fix OOB read from firmware-claimed length exceeding actual frame size
Date: Tue, 21 Apr 2026 13:49:13 +0000
Message-ID: <20260421134916.317971-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134916.317971-1-tristmd@gmail.com>
References: <20260421134916.317971-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-35144-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44A6E43B8F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled length field (12-bit, up to 4095) from the RX
descriptor is used as the memcpy size in rsi_prepare_skb(). No check
ensures this claimed length fits within the actual received data.
A malicious or malfunctioning firmware can cause out-of-bounds reads
past the RX buffer, leaking kernel heap contents into skbs delivered
to mac80211.

Add a bounds check in rsi_read_pkt() to reject frames where offset +
length exceeds actual_length.

Fixes: dad0d04fa7ba ("rsi: data and management rx path")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/rsi/rsi_91x_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 2ff7068bad7a7..9901bd53cc844 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -181,6 +181,12 @@ int rsi_read_pkt(struct rsi_common *common, u8 *rx_pkt, s32 rcv_pkt_len)
 		queueno = rsi_get_queueno(frame_desc, offset);
 		length = rsi_get_length(frame_desc, offset);
 
+		if (offset + length > actual_length) {
+			rsi_dbg(ERR_ZONE,
+				"%s: frame overflows: offset %u + len %u > actual %u\n",
+				__func__, offset, length, actual_length);
+			goto fail;
+		}
 		/* Extended descriptor is valid for WLAN queues only */
 		if (queueno == RSI_WIFI_DATA_Q || queueno == RSI_WIFI_MGMT_Q)
 			extended_desc = rsi_get_extended_desc(frame_desc,
-- 
2.47.3


