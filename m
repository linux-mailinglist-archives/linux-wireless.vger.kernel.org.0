Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF24F86A8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbiDGR4X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 13:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiDGR4U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 13:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93DE4CA6EF
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649354054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CK9Z5mVDe4mgBGspYQzzn8gJDiHvz3qCsQ86FE3l+us=;
        b=WRXydbvXYfYpSEMZIYZNKUVjEfx//g2Sv5ZmeMayiluOaiTSHJYVzxCuqrCpmwtpr0So16
        Ey84+AzbccnLk5ftCHqoWqKelPdbXz3i8Gitdwcq9paSS+5G1yIW8FR6i4K8mVPj95b4Ph
        q5LreLl5+XgRFWdDWu1Xn2OUSRmn3wE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-Ke-PQHEuPpmaTF8ZkCNq1g-1; Thu, 07 Apr 2022 13:54:13 -0400
X-MC-Unique: Ke-PQHEuPpmaTF8ZkCNq1g-1
Received: by mail-pj1-f71.google.com with SMTP id md13-20020a17090b23cd00b001ca7df65e1cso3939866pjb.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Apr 2022 10:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CK9Z5mVDe4mgBGspYQzzn8gJDiHvz3qCsQ86FE3l+us=;
        b=nqtFMXpd61GVylrLWW0Z8de91gET5LCVIdtwEMs3mZFp+6fuiBx9HqZBbaL7TDS/Kd
         x31a2ySc3XA9sBrltYNsdgmmUJVJsF7ZlUeL9eU4BBnVimItbxpaHeaT7+yHSt7Dbzqc
         QLp47SqlrrLE+EnWuYtcKTtibPFJwf5WR47V/jjfEdF6qiI5pXA4BOzYMJ/7ssSMk4Q4
         JLq9X7JJDA9gkf9T3fUeIfRdKYxD406z7XG+WWKLyKB9YH4Jafku9uztaF3vtObxNtzC
         j7XgC8WqzgVhAhbeaRH/bEjwNFnGMnrCvySv7L1L2QG6M/zVT4eEFDqMJ2bJs+gk/LVV
         Lb+g==
X-Gm-Message-State: AOAM533enWvVx88Bq98pDGt7AJ/W128kkrndZKP78VNAfVcHleBCyV3k
        JqOfUlrteCsTaaFWwaTSD5YiW1uTq60AQWBlKnDMzo8cskhjgTU5lRbBx6oYheWS25UaGgL98LD
        zpsWVF9fek5PPOxHTu4DU7qXJcsc=
X-Received: by 2002:a65:6b92:0:b0:39c:c97b:1b57 with SMTP id d18-20020a656b92000000b0039cc97b1b57mr3129951pgw.517.1649354052365;
        Thu, 07 Apr 2022 10:54:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY+f9QwoacEBY4kuGoqYuYwACBfLXX9MLBnkeSnGdArm5ggb+OlgU6GsrW0+ANYwvG2th5MA==
X-Received: by 2002:a65:6b92:0:b0:39c:c97b:1b57 with SMTP id d18-20020a656b92000000b0039cc97b1b57mr3129928pgw.517.1649354051960;
        Thu, 07 Apr 2022 10:54:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm23439873pfl.15.2022.04.07.10.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 10:54:11 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     pkshih@realtek.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] rtw89: ser: add a break statement
Date:   Thu,  7 Apr 2022 13:53:49 -0400
Message-Id: <20220407175349.3053362-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The clang build fails with
ser.c:397:2: error: unannotated fall-through
  between switch labels [-Werror,-Wimplicit-fallthrough]
        default:
        ^
The case above the default does not have a break.
So add one.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/realtek/rtw89/ser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 25d1df10f226..5aebd6839d29 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -394,6 +394,7 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 		break;
 	case SER_EV_STATE_OUT:
 		rtw89_hci_recovery_start(rtwdev);
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

