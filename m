Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AE6C7F1D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 14:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCXNv1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXNv0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 09:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298D1ACFE
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679665836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FMTjZQ/T7fVsB9p23mpEDbCQHzwssIrPeWULDPJBsw4=;
        b=Ifp9XiylYe8tY3v53WeiLqRDIO2dq1ttjrxW7AsFxygL4EwbeCOf7vR6UJZQStWeoBPOfR
        7oJZNAcVYcS79M4Ajp987e2wjVomEJXwOjkVnZ27XlqnNLZv7vyg8Z3ZJsBb6bO7V117lU
        ZUaDD8619IW7FtgAI//pxFvMne9F99g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-GYeDVo7kNACkWXr1m3fIpQ-1; Fri, 24 Mar 2023 09:50:34 -0400
X-MC-Unique: GYeDVo7kNACkWXr1m3fIpQ-1
Received: by mail-qv1-f72.google.com with SMTP id g14-20020ad457ae000000b005aab630eb8eso1035421qvx.13
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 06:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679665834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMTjZQ/T7fVsB9p23mpEDbCQHzwssIrPeWULDPJBsw4=;
        b=ahdc0B0d+/GhF+wyseCz4pRXIc26W0XITB9+JcDdeMbEZnLfYU5WUbJt+hiK0fwIge
         RJWPcUH5FH4+uJ11pgS99PKR7f3UJiwJM3VUBbyUPdbFp6bELU6uWSiqht9zaw7COPkS
         3q98Ga65ZYAgglP1YtXWn4CinTKQTB9uxYn1LqbsoNR6WMHOrESmcX0IirtUmB/oZIEb
         lIWhAqNwUZtYAhowxTXxRVjBH9FQ8WN1sQvOEuhExo9d5nK63vTfNTdE3Q3JTsS0HVdH
         Lz3/IhvIhwQGLbo3MZU/iKUDYVMBUoRiYPz537GFjyRB5bOVbs75DcqGilRdbbcXYiWD
         yNmw==
X-Gm-Message-State: AAQBX9f5JBs7zgthhWKKDZJWiun4HJEO6grQSZj4XJn9MzDJFhM3EYI5
        Cdqhgo3hi9H4zpz13G80/EqaDhFCBF1kF4eXdYF0uQL3kfkPINdKvEAGEsnCl8gy++QvcZUfCrL
        6asxHTvl3bze5+NASDEhtk0QeX4k=
X-Received: by 2002:a05:6214:1c81:b0:5cc:97fa:eec9 with SMTP id ib1-20020a0562141c8100b005cc97faeec9mr4261660qvb.25.1679665834191;
        Fri, 24 Mar 2023 06:50:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350ahlHZPmdC3xd97ab7RGu9groXWTX+2fdJ9Ht5qCwv4vBumlH8C1WLa0jD3fUCrLsQs2svgVg==
X-Received: by 2002:a05:6214:1c81:b0:5cc:97fa:eec9 with SMTP id ib1-20020a0562141c8100b005cc97faeec9mr4261627qvb.25.1679665833983;
        Fri, 24 Mar 2023 06:50:33 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id ks10-20020a056214310a00b005dd8b934573sm697466qvb.11.2023.03.24.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 06:50:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     Larry.Finger@lwfinger.net, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] b43legacy: remove unused freq_r3A_value function
Date:   Fri, 24 Mar 2023 09:50:22 -0400
Message-Id: <20230324135022.2649735-1-trix@redhat.com>
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
drivers/net/wireless/broadcom/b43legacy/radio.c:1713:5: error:
  unused function 'freq_r3A_value' [-Werror,-Wunused-function]
u16 freq_r3A_value(u16 frequency)
    ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/broadcom/b43legacy/radio.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/radio.c b/drivers/net/wireless/broadcom/b43legacy/radio.c
index fdf78c10a05c..8d7eb89c1628 100644
--- a/drivers/net/wireless/broadcom/b43legacy/radio.c
+++ b/drivers/net/wireless/broadcom/b43legacy/radio.c
@@ -1709,23 +1709,6 @@ u16 b43legacy_radio_init2050(struct b43legacy_wldev *dev)
 	return ret;
 }
 
-static inline
-u16 freq_r3A_value(u16 frequency)
-{
-	u16 value;
-
-	if (frequency < 5091)
-		value = 0x0040;
-	else if (frequency < 5321)
-		value = 0x0000;
-	else if (frequency < 5806)
-		value = 0x0080;
-	else
-		value = 0x0040;
-
-	return value;
-}
-
 int b43legacy_radio_selectchannel(struct b43legacy_wldev *dev,
 				  u8 channel,
 				  int synthetic_pu_workaround)
-- 
2.27.0

