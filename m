Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA25B406D7A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Sep 2021 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhIJOTb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Sep 2021 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhIJOTT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Sep 2021 10:19:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829F3C061574
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g14so2012587pfm.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMwkUe+0yoW+A2+6v5xt7NkklVccYWTe+a7hUuUevc8=;
        b=qBEe5lc5u0v4/l2QbhiQfOCiZPti+vQLTeNYMJr4aCNVIrnn4RNiEdHRg55c1pNMCW
         9O4a2sU6dr+PnRDLmpnC5doNbAgWCDpXbQGQOHH2J4k+JfHlOtdlbSNxeZz4F+gJF9P4
         //lktNjKjTevw+oJ4LC/1zlKLK70EAYWBO3b/M12H2+uCEWeIX4HpTki24SrUHEAJqcn
         gVUZt1B8TNk1GnXwvjDa2BzsX7UpCF96Hl4kRTlhYh4MV9L4Nbr14H7BJKGT+uc2k3QZ
         xH30PqLYQdcxHPIyQWpC5NMMMhxm08vCRXiMt3k39iloN2F7q0OLWeEc6WANqNUob/4C
         8X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OMwkUe+0yoW+A2+6v5xt7NkklVccYWTe+a7hUuUevc8=;
        b=IWvtosPYCd39L7pG/7JiGVgdi/tVdQGGjgWiP/rIIYu5RLoRgmHRr3RE/8evAsET3l
         nEbb6jWWd9tv46DBdYqgiOwKRYRTro4IyYpyO/gWP+PQ2DH6j3j5zKG7cHCWAsOmX4Ub
         2HqnnK4pQuQruYQSTCz/D7AH+l8kV7hi7c8+wZyXFQ7wRUtGkFJHR69fPW1a8Yn5UKB6
         fRq/SR8+McwC4sKFJneCX8UXsQ+Aj0/wEzT4Z9tz1x1C6XWxDTwWfKfuu9i6cD3BcWnH
         7eL9lN9z/27L+iwGcZMOcU4xix4Sgl8PzQZowi+a58Zo/Yxu6DlDHWi+9Ei3tjpKV54H
         KWFQ==
X-Gm-Message-State: AOAM532uScxuvlm+y1ozN1BVnE9PeDBHOYO90igMl7HBBGW2hoqd2+ln
        fBGrwLGMnSQEzrxjHdH5Zvk=
X-Google-Smtp-Source: ABdhPJzU22GZJVWbXbFkfLttfZf46nDbAOa26nFzVxfc6mbgD2X3y4kGySgPZ4zjbyM6NX2Ix8pdOA==
X-Received: by 2002:a63:3717:: with SMTP id e23mr7624958pga.10.1631283486944;
        Fri, 10 Sep 2021 07:18:06 -0700 (PDT)
Received: from localhost.localdomain ([49.206.113.222])
        by smtp.googlemail.com with ESMTPSA id q9sm5079519pfs.40.2021.09.10.07.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:18:06 -0700 (PDT)
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gokul Sivakumar <gokulkumar792@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH iw 1/4] iw: nl80211: add NLA_F_NESTED to nla_nest_start() with older libnl versions
Date:   Fri, 10 Sep 2021 19:46:15 +0530
Message-Id: <20210910141618.1594617-1-gokulkumar792@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is noticed in Kernel version 5.14.0-rc4+, that when sending the NL cmd
NL80211_CMD_SET_TID_CONFIG with nested attrs under NL80211_ATTR_TID_CONFIG,
kernel returnes a response with the error "NLA_F_NESTED is missing".

 $ sudo ./iw dev wlan0 set tidconf tids 0x1 ampdu on
 kernel reports: NLA_F_NESTED is missing
 command failed: Invalid argument (-22))

Fix this by setting NLA_F_NESTED flag everytime when using nla_nest_start()
library function. This is needed to make cfg80211 allow the nl80211 command
NL80211_ATTR_TID_CONFIG in the new kernel versions that enforce netlink
attribute policy validation.

Signed-off-by: Gokul Sivakumar <gokulkumar792@gmail.com>
---
 iw.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/iw.h b/iw.h
index a118f5b..545fd0e 100644
--- a/iw.h
+++ b/iw.h
@@ -11,6 +11,11 @@
 #include "nl80211.h"
 #include "ieee80211.h"
 
+#ifndef NL_CAPABILITY_VERSION_3_5_0
+#define nla_nest_start(msg, attrtype) \
+       nla_nest_start(msg, NLA_F_NESTED | (attrtype))
+#endif
+
 /* support for extack if compilation headers are too old */
 #ifndef NETLINK_EXT_ACK
 #define NETLINK_EXT_ACK 11
-- 
2.25.1

