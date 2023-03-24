Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70756C859C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 20:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCXTHr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 15:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCXTHp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 15:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552DB1ABCD
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679684812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m1e+oH63s8EilReY/6J1/4GgJ3Yip783LTwv8q9nidY=;
        b=X4GVWJrPUP7H58rDM/uvIswL6yH4xPikqC3Ti5T4DgQQNm57WvaB2eZpWgU+CjdGszDSWV
        Rnx6WcH8cFJfdrrqIEmLppYojo4r+6HhF14BrZ5D0eTjWRJDGwg0c61sFrom9DjxUHm4c9
        pJisvTGzYMeoQUaN6VRB0W7tdPrZbOw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-RShB7BLqP2KdOpDzz347Wg-1; Fri, 24 Mar 2023 15:06:51 -0400
X-MC-Unique: RShB7BLqP2KdOpDzz347Wg-1
Received: by mail-qv1-f71.google.com with SMTP id z14-20020a0cd78e000000b005adc8684170so1463761qvi.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 12:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679684810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1e+oH63s8EilReY/6J1/4GgJ3Yip783LTwv8q9nidY=;
        b=D73Ard1ZPCpPxgmFTaLxI4xGQKcegUIXNs/qXQfN5NSawvGY/drEjIVsFrbhA2oDd8
         srrfcEnVEEJN1AlbCCI6QkF0coSaKSrUvkq/5VDCcyZXDrFjYI1Mx8nxR0ddRi2KyzYC
         81XdjL3cLrPMeakFyf6COW0D685bdPVEdUGW2hrTvKnmm590ci1/UhUKzs7s2dmIeTzq
         x3f+sReB6ZAcj7jK3lKLQ3bwz2f0R3PQY9qXR4o5e/jRXEE4wjYvD7lEFfZWZivvu0Rd
         hEnUBqYBNQ9+phHmqDJiBETufLsLDM6wf8W5xxio1qhaOSv89so8E6mxnwBI2CP2yoAZ
         ApUg==
X-Gm-Message-State: AAQBX9c0MKL+4UthVDoCDsxsGKMCQyZySkBHr8A9GHfxqSLp6jCL1jK4
        YxlfjPL+Faujp7VPnOqWn0o4rI/ZMcd86Tf310prO/RpT+B3Hap1W+UohcU5gI9vNX/LRZWRAnv
        PLyXfvUsp6bS3vY74vG5UemoSOzg=
X-Received: by 2002:a05:6214:27e8:b0:5a9:2bc0:ea8b with SMTP id jt8-20020a05621427e800b005a92bc0ea8bmr5351754qvb.47.1679684810466;
        Fri, 24 Mar 2023 12:06:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YuWvGXZU1QVTitk/8JsI8hEFHXd1EPDpR8zn1NFJSLnBRtZ4fzQy+1va5RMqv6w0SUiL2WXw==
X-Received: by 2002:a05:6214:27e8:b0:5a9:2bc0:ea8b with SMTP id jt8-20020a05621427e800b005a92bc0ea8bmr5351729qvb.47.1679684810228;
        Fri, 24 Mar 2023 12:06:50 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id kr15-20020a0562142b8f00b005dd8b93456csm885828qvb.4.2023.03.24.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:06:49 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     zajec5@gmail.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] bcma: remove unused mips_read32 function
Date:   Fri, 24 Mar 2023 15:06:47 -0400
Message-Id: <20230324190647.2654293-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

clang with W=1 reports
drivers/bcma/driver_mips.c:49:19: error: unused function
  'mips_read32' [-Werror,-Wunused-function]
static inline u32 mips_read32(struct bcma_drv_mips *mcore,
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bcma/driver_mips.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
index 4f01e6b17bb9..9be0806eb033 100644
--- a/drivers/bcma/driver_mips.c
+++ b/drivers/bcma/driver_mips.c
@@ -46,12 +46,6 @@ static inline bool bcma_core_mips_bcm5357b0_quirk(struct bcma_device *dev)
 	       dev->id.id == BCMA_CORE_USB20_HOST;
 }
 
-static inline u32 mips_read32(struct bcma_drv_mips *mcore,
-			      u16 offset)
-{
-	return bcma_read32(mcore->core, offset);
-}
-
 static u32 bcma_core_mips_irqflag(struct bcma_device *dev)
 {
 	u32 flag;
-- 
2.27.0

