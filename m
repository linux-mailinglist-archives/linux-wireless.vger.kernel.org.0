Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C37776DFB4
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 07:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjHCFXK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 01:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjHCFXG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 01:23:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A632D62
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 22:23:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b643df5dso379674b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Aug 2023 22:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691040184; x=1691644984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoLht6Nj+QdoUfDoHkYrw79LiGPXCNEAvhbkzzXglIs=;
        b=MNyoiRAbJmQfGdpgpLQgEjR657sskbGl1I/vQps+Yty+Zu8vTloO+twdKugdJ4iv4j
         Ai7nUlQG6ebDpYRtcb4sSNXDsbw019wUb6aQfu1nHYhdfH/rCk8Ovr5J5aHpjD3BaPl1
         jbicGWUnQ3frnU/pE7YK6rCeKjo89UsPLJa63Q364P2Hvc+OlDiLssn1LRc2uQ9BuIAe
         9QLd9Ti7pDpl+E+j2NQhHLS+6A+gL0XFaPDhf+pVB5HHMP56eiqcou425YTdvZf2ewIY
         697a2ynUxQcgsfTOKYSeIeiZh79Z3d/wVnOWWMUOkG/KzqrGYAbAFmKoOWVkfA/ciGUN
         rmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691040184; x=1691644984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoLht6Nj+QdoUfDoHkYrw79LiGPXCNEAvhbkzzXglIs=;
        b=YonCeInux9mdnxQJNLcjWjkn4zmaI9WO/egFTh57qX0qiSpji3nb6up0vjL1L12HTG
         /bwKqqOYe+tFCzpkOKUm6xYuA9OT5uLxE3IiYuhmDlFSbcHbz+KtcTk/7iO31W/XgL8O
         nS8m4moJ6n7RGgXOYqAC2RKRUf9XS57eWZ3y70Xj2aUxSg8znAt/yBDF8LcTTi724ItW
         Co9QX7qxy6MQvciUeWqBmqp8dRpRv9aEUYMu/6fxRHrJhZeaM1jPySfAQ1k269UhwVqx
         fBHVNA6qhEMtwWGBGsjNwBuReVbJ5AhbX5JLp2Pn1ivdmYl+0saWzMcCcfOUOJQ7YO0I
         5W6w==
X-Gm-Message-State: ABy/qLYGhVAlW1FvtZZPaHoj8kQJ7/l4XCk9nhfBfbKhwKc2qVqL56Hy
        zkS1t7GOzh8ymFRTqrwn/uI=
X-Google-Smtp-Source: APBJJlEgPXz/r9TdTphuTp817soe3ze+zaNp4Ct7yWmTZmnI9QFxXOmXI65huZjRwldDAB2P565GRQ==
X-Received: by 2002:a05:6a20:3caa:b0:13e:9451:53ee with SMTP id b42-20020a056a203caa00b0013e945153eemr5188313pzj.38.1691040184137;
        Wed, 02 Aug 2023 22:23:04 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:c7db:43fb:24e4:2bcf])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b001bb988ac243sm13266685pls.297.2023.08.02.22.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:23:03 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     aspriel@gmail.com
Cc:     franky.lin@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] brcmfmac: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
Date:   Wed,  2 Aug 2023 22:22:37 -0700
Message-Id: <20230803052238.12147-1-rauji.raut@gmail.com>
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

