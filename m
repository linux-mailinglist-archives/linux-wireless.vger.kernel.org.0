Return-Path: <linux-wireless+bounces-21785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDADA94FD8
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 13:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E5A7A2BFC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453931A83F9;
	Mon, 21 Apr 2025 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX3zvUv9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895E208AD;
	Mon, 21 Apr 2025 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233603; cv=none; b=cnpWfovKRkPP3Sis1mXldIMW4s45HtlzhL8RvsCalAbQvZCGgDx8FhNMIz2yLmcY5n2HE/ZNE6+FC+9wwklxoPvopUzJSqs5ITsx2ZrRVX0cuZdxQTNpxwqMQbXISNAStyjoHDbDiPhZzEH+dkCG8hyWkdSzyHhzGfmACNqCWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233603; c=relaxed/simple;
	bh=nYE/GPBKgV5rdH3Np+KQo5T8RRPSiFT/CZ2aYXPJSFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3/7cDATV2Kd6g+Bc9msr5jZHVTfVitCMta72NO4XPg0UE1h183X3mVSbBZwxduZoUs1S1rUyy/4p4pHcWhQbzjDtaSw3ZOTkQqlNxy/2bIh7dcPQ+WhpoiU/vB8+Zt88EAVy2IMM+Vp6S5Lexi1IF8k+sf9AeVlYWroTCtQshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX3zvUv9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c30d9085aso2791767f8f.1;
        Mon, 21 Apr 2025 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745233600; x=1745838400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZR2UVpqmeFDPx4PfDo4Uk4g9Hsu2oDRhSNi1KzWe7k=;
        b=fX3zvUv96i2WNtXnzMmtNs4w/zs8xyY2Zbz6KMQaHcaBdslBOXXenNRNQq0a3ZKv4x
         9pwMeqii5gTdVtFyGkj9vOlsdDga2mUHhff7jQLq2VVUWWi0RWojC+rIbichNrGmrj0U
         1H5cOy08ZJmYesVYScnv8Om/KJgVahn/Dh5xO9hgGZEcs7zltjM8zCc/nIfKaaYBCmRP
         6EqKzFapjhJjdRbW053VnjwkfB/zTbm8PF3epbiLLHNxYcPZ1oHGppMzwvd1KpLfy+Az
         6XSwlGUAdcRmiNVbew/p/olVnIt/niMY6kDsNUKvwcmmUjMofGnHFotkhsQ2ga/rQGSM
         Mlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233600; x=1745838400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZR2UVpqmeFDPx4PfDo4Uk4g9Hsu2oDRhSNi1KzWe7k=;
        b=sd4Ty023cavKbfU0g8o3/8mYpccMQgVQckwlIEDlmpbedXevFRAs7zzBnETa5RTEr+
         84FreyYX/E+J+Qbpyub+YmjtvoayKg1vRW+X4h6EMkOK4svXMadBfAx1J7bJzmEhxmGo
         WqGnhu8/+B/Q8XY9H2fGKfYgtI6MVNr56MKetO56YHhPqIRqdgk9tk0ijZHru4bjZdx1
         U+ZFtfZGBjjzx6bgmwpdPdN8p7s49ik2l/1lSrTeFSsa3jnZpdI6UtXfm26EUkYrLsAT
         dw2ijHGWI5tJB3lfrQ4vtTS/U+4BcQVYlZAFK3V5OJxH4wade3V+Avud0uJS6Qa9hAy+
         9POg==
X-Forwarded-Encrypted: i=1; AJvYcCW51SuwwujD/jv77F6Ra5CQSpefaj2KeJwE/rPjv8FFfNUeeMVaaEwxN2xeZBMdOylmj8QInEujwQFcbp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwu/RrRN0nUYqd4rCWuFQrOvBbNqk6R2p6Y0eu3nfNJGdyFa8t
	9uRxm8Jhob551s4CYC9CIOlDJaeapjfziin6lP7C9Rp+wo+ugDw8
X-Gm-Gg: ASbGncuhX9jDOBoY48x1/z4tBmhwg6g6SeczYyqyW89kBC5sNsbg7+skcXZYMPDbvcU
	0HMKrx8V6tfXxMMyJO2fiLz6hTsRAgEOhHn/UO9YLdgh9Mz7GEyfMSgzyHJile5i/p7j6ZKNY78
	Xl8iZeyYeKA/ZhXhFM2Escdjs2x+u7phxCEdjujYvqhDrnUb3mmDHQKnataS3xd4yRXcG+IE3Ko
	0EHBWaOzuTOmuhtSnxglWhtptmohM7rs3Wc+9yXSsPotLlfX54sZKBmuaL27b1ku41cLR/Yw/h8
	HavVTUcIyJNBkrgekcOnp5W5Fv1IeAvMDIKNBtkMGLkdtOkMeM4XxpE=
X-Google-Smtp-Source: AGHT+IHtD5/1rHmlT23aH1jNp5r6/B3KW7aVypDmNsW6+U1WtU/SdcmPYNzY+80Sukpawj5+HxPkuw==
X-Received: by 2002:a05:6000:1889:b0:399:6dc0:f15b with SMTP id ffacd0b85a97d-39efbb058aemr8266067f8f.48.1745233599657;
        Mon, 21 Apr 2025 04:06:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:fc11:84a0:480d:20a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4235a9sm11644652f8f.13.2025.04.21.04.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:06:39 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
Date: Mon, 21 Apr 2025 12:05:50 +0100
Message-Id: <20250421110550.9839-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If link_conf_dereference_protected() or mt7996_vif_link()
or link_sta_dereference_protected() fail the code jumps to
the error_unlink label and returns ret which is uninitialised.

Fix this by setting err before jumping to error_unlink.
 
Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support")
Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
v2:
- Added missing semi-colon as pointed out by Jonas Gorski

 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..70823bbb165c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			continue;
 
 		link_conf = link_conf_dereference_protected(vif, link_id);
-		if (!link_conf)
+		if (!link_conf) {
+			err = -EINVAL;
 			goto error_unlink;
+		}
 
 		link = mt7996_vif_link(dev, vif, link_id);
-		if (!link)
+		if (!link) {
+			err = -EINVAL;
 			goto error_unlink;
+		}
 
 		link_sta = link_sta_dereference_protected(sta, link_id);
-		if (!link_sta)
+		if (!link_sta) {
+			err = -EINVAL;
 			goto error_unlink;
+		}
 
 		err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
 					       link_id);
-- 
2.39.5


