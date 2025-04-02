Return-Path: <linux-wireless+bounces-21057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0300FA7880E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 08:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5DF16CCD3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25098231A4D;
	Wed,  2 Apr 2025 06:24:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0178136A;
	Wed,  2 Apr 2025 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743575073; cv=none; b=Hi+zr+Y5duhWAJeSbyc9a7f5Galax3iwVcZWl/aPZ0Qdz9ur0T6jPsxjynozsPjVOE8Q0XI8rtnb75eogOpvfjbLH/bJWJ+MZBRLpthrXt2kO/+FsAH1MqTxGMhe3itcJPprkDCAjvBIAbabtrW8pziPL+rKsD76yHylhrTrjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743575073; c=relaxed/simple;
	bh=79r5Ng5WIgkkd9x0rTfvNYKqBKsD6SO8Jbs3mhI6jAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAJdmPM+kYWKAYydpzwfISaNe86wGzBp4ZeRTF1aDstpU6Ec54SzR0iaqJUaHW1t1FnTvw2ybHcoNkQbUDJSoCoiztoCdIkwa/umNfrgdA7eBb34dvkC02VMKEpNs8VVV4imje1/xlYO05z9ZHUzWM4cu2S0GEMPast+zF2+/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224100e9a5cso118620325ad.2;
        Tue, 01 Apr 2025 23:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743575070; x=1744179870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHAwMDUNKa/KS67Igj5f0vS6OHnJzwpFGFxB/aQLDIE=;
        b=xNb65/Rlp3mZwprYSbzGiXflMX0fpUnnLb0fbTKTWbeJ93SQ2qINlNuh2qbGBeoeYj
         N8d5WSXm1G2IC5iHq5onmSucmYKHt5Zt62Z36PvP6NTdscgVCN4IVz/PhKZ+FzgIgUHQ
         GH+9nBqO7BZoKoMCZHC817xsjJWFQGV9RVjy8msmlfc83xfZra8aenbOG4RWRVJHGdcN
         uq5gj1pCe3W+wClFzg8BVm5lX88wCOb0wFMas1Ju9Ll6QmgIVExB/Lan/tA5a/lPdoM0
         AmO43uv8v3L5e8pt8OVOLwGhxu6+FTbvHinR42UKq2uujGtj3O3l91k0OCyMD3JuTEGY
         kBbw==
X-Forwarded-Encrypted: i=1; AJvYcCWpFFZYKl+tX1upwTywVREtYsCmVpRWZjwOEQ90SInI4ELDS8x4P5yNn+SXTxpDpPasdHFqi414A9BrC7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYxroRjrGhdSwBkmdW7TlgrfuCvamnqwDAmZrKOK7OYF5HWhp
	/GWFvTk/oAIWq6E6Vh66hpctXxf+sFy0mRgCEURwBMVylqdEkUeA
X-Gm-Gg: ASbGnctxjy7ShPUgtaXpLuZGYjmDMxYNqQ3ra+2RGBTGX3wQHMELB5k6xcG1hsI90gL
	alHkTjCYmw6mGuH/tFb3RxdUfqrgeGJVoeXWc/yNiHOYGqbY2HwaA11Jt87JDMudMwLZY6AMbmd
	2PePC3XgFhpGIESwUCJ53Berbsx+MS2jVRUeqtoeRWfLNFW99VQ16pc6kOcN22C4cKIn9KMA0Xk
	QyElmcw4rBTPX0pf6rqOk0UsCATfpaUJWm+wTtVFTrvCJWkdrkXQG0zbvs1wbC+IjBWptejm3t8
	E9HlRzMsimVjMk4oHt601NN6f7XRCb3B8ynZ1YfRPLF1+BbHBoHfhRw=
X-Google-Smtp-Source: AGHT+IGLDw+svnuLeVc9Vw/XXckwgRJWmGdIcd/ktneoz6ILKjyAsGLKhpl8Zd9YXMzbaiKU9bXcRg==
X-Received: by 2002:a05:6a21:9007:b0:1f3:33bf:6640 with SMTP id adf61e73a8af0-2009f5ff4a8mr26880852637.18.1743575070034;
        Tue, 01 Apr 2025 23:24:30 -0700 (PDT)
Received: from localhost.localdomain ([192.9.230.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970def120sm10052479b3a.7.2025.04.01.23.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:24:29 -0700 (PDT)
From: jiangfeng@kylinos.cn
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Feng Jiang <jiangfeng@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] wifi: mt76: scan: Fix 'mlink' dereferenced before IS_ERR_OR_NULL check
Date: Wed,  2 Apr 2025 14:24:15 +0800
Message-Id: <20250402062415.25434-1-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Jiang <jiangfeng@kylinos.cn>

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202504011739.HvUKtUUe-lkp@intel.com/
Fixes: 3ba20af886d1 ("wifi: mt76: scan: set vif offchannel link for scanning/roc")
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index e7b839e74290..cc2d888e3f17 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -302,11 +302,13 @@ void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			   struct mt76_vif_link *mlink)
 {
 	struct mt76_dev *dev = phy->dev;
-	struct mt76_vif_data *mvif = mlink->mvif;
+	struct mt76_vif_data *mvif;
 
 	if (IS_ERR_OR_NULL(mlink) || !mlink->offchannel)
 		return;
 
+	mvif = mlink->mvif;
+
 	rcu_assign_pointer(mvif->offchannel_link, NULL);
 	dev->drv->vif_link_remove(phy, vif, &vif->bss_conf, mlink);
 	kfree(mlink);
-- 
2.25.1


