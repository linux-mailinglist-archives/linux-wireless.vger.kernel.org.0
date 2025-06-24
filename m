Return-Path: <linux-wireless+bounces-24413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22DAE5EFE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 10:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5574A2892
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E9257424;
	Tue, 24 Jun 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2MzqTxI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E1253950;
	Tue, 24 Jun 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753299; cv=none; b=Ei84/HBqCbwuPVLAaXbORC/5h9tq5YBsXgQ0GZJhyTtfY54ojSQ18cIS8zOcwBYJMJ9pwBopJp3QeRmPObBEAHjCquQY2LFStKlITU6LPhsfJf1JIByyrgNlvY/I8l8U42syywJ4ZtDnELTKuQ0UOdzRosgxWS8RCnFjDGPRXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753299; c=relaxed/simple;
	bh=sMDYw/iEzAAz7E8kipgSoSk+Xe3siOFd54HwBLDS/lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6Roo2cnvOkM3PJJcqIpORME+U79ri889HUCT7tZFdm0OiglJfTemcQDPrJHkRPRDUR64KE550XctxiysJKLjz9kMjB6pGqW6aDkkIE7mnaO/9fZxuRW2HUOPG/6kA8Js7stZvU2G9mLAeuKpuX2JuXxiYqU/LzAono3Nfd09AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2MzqTxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C38C4CEE3;
	Tue, 24 Jun 2025 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753299;
	bh=sMDYw/iEzAAz7E8kipgSoSk+Xe3siOFd54HwBLDS/lw=;
	h=From:To:Cc:Subject:Date:From;
	b=Z2MzqTxI3dtLZ7GtsTSYeMod9QaXWm+vcXoL8iaQcrCqlf1k5EKrjFgoyzhTbm9DQ
	 2dKYoB8gMhemY3752FmjoAUa/O11f/+md/cW03qFT80BXvOHXo6XKwcV/Ah5sEUat0
	 rngw8dM8a1lnP5BY6oogNa4uQngxhw2R8fMvNhJKUAX3duH8DFom9eu88Z5qK1gKsH
	 HYBzuIl38GffZQT78sqHTncspRbMsmE9UkOJ/ekXxHcXkfzEIsUAY3H4GauB4fX6jL
	 6J/E89XR9yeySKbTATQ//O57LFo0fdm6yK4/LTxmLGSFry0jDB5su41mEZqJohGMgo
	 N9wMXqqxeNHSQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uTyuO-0000000042t-3zC9;
	Tue, 24 Jun 2025 10:21:37 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix suspend use-after-free after probe failure
Date: Tue, 24 Jun 2025 10:20:22 +0200
Message-ID: <20250624082022.15469-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the PM notifier to avoid a use-after-free on
suspend in case core initialisation fails (e.g. due to missing
firmware).

Fixes: 32d93b51bc7e ("wifi: ath11k: choose default PM policy for hibernation")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/all/d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com/
Cc: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 22a101136135..eb1f35617c64 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -2581,10 +2581,15 @@ int ath11k_core_init(struct ath11k_base *ab)
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
-		return ret;
+		goto err_unregister_pm_notifier;
 	}
 
 	return 0;
+
+err_unregister_pm_notifier:
+	ath11k_core_pm_notifier_unregister(ab);
+
+	return ret;
 }
 EXPORT_SYMBOL(ath11k_core_init);
 
-- 
2.49.0


