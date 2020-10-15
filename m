Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03DD28F322
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Oct 2020 15:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgJONYf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 09:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgJONYf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 09:24:35 -0400
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Oct 2020 06:24:35 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC8C061755;
        Thu, 15 Oct 2020 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1602767724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OtGm/dfhR5/P3i7g9bPbe0G2sAeMsBvVGJxEpCJumWI=;
        b=i5HXmdWP+XlalAt5YZiibjn6udv7Iws/fYElEkwacu9NI37tUdvpcRARcM2RxnEakZKA61
        Mds3VWUq/c7kHxaubFcsLdAGdcPD4WETdFW30u9T7KIY9E2VDcKq6ZOqAi+TdZ5EJojVW0
        reFOPhne7wK4+mJp970TpEj7z2qVI0Q=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, devicetree@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] dt: bindings: add new dt entry for ath11k calibration variant
Date:   Thu, 15 Oct 2020 15:15:00 +0200
Message-Id: <20201015131501.1939685-1-sven@narfation.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The bus + qmi-chip-id + qmi-board-id is not enough to identify the correct
board data file on IPQ6018 based devices. Multiple different boards share
the same values. Only the original reference designs can currently be
identified and loaded from the board-2.bin. But these will not result in
the correct calibration data when combined with the pre-calibration data
from the device.

An additional "variant" information has to be provided to select the
correct board data for a design which was modified by an ODM. This follows
the same approach as ath10k.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 4b365c9d9378..6af999191559 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -144,6 +144,12 @@ properties:
         * reg
         * reg-names
 
+  qcom,ath11k-calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      string to uniquely identify variant of the calibration data in the
+      board-2.bin for designs with colliding bus and device specific ids
+
 required:
   - compatible
   - reg
-- 
2.28.0

