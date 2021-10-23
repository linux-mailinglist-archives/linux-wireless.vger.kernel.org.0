Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CECD438102
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 02:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJWAmY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 20:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJWAmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 20:42:23 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3962C061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:40:05 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y17so6048770ilb.9
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 17:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqVZHbAh38oedPXhnJ9UUlohxQ5MfFVRNe7r/oz6L5I=;
        b=LVoG3VFhDXYSABmY/tpUZryWuUEddgAIFf6D9jwBDTSLT1pWwpMUJ23PXEjyBk7Kno
         aLgTOKYGIQKtxjb1BKsvFlOjFQ+CUuPxMtTdTrXLHu7YbJnmBB+8Bt7hMQ2/Klull2RD
         UhVDlmh7IjqY/xs/7P1G8dZ9cMntmz70+Xpqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqVZHbAh38oedPXhnJ9UUlohxQ5MfFVRNe7r/oz6L5I=;
        b=VnoomRwfT5ue7NI0J/VfvH7vTmwQvOyBleuB7so2x0+e36U4/n6XoKCS1S+rFNn2hC
         vNVMv63Ja3W6XW4YUH5k6qbGaGuc1lNNfQJRWI+jJn9MqA3WPoi6+npKCXcaAXXwABd6
         YIOgnbqG5qZC7WiWDuj4X2ncVomzn31oEbR3P1htdP6RibbnhFhkWM6+dOvPLBYUwiuh
         yldoErS7M2EQ0Qapa26yWs3FHyyoCA4sGA3nU3T4S3y8cfYmIlLlQlDimR7Bw8CIDoGG
         b0YA8tcoO+7ORTsuuWzENV5dj2vj4247VZg7Lh9lbHAnXpd8t3rqsIaZpEfoJbcd9W2h
         ZNWw==
X-Gm-Message-State: AOAM532KLphlpSPDenR3gUX3KrPVpEmepFIQtZJFn15MXkGn2aXDl1TE
        0k16zn81+axenccY91rLk8lzQg==
X-Google-Smtp-Source: ABdhPJwRFlrU29LN0y8tvDBQAHaR7HGiI+pUX3vPvEeOxtIqaYSozAZ52Ny8BItI8rHWjDa9aQBrGA==
X-Received: by 2002:a05:6e02:1bae:: with SMTP id n14mr1949301ili.253.1634949605102;
        Fri, 22 Oct 2021 17:40:05 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id b3sm5075494ilc.36.2021.10.22.17.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 17:40:04 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Joseph Gates <jgates@squareup.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Eugene Krasnikov <k.eugene.e@gmail.com>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] wcn36xx: software scanning improvements
Date:   Fri, 22 Oct 2021 17:39:45 -0700
Message-Id: <20211023003949.3082900-1-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Less important now, given Loic's breakthrough with FW scan offload on
5GHz channels, but downstream does do software scanning so these fixes
for that path may still be valuable to someone.

Benjamin Li (3):
  wcn36xx: add debug prints for sw_scan start/complete
  wcn36xx: implement flush op to speed up connected scan
  wcn36xx: ensure pairing of init_scan/finish_scan and
    start_scan/end_scan

 drivers/net/wireless/ath/wcn36xx/dxe.c     | 47 +++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/dxe.h     |  1 +
 drivers/net/wireless/ath/wcn36xx/main.c    | 49 ++++++++++++++++++----
 drivers/net/wireless/ath/wcn36xx/smd.c     |  4 ++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 5 files changed, 95 insertions(+), 7 deletions(-)

-- 
2.25.1

