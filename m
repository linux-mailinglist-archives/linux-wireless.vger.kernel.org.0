Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92FC2649BF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIJQai (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgIJQ1h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C2C061573
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so388325wme.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mL4mzudrzXf2cUTx9eQ/J+GPxyAkKkLNs3IL5Bs2Jrg=;
        b=FhpAm/mF2S0ktfsReBCbwmNFlAi5VPzeXlMJMmtmVLby9qk8bR0fJkQEL3UY+s1Np3
         vLce65hZUqyLXnzoSKTWZpQxyMN1VhVUmzvlEweZ8cf2lSI3KN9I1ZpXaO3d4V/lI6wE
         f+LwN9N41+i1LOJFI3g2mMpeNCNhm+f6+oWCsdIX2VSuUPnHUT7LkYVLHUmMtfJ/t0W2
         OHIAnJMQUxoxFY3WApy7e7S1CI+PYqxppde+9p6gdoj3IgudYh+feFyVGJRqF0+S+AGs
         ZEM1KeZjVXGdq4FnZp6m2iTzqIm+itiJ+aBjU6rP9J7wCNNcfmNep9iELlcmAv6ux/yx
         GVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mL4mzudrzXf2cUTx9eQ/J+GPxyAkKkLNs3IL5Bs2Jrg=;
        b=XQ8DwWOxnOHAB6WkBDKUdlYs6xSVfZ2fsmjsN47fEmyi9BPPzM3Sc0r0RcxtUtJ+f0
         4xW1xk1R0ks+c/HZ837TmpSI1v8DLJvE6135K8Ahq/8COblv/qPLhtnfoU7iHGMOgs8f
         fwi9NnJjqBX7CwCPUk9t6gv0Rf6xJEXwBVMHL+0L2JxSFYIUjcFYe5rA+pTn2pN9ECAt
         r1jZ2AltHXzRbctvFtez9dPn4QbhjfJsCOTfW22jIgM3+7W4+fV2UHlfpTOhsCNaqWCe
         SUHq1c9WnMdSvRMXzS3/g2YVFnLWwXXAHLMsgCzaLWFJV2BNSqKfkRC1OrVKeo4Pslif
         X6Yg==
X-Gm-Message-State: AOAM532muZbuOi0xs36iNNobSH3/eSHoZ83C+BiS1BETOUfTFjofIQE/
        HPSDKhpOSdb8Shct8sjSvgBurq/m+rnt9g==
X-Google-Smtp-Source: ABdhPJwuKKuALwNUcm2VKp7y95gpBWlgd+WkWKrGE1fpOQiOUaE2aET0atnB7uesn5YmOnfIl3USww==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr454417wmj.174.1599750304517;
        Thu, 10 Sep 2020 08:05:04 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g8sm3852620wmd.12.2020.09.10.08.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 0/7] wcn36xx: Add a set of helpers to enable VHT parameter passing
Date:   Thu, 10 Sep 2020 16:05:45 +0100
Message-Id: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is two in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

V5:
- Fixes -W=1 warning caught in later patches by kernel build robot
  I'm still declaring these functions standalone for the purposes of
  granularity and bisectability, a later patch makes them static.

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

 drivers/net/wireless/ath/wcn36xx/main.c    |   8 ++
 drivers/net/wireless/ath/wcn36xx/smd.c     | 108 +++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   1 +
 3 files changed, 117 insertions(+)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
-- 
2.27.0

