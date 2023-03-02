Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204D46A85C0
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCBQDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 11:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCBQDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 11:03:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DA1514E
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 08:03:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536be78056eso315679787b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Mar 2023 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677772997;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OCOfjy9wgPSJAfIMwhSliKQPfrgPuk24lq60Zc+oJ3w=;
        b=poLVNQzg/V7jkO67c4aASSzpvoGIK0gxkS2bCETcVWgmsT1SoOu1KyXcmTe/jJ9Apv
         4v3pWgK+1h9/PSOj9MYztO9Wy5RNZETDBo85HyMxBg593Oh8Zze4FVv44iALm8ReNcY4
         Kb2/cegSrGCJINxZL5I3MNuSrEi/RTK7+T4GAo7Y+F0V+psZg9lsNxwcTIUY7jqtl6tW
         eCQma7ysc55iZrBKsVKQZIn+Bkvi5zGGfSW8bp5QtMYys31wYT3cvEk4IctWNmgulTI2
         oqatWSDxGEVCpcSXuNqSj+hSX3Mx8Rja9VKfy4wgFjJvW2S+pd093IdPr1K5FKdXl4Rm
         9dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677772997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCOfjy9wgPSJAfIMwhSliKQPfrgPuk24lq60Zc+oJ3w=;
        b=7nkmQbCDbn0lfl6hcf+TI8GHtp12fInKV320R5WAaT5h5xhlbkkgkluJnsBivc1E9d
         MErsbjMhtCpfoQfql0Prbwg7RUDGgE/OsWySgFvV3vqcXGp23kYL+/V3LIx+qIK65GMY
         AzYXF2wJH5oCKpf0gqcj9WuKTNKh1UtIcPYbbU+rHCdwGXlEj0WEiDfJEGijKdiPEqke
         ccNWgBn+RQvd69wH5kOBd14axugPEQtg2GSRFPml1/iuc6j6s5d+qiwHrUXBARktm0e5
         h7WgGdyFWzAau+nTRB6yO73jXfDXDkNtk0dsnUjp4J7XdFQCLM+R91VxYfyGAqg6aDUq
         8IBg==
X-Gm-Message-State: AO0yUKWNvGnfGrL616VgEjCQvh9E6NP34rIjLXnnZ58u4e8Oo3FtM5Ey
        yBOUVN8FzdeHKg4Gh6Fi10SeubsM9aA=
X-Google-Smtp-Source: AK7set8XZeCs3Ju2LfDDbQxdv8YUdLKNoKygQ79DzdYX7f/D+n66RB6DxvZr7mGXaMUbKUr/OImEvfuwGCo=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a81:a783:0:b0:533:cf4e:9a80 with SMTP id
 e125-20020a81a783000000b00533cf4e9a80mr4044211ywh.6.1677772997559; Thu, 02
 Mar 2023 08:03:17 -0800 (PST)
Date:   Thu,  2 Mar 2023 16:03:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230302160310.923349-1-jaewan@google.com>
Subject: [PATCH v8 0/5] mac80211_hwsim: Add PMSR support
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
V7 -> V8: Separated CL for exporting nl80211_send_chandef
V6 -> V7: Split 'mac80211_hwsim: handle FTM requests with virtio'
          with three pieces
V5 -> V6: Added per CL change history.
V4 -> V5: Fixed style
V3 -> V4: Added detailed explanation to cover letter and per CL commit
          messages, includes explanation of PMSR and FTM.
          Also fixed memory leak.
V1 -> V3: Initial commits (include resends)

Jaewan Kim (5):
  mac80211_hwsim: add PMSR capability support
  wifi: nl80211: make nl80211_send_chandef non-static
  mac80211_hwsim: add PMSR request support via virtio
  mac80211_hwsim: add PMSR abort support via virtio
  mac80211_hwsim: add PMSR report support via virtio

 drivers/net/wireless/mac80211_hwsim.c | 775 +++++++++++++++++++++++++-
 drivers/net/wireless/mac80211_hwsim.h |  58 ++
 include/net/cfg80211.h                |   9 +
 net/wireless/nl80211.c                |   4 +-
 4 files changed, 834 insertions(+), 12 deletions(-)

-- 
2.39.2.722.g9855ee24e9-goog

