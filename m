Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9096A3A366E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 23:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhFJVrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 17:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231200AbhFJVrb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 17:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623361534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSv9PvVn6D8P1hr2HASl5EPE56aRrWalXa3WhtLcjzQ=;
        b=cU6yn79nOFJPuuLOo17nWSv7pPg7YWom4odjPVqIEj/gg1lOVlJLF4H+N1oOL1hzMBEzl2
        Pu/Z80Nb7O0Iaz+plLnMR6K1ZJsniglTk5lhNuyt7dQBKUyUynNRKnVKDQeVd1R9VvmbeB
        9hzRZloFAtGxuJuVaM19uxGBN56OMsA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-iaNN9FoEOoSA3C5HM6aOfQ-1; Thu, 10 Jun 2021 17:45:33 -0400
X-MC-Unique: iaNN9FoEOoSA3C5HM6aOfQ-1
Received: by mail-ot1-f71.google.com with SMTP id 59-20020a9d0dc10000b02902a57e382ca1so670887ots.7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 14:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSv9PvVn6D8P1hr2HASl5EPE56aRrWalXa3WhtLcjzQ=;
        b=SPskN9209HQ0K6cfdniWaSnwqCs8gC/dZzpe++SojajVaO6zOCurcL6FOUawxPFhNY
         3E4eTI2B/sbTJou0Q5K0aYoNaBAPszMy/Ar1lJI7FowgxZq1rrxtnS53f+F4jknYxLCG
         jspXoXcIdjhe7sDbZFIRazFiL85PIcmFU0YwefCJuir6vf3guqJl/23J1nXeW6NK3ddD
         M+hND6cS7aV0z1Ujqr32xXfjCCVg8sQc0vBEKvzciubSWLuFLflgvH/gl+YqUlqyn4QU
         ANo54/g0RLSHHE0Sj7t9WYrn6LDDnqjG5Ne0DoPh9i/QEvDSKJy2ZbDVtBRpkvWrxjdF
         uHEw==
X-Gm-Message-State: AOAM531xFrhquRgCgkGtGCfaXvKhfZ3oTdOZsOUlDyH/FKCqMYuKLia+
        R/dmg5sYYCbdvcGy7xfIGMHb5x71n9+1AFRR82Vpi6K2tsvjAt76QJm05bPiPOHfj4uGdRyE7qo
        pntLFJ5utLJLaABR8avQOxoqEPzU=
X-Received: by 2002:aca:b506:: with SMTP id e6mr361769oif.178.1623361531507;
        Thu, 10 Jun 2021 14:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLkOYqEPHROAavZ+GqUoBa88evwWu8hew7OzFYwlCFApTMasrs2l9HZneVNx3WKlokSV6LKQ==
X-Received: by 2002:aca:b506:: with SMTP id e6mr361752oif.178.1623361531370;
        Thu, 10 Jun 2021 14:45:31 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i15sm881839ots.39.2021.06.10.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:45:31 -0700 (PDT)
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
Subject: [PATCH 2/7] mei: hdcp: SPDX tag should be the first line
Date:   Thu, 10 Jun 2021 14:44:33 -0700
Message-Id: <20210610214438.3161140-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610214438.3161140-1-trix@redhat.com>
References: <20210610214438.3161140-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

checkpatch looks for the tag on the first line.
So delete empty first line

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/mei/hdcp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
index 95b2d6d37f102..54e1c95269096 100644
--- a/drivers/misc/mei/hdcp/Kconfig
+++ b/drivers/misc/mei/hdcp/Kconfig
@@ -1,4 +1,3 @@
-
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2019, Intel Corporation. All rights reserved.
 #
-- 
2.26.3

