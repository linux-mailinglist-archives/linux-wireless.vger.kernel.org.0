Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB44E79EFF2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjIMRJs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 13:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjIMRJf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 13:09:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A75268E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 10:09:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502defbb0c3so34837e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624944; x=1695229744; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vZ9kAZehe6uRUddqEUoKwMQrCUGUj3DIHCxJ6+5D8sA=;
        b=BcZJbYAF6iuS+yGNln587jNH9Uskr7iZD6gPUF0jOJ7WSjKtyJ6ATxnbR8vItbHfFp
         SX6ooDtLpYwvR3YlTyAxIdChSIisF8LL7zE1clLrlzTJuhblzOR4bKqM4dqMHux1bHm5
         athaeqTATUA3N4o8pvCQYA6VisFH9QUk/uIDorl4V7STvrnJnd462UU8BygrHKlvDo+4
         ieoewP5OBX2AKX1LLBjTC0GVb4KGULUg/J9sU2PqWCkB8A2E5SejM/3vhQQZsY8WOODW
         EtJKY81LgmxUIbQros6utqThzy82nH4HQqm+MHdfbpOJXIuT9vowEUxl0NjA9N2ISKOb
         yqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624944; x=1695229744;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZ9kAZehe6uRUddqEUoKwMQrCUGUj3DIHCxJ6+5D8sA=;
        b=RIolmqL3/wCOgPzu4nLoMF9hdWgSH+Tdj9YcSNvUTtS2xUql09ixANSdZhRaiWbpb7
         qn44CaWBDOUsEMBocYVlzWsBvS0eakrlJH1n7JkIppE7qFpg/GLLaFOd8DQhVnik/p06
         Ms2vC79OOE2Mhph4z/iLrQJbf1aQYRNUcDwKbFBrcNePrGv27YuFdx7VvI/X5fg6vwkT
         ARbHW3Il/Ed8vgtHTO8nxd/fAtYajBnco5YksaMLp+XUBDG+IDgagBt7W5tjNj7MoNuu
         qWy6fYV5N7A+YJcxBm+gH+JkSJB4RXuXvwZwQ3R2oQk7iAmwMLuY8E2lwIUe+oE2FjGp
         t9XA==
X-Gm-Message-State: AOJu0YwGbMLW+3QsTCEfbtREWNYmb9J4KAdOsWaJRSz74xi9O7as/FUV
        6aZtXUmZIQm5kcAroejHLA4ySbqDpim6BZI1fWlisq5nayho1g==
X-Google-Smtp-Source: AGHT+IE9ecne3TTQL60K7Fw5v99QnVw+cOiOih8BOM75o1lCiATusT3ESCFnQhDIa07iJiYepwEQNF71qT4jFDo+hOk=
X-Received: by 2002:a05:6512:328c:b0:4ff:9bd9:f69a with SMTP id
 p12-20020a056512328c00b004ff9bd9f69amr2667306lfe.65.1694624944453; Wed, 13
 Sep 2023 10:09:04 -0700 (PDT)
MIME-Version: 1.0
From:   Rusty Howell <rustyhowell@gmail.com>
Date:   Wed, 13 Sep 2023 11:08:48 -0600
Message-ID: <CAE+BM3=Neb_g3QPMiGjpmkkpUK6wupM1FX06DyZOtDnQgBz_YA@mail.gmail.com>
Subject: Add extra check in regdb scripts
To:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From 434588b8f06f78a3188909c298a6f6671dab7b3f Mon Sep 17 00:00:00 2001
From: Rusty Howell <rhowell@control4.com>
Date: Thu, 7 Sep 2023 12:56:47 -0600
Subject: [PATCH] Add same check that kernel uses to check reg domain

The kernel will reject a regulatory domain if the max bandwidth is greater than
the span from start to end. We should catch this error when compiling the
regulatory database.
---
 dbparse.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dbparse.py b/dbparse.py
index 5f7e082..1e87813 100755
--- a/dbparse.py
+++ b/dbparse.py
@@ -218,6 +218,9 @@ class DBParser(object):
                 self._syntax_error("Inverted freq range (%d - %d)" %
(start, end))
             if start == end:
                 self._syntax_error("Start and end freqs are equal
(%d)" % start)
+            if bw > (end - start):
+                self._syntax_error("Max bandwidth must not exceed the
range from start to end")
+
         except ValueError:
             self._syntax_error("band must have frequency range")

-- 
2.25.1
