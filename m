Return-Path: <linux-wireless+bounces-39130-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jKGkN54tV2oDHAEAu9opvQ
	(envelope-from <linux-wireless+bounces-39130-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:50:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D867275B3AE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 08:50:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YyM8vA1h;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39130-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39130-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6BBE3018CD1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 06:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06566318ED7;
	Wed, 15 Jul 2026 06:49:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1673128D7
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 06:49:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098186; cv=none; b=l8Xe0lpTb4FbjGOcCMoza/++hjwhSyhVR+xOB3gSB3YTyrgFZCukdmVfvUH83p9SCFpfWxyiN2HKlLpBRps156gGSlUes1hI+8MGRuBCwKjNZ4dATK0Qw+Y6Gt1epVzbDVd8jqUu6WC+VGB3+8TanDv7imsEAlmAsCnahskOPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098186; c=relaxed/simple;
	bh=H3H+U00EvKmnxYu0Zr7XD5SgUBsLDMZC5MZOue8X6sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kkq1NJeVncyFx4nY7oWq4hBiAKlZ0lC4ZXJLOW5JuzT5J4pznd4a9YqdHw3xTKyI6UtV1+Su51/t+Q10GgeZ8pWozmAMGLRARQ9PHktZ6o2zLys6PrRN0qxwm5cS1S31aOhwJFGtZ5/nPoq9kZ0WJnS5FHgH2FkLTboyNxH7XvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyM8vA1h; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceed7018c8so11182175ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784098183; x=1784702983; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WAxwSysnuvqpld0W2wLJvg0Kqlo0lOvRkB5I8+laT8o=;
        b=YyM8vA1hTOu74IEVr6EYxyxWlAhoh1T7vTwQtCwuVqZLCF3UMifSDrIgBrDCt1+6Mz
         uGeqGtNZLjRqHyyPaYC8psT2PfCALFzeSZ2MGmIi81y/8Ftm+vyXwsvmeNgIcfXcB6wB
         vPm/t7iZpiE8tTgPuZkRGNyINWwkKge5GUQ4vklfUzQHftQR050EmmVqQnHT2xZpVCgq
         i5E9RPj5w79abNSHMHHplzkLZPksBDyzKseitt/gYclc10nMtRPtKfS6VOZAhrj8Mbh2
         V8W+XGlzRK0zISkw99+ZTesxnXAcLZu+Y8nRKkb/X7qaIxeuNylG0z1MZhupeVeG0Zvo
         Xi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784098183; x=1784702983;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WAxwSysnuvqpld0W2wLJvg0Kqlo0lOvRkB5I8+laT8o=;
        b=IKxZKpXEuZNRVV7cJJG9hYNNpX4S1QXVsDkTnST2CYDBoCM3eZFPsoODD8606Hx2DU
         zuyv16SNSGgkj5o7lP8NmMjKrF2ijX15OAkFtqxF8lhpMrHyfB2p3epBIDSp5mucA6Yi
         6hr/Euhq7OzqreTHU8u++A1O5PydF4KCvOoIEel97JvplvGDttTGCVbUGsd169AyitE6
         1ycAA4bGdeVd9TzA6tcs0kD0w6udN7tYRle4yB25aLb4Alf2/j31NA05JofwMPO9CSEd
         uIwwW/F9AtSb3Sr7CBf9wRi587meLwyzi9UY7n9h0fCn+viyy00scqMu7pCyT4NEhP7T
         RRPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkSfa4E/VR9JRfrFPP8eY9Y6QAFgb4myySr9tjHsIedLg7qzhHlyIDJpuICzAHED84QdG8sAOKHvUn+blYVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynzDvVPd27AcMAVbbfin94n6+hjqCkMWXpbwGanmxRT4xX3sPE
	FypzuGvnonGq7UKdlvslZ0OQovM4MYFDWtiudb40MssGhJk3HGVZODlM
X-Gm-Gg: AfdE7ckWA8jgS/BVVTbeBiS9gXrYJRpoiIYroxrgb1RO4MOkjtptyPhdKUoPasImKvc
	i6UI3+VeVzmKPYaHq5v7eywXq+Haluswm3T6HONvq0mivcchDQp40cfC+liaM1iOp0qGzGIgibX
	qKwcjIRzvw418WEtc8EZZlKFi89nDtq2ru0zSrfdL0v8sImaZKq+Swu9RkAMTPXnJWdfwiNh6pf
	upEAiSMln/P+kYVSyTK//wCudKujrUrrJsEd6X29ufpv9PZbqx1RC0xpKYAewosXdYS9boZ6r6+
	EUjwBJX8q88HSCi9vhMvcNBFc0O5T/KB89iJztMa3iJPxzzCoPf5Gqh2FO43OUhHvTL9a71Kqmg
	jTYTauOM2wJa4Hbq+FUE4Pb59k64NVAkx4m9IkLW0toM+Be24XYNSHuVwBgiBl1mu6a1i2+gr/d
	EaMYhAwn+Oan55xi2yil+aiR8+nV7Bayrec1shZgT49jKlxwJzv8C+2T3O+gVtuceuRb2vftHI
X-Received: by 2002:a17:902:f683:b0:2c9:97a7:f543 with SMTP id d9443c01a7336-2ce9f1789d4mr143177005ad.41.1784098183463;
        Tue, 14 Jul 2026 23:49:43 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce7b3755a3sm86051435ad.80.2026.07.14.23.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:49:42 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Wed, 15 Jul 2026 14:49:38 +0800
Subject: [PATCH v2] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-b43752-f2-blksz-v2-1-f9be49856050@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIEtV2oC/3WNyw6CMBBFf4XM2jG0RSqu/A/DorRTmMjDtKZRC
 f9uZe/ynOSeu0KkwBThUqwQKHHkZc4gDwXYwcw9IbvMIEtZl1oo7CqlTxK9xG68xw+Sd0Y4UuS
 ogbx6BPL82ou3NvPA8bmE936QxM/+byWBAs91o731ZMhX134yPB7tMkG7bdsX39Irr64AAAA=
X-Change-ID: 20260713-b43752-f2-blksz-efda1de3ede9
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Kalle Valo <kvalo@kernel.org>, Angus Ainslie <angus@akkea.ca>
Cc: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, 
 Wig Cheng <onlywig@gmail.com>, linux-wireless@vger.kernel.org, 
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784098180; l=4721;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=H3H+U00EvKmnxYu0Zr7XD5SgUBsLDMZC5MZOue8X6sk=;
 b=VN931l1m4was2Q22iLRg/8Eb8uMCk/v1EXvXXIMHef101oh3mdsnCMBnu+QE4nXo6hy4jb++h
 aGpKCwThUUABqbOjnBsZzD7lMaydacgFqTa/kt776aaUl0CemMC7Tj7
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39130-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infineon.com,gmail.com,vger.kernel.org,lists.linux.dev,broadcom.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zaq14760@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arend.vanspriel@broadcom.com,m:kvalo@kernel.org,m:angus@akkea.ca,m:gokulkumar.sivakumar@infineon.com,m:onlywig@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zaq14760@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zaq14760@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D867275B3AE

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

Backporting note: kernels before v6.18 name this id
SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, so on those trees the case
label added by this patch must be adjusted to that name. Cherry-picking
the rename commit 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
incorrectly labelled as Cypress (CYW)") first is not a clean
alternative: on trees before v6.17 its context collides with the 43751
additions, and trees before v6.2 lack the FWVID framework it touches.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 6.17
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

Gokul suggested having stable cherry-pick the 74e2ef72bd4b rename
first. I rehearsed that on 6.12.95: the rename does not cherry-pick
cleanly, as its context collides in four files with the 43751
additions from v6.17. The conflicts are small and easy to resolve by
hand, but the prerequisite tag format promises a clean cherry-pick,
so it would not be accurate here. Moreover, the Fixes range goes back
to v5.15, and trees before v6.2 cannot take the rename at all: its
CYW->WCC change touches the FWVID framework, which does not exist
there.

Adjusting the single identifier in this patch instead works the same
way on every affected tree (build-tested on 6.12.95), so I kept that
approach: the stable tag uses the documented "needs adjustments" form
and the details are in the patch description.

Changes in v2:
- Rewrite the stable tag in the stable-kernel-rules.rst "needs
  adjustments" form (Arend)
- Add a backporting note to the patch description: adjust the id name
  for kernels before v6.18, rather than cherry-picking the rename
  first (Gokul)
- Link to v1: https://lore.kernel.org/r/20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com
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


