Return-Path: <linux-wireless+bounces-11439-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CB7952051
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D0281E90
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821891B32C1;
	Wed, 14 Aug 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmHseTzj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157F1BB690
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653942; cv=none; b=YwW+B/UQ1ig85iOfz0+xVgvmQcal8RtJaxwS+mCf9gGtLq3eCzegC14Mg5v+Bpmq3gKD80ZTmhxVWrfVTVc6WRBcyKziYISJ4ddKlrIG7jqO7NtgWZgD1xVo/xa4MW643wxgXe404JgTe9n/SwIcicqZhtfRWAZow6R8816c0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653942; c=relaxed/simple;
	bh=z4WGTSzjzqpvQ/tRcSN3ioNJh02e6ZDfhMiaLn+LpWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIfWDTw+Je2iAUs/le/DkCh0mJkt1ZXhLAXjuCG0L1k2dvBpCT+XPWOgaLxp19EayfjY1a2AhWqOaTpuiSq1Avb4hPKAlRfMnzpSIwy4NJmv7jPHmVQnftuiJUHGfJZ+bAY9N1UGnUtmvAMefeN6hLgwuh3Z/efU4bTBY2jWz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmHseTzj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso62373e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723653938; x=1724258738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGHGrfhVZGCi7ebZvtlasyvLsOQ+wsjF4xpmwarBNSQ=;
        b=cmHseTzjGrrscr59qsjBn21XwMg/C/eu8IaUJuACKX5bOGT5SHGQB/E0RkU06gfXX5
         SWZDkLj336rkt53mBItrnEDw5YEO2108aitfwBRTrSgIBJpCksyTih8a/NawOJRsqDdq
         l9frMPPxheXA28c95YrSSlXQZ+tYfpXCWW82AMq0OlAHkhaNySrTnxWDwzqbwF5hBmqe
         e+XBnQ54ST4K34a6NlV8LVixgpAgO2Mr18KzbI4FuzBiaM9XBXNu12ICvhlqUV/yatN8
         U/QYoQH+dNPlW45dp6hWAOXnzDvsU+spoxv55+NJKr/soZcwXKpO730YgLzmXxaPl+5f
         gG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723653938; x=1724258738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGHGrfhVZGCi7ebZvtlasyvLsOQ+wsjF4xpmwarBNSQ=;
        b=YsKGEpoAWvCRuvncZunE/BO4hCmjCRe/f7H1hP6aMz+5PECcjrvV08aOUWVhIf3jEA
         LbLgPZ9m1xp/dJVkECvXntbdxgyOznnOpxh3zWdIAc7YUkeftQIlzlPthw7sdo8aevMm
         1KwFy6l088PrfAIX80D1bmuX6snRZ0TVzC3HOcP29W75j2cB1/DmJR6gJQbBnBAwo156
         M0yQ3t3JREpPAFqTGPHR07LPzh/oGNnvA328LZhF3E2uUiYhD6+7T/PSZ3SNFPpaPm/a
         HPPkUgiyGgWRLOT1hmN4zf/bFCxrcW5OwcO1RrSHGCx7JraNIdgw1Ds4/AMRgxq+/fyZ
         43mg==
X-Gm-Message-State: AOJu0Yx1c0n0x/QZdy6plY5F8l1JlYuCzFX6X41XBUbBZOAPDiCJ2Bk1
	LC/t+x1xpV1F6dRrenpj2rgkUhbvjhn/UplFikTlcmlZMOo8xYDiMH0Qsw==
X-Google-Smtp-Source: AGHT+IGVg6Z0mt0BxnC93MsDZoAr+SShVFVo+bU62HnJUJOcbpwqge9ERHZqtEV57lc9gM3wwjbHyA==
X-Received: by 2002:ac2:4e16:0:b0:52c:d80e:55a5 with SMTP id 2adb3069b0e04-532edbb301fmr2484707e87.41.1723653938262;
        Wed, 14 Aug 2024 09:45:38 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f475ccsm196326166b.14.2024.08.14.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:45:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org,
	James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/1] wifi: ath10k: reduce timeout for disabling a key
Date: Wed, 14 Aug 2024 09:45:07 -0700
Message-Id: <20240814164507.996303-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814164507.996303-1-prestwoj@gmail.com>
References: <20240814164507.996303-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QCA6174 experiences random cases of a key failing to be disabled.
The timeout for this currently is 3 seconds. This can happen on
roaming when removing the old key during the transition to the new
BSS. Though the roam will generally succeed (except with
some AP vendors, explained below) it means that it is delayed by 3
seconds until the timeout expires.

Certain AP vendors appear to have issues with this delay and either
ignore the subsequent reassociation, or reject it. This results in
a disconnect.

Since key removal is a non-fatal failure it feels somewhat safe to
reduce this timeout down in order to both reduce the potential
delay and play nice with APs that aren't able to handle the delay
between authentication and association.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index ec8d5b29bc72..fd20107abd0f 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -301,6 +301,7 @@ static int ath10k_install_key(struct ath10k_vif *arvif,
 	struct ath10k *ar = arvif->ar;
 	int ret;
 	unsigned long time_left;
+	unsigned long timeout = (cmd == DISABLE_KEY) ? 1 : 3;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -313,7 +314,8 @@ static int ath10k_install_key(struct ath10k_vif *arvif,
 	if (ret)
 		return ret;
 
-	time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
+	time_left = wait_for_completion_timeout(&ar->install_key_done,
+						timeout * HZ);
 	if (time_left == 0)
 		return -ETIMEDOUT;
 
-- 
2.34.1


