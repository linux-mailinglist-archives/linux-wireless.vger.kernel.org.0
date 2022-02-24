Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10464C3487
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiBXSVA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 13:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiBXSU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 13:20:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AFC2757BD
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 10:20:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x18so2586457pfh.5
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PFADpTEyYX0jTJI05krr0oEdPH5jTdoFS7XZkT5l9cg=;
        b=YUvsAKn973g3YgJuIMjwkuD4Eg/fWOJzGrXbuF+0UahXAFW9vU4Elz/BcRPES62z/T
         0MZez+5+LxCPvC/8CcDWxp8M9GnGp1ObBfunctbgeDPKepc8kQJ+S73vTmp6Zz0I3ij8
         4xvOJSkSMWI4XA7DqtWao982CMlmoVYEMQUAyWBBp0qvmUmGJ2l7e0bYhcyjGWk/Skvc
         tyLiAqLokCGOJccFgneawXX73/2nnGY5pXUv3oEyLzdRuLnJTGIxvxHv0Saot4zgDmCB
         XiqysG5MzTNU+KwBfB33/Zvlkmz0PhsAa79h7KJPYO12Aq/Svlfz7m7nAfC/X/oER/+Y
         rQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PFADpTEyYX0jTJI05krr0oEdPH5jTdoFS7XZkT5l9cg=;
        b=5RBewsxfdxxdjei5qFYsxCeR9VUP6spoMWm+hW6XW3xtmox4TpsEe0GUZTIwKhsWRw
         jjphQNGIiGxQFqpAydMJQSgnYKFW+x7FHm9YbNHV83KYkB0dMesr9bPR0kIpA2EEqMWg
         qO8oIus7SrihJWXQwoSvs8R+95XNDb8Pdjt70U8RbhVkNfm+LI0o12nmmGQkHtGKmWNv
         vkb1yrhNFRHhiFJiLWV8VI7HGJLamgtlzlWvUNEj70fZvMZNcdbohbtBRk1RXHa2Bj3j
         QCV2bcqk8wWggn8qa/WQ1YlB/waHvz5df2UQjAxRJ+ArYuWrLYT/FdQ3KXne3kgEj+SS
         JxCw==
X-Gm-Message-State: AOAM532QoSRN+4bkPQvzhoGiYiNTLwnLNvK4NmqB6jwhf1Naq3ctLDlJ
        nLOS01/n3yuFfGdWaPN8O9HrcH4eMVY=
X-Google-Smtp-Source: ABdhPJxd1NTtZc3rgdjtX5s50mkXvHYSMJgtllZDawNwvRf+nj30ByDYL4nHRaPcT2ab+/Lm91/Bcg==
X-Received: by 2002:a05:6a00:1ad0:b0:4a8:2462:ba0a with SMTP id f16-20020a056a001ad000b004a82462ba0amr4042951pfv.75.1645726824159;
        Thu, 24 Feb 2022 10:20:24 -0800 (PST)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00158500b004f0f12b320asm222768pfk.6.2022.02.24.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 10:20:23 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] brcmfmac: include missing AP scan feature
Date:   Thu, 24 Feb 2022 10:18:09 -0800
Message-Id: <20220224181809.2808754-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This driver does not advertise this feature yet scanning with on an
AP interface appears to work just fine.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

I've submitted this patch mainly to start a discussion about it. I
find it hard to believe that ALL brcmfmac devices support AP scanning
in which case this feature needs to be limited to those devices
only. Trouble is there is no FW feature for AP scanning AFAIK.

In any case I think this driver needs to sort out if it supports this
feature or not, and advertise as such rather than leaving userspace
in the dark.

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index fb727778312c..b6a50e65dbf6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -7729,6 +7729,8 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
 #endif
 	}
 
+	wiphy->features |= NL80211_FEATURE_AP_SCAN;
+
 	return cfg;
 
 detach:
-- 
2.34.1

