Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2218222AEBE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgGWMLk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 08:11:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62309 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgGWMLk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 08:11:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595506299; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FptydSy4bM+wkVcJlAXIuT/JksRJcUM8YQGl+UvE1Ow=; b=TmKAx96XTQ7avz+L6fgkbykfHw8f4NkLJgqx27jWBjyzU94sq55DKkLeTUSzLtHeZkc4QiCf
 agoTzaqP777T0ABzo9ZHMlOa/HJeMVNWdoqo8wimhxKxab8a3ieTl1zRCoFEWhHImoiSPhzl
 +Zp/vYgOOjEWcCvbxC7k+EdEMIo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f197e653dbcb593a9467462 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Jul 2020 12:11:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29AFBC433C6; Thu, 23 Jul 2020 12:11:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DEBFC433CB;
        Thu, 23 Jul 2020 12:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DEBFC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        akolli@codeaurora.org
Subject: [PATCH v4 1/3] dt: bindings: net: update compatible for ath11k
Date:   Thu, 23 Jul 2020 17:41:02 +0530
Message-Id: <1595506264-6393-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595506264-6393-1-git-send-email-akolli@codeaurora.org>
References: <1595506264-6393-1-git-send-email-akolli@codeaurora.org>
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

 Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index a1717db36dba..7cd1e323ca56 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -17,7 +17,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,ipq8074-wifi
+    - enum:
+       - qcom,ipq8074-wifi
+       - qcom,ipq6018-wifi
 
   reg:
     maxItems: 1
-- 
2.7.4

