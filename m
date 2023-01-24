Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57A679BAC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jan 2023 15:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAXOZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Jan 2023 09:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjAXOY4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Jan 2023 09:24:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05E9ECA
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 06:24:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w70-20020a25df49000000b00803e799d7b1so10601534ybg.10
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 06:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYWIFqTbzSvnVb0ZRy1cEqN2xC3sqcq3T09CZTeTZGI=;
        b=DLy22mVMZPYcSIi7HmIVEAAbbsXtono82uo4OBHNaLaMhABQQ/yDUYPD/kXwIDY6y0
         jefWDahfcZKkcz6bWATFi7llfHrJn1/5co9OcAfKZD5oq3dN0RD0Vnr3Zh9fmHNXGDzv
         /byw6tjbHJnJiQldAE2HPeVx+5d6IuZhmsYHEVQBT62zyobueo6v4hE56Vc8FFOlL48b
         W0fWbZp7ALaMsengWZkABSujILMIrwuWhKwW+BdJP2+Ofe18zJFS9kAgg9HM+ko+qHlt
         4nVrC2NuPQzL7IMzNumQ2A1TIGRpglbWbUekfP1eLXqomPjruZsOuWLuIHjfuvFiBdmE
         ezrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYWIFqTbzSvnVb0ZRy1cEqN2xC3sqcq3T09CZTeTZGI=;
        b=PrpvT9DnzpNA3/n1I3Tj4b1kOovCjCZ4jaMF/IkTFxZtP+4GJ7ejDQ2nDA342KQQR5
         GDxoQ7Yh5eLhZKjCp6pS4Z3Xu0bfJjzFOb2+V7JXPJEbvnidx7i9KRGExrIudd/ThzpF
         a9F0pwsLp7zT/HKtgAnP+eOYQBZS9x50PrSbkDmeaQMm5Xt/0AgvNWiS8ukV6oUDRjYS
         rfA6dZHm0wtkVfukqHnH/OqVioe0IbXgiM05ytl1gWlFl+Gft6znKz5yq9pP/Q/4nu9s
         m/QXpF3BujMpwBWCeQ0jTugyeq2j38w2Bl5ugR8Kw4/YOppBkpqwWrdoFCO7QrYjVHVN
         Dnqw==
X-Gm-Message-State: AFqh2koRz2aWvcjcB+Go1CUy/NnXjOkUF6+VyMKmmbupkAHJSuinDkvM
        n/EB8D9ybSVT8fszKklYctsUCnQuCUA=
X-Google-Smtp-Source: AMrXdXsa/8G44WL1+C5uMCUjwdyx4OGFL2fsxdllh90UwRiflkE2N8+qePKx4Id0LMccb3cvCsuK2/JATP4=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a81:4688:0:b0:3e8:da97:53fd with SMTP id
 t130-20020a814688000000b003e8da9753fdmr3259180ywa.42.1674570294567; Tue, 24
 Jan 2023 06:24:54 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:24:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230124142431.357990-1-jaewan@google.com>
Subject: [PATCH v5 0/2] mac80211_hwsim: Add PMSR support
From:   Jaewan Kim <jaewan@google.com>
To:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@android.com, adelva@google.com,
        Jaewan Kim <jaewan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Kernel maintainers,

First of all, thank you for spending your precious time for reviewing
my changes, and also sorry for my mistakes in previous patchsets.

Let me propose series of CLs for adding PMSR support in the mac80211_hwsim.

PMSR (peer measurement) is generalized measurement between STAs,
and currently FTM (fine time measurement or flight time measurement)
is the one and only measurement.

FTM measures the RTT (round trip time) and FTM can be used to measure
distances between two STAs. RTT is often referred as 'measuring distance'
as well.

Kernel had already defined protocols for PMSR in the
include/uapi/linux/nl80211.h and relevant parsing/sending code are in the
net/wireless/pmsr.c, but they are only used in intel's iwlwifi driver.

CLs are tested with iw tool on Virtual Android device (a.k.a. Cuttlefish).
Hope this explains my CLs.

Many Thanks,


-- 
2.39.0.246.g2a6d74b583-goog

V4 -> V5: Style fixes
V3 -> V4: Added cover letter for overall changes, and fixed potential
          memory leak.
V1 -> V3: Initial commits before the first review (resends).

Jaewan Kim (2):
  mac80211_hwsim: add PMSR capability support
  mac80211_hwsim: handle FTM requests with virtio

 drivers/net/wireless/mac80211_hwsim.c | 826 +++++++++++++++++++++++-
 drivers/net/wireless/mac80211_hwsim.h |  56 +-
 include/net/cfg80211.h                |  20 +
 net/wireless/nl80211.c                |  28 +-
 4 files changed, 912 insertions(+), 18 deletions(-)
