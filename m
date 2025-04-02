Return-Path: <linux-wireless+bounces-21069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E447A78CFE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08D516D161
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51D2356BB;
	Wed,  2 Apr 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="UWav5opr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C2214A8D
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592956; cv=none; b=W6Pl3SkmbPNzuidr4LSteuYA8yF35VMd6cdn1RlVj4by1bkyzm0jCCTBuQmfEBcLu7oND4HvbHDVGHmlG5K1TyuBG0rx19+9hoox9eBBfbzxFvB0eWPJGwnCrbFAMoq4RwGitXycJNVpQ/5XFQN6bRExtDsMNHIn+XoBJPQS6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592956; c=relaxed/simple;
	bh=DWwUxvwA4XD03jKsrBX9TWgvFf4p5JtyETqjG4iii9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZpGJuDXlOaZX7zc3Qr/HLJA+niYWCkCdzKgxERSI+aDqggoiWMkxgYAYJdiIHfoYrBWdefNAmWLuHGE+HjD8I5Mx1wMrh+dmVNbVHRVH9Fu0UB74tq1pnrlonb6ChzzEF4f8IxhNpyJ+kwO88a4qU1Fss8Vfq1ZT4QtPHhsYkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=UWav5opr; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1743592948; bh=DWwUxvwA4XD03jKsrBX9TWgvFf4p5JtyETqjG4iii9E=;
	h=From:To:Cc:Subject:Date:From;
	b=UWav5oprjSGiAMnF5i4Y3xqk9ILVWQK/kDvlmxnBUN9ut3+LBHgdwGQv/+Ys9NEJ9
	 8akbxioSMjOHsd1O60458b2+x+Xqo9bhmHZ0T0VcaZEME6y3V057jPNGNBJtVynkDT
	 Geuc+Tv6yS+5h2vFQHbmOJzp78480KIdrAeD5LiUfhA/Ks9qfO2wVMfRRnDwADOuLd
	 zWxZzY9v872XV7Uxy/J8TvQUNg670lc1IRZkmmyIn6q0DT1insgS+ir8+Hag5Qdt+a
	 /wau3QPNgUAKv+FETL2Xv7xtPVlrKmyKFLrYhOHjUFJ8oa7HT1fxULVjKpR2+DYt4S
	 ktVBhVrGY4Zzw==
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Sujith Manoharan <Sujith.Manoharan@atheros.com>,
	"John W. Linville" <linville@tuxdriver.com>
Cc: linux-wireless@vger.kernel.org,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH wireless-next] wifi: ath9k_htc: Abort software beacon handling if disabled
Date: Wed,  2 Apr 2025 13:22:16 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20250402112217.58533-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A malicious USB device can send a WMI_SWBA_EVENTID event from an
ath9k_htc-managed device before beaconing has been enabled. This causes
a device-by-zero error in the driver, leading to either a crash or an
out of bounds read.

Prevent this by aborting the handling in ath9k_htc_swba() if beacons are
not enabled.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Link: https://lore.kernel.org/r/88967.1743099372@localhost
Fixes: 832f6a18fc2a ("ath9k_htc: Add beacon slots")
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
index 547634f82183..81fa7cbad892 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
@@ -290,6 +290,9 @@ void ath9k_htc_swba(struct ath9k_htc_priv *priv,
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	int slot;
 
+	if (!priv->cur_beacon_conf.enable_beacon)
+		return;
+
 	if (swba->beacon_pending != 0) {
 		priv->beacon.bmisscnt++;
 		if (priv->beacon.bmisscnt > BSTUCK_THRESHOLD) {
-- 
2.48.1


