Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3A6260C9E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgIHHzd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 03:55:33 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:56904
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbgIHHzb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 03:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599551731;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=qaY5Dk7ViEa4GGrAI6tOa+BjCf/dNJXLglEl4IIPa9o=;
        b=AzQNiLCoO0jw9RMdixJ3eHV+o5jOU3cqAHzzNmM3jJhdHrCmokNCsyt6DDlyVesT
        9kDBjWuDBhwaZYNEy43bjRrPplbSgfUvTBT8V0ZhxnaLrk4ZrTlDqNHacE902TZ2Vob
        CnbXk7qY5QZW+YuedAEh62NlAZik9UltHxIEm9OA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599551731;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=qaY5Dk7ViEa4GGrAI6tOa+BjCf/dNJXLglEl4IIPa9o=;
        b=fKuQm1nU6uRmbQfJIXsiaUAAOkwkYSgztYvqXXLxYMlSLbuxixBXOS4u3frMeWxH
        o0KeAThgoT++7ObpI/fN3B6Rtaasw7eAMstSxiCT0/mMEyQB2IId+CMbGMJrNNmFFWW
        e0GGNuKtW1pw3cOeAsu6X35twVLH5Ezjgli2QBdk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93D36C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v7 1/3] dt: bindings: net: update compatible for ath11k
Date:   Tue, 8 Sep 2020 07:55:31 +0000
Message-ID: <010101746cb6751a-ca300933-1174-4534-a01b-b1dbf1c1f305-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599551717-3801-1-git-send-email-akolli@codeaurora.org>
References: <1599551717-3801-1-git-send-email-akolli@codeaurora.org>
X-SES-Outgoing: 2020.09.08-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add IPQ6018 wireless driver support,
its based on ath11k driver.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V3:
 - Use 'enum' rather than oneOf+const.
V4:
 - removed oneOf, use just enum (Rob)
V5:
 - Fixes errors in 'make dt_binding_check' (Rob)

 Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index a1717db36dba..4b365c9d9378 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -17,7 +17,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,ipq8074-wifi
+    enum:
+      - qcom,ipq8074-wifi
+      - qcom,ipq6018-wifi
 
   reg:
     maxItems: 1
-- 
2.7.4

