Return-Path: <linux-wireless+bounces-16217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD449EC16E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6444D16915D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33721422A8;
	Wed, 11 Dec 2024 01:20:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF87137C37
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880010; cv=none; b=FvX3SZWg2VyMZvKaJt/0unx5b+BGHeOvrKGFFAONVq95yPqOm+IunIkAGdID8UTmiXQQb7TOQankZJL2dFEjYCIEsUBDJYfc+CL60LLsxNXzbpHlkry531VQlafkaidy9UWTI715fl1HF9VnpxKmpVi0Mh5o6sRnkbX1Vgb0+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880010; c=relaxed/simple;
	bh=DzMK61PDEB8bhmUK0HD911K/DuT5MeZ0duy0BTp6pgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDJF67F6TaUr5daS97hNJZCntHBplzaE5UaNtlmKtvtPqsbilBeiNbQyLg1K8DNjarPMTbbvvXNg1tHjlcr/tGLhn/j+ul0OyqMlINQCdEcfBimZSdJY7aEaN8msRurj5ijlREppp3smoyc/fLE+UBhNeuqT6XGhaBy0DcF/DVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2c51478e5so904638eaf.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880008; x=1734484808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y62PD/q4WifdsD9DWO73O3hL33oH6LRMI1tKvJMAWf0=;
        b=Z97JtWrRjIlKItMB6IeSktDKhBbETmoJHLWlHfQpDQ9hL+V/fy7o3v2+lYdaJDqhDD
         90bCYTJ3ND0UyUnguzx6/j5tFcuLRPd8I3+o9GAOCejBpm0f3J1+fnG3ujm0cZwp2KML
         0ZWE3fDkHgvF9Nqotz4FkWBrAbc3O5sDQN067iE6J1kmuBLpTNSRRfkwpxkNg9HFQ4tG
         Tn3KPhRwnOYCHi+8E9brvnfVET6RT/eL40NJnkO6QqpHtwfeqIzMWJZEMFNnKBzyl73V
         BCFFpi7FzlVEd2foq5ZQz+fBftLDttZiIEE1jgmetUML0TwC3LN09DCb+7HRyWQDJgwj
         Zpew==
X-Forwarded-Encrypted: i=1; AJvYcCXu9KFqwGuPLXQ6oNzTBuIwrIMxe3j5onxoW6RYj7f9cULAbgD9iryuHLtEi37o4ezkgDTu6WWk755rPrLwlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxNcnqmLwIKsFoiiicpqeBLzlRQcXlmPrdfUnI3VctuL8oqKL
	n8nLuF5HhGrAc5kgFG2lT8OUjHTSrVFVvR2E5+KqPBIETWgK25cR
X-Gm-Gg: ASbGnct1Tbm68e573+8GSDZXo01cQL9I0rQwXZ2w1fObKrdpICAiEzUAmMHMQtGhkQB
	Sgq8nWATPrvHXTG4A4err5d4/ST4ZWLWBLmko1kCUok3Se7x7nB99lHkx/5GxbDQfS5v+qQSyCC
	0aO19KTaMN900Uw8vb5Gnf2d0kGMRIyNSoFN4vz3yoOW1e00Rb67XRJ3LEc1zJP5rTcWpm712K8
	vcXxEnIqdYOkf9cSSSJTCtkbKpw1lyt0dzjjtnVswdTiKGPF9hTvd+eLcKtOq/dshzyXRk=
X-Google-Smtp-Source: AGHT+IHi2n0Oe10OpBcmMYum3qtEL9tyj3CRay7lN1GLs50XcirrOBt7LFdX+aDJKqzt8/dNOU+ccQ==
X-Received: by 2002:a05:6870:168f:b0:29e:2d50:11aa with SMTP id 586e51a60fabf-2a012c1ddaemr707724fac.18.1733880008569;
        Tue, 10 Dec 2024 17:20:08 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:08 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 09/17] wifi: mt76: Enhance mt7925_mac_link_sta_add to support MLO
Date: Tue, 10 Dec 2024 17:19:18 -0800
Message-Id: <20241211011926.5002-9-sean.wang@kernel.org>
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

Enhance mt7925_mac_link_sta_add to support MLO.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 93e00a3840fe..9e9f33b6a1bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -878,9 +878,14 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
 	/* should update bss info before STA add */
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-					link_conf, link_sta, false);
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+		if (ieee80211_vif_is_mld(vif))
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, link_sta != mlink->pri_link);
+		else
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, false);
+	}
 
 	if (ieee80211_vif_is_mld(vif) &&
 	    link_sta == mlink->pri_link) {
-- 
2.25.1


