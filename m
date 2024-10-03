Return-Path: <linux-wireless+bounces-13432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EBF98E860
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 04:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DF0281563
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 02:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F10171AA;
	Thu,  3 Oct 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKJE5hAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882712E7E;
	Thu,  3 Oct 2024 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921856; cv=none; b=D/5gUpYsyazBP+do11vqUvzi8cnZvbU/CMy732Xcy7eJ59LadY4vQ42Muvxa9VxK0quqj9nlFEJVGwV5/MMZ7IAHckXif0kqEgCApmLPYo6pJ1b10JJ/B7ttgxXEdFkUj0l8oFJocCWF66SZ5VvqHbO6bWGuN5HEkD81BUajwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921856; c=relaxed/simple;
	bh=RmRVst64ZEQd/A6urq0Eahz20qftWvwPh7sv4j1v5tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FppRDu+Jwtlx0Jv5znpRqZ3z2Myf1kG7VWiw9VwNCF36ZhiX7vaUonN/Kx/WP6r0jUJNSNQ3uKKhGlJilIpwE+RWEUeVW1726LH1DBiqCqtUY1MoygQ5ClN11SZ/PWRMbI9veYPz4GaOpp8q44z1smFwm8Is9p4Az3BT9OHmANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKJE5hAU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b7259be6fso3783965ad.0;
        Wed, 02 Oct 2024 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921855; x=1728526655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHx6vU1ME2OnvOlH7k2mGAPyR4Uu9ah4hPTObNBm8ak=;
        b=kKJE5hAUivagusB3E2lJZeeltXKmkarKOaLWwKp10z9vmIHsmNI9VfTTxTnA6NmsFX
         LfAFr0HwbKfsUmIqoQ3J8T/M2RY0oIcOxjtX7x1YNWKlE1C03kStPuI9VDc+3RkZdn69
         9ELfrXNR+w6+YknLiBnZ4lNdedC8Dk1ZIhIkW1R8Ugf/60UDLcOpx5d/LAhFqALFkI/H
         ZUCX3IdPdIUrFSeDr3vBE4w35HG3SzCk64u8qRO/w3MBAnB6H72GU1ijNTonsGgImyuK
         P5pMwdAtcJMwpkQ7EGPLPSYdzUQC7Gp9fOXP+kSsYbt4XgCawn0U2GZ28q2taXYSNv5G
         hH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921855; x=1728526655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHx6vU1ME2OnvOlH7k2mGAPyR4Uu9ah4hPTObNBm8ak=;
        b=FQC2vdo3ya6sd/W6eTSYnXzmYGsRhl/DT43U/LamRS+ooDBx3+Kv3GTGIy5yk02meI
         QddDQGCDr2mxKw1+tKaa0+pSO6X8vA6iggQqfSMeMYkpw4fXlp0DZwycOsQSIAXksDQT
         w7jQGIjLRn0QH8RgNL7dRlZM8X6woUDmlFQyf99ViVR8Qk8N3IXvEDh2ooUWx277USvx
         E9MPRfiVNL4J6ztMPS8II+DV5UZJfbjhIDDAg6D2sg5z5lzTexHu+6BKGiaRSJPu3gtp
         g8b8r/Ojfl7ESZtLrSk3rh02LJxcoGQz1tbsTJ7nWRMyP8cjkCudTEavdjf4mQnESaww
         tLLw==
X-Forwarded-Encrypted: i=1; AJvYcCVC9G5TDxRrKhlTmu9nk0gO9dU3mqbEHTqd9o9muAqH605G/4su0vCDJ9iGplCqjDfNRF5baEGTZMv2Nrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKbqB+sJizqhmJj34iLNYyhQDizkCRn745JFRI8FD8xZrxAIH
	G/kmXqdKUlDyq4GF6AHI3gabMk12I+jwahnojN0QXKE3NeErV4L9VHFfOf8O
X-Google-Smtp-Source: AGHT+IEmUmCFpE7t5S4ZMOKly/rQ3wxk255nkSI+XkbDoF6hRSrfSyTuNo/pDhDcG9dZMPt1Zh4TxQ==
X-Received: by 2002:a17:90a:68ca:b0:2e0:855a:ab31 with SMTP id 98e67ed59e1d1-2e18466dbdfmr6224209a91.12.1727921854723;
        Wed, 02 Oct 2024 19:17:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f799b60sm2388378a91.29.2024.10.02.19.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:17:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2] wifi: ath9k: return by of_get_mac_address
Date: Wed,  2 Oct 2024 19:17:32 -0700
Message-ID: <20241003021732.1954299-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using nvmem, ath9k could potentially be loaded before nvmem, which
loads after mtd. This is an issue if DT contains an nvmem mac address.

If nvmem is not ready in time for ath9k, -EPROBE_DEFER is returned. Pass
it to _probe so that ath9k can properly grab a potentially present MAC
address.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: modified commit message
 drivers/net/wireless/ath/ath9k/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index f712bb6d1f47..5f4efc760183 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -647,9 +647,7 @@ static int ath9k_of_init(struct ath_softc *sc)
 		ah->ah_flags |= AH_NO_EEP_SWAP;
 	}
 
-	of_get_mac_address(np, common->macaddr);
-
-	return 0;
+	return of_get_mac_address(np, common->macaddr);
 }
 
 static int ath9k_init_softc(u16 devid, struct ath_softc *sc,
-- 
2.46.2


