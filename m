Return-Path: <linux-wireless+bounces-12060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696B960677
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E511C227A7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9A19CD17;
	Tue, 27 Aug 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="J5+yzYIW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86C19D89C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752586; cv=none; b=bhD1HFUJ3VU+t0E8UCuUpqk3LA8qsfqynC1apHSlI/ZIxI48bjfDUWWOPO2BHKynvy2oB5Y3Mx5UfFs3P70QzyzGJmv5grbRZaY1oRk0/FBG6YE9Un5+zF4cauXj4TAEc+iGpnX8AqysRE5MmSjKL+/Xh9myMmK7OnO5DgXMo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752586; c=relaxed/simple;
	bh=hgeCHMW5MeeM74OqWDE0LVmUOQ9CgZppUHDKTxQgKJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYNNq39KyE+kYBCPAHDzPHm8CJZwUC2mMz5XusJCNA2kF6imQ+265mxqlOltnJdaHSmBtZDEhEnifR216bxoBxrQz56gvBZE3DBTtzgSoYQnhwXAw8gE4dNsjA6tgyz3Bl/+50gPEFc31sqLIkgxhtML5jk77I1w1UMBaaUo8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=J5+yzYIW; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mfTYGypLAx1CnrulIUHVx4SahxITO9zguZEcyz14pfo=; b=J5+yzYIW8kumJ7shc4hd1DHvrp
	SBYEiQ0JzyJGmSTgGcfWFZu2UmOEuBjBfkPR6VwjW2z0O9L8/1mMAFsPOf51/lWeZIhIY1w7C1QVZ
	Dznoa+uJkz+41P5LZLsvHjNEChPW6+95ShPyj+cTh4O3ecVETQcoSsv90YmnqQ+loi64=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWn-004Ww8-2e
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:17 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 20/24] mt76: shrink mt76_queue_buf
Date: Tue, 27 Aug 2024 11:30:07 +0200
Message-ID: <20240827093011.18621-20-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse one bit from the length field for skip_unmap

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 794cd33be68b..0b75a45ad2e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -162,8 +162,8 @@ enum mt76_dfs_state {
 
 struct mt76_queue_buf {
 	dma_addr_t addr;
-	u16 len;
-	bool skip_unmap;
+	u16 len:15,
+	    skip_unmap:1;
 };
 
 struct mt76_tx_info {
-- 
2.46.0


