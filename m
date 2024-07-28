Return-Path: <linux-wireless+bounces-10574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE193E2C7
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FFD1C20D06
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F913A24B;
	Sun, 28 Jul 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBufl0bl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBE194C68;
	Sun, 28 Jul 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128089; cv=none; b=JY5VPrfIOQcg90Y8ynwvejDV7ZdulV7p6aom6ks8NsgHDWH3hSIXw5uiz5JuLIKTB6+8kqas9+gqUtbjiMu36GAfajqqRce2SE9xBYTCnK1ZHl9bx5DPF8zUw3Su7/1DQOqhXPy0JiW3K3cbhPqzRHgxLclxoN8hCvQ+bigOri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128089; c=relaxed/simple;
	bh=UFjFLGyWMrNDUcEKM4QvLGE1aXNITIWrX5TYMzsTATw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZVeFbv0f6wd39mvs5q51Jx/2P7E9zB6Ok5HcUA6lZQJgY6h7c9wgfgFLsJEFL3Em2OXDO8BhOThVJUQZFcqhDT1eAUZFx2RenlON409l5wZfADacOmRj243sr95ajDRa/AqfYu7ytrTvCigfEks5ic3iCE14LZ7qKjSQmn9knY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBufl0bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17F4C4AF0E;
	Sun, 28 Jul 2024 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128089;
	bh=UFjFLGyWMrNDUcEKM4QvLGE1aXNITIWrX5TYMzsTATw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBufl0blouI9ulLRK6WumMOCzyhapaB5MDpVlDJkzfKzofYHbbfF17DaaQON7sXMj
	 w42ddZlL6vXU8e9kMZo5LJrbhNEItVJTCnnhFSMOP/ec5bap9I5utUfJrD4Vke4naS
	 tIGzAeJYd7i3y1P8vahfeKMwqSPaCiwzxGQ1400xxYF6j12yHTHx3F9rkUUFpCFIq3
	 Gcvmwa6IWIO4RrVKYHheu2/hhZYSd9x3NhGve4qez5FLMbTDiYedRzDEYviBItBpjo
	 IGmCwmmYXAWLw6+qU6B7eOtXBTiewTO4JXHUTPm65GFJuNy4utgH5OBNirEwRsY4zT
	 j4RKp+zwyzZxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 03/15] wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()
Date: Sat, 27 Jul 2024 20:54:24 -0400
Message-ID: <20240728005442.1729384-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 3d60041543189438cd1b03a1fa40ff6681c77970 ]

Currently the resource allocated by crypto_alloc_shash() is not
freed in case ath12k_peer_find() fails, resulting in memory leak.

Add crypto_free_shash() to fix it.

This is found during code review, compile tested only.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240526124226.24661-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index dbcbe7e0cd2a7..a5b6e2e078d33 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2756,6 +2756,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	peer = ath12k_peer_find(ab, vdev_id, peer_mac);
 	if (!peer) {
 		spin_unlock_bh(&ab->base_lock);
+		crypto_free_shash(tfm);
 		ath12k_warn(ab, "failed to find the peer to set up fragment info\n");
 		return -ENOENT;
 	}
-- 
2.43.0


