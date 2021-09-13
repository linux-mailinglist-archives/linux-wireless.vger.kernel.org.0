Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC186408E40
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhIMNaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:30:35 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57746
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240599AbhIMNWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:22:03 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C7E2140266
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539246;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=C9UVcbIUq3O4jN/3iHXwE6SSuKueuzAPU+yMYAhssYEWhd+HFJKX9NQCyZeGXBBm0
         i542P4TyYCPz9wzsaKw1+fcRKbXbNbDzmnsgaPX6BuyUYa8Hr+Bq+kRESdzohlzahQ
         zzqQAtkNcArCVaQEdKTWb0HvdE/bhhQ4fkEG1Su94IviI5ofwt3RNBlTGsY1kLN+Xm
         G5gh62mfmk1AcRG82xVUhZV+pb5cd7YldXe96TNdn8LBXR6zEx9Hf1f1lHL5gaY2hz
         oYRQK7bN1s9aoNeXAb7oNZeAXtUYB54cpWYSIe0NfD9ynDM9aPioGj45N93QuqxO9G
         +6TFKvJ63c5Fw==
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so1323644wrp.16
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf3U+DHYhMpuIl7nTJH6GPAYe+llXfLG7+wtuS7r1DY=;
        b=K9+VdU9IT5WMY/m/HstaLmVVVy75u/GBYOsFrjJEGBR24eOsaT0+dv7/9/7lcVULib
         lv9jEyQUEW16yef63V1QSOCk61cdmzdyPOrn8vVe+4cpb1EP4iWyIeUfjVOj8FFA3JeC
         zGJfiIwHj35HbdnERpnoQxXVpIdjKvUS3bJ6y8qX+5ddfwAYBnj8WQD9AHSkNRd5WLPS
         ABfXjaR/OPZ4zhWextLQPJsiJHxuHUdJEVqsia1M9Txb9gFloT4JBWf4fvwqpDk9rwuQ
         xAqAGsFY2edou5pCpeO+tAIyYUbj1baEnxYGdwrxCJ3cGqSw0kM0nYvX8D964oWXSdKN
         3FtQ==
X-Gm-Message-State: AOAM532raGbnMM+uxziD5lHbjmWDNdH77gkG5aO5T7mB0HU2EO3/Zr4N
        33kphLSEUbJeFvopGr/78IzbW4aubedm7ViJFvu1dyNGupjN9VBByZNbg1qt05O1g/Gzkyxhhsk
        k8wU2XDkjMW48uHwT1Jh3jp34IIdMMObUN1lJDovEiDTK
X-Received: by 2002:adf:f90f:: with SMTP id b15mr12528815wrr.364.1631539246423;
        Mon, 13 Sep 2021 06:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO4lsG5wdmhKIDutLLy9acqil5ZkWEOWZw6YwdcZcxBYqUrgu1dwPeeITR5yS7gtM6A2hFVg==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr12528787wrr.364.1631539246274;
        Mon, 13 Sep 2021 06:20:46 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 03/15] nfc: nci: replace GPLv2 boilerplate with SPDX
Date:   Mon, 13 Sep 2021 15:20:23 +0200
Message-Id: <20210913132035.242870-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
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

