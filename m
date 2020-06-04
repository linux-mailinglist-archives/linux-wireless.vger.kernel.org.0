Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61B61EDA33
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 02:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgFDA5l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 20:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgFDA5l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 20:57:41 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC952C03E96D
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 17:57:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g7so2369079oti.13
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1G7Igc4gifoUST0s04WvC0IkeRmMJVuYlbJNUF4ASk=;
        b=hV3emYyRx5U6nbcFY3EojfztcdAn376bDUAUeCagjhogI/KH0XLzALQ2VPaGue6jC9
         Jj8avmCdhM4fc2cgCYGiGaXh2DDWM10U5NuVuq4AeqmYgYKgEY3CiliOmx8m6bI6XpVK
         LhMHo6m/6xrm0Vv+jfDcpLn2ZS9srenpWcWgTlmqr0/BF+GPqIDZKenRTdBIOY2hvtqQ
         dUnvegZyefpsY/bb4hGshQ4uB+J3gcV8j0DNeVVqHB3CjUNRS6bgnfXUXbq4flpFTDMT
         kinO4nmH5BLx2GfftP/jiqPc+CHrAA1ZAKn5enfpiLRsjbzFgGfRjjNq5dNxv6ReOtwE
         qX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L1G7Igc4gifoUST0s04WvC0IkeRmMJVuYlbJNUF4ASk=;
        b=LotbKGXyDCjWoeH+OYO6n0/1S6hx6fReReXTaeC/GzfO5WeUMKH4NsGUzHzQkmgQXo
         vddZHFp7hmbAaMTlWJjzqy462HglQPNaatgmOMZPG6MCq6k9iKq0Cxamp3qWY210Zl+x
         8Kqy8fuV207oaPrLyyYSfI/YADpzNLQqDOKrfRxKJBYIYYp6Q98oWKtuFjtXMqIXkFPc
         C+lTPsRzrSXGO0xC/pbUFdtjDxo+uRxtPk6GBcbzREVyb4WMuDZtQD66O0rz4F6iILyw
         V3Gk106PjVxo3Uf9b7ijfU6EKmouit72lP7gqJQK4RwMycOxxEYjpTO996e6mTO/36AJ
         pjJQ==
X-Gm-Message-State: AOAM5314tvfOWAdhrVMyoIiJHObnldrxeUTrSurF1m5IDi7oVzm+rumh
        4dByHQkFNNoa1DOgW8K4ELni7BN8
X-Google-Smtp-Source: ABdhPJxH1+zYnjOm67kGA/pp+q0XZj8xgON3k8jF47KixaoKXjU54yS9Py3Yu4xxv3GrG8zbIAH1hA==
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr2026949otc.92.1591232260346;
        Wed, 03 Jun 2020 17:57:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id u80sm1011300oia.5.2020.06.03.17.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 17:57:39 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/2] rtlwifi: Fix some Sparse warnings concerning endianess
Date:   Wed,  3 Jun 2020 19:57:31 -0500
Message-Id: <20200604005733.7905-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While investating an unrelated Sparse issue, some endian-related issues
were found in rtlwifi. Although it is unlikely that this hardware will
ever be mated to a big-endian host, the issues need to be corrected.

These issues do not cause incorrect code to be generated on little-endian
hosts, thus there is no urgency in their implementation.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (2):
  rtlwifi: Fix endian issue in ps.c
  rtlwifi: rtl8188ee: Fix endian issue

 drivers/net/wireless/realtek/rtlwifi/ps.c            | 12 ++++++------
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.26.2

