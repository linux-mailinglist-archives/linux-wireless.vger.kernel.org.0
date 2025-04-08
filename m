Return-Path: <linux-wireless+bounces-21281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF8A8154E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C82C1BA4610
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C38225A40;
	Tue,  8 Apr 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHGbB9wr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AF21517D;
	Tue,  8 Apr 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139019; cv=none; b=QfEY4xvOlqDTcdd08BmZ3WkbOu+fn3N7HBjEhTELj6R4vKTXMAkI5itwUQq4+COTMSxcZw9KtgZli0BzYegy5Acx/JqbSvU9Wp8bAmWkr+1CdwjByyq0ffgT3xAVFIIziKSE4qmHSgTrUQ68GWA1mDKUT3n8AFEx2XwHbmYIu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139019; c=relaxed/simple;
	bh=pHSSTO56neWEEEtpVKmutcv8dw9yWs0shUPmz9GS6v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyvAQIp4IIwl+RkUfQDCGYcuha1GBaB9J6/01AhwOnvoqjX+ernppMORB/wVNw+BWNa9BkQvcw+NAZIsz5As2dHRyHJoU4twpMJTZNyFDmspxNNbONwWP78lx9B6c11w5PlqqcMFY+U5CWcjocr7KK2rWgJCnVf0yN4IFnq3EWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHGbB9wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE3CC4CEE5;
	Tue,  8 Apr 2025 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744139018;
	bh=pHSSTO56neWEEEtpVKmutcv8dw9yWs0shUPmz9GS6v4=;
	h=From:To:Cc:Subject:Date:From;
	b=jHGbB9wrS9Ga5nO6c0XIStwD4hEx9MwNOOY6sWYkQHLfuTLHDwrqeMnev/R8Eytb3
	 XMBwXMzr/I5AKWpi5uzAkRBTixYzLesS10cKeUpijGLkpq1iN5gnEuzobgwtUXKgd2
	 x7Hee3peXsAH5HBtzxDAzMNfxZd8SQDa9AF9mZ6JNCKQHC1y17umW6tT2PNuMJwT81
	 dA2e6VCBSK3iBRYkZtOIlp17ky+mKuO4Hpeg1hOmn4w1Z7QNNbwnLG380iwzNdeGZs
	 Jxkh2bTYEhWGeKNff2lSODAvwGwfajmmXBoMu7cDK9cnz3z4/g7DypdvsSNKfIyTyO
	 0PsqvzaYQTRqw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath11k: Use of_property_present() to test property presence
Date: Tue,  8 Apr 2025 14:02:11 -0500
Message-ID: <20250408190211.2505737-2-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_u32() isn't really correct as
"memory-region" contains phandles (though those happen to be u32s. As
it is just testing for property presence, use of_property_present()
instead.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
I'm assuming this should still go to linux-wireless list? I had to 
manually add that, so looks like recent MAINTAINERS changes aren't quite 
right.

 drivers/net/wireless/ath/ath11k/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 412f4a134e4a..87ef7f321065 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -929,7 +929,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 {
 	struct ath11k_base *ab;
 	struct ath11k_pci *ab_pci;
-	u32 soc_hw_version_major, soc_hw_version_minor, addr;
+	u32 soc_hw_version_major, soc_hw_version_minor;
 	int ret;
 	u32 sub_version;
 
@@ -955,8 +955,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 	 * from DT. If memory is reserved from DT for FW, ath11k driver need not
 	 * allocate memory.
 	 */
-	ret = of_property_read_u32(ab->dev->of_node, "memory-region", &addr);
-	if (!ret)
+	if (of_property_present(ab->dev->of_node, "memory-region"))
 		set_bit(ATH11K_FLAG_FIXED_MEM_RGN, &ab->dev_flags);
 
 	ret = ath11k_pci_claim(ab_pci, pdev);
-- 
2.47.2


