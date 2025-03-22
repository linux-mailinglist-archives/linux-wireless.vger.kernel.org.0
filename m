Return-Path: <linux-wireless+bounces-20706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0327A6CD18
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Mar 2025 00:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A730171D16
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C2198E8C;
	Sat, 22 Mar 2025 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsz31ORs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0271519AE;
	Sat, 22 Mar 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742684503; cv=none; b=XmLQD2nV9nabP/3P2HkL6cUUnIikfhGDRXykgqVtGLKI2ETuhlghFuooPC5TqImFBHeNBsR1v08ZtVJo755YkCgcpBwo5xm83rxg0UBFn/pmXyvfWVQZrOowJJT4lJsLNG4J2FcpzaROeWjeKUWNIxFDGLUY0wqTSNj4FeO++O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742684503; c=relaxed/simple;
	bh=nYE/GPBKgV5rdH3Np+KQo5T8RRPSiFT/CZ2aYXPJSFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EDY0N31qANbal/NadclzVWyPHN0IMdKR2cv/PNZjEPJFhi2aOuTTIhPrK4SRBtnNAzZ8yapoGb2TwdMg193qU5ToHL7ngKH6wZTJNz6iRbzhCv5ui2EEc9QXnKAaO0qpDqldYOGm1NRCQTgjBMN1OpYfanaeDvuEkTPZirB5U/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hsz31ORs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912c09be7dso2036296f8f.1;
        Sat, 22 Mar 2025 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742684500; x=1743289300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZR2UVpqmeFDPx4PfDo4Uk4g9Hsu2oDRhSNi1KzWe7k=;
        b=Hsz31ORs9BeJYwZU1pUBWIEyz0FiQB88KmXjq/kfQxvyQgRlzSCV0gKKbI4C81qW+A
         2cy63d/cQ8MiwCpw/FkjgCEd5oj41TsqkwDl1ZEQTBQTOivZ7n04yBiLYgtTLuOXz9Wo
         G1GTr/Bptj9Icu9GTb5NnVpfgZBpFDO10VhOMU/fD4+dDg76BAYyFVFpNyPfMPQXlF0L
         R84xxzVtRfooutI36+ACzBgOA68lqrJ5HW20uV8a9JWmcUF8NTJaFIfWXkTXDeT5jwCR
         7i8043+TdpfzfmzruLhZgnhg50IqkPN0PuFmLPwp419dJfJjiDqgMHrmKHLfD3s92c6M
         I+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742684500; x=1743289300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZR2UVpqmeFDPx4PfDo4Uk4g9Hsu2oDRhSNi1KzWe7k=;
        b=isMDPVqk2SIYqcP2VXEYaTAHIoPi/Un2Wgg2jLR03rCEaxV0AqNwBh9f9H0k0PvOPR
         t3n5gp8ZTGT9+I0OuEH50XB88ZiuqyqLwJN9ajh6FKddpt47wHLssSs84sL4W5v5miSw
         LmVw4qlRnDXxMWglZnURwEGAJdjt/mtxqAi602fZKZTqztrtJ4zqE5oErVOu2HH8MxN5
         UArohNxtjhllNrDPTf5Gd2ANIW0er6zCfIcOl3oNikUJptv8noEydp9TDCeLhdVNdueE
         cuQZWv4KtFG3z9wFSdaVgHSYMtJWiOQu7I1Th4RngMNd4YxX0mysDjcSqS1JA5iRugTz
         z1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEfsEwXswVBbAZ2kmhlAxlBi72Sdzu1jJH7/NGxs5PfM0Fs6jU0RDb6Lk8ge94qLSe0sbY0lfkxUGl3gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EH3IZLRl10d/6iRufvvabHCkrJXkoYo/HZ3i7AtfW7Gd5aTW
	1NHqwA4PsMGybkfD1LrKSO0axgiaRcC76zfll/P9pHEGcnAwU293aAUmTA==
X-Gm-Gg: ASbGncsn4P6G1VYdJas2NlF2LKL31ZTo92b/bONv0rKNJg+YZrkPf6Mu2MiqQJcFG2/
	Lf5KRcdbfXXjQVeRFWjtngIX/NxGpi6+pAGvIe6O1HIl5W6PVTMjm4wlMSUe+vIl1Y3ePsIcTcS
	pF7T45eUojMmThIQ1q5aktDb3GZe2AWE9+we3UAjj/p9knVLYmzvN4QihCzcnvbzH2pm/Y5jt3e
	Sonz1vBHTBu2emRgQTsBHubBBrD+gTtE+LeztiQnr3prbuMpjSANhP6GRYYG+sLJB1m70HznUyI
	9s5IqdDgM/r8O9KyI3p9aC7zsS41C90+v9Ez5EWyIYRJnw==
X-Google-Smtp-Source: AGHT+IHjCKrhSEzyg1bOP/bYmKQPvVEa5OEsNqQOvW5LA8oKHtiOj2mV+K4xOb9q373wp3gepKGEtQ==
X-Received: by 2002:a05:6000:1448:b0:391:253b:405d with SMTP id ffacd0b85a97d-3997f933da0mr7944371f8f.41.1742684499903;
        Sat, 22 Mar 2025 16:01:39 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:ec99:3da1:428d:90b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f2asm6261120f8f.30.2025.03.22.16.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 16:01:39 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com,
	jonas.gorski@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
Date: Sat, 22 Mar 2025 23:01:37 +0000
Message-Id: <20250322230137.28164-1-qasdev00@gmail.com>
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


