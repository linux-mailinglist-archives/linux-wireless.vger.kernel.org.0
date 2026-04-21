Return-Path: <linux-wireless+bounces-35162-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH/tNYOC52mR9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35162-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE6343BA5F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D6013060C7A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD9B3D810B;
	Tue, 21 Apr 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF4hpOEd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC13D7D89
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779406; cv=none; b=KJPq96E/7A4VMS49jKZ5FfhISfasdYLSkobqdy/NHJPtqqhf6tzDcz2KK451rNzSem1eoE21KyStqNZyA0J96q8fTsnjtjyuHxJIVpOOeDRrtCJ7sjYdKv59xc4oJFbiRAeW8FrdiiPWd3mK3tBOPV9VWC8K8rHiX7h4KB9dJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779406; c=relaxed/simple;
	bh=ChbgosE/hxJ/3omQWG1u4nj1j4PR5kXlFS+oPL1yFck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkra7hHmh0w88PHn8vlBcdx1au2HFc0lFXDEfPwDj4DHRBFVSf6aGbmXhq/hJKOZjM9c0rfoCrYj99WmAptNzGtv/3u+/Q9WHqfGU7J9el0/7Zp0XMp4o3BHIqYPODEjvZgYM4+q21G0QAxG2SQnVcb4gGC/nHLjMmkV++6OqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF4hpOEd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso17500255e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779403; x=1777384203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKsKwit/QfxmV/HCZw97Oaq3jz5pQ918N7xiphVRMws=;
        b=bF4hpOEdX08KW0Pi+6zBaMrlSZCbiTyeKC7gKv4yzM5fJe/+Yqq49Iki1te/aYzDxw
         AmnRcg+kjSIEGtHxDvMXIRHZseqMMfR9ZUtdwyD0pIUWqfTdS3/Csf/XVc1l2Q30LgY8
         g8AbUjThfXPH1mZhcFmDj/nq3vMPZKjdmxqN4vmzdbsaae0rO6xEwXBkOjj4TYv18OAb
         fw6V/ckqVOiNFtZYydzjMyhglj6SzcZh111R9oUWvLramaTu5UXZ8Qd9+nOdp+3y43zI
         hVdoEe7hLhv2RbecdvpKPULZd/E5s5C+3dEj3cLUOh/wuZN/ueqhan/xYxgknMjHRs2s
         qufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779403; x=1777384203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKsKwit/QfxmV/HCZw97Oaq3jz5pQ918N7xiphVRMws=;
        b=qgsyJR3qt+c1+qYdwS1qJ4kFUPgJn/GAx2+sbkMcE5OuzqHKDra8RXbip9kyK4nyG/
         iPlAm26LAvaHeDSp6J83T10nUuvoVSaZWPmx9QByuu0hpuJkK+GLRHqGvMEPaA0Z4SCj
         s0ughgiqUGrH9lggaOSkPjSIh8NFza5iGbJ+N0WMvRLBPB/J3IewnAMEJ6j2TXa5iT1M
         Y5+L/oItY+31ezgOuisdQXsGmnizs5KBu4HkudcTugAK9Sm3MuMLrIZ9CLL62fSd/OfH
         rKD1a29VOB4BLz5/5ia2RAZBvOl6cXNmVuKMi6qZCp6WJ31WRb59iFu1Nn7lOW20xcK2
         Tn6A==
X-Forwarded-Encrypted: i=1; AFNElJ9WqiTtMLDAiR9IB6XGkQDmGy7xNghISsIH2ZhE3KfJy27uX23ZtY6/RpUHfUNqgphwyPowmbYO97a/oReMjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaFcJ2pPwqO26XIZd8GAxFXiRwlgNcAlnBnzBIy2GU7xcXtsC
	ifhP4ATQtDQ3eRQ0sus/33/XiCsQ5XO0m6cVg69TpPl+wRmSSTIwK93PDsIf
X-Gm-Gg: AeBDiev81u9+HXOwx+v8UMCq8NtZ+bVfPmD2X2EpBkSVc2h3eezJHZ9NMKauXNBz3I3
	Qh1rlkQrpbrEL5Ago4GK68qrJ8c488w7huDQLMeALnsp6FZXf/dzBCoWDXsUtzkr72jc0SJfeUj
	fr8IwQ5Kbd9hrVW4H9mtdC3xlfPHhQAxdgzOl6LasJbnJ2+ro4i20v93pb3crVUzETMgbObPQE5
	YQ4hApA1PbPiYX6UXnchnwhBB3XfGIoauSWm364dn/kpYT3OsYylW7kG6mQdQaxPvbKMFCv8xTO
	HAM59D41nnUVRdiuTwSEiSeUwhm1Ly5yqXywD9J5hOVTt4AMJnjLGazRBSy1AnzPcie+Ia/Pa+P
	SS19Vx/sZJJ4rqx5rGf4lHKZLueHe2z2Mmx4SNAaKTBcd1v2cfBpix+LusjXSxiO3izpS4ItQsw
	7LrdivH75Ey1h34g==
X-Received: by 2002:a05:600c:8592:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-488fb779acbmr178711885e9.15.1776779403449;
        Tue, 21 Apr 2026 06:50:03 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffad20f2sm157213795e9.0.2026.04.21.06.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:02 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/2] wifi: wilc1000: fix integer underflow in wilc_network_info_received()
Date: Tue, 21 Apr 2026 13:50:00 +0000
Message-ID: <20260421135001.343596-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135001.343596-1-tristmd@gmail.com>
References: <20260421135001.343596-1-tristmd@gmail.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35162-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 5CE6343BA5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled frame length at buffer[6..7] is decremented by 1
and used as the kmemdup size without validating the value. When the
firmware sends 0, the u16 subtraction wraps to 65535, causing a 64KB
out-of-bounds read from the RX buffer. For non-zero but inflated values,
the read exceeds the actual packet data.

Add validation that the frame length is at least 1 and fits within the
available buffer.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/microchip/wilc1000/hif.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 009c4770a6f95..473e406c98d87 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1576,6 +1576,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	struct wilc_vif *vif;
 	int srcu_idx;
 	int result;
+	u16 frame_len;
 	int id;
 
 	id = get_unaligned_le32(&buffer[length - 4]);
@@ -1594,7 +1595,15 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	if (IS_ERR(msg))
 		goto out;
 
-	msg->body.net_info.frame_len = get_unaligned_le16(&buffer[6]) - 1;
+	frame_len = get_unaligned_le16(&buffer[6]);
+	if (frame_len == 0 || frame_len > length - 9) {
+		netdev_err(vif->ndev,
+			   "%s: invalid frame_len %u (buffer %u)\n",
+			   __func__, frame_len, length);
+		kfree(msg);
+		goto out;
+	}
+	msg->body.net_info.frame_len = frame_len - 1;
 	msg->body.net_info.rssi = buffer[8];
 	msg->body.net_info.mgmt = kmemdup(&buffer[9],
 					  msg->body.net_info.frame_len,
-- 
2.47.3


