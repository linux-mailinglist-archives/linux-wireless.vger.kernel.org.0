Return-Path: <linux-wireless+bounces-38962-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6DD8DIinVGqOowMAu9opvQ
	(envelope-from <linux-wireless+bounces-38962-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 10:53:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A00748F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 10:53:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jL1p9jFR;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38962-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38962-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFC1B302A4FD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E8A3CFF6F;
	Mon, 13 Jul 2026 08:51:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2C3CFF5E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 08:51:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932662; cv=none; b=g0RvOUo74ibeuWL5qk8oKvDt3DT8jkDvKYvFG4a8YECr2fAq9KzqupYIu+npx6c80ZICLG9myoaxjhfXjFDUFk1vaH3NZwfDbSO3YwZeMNfaDdO+NjFAf0XSRuoYN6/svuVxRWaq9kxWnPQjg/86tJvinijz5e5rRff396FRusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932662; c=relaxed/simple;
	bh=x2y7A0mQWDqx9SWlyeRZiEZyZuZoqGFvVUSn6KvNwf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=df6Z5OaO7L8nC3O9L0Tm9FHqvVP1fmxu4ZI/3xohBxlazpmZAWpidsUnRGFLrAu9hvl6bLOlL5lZrK+hm1uayyEcs97goqNo9h4XFlzkAUUPV0UqnwN77Bfw522BB96T04WA1E0SrZdvcFD3dBQ1BbN0TqJqS2IAI0856q4A6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL1p9jFR; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceab75934dso17073265ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783932660; x=1784537460; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tx9/pVLn3lgrECS5JH9ovCKH0knPJW11H9lumC0dnr4=;
        b=jL1p9jFRhaFMesJgl1p4U2INxgWhdLH4uIIop6etx/ppBCkqoyC602G3FYRwPcI5Tn
         yBQ7f3edJcWzQU1wZtGUjzjE3o+barIbb0i9sDm/B6MpYVY/xBnjBqzLA+ktQtcyEN7i
         TZxi88aT15x3b6Lr/25Qig5DnXLncYFQAVRbRmYCbJvlkKm2MzUUTD7mHsfar9z6K8Ad
         QD+owxO8Dr82ipl8VVDrlkU1vXvi+lB6dj5Gc9qEAqNoYCq0pD2nKe3k+ds95yjxj0lu
         R6qFjV7UGxzPQhDfsJ6YNm4Iet+7PXF7kyudhOf93THiU8QKDsXkDfndkUycGJsHl4BK
         Z0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783932660; x=1784537460;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tx9/pVLn3lgrECS5JH9ovCKH0knPJW11H9lumC0dnr4=;
        b=DZ5MElFbJrImQABjc2DBlCkw5gaHTj7ALs/xmFQh6/M2DfPLYiDFMMQN3GOAcuCYVx
         Tzxn/ySkzfLz6Jb141jxuACecH3D5Xd8Pp7uw7OGMQeVbZrvsI2Lv/EXCeApdPq9DhJL
         1b4BKklj1XDiw3w79hoU2TrXHTB6ALiT/HXyLPhsHBe8b1Uz8RcseiQOUyZ+V6dvlYCm
         J2EVAa7LxCSImHA7AmPttUjiZ37t444KG84mvUPsn02x6HU7RIKAAQnMEgVP2WXDqh9p
         CRJjMSqoHlyTQIQK/MUCXz4SYFlM5fjusaWFzxrsMl1XKnS6lFx34bS9aCjI6zTB6CWN
         6ctA==
X-Forwarded-Encrypted: i=1; AHgh+RohFazmqDcagCLI5viLGM71V1waCGuzARJibS39qHtHMzxSofGX2eXRWqhZMadyP9xmy/tsKaDawAr6mo9A5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjV2kavmozknsqmF3i5ysVv1w2TwuvDNgjEMcyFl3ZtbTB03g7
	GGbZOLcgjytHDvRGev8De3vUn9dQpf6jd7YOwwnfGh7+cQZhTb5w4YNy
X-Gm-Gg: AfdE7ckSLFenG0JnrTC0UB9i4heSNWav26i3JItk7ZvZXC/O4UKOJQFxN53bSGwCOte
	zFIXD9IoSDlvu4SINkNugfOjW6qLPMjC7IUC3ke7yElmyJMu251R4zQxaI55gjbhaWyqT+P6eYl
	CUFaQ4ZS7QnGxJOWVBTxyTB3fVg/r9ocnMOkdfHC+8JFs6uatZyBykKoZ7bdKS+RyLk727rmn3B
	pm82SMla2e5h6PEWZQYzTCdVOYm7B2zk0LvgZDKOSmm2V+RJF0UVpRfEPDMkgqCYnLJpUo0yMm7
	mgH2jtE8oQ4r06+4vfzcF1clzbweXWsgkEizjaNTFN5PTypVXjVhZKvC2wPJHdlDpGQXTpJK/S6
	sRznXRUPN8cFAiymy5/Ez4aoZSSRajrzbkHEZP+rtMUzJZQ7IvAfly6aGhpVgIcwK4ES0VT1Vzf
	T8JhqmcoS3eu288kvzir83CCeYjrYpULjiJsaamfpDYBXUvUt0FKQH7sB/S8nypx6nTuwij/qv
X-Received: by 2002:a17:903:b85:b0:2c9:ae0b:61e3 with SMTP id d9443c01a7336-2ce9e9a6ed8mr68713635ad.2.1783932660354;
        Mon, 13 Jul 2026 01:51:00 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5c804sm95405245ad.82.2026.07.13.01.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:50:59 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Mon, 13 Jul 2026 16:50:55 +0800
Subject: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO6mVGoC/x3MSw5AMBRG4a3IHbuJth5hK2KA/uWGIG0iQuxdY
 /gNznkowAsCNclDHqcE2bcIlSY0zv02gcVGk850mVXK8JCbqtDsNA/rEm6Gs72yMLCoKVaHh5P
 rP7bd+34mYVoyYQAAAA==
X-Change-ID: 20260713-b43752-f2-blksz-efda1de3ede9
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Kalle Valo <kvalo@kernel.org>, Angus Ainslie <angus@akkea.ca>
Cc: Wig Cheng <onlywig@gmail.com>, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783932657; l=3337;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=x2y7A0mQWDqx9SWlyeRZiEZyZuZoqGFvVUSn6KvNwf4=;
 b=BriQddfQajmgnCw8Aakdagw3LVvgLsP2Zq4g4TFKQomiuHfkR5bWjOjAThxzIfHyPUU1TxUVM
 t2+MK21tqSSD+w1LXqhx2T2x3OK4/z1eBGVRXDEceDDkHThoe2UzDaP
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38962-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,broadcom.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zaq14760@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:kvalo@kernel.org,m:angus@akkea.ca,m:onlywig@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zaq14760@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zaq14760@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90A00748F6C

The BCM43752 is not reliable with the default 512-byte SDIO function 2
block size: on an i.MX8MP board with an AMPAK AP6275S module at
SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:

  mmc_submit_one: CMD53 sg block write failed -84
  brcmf_sdio_dpc: failed backplane access over SDIO, halting operation

Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
set up the 43752 like the 4373 for the F2 watermark but missed the F2
block size, which the 4373 limits to 256 bytes. The vendor driver
(bcmdhd) also programs a 256-byte F2 block size for this chip and runs
the same hardware without errors.

Group the 43752 with the 4373, matching the F2 watermark handling.
With this change a 10-minute bidirectional iperf3 soak completes with
zero SDIO errors at ~270 Mbit/s in each direction.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Cc: stable@vger.kernel.org # <= 6.16 needs the CYPRESS_43752 id name
Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
The failure was isolated by testing combinations of scatter-gather
support and F2 block size, all at SDR104 / 200 MHz, with an iperf
multi-stream stress test plus a 5-10 minute bidirectional iperf3 soak:

  sg/glom  F2 blksz  result
  on       512       fatal halt within seconds (CMD53 write -84,
                     "failed backplane access", wlan dead)
  txglom off, 512    survives, but ~14 recoverable CMD53 errors/min
  rx glom on
  off      512       firmware PSM watchdog reset after ~3 minutes
  off      256       0 errors, but TX limited to ~142 Mbit/s
  on       256       0 errors, RX 265 / TX 273 Mbit/s (this patch)

So the corruption tracks the 512-byte block size, not scatter-gather;
glomming only amplifies it. The vendor bcmdhd driver logging "set
sd_f2_blocksize 256" at probe is what pointed at the missing override.

The BCM43751 shares the 43752 firmware handling and F2 watermark case
and may need the same fix, but I have no 43751 hardware to verify.

Tested on:
- i.MX8MP (usdhc SDIO host, AMPAK AP6275S module) with Linux kernel
  6.12.34 plus this patch

The touched code is unchanged between 6.12 and the current tree apart
from the 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
incorrectly labelled as Cypress (CYW)") rename; stable trees before it
need the old SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 name to build.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d24b80e492e084160e1d085b8c20242de3e07c28..3f7a05c4d27ad4c284a6ecc7f0b014a1e985526d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -911,6 +911,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		return ret;
 	}
 	switch (sdiodev->func2->device) {
+	case SDIO_DEVICE_ID_BROADCOM_43752:
 	case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 		f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
 		break;

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260713-b43752-f2-blksz-efda1de3ede9

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>


