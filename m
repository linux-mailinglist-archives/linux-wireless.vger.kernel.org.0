Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4F444503
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhKCP6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 11:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhKCP6g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 11:58:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43639C061203
        for <linux-wireless@vger.kernel.org>; Wed,  3 Nov 2021 08:56:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so1727188pjf.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Nov 2021 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wB6L2zhgIZw3VuMIvl+9jSRccRbfwY9247FkYpdL0aY=;
        b=dW56jnmgDtqynIU5Q+4TgJNOK5/NMDKboPX1MmaRr6TIPGKKMuTORRHVd+eKO+gb1J
         F9CjXz01U3+wl3H2VbwpaCRDn4ueAv46ELOXnvjHif0wov09YHb+xvJrjcQLfbP0aY4G
         KvSDnOftdKvwJ8dakI0KNrEwnWLpHoBXzlNvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wB6L2zhgIZw3VuMIvl+9jSRccRbfwY9247FkYpdL0aY=;
        b=rwanWVKgH1puwKxTf8lcsyTEWSxqF8ij5ChaEx4wVnMIDzU2cQOkl/GrGNX5a/IDlY
         qP2lgUfh7kc2nBSsRhZZVmUSU1nB7TXIHAtVH4EVnCQDoXCuK0q+yKU2As2QX1Pn3Tax
         zm2TF6x91YwjvPpu3ryEzSOuZIAkOmEj1dJ0nPVRCsYz2GKgI/g0pH8OxSZNJZpd7vhk
         HsVeuWomV5iqGnWcCUAAPNMqXLjfkeriJpWJKOUi1+WqpcNFWyJ261UVKDzFZ1xrswZ0
         wqOkLs+CPqnem2WFoVICBTYYzvfFYsCz9tyBN48nulYhJ9BafRqLa0ABeTZ8adxng8uq
         bO2Q==
X-Gm-Message-State: AOAM532wVvRy2rRTI8vy3+pG/jeZdm82I8qV3z9wgdClTR3Z+iWU153o
        0rXlI/VoKFFoZg9YsMMwECSNzw==
X-Google-Smtp-Source: ABdhPJwJHBwZvky/2hhePb9Q/bclZzLHICNSu13XZlb7MrPyS8HuhRjfaZtItq8TjUEpDSH9B5Errg==
X-Received: by 2002:a17:902:654d:b0:141:7df3:b94 with SMTP id d13-20020a170902654d00b001417df30b94mr38998695pln.60.1635954959352;
        Wed, 03 Nov 2021 08:55:59 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:d401:aa7a:1484:c7d0:ae82])
        by smtp.gmail.com with ESMTPSA id x17sm2742679pfa.209.2021.11.03.08.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:55:58 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] wcn36xx: populate band before determining rate on RX
Date:   Wed,  3 Nov 2021 08:55:40 -0700
Message-Id: <20211103155543.1037604-1-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2:
Fix unused variable warning.

Benjamin Li (2):
  wcn36xx: populate band before determining rate on RX
  wcn36xx: fix RX BD rate mapping for 5GHz legacy rates

 drivers/net/wireless/ath/wcn36xx/txrx.c | 42 ++++++++++++-------------
 1 file changed, 20 insertions(+), 22 deletions(-)

-- 
2.25.1

