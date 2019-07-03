Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000D25DD25
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 05:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGCD5U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 23:57:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCD5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 23:57:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 874EF607DE; Wed,  3 Jul 2019 03:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562126239;
        bh=swA+By0KKqoGjcIDAfeGafYPVgkUut5vD1yu9dPbk6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eY0N3cfJlRy2Gg+Uy6ransk3hDgDsftv8b92JZz+umrw998ZUddTR6YqA4tSqeJNv
         2MT8zneUfDFzV6DDgtImTvSs1oa8TbWu7a1xPXSmukI5tzs6pnSXgsvx9E+jvQnV7x
         aVwFGk/jLp3kPzN7k7gYA4e+8jeVOwqE/71cJd8Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7499360770;
        Wed,  3 Jul 2019 03:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562126239;
        bh=swA+By0KKqoGjcIDAfeGafYPVgkUut5vD1yu9dPbk6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eY0N3cfJlRy2Gg+Uy6ransk3hDgDsftv8b92JZz+umrw998ZUddTR6YqA4tSqeJNv
         2MT8zneUfDFzV6DDgtImTvSs1oa8TbWu7a1xPXSmukI5tzs6pnSXgsvx9E+jvQnV7x
         aVwFGk/jLp3kPzN7k7gYA4e+8jeVOwqE/71cJd8Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7499360770
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 1/3] dt: bindings: update compatible dt properties for WCN3990 wifi node
Date:   Wed,  3 Jul 2019 09:27:09 +0530
Message-Id: <20190703035711.25592-2-govinds@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703035711.25592-1-govinds@codeaurora.org>
References: <20190703035711.25592-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

update compatible dt properties for WCN3990 wifi node to be
compatible across different MSM platforms.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
index ae661e65354e..baaa3f32ae44 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
@@ -5,6 +5,8 @@ Required properties:
 	* "qcom,ath10k"
 	* "qcom,ipq4019-wifi"
 	* "qcom,wcn3990-wifi"
+	* "qcom,sdm845-wcn39xx-wifi"
+	* "qcom,qcs40x-wcn39xx-wifi"
 
 PCI based devices uses compatible string "qcom,ath10k" and takes calibration
 data along with board specific data via "qcom,ath10k-calibration-data".
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

