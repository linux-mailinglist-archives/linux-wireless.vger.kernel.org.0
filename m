Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D7675BFC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 18:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjATRtm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 12:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjATRtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 12:49:41 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCA113C1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 09:49:40 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 38-20020a630b26000000b004773803dda1so2896818pgl.17
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EtBiS/tl16MmIzzTANwiKqwgJzZ181f67W8/y+A46U0=;
        b=XULRqp0Fu+j3es3P42T+2YPXI1Ts6EFXVKl1ZBdYUw5P4gMTy7co6Ayb4jBM0r0k9N
         FhpYAT08Lupt8yBVu3M1p06x7aTfmWl95E+Sp+YtwDAPJaY7zpjoi9YIMikEbc5whpWp
         bwOI7esNzNygfBguV3lg32ZXXg2JB3OPL7staPgx+82XR1bHixdacU+g5tnoQ/hX6OAf
         +ZR/7Ir20ToO1EwV6Cb7lbv7CjHzvzbZg70WSHpNflGJzXe8X1WiGv6AZ947aC7IZQGh
         XjAbXmyFvW8s1CA+KdguSnoV9Lh3213RE79qBOetyAs4sz4nMdkJYOAHjNW3T8zxJWSe
         dMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtBiS/tl16MmIzzTANwiKqwgJzZ181f67W8/y+A46U0=;
        b=XatztVrMGIJ7l/0K53nOPTzJ4eu2mijo2cKt21UhN2EQk4rZlb2PRCfcTm1BsdZLlb
         Ny0ARgL0FeOxEmx1kBKp8TDQG0NgIF8WWTJNMU0zhKudCgkQdpjnLhwj5zqrFYkMIARz
         WjnwnK6hoEkVjyD1jbXNwySVwZJkuHC/gtPVaxuWlHcpzF/+bB26FqbZQ3MiUaX3y0tx
         i8vf8rV4FfKREGn96KifLVYRRbuGHCjxRH0BMr3oZxpcNB18hQve70nL3M8FVIC9Iht7
         ggj9ucpBIz7hYYwViIuyQlzA+kL3Xsx1UCk6F0rpyRLbM6g2PwvlQQRbuy0u8Y5nPqNV
         q3vQ==
X-Gm-Message-State: AFqh2kqzBqzBgXIaLn9N3Ns5y/MWGv+E34iAY6C9mbz2KgXNmHPWAd1C
        CjEwfmbfJejLjDxxoTeeb8/3JIdgUvU=
X-Google-Smtp-Source: AMrXdXv3/LeWz0ry7GDKb4NdTafMepcXlG8xXyJcDIshtFWio9767P4+L7h17ZnxQGbPwBczEbWSNQyuZTI=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a05:6a00:300e:b0:58b:8520:2916 with SMTP id
 ay14-20020a056a00300e00b0058b85202916mr1783053pfb.2.1674236979960; Fri, 20
 Jan 2023 09:49:39 -0800 (PST)
Date:   Fri, 20 Jan 2023 17:49:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230120174934.3528469-1-jaewan@google.com>
Subject: [PATCH v4 0/2] mac80211_hwsim: Add PMSR support
From:   Jaewan Kim <jaewan@google.com>
To:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@android.com, adelva@google.com,
        Jaewan Kim <jaewan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Kernel maintainers,

I'm proposing series of CLs for adding PMSR support in the mac80211_hwsim.

PMSR (peer measurement) is generalized measurement between STAs,
and currently FTM (fine time measurement or flight time measurement)
is the one and only measurement.

FTM measures the RTT (round trip time) and FTM can be used to measure
distances between two STAs. RTT is often referred as 'measuring distance'
as well.


Kernel had already defined protocols for PMSR in the
include/uapi/linux/nl80211.h and relevant parsing/sending code are in the
net/wireless/pmsr.c, but they are only used in intel's iwlwifi driver.

This series of CLs are the first attempt to utilize PMSR in the mac80211_hwsim.

CLs are tested with iw tool on Virtual Android device (a.k.a. Cuttlefish).
Hope this explains my CLs.

Many Thanks,


Jaewan Kim (2):
  mac80211_hwsim: add PMSR capability support
  mac80211_hwsim: handle FTM requests with virtio

 drivers/net/wireless/mac80211_hwsim.c | 827 +++++++++++++++++++++++++-
 drivers/net/wireless/mac80211_hwsim.h |  56 +-
 include/net/cfg80211.h                |  20 +
 net/wireless/nl80211.c                |  28 +-
 4 files changed, 913 insertions(+), 18 deletions(-)

-- 
2.39.0.246.g2a6d74b583-goog

