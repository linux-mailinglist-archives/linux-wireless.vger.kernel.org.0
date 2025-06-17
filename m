Return-Path: <linux-wireless+bounces-24182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE0ADC53C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 10:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C991894490
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD9290092;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez/t/QZh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6128FFEC;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149890; cv=none; b=SxfnQwz1x9TZOcelED9l+ACh6NdEMT2Dg5otX77my2/+txe8KZSoP4AtA8oTMOXknr4NM441zg3DARoHpyYl0G85LPMr4g0N1DNHzSgUHTsc9gGU1H+lj7x0/mKYfsei/nrmoYk3XC6XRqE7Yru9HRkCdTSN0ihtZBTar2IvyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149890; c=relaxed/simple;
	bh=UwJ4gWOA+4pUw1190gZfv9SzitV3uWzPw5iBVgkeq28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTtu0iQ5cRVTEv7QOH/zOhxV9bXRidBcGnAuxwpucRZZinAe1TWfBoM4Fi7d2dCkTPLSRST2bBHeh0DvUG1mkQYr5ttjpYn6///g1zHBpwRJKPRLoAuMSif/o6KHTg8tfB8Kp++mW1pEPLcwargLBba9Up/7E2m7lUTVCP+dXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez/t/QZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C827C4CEEE;
	Tue, 17 Jun 2025 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149890;
	bh=UwJ4gWOA+4pUw1190gZfv9SzitV3uWzPw5iBVgkeq28=;
	h=From:To:Cc:Subject:Date:From;
	b=ez/t/QZh2AGvECjxhFJVod2sUwdGUte5QUrvSJHZowj0cxJBN/f9IB+p4KZLx+S9w
	 9tQGouQPOBtO09IopoEoe2ImCunfDOW+pGBjBbaql+EgnpV1nOQ7Pz0jNZmFnUiagK
	 7dtE8+MsyizOj2yYybrEnmNh+OSvEWl7BgSae0ryhAVm6FotSELBeLxwfQyEOb1wBK
	 8vRFwFUF3QlEDt8f5psC0H6xyUj0uG2zvnnQpq5jeKppuNdT3qxJMAURo6nesBy9Xy
	 Tzvci9RI9AQ4zIl9V1WtPuw/MCR/ttYdYVkXDmPdlT7Zt0XASDBsDVWbOnCPurmdO2
	 DaFGUydhrA7Og==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uRRvz-000000003ml-3pRK;
	Tue, 17 Jun 2025 10:44:47 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/4] wifi: ath12k: fix dest ring-buffer corruption
Date: Tue, 17 Jun 2025 10:43:58 +0200
Message-ID: <20250617084402.14475-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a follow up to commit:

	b67d2cf14ea ("wifi: ath12k: fix ring-buffer corruption")

add the remaining missing memory barriers to make sure that destination
ring descriptors are read after the head pointers to avoid using stale
data on weakly ordered architectures like aarch64.

Also switch back to plain accesses for the descriptor fields which is
sufficient after the memory barrier.

New in v2 are two patches that add the missing barriers also for source
rings and when updating the tail pointer for destination rings.

To avoid leaking ring details from the "hal" (lmac or non-lmac), the
barriers are added to the ath12k_hal_srng_access_end() helper. For
symmetry I therefore moved also the dest ring barriers into
ath12k_hal_srng_access_begin() and made the barrier conditional.

[ Due to this change I did not add Miaoqing's reviewed-by tag. ]

Johan


Changes in v3:
 - drop reference to commit 51ad34a47e9f ("wifi: ath12k: Add drop
   descriptor handling for monitor ring") from the commit message of
   patch 1/4

Changes in v2:
 - add tested-on tags to plain access patch
 - move destination barriers into begin helper
 - fix source ring corruption (new patch)
 - fix dest ring corruption when ring is full (new patch)


Johan Hovold (4):
  wifi: ath12k: fix dest ring-buffer corruption
  wifi: ath12k: use plain access for descriptor length
  wifi: ath12k: fix source ring-buffer corruption
  wifi: ath12k: fix dest ring-buffer corruption when ring is full

 drivers/net/wireless/ath/ath12k/ce.c  |  3 --
 drivers/net/wireless/ath/ath12k/hal.c | 40 ++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.49.0


