Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867B51232C3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 17:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfLQQnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 11:43:41 -0500
Received: from nbd.name ([46.4.11.11]:51148 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfLQQnl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 11:43:41 -0500
Received: from pd95fd66b.dip0.t-ipconnect.de ([217.95.214.107] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihFwe-0004wY-Vr; Tue, 17 Dec 2019 17:43:37 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH 1/2] dt: bindings: net: ath11k: add qcom,board_id definition
Date:   Tue, 17 Dec 2019 17:43:28 +0100
Message-Id: <20191217164329.4151-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need to be able to define what id the board has allowing us to load the
correct definition data. This patch adds the description of the required
property.

Signed-off-by: John Crispin <john@phrozen.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index a1717db36dba..c68daf6ad424 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -142,6 +142,11 @@ properties:
         * reg
         * reg-names
 
+  qcom,board_id:
+      $ref: /schemas/types.yaml#/definitions/uint32
+      description:
+        The board id defining what board definition should be loaded
+
 required:
   - compatible
   - reg
-- 
2.20.1

