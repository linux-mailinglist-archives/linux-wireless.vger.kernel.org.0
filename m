Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7676897D
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jul 2023 03:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGaBQs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jul 2023 21:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGaBQs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jul 2023 21:16:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5B1A2
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jul 2023 18:16:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so2499326b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jul 2023 18:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690766203; x=1691371003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoLht6Nj+QdoUfDoHkYrw79LiGPXCNEAvhbkzzXglIs=;
        b=Q77lfKBGO1gtg7GHeJifAa2N4OOCQsbu/8fYgxBycCuTeFosUbOVfiGeg8tUFmaXyf
         F9El/OzKqhoi/yV9hMHJiRUfFTzqJGtwcpMsMcwXJumlgOjfzD+OyLBUxS1naEVQ40YW
         +M6fX+e8GwVV1Kc8hM9yvYACfY3PDc5Aki6CJI9ZzCEM2hGLiTqVQ/MF8bm5w6bLUmA2
         d3WLWyhHIDIEVffZBbs4Ksg6mNgaOBOrK0aHQfUH1265fxJicELeUYAcNYn++wYDFeYc
         6g/1XKEocy693h1M6BjWJmaeJNr/YO48jm+P+qCOKX6c08L/+320QjbfXQSKeqjffOOX
         ZuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690766204; x=1691371004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoLht6Nj+QdoUfDoHkYrw79LiGPXCNEAvhbkzzXglIs=;
        b=l1kM+mGTyOp4XdsvkPIODAZbWTrMy3GYdHb0qKbvzPEavDpPci5N8tC92Th4BJ7Js6
         O4s5DDneGxQLWVV8ILFubuNGb+PVoq8UDmUIp2JCDKoSFswTnzsNpf+2FChw8lp6CLl8
         wG2kEh0xmsPJQiRjlshM2Bo7CBPg56p2SDIUnsggfmd1Y/evq6x+K1BIz4s9p8L1tZfj
         ybxX2g1OSIf4aym8pQZ98bU8mlFTL7BCCFiNGDiG8d0PtHSgmrFE0XBugHdCMyqcQUhU
         09U5/o6L7T3wjVYnLdpQ0Km1YUDaBaznpaptpO9tZqju6o3ziYhct2VMJE/Sbr6V+LdY
         tiOA==
X-Gm-Message-State: ABy/qLbRDc8eQ3pWbKC1tnj6twri5/cpgBQ51n9ZleQMw97OjV4EUH37
        Tq/EqT3PShUot6Exkri+cwKBNY/+emf7JAlR
X-Google-Smtp-Source: APBJJlGm8+7fAysmaFnTRk2gyFZmqf8NkF0LlK0YpCb6TaNVmCWjvHTM9zeqgdip0y9QNjkv8S0yfw==
X-Received: by 2002:a05:6a20:4288:b0:133:fd64:8d48 with SMTP id o8-20020a056a20428800b00133fd648d48mr9586468pzj.4.1690766203411;
        Sun, 30 Jul 2023 18:16:43 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902bd9000b001bb515e6b39sm7166021pls.306.2023.07.30.18.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 18:16:43 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     aspriel@gmail.com
Cc:     franky.lin@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] brcmfmac: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
Date:   Sun, 30 Jul 2023 18:16:35 -0700
Message-Id: <20230731011635.20993-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replacing zero-length arrays with C99 flexible-array members
because they are deprecated.
Use the new DECLARE_FLEX_ARRAY() auxiliary macro instead of defining
a zero-length array.

This fixes warnings such as:
./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index de8a2e27f49c..983946b146b3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -116,7 +116,7 @@ struct brcmf_dump_survey {
 struct cca_stats_n_flags {
 	u32 msrmnt_time; /* Time for Measurement (msec) */
 	u32 msrmnt_done; /* flag set when measurement complete */
-	char buf[1];
+	DECLARE_FLEX_ARRAY(char, buf);
 };
 
 struct cca_msrmnt_query {
-- 
2.34.1

