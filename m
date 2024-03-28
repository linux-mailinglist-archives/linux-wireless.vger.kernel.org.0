Return-Path: <linux-wireless+bounces-5416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A388F440
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 01:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DD31F2CC10
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 00:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDAB17550;
	Thu, 28 Mar 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLg6Nwbc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157518C22
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711587469; cv=none; b=lBXec7DVx9q7zTgsTxFmIJ+dsLBYo8F5Dsao9L8qXXZdHR/4wPt63o82IdXMQh9rhGQRbpyql6l0OpbUHCBeKQiDlC7HYS3P5wXAKihS/09HRw6QmdNly/2FKB3FsOinwFdCUWfXMwtnR3cN0NFCwChQyzpnysTQ+cnyta2oYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711587469; c=relaxed/simple;
	bh=N+KfodBidYylkCq2HXBEDWmalZz/B4Kjtu68NJi7sLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HjVWdCe5imzzwgD+xxe2IZ+HrGLwZI+itBSiHpJ05LrVsh/LmzzV5GZx4NOvqtzSke7zUka/LDyTbanhEZUdQJ02tNvzEQVCv3Ki+Lr+35gzCscWpYslq7LTJCmuKYQ5uY99Ds0L4IEr3T1HP4Li7KGT8bcU1qrsciHB740sHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLg6Nwbc; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a558d9c33aso232647eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711587467; x=1712192267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mIRSx0mAmbITPiG9xErKUADrU3ARFxRfq2BAbihreo=;
        b=DLg6NwbcaSztJLgYtWtRlmzcwN8qmWTzND2fkiNZkE20Ppb76i0MGf3RqJM8hAuSCq
         +douYGfXpYI2CvqGWcBFwhzQ81uEzBewMjELPzzC8sIK7ykpysqq8lI8LbkgMVdU0SEn
         M/a9/Gpz4CBXDRvVai0y3o//HvBjXA+9hkGOgDTIxEVLv0tCAm6farRDQIhcGLIxc6HF
         ZSE8l4H0x/vHiSkcp1v717/F4AchjzQaNGhTD99ib3UEZWMHp/H0GPccCANic2s/frJ1
         TVXxIkbM3Uq4qn0xcPyl8cybx4dNEIewfInS6pXi8+q6llOEIY/lkbKeijKB06M88rkt
         cBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711587467; x=1712192267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mIRSx0mAmbITPiG9xErKUADrU3ARFxRfq2BAbihreo=;
        b=BNjT7hTeXEB+5JUjeJaM5H0Ic3byF5Z1OsC51QQy0fG5/rmtsdiuLXZCuok6K8WN7p
         S0xP3L4jlD9ca0OWcU2Ict+2gVTqsDPeYknhNWF09cTvpFEDNjSL2THeCLmq13iIIWuN
         CjtFI8MwNBKDrbKY/zD8T8R40heOHQyTEXdwb0tfOchfFk0k16WAyLRcO9OyIfblhFNX
         4cqQRFppMqg1/AB9k95j5P46Q361gS6abHFeugQrl03Ftk7SOlk9BJAwiAShJlHrTeCC
         rZ0IqEHATpt6r8OUXRgNoNYK1XQrAwvOUlW8APFzUIekbpXJXFb17V26HUM6dZY21QiJ
         Wt5Q==
X-Gm-Message-State: AOJu0YwoPezD7ZyLOEiOUINlu0WikKW2THonvbIzI8ynUS7wzpAW2O84
	2JCMRxo5DfgW51V4ILvEaeXHuiYt8Q0MhYD+ruf/nsmpnQCv1sQ3
X-Google-Smtp-Source: AGHT+IGgElZdZDWRAXc9zMR3lTKO6akRclsFBxWlm6F2VjWTPlBXKO8y3FTpFkBEJRKnVmo/gCuImw==
X-Received: by 2002:a05:6358:419f:b0:181:6574:a9d8 with SMTP id w31-20020a056358419f00b001816574a9d8mr1229034rwc.6.1711587466960;
        Wed, 27 Mar 2024 17:57:46 -0700 (PDT)
Received: from localhost.localdomain ([159.196.169.81])
        by smtp.gmail.com with ESMTPSA id 192-20020a6301c9000000b005e83b3ce8d9sm136318pgb.8.2024.03.27.17.57.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Mar 2024 17:57:46 -0700 (PDT)
From: Richard Kinder <richard.kinder@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Richard Kinder <richard.kinder@gmail.com>
Subject: [PATCH] wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field
Date: Thu, 28 Mar 2024 11:57:25 +1100
Message-Id: <20240328005725.85355-1-richard.kinder@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Logic inside ieee80211_rx_mgmt_beacon accesses the
mgmt->u.beacon.timestamp field without first checking whether the beacon
received is non-S1G format.

Fix the problem by checking the beacon is non-S1G format to avoid access
of the mgmt->u.beacon.timestamp field.

Signed-off-by: Richard Kinder <richard.kinder@gmail.com>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 47a2cba8313f..6c89e2e4886c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6185,7 +6185,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 			link->u.mgd.dtim_period = elems->dtim_period;
 		link->u.mgd.have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
-		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
+		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
+		    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
 			link->conf->sync_tsf =
 				le64_to_cpu(mgmt->u.beacon.timestamp);
 			link->conf->sync_device_ts =

base-commit: 4076fa161217fcd64a578ca04586c4be728cb004
-- 
2.39.3 (Apple Git-146)


