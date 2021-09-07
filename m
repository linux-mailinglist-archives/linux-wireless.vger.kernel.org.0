Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD4402860
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbhIGMTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:19:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33466
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344140AbhIGMTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:33 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA1F94079A
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017105;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nnymz8kp/mgzjScIEynJSLO0Mz2YcEfaFbhDyohlg4NxN8OWavup8s34wsYvdgt2+
         Sps/J7Upxp7riu4drfB6OlQ9kwBSRfv1vcMAC34509xEIQP/iIXsiOkOpZooL7VArD
         HOgmVq12UXlLzuv8bmtgbjWS4u4JvsVGkEhTtk33yWchKmOd53MjTAZoPMCqy/0MJX
         uTJMSQHAKzLaTBfMUoMGXJM4qfk9lWxSis1yxZb+GRjzQMlAXJq+uaF4I7Ta5JqG4I
         yyQAfDyorNATsnr2h4eNVIuoif7U9ZdVPQToTbUgRGs09JsFAHamlvtuk6VW+ryl3y
         hVs99MdtojFoA==
Received: by mail-wm1-f72.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso1029498wml.7
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        b=f7Mk6aTppfGfPWENWLa2cri2oZ0cTa/LJ+Z09asnXrfNSO5NbeXuYj1oROG6Mfj0zw
         ApXYn06l5g0FxrabRy09SpE9SHFmazmqO5Uwjk7zalb21dZa3vzRWO3p8eSJQwcI1u22
         2kFm97j2gMuQzyIEw72LWlX0g4Tdw9UF4PO/NgnYkSSsxLdJ0vL437wQkbluPes0zqnU
         iQTqDii+HGGC6gstbK4LVf6ihT0R24FwdI+wrtjmAtAOZrjM87DhNOMzMjRPWctdWQEI
         y1KmCVzaDqUdQTcjurrsNNsMBP3GD0qjbNf/8aHws6AjTVIVeazE0zrU2J5R0SkcEkFj
         zTpg==
X-Gm-Message-State: AOAM531wYGp2xdcL+w7s5FdJPMBTgIU20gBuFKA1Gf6k4aiOvI5UM5gU
        U+FZJfTSi9PwU1HWXFnlQhdxJ2OYI7zMF2zUF1Dnlui5ANmuNS8m96Q+3A9pto/YKUKv1sWSLxX
        3aTAGnqhKDc6WfXm+bVeL+LNpv2j6SDVeCj/BS4WtKCo+
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr3543983wmq.159.1631017105646;
        Tue, 07 Sep 2021 05:18:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGnITbLQyBPqv15Y5qGEl25iI8Aaoxxgo0CFdcBuZBhKAuVcx8mn1j6CPUzijO1vm85/0Uww==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr3543965wmq.159.1631017105503;
        Tue, 07 Sep 2021 05:18:25 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 03/15] nfc: nci: replace GPLv2 boilerplate with SPDX
Date:   Tue,  7 Sep 2021 14:18:04 +0200
Message-Id: <20210907121816.37750-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace standard GPLv2 only license text with SPDX tag.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/nci/uart.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 502e7a3f8948..65814dd72618 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015, Marvell International Ltd.
  *
- * This software file (the "File") is distributed by Marvell International
- * Ltd. under the terms of the GNU General Public License Version 2, June 1991
- * (the "License").  You may use, redistribute and/or modify this File in
- * accordance with the terms and conditions of the License, a copy of which
- * is available on the worldwide web at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
- *
- * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
- * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
- * this warranty disclaimer.
- */
-
-/* Inspired (hugely) by HCI LDISC implementation in Bluetooth.
+ * Inspired (hugely) by HCI LDISC implementation in Bluetooth.
  *
  *  Copyright (C) 2000-2001  Qualcomm Incorporated
  *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
-- 
2.30.2

