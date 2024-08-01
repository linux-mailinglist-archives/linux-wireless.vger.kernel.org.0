Return-Path: <linux-wireless+bounces-10811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD522944931
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF581C20FC4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE1113E3E4;
	Thu,  1 Aug 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFVPw5V2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60638157492
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507338; cv=none; b=ZS0F9tfroTI2HmC1GA43nLgn0XXSimXmY8GQvWqy1dBggYV23YNhGoTdqzrk5qEFS4+AEH8pCQb7/OZMMEzSkyEicQ3WMbtt+yQOPD1BA9ckbboBaiCzQcJGbTckh75RnC1fh/7p5AjGyByC2x7Q45uRBT66fS5poO5YEfQGtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507338; c=relaxed/simple;
	bh=FOCdvMysQKfvcENiV/YXkGLv8TWhqy15B27048kmxds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTYpxFTrpjpht+3umDQxPLGHa5clJbLjRHerkBrm+ImO+H2Go4NgnjX4Ky9Aj7n8U9hFyf3WgHKd1OTGv9+F3NJR+s5Qq0Q4mz6UyavPDwQ4kiUG68R7kmSogS/ycVdpHvXziyqXdLxah8OrxNVFdjcdKK6h5jjdMxY0sKpS274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFVPw5V2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f01afa11cso10086277e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2024 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722507334; x=1723112134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKDe4lX/z1/ndk5hg44rYl7hDxWs3doatHrDnvyNy+o=;
        b=NFVPw5V2oneqFEBrq84/3yWoE/aAJECc24XflVCdssMLnTDp0fwyRQRH2R3NoErP4G
         8I3cSMnbdCc5DcIDaD2vo/g4He1hhOSYynt6RyWa9s2kRwoUQbmk/BQsC3Ia5FbAEVCQ
         C+J973yhUCbO+8gyv91fXjtE7NQhMWmhfBJMUMMZkgy6+5AwYOJV7wyl4iuonujuwJ7g
         dwbslGu6SLEytcxDyoVTYTo1T0M7ean7apMbJ3EwrMf17d0760Zcbiykt02RGFJ7sDUR
         gWOajv+rtJqYhkab/XlA5/7Ai2We3NhjUXykN16neqtzt9m+b5OhIwtjqXiBwPrAkN8E
         rV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507334; x=1723112134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKDe4lX/z1/ndk5hg44rYl7hDxWs3doatHrDnvyNy+o=;
        b=TKz1WfV2VuRhTmoTFCjTp2eOXg+YW5lQPQ/XEetn8yMs2e2K0cN9ZFKlrKT63ch7Sg
         Be4gvw6YGBkf2l5dx/YuxzpqGxUsJ74SHErqO7eNDpoYimYTY1jjI3qmwS8gARdqbyJD
         ZwPEdJQBgaPTCIntOeZHsqrOJm+A17jLC0bRkG1Cj4go+IILWlZut6uXN+AW2M/IZfRm
         V/Pfg15xOBOcCnCIgdh/pNGcoUsRpwmRLQy5mT6kV1kKNo5A4oPKQmVe+WWTJdEBVRx+
         /VxVQd6VXpmFiLU4EdnlpWTby0IGJRNoSkR8EbMMC2sEdkT+e3JuLchOxL4l7h6UJUMb
         f8KQ==
X-Gm-Message-State: AOJu0YyoM0bxY7mi7AD/IqDxAfXfYRyrKLoN5z9WUDYv4nj5ix6ld63v
	rN2shdmE2ynKJn3tkGNZCLp72wOdGOLCWWSjq7LVnl5ZXst5UU67XiZTZJx4L9k=
X-Google-Smtp-Source: AGHT+IGU8stJDezD8B8p1nXH09RqPbUuI198CRu0ZrUvsAZSPXI4QXpQJZi2o3FT5MvjsJvtrfOKGg==
X-Received: by 2002:a05:6512:3a83:b0:52e:eacd:bc05 with SMTP id 2adb3069b0e04-530b621b294mr1140939e87.61.1722507333902;
        Thu, 01 Aug 2024 03:15:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:1fa1:82cd:5aa7:1b06:c396:7647:9ebd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08f74sm2502552e87.152.2024.08.01.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 03:15:33 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmsmac: clean up unnecessary current_ampdu_cnt and related checks
Date: Thu,  1 Aug 2024 13:15:31 +0300
Message-ID: <20240801101531.6626-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'brcms_c_ffpld_check_txfunfl()', 'current_ampdu_cnt' is hardcoded to
zero, so 'txunfl_ratio' is always zero as well and some dead code can be
removed. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 .../broadcom/brcm80211/brcmsmac/ampdu.c       | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index 33d17b779201..a767cbb79185 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -351,9 +351,7 @@ static int brcms_c_ffpld_check_txfunfl(struct brcms_c_info *wlc, int fid)
 {
 	struct ampdu_info *ampdu = wlc->ampdu;
 	u32 phy_rate = mcs_2_rate(FFPLD_MAX_MCS, true, false);
-	u32 txunfl_ratio;
 	u8 max_mpdu;
-	u32 current_ampdu_cnt = 0;
 	u16 max_pld_size;
 	u32 new_txunfl;
 	struct brcms_fifo_info *fifo = (ampdu->fifo_tb + fid);
@@ -389,26 +387,8 @@ static int brcms_c_ffpld_check_txfunfl(struct brcms_c_info *wlc, int fid)
 	if (fifo->accum_txfunfl < 10)
 		return 0;
 
-	brcms_dbg_ht(wlc->hw->d11core, "ampdu_count %d  tx_underflows %d\n",
-		     current_ampdu_cnt, fifo->accum_txfunfl);
+	brcms_dbg_ht(wlc->hw->d11core, "tx_underflows %d\n", fifo->accum_txfunfl);
 
-	/*
-	   compute the current ratio of tx unfl per ampdu.
-	   When the current ampdu count becomes too
-	   big while the ratio remains small, we reset
-	   the current count in order to not
-	   introduce too big of a latency in detecting a
-	   large amount of tx underflows later.
-	 */
-
-	txunfl_ratio = current_ampdu_cnt / fifo->accum_txfunfl;
-
-	if (txunfl_ratio > ampdu->tx_max_funl) {
-		if (current_ampdu_cnt >= FFPLD_MAX_AMPDU_CNT)
-			fifo->accum_txfunfl = 0;
-
-		return 0;
-	}
 	max_mpdu = min_t(u8, fifo->mcs2ampdu_table[FFPLD_MAX_MCS],
 			 AMPDU_NUM_MPDU_LEGACY);
 
-- 
2.43.5


