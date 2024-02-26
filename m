Return-Path: <linux-wireless+bounces-4019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA52867F8E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 19:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D828D399
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9212DDAD;
	Mon, 26 Feb 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtIGL0Kk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4112DD87
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970869; cv=none; b=TQHfKSnMmoADbCvsWWhQaKIGfFK/ahyTpI0p6tIv0xeKlnN4McNK4uJXhdSWOpIR1/CDhylTlda5ISbacg2NB22Q5JJW01XBR+Ykvdr+s0vaJeNC29AI8t3S9CWQ4jZJ+SAL9wsUNGwinLf/GPIPZ+JUKOBlORnXc6ok8jtZ8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970869; c=relaxed/simple;
	bh=J/7FZyfKcyHUYIOf/R68OJOh8BSS70qpjReTtInbquY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6ZeE4npMqJ4lOexLK3Wycrewz5NItjfg104sMXltckNfUEHSdg0WE9AQRKysUUnv3l6yp5SvUmlG/ExsznvH2j7zic6pEjroPpNlAuKATPJ0ZW0rYV3iVjMYMyzVvEKIdohRrg8y/uagAYhXZzWZ47haQ6bk6JKjG/HgJFNjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtIGL0Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F821C433F1;
	Mon, 26 Feb 2024 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708970868;
	bh=J/7FZyfKcyHUYIOf/R68OJOh8BSS70qpjReTtInbquY=;
	h=From:To:Cc:Subject:Date:From;
	b=XtIGL0KknF0Ze2PxwrbJr06EMgkPNH17mjCaqWqOOVPAzKRPfQR4WE20sf8x3CuF+
	 TBYzLCl/wFHUC4c5Ru1SL2RCvO1EsJ03q0mZvftD6aPN03td47BMa2hOaUwCqqSoou
	 yGgJEjrDItau36GLI7gJDFxnCVGnFEdFFT5cNKpVIah1XI7/cpa9paitOUT5PPW4v/
	 pNvbN9q+zCm+j3ab7NdcLMOVzA0bbcBTssWCQAAfhMEdO1IsgyrhBfxBOXMM7qydse
	 vYQy7+Eh5NdN6JOL64ai8eBspv0fRxvEhJ1L7dmE9k3yg+jvLZ/x60Lq3J/RGIBNOG
	 fjs0ZQpx1oM4Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix license in p2p.c and p2p.h
Date: Mon, 26 Feb 2024 20:07:45 +0200
Message-Id: <20240226180745.3195805-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

ath12k uses BSD-3-Clause-Clear, not ISC.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/p2p.c | 2 +-
 drivers/net/wireless/ath/ath12k/p2p.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
index 61e919b23b16..d334df720032 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.c
+++ b/drivers/net/wireless/ath/ath12k/p2p.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ISC
+// SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
diff --git a/drivers/net/wireless/ath/ath12k/p2p.h b/drivers/net/wireless/ath/ath12k/p2p.h
index b6f177fe4ff4..5768139a7844 100644
--- a/drivers/net/wireless/ath/ath12k/p2p.h
+++ b/drivers/net/wireless/ath/ath12k/p2p.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ISC */
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved..
  */

base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11
-- 
2.39.2


