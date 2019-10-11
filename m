Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 146D6D4798
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfJKS22 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 14:28:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42509 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJKS2W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 14:28:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so1140520pgi.9
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2019 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oCcxD88VFm1cXltnKInhOC0dvYbRf3OZje5KuISZ28=;
        b=DmSSa+o/fbCnmcSE8r3LLdGEcw4nF+cZDPt6n9Uav/Mh/6eUQUBdpUuOVjFil99enF
         yW+l+bqqnjB2LexYRbSpMwtzwWFE8E9D/KnGVyNJulBfAtHABiiSDzWBGbr2X/OK+XT8
         L9Hviw5kazL60EJ6JyhVmA3PsPTO5Un7UcOuq97b7+LwEoOnaInyOvbl78GA8DDCEIu4
         pKdxSQq3K3wzCSHxveT1nB+mV+iSi/AR5oKe8Z4vigMNNzWYy96byVbfG3DpQQRkesij
         1jl1r0OfXGl8OxMN96Wtp706aglMlW6IEQw6UURw+hIsGYJAX+wP3AqwzZkaV0dSvvrt
         Iz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oCcxD88VFm1cXltnKInhOC0dvYbRf3OZje5KuISZ28=;
        b=OI6NjId19P0xscBQet1TEb2abVS8v4HVMRu+JSVnvUbWv3wjSwHM3QQz+LBQy6dCIE
         8r0Q5lMvazlnaJ5NJSNvKFLnLEFz3KrjfC7IGG6j6QVb0HtG2aj2VLo+Ahk1yCuCtap7
         fIn+oP05QqVzDmP8mT7eZC1l1pyBfGhUOhpEEX7yGcI+coTOgY5l4flUpJJ5DPOZd2Q4
         fvfAq3SyqDyOY6YhhRCpbGJI8xjBQaNFfRTOfJxlGVSQA/9OWg3qzeM660BclM5pN9Yr
         o/CyCwQZI9KiohD8JZz8hpRxTaBNdsknYUS9xYVpr6FTJK1Xjzj/iqL+2GVaES3WdoWo
         Lieg==
X-Gm-Message-State: APjAAAXoGuJavJpWgcH4IjidNJUOvpLf4dKbbbqezqDWefRFjit1BV4S
        F2K5Uu6EZ1VYKyi7tnl8R35Tiw==
X-Google-Smtp-Source: APXvYqw0pkpNYcFqFnQAxe70uYZ67hQnflJjxtKuMR2lnBw5aheockxkUpH2gAVY12yHDaYAukkmnw==
X-Received: by 2002:a17:90b:288:: with SMTP id az8mr19023217pjb.18.1570818501530;
        Fri, 11 Oct 2019 11:28:21 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a11sm8652343pfo.165.2019.10.11.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 11:28:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v2] ath10k: Correct error handling of dma_map_single()
Date:   Fri, 11 Oct 2019 11:28:17 -0700
Message-Id: <20191011182817.194565-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010162653.141303-1-bjorn.andersson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The return value of dma_map_single() should be checked for errors using
dma_mapping_error() and the skb has been dequeued so it needs to be
freed.

Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Free the dequeued skb

 drivers/net/wireless/ath/ath10k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3d2c8fcba952..e8bdb2ba9b18 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3904,8 +3904,10 @@ void ath10k_mgmt_over_wmi_tx_work(struct work_struct *work)
 			     ar->running_fw->fw_file.fw_features)) {
 			paddr = dma_map_single(ar->dev, skb->data,
 					       skb->len, DMA_TO_DEVICE);
-			if (!paddr)
+			if (dma_mapping_error(ar->dev, paddr)) {
+				ieee80211_free_txskb(ar->hw, skb);
 				continue;
+			}
 			ret = ath10k_wmi_mgmt_tx_send(ar, skb, paddr);
 			if (ret) {
 				ath10k_warn(ar, "failed to transmit management frame by ref via WMI: %d\n",
-- 
2.23.0

