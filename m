Return-Path: <linux-wireless+bounces-16219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F09EC170
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C13B284C2B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E778F3E;
	Wed, 11 Dec 2024 01:20:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0297346F
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880018; cv=none; b=CbEHoqkP4c9nw0zJ35IQyrcBOtbkdSvQcfH+wLdgpVMbkPztkaOm9uW/tl6fHMYZewc9AsEfZWctB0tht4wzzLx+45ANflNoXFmUWvrJRlQ+NgeZ5Vf+ZUFTh5ULVLq0fZc19LkcutBuMzXtYHzn44yRYWDuuRjgQYnnRrEACpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880018; c=relaxed/simple;
	bh=K7T++v3suEkb231OyqJeS1Imd0nNRqHTNNjdhpQ3Hi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz9v4sI3uhCgzHBjDYWGNV7YSJo92bf7g3tuYDg3GlMSdR/9FwJjXgQPZ+yM83gcicUBRPuS0quDEenoYqfAAp2N0G1NFLB+8xDmkIU9PlH68xq1UK6xQa7Gaq7+mCeJLuhMPyc8OD+F0zY8Zs2gSxAEsyS15El2N4IN+xpr1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2bdbca73cso700044eaf.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880015; x=1734484815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdfYkugeufvaD6bBwr+fMjYhLzDCWCLOV5qz0sJPubA=;
        b=rzhsjhKi3KY5PXTcuXpePUCPi16wqN+9Hf7opv2joUalJLrIaJooKttpxNGE6mEpBb
         FBhAGMiT8Ywh7NA+bN/xzEXhtIokd3pddRXlskX35m4X+uELJTugxslSfbBOD3b2Afgt
         md+CZCpj6kWLlDR9XFDGaT2jChRTyPxKKblcfYzITD3OcQ7u8BXPIhdBUxHcu+W5QWdA
         ejpLpqxxLj4vQBEXQQjBQHI3+BB3SvOqWxgs1Ci5X8dgrqZnp6c+FWdjjDfBIA+FFpBO
         yZTYA7ozQ+IslzKuNE4JxvDVH39qj7lkCPGh+aiTrSNxYt4szbPpJTWgX3KFIXb2hkSk
         eMPA==
X-Forwarded-Encrypted: i=1; AJvYcCVKnwsR+antaUBZxjh7B5EKqu5RRLI7Z2Syr9+PavQ6fD6KF8sVvE6ilVYsx6ukujgWOuUkh8Zmp/e3zC/jFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OigZDoI+oEkEazpTtPIE9ZINOkRb6COwFmH7VOhIjuXYpCC9
	B0Ii/vgAe5up/7CpfU8ZQIbMhqt0tRQRrJBYVqv3kTpC37enfECRyvW4wxVyq0g=
X-Gm-Gg: ASbGncvinxQ5V63yxl65kNmXN9RpRg4i/8VSBsvksxsihOuFdfcgqZC8NvUh5yfl5HO
	cJgTxFjTrn41H2NoToOxJdiJlcQ+0KNshJJmtoNk81139G4gyv73+V5baIz0eAdXg2CYKOEQdEc
	dYAcrRDo48YVcaCxuBD66FjhbD2/gK5LY7q5toaO6k7eNNPCJ0n8Ng6m9CnFPR2zpWdCjDIGkPU
	xJC82pYjAi+pOKEBa4UeRkmCLLSeI142tamfp3qpZhLGVXPIHPfImdWq1H9f+R1yP95Z6I=
X-Google-Smtp-Source: AGHT+IFsi/N15YrTJAV4K2mZ/2RhdEDq73CVQz1/8jVmt+l1w+60W75u2y3clZ11ZP1IRXt4WmmcCA==
X-Received: by 2002:a05:6870:470e:b0:29e:49b3:c50e with SMTP id 586e51a60fabf-2a012c1ffe5mr693962fac.13.1733880015653;
        Tue, 10 Dec 2024 17:20:15 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:14 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 11/17] wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA
Date: Tue, 10 Dec 2024 17:19:20 -0800
Message-Id: <20241211011926.5002-11-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Update mt792x_rx_get_wcid to support per-link STA.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
index 106273935b26..05978d9c7b91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -153,7 +153,7 @@ struct mt76_wcid *mt792x_rx_get_wcid(struct mt792x_dev *dev, u16 idx,
 		return NULL;
 
 	link = container_of(wcid, struct mt792x_link_sta, wcid);
-	sta = container_of(link, struct mt792x_sta, deflink);
+	sta = link->sta;
 	if (!sta->vif)
 		return NULL;
 
-- 
2.25.1


