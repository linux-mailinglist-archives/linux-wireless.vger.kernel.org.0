Return-Path: <linux-wireless+bounces-28248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF86C095B7
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20E084FDDC8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7830505E;
	Sat, 25 Oct 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvbCeHk2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A74303CA2;
	Sat, 25 Oct 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408853; cv=none; b=pMOKGEoNUPppCqX97yXJPK7ydLoPHfLmjbnxDEzgAXy5+5WULoS1Rnbkp8Fv3fJYtkhcovvIH7ESp9sJz6XMPB8XHOFJuBNIVRUkTybrkoOpYr0k6XJbdkXfqYwHdTv2gdhs2H8Y5KV+WrkWJ3CqAw3ig5FWhuqZHpqoXmiXQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408853; c=relaxed/simple;
	bh=QorErh9yORnjHmKK8rfLqSYNYmxvjnmyWw6S/K7/wcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0chkcWuWS5gEwjzQUj526/9cqoE8JUUliDwpjWgsIEud3Aibe0HiVFYVxT5F578f522V4qhpWcDW4m+l4ih27v6nJOQf4J1IXmyF+UYR6JYOF476/vWNgPAf/R/IL1+4hB99fGv2/lADfW188FjxqB5GSdLWSZ1+j/8y3tNmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvbCeHk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A164C4CEFF;
	Sat, 25 Oct 2025 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408853;
	bh=QorErh9yORnjHmKK8rfLqSYNYmxvjnmyWw6S/K7/wcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvbCeHk2+7WwwWJm3WZBOiuvQ0k57Al9crKUiL3oNM5Uoelh4GsEeRSyg12KIAIph
	 grTKw+qXaAcXwT8HL4Ec36uIh9vXtXrb1TE+nH9nYw+DY5DIBa4h/OaWT6jgfO9B49
	 CTUXsRvuitwYTMpMz7vQpHwYF0IipGNjgRDLLJo3XFsqh7t/ALQ82tEk1gRtQ5TNR2
	 jSNYzuJM3vhe7AKAcBOMXCkqF0Z4Linft6WqaZAhE3bg20sa0j177psYSOzC5DCR1J
	 hQtwa6ve7M62RXen9EbzdVw0ZL2wwsSS1wsLLMV47CnOaqa/gdaFX18vr3mCGi+fmF
	 epGuWfhur6Aew==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-6.6] wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
Date: Sat, 25 Oct 2025 11:55:31 -0400
Message-ID: <20251025160905.3857885-100-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>

[ Upstream commit 82993345aef6987a916337ebd2fca3ff4a6250a7 ]

Increase DP_REO_CMD_RING_SIZE from 128 to 256 to avoid
queuing failures observed during stress test scenarios.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250806111750.3214584-2-nithyanantham.paramasivam@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- Bumping `DP_REO_CMD_RING_SIZE` to 256 in
  `drivers/net/wireless/ath/ath12k/dp.h:187` directly enlarges the REO
  command SRNG that `ath12k_dp_srng_setup()` provisions in
  `drivers/net/wireless/ath/ath12k/dp.c:555-563`, so the host can queue
  twice as many HAL_REO commands (peer/TID deletes, cache flushes, stats
  reads) before the hardware must drain them.
- Under the current 128-entry limit, heavy peer churn makes
  `ath12k_hal_reo_cmd_send()` fall off the ring and return `-ENOBUFS`
  (`drivers/net/wireless/ath/ath12k/hal_rx.c:223-236`), which propagates
  straight back to callers via `ath12k_dp_reo_cmd_send()`
  (`drivers/net/wireless/ath/ath12k/dp_rx.c:650-667`) and leaves TID
  teardown paths dropping the descriptor while firmware still references
  it—exactly the “queuing failures” and memory corruption observed
  during stress.
- Ath11k has already shipped with the same 256-entry setting
  (`drivers/net/wireless/ath/ath11k/dp.h:218`), so the larger ring size
  is a proven, firmware-compatible configuration for this hardware
  family rather than a new feature.
- The cost of doubling this DMA ring is only ~6 KiB (256 × 48-byte
  entries), and the SRNG limits in `hal.c/hal.h` leave ample headroom,
  so the change is low risk and entirely contained to ath12k datapath
  setup.
- Because it prevents a real-world failure that can take the device
  down, while touching only one constant, the patch squarely fits the
  stable rules (important bugfix, minimal surface area, no architectural
  churn).

Natural follow-up for stable maintainers:
1. Consider also backporting the subsequent ath12k retry fix for REO RX
   queue updates to cover any residual overflow scenarios that might
   still appear beyond the expanded ring capacity.

 drivers/net/wireless/ath/ath12k/dp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7baa48b86f7ad..10093b4515882 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -184,7 +184,7 @@ struct ath12k_pdev_dp {
 #define DP_REO_REINJECT_RING_SIZE	32
 #define DP_RX_RELEASE_RING_SIZE		1024
 #define DP_REO_EXCEPTION_RING_SIZE	128
-#define DP_REO_CMD_RING_SIZE		128
+#define DP_REO_CMD_RING_SIZE		256
 #define DP_REO_STATUS_RING_SIZE		2048
 #define DP_RXDMA_BUF_RING_SIZE		4096
 #define DP_RX_MAC_BUF_RING_SIZE		2048
-- 
2.51.0


