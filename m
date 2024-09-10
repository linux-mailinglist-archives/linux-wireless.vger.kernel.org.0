Return-Path: <linux-wireless+bounces-12769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD4973F73
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 19:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001F728E78D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8ED1B2529;
	Tue, 10 Sep 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V13Oi17B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE61A257B;
	Tue, 10 Sep 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988968; cv=none; b=PSFntpiRmEGne5GJqq7uVPO2JCf56mPo3EB0BzqB+opT0CvtgYg3cFSpfHMJwPTk9v2yIsew4XiLK9g3N8ewy9+m79957lzZpJ8qUn6S3NuHrpuCRa0nJLd7+8DA3zHlfHcdfxn8xrs5loKp/P0oTcaHa09HMbuzT0LFD+Bm/Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988968; c=relaxed/simple;
	bh=Cj+QOyImgiVgaityzLKNeNzJTMHwLD4SZFxnYezKIyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmy06K0wBRaETa1ZV5wFaOz+zyrNILll6tuyrB8PwXfQSpUXWGOdx7k3mBPlWDP8iAgSvz7atJ5vWrQPgy7F1VrtnCsRF0Vdsw0Cbq2XKa3Nk8zdVCIaTFCtS7a0ia3BYJ2tMJtQFC5hLiux02u3DCDzPAayJqHEd9PgFhl5Yno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V13Oi17B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E111C4CEC4;
	Tue, 10 Sep 2024 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988968;
	bh=Cj+QOyImgiVgaityzLKNeNzJTMHwLD4SZFxnYezKIyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V13Oi17BJDwrBwGAGHBLOV0EE4s8XKIH6XnlfWHcvhnnKPt+JlIbADrokXeWoF8hZ
	 cSxmhtXj+2NuaqBI3bEE3X/0lYtmm730F2syBM9DT67zL/BY4eWzI2S3EuUPIjDlkt
	 16zw071nG02MT7nhAJG/YT4bZs/3mMmMY1hS4v/Rh5voMKfhHjVP2vx1FJc94jBLau
	 Gr1PWcYpSUYqrlOFXFwh3j5Qd3vwM36lqPeWUNPVaKOW5xHLBuFFRyRYjjAHtOCFGw
	 ACGfV4Jr4/NpAbUPNo3+vjwoLasRDWN4vpPq70q4AUFLcVxN6IwAtkR+obfQyCihOY
	 Lj3tCvO6Wkagg==
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
	ath11k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 15/18] Revert "wifi: ath11k: restore country code during resume"
Date: Tue, 10 Sep 2024 13:22:00 -0400
Message-ID: <20240910172214.2415568-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172214.2415568-1-sashal@kernel.org>
References: <20240910172214.2415568-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit d3e154d7776ba57ab679fb816fb87b627fba21c9 ]

This reverts commit 7f0343b7b8710436c1e6355c71782d32ada47e0c.

We are going to revert commit 166a490f59ac ("wifi: ath11k: support hibernation"), on
which this commit depends. With that commit reverted, this one is not needed any
more, so revert this commit first.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240830073420.5790-2-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 47554c361963..a14d0c65000a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1009,16 +1009,6 @@ int ath11k_core_resume(struct ath11k_base *ab)
 		return -ETIMEDOUT;
 	}
 
-	if (ab->hw_params.current_cc_support &&
-	    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
-		ret = ath11k_reg_set_cc(ar);
-		if (ret) {
-			ath11k_warn(ab, "failed to set country code during resume: %d\n",
-				    ret);
-			return ret;
-		}
-	}
-
 	ret = ath11k_dp_rx_pktlog_start(ab);
 	if (ret)
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
-- 
2.43.0


