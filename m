Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD42630AB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIIPhj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbgIIPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9E0C061347
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so3435314wrw.11
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yl/nnkmmjEV1dEUeIEWBah0JAShNSUhA1OGmxb4SHg=;
        b=TWMgl3rqh8xfOJBvdb20gacEaA8MPiLOlqUOzrXRVZ8tijmSKlo/Q5cssfCvRT14vC
         5sFOSBqhB1ErAKBysIERtHmKRmqJEzyVVO+bzaaccsXlEj42DZYvLadV/9ZFmqSuWbKn
         7SGh6axVSVxXc4hUfH0wYaaUxdIhZQLU1Md5PqPd1qahacaMrzPx8Kqi9kxirh1ilgz4
         HC8sofnMtgerLoB9c+QoWxrQbawZqzea8TBtBlNDsYHhpWE1olk6hDvtkhhj2GLQ5UfB
         8LFzDPFTFTURFAMEL5oIEezpKmfJS9ZfVGLAjaaT7hZruOMxLfuK4CxwXB2tNCKZi1IB
         p/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yl/nnkmmjEV1dEUeIEWBah0JAShNSUhA1OGmxb4SHg=;
        b=lftkJ6ybmwlSDkG9W4huKhPduVDHcXyYxyIDIveO5LmXCq/FownM6gX6Ge4NaZ/42e
         xQ9aWzqPL4gcaf5/bsfVKpNaaiS1M1mHH9wMUsMN0QSTw/tbNsGoGdRu6iR2EkrquO34
         KI2ZvS3yx01T+mzgtBHILHeC0QlK3YHUmCXfsKoWUzs+l7dPoSesfza8EFLm2TTkjxPc
         uhj22wUsgjRDqS2DTFRjcmKK3aiZL0jbFG7gAEsGzilOm02Qw5dIbB+RjdM/3k+kJ0ys
         7DehJSXM5tmQfcmoPGPrRQaXUjjtdMQu2dtDbtGoFzT9W+i3G5yrzv8vCul461i3+jqk
         p8qQ==
X-Gm-Message-State: AOAM531ulOp9YU3nkJvc4hy8d6EMEFEtMWv2PzOkuzVUQGKSbjcp2hb6
        7AaSCPjR++8s6h6eNdhQKbz2vQ==
X-Google-Smtp-Source: ABdhPJwcbRlz6GtlXE6hCA1I9y8mE/UIUkbe5+gO/bHoUeZLUVeNr2MArHe8M3l6ClsggeSqqf44gw==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr4415955wrm.422.1599665719547;
        Wed, 09 Sep 2020 08:35:19 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2sm4473335wrw.96.2020.09.09.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 0/7] wcn36xx: Add a set of helpers to enable VHT parameter passing
Date:   Wed,  9 Sep 2020 16:36:00 +0100
Message-Id: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is two in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

V4:
- No functional change.
  Sending out full set again using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908182437.2870281-1-bryan.odonoghue@linaro.org/T/#t

V3:
- Enables MU-MIMO bits in wcn36xx_smd_set_sta_vht_params()
- Adds a set of helper functions. In the previous set these unused
  declarations would cause a warning during compile because they were
  declared static with the intention to add code later on to use them.

  To resolve that, I do not declare the functions static. Static
  declaration is done in a later patch after the functions have been used.

- There are two good reasons for this:
  1. Granularity. I think its important and useful to have a patch per
     function that clearly sets out what it does and why.
  2. Patch size. Declaring seven functions at the time of their first
     use is not good practice.

I think maintaining patch granularity is a good enough reason to not squash
these commits down. It is pretty trivial to declare the functions static
later on without generating compile warnings in the interregnum.

V2:
This set makes a series of modifications to enable passing of an extended
V1 data-structure to the firmware.

A series of of helper functions are added to facilitate the setup.

The final step in the process is enabling the extended data-structure
parameter passing for the wcn3680 only.

Only a firmware that is capable of 80211.ac will accept the larger V1
messages and only after explicitly enabling the DOT11AC firmware feature
bit.

- No functional difference from V1 for these patches
  Breaking into smaller chunks to enable easier review/merging

V1:

https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (7):
  wcn36xx: Add wcn36xx_set_default_rates_v1
  wcn36xx: Add wcn36xx_smd_set_sta_default_vht_params()
  wcn36xx: Add wcn36xx_smd_set_sta_default_ht_ldpc_params()
  wcn36xx: Add wcn36xx_smd_set_sta_vht_params()
  wcn36xx: Add wcn36xx_smd_set_sta_ht_ldpc_params()
  wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
  wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()

 drivers/net/wireless/ath/wcn36xx/main.c    |  8 ++
 drivers/net/wireless/ath/wcn36xx/smd.c     | 90 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 3 files changed, 99 insertions(+)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
-- 
2.27.0

