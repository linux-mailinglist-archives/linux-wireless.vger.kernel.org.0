Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13082F6D8D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 05:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKEZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Nov 2019 23:25:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfKKEZR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Nov 2019 23:25:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7A1160B6C; Mon, 11 Nov 2019 04:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573446316;
        bh=4Y0YwJJR6qs/159PSN+vDpI/U/hJrMx5N4QmXUvVgTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NM2bGDqKK2OY7uUphdFFI9z05JQAG22zHpa3RnBbXUzHDnWvxkLxXxJ4NaOatTjuJ
         RcfbBZwJHJYPQ5G/Nmz8hC5/r5vV+rkyT5Gn2pSXRIsOwQrrJjTEK+kNGlzqnTp8Y/
         wWL6UVm3PkffnYKoQAW1maAop7tLiCvyUxM5U9pc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD9166092C;
        Mon, 11 Nov 2019 04:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573446316;
        bh=4Y0YwJJR6qs/159PSN+vDpI/U/hJrMx5N4QmXUvVgTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NM2bGDqKK2OY7uUphdFFI9z05JQAG22zHpa3RnBbXUzHDnWvxkLxXxJ4NaOatTjuJ
         RcfbBZwJHJYPQ5G/Nmz8hC5/r5vV+rkyT5Gn2pSXRIsOwQrrJjTEK+kNGlzqnTp8Y/
         wWL6UVm3PkffnYKoQAW1maAop7tLiCvyUxM5U9pc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD9166092C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH v2 1/2] dt: bindings: add dt entry flag to skip SCM call for msa region
Date:   Mon, 11 Nov 2019 09:55:07 +0530
Message-Id: <20191111042508.12628-2-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191111042508.12628-1-govinds@codeaurora.org>
References: <20191111042508.12628-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add boolean context flag to disable SCM call for statically
mapped msa region.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
index 017128394a3e..7ba22918bab7 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
@@ -88,6 +88,9 @@ Optional properties:
 		    of the host capability QMI request
 - qcom,xo-cal-data: xo cal offset to be configured in xo trim register.
 
+- qcom,msa_fixed_perm: Boolean context flag to disable SCM call for statically
+		       mapped msa region.
+
 Example (to supply PCI based wifi block details):
 
 In this example, the node is defined as child node of the PCI controller.
@@ -185,4 +188,5 @@ wifi@18000000 {
 		vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 		memory-region = <&wifi_msa_mem>;
 		iommus = <&apps_smmu 0x0040 0x1>;
+		qcom,msa_fixed_perm;
 };
-- 
2.22.0

