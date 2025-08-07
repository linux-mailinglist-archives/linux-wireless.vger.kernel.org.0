Return-Path: <linux-wireless+bounces-26209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD9CB1DE7F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 22:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A672006B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 20:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34323372C;
	Thu,  7 Aug 2025 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD1KCJDA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40491FDD;
	Thu,  7 Aug 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754599992; cv=none; b=Lsf2CWNMDSn2I0a4EFzOKV/pL+OKDYebbeCR6HgRDGKZ9vdeJfyhJsNGIsucpOZAw8Q+6ZXI6AlUqVlALtCmmbS2W6sWn/cjvzYqbqfMUb9dOOW4w49eb5swxpzgCg1aBxdOp9CAZubZcaSAcNa+IvnLqLdVSu9Cmj8UVIxg5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754599992; c=relaxed/simple;
	bh=eEXKk+I5tcJfGdMDXMtI2opCtm6L4e5pQiFvbhVEGIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aya7sFBIvX7lS60JBwuUaKXicD4x0nqKdQmlsyRWilymK3TXv6/zL2QJvPEksrHZLj7wNMT7VqwAV6M312aXJH3FuEd1MI36v0n/ZAQCVMf+BInz4RRL8zPoEkm3sbaIlVhmI57D9nxnOBTBVT0qDeLghgOdEvh0vNnhvSeVC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD1KCJDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB75BC4CEEB;
	Thu,  7 Aug 2025 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754599991;
	bh=eEXKk+I5tcJfGdMDXMtI2opCtm6L4e5pQiFvbhVEGIg=;
	h=From:To:Cc:Subject:Date:From;
	b=YD1KCJDAp/afwmcAIXaDAe+TcWH+rKH/N+MWNtUKeAkI8XBwfq8FgWIbqX4f4ExGR
	 G2sn1c7exZ1BQVApQGsRD46319pTu4w8uxdw4W+MUbYiPCYPsST7rkHS2b943o/Eqy
	 VQW7p4aQBQUT/SvMG5rThh7dpBvC0FOHsSjD4sR9xgy3DssE0CBpwWkYmypatyHbI6
	 Ed5ojaPLOZ9UK5sIB8aME66LydmX6tUf/6/tCV/9NmPTgZcgg3ocfmSdhLpHdHIPFH
	 L3vC1T5CXyGoBtf8Bvhacpo0+2IoyJcDbYMc9UlExO3JAdPDJaa5Kkb9SkgHXrrl7O
	 lQLmhLehB4otg==
From: Arnd Bergmann <arnd@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH] mt76: avoid uninitialized skb data
Date: Thu,  7 Aug 2025 22:52:57 +0200
Message-Id: <20250807205305.88394-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Two functions in the mt7996 driver cause a clang-21 build warning because
the pass uninitialized data into skb_put_data:

drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:1894:21: error: variable 'hdr' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
 1894 |         skb_put_data(skb, &hdr, sizeof(hdr));
      |                            ^~~
drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:3386:21: error: variable 'hdr' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
 3386 |         skb_put_data(skb, &hdr, sizeof(hdr));
      |                            ^~~

Remove the otherwise unused variables and instead use skb_put_zero() instead
to fill the header with zeroes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 3593fd40c51b..6a00df3c5343 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1880,18 +1880,17 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version)
 {
 	struct ra_fixed_rate *req;
-	struct uni_header hdr;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 	int len;
 
-	len = sizeof(hdr) + sizeof(*req);
+	len = sizeof(struct uni_header) + sizeof(*req);
 
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
 	if (!skb)
 		return -ENOMEM;
 
-	skb_put_data(skb, &hdr, sizeof(hdr));
+	skb_put_zero(skb, sizeof(struct uni_header));
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_RA_FIXED_RATE, sizeof(*req));
 	req = (struct ra_fixed_rate *)tlv;
@@ -3370,20 +3369,17 @@ void mt7996_mcu_exit(struct mt7996_dev *dev)
 
 int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans)
 {
-	struct {
-		u8 __rsv[4];
-	} __packed hdr;
 	struct hdr_trans_blacklist *req_blacklist;
 	struct hdr_trans_en *req_en;
 	struct sk_buff *skb;
 	struct tlv *tlv;
-	int len = MT7996_HDR_TRANS_MAX_SIZE + sizeof(hdr);
+	int len = MT7996_HDR_TRANS_MAX_SIZE + 4;
 
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
 	if (!skb)
 		return -ENOMEM;
 
-	skb_put_data(skb, &hdr, sizeof(hdr));
+	skb_put_zero(skb, 4);
 
 	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_HDR_TRANS_EN, sizeof(*req_en));
 	req_en = (struct hdr_trans_en *)tlv;
-- 
2.39.5


