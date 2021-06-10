Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFB53A3691
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFJVs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 17:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231322AbhFJVsC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 17:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623361565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EskfVdmEpVOex3IAfBnti5Wx89Q+wzN0Zpd/qsC+eCM=;
        b=gVHGJHnsN/wkoVH0BNzslrOltTWz1FSaXr4Sy5uHFzRYE7TkSQ6TmP9PpSwOaS2i9oRXgd
        t3lgLeHnSvr3d9mGulmMFWdIznywBOTJV3I8jPhuLpB30Uuetb8MzGuH3TRwzhRC6Is9zL
        emWdusV4f4GBEf8DZNDWBRR2JFJ/aIU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-upnA6OqOMKC0329TvKjGsw-1; Thu, 10 Jun 2021 17:46:04 -0400
X-MC-Unique: upnA6OqOMKC0329TvKjGsw-1
Received: by mail-ot1-f72.google.com with SMTP id l2-20020a0568301d62b0290401806fed24so678139oti.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 14:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EskfVdmEpVOex3IAfBnti5Wx89Q+wzN0Zpd/qsC+eCM=;
        b=qXfisKzZW2/rn/1LyC+qPZYaMErXUC3gG9VTM9O/VNDMHhUnvDiqTMiSPdI8JQBut+
         yLGVoAQfDnnC2d5QphNCA8Cij/79IGhrG2j1VYqjsASmBv+vNaxtHjlYWiKkdr4ogpNK
         OBe6mDA7EWnU7dlP52VuL7mimziZvxAOGOCxqyxesJMqdtdw1jYbCqCT9pJAJ2gjI8Qx
         h02faGI0KfFc1NW/b8lQ8vbFu7RSb5vsQ5fbWc/KdA3Wg5lFBLpqnWCPju2ggy9239oo
         UZYtxMuOBbX6oAG9bsa5BQp0wkeLIUMHWyNK/zzMQy/9ss/yrnvNJ3uiwTmSTToVCJHV
         RtEg==
X-Gm-Message-State: AOAM530lVFC/9Fj4EmXqClB+jb/1jIY3IAuS6kjUyxPBW0H7anA9R0tF
        e1YCFFDhAvBarf3fQsVVXW+y5At+o00wF5sHDHVX3chPvFo9bPNGAcyuX1H6dureNFMYdK0mWau
        P4KCtLYsXX7sS5hEAevlqiTO/Gkc=
X-Received: by 2002:a4a:b2ca:: with SMTP id l10mr508297ooo.30.1623361563881;
        Thu, 10 Jun 2021 14:46:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7SVUzlSK/f1fDrHG5iNpljzriPnaeQkhfspBLGN6ijrDdm2MtUq40WVdJ5HgW0VGYiWYtFg==
X-Received: by 2002:a4a:b2ca:: with SMTP id l10mr508277ooo.30.1623361563723;
        Thu, 10 Jun 2021 14:46:03 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i15sm881839ots.39.2021.06.10.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:46:03 -0700 (PDT)
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
Subject: [PATCH 6/7] mt76: add a space between comment char and SPDX tag
Date:   Thu, 10 Jun 2021 14:44:37 -0700
Message-Id: <20210610214438.3161140-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610214438.3161140-1-trix@redhat.com>
References: <20210610214438.3161140-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch expects a space between '#' and 'SPDX...'
Add a space.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/Makefile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index e8fc4a7ae9bc2..83f9861ff5226 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -1,4 +1,4 @@
-#SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: ISC
 
 obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
index 40c8061787e94..80e49244348e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
@@ -1,4 +1,4 @@
-#SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: ISC
 
 obj-$(CONFIG_MT7915E) += mt7915e.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index e531666f9fb43..0ebb59966a083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -1,4 +1,4 @@
-#SPDX-License-Identifier: ISC
+# SPDX-License-Identifier: ISC
 
 obj-$(CONFIG_MT7921E) += mt7921e.o
 
-- 
2.26.3

