Return-Path: <linux-wireless+bounces-10569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C493E273
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAB02815CE
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83064CEC;
	Sun, 28 Jul 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW33Y/cm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0A61674;
	Sun, 28 Jul 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128019; cv=none; b=UVDrPooxqgrVrSKTU6oKCK/PfborEs+9/imEC9qWdt5vVnZYE7Lrff1N5e4cOHzeJcHshDfLeNmCNQFZsc++4vzmffECVpaw28y0j7iZ5sKFW10XqK9BAAC8Ce2Y5KDu5Bt2LI3dbwdaoxwvtkO7lSF+MMGkPm0zRzGYBDwbBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128019; c=relaxed/simple;
	bh=zjyyy8tHQjp/HACAEfML/utyS/QhvggQtox4+hC48Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9U/E1Y2sOtunzauoakAKtpjgFcQqcHebdrEh+0ctGtabSU17kQ6GtFHWwPdZcY+tSLu95wz9h/rW23Zn3posmjRDnhLdIvKbwDmDgSUAXvSqSVb2s7k2iaum0mNys3TPh91BdNEm2BYSzdvJwGs5uri2nzhYlHc3U48gLR365Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW33Y/cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164ABC4AF09;
	Sun, 28 Jul 2024 00:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128019;
	bh=zjyyy8tHQjp/HACAEfML/utyS/QhvggQtox4+hC48Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kW33Y/cmcjrbEDGT++wrASjBznpfczvcOoT3j7K8075lYQlceMNLVDVgU6Kj0sFft
	 0A1Ho+DljW5eMZf8EHTYr/SaJYQoGu9BzMO9NMOq2ckAi+AcRBeQ/MDPv0nubQ3mfX
	 0DMb3y/o7sOKN64N/rGz+gIKKgFP3qTxSLE4SP327jLNgVAnOCd6Qwau7hnXpTbRBr
	 oq4p0LmZElk/37WGl3OFr0lDzPkXQhl5pZYBKExPsy1cgtNoEXQCgX+Td3o1vRYoNO
	 eigKgvnGDKJkN3Gp62yFf8Kh8orFaB0hkUI24K2DRlNfKwzVBwKXetFrKjRgOwd0Y9
	 Sk+W6q5YFxRXg==
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
Subject: [PATCH AUTOSEL 6.10 05/27] wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()
Date: Sat, 27 Jul 2024 20:52:48 -0400
Message-ID: <20240728005329.1723272-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 75df622f25d85..f05c45c8732e7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2762,6 +2762,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 	peer = ath12k_peer_find(ab, vdev_id, peer_mac);
 	if (!peer) {
 		spin_unlock_bh(&ab->base_lock);
+		crypto_free_shash(tfm);
 		ath12k_warn(ab, "failed to find the peer to set up fragment info\n");
 		return -ENOENT;
 	}
-- 
2.43.0


