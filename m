Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60DD68D1C8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 09:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjBGIyL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 03:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBGIyK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 03:54:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006BD1CAF7
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 00:54:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 189-20020a2501c6000000b008b256b6643cso558590ybb.6
        for <linux-wireless@vger.kernel.org>; Tue, 07 Feb 2023 00:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SUWvqh2oss6qlxbagRwaRIMaXzddzW1vPLzO204jfbc=;
        b=GtxRW+mPTOVcteUlR8T25ku2o95R1ODqIJF9qH0+g2b2qFDyvFC1aNYaqBfE8H9iBI
         634oYG+4izQzwKKYtqc+a6wn9SAWLotPRTC06n6inSA0x367+9Wr9LvFvREMpynaRL5M
         luooVlNb+xacgtH62HW5TuSqbvPQm23snpcktBtLOqgZ22/5+jgvJ81Cz3SjlTuF8Q1g
         tu6YHO9AFZetsodf4HfEgu1d216mV5OP6c6YNBpbvAVDfXRbAyFkZO33g5JKpBmPGYZ0
         OZ7s/tTPZ6T+63UOz6KqJKJJqRxwIiO/rzg7HzvBWTREFaYiNMZBxly3U77Rpb1amUd+
         DEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUWvqh2oss6qlxbagRwaRIMaXzddzW1vPLzO204jfbc=;
        b=x4Mfj/aOphCGQMIfFkBB2Np+t3pNnaezetahSZtfjokkACcWDv+O65f7+QXh9bcoVf
         ncrgc3C7jf8m/YZHFflf8NBu0UoOYfDNA9j1HdyAfEmOIDRYtCT56zJWu23h792JY4VO
         j2kIG1qnQTQV56cjciYLitV1s1P8pu/aovmwfvXVPgbMPv5NZVnbbmmhCPuK6YUO3KXk
         mCqxneQdCgHuHfKHrm1fjrzuYPVS48ehSvHfT9gpUqVLY1WdAv0UWBRUA1QoWbFyyIL/
         Rr1eMfSjpF8jpevDtgODBKfVGoX1hk5TgYE1hZyk8S58RqT2eAd0we6RTYGKeAfa292N
         tKog==
X-Gm-Message-State: AO0yUKVSGIQv/NRaAr6BAS19880wqD/fWbH2uIdhj9cfMLiijEe9BCuW
        buJrMLQDBDhvVCl2E7nPYCswRL7rmPU=
X-Google-Smtp-Source: AK7set9fXUBs3havc1DTptsAp+J5lKf9vtXsyX/6Sgqf3yEq5Ut92vpC1tks0sbYRErBLc38iy+LrfuBpkc=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a0d:d68c:0:b0:527:6377:4e80 with SMTP id
 y134-20020a0dd68c000000b0052763774e80mr225854ywd.113.1675760049264; Tue, 07
 Feb 2023 00:54:09 -0800 (PST)
Date:   Tue,  7 Feb 2023 08:53:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207085400.2232544-1-jaewan@google.com>
Subject: [PATCH v7 0/4] mac80211_hwsim: Add PMSR support
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

V6 -> V7: Split 'mac80211_hwsim: handle FTM requests with virtio'
          with three pieces
V5 -> V6: Added per CL change history.
V4 -> V5: Fixed style
V3 -> V4: Added detailed explanation to cover letter and per CL commit
          messages, includes explanation of PMSR and FTM.
          Also fixed memory leak.
V1 -> V3: Initial commits (include resends)

Jaewan Kim (4):
  mac80211_hwsim: add PMSR capability support
  mac80211_hwsim: add PMSR request support via virtio
  mac80211_hwsim: add PMSR abort support via virtio
  mac80211_hwsim: add PMSR report support via virtio

 drivers/net/wireless/mac80211_hwsim.c | 777 +++++++++++++++++++++++++-
 drivers/net/wireless/mac80211_hwsim.h |  55 ++
 include/net/cfg80211.h                |  20 +
 net/wireless/nl80211.c                |  22 +-
 4 files changed, 859 insertions(+), 15 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog

