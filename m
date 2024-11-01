Return-Path: <linux-wireless+bounces-14818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DCC9B9427
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320C5B21886
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222801C3F26;
	Fri,  1 Nov 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzFD0tti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEE1C32FF
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474229; cv=none; b=WBWlhnpRf7FzAis6zz0fKjwQcjn1/DtaNbUZzodb8SPw8Rka09YdswWML34ouT3wUxSjHDce7vXT/Kce4L8+PPf7qDpercFoOIlDqC8bsp5CMQ4bQDBdaxtHdKetPDkqwyKaM8OUqJTNQrT+WMPL8M/NTcxupLUSecyh+XiyH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474229; c=relaxed/simple;
	bh=cI45HBk6KyHpqGnCdeXtWbhky1ba9wmHtnNGv1+4u5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M77z1PvxXP5e4tHTRxDid/VCNukC9NpNL7ULYCJKYuQdSp8a7DJJiKhSlYr+GIb8iKfhoqvChymrBavGfTQM9oID6fyidWDtxTHjYsLgYhifwkQUPs5W47jlTEflWa5b8uO0PthZE4eC/yKjMLuPxQRdvrLDoe/DPQ8UCbB8dwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzFD0tti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082CFC4CED1;
	Fri,  1 Nov 2024 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730474228;
	bh=cI45HBk6KyHpqGnCdeXtWbhky1ba9wmHtnNGv1+4u5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzFD0tti8Oeu0TxjMgYZ1acIzfeffD8LYsgULjbxs+Z9YEfhP1ml3riObSv4ja+X5
	 6rHSdSuNt0EFxZK+QnWbRaWU1xFQL8Dyr7cT5jLsBBr/a8YE3DhQ+vSgR5hW+bVt0x
	 7P9MUOsm17wMsfOq4zEH5JmtKBt+jUoQozhoAdoVkObYf+EImpVw+v4k89Pj1W3ddj
	 Wdb3f175DCdaO2Ubg5PJ6Z0V2e9kTNY8t+Fxip5z1WP3cKZfKduAOEmz1aR34MDcb/
	 7lSy6GVzNszyzKHzT2/KwhPOBm3fxH81o/bORIxUFQ+J/Ijg4SHiSFgdUM01c2jlmh
	 1NUlRprb1x+NA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/8] wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
Date: Fri,  1 Nov 2024 17:16:58 +0200
Message-Id: <20241101151705.165987-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101151705.165987-1-kvalo@kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

In commit 477cabfdb776 ("wifi: ath12k: modify link arvif creation and removal
for MLO") I had accidentally left one personal TODO comment about using goto
instead of ret. Switch to use goto to be consistent with the error handling in
the function.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f5f96a8b1d61..7dd2b66d3386 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7047,8 +7047,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
 		ret = ath12k_wait_for_peer_delete_done(ar, arvif->vdev_id,
 						       arvif->bssid);
 		if (ret)
-			/* KVALO: why not goto err? */
-			return ret;
+			goto err_vdev_del;
 
 		ar->num_peers--;
 	}
-- 
2.39.5


