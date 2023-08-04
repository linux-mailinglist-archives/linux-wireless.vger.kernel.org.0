Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8452770BE9
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 00:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHDWZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjHDWZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 18:25:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A531A1716
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 15:24:51 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bc9811558cso2156420a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 04 Aug 2023 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691187891; x=1691792691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVUvP3xlkS7TG1/vaRoCl7sJJdsrR8YDV+I7ci1RZoU=;
        b=CNCB8RtZo8T/khwcc+hbbbudJy+lJ1YDfDTz2PqSRyiUlr4BJLySJYDL3mnVeMCMwe
         SxlbAe6lZSAw2BdA0s2+hv+tqRlDFfQ8b4Ebe3tZzd1ZD7e/9/1VTEIUVAy+OYqU4cgJ
         4HeaUiQKzjjmuLpfLn7xzxkRhoVwwkFos7MaMawbuzoPO2LRELkTdnmPsaOFPnvbncsd
         I+OLHLyAtW9FOWDW63kBmhvMzcN+80frqedi8TZjDIwAet8/+5cWAt97UfC8tdKTLoOe
         2/HtiDbZQT/+w19E5vDtYsIBQ4LEzh5ovWCk3n7C3NiteCDah6sDwTBR5GGY6rFL/O8l
         0N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187891; x=1691792691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVUvP3xlkS7TG1/vaRoCl7sJJdsrR8YDV+I7ci1RZoU=;
        b=mEMyHkpusaB12qR8SF2KuZ7ZluJdvwkUsT//G939rHZkYz5xfVTQV7lyg0XSkC1C4v
         6u41ruAZ5SwMwPCIVVlg5E/Kmce5b0LQ5rV7GjKcHZGycRk0moWT8rGfLKjG8+tglcNg
         lpSy0F0S1ErOdBkLjqAyiO3lq5W+Xzw9JczA9yOodFEpJ4Y731pLYG7IPGmLQjcvo7lB
         rTCS8uqKIG0npwJWCTkxXFbWeNZB11+9fhGxf4CB6rY61AjW1vVMjNsHKMael3pKppPr
         iZzivvv/nLnBzuOmBy9RZBPwpgtaHsoe2LDW/EQaSDO4Qu39K+yGmBJgOfEpjDYwl/14
         4raw==
X-Gm-Message-State: AOJu0YzBNc2HGS0Neqmjj3kdbnhJDKpCFqh+OBpuqjma2SoandIx37wL
        Ym7u0rFtq3cBH0McqFveJII=
X-Google-Smtp-Source: AGHT+IEipStUNfkpA0CQ0Nk66R1JT7Jw5gxbjjs++L32ZnMNr7HUzUIxl9gF9I/2R88qU9IExG4Tag==
X-Received: by 2002:a05:6830:44e:b0:6b7:6e07:4951 with SMTP id d14-20020a056830044e00b006b76e074951mr3116118otc.25.1691187890961;
        Fri, 04 Aug 2023 15:24:50 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id x24-20020a05683000d800b006b8bf76174fsm1728379oto.21.2023.08.04.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 15:24:50 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 2/2] MAINTAINERS: Remove tree entry for rtl8180
Date:   Fri,  4 Aug 2023 17:24:38 -0500
Message-ID: <20230804222438.16076-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804222438.16076-1-Larry.Finger@lwfinger.net>
References: <20230804222438.16076-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This entry is not needed. Remove it.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 78fcede50979..be71eac5e975 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18519,7 +18519,6 @@ RTL8180 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	https://wireless.wiki.kernel.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtl818x/rtl8180/
 
 RTL8187 WIRELESS DRIVER
-- 
2.41.0

