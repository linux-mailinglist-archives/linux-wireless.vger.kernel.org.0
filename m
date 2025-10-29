Return-Path: <linux-wireless+bounces-28363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEBC1B9FB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 16:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E60266134F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1D52DC76A;
	Wed, 29 Oct 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4kvwU8P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C342C028D;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748001; cv=none; b=BLdnB9ktGwuyL1g74zcebPPRVcwoQbGSNjrNfOI2Q0H7Q5utVsOpqMRAqpomR9xUtzw+EPeHXXRv9aRoroOF9FyCXX1Wm0Nj5/KVafRpHFvK25ZqWO1GoONIB2aheD60e6o47QWIGayQRi5qFYJaVyValXBP/MnnNHSs09MHHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748001; c=relaxed/simple;
	bh=VZqF9VrAmlHotZC3esggL8Hr1cnKxgb531ArBlobfaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KR9R0/FIAcHd9aBES5fTyUsPMZbDtuwc2J5BsYZCqvOxXMKWpNwkC/m0oaaOsQVXkXoWxlcc3IAAPVkbqbpJOYsxsSIf/v/ZW89FiE9x8Q1qaXAJGPPTb8SOFs++kB3Ye6DyHj1yzkmcoxcNacWdJmIZp49pV+TjNqztgb6Q0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4kvwU8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5F2BC116C6;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748000;
	bh=VZqF9VrAmlHotZC3esggL8Hr1cnKxgb531ArBlobfaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p4kvwU8PXGIa7diweVJjDvIyEOAl2NEL2Yg6t1WtZBlb975WYqMYBMUOFLw1ps+HP
	 jYZqyxfUSTeYEbUf/14hLDl+ceNvugPIDDeXSohWTJ33JMSPvxZOxScW1IEWJkoJh9
	 y/JcjTBDdWPyxZmUWsCn4xSo2gJXGamyucg+OgxSKwScN4uG8C2Lm7+sm4VvexwMsI
	 uM3DTTohKBVzTSuBjMqS5aa7PQEMhvjuDtT8ixSYS3J6mn+gkfwhBHC9vOxAQBViDX
	 nvi8SXfyDoJD+c+y37S3cqMyEHynugZ9ZK04ImiOJH6PAplRVmNvxqrSWYAuB7rps7
	 gMD4uZxfry7UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC4CCF9F6;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 18:26:27 +0400
Subject: [PATCH 6/6] wifi: ath11k: add QCN6122 device support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ath11k-qcn6122-v1-6-58ed68eba333@outlook.com>
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
In-Reply-To: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761747997; l=1944;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=MO7KsMfpzKHk3Kbh2D8damE6MIZVTsMgz25SICdrEDs=;
 b=K3qK5c3f0lBX0CW0vl5IFl9pODMBfTzS0f2OsZsmCjYeksCdtIJiyhhes4SZWzKIzw18NU6EC
 egExsLPJIhlDMg0OgQbszxEu05a3cT04hTUgeQbovPISaaGNStZjFGi
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add support for QCN6122 wifi.
STA, AP, and MESH modes are supported.

Tested on: Linksys MX2000, Linksys MX6200, and GLiNET B3000 access
points for prolonged duration tests spanning multiple days with multiple
clients connected with firmware:
WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Although QCN6122 is a PCIe device, it is an IPQ5018 SoC specific
solution and uses shared IPQ5018/QCN6122 firmware.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 3 +++
 drivers/net/wireless/ath/ath11k/pcic.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 820a383e88caf125892176e421b0121fed7e7055..6747fcdbf9a777d4214b9ef751dac2774a80c0ff 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -37,6 +37,9 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
 	{ .compatible = "qcom,ipq5018-wifi",
 	  .data = (void *)ATH11K_HW_IPQ5018_HW10,
 	},
+	{ .compatible = "qcom,qcn6122-wifi",
+	  .data = (void *)ATH11K_HW_QCN6122_HW10,
+	},
 	{ }
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index fc6e7da05c6028e30facf10d38a55f614067e44b..ac1e156ab3e0f0c47de1eb1ac5afea21addfd739 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -139,6 +139,15 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 		},
 		.hw_rev = ATH11K_HW_QCA6698AQ_HW21,
 	},
+	{
+		.total_vectors = 13,
+		.total_users = 2,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "CE", .num_vectors = 5, .base_vector = 0 },
+			{ .name = "DP", .num_vectors = 8, .base_vector = 5 },
+		},
+		.hw_rev = ATH11K_HW_QCN6122_HW10,
+	},
 };
 
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab)

-- 
2.51.1



