Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F53C34EC6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2019 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFDR3O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 13:29:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40555 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfFDR3O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 13:29:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so10745337pgm.7
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2019 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFo+Cml7JxiPey2gwmiRmH8tPb+Deo/oS3silL2yxZc=;
        b=N61bh+x1YFfCBev/Zwkc8He+QGNTb342PZxDgzqdfz9pMS/l9YVL+XY0gFYs3oRDyZ
         A6bL52tlZEUDZy84tZ7bum0Q7pjZD5prpeifOqyrLG+IZfhEYwlHCQiGEH6BU3ENg7OG
         VLk+qBj3oUYR83EEE3kuQjE3DYOoxVOAUM6H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFo+Cml7JxiPey2gwmiRmH8tPb+Deo/oS3silL2yxZc=;
        b=HDqKvdXfVG82KZy/s3vgmJZXu6e8IIn0Mj9/cYoQc7wRonF3WJCnYt1HebXC9YNQW5
         f4e1rSyIe9mEQiOKbUG5a7FkRPL96WPJZH01n9CvsgS4dQ41ui9zzaWjcvZJb2frQ8N2
         XB1dxdDPh2AvSsnIGVKtkUJSbxKVsnHF73cNLAiCAnc/DGaPkVgKPM6BjXUMTrOgpBwd
         z2dYFdlGJjgc3BI0EZctZmUzyhqsCjshzm89LRTrycq1fqv3dypzQ1AkeaaftI77tLth
         OAFEi7Sk9OCxhlGdltOpEip2GIZRWrwd0bkQDILTMQ30Zc2ID1ajKK3sEXZtD009OiiW
         MUtA==
X-Gm-Message-State: APjAAAUCrCrciXfq4wGSMsRb876rpAVygook8SOMw1XDAFxUXWZp3dr5
        No5bC2R9ZKLjkmG1CZgLLhKttg==
X-Google-Smtp-Source: APXvYqxa24wA9trv1+kh6Te7TMdbEl07eQtif4EI2omG8tMZ2UdPcthS6IFtPY7g6ruYWoJUIQ7Aeg==
X-Received: by 2002:a17:90a:8584:: with SMTP id m4mr38051966pjn.125.1559669353526;
        Tue, 04 Jun 2019 10:29:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id k3sm16185351pju.27.2019.06.04.10.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:29:12 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: drop 'set_consistent_dma_mask' log message
Date:   Tue,  4 Jun 2019 10:29:10 -0700
Message-Id: <20190604172910.107199-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This message is pointless.

While we're at it, include the error code in the error message, which is
not pointless.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 3fe81b2a929a..82f58bf0fc43 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2924,10 +2924,9 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 
 	pci_set_master(pdev);
 
-	pr_notice("try set_consistent_dma_mask(32)\n");
 	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (ret) {
-		pr_err("set_dma_mask(32) failed\n");
+		pr_err("set_dma_mask(32) failed: %d\n", ret);
 		goto err_set_dma_mask;
 	}
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

