Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0D33825C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Mar 2021 01:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCLAcg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Mar 2021 19:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhCLAcQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Mar 2021 19:32:16 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F49C061761
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 16:32:16 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so557766otf.12
        for <linux-wireless@vger.kernel.org>; Thu, 11 Mar 2021 16:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isIJ1maemEvfOxt679u3GZk6zqUs0JdaNZTH1YsiYK4=;
        b=YICE8gIFE1rd8aHBxZPzOdPTUNe8SYeUQZ6INqHnhetQONW09v0FLQoJdKUMAf0sGF
         udcFpqMrGNrEWO2RSaH0CEBu+0gOVtC18AlxHX9ePsqZRbJnjM051fbT1IdvnhT7sX+P
         yp20Qt2f5FawiBFXzcHbdiyWDruxP0ZDvuV8hjHP9kDyYOsbtzaYRAWgTIkpURE8Kan+
         nqVW0A4ZoMPP8FtwoMmu60CnhN4SgfYePTLNMvdNPi3oojFyU3M7Nim6LDfuBbrdOosO
         idr9b8VzcYCw/iuEEqge96JiR6nOcJVAaPpfb7+pmDwTwYS4+D2aXERIrvu6xdMNenao
         hZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isIJ1maemEvfOxt679u3GZk6zqUs0JdaNZTH1YsiYK4=;
        b=h2qxervnlz2QYHY3XPKvAihGPH5jA/WMjkbj+8WmMlKa6QKgZvHaJc6L6FHDKEoGeo
         KpRXmCqlFvyLlmOYPaBeOuyYZK+Yuuw6W7GTBbtGjCA4T7dI8Sa8wKafclXd9qO37/tT
         Ka9/fTRPWGp8TBNCQ2iEpdnPLRrHLrpsVCnf0zFcA0hP/mT0VPQ7t2HAGrUxGQnDt0yf
         4f7yVsCogYVwxZP7eLP7AiubsX83YXX6AtOgbydBEknZDrfLj2mkFkET+8FzLr7cehvN
         ZIPrYN/n1oapFSrmLSb7q1zXu9PJSZRa39S2wklus6ZrR+zUd/1VhsrOpeJWeBXq7tR9
         9nOQ==
X-Gm-Message-State: AOAM530pBKaUDis2OayO13hawLILbXInYJxXwVxuq2iEaUwC2OiZC+Nv
        JqfZ6Dc6Lt+io4TFd1/5ne40mQ==
X-Google-Smtp-Source: ABdhPJw6wYPH6HVdOaZ7Utjo3z2uqPRCd3muxY5zNCJbEJqOuv/ktIC4UeHTldx+mXF50YGuIPm1+g==
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr872436otr.341.1615509135652;
        Thu, 11 Mar 2021 16:32:15 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l190sm670835oig.39.2021.03.11.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 16:32:15 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: soc: qcom: wcnss: Add firmware-name property
Date:   Thu, 11 Mar 2021 16:33:14 -0800
Message-Id: <20210312003318.3273536-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312003318.3273536-1-bjorn.andersson@linaro.org>
References: <20210312003318.3273536-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WCNSS needs firmware which differs between platforms, and possibly
boards. Add a new property "firmware-name" to allow the DT to specify
the platform/board specific path to this firmware file.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
index 042a2e4159bd..1382b64e1381 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
@@ -24,6 +24,13 @@ block and a BT, WiFi and FM radio block, all using SMD as command channels.
 		    "qcom,riva",
 		    "qcom,pronto"
 
+- firmware-name:
+	Usage: optional
+	Value type: <string>
+	Definition: specifies the relative firmware image path for the WLAN NV
+		    blob. Defaults to "wlan/prima/WCNSS_qcom_wlan_nv.bin" if
+		    not specified.
+
 = SUBNODES
 The subnodes of the wcnss node are optional and describe the individual blocks in
 the WCNSS.
-- 
2.29.2

