Return-Path: <linux-wireless+bounces-15725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 952849D9C30
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCB3B2750C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52321DC759;
	Tue, 26 Nov 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czZgD15g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E21DC74A
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641107; cv=none; b=SK7djoykrGCvXu/DjGFtcew+zq0kmv3PPLSG+S3LOyVDg+shd9BdVLVC3IQUpDtq5bkVxu3SFOkSQSapmQX7p48z3L4x+KfdYwh67LvOfgwWigOs4xOAYOo2VGezNNUsaMzRConXU4Nk4H4Gvab4u1rB5cOmuHrnSE07aHIW0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641107; c=relaxed/simple;
	bh=VRIrU/lTFBp/KOyFr4YVshRzUtBzVvX3JA79bvSZD0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYM/ylPu2bCgRzfI3yTcfYxXA/pndHHjmiheTUOAOwtOZ5Fm3adijXN4ad9ZfG49pJey+R2naUek6+cZqT7fEZe0Rwc38vMfv6daJ8t9jF0ofl+eoTiA73e1VZfJN36UWfJpbTqNqAzMUGSQRyZTXHJvC1TK92ogH1VxDdeqSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czZgD15g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111ECC4CECF;
	Tue, 26 Nov 2024 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641107;
	bh=VRIrU/lTFBp/KOyFr4YVshRzUtBzVvX3JA79bvSZD0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czZgD15gDwNMBIF+7EdNqhnE+1JD8Qk9+SPPfWqFnFfj3EioGZ62fOTNp25yGrWND
	 7jaEJuGSeO9dfOd1u5GpRzscSr+JBg7e82bUekZOWi1ngj5Hg9qHYIq0fKxQrRC0i+
	 vzcKQaPkZ/NGmAH7G7mLcbFuVbuE07e1J8TXPzyn3K1BQ/uLCcXosdYI9Slqbdmuk8
	 +iQJuQAqjq0NRotzOmnoHtJQXGviXaA7Ow/0PlfE9X7yaAGvZRySbEIo3VOd3IivhG
	 PN/cCvFPn5TYIMh5rJLnXEtpRYM52a9l3raPpJwskqMAc+hw5beXqg8HLSpi/FAF6u
	 hDFY0IXSMcKQw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 05/10] wifi: ath12k: ath12k_mac_station_add(): fix potential rx_stats leak
Date: Tue, 26 Nov 2024 19:11:34 +0200
Message-Id: <20241126171139.2350704-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241126171139.2350704-1-kvalo@kernel.org>
References: <20241126171139.2350704-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

If peer creation fails ar->rx_stats needs to be freed in error handling.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 428415237831..8287c2e6b765 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5308,6 +5308,8 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 
 free_peer:
 	ath12k_peer_delete(ar, arvif->vdev_id, arsta->addr);
+	kfree(arsta->rx_stats);
+	arsta->rx_stats = NULL;
 dec_num_station:
 	ath12k_mac_dec_num_stations(arvif, arsta);
 exit:
-- 
2.39.5


