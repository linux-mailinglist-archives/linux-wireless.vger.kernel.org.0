Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9612919E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 06:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfLWFta (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 00:49:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42933 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfLWFta (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 00:49:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so8624230pfz.9
        for <linux-wireless@vger.kernel.org>; Sun, 22 Dec 2019 21:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iumy1PBiJpZgzq+fMy5WNqZile1hZxg6rvR6lEmVeXg=;
        b=bdRC6gCocAk80rA1xbTl2p/ncFNdXB1ojFpp0JkL3K/81G3P//yEdsNnpzsTtfZsPf
         3YyU0Nsh/r9PJjv/AzfM7A3D+yYzf5u0BxlxQ8gLYhOzCR+5VkfCh4dpELTXWloWB/RZ
         xEw0nYFKEpzJ74Bqfh6KuIgaKyMMaJYH0WK27MRXLAYw4BAb1VbRbLchJ7aPwqqONQ/U
         4HpP293tKl5NmXsZtEcnpb1w7oE44FZg/+73qGoUtANehnUuY+ZPs641yIhmRZ9Mp8Pe
         sVNmmOF0zrhyeQms2fuNTit47iQhqaP6Ss5h4Frxw+5ND9NlufPH9VSoFHeBSr2i2miZ
         HtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iumy1PBiJpZgzq+fMy5WNqZile1hZxg6rvR6lEmVeXg=;
        b=NVGnNMeu6qG8v3I20Vh41kVny3ENyou9AuUANAmA6Wf976TtDyYk9GiX6Wi37zHYTf
         A+YvHVdMwsL3ItMmZZmjiWFIpPoeG/HvaV7Ypcf1eGTvKScoJsdJjHmY2RQ8s949lkmm
         nI9Fk/DkDe5sYJevM7pHCgXNLker9SAcLOtXF5fqW6j8jN4OqOdGXcs5DoT3bQFnsh41
         hy9ACXd7I7VnxvkM8TYeXPUmSY4kj8gRkoLlxYbcVmnkyQuPQ10j6ReXqLvL/GecM03T
         uMGBAr0+p7Esrlmgo9KsKrms2ZK9TzJZ+bAMZ5EXfAEiOepbRqK3CRsgY2nRIkQzq5GH
         VIsw==
X-Gm-Message-State: APjAAAUKMcLCsIJRRf9MeVlzpngn1MA1QXGIc5qVO4t/C8c2Ku9xY//y
        /JDipEyZnLtDKBsggnHse9yK+Q==
X-Google-Smtp-Source: APXvYqzEhqEiHcIOvRTWeex5QbVNVUAfTErekI8OsTPZn9rtRwW9Q326fkVGONQjLmBd3RETwbCgWQ==
X-Received: by 2002:a63:d94b:: with SMTP id e11mr29475446pgj.79.1577080169416;
        Sun, 22 Dec 2019 21:49:29 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l14sm19731779pgt.42.2019.12.22.21.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 21:49:28 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Gross <agross@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: [PATCH 1/2] ath10k: Add optional qdss clk
Date:   Sun, 22 Dec 2019 21:48:54 -0800
Message-Id: <20191223054855.3020665-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
References: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The WiFi firmware found on sm8150 requires that the QDSS clock is
ticking in order to operate, so add an optional clock to the binding to
allow this to be specified in the sm8150 dts and add the clock to the
list of clocks in the driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 2 +-
 drivers/net/wireless/ath/ath10k/snoc.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
index 017128394a3e..3fc2cce4626b 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
@@ -50,7 +50,7 @@ Optional properties:
           entry in clock-names.
 - clock-names: Should contain the clock names "wifi_wcss_cmd", "wifi_wcss_ref",
 	       "wifi_wcss_rtc" for "qcom,ipq4019-wifi" compatible target and
-	       "cxo_ref_clk_pin" for "qcom,wcn3990-wifi"
+	       "cxo_ref_clk_pin" and optionally "qdss" for "qcom,wcn3990-wifi"
 	       compatible target.
 - qcom,msi_addr: MSI interrupt address.
 - qcom,msi_base: Base value to add before writing MSI data into
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 7e85c4916e7f..aeb4cca92c35 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -46,7 +46,7 @@ static const char * const ath10k_regulators[] = {
 };
 
 static const char * const ath10k_clocks[] = {
-	"cxo_ref_clk_pin",
+	"cxo_ref_clk_pin", "qdss",
 };
 
 static void ath10k_snoc_htc_tx_cb(struct ath10k_ce_pipe *ce_state);
-- 
2.24.0

