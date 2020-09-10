Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0932649C0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIJQal (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgIJQ1g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888DC0617AA
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so361361wmj.5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKhb1tlaziAq0yvNnW8uGhduqVdDMEMiKkNRMF7ABhE=;
        b=vN9AOJBRJveHlpA1HDYLFrt+U5bpeqKGNP5MFjvT4IAFXBseP9NKZENVwTgzD0TB5p
         RdK+JOBhi8uRblovCY8mfxo7jptQtTACxAPpwBvUCPedAZp9FwsnJME0Wb/fKlXWdYGh
         5yw4ZYTAa6udWosZ7xSGhlrBJ2ZjeM9P+JeAg5my6OC0RZ7tCHB+YmZ/fhcO3eWmNVbD
         L8kCdqwjNkXQXpDoEIjvf3clU01TuKOapb3pGRHOwl7wyXd4Gw+EAalqIWTLg6CDVpKl
         cn9mNSGqqr9E588deEj8+B+gv6+L1CRXWtK7yxkWjHrbjyQsfuZ6wv76SISW/5oxTZMA
         98Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKhb1tlaziAq0yvNnW8uGhduqVdDMEMiKkNRMF7ABhE=;
        b=RINL6y21xWym6LEufqKCCBI+aXicM4KCPr8poiArBDYaa7v7XEnSfNPD5UszU8BIwk
         8n/FvF2AtdkMI+6B27nCVnPcgxZzZ+SGy2Toy1alSOsuBEbJ7D46K/KLA6K6atsv0arV
         DHj3k6xzLg7EU9+6qPRXluX06R8xq06dFdkYJLSqVLZw0YuOmoMdznc0NQj++bmjYp8s
         VaBZoVFqLKn9YDVNZHtKB6GNPRuvnScUBK4iqyT+6ZgDirGtorzCKVTT5u1EbYw3XmYn
         CZr8rpZtIYsuJcyujETZqfvRcrssO3sfO0ug6m94EgX/0zZtYoSArcBS85/tHTtjOhMV
         mWMA==
X-Gm-Message-State: AOAM532MW2DF0hXqPQXq9gMx5q+hP6uSozXHMZxCc5dEWT5GdekLW50U
        QfbCLurKGdQODPtKlAfh0oJaaA==
X-Google-Smtp-Source: ABdhPJz62e4pkDJxD+FbqAkn+fZMzNh4b0KWd3ZB59jDpSqf6jSei199cSU2tEx5L1Jc4wDiKBoIww==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr506019wmj.68.1599750380692;
        Thu, 10 Sep 2020 08:06:20 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i11sm8778906wre.32.2020.09.10.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:06:20 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 0/5] wcn36xx: PHY modifications to support 80MHz operation
Date:   Thu, 10 Sep 2020 16:07:03 +0100
Message-Id: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is four in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

In this set we add the ability to configure up the wcn3680 PHY to get onto
80MHz channels. To do that, the upper unused bits of the hw_value field of
the struct ieee80211_channel are used to encode additional PHY settings.

Accessor macros are provided to encode and decode this additional
information. Depending on which channel we are on, we need to configure the
PHY into one of four modes representing four potential adjacent 20MHz
channels.

The modes describe where the primary channel sits in relation to the other
three channels giving us 20MHz + 20MHz + 20MHz + 20MHz to get 80MHz.

V5:
- No change to V4 but need to send the set again so that
  prerequisite-patch-id makes sense to the build robot here.

V4:
- No functional change.
  Sending out full set again using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908182514.2870410-1-bryan.odonoghue@linaro.org/T/#t

v3:
- No difference between V3 and V2 below
https://lore.kernel.org/linux-wireless/20200829033947.2167817-1-bryan.odonoghue@linaro.org/T/#t

V2:
- No difference between V2 and V1 below

V1:
https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (5):
  wcn36xx: Add accessor macro HW_VALUE_CHANNEL for hardware channels
  wcn36xx: Use HW_VALUE_CHANNEL macro to get channel number
  wcn36xx: Add accessor macro HW_VALUE_PHY for PHY settings
  wcn36xx: Encode PHY mode for 80MHz channel in hw_value
  wcn36xx: Set PHY into correct mode for 80MHz channel width

 drivers/net/wireless/ath/wcn36xx/main.c    | 50 +++++++++++-----------
 drivers/net/wireless/ath/wcn36xx/smd.c     | 15 +++++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  6 ++-
 3 files changed, 42 insertions(+), 29 deletions(-)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
prerequisite-patch-id: 9a4ac7faca179f6594c9b3a115ee69a2da540a69
prerequisite-patch-id: 183286f9c22d1aaa12f356651224e6b337ef1938
prerequisite-patch-id: af468d413daaf8d2aad195fcb43c6e66390d8468
prerequisite-patch-id: 08122a9557904ce5358f52dd08cc33270fa202c1
prerequisite-patch-id: 82e0b7c5b2e9fa80baca001cce12577d98e306a9
prerequisite-patch-id: 8ee7f5bd6cb5b7b7d713947b554ad93bb90d8230
prerequisite-patch-id: d05c2253e4523b05b2e43491aa13ceeef68fd2f0
prerequisite-patch-id: 8be29513d3efa64df15297bcf81ec3db55088ee1
prerequisite-patch-id: d267dcd834afad75a69bcd2adcccfdad6566a7ba
prerequisite-patch-id: 47145acae6e24e8e6580fca1dbddfbec24f7b50b
prerequisite-patch-id: 8c66bccb923be821cf109a3a0d3a1a028edb4930
prerequisite-patch-id: d0f5f3769b2963208fd2348840726fa1d3501b63
prerequisite-patch-id: 746f63cf58fa3bf62736435c81dba2558aba8e81
prerequisite-patch-id: 375bb7847ae74c63d2eacdbd0d73371aef1546fe
prerequisite-patch-id: 8a598e22a08b0ec233d0ec56eeb53673eb1b8feb
prerequisite-patch-id: b0eba574ddc35ecec2d0e39c0d3351d1b260420e
-- 
2.27.0

