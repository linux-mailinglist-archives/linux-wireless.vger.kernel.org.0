Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667583A3674
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 23:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFJVrw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 17:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231342AbhFJVrk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 17:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623361543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sg0e7jXQsTWhtJdkPVNcldGSCJQVzZfo88rGKEyxbVM=;
        b=jF0km8g4p89mBhncdGbC1/Vg5ETEzZF00pe+w/WdilVR7Ux17nxM3V3BO//XUmDMZQUg2H
        22p8+VrTeI3qjV/ffpXIy8nIt1CG8s0Kw2UrVS7x35vHgfDwkC4I1sk8vnMbah81ugmy7X
        S8n0kWWgQlxIG3COtd67pFg2iRtKcAA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-pXFaQnYYNhKnv8y2h04IqQ-1; Thu, 10 Jun 2021 17:45:42 -0400
X-MC-Unique: pXFaQnYYNhKnv8y2h04IqQ-1
Received: by mail-oi1-f198.google.com with SMTP id j1-20020aca65410000b02901f1d632e208so1892784oiw.16
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 14:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sg0e7jXQsTWhtJdkPVNcldGSCJQVzZfo88rGKEyxbVM=;
        b=kO2n7rBc1nf4GXfrCGjV3VvSCswUNuByRh2OxnBQEsmYZX2hyChY238D3FgssuNlQg
         wBKE/RrB/BFX51LeUoIa4S+Fg9bPbySkjoDSQLsmVhH7knNDSLFF0jXakNrjIBqj9cZ+
         IdDYF7RBjgG2EQj8u7d0C0lbFC83LMinUHrKIr2VqdUMnf/S3FvZX/Rkf+vZbUUTbtSg
         AQDJc+45LntUuj9k9D3hby9U375qCXRC8a1MPPv1PKTE5RTqp+lGkKbUYOveIr8pHEbs
         vdkfkHhJE8FxJ/fN6emOSDfpploGM8IxEQf1cdN7yEJzatqTZ/vsD86pfD1KKwsIbmYX
         CPXg==
X-Gm-Message-State: AOAM533Fhkn/8Ra81UDFkUdFU4c6YG5sFCRHxjAr6sgQQyG9jIr+2gUz
        Zh04REeNJ86VDt5DS7zeaNbVtv6xKR/TFw5WcpAMcl5lrheqhSuRFtmhg8RLbDCaEIb89/ryj+X
        J/2Xnnr4m5WRX/xRk5hbaKtWx/Qs=
X-Received: by 2002:a9d:6087:: with SMTP id m7mr370787otj.318.1623361541284;
        Thu, 10 Jun 2021 14:45:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXb9l1V2GdEF4zDsZ9LozrWKOCTW8y6roYjcLTL2ZDJoW3I+XShj/h6JSCX5VGU9bVCgQ4yA==
X-Received: by 2002:a9d:6087:: with SMTP id m7mr370744otj.318.1623361541117;
        Thu, 10 Jun 2021 14:45:41 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i15sm881839ots.39.2021.06.10.14.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:45:40 -0700 (PDT)
From:   trix@redhat.com
To:     robh+dt@kernel.org, tsbogend@alpha.franken.de, jic23@kernel.org,
        lars@metafoo.de, tomas.winkler@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, nbd@nbd.name,
        lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        matthias.bgg@gmail.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        zhangqing@loongson.cn, jbhayana@google.com, sean.wang@mediatek.com,
        shayne.chen@mediatek.com, Soul.Huang@mediatek.com,
        shorne@gmail.com, gsomlo@gmail.com,
        pczarnecki@internships.antmicro.com, mholenko@antmicro.com,
        davidgow@google.com
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, Tom Rix <trix@redhat.com>
Subject: [PATCH 3/7] drivers/soc/litex: fix spelling of SPDX tag
Date:   Thu, 10 Jun 2021 14:44:34 -0700
Message-Id: <20210610214438.3161140-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610214438.3161140-1-trix@redhat.com>
References: <20210610214438.3161140-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch looks for SPDX-License-Identifier.
So change the '_' to '-'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/litex/Kconfig  | 2 +-
 drivers/soc/litex/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
index e7011d665b151..c03b1f816cc08 100644
--- a/drivers/soc/litex/Kconfig
+++ b/drivers/soc/litex/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License_Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0
 
 menu "Enable LiteX SoC Builder specific drivers"
 
diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
index 98ff7325b1c07..aeae1f4165a70 100644
--- a/drivers/soc/litex/Makefile
+++ b/drivers/soc/litex/Makefile
@@ -1,3 +1,3 @@
-# SPDX-License_Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_LITEX_SOC_CONTROLLER)	+= litex_soc_ctrl.o
-- 
2.26.3

