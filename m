Return-Path: <linux-wireless+bounces-10054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EF09291F3
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78886B229F0
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638664D8B9;
	Sat,  6 Jul 2024 08:29:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66A82D6D
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254564; cv=none; b=X0bFN3O5TtaCtiNwD8HT+2RJWV2TqqA+/lJRR2j+FsYnjw2xC7IsW60Raq1YFqYrCHr2v6MPDvY1lP66CVC+ILfS/G+fOTJH/2neACkFiX8hZxVZt0rvk+XUgq940gQHCZUkeUI1iNX/VHuQTwMAEckX9VmlyoREsXBjmwA+JJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254564; c=relaxed/simple;
	bh=DpAUH8b12PoPScKJCpCRntjR/bJhjKkNwo7JotPkIWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6/V5tX9dOF5xjcIiBAX9eUSyjjG0LZhaNWkbtOxVRbLfq+XsmwTdDhDlf67ZzWw9S4/I1jmIJ5Q59HiV6rQMQcVNtlHhaO/11z3pTxPXSyuq9T5gPBQqN9FCXwG/yG27xOzRtVi3CqkAU2BrI3mR2DNsrrAGRCwYnLtP001uCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c665d8345dso14538eaf.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254562; x=1720859362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDWsadwt/xEY8QJ0HP1J0p9sCg8C+huC3dGYVm5QTrA=;
        b=pwjFiHpxJ1AG5wMP0E8IIvEE2nw3hDU7Bb0o5p80Rn4HLkhK1rlBnVgaXTPfLHVXop
         03hZcORKdZp1bNO3cjMaAZdup2diaP3iqBQsNIp8HZu94oHbLkQ4KBufNU2nQA1Oqi3L
         9Fo1CKlxZ3o1GxcQtqyRtz9gnNvq2vLcCjALVQ/px6v2w/zSUdfwXEM9rkPzMQBkJFzD
         q+ff05ue8+QEUQyZ5bQ0NWe553b5MmciqSyW4tfRN7QQo5uZ4CFr5CYEnYtW+W1glpum
         51GJ2Y1EYIkLE2VCjCZHJZGMOJ33bmEevpdbUxrd/4FvS4Olx5nqHhHTUFSVZ7lv1Wgy
         IkFA==
X-Forwarded-Encrypted: i=1; AJvYcCWWTU9/RgekoaLz1vmRutCwLfEkwY2zJlbLCDeB3C8W++ZxdaNfz7ThMyIkKq7D3LlGlU3j7Rpz2J7XIbyyY2w7GLEgVohZH9iDlyfrk14=
X-Gm-Message-State: AOJu0YwaG3XX6REzRwXiyeSvKWhx+K2mmOOeoWlHJrdU18YnuqslPgcu
	cP7o1b2umigmxVl7CKzOchV8lfs/Gkmm18t9/OJuuQntQiYN2xcq
X-Google-Smtp-Source: AGHT+IGSmxnMYI6qyVOuKJhXuZQsvKS/iLknCxT8PYn3N4BOpFvg2ZPEwrqQXATr+hHCnmcdeoXbWg==
X-Received: by 2002:a05:6871:24d5:b0:25c:f5f8:a80d with SMTP id 586e51a60fabf-25e2bb7606emr6642955fac.2.1720254562101;
        Sat, 06 Jul 2024 01:29:22 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:21 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 35/37] wifi: mt76: mt7925: update mt7925_mac_link_bss_add for MLO
Date: Sat,  6 Jul 2024 01:28:15 -0700
Message-Id: <37fcf3ea7b4883840d61f97231277b297e1b15a3.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Update band_idx in per-link BSS to be auto for the MLO-enabled firmware
and the MLO-enabled firmware only supports omac index in 0.

The change remains compatible with the non-MLO mode and the older firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 44d9da5aadd1..0c4e106ae735 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -333,8 +333,9 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 		goto out;
 	}
 
-	mconf->mt76.omac_idx = mconf->mt76.idx;
-	mconf->mt76.band_idx = 0;
+	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
+			       0 : mconf->mt76.idx;
+	mconf->mt76.band_idx = 0xff;
 	mconf->mt76.wmm_idx = mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 
 	if (mvif->phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-- 
2.25.1


