Return-Path: <linux-wireless+bounces-23712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B831ACE0A1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE183A801A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5629186B;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME07JsVZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CDD28FFF6;
	Wed,  4 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048349; cv=none; b=KDDPxHQIQtspMYdmFepb3uNbpXGWt1BWu8W+qdm8x0Is+mTAhkJKmgZ6ZSSDiEggp2HkpCRxMJtHYF5qAhi6zxj58ch25t1f+Nm0oR7e5jC65YZxNPh6bJhxkkuU6rjEzaqYEPqpU8jBkI1X7gHCEYDcun9RPPscs5Arv3w4SEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048349; c=relaxed/simple;
	bh=jCU35/+TKbgORi0NUC6EDs8hyiwRSH9wrJqZBXO2lXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoputN3cuMYQsL5TtLE7LckgkANTjut1hutQFPQVXrePM1ZIwzw9aTC6+9489c5B15RFJYJCrPyMf45in9gxlN+G0z6Igx06juA+VqiG/14KGFPa5vJp015j73bbjlIF1SilvKbLSLm6ZUoxKa6W3WNK1oIaiz+FUOE6tVli5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME07JsVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2613C4CEE4;
	Wed,  4 Jun 2025 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749048349;
	bh=jCU35/+TKbgORi0NUC6EDs8hyiwRSH9wrJqZBXO2lXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ME07JsVZauyPsfZRf0dc2C5+jipj5QEb0AEbo4ebssUeyozBPuIZ26dsuDXfrpSbv
	 upkSTYbg/vZgtCNKKIaD/LXk2uavHjrlr1I71jtS25PqwwLFl+UQCbmdD0WTz0xaRf
	 kpcL+LjZ/3gviyZlZ+ObZCzuw8dyf93j0MAoQBC2OmcxPb+ggO5ZIEybIsjW0icQLJ
	 0qLexdjRIQtMctYefE3eg9HPQQnm0S5Eglo9pTWGXGcnkP0l2j/TytMjoEqh5cAyTC
	 6sxxoVf7owE6AP5ZUTciG6QnopTooUIK54ElNbwsP8kcmqTqOCK9u9ZJz+jDhIr5HE
	 szAhc+7ff5OGw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uMpNC-000000007OW-1iOK;
	Wed, 04 Jun 2025 16:45:47 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] wifi: ath12k: fix dest ring-buffer corruption
Date: Wed,  4 Jun 2025 16:45:05 +0200
Message-ID: <20250604144509.28374-1-johan+linaro@kernel.org>
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


