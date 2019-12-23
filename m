Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457B012919B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 06:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfLWFt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 00:49:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36506 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLWFt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 00:49:28 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so6993821pjb.1
        for <linux-wireless@vger.kernel.org>; Sun, 22 Dec 2019 21:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XUacwVg6UtA8MchmvXuh03DJHAG9CnuImbIcloSG5k=;
        b=P+iJV5pbry18PLZyr669o+IPKh7QicKAILliFehkugV8ZOKOxqSVcVXCmVSgYN9xrj
         xPe/xyLltPJI0X9rQ5GMwIfto/S4RT67Q3m7djdZY1OI6uYLvGqoHUhK+AGCiiojEPLm
         zvsrB/SWV0NUhLbE2cPom+DB22t5tcs8k0dhTICX6mSFxKzyzMegfjldRBFkbD/PA23q
         /7U/8X+5JVjimI1Q24WalhGe91L1whzdSfg6ro0rNYPBfCCiKVfg6vC3RmjDE9Zhon/S
         TiNnGD7+dIqmKWYJuX7UXloGM21mecV56nSdh2yFlLZPDfGvWj+zzjQSW6+QbV0LY3dd
         afFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XUacwVg6UtA8MchmvXuh03DJHAG9CnuImbIcloSG5k=;
        b=aF1yI+ZKn+llpc/sY1uhfmLzKdOR4VPf+kluFMxgjBF5x33e9BbKDcBro517LX3NZj
         uKzmk2NnIDnBQhYJBNd/TH/EdND21sKHovV3OW9jOPawxl4DRNYumLWsknnnMHYOnqxh
         8QO1sbq52cJOToDlbdXyG2VkOnapAPWRBBt9wlHt97wf+L3hLhYbCUEE2jkR8KIuWFOL
         M+IRDCm+akE7OBE/lUcdyBwVBwqoI7vjuidhzXLubQeB+r4UEzrG2gFlXiw2BZLTpOK3
         Jy5Yrgz5sm+3eAzY/aVw4HBsknc5YHmnNk9zIQh01dcxZKo1QSqSdDyuKMH9Cm29xX2s
         Cdgw==
X-Gm-Message-State: APjAAAXAI09clQpsVThRwKV3N9NXI0V5VSHXe+YK1VNOJv7DQKBB5UZi
        xAOklzLN4sAS0kvkYh3Fpp9odw==
X-Google-Smtp-Source: APXvYqw+lXD6B//G6RmvqL6dzbQ+OHOTBYMX7tSL/CHI+FnUJbP04tPOj2vJTeE6aVXU6tCj3fxQmQ==
X-Received: by 2002:a17:90a:b392:: with SMTP id e18mr25820505pjr.118.1577080168070;
        Sun, 22 Dec 2019 21:49:28 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l14sm19731779pgt.42.2019.12.22.21.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 21:49:27 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ath10k@lists.infradead.org
Subject: [PATCH 0/2] ath10k: Enable QDSS clock on sm8150
Date:   Sun, 22 Dec 2019 21:48:53 -0800
Message-Id: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On SM8150 the WiFi firmware depends on the QDSS clock ticking, or the system
will reset due to an NoC error. So this adds an optional clock to the ath10k
binding and makes sure it's enabled while the WiFi firmware needs it.

Bjorn Andersson (2):
  ath10k: Add optional qdss clk
  arm64: dts: qcom: sm8150: Specify qdss clock for wifi

 .../devicetree/bindings/net/wireless/qcom,ath10k.txt          | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi                          | 4 ++--
 drivers/net/wireless/ath/ath10k/snoc.c                        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.24.0

