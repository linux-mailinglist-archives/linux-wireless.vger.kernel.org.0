Return-Path: <linux-wireless+bounces-18308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BDA261ED
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10263A061A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCEC1D63D3;
	Mon,  3 Feb 2025 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umpApImA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FFD1D5176
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605889; cv=none; b=NapVOSX8eqoc3ts9JYOEupayj/3xRC+LU5NvNwNaqTljQc9dxxKkCaBaTP2BFNyUDfKpGp/ZORzvGUa1toKSzu/JEC8fYsuPSdMOx42qfLhggjuHnVmEvTxPfOTwx4BMlkxyYjtGIf6go8xGvPzVhsYeQ57TVZtrTN+fcOH7GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605889; c=relaxed/simple;
	bh=uyU+cyi8HOtY8ILi4qFyRpji6zcStOmr4W2XE7K2sbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OW1eD1D8UkLL7C9AxrFcuYN1Y5V0M19KPLUTn+4JVqxKVuj5m7kt09xqDIhJhSJHvrj1G/WOqlBwl3gKwwbVQBQ4EEso57DzyHD8zFM4T3JcA53P4/BnzvmjdcQCWgf+U79oY8zmwwkrhDxIy5pWzE8Q6gJULsDndJ1rvKP7+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umpApImA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF163C4CED2;
	Mon,  3 Feb 2025 18:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738605888;
	bh=uyU+cyi8HOtY8ILi4qFyRpji6zcStOmr4W2XE7K2sbs=;
	h=From:To:Cc:Subject:Date:From;
	b=umpApImARvSABFTR6sL+J2VYowWUn7ZPrhYKySJ3e+oQ8bnVMYMmQ5Ax4frhhYqNk
	 0YJg3hiYqNHEpsQCobNTL0k68x1+3VLb9/KeR1O0qi2wdv4QA9P5dXCeckTKf8+uqg
	 IMXaZxjv/E9fiDWuFLiEF2KgSc8ZhzkcNkGvszVfhyTVjE2Etg173pO+0gGIrBfi7r
	 TByVSJKOOm+v8cDniJgjWC8cUUPpZSnDV6V5cW5YHUQUbmWRhQ4lleYiWEOn8R+SYA
	 C4V5EhxJHFwIqoATaHunW0rad+NqiUaKXAaI8jE1SnhzIaT6ooiTpBxX1Ein4bazJP
	 f8jJ5W5n+6V9A==
From: Kalle Valo <kvalo@kernel.org>
To: ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless 1/2] MAINTAINERS: wifi: ath: remove Kalle
Date: Mon,  3 Feb 2025 20:04:44 +0200
Message-Id: <20250203180445.1429640-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm stepping down as ath10k, ath11k and ath12k maintainer so remove me from
MAINTAINERS file and Device Tree bindings. Jeff continues as the maintainer.

As my quicinc.com email will not work anymore so add an entry to .mailmap file
to direct the mail to my kernel.org address.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 .mailmap                                                      | 1 +
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml         | 1 -
 .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml     | 1 -
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml         | 1 -
 .../devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml     | 1 -
 .../devicetree/bindings/net/wireless/qcom,ath12k.yaml         | 1 -
 MAINTAINERS                                                   | 4 ----
 7 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 42e42cabb36d..68d36bf46dcb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -370,6 +370,7 @@ Juha Yrjola <juha.yrjola@solidboot.com>
 Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
 Iskren Chernev <me@iskren.info> <iskren.chernev@gmail.com>
 Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
+Kalle Valo <kvalo@kernel.org> <quic_kvalo@quicinc.com>
 Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com> <periyasa@codeaurora.org>
 Kathiravan T <quic_kathirav@quicinc.com> <kathirav@codeaurora.org>
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index 070c4c9b8643..aace072e2d52 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies ath10k wireless devices
 
 maintainers:
-  - Kalle Valo <kvalo@kernel.org>
   - Jeff Johnson <jjohnson@kernel.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index a71fdf05bc1e..a4425cf196ab 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies ath11k wireless devices (PCIe)
 
 maintainers:
-  - Kalle Valo <kvalo@kernel.org>
   - Jeff Johnson <jjohnson@kernel.org>
 
 description: |
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index ff5763dc66a8..a69ffb7b3cb8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies ath11k wireless devices
 
 maintainers:
-  - Kalle Valo <kvalo@kernel.org>
   - Jeff Johnson <jjohnson@kernel.org>
 
 description: |
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
index cbfb559f6b69..318f305405e3 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
@@ -9,7 +9,6 @@ title: Qualcomm Technologies ath12k wireless devices (PCIe) with WSI interface
 
 maintainers:
   - Jeff Johnson <jjohnson@kernel.org>
-  - Kalle Valo <kvalo@kernel.org>
 
 description: |
   Qualcomm Technologies IEEE 802.11be PCIe devices with WSI interface.
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index 1b5884015b15..9e557cb838c7 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -9,7 +9,6 @@ title: Qualcomm Technologies ath12k wireless devices (PCIe)
 
 maintainers:
   - Jeff Johnson <quic_jjohnson@quicinc.com>
-  - Kalle Valo <kvalo@kernel.org>
 
 description:
   Qualcomm Technologies IEEE 802.11be PCIe devices.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5bcc78c0be70..2048c75c3c42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3631,7 +3631,6 @@ F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 F:	drivers/phy/qualcomm/phy-ath79-usb.c
 
 ATHEROS ATH GENERIC UTILITIES
-M:	Kalle Valo <kvalo@kernel.org>
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
@@ -19192,7 +19191,6 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/tuners/qt1010*
 
 QUALCOMM ATH12K WIRELESS DRIVER
-M:	Kalle Valo <kvalo@kernel.org>
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath12k@lists.infradead.org
 S:	Supported
@@ -19202,7 +19200,6 @@ F:	drivers/net/wireless/ath/ath12k/
 N:	ath12k
 
 QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
-M:	Kalle Valo <kvalo@kernel.org>
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath10k@lists.infradead.org
 S:	Supported
@@ -19212,7 +19209,6 @@ F:	drivers/net/wireless/ath/ath10k/
 N:	ath10k
 
 QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
-M:	Kalle Valo <kvalo@kernel.org>
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath11k@lists.infradead.org
 S:	Supported

base-commit: 3319569bf9d8b4d8c5aaf0d410b620210c4bb317
-- 
2.39.5


