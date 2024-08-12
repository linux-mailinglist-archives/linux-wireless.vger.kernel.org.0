Return-Path: <linux-wireless+bounces-11300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBAB94EB6F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B891C21574
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719E170854;
	Mon, 12 Aug 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="M7LF/bXr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31F171099;
	Mon, 12 Aug 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459572; cv=none; b=LWA6dUsAtosI4C1xW2iMkPDb9iv0i7ZQ9sOyRydiVJnxyzzHUG2uji3MrSpKlT6HgIPVfxjqoCWOfvP9YjSp/qdj0O2H3S1cuKVTaacMZYhtS0Otv18eoHYiT2W5MtiL3ofyoF6SWJOxQZFMcakF/j13k2G1MOgfF6Tq+ELpHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459572; c=relaxed/simple;
	bh=uSvpnEL4186VLSt2Ovpors+CqmrQw03QsV4ki/UFUNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZLz33mLl/r72uZzkH7tKTib6zGVPGfYbEYAgjaDa+efEhABJbkGvfEngbtdS7EvrzkoBGzCjAk6hBNBpu1n4wPp7TRkkw82wSWY4AqHeQ7hZExhsbVRW0xH6+U0GnWTBPKmX9LWGdvjQeR3edln3deo6Rd+c/HmD1tuZA9CJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=M7LF/bXr; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723459545; x=1724064345; i=spasswolf@web.de;
	bh=pajeKwVmCHYKYe6e64KzbpO2jnBiZASKVeRA+7OwpMg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M7LF/bXroAcKL/vRSBlThceY6U9JzbBnJxYqdqiFn0BfDB743jJaEuw4U3kUDfyO
	 07bImy8VRXNH/7f8c0pisDNAgeCAhkrR2vCv3ZkeqOAM6DT2cB2kiV5M82XMxlswh
	 jaBrdwrp8QvRX51XfTp/9lBKHhWzpryYWPAeA9vDMsFe2gz4+WUAEJCZntL5ygjzJ
	 ANxJktnXuyw/l5Zj+RGxDaMWlag5gxMjKD1wRkD4d0P/HvPjfF9KmcwwVec1+CHJV
	 SGRqt1p81Y3ZCJSGBcNirKTU54OppZn0jPkQvBJvj0zjzr6+BTKilxm1801w2JyXd
	 wY8vTJ3D7KI2vjknBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MaHWx-1siaoW38Uf-00QegC; Mon, 12 Aug 2024 12:45:45 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-wireless@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Kalle Valo <kvalo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@kernel.org>,
	deren.wu@mediatek.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi@redhat.com,
	mingyen.hsieh@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless] wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change
Date: Mon, 12 Aug 2024 12:45:41 +0200
Message-ID: <20240812104542.80760-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0A98Q129rSHz9r1PkU50MFrjDmOd5fuQgJPBQxv2kkwsh2jXG6U
 kQ4eb2XnT4QUzVoMRdQVygSxjVtn0gNW8lAOmQheDUoYS+te3sR6XaQV3DdnLJ+9w30zk08
 aPrbU/JgembuNxGkusGpeVduVLi1kW6L08FnKoVzbVEoEthR0IChXGxB0LyRZwyYcZw6xXw
 WIBrNHbgL2TRrZbJuUfvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IbSThmmD9cw=;YN1Mb4K1Y4uVZEne60oy5XSxeoW
 99UcTjTJM/hIdCvraU81zi53xwLLK0wNdFjSXCnpXHBzDdK2khVExHU9exyMMAZcIedd4iper
 W8QgJ80d0vw5SiAXDowB6FzkJzXfLUCLacynqU2gDOuqbiUgi7lzvV5uGOY23fikodWsSVTLw
 rKytF3b19f0JpHrPNnTn1yAdg6i07yvm+dGaj5khtc3ikpZ4mzw3tcDbxfu/tUa4A5rOg4zBb
 mWQDFlpRKQ9euNddFCbpp/DtB7QwDKp2y88Sn72QnU0sUBonbJn30zEVxt8uSRZ2F2FBaPiwO
 wcZBP/IlUErb7asfRoGd6eL1kwlfiMHqvK4gwMiLw6on8XVbxUY2jbek20luvzMy4WG3UmrCe
 wBGXBavAg2Nf5kLDxhp8WUrYJTOj9lnG2LOnhhs4z6iisnRDTIgJ20N8YDQLo3w1ekZul9g6n
 l+eQtyFtKz3xwI/dR+cV3x/ftQQgUOy7WVqfXHnLPKOjHJ57uKnHTVBUBHYRaMPh813mF6TNv
 ObNtpSbNaA+cutMmDw869MSJytLJIUbcmvPZVGjhnKr0My8Eh6V84Eu5+EP15fU01nQwkWdZk
 4/rlQQMFxq3o7lqjlBAWhjEe5WS+DFBc/BOJyXTLU/bN4vXnNKd1NurvpkWvo2YHYBCiu2e9G
 JnsFFfs9uTfDC08IhV7Sdbc+W6c+i4uLrs4YwCpFxT6qJIH1/w6P0V29Xe1OGLtVuna9ZrN1Q
 /Cac5dev3db1NzVf99hoqaTfqWsk9TIeWWhyunN8Am3KT5yWDbCFy6+ng4h9joIw7zi6sWpF4
 wQp2OiXHGLJhomi5K+Wy9/Xw==

When disabling wifi mt7921_ipv6_addr_change() is called as a notifier.
At this point mvif->phy is already NULL so we cannot use it here.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
=2D--
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/main.c
index 1bab93d049df..23b228804289 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1183,7 +1183,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211=
_hw *hw,
 				    struct inet6_dev *idev)
 {
 	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev =3D mvif->phy->dev;
+	struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
 	struct inet6_ifaddr *ifa;
 	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	struct sk_buff *skb;
=2D-
2.45.2

As the solution comes from Felix Fietkau I put in a Signed-off-by for
him in the commit message. I hope this is ok.

Bert Karwatzki


