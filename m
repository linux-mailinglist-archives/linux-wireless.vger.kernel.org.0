Return-Path: <linux-wireless+bounces-14503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D292E9AFB9C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 09:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105461C22766
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C271C2324;
	Fri, 25 Oct 2024 07:56:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F31C07F7;
	Fri, 25 Oct 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842970; cv=none; b=iiZ8WBOUkmvrt2z84Gk/9hOqK4o9jiWSEVzExUq2Vc89N3Fnk4cbjATu1fyZuTgJjEslCnrPOen+nNT/Dy6ruecxXG32mYLoSSMEvv8hkh5pTlCJF+wC2HznBO90bwo/BsibvpsFmxU1xyTpWq6jsjTKFd1Rq7l4aHZppoubcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842970; c=relaxed/simple;
	bh=bgNWztlxw4rEHrUSzO9YUY59UQ3Mv+IbBmdSrZslzeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/S2dregnt7c5cW+OpBsFBdb0rh9nx7GHNyhaK7xn87FseJqW/5lPAuVMZdeim2HcTvzWEqFAqI3aZ6H4okU0nwjmci/ylipqqGAIr/NtPH8LLBAz5nZLh/ORc9yzVaY+kA/9xPebKxZk+PJcQLj9IgWqBMv7F5FPppqSN6I9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id VHC00152;
        Fri, 25 Oct 2024 15:55:52 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201620.home.langchao.com (10.100.2.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:55:57 +0800
Received: from localhost.localdomain (10.94.19.204) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:55:56 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <sean.wang@mediatek.com>, <nbd@nbd.name>, <lorenzo@kernel.org>,
	<ryder.lee@mediatek.com>
CC: <shayne.chen@mediatek.com>, <kvalo@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <deren.wu@mediatek.com>,
	<mingyen.hsieh@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.or>,
	<linux-mediatek@lists.infradead.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links
Date: Fri, 25 Oct 2024 15:55:54 +0800
Message-ID: <20241025075554.181572-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 202410251555529e83ff3bf139e32a4d242e5986fe8ea6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

In mt7925_change_vif_links() devm_kzalloc() may return NULL but this
returned value is not checked.

Fixes: 69acd6d910b0 ("wifi: mt76: mt7925: add mt7925_change_vif_links")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 791c8b00e112..a5110f8485e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1946,6 +1946,8 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 					     GFP_KERNEL);
 			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
 					     GFP_KERNEL);
+			if (!mconf || !mlink)
+				return -ENOMEM;
 		}
 
 		mconfs[link_id] = mconf;
-- 
2.31.1


