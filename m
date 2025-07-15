Return-Path: <linux-wireless+bounces-25500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F3FB06953
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 00:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF9E17E9BB
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879929B8E4;
	Tue, 15 Jul 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8LHvr61"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5F1C2DB2;
	Tue, 15 Jul 2025 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618813; cv=none; b=VhgeEGHZTsr8mJ67dBn6tQDmGvkKyZ3c6q2ryHIWPvHPPlyfPicZjvDQld0BXh0aEC5E4Qmu/WV+MjDgDIRt4BS0NOjN+8TGcbX/x3G6t6WdgfuOgV264Wbwoo1PV2hCoJmE1j/7nIzCtb74/mU2AMEcW4coFGS9Nkz8TU+h5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618813; c=relaxed/simple;
	bh=dyGcpzNngBMQ2YV4Wi/gcf3C7b7anIslY6CBRkZ6gEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n84BMLfHeAc8A5/nXzGwEfcFkGbl66CCDNSWjYQJ3SMH57yg2V/qWn7AcXlBgy+3nRuIaMyoz0+ATE5+EO7UYOJXI5ubXzAcoXTK3sF9RASoDMzIv64H94gXA5uEi756IBAtpmG05EmGt8valSRar/e1HRLvEL6VyXOL8UAtkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8LHvr61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C871AC4CEF5;
	Tue, 15 Jul 2025 22:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752618813;
	bh=dyGcpzNngBMQ2YV4Wi/gcf3C7b7anIslY6CBRkZ6gEE=;
	h=From:Date:Subject:To:Cc:From;
	b=P8LHvr61VPq1o/fizrHXVI4ZPQCeIcgDWWg9nU8IuyP9DkmCIuOYg33Kk3u9D8uHW
	 hjg99qwKbp9Lx5zRv+WcOV1qP5UqE2vz4MfiiBJDmILiyi00XkSLcYV86mLF+mCFj5
	 PG+MrGH3YwscS65wzsYMYvVT4hsCg6fR1mzlHUZIFJk1siRg+znhFrF0jcpWNlF/gF
	 +POYE3XwtpXRXVmqxqeDR6zMfesXb6gnhU6kNg9JjFtoyuy0QlwZYWg3S8PDPmI7LU
	 kYwV0QPt5BqsjMFt3T2/jDlB4f2JRun+PaIc23D/YkgvrnuTD4TLKxvnL1NboxaXln
	 K9EVa3xRC0NtQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 15 Jul 2025 15:33:25 -0700
Subject: [PATCH] wifi: mt76: mt7996: Initialize hdr before passing to
 skb_put_data()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-mt7996-fix-uninit-const-pointer-v1-1-b5d8d11d7b78@kernel.org>
X-B4-Tracking: v=1; b=H4sIADTXdmgC/x2NQQqAIBAAvxJ7bkHLivpKdIjcag+toRaB9Pek4
 8AwkyCQZwowFAk83RzYSQZdFrDss2yEbDNDpapGdbrBI3Z93+LKD17CwhEXJyHi6VgieVSatLW
 qtsYYyJXTU3b/wzi97wfbvvL3cQAAAA==
X-Change-ID: 20250715-mt7996-fix-uninit-const-pointer-01e1dd03d444
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=nathan@kernel.org;
 h=from:subject:message-id; bh=dyGcpzNngBMQ2YV4Wi/gcf3C7b7anIslY6CBRkZ6gEE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBll1624BTtKdzdwrLrW6+cz6019Vte06mtHtylMNdKU/
 7D7lNTSjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRtfmMDLOlHf62PTyYUm0q
 tuKShooYa4bf/6J9Fr/9l7o0bV56fg/D/yr38kR/+wMs/x7lBqxxW+cW5hvCfeUFx6GS0KgVR+P
 8OAE=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A new warning in clang [1] points out a couple of places where a hdr
variable is not initialized then passed along to skb_put_data().

  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:1894:21: warning: variable 'hdr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
   1894 |         skb_put_data(skb, &hdr, sizeof(hdr));
        |                            ^~~
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:3386:21: warning: variable 'hdr' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]
   3386 |         skb_put_data(skb, &hdr, sizeof(hdr));
        |                            ^~~

Zero initialize these headers as done in other places in the driver when
there is nothing stored in the header.

Cc: stable@vger.kernel.org
Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Closes: https://github.com/ClangBuiltLinux/linux/issues/2104
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 994526c65bfc..640abb4dce7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1879,8 +1879,8 @@ mt7996_mcu_get_mmps_mode(enum ieee80211_smps_mode smps)
 int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				   void *data, u16 version)
 {
+	struct uni_header hdr = {};
 	struct ra_fixed_rate *req;
-	struct uni_header hdr;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 	int len;
@@ -3373,7 +3373,7 @@ int mt7996_mcu_set_hdr_trans(struct mt7996_dev *dev, bool hdr_trans)
 {
 	struct {
 		u8 __rsv[4];
-	} __packed hdr;
+	} __packed hdr = {};
 	struct hdr_trans_blacklist *req_blacklist;
 	struct hdr_trans_en *req_en;
 	struct sk_buff *skb;

---
base-commit: eb8352ee2d1e70f916fac02094dca2b435076fa4
change-id: 20250715-mt7996-fix-uninit-const-pointer-01e1dd03d444

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


