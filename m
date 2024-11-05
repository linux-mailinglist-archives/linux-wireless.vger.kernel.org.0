Return-Path: <linux-wireless+bounces-14939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA59BD86D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 23:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822D1284260
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9301E5022;
	Tue,  5 Nov 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYm8i6d/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C021DD0D2;
	Tue,  5 Nov 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845411; cv=none; b=hDpSKGFzpqvS1EoMsk8Y00zFC8HxNHQUvJHTp4vOvEFXrGu8zsDrwx29nIoibCbUAkc9Lz1vtFLnZT+PYwji4gFAo2QzKiOtuprw1KJpKwN0eHu0Jf3Pn4InniKHLc94ITwwp+/QmJcm1iiXjwK6/yHoXiHMnZ6cYbIK0MRFiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845411; c=relaxed/simple;
	bh=PSDevF+9bpCAhn90b16Axgvx24s7F8xiPpVOOdIKsSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBIc852DG4LJWfAUvw7+DtyKHHbVhqGhCpS1ASMuPNu8T1QBiQ3y9yU6QlIV+DiZk+Y29hf/PvQcj+7RSBt5dCH3gSnavFWVRCHgnn4Xz12HDVh/11zLBaBd4vh08ClWx0xUqFksrc1X80U/4iFkavuc+Z4ts9vXtltaMtZHQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYm8i6d/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582cf8so5214745b3a.2;
        Tue, 05 Nov 2024 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730845410; x=1731450210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfEsgTfKusKVWTPk7T748FiQhgqqZfqkXXFdUcb5tus=;
        b=dYm8i6d/l11yLUp7qihpbHC/l30SyZU13z+r3f/HUMmE5zm8RQf1FoPg2FmilxZ1S3
         m7o7EgXm9BG+vZJYHRwydwHVlhMvTjl4lGfesGXrBj0CKKMU1Fy1HF+QlnvXIPbwnIxj
         7bRaNPzVayFOr/3WpJnKb/Kj+DuZ2sP0aklhI/Q6cOup8IgyhlesmWqQB148PVDSyyZu
         nuGgh91BJkKQGJUFQxRW1CI+4YsuTHbVRGIAbpn/LJFCxt1sDiCske4gltiVn2DqcPJk
         1EFPxSa6k9Cjnjw5l0f2/MbVR85Gbnw/zo9OlQCR6oFZetvxi/Q7kFFZ3JQ0ugLaqmfh
         D1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730845410; x=1731450210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfEsgTfKusKVWTPk7T748FiQhgqqZfqkXXFdUcb5tus=;
        b=HZcuNrsg1ezl0Ey8HFkgU7lc0uwwYDle2FMAvvupHhOH64xK7E/+I7EBPgT0X6VUz9
         YtnIslWeyjZ0YtwtAl7Eq9/wUlewBKnRjCDd9XXAdSUlXaNIud+aXI1BvFR7jVvDf8Fx
         Z3RjTLif9oSY4WOxTUR3YqslCGTnVH8mRjHDUlEveSakGJNmrFHWHQml3zHAIH21petI
         vWgjFJ53ELzHyGn6hPloNo3M6hGpSAjLjJuf2zk1wItnGMyN4DBJE3bom63OJTcmEvRn
         qmUdE+cC+RUNxwyq5D55n9z7ClN6cbfs3g/mNuThEOUECKFuEACPA6wPzzKaYEbwJzPo
         GpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl+GbTMZn46HDn2mgJYr9frVlfkMPWueORat+mWxptNii6kJCQHsP9kGirdOUTeYKkpDIgcvwcF4ketfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXmrOjk7/tmYdgMXSDWTLr1gjQ4asA3H6/c1Uddzme+qTwTkm/
	Ltn0fH1liSlUxQO1hMhqT5AyxgK2Vaw/NcUNParMGpi5rMQD6v5VQ+FI5Q==
X-Google-Smtp-Source: AGHT+IENY2XxairW6ZJWBwXhI+SdDR6RNm3+EoGONnUXF1W6LfgjlCrYNIHry9L/+lYqU1DqKzovuw==
X-Received: by 2002:a05:6a21:78a8:b0:1db:e464:3663 with SMTP id adf61e73a8af0-1dbe46438ccmr9967318637.17.1730845409056;
        Tue, 05 Nov 2024 14:23:29 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ed42fsm10219469b3a.78.2024.11.05.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 14:23:28 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3] wifi: ath9k: return by of_get_mac_address
Date: Tue,  5 Nov 2024 14:23:26 -0800
Message-ID: <20241105222326.194417-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
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
 v3: only return EPROBE_DEFER to avoid terminating probe.
 v2: modified commit message
 drivers/net/wireless/ath/ath9k/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index f9e77c4624d9..01e0dffbf57e 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -647,7 +647,9 @@ static int ath9k_of_init(struct ath_softc *sc)
 		ah->ah_flags |= AH_NO_EEP_SWAP;
 	}
 
-	of_get_mac_address(np, common->macaddr);
+	ret = of_get_mac_address(np, common->macaddr);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	return 0;
 }
-- 
2.47.0


