Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F992633B3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgIIRJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgIIPgN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2110C0613ED
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so3439188wrp.8
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FoBWz/HuXCSj34hndE9AQdQ7FOo0tm240K7lkUOWDyE=;
        b=DDeLUdKfoKys+iVA9ZyaME+/++JXoHB59JIpL9uU6NhtFxZiH46zyk10Jop5H8WY6S
         fvbDg2kaMUu/r3rdjjAyA7MGWsxlX91AP/0pyG+LValUlR/RU18heR9ClJUDlHhTZ2af
         3+W1yIEKf047CHFl7bap0pdIPUjRkXAUsNfdKs5olPwjXUhh6WX7xqfebosiaa1nn80i
         vG9DGNVubMLC93GMi1NetcFZwMJ/pnjx7BvPmB+/AxhyEUQdPLsZNTdVju1A+Y06VpM/
         NcjbYFbq0JJUvzqVi2iTRn8gi06C0jDE9rNW/ntfeHHwjP1aDPdrX8Y5qNMqmPqSj8Q2
         mUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FoBWz/HuXCSj34hndE9AQdQ7FOo0tm240K7lkUOWDyE=;
        b=m/FAFSUem7478UimaCEmvYhcRFFk+zXRuuC5xt0QLPPLGK9X7EAoYw3pNjslZkurSJ
         NuFofPHUP2JQ+PsXZYqm6H16qPJaiHxuQC9EGueeFw/o40/JnBzvk+q5VAW+DyjuARHc
         sHUY8yuVE7kKSjW5M/RIdMB1a1d4quV8gwEKyKpEC7rsjfBV7u6YSpu33vv3JLUKbslR
         4wKZJKKV1ytLaoz3MfZNN4jKvGZB658jGLvzUAXPQiQdgIRy2z0bmS6xWwpK7mUTOnrr
         b4DSuO0qfQRVB9If+AuMnF/lYcnknJUPf7Mk/2EybsdtY6a0Ettx7vYSnWO0EiDebBkw
         Spkg==
X-Gm-Message-State: AOAM532qP5WPNRpebZWFHJlhOe2io8LLcevjVsKrhg4GSxsvTFjUKGm0
        Tmmqr5aWUDyemjyc9KHXuTr3uQ==
X-Google-Smtp-Source: ABdhPJxouubP8qX5IJKFVIBHZJud1i8BDphNWpGMbotomve7QUc8obih9XPbUQO4C2Yx340uEvzTIg==
X-Received: by 2002:adf:912b:: with SMTP id j40mr4602964wrj.42.1599665771357;
        Wed, 09 Sep 2020 08:36:11 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v204sm4619807wmg.20.2020.09.09.08.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 0/5] wcn36xx: PHY modifications to support 80MHz operation
Date:   Wed,  9 Sep 2020 16:36:55 +0100
Message-Id: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
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
prerequisite-patch-id: 1a7fb93ee5874d2d011409eaed0b4fd764666b9c
prerequisite-patch-id: 77cc008b21a650fa7a33c4acad2fb632b09634fd
prerequisite-patch-id: 988ae4802971d6895b03b2752122b2be42baf188
prerequisite-patch-id: a3ba2a1963e03e23e86c937cd4cfb649e1b819b2
prerequisite-patch-id: 8a1fe4f63bc80e9a8035aa52356da8c46eab8665
prerequisite-patch-id: d75c1a60d1ede373c1f3eb684bb15c853c88eedc
prerequisite-patch-id: 47145acae6e24e8e6580fca1dbddfbec24f7b50b
prerequisite-patch-id: 8c66bccb923be821cf109a3a0d3a1a028edb4930
prerequisite-patch-id: f078e5fdfe8c18936469bfb118a964db13ea729f
prerequisite-patch-id: 746f63cf58fa3bf62736435c81dba2558aba8e81
prerequisite-patch-id: 36a94e202cbdaee8e06f9a108b1c894bd1159e62
prerequisite-patch-id: 8a598e22a08b0ec233d0ec56eeb53673eb1b8feb
prerequisite-patch-id: b0eba574ddc35ecec2d0e39c0d3351d1b260420e
-- 
2.27.0

