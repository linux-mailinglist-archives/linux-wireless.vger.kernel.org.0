Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2264A54676A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiFJNgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiFJNgs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 09:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E5393CF
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 06:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D22161B2D
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 13:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277AFC34114;
        Fri, 10 Jun 2022 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654868204;
        bh=MvVzgcpreC7kAbvFcHN7/ImYpOY0N6AnfZXoOrGMCX0=;
        h=From:To:Cc:Subject:Date:From;
        b=esqsUxY4xzE2Qw42TqlJUPctigFP+s2OJdhSyB/aU+FooeGB9bglV3WT9FCmfaX1v
         IRbdMsb1b5E+bLCSYqeBC8aBiZWZxPjXlZFp/fAzj74YuWMuBDxOhXFqxUOGQs4q9y
         8nhN610pVxxGakdLSMFLb9ZoRtlbEESvuJC112X2lDdhUj0Kx6SUMUPAJb7xcUiTZG
         gmlJLskaIBBRaCT9eNqjdTabgXfcNEzyfgZ7vzZALhye9bq6B1EA5a9H4gTxojQtgN
         WpxHnvIFNpZpf+c+aqlmDGqBNGzsnu5yYfEp8xPjGO9A+Vt4Fv/vHZpGpbXZyx8XqJ
         gAB2IaRB/iYmg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless v2 1/2] dt-bindings: net: wireless: ath9k: Change Toke as maintainer
Date:   Fri, 10 Jun 2022 16:36:39 +0300
Message-Id: <20220610133640.10810-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Toke now maintains ath9k so update DT bindings as well.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
index 8cd0adbf7021..7029cb1f38ff 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Atheros ath9k wireless devices Generic Binding
 
 maintainers:
-  - Kalle Valo <kvalo@codeaurora.org>
+  - Toke Høiland-Jørgensen <toke@toke.dk>
 
 description: |
   This node provides properties for configuring the ath9k wireless device.

base-commit: 90f4b5499cdd94be3c1e856375ecd7d5f9c4cecc
-- 
2.30.2

