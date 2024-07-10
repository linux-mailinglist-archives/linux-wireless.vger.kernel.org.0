Return-Path: <linux-wireless+bounces-10156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A992D8A4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A731C21252
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB719596F;
	Wed, 10 Jul 2024 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="L3D8RP3u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCBC6F31C
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637921; cv=none; b=DVoOf2d+NANV/WsHyURsRkMff4GZkz4olkFeXe2xwTohT3z2p0vtuF40tbpKO2KKP24eO8A8zVw2Lyfi5k5fhL0A0cj9n0ASRErrercOVA1+KlkZWRTgadD9fz3WZHEyXZxcmbquJClZ8zj0PejHBkBVpsP7bxxcuH/zxpoIiwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637921; c=relaxed/simple;
	bh=YrfnOc6wEZCSrEGdlpWnhLi4yoU51F7CZXquQNbd7mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdfzDe11A2AvOkEAlmJCJJtsa14wDMRYwT8YUYnwp3OKrTY6gIX+nLfICV2z7anDrKa+lKiX8nqCHDeKK3uKDzHlDsUB85cpgufT/2uuD/+SAP/Y3NgB/86K6bXm71wkRi0pdWno0KaEIWz98ExmNU177cUledj7avae/VEC2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=L3D8RP3u; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52eafec1e84so168556e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jul 2024 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720637917; x=1721242717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJYMRMHzC37gV1kVGMz9CGrplXBbaWXQ72J7tDcGK1s=;
        b=L3D8RP3u0VoyUGm3yqFn7yuDW+mhLDiU91HGziccv0SlGbqbZc9Ra5D8jA4mRNknBf
         qumdy6OndaFiVjGvNtz7SbhOSFGJnNn8GdQa+ya1S1WnxkOMpxfIA353g8ZNWHEOA246
         iigx8w++6XfMc9eBJXyh5pdt+Nr+BEzUaaWFuNXpNUBDg6gQnzJh96Gfr/t08E1ZxoT3
         qsGssfTjJ2J50tBq9KApNCSPNWgYxI0XgxY3MkMx27FBVmT6LOrAMbUl/Eu6Z/2ycMye
         5RsW9fh/K+zp4wiEfMco+R7c586jI/w0UcvxVgZoVMnhfZtpZosEl8MUvEVJkwcevVS3
         EPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637917; x=1721242717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJYMRMHzC37gV1kVGMz9CGrplXBbaWXQ72J7tDcGK1s=;
        b=BZGT5nUheEbu6lsvc5M5ZVfg3sD60huB8xxtQYGx+rRqzCVjHR9R/mzy3ErPfdlMwK
         ZMw12JlAHoa0jKH0ZnkFQbk6ngdchyykNQgBSCI3m5a4K4HTOrkTqCBgzAIPHGzSLHql
         fZDp/51604ZNq+zm85it8iElB1y/hsVzAJIjsRpdGvwV+ay/qy3Yvs+nLQHZd5HAD5Hy
         nteDYiw2Sk6gjO/FvY1jFh2ykdfUOQbj78ZhSwaMlJI94EWJoR1/2n6MNH4270mJApaB
         GPhiNdxbtiBzNbwI+xt4tFh4XIDHZv9R54JRiHGd4AeQYDOcsybQqz+KEevUTl8TPW5c
         y0hg==
X-Gm-Message-State: AOJu0YzSnAatlc54fwn83MZCty3p8vwr1SwjumNlJsr4dbjJfxk5VQam
	PeAZjPRNjPv8yebqaAZL6wFadaNwDkgCygOVuUh1EL0/CBoIFeoHCHMJv2n43mk=
X-Google-Smtp-Source: AGHT+IHq1gtV4vdpsCvWVBt/1zvuwCclYwi4LpINzmgObh9B6XyVyb0wwj2eTLHWiRBGvtDkGyfWLA==
X-Received: by 2002:ac2:5e9c:0:b0:52c:84d1:180e with SMTP id 2adb3069b0e04-52eb99d4fd8mr3107760e87.67.1720637917332;
        Wed, 10 Jul 2024 11:58:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741553sm91586145e9.40.2024.07.10.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:58:36 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: toke@toke.dk,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] wifi: ath9k: Use swap() to improve ath9k_hw_get_nf_hist_mid()
Date: Wed, 10 Jul 2024 20:57:44 +0200
Message-ID: <20240710185743.709742-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the swap() macro to simplify the ath9k_hw_get_nf_hist_mid() function
and improve its readability.

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/wireless/ath/ath9k/calib.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/calib.c b/drivers/net/wireless/ath/ath9k/calib.c
index fb270df75eb2..4b331c85509c 100644
--- a/drivers/net/wireless/ath/ath9k/calib.c
+++ b/drivers/net/wireless/ath/ath9k/calib.c
@@ -32,11 +32,8 @@ static int16_t ath9k_hw_get_nf_hist_mid(int16_t *nfCalBuffer)
 
 	for (i = 0; i < ATH9K_NF_CAL_HIST_MAX - 1; i++) {
 		for (j = 1; j < ATH9K_NF_CAL_HIST_MAX - i; j++) {
-			if (sort[j] > sort[j - 1]) {
-				nfval = sort[j];
-				sort[j] = sort[j - 1];
-				sort[j - 1] = nfval;
-			}
+			if (sort[j] > sort[j - 1])
+				swap(sort[j], sort[j - 1]);
 		}
 	}
 	nfval = sort[(ATH9K_NF_CAL_HIST_MAX - 1) >> 1];
-- 
2.45.2


