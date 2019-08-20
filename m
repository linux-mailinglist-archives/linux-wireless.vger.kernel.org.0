Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7CD96516
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfHTPsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:48:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38242 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHTPsY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:48:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D9AE460A42; Tue, 20 Aug 2019 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316103;
        bh=BQOxAJWEwv/+lJGNNEzpL/DW1XfPlje21JN+L1cyVc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzFD4yBkIau4YLilrmaXK9bjsgUunDtKyG2n+EN8HK9baVEQzb8Zs/d9AWA2zEcHt
         dFJZEyh1n9fPGu+4FZyBiiBki22MhHNTi9lrSC1ZzoEBv23+5eVEjwsqd6ZnCGnxk3
         QVV/Uf7IbEs9qE6586INvVmu3uOCBxNrNdmDjK0M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63D04611FD;
        Tue, 20 Aug 2019 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316101;
        bh=BQOxAJWEwv/+lJGNNEzpL/DW1XfPlje21JN+L1cyVc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmJmFsJcneqQg+ZxIvM9NEusxqtdJ5IctowWGlK8l8HsmKHzcVXOBRA3o2BAFLjTh
         DA182RqgsoRTjJPNdFCw0sL/IZu7lY0ftFpAN1G5m6h5i3++iFMR/vfCOHdKpmIM/2
         zkONMda1lWAswNcrUgtvGFYGQyt+FSGfqOjFGwAY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63D04611FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 01/49] dt: bindings: net: add qcom,ath11k.txt
Date:   Tue, 20 Aug 2019 18:47:27 +0300
Message-Id: <1566316095-27507-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 .../bindings/net/wireless/qcom,ath11k.txt          | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt
new file mode 100644
index 000000000000..1824238b4b50
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt
@@ -0,0 +1,127 @@
+* Qualcomm Technologies ath11k wireless devices
+
+Required properties:
+- compatible: Should be "qcom,ipq8074-wifi"
+
+AHB based ipq8074 uses most of the properties defined in this doc.
+
+Optional properties:
+- reg: Address and length of the register set for the device.
+- interrupts: List of interrupt lines. Must contain an entry
+	      for each entry in the interrupt-names property.
+- interrupt-names: Must include the entries for CE interrupt
+		   names ("ce0" to "ce11") and hw srng interrupt
+		   names.
+- qcom,rproc: DT entry of q6v5-wcss
+
+Example:
+
+wifi0: wifi@c000000 {
+	compatible = "qcom,ipq8074-wifi";
+	reg = <0xc000000 0x2000000>;
+	interrupts = <0 320 1>,
+		     <0 319 1>,
+		     <0 318 1>,
+		     <0 317 1>,
+		     <0 316 1>,
+		     <0 315 1>,
+		     <0 314 1>,
+		     <0 311 1>,
+		     <0 310 1>,
+		     <0 411 1>,
+		     <0 410 1>,
+		     <0 40 1>,
+		     <0 39 1>,
+		     <0 302 1>,
+		     <0 301 1>,
+		     <0 37 1>,
+		     <0 36 1>,
+		     <0 296 1>,
+		     <0 295 1>,
+		     <0 294 1>,
+		     <0 293 1>,
+		     <0 292 1>,
+		     <0 291 1>,
+		     <0 290 1>,
+		     <0 289 1>,
+		     <0 288 1>,
+		     <0 239 1>,
+		     <0 236 1>,
+		     <0 235 1>,
+		     <0 234 1>,
+		     <0 233 1>,
+		     <0 232 1>,
+		     <0 231 1>,
+		     <0 230 1>,
+		     <0 229 1>,
+		     <0 228 1>,
+		     <0 224 1>,
+		     <0 223 1>,
+		     <0 203 1>,
+		     <0 183 1>,
+		     <0 180 1>,
+		     <0 179 1>,
+		     <0 178 1>,
+		     <0 177 1>,
+		     <0 176 1>,
+		     <0 163 1>,
+		     <0 162 1>,
+		     <0 160 1>,
+		     <0 159 1>,
+		     <0 158 1>,
+		     <0 157 1>,
+		     <0 156 1>;
+	interrupt-names = "misc-pulse1",
+			  "misc-latch",
+			  "sw-exception",
+			  "watchdog",
+			  "ce0",
+			  "ce1",
+			  "ce2",
+			  "ce3",
+			  "ce4",
+			  "ce5",
+			  "ce6",
+			  "ce7",
+			  "ce8",
+			  "ce9",
+			  "ce10",
+			  "ce11",
+			  "host2wbm-desc-feed",
+			  "host2reo-re-injection",
+			  "host2reo-command",
+			  "host2rxdma-monitor-ring3",
+			  "host2rxdma-monitor-ring2",
+			  "host2rxdma-monitor-ring1",
+			  "reo2ost-exception",
+			  "wbm2host-rx-release",
+			  "reo2host-status",
+			  "reo2host-destination-ring4",
+			  "reo2host-destination-ring3",
+			  "reo2host-destination-ring2",
+			  "reo2host-destination-ring1",
+			  "rxdma2host-monitor-destination-mac3",
+			  "rxdma2host-monitor-destination-mac2",
+			  "rxdma2host-monitor-destination-mac1",
+			  "ppdu-end-interrupts-mac3",
+			  "ppdu-end-interrupts-mac2",
+			  "ppdu-end-interrupts-mac1",
+			  "rxdma2host-monitor-status-ring-mac3",
+			  "rxdma2host-monitor-status-ring-mac2",
+			  "rxdma2host-monitor-status-ring-mac1",
+			  "host2rxdma-host-buf-ring-mac3",
+			  "host2rxdma-host-buf-ring-mac2",
+			  "host2rxdma-host-buf-ring-mac1",
+			  "rxdma2host-destination-ring-mac3",
+			  "rxdma2host-destination-ring-mac2",
+			  "rxdma2host-destination-ring-mac1",
+			  "host2tcl-input-ring4",
+			  "host2tcl-input-ring3",
+			  "host2tcl-input-ring2",
+			  "host2tcl-input-ring1",
+			  "wbm2host-tx-completions-ring3",
+			  "wbm2host-tx-completions-ring2",
+			  "wbm2host-tx-completions-ring1",
+			  "tcl2host-status-ring";
+	qcom,rproc = <&qcom_q6v5_wcss>;
+};

