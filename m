Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F7E2E275C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Dec 2020 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgLXN1n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Dec 2020 08:27:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgLXN1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Dec 2020 08:27:42 -0500
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ksQdw-0004hs-DC
        for linux-wireless@vger.kernel.org; Thu, 24 Dec 2020 13:27:00 +0000
Received: by mail-lf1-f72.google.com with SMTP id i21so1490276lfe.14
        for <linux-wireless@vger.kernel.org>; Thu, 24 Dec 2020 05:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=e4xgp6vB88we292tJAxVZLyu5Zd9cAPYEm3vxvac9t8=;
        b=r6L2CGbtC2th2cRPkzBPZ3xwF/e44WPzUBuiq9e5KnLgR+8tJpRikA9BuKBAxkP6UI
         h2ql7ZR4rCs8pg4QuxKLkjEi2X9R0/LIr1sNZf+VTd4byM/g9KyArKFQHnsAomKJSXYz
         1QPzVl+AWI2OEExJNg9xTmuSlFMsCPxNX3EN+0jRohRszGheWi7oteNhN6qovkeUQ94D
         91tH2RpaiUx1luKr6BS0RgilFbR3yTeHRygYRm/W08YiCE6BimMtCosZ85Q/ZKvcOJ06
         MRnjEDRBPNiv9Q2cEWHP9Qq1IR72HZ+KPDnMEJ3etBkekNZ9iqSRxv2Y4DpAsvPirvaq
         66Yw==
X-Gm-Message-State: AOAM530Ijsl4qij8j6UWwHfcV1UOYetxV3tLu16v97gjqww066PMPX1n
        RsBr3PQ/XewXVv1SCw3lkbMNm+7AM4Qn3Q324ztFXvEE9fJpjfnv1AHa3PXd8sHj6tfrvwWkoia
        4jT/6i2HmVeM2eySzp1DRvLu3egrmtojRdn5UYrCaxYznexpxwPN3ECABi1Ry
X-Received: by 2002:a19:8316:: with SMTP id f22mr13780102lfd.10.1608816419700;
        Thu, 24 Dec 2020 05:26:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwD9ypdnYcNz7oM44uRamuPm+qt+NL7wmz07Tk/v1s3MnEsvwGMmMb+R/NQ6FUjDI/wEghGsYLv5np7ml+Qi8I=
X-Received: by 2002:a19:8316:: with SMTP id f22mr13780098lfd.10.1608816419461;
 Thu, 24 Dec 2020 05:26:59 -0800 (PST)
MIME-Version: 1.0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 24 Dec 2020 21:26:48 +0800
Message-ID: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
Subject: 802.11ac AP mode support on Realtek 8821AE?
To:     Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ethan Hsieh <ethan.hsieh@canonical.com>,
        Hugh Chao <hugh.chao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ping-Ke,

We've found that when creating 5G AP on 8821AE, it's not on other
devices' wifi list.

Here's the steps I used to create an AP:
$ nmcli c add type wifi ifname wlp3s0 con-name hello autoconnect no ssid hello
$ nmcli c modify hello 802-11-wireless.mode ap ipv4.method shared
802-11-wireless.band a
$ nmcli connection up hello

If we change "802-11-wireless.band" to "bg", then the AP can be
scanned by other devices.
Does 8821AE have hardware capability to support 5G AP?

Kai-Heng
