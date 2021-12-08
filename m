Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977A46CF92
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 09:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhLHJBQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 04:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhLHJBQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 04:01:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB7C061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 00:57:44 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 137so1516147pgg.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Dec 2021 00:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me9WYpu3noGP7R3Uc2V4qejvmKsuzQtp6WBHkL6JJ34=;
        b=a0P8vxp5qFAHEnKHmOGMQT6yYKt1f1YL0XbmxNtTF+S1sW523ENTwTLz4BgOnOyhna
         VeB1NKquPAcV4H/+yj9n0k90GyAYRgJWdWwxzUyno1sqpgJQrlxJmuxXUbVtJBvpYw71
         nEScK1bIAM7crMIJQRvRdhmUxvfNNS/cZzyHGEatuaG+sbDhw6ozH1UMv0m2Hy7C3LnV
         u6nH1nH9KB/9hhdg1h6oqkZ18n5iaNHiz4Zc5FxAMYvYmSZhwkUmOX5TecD8wMwb6pTD
         dPf9cf57dsBwutxmr5G3X/8GUsTzhVUuwxNKSSMfMSS0yF41SFLNcG3IUPbpTG4rgakR
         ba2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me9WYpu3noGP7R3Uc2V4qejvmKsuzQtp6WBHkL6JJ34=;
        b=XVTmIZNLG6HEyrsetl4IiKl/Jz/GKe82Gkv3nXTmTq55WB0MvWnVsTrkEUv+rU3AMR
         LtRwvuLlMRe5qaqL1k9rLYyKajy4i8dYSdL7VQ/q6YEaWJAkPkCkyte+3D68I+ag9mPj
         fNtLs+srY5+wGz07ntWjxPEP93GUKNbDaCOHaRlmg2mXfidUDtSW8UAoqGHZMRJo9+pz
         K3h6uNQWjJf2B5DEU/mtThon+RnmWzixg3K0gozKRHS32E1/jEi6XKwyjDqUL1XngZJB
         4Q6YNtq7u7ycb8b7wQRcLnlIC12GMXlc35515QZgb77rDnChXHX7zL3ngNV1NyrqsGOG
         WU/g==
X-Gm-Message-State: AOAM533xCeqa2grKb+wx3Brxm84iSZxLaJiHhLIPImJDrb6eLgrEBMsr
        wmj3eJTRtErDtEZfpuZrECkN
X-Google-Smtp-Source: ABdhPJzVkFfiD7oa8U3/B1Kv9DliwmeX3DMinwAptexT8/Vy4Y1y05AK4GkZo3aV3yxvCEC0A05hzw==
X-Received: by 2002:a62:82c1:0:b0:4ae:db0e:bae1 with SMTP id w184-20020a6282c1000000b004aedb0ebae1mr4473369pfd.47.1638953864414;
        Wed, 08 Dec 2021 00:57:44 -0800 (PST)
Received: from localhost.localdomain ([117.202.189.59])
        by smtp.gmail.com with ESMTPSA id oa17sm2055470pjb.37.2021.12.08.00.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:57:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/1] MHI fix for v5.16 - Take 2
Date:   Wed,  8 Dec 2021 14:27:34 +0530
Message-Id: <20211208085735.196394-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Greg,

Here is the final MHI fix for the v5.16 cycle. Kalle reported a regression with
ath11k stack due to 020d3b26c07a, and that's been affecting multiple WLAN
products like QCA6390 and WCN6855. The regression doesn't let the device to
resume from suspend and that has been due to a firmware bug. The device goes
to a bad MHI state during suspend and that can be seen in the MHI state during
resume. But that doesn't seem to affect the functionality of the device as it
continues to work fine if we allow it to resume.

Ideally, this should be fixed in the firmware but as like most of the products
out in market, getting a firmware fix for this issue not doable. So we have to
workaround for it in the MHI stack by allowing it to resume irrespective of the
MHI state.

Since the fix patch also touches ath11k stack, Kalle has given his Ack so that
the patch can be taken via mhi/char-misc tree.

Thanks,
Mani

Loic Poulain (1):
  bus: mhi: core: Add support for forced PM resume

 drivers/bus/mhi/core/pm.c             | 10 +++++++---
 drivers/bus/mhi/pci_generic.c         |  2 +-
 drivers/net/wireless/ath/ath11k/mhi.c |  6 +++++-
 include/linux/mhi.h                   |  3 ++-
 4 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.25.1

