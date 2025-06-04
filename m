Return-Path: <linux-wireless+bounces-23705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF7ACE06C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D5E188C36E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005C290DBF;
	Wed,  4 Jun 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUkq26Bs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33830290D98;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047772; cv=none; b=tooKKPTcVoS8TEtEl7oE9cHzblmTBfNogECe3JRCoogPH74UMc+GDx7ypwn+OzWFo/qIT6DMwjRBQHrsOBlpiHT/fxW/N9hZNxazlXad4wSlmICKUDVoFA83aa6TU+UOJxPTounNldrZG+Fh+3tEf4jj4Y9vGo2P2StSc37tdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047772; c=relaxed/simple;
	bh=bBea28t9w+SP1kNsex5/pyeXu82UeQzcQARI9RSlSM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Etra8fjndHO7si73KZmiW/Pli3SqjdqGH0NZ7QDDmPtkuoGYpDHnXGWZWjVti0VHyyw0CmU2izMUUVm9yGCDc/jWbmZNAFDHLok1zFJbR4+narHskcgVpnUEQGfIt7clCYE3ktk/zfga/EDfsvkSfGu0WuyCptsli5OE5MWVPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUkq26Bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B409FC4CEF2;
	Wed,  4 Jun 2025 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749047771;
	bh=bBea28t9w+SP1kNsex5/pyeXu82UeQzcQARI9RSlSM4=;
	h=From:To:Cc:Subject:Date:From;
	b=dUkq26BsEXCfX18Btfq6dPJlC2IbQpDL6jXDEumT+Gx5glJFMW4x2LqrNW14t+eHT
	 tV4OvgxC83dt1vyxXUPBVby5KIq/++XnNQkef+xl2b2D7OpbGzVLV5QCINhYHW+ABI
	 maXCX+aRn0SMC4+g+zLGOS/1k9mAKHooFCMI+dnCrjWhEkOS0NCbMZzaeFzHkOvVgc
	 gQjgUy1R8GxDImMQHcjYwetRb2r1a7h9ELMZqeSH3itKuoMekmfxI9GenySvWtNRwg
	 HptPzz/9psi13fW39DOc7rqArk5EtJajnjIKbYPG8O0c8a9a+U/T4j5LpqRo17X5Bc
	 i9aRyVIgSesPg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpDs-000000006nG-3IZb;
	Wed, 04 Jun 2025 16:36:09 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/5] wifi: ath11k: fix dest ring-buffer corruption
Date: Wed,  4 Jun 2025 16:34:52 +0200
Message-ID: <20250604143457.26032-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a follow up to commits:

	6d037a372f81 ("wifi: ath11k: fix ring-buffer corruption")
	ab52e3e44fe9 ("wifi: ath11k: fix rx completion meta data corruption")

add the remaining missing memory barriers to make sure that destination
ring descriptors are read after the head pointers to avoid using stale
data on weakly ordered architectures like aarch64.

Also switch back to plain accesses for the descriptor fields which is
sufficient after the memory barrier.

New in v2 are two patches that adds the missing barriers also for source
rings and when updating the tail pointer for destination rings.

To avoid leaking ring details from the "hal" (lmac or non-lmac), the
barriers are added to the ath11k_hal_srng_access_end() helper. For
symmetry I therefore moved also the dest ring barriers into
ath11k_hal_srng_access_begin() and made the barrier conditional.

[ Due to this change I did not add Miaoqing's reviewed-by tag. ]

Johan


Changes in v2:
 - add tested-on tags to plain access patches
 - move destination barriers into begin helper
 - fix source ring corruption (new patch)
 - fix dest ring corruption when ring is full (new patch)


Johan Hovold (5):
  wifi: ath11k: fix dest ring-buffer corruption
  wifi: ath11k: use plain access for descriptor length
  wifi: ath11k: use plain accesses for monitor descriptor
  wifi: ath11k: fix source ring-buffer corruption
  wifi: ath11k: fix dest ring-buffer corruption when ring is full

 drivers/net/wireless/ath/ath11k/ce.c    |  3 ---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 25 +++++++-----------
 drivers/net/wireless/ath/ath11k/hal.c   | 35 +++++++++++++++++++++----
 3 files changed, 39 insertions(+), 24 deletions(-)

-- 
2.49.0


