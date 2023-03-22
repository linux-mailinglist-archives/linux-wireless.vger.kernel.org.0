Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC346C4B83
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 14:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjCVNT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjCVNTR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 09:19:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D9C5C12E
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 06:19:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 185-20020a250ac2000000b00b6d0cdc8e3bso8297116ybk.4
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679491152;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yb81hp7ZlCpX7Yr6wz12GTlDZ40WK1rINM0mAGZ5OpM=;
        b=KBNKtldMVauP0c3qFAYy0easJJXbtNYVy4U/IesleLkFYfKKbALxTxCH7Inv4oVyLT
         qYLwRhvBHmwfG+4YVOXvTFnS/DbxB69WjXLSPA2NmYGFKEvAIDDTZMiZ2j37eBYEK15+
         ltVmLrHobkqo8LIrLNlH/L65MWb2X/Dy/y1b3yPNotkUunTUt3TFOg6FvXQhTk11u/j7
         ZyXr5rj/vDOccu30NhJZvxCXpjNDvMXNzN0znRYYT6l7SjuEkk6a7TKsb919eu38Q5sz
         vM1VWaIRLvTMldqJj8vlRptxFLqN1mT4bYK/JvBXxJc9NGbYQwNY0tQ8R/8DM2/qri6u
         DXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yb81hp7ZlCpX7Yr6wz12GTlDZ40WK1rINM0mAGZ5OpM=;
        b=ULknIcLXXTLEgxx4z6QPJgCw7ctbqhsf0Q8zYPlIzlMQB+Lplu5ZTWVb+vx2cLvxgJ
         vSA/6sfXEQKmO3kKfopzJaUl3HeUJvSI2QjImZGDxjgteEhRGEx0s7riK72MaQqyRxxe
         IgAK/rkVk4FsgIg1NxS69Y6x2B6yWnf0ELv6CJeovXqSttJ7OaSs7eLb3KDPLurmf3rV
         f6f66vL+w+JwcV7E9y+DXKVEMAmqrpxrKeFWmbWHqihrSLuZ2lYlMeUb3K38uHPQuCde
         2+ufQHV3SGnYQvunoO6/44Ykc4rGwfn/GrOfhCxL32/KqqcMN6WgPFGpjuIoNv0EKUTp
         wClA==
X-Gm-Message-State: AAQBX9eMiMdBDSi7pm1xHX1dB1d2+YNNmPq/Wer31QUYb8glrYhA8Jlr
        6T7f/lgHQ38qHX4GFcoRc+al0ODskVA=
X-Google-Smtp-Source: AKy350aspfgHB1gDVWJthbqNoLqeIswB1rcjtYlr4D89NRndFfZREPvg7ka5TcVt7NpUkmh1ZsQMUOU9HBI=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a05:6902:1003:b0:b3c:637f:ad00 with SMTP id
 w3-20020a056902100300b00b3c637fad00mr4107795ybt.5.1679491152591; Wed, 22 Mar
 2023 06:19:12 -0700 (PDT)
Date:   Wed, 22 Mar 2023 13:16:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230322131637.2633968-1-jaewan@google.com>
Subject: [PATCH v10 0/5] mac80211_hwsim: Add PMSR support
From:   Jaewan Kim <jaewan@google.com>
To:     michal.kubiak@intel.com, gregkh@linuxfoundation.org,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     kernel-team@android.com, adelva@google.com,
        Jaewan Kim <jaewan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Kernel maintainers,

First of all, thank you for spending your precious time for reviewing
my changes.

Let me propose series of patches for adding PMSR support in the
mac80211_hwsim.

PMSR (peer measurement) is generalized measurement between STAs,
and currently FTM (fine time measurement or flight time measurement)
is the one and only measurement.

FTM measures the RTT (round trip time) and FTM can be used to measure
distances between two STAs. RTT is often referred as 'measuring distance'
as well.

Kernel had already defined protocols for PMSR in the
include/uapi/linux/nl80211.h and relevant parsing/sending code are in the
net/wireless/pmsr.c, but they are only used in intel's iwlwifi driver.

Patchset is tested with iw tool on Virtual Android device (a.k.a.
Cuttlefish). Hope this explains my changes.

Many Thanks,
--
V9 -> V10: Applied reverse xmas tree style (a.k.a. RCS).
V8 -> V9: Removed any wrong words for patch. Changed to reject unknown
          PMSR types.
V7 -> V8: Separated patch for exporting nl80211_send_chandef
V6 -> V7: Split 'mac80211_hwsim: handle FTM requests with virtio'
          with three pieces
V5 -> V6: Added per patch change history.
V4 -> V5: Fixed style
V3 -> V4: Added detailed explanation to cover letter and per patch commit
          messages, includes explanation of PMSR and FTM.
          Also fixed memory leak.
V1 -> V3: Initial commits (include resends)

Jaewan Kim (5):
  mac80211_hwsim: add PMSR capability support
  wifi: nl80211: make nl80211_send_chandef non-static
  mac80211_hwsim: add PMSR request support via virtio
  mac80211_hwsim: add PMSR abort support via virtio
  mac80211_hwsim: add PMSR report support via virtio

 drivers/net/wireless/mac80211_hwsim.c | 785 +++++++++++++++++++++++++-
 drivers/net/wireless/mac80211_hwsim.h |  58 ++
 include/net/cfg80211.h                |   9 +
 net/wireless/nl80211.c                |   4 +-
 4 files changed, 845 insertions(+), 11 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

