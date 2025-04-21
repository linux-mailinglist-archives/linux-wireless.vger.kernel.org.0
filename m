Return-Path: <linux-wireless+bounces-21788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98EFA95022
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 13:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08E27A626C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6413B26136C;
	Mon, 21 Apr 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV7GMbpN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49719ADA4;
	Mon, 21 Apr 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234767; cv=none; b=rfTeFVyIp69BTIz+WVQQZ3ihmtE1yVvRM0zdtNZO09il/VvDw00TLKPONYG+SAtIej+M3F1om75A8lwaX8gdV6MeVb0uclcT+pdRq2s//3IOzPSnfhsRkpqPTgktn5vrWL86cMXnl5wC3tP9mg9DphaYB3dR15fuUtvmyL7oVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234767; c=relaxed/simple;
	bh=nrhgipuQElBRXLd+C1UKsGu61t1Dp41M14C3lSsJ+qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=at+p4Ie7l1QPLpclav/oPYriEfk/LHU6tBleyWjeudNqEbODGjA3PqTz7076YGn3SAwU+NOVmv3eJ8oTTC+6NdC8Ow+bHSM1xv0CPPf9M0wKbGc4ad+OQSqnON1c3qD4sPK+/S5+Bj2/tYgKsxqO1jcyWlq91Lz+m+Dmd7znuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV7GMbpN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edb40f357so28817735e9.0;
        Mon, 21 Apr 2025 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745234764; x=1745839564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DywDJj+TP6Fy0BegsYxCLBJnBZZmwEA8i9S4As70Fkc=;
        b=VV7GMbpNDKZexuiR3E3L//NaABPb/mpUCpoqlNeIjFcNqabge5WR9YGAv4cuvZuOte
         w0WojlGT/vxWzqf6BGT+cp8ws0ub32XOeQro8j2Zdq/K+0rQ3rcKbIfYbw3+8dw5N3Hq
         sE6NJB5/8dW+DLKWhltezudDfBW1170fPoTHkTsTo7BDe2/2MnicDcKSq7weZ9Pa5dZm
         vlBJ4uY/cjvLE+ctXDAFwase/ctSvorfKJzWD5+N3vKFs6buxOCYn2TPhU32cI/Cgywx
         BJ0POn9t7zv5jKMkqe5IntBDSi+BE/TbjBFU896OZUAdrLPMpEAODbmemQikN0WPucPs
         785g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745234764; x=1745839564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DywDJj+TP6Fy0BegsYxCLBJnBZZmwEA8i9S4As70Fkc=;
        b=OUkYg1jiD6/fj38jsDWe/s88pGkMTif6WJ///H/slqn1JLCSOR9Vh2C/pmGsy6mppR
         j4chjxDIKXlXoAu38yhhVH1997wQbeE4lYHMv0kTSIHfpp5ZYp7rku4063LXh6vRAG3k
         XNnc3Vf+gbm8zqQY7kiJnCYRa+0eX+wvUJx1SdD37i9eyigKpIz8OmIJci0x95S67D0N
         G3j9DpGc4mtduim/BJ/Pk8OGIlhCz5WiVI2CftVY6epHQEJac/oTSR9SRE0xGI0v76zr
         S4Cd1n5KTgdAHMEhgRX74YCW9YloOz8BVXDzi95UaDZ36m2kaUpy64ArEcqX0yjRg8+/
         DbLA==
X-Forwarded-Encrypted: i=1; AJvYcCW5B/Yl8n/gfsxngZiYF8nDtxYGKapr2k9VS0GE4mUyfOh8nTVp/KocjS2LEDFbVVLNSNEFrF0aSKzpBus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtE2yCBRpn4mWs7jqb5QXF4fOClKP7o7dMECUG7dR93Y4yEvk
	O6DGz86QPR8rJa5ByOqSj7msDliJOSA+oSDOHl+wh3pFev9Ljv6JzNircQ==
X-Gm-Gg: ASbGnctWC4UaSHGdme5VoAybXAFIff3Fu7RlKbQDPiGJf2P16BICDmWIJ1Ou8fgiQ8y
	VBegroxYkUP5DTs5e6WYEbu8YTKR/Qg7v7RVEySr8PhyokAKqaBxmUmmjn6f59lcaaBSWtTakg+
	s1lQoHG+Dk1PRb322o4Yahck+EUVF8LtLJrLFZGP6jvLtQGMHAh30VFQSyXSTskfZA5Q691RknS
	dRgmV3LC3zvL8+AqOwRt1qokmukGSJKB4Yfb/0szaV4wJPG4C6D00boOmXrVsPd4TStaCkbLkyF
	lo4BGjOqkuy5PPy1C3y4azCXBkCdiGATnAGWNsd3KyohTh+QJTTcBsempjM0tPEpog==
X-Google-Smtp-Source: AGHT+IEyd/gCLe6uVv+NRUValpX0NFG/QctCP0805z/W9pjLxvuoIW7drtqziovnyPlzm17OYnq17g==
X-Received: by 2002:a05:600c:1c8f:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-4406ac21897mr78319485e9.33.1745234763686;
        Mon, 21 Apr 2025 04:26:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:fc11:84a0:480d:20a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207e6sm11450879f8f.7.2025.04.21.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:26:03 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND] wifi: mt76: mt7996: avoid NULL pointer dereference in mt7996_set_monitor()
Date: Mon, 21 Apr 2025 12:25:44 +0100
Message-Id: <20250421112544.13430-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mt7996_set_monitor() dereferences phy before
the NULL sanity check.

Fix this to avoid NULL pointer dereference by moving the
dereference after the check.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 91c64e3a0860..32846da51cbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -414,11 +414,13 @@ static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)
 
 static void mt7996_set_monitor(struct mt7996_phy *phy, bool enabled)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev;
 
 	if (!phy)
 		return;
 
+	dev = phy->dev;
+
 	if (enabled == !(phy->rxfilter & MT_WF_RFCR_DROP_OTHER_UC))
 		return;
 
-- 
2.39.5


