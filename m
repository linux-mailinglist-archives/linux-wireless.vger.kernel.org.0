Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9EF545DF2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiFJH7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiFJH7t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:59:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383642065F9
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B4462021
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 07:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD660C34114
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654847987;
        bh=d4QJB77BP/v4Lx/hbX1NB9j4EVmIIu0HiWtVldOysBw=;
        h=From:To:Subject:Date:From;
        b=ngZsA1thbw6+97vY2xR34WAl/IkZk55/MkC9nVcfO3p3ptZOmLRgL9UZgYPbEfcIa
         +HV6LnxLkgujRPmjiKtBMpG4FFLLmkZduc65OtuyMLL55CYUhEbgU/EhvTyO5jJ9Xk
         5TzvYyv4c2cj+yP4HsUv4aPL0ckLxuVomdRYHjM7qDxwKtJpVvMhGlX25uOnlFCBlY
         ctDsMQ3SB+dAMFchwAM6p+iKf5t1V67nXh9KgheD4eAPGO4cUwcXIcLOTl4we5sz6b
         VXcaKlKh9oONp7IpBcI2tCy7rcd5py72EkKFHl+H4lKIvQVAPdht2tR1uMC8DMscPd
         FZRuAAR1A/ugg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless] dt-bindings: net: wireless: change Kalle's email
Date:   Fri, 10 Jun 2022 10:59:44 +0300
Message-Id: <20220610075944.23787-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

My codeaurora.org email doesn't work anymore, so switch to my preferred
kernel.org address.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml   | 2 +-
 Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index 8cd0adbf7021..6593d595b112 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Atheros ath9k wireless devices Generic Binding
 
 maintainers:
-  - Kalle Valo <kvalo@codeaurora.org>
+  - Kalle Valo <kvalo@kernel.org>
 
 description: |
   This node provides properties for configuring the ath9k wireless device.
diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 8c01fdba134b..a677b056f112 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -9,7 +9,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies ath11k wireless devices Generic Binding
 
 maintainers:
-  - Kalle Valo <kvalo@codeaurora.org>
+  - Kalle Valo <kvalo@kernel.org>
 
 description: |
   These are dt entries for Qualcomm Technologies, Inc. IEEE 802.11ax

base-commit: 90f4b5499cdd94be3c1e856375ecd7d5f9c4cecc
-- 
2.30.2

