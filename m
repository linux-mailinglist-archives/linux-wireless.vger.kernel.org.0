Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1230E25647C
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgH2DjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgH2DjC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1462FC061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so887866wmi.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6C+RlpuxfUTNBjxdsuDscPKf8gURD41UbbOvyjhZ5UM=;
        b=zhnoq0Qqfub1YBnDDb4CW5Uej7EaCQW/r2heI6IJzXhQV68dP5UIkV+Y6/dKNBfDKr
         SBKvoagSd0YoaZZ9TKJFEQVzSxybVQfdK/JKLSiRWL8n8gBKI1r/ywdlFmach8RUnrMS
         siUYQEE0tcmTGoIfhHA8g/Lr+sngW4eoOpRVadPo9SRoNqkyIUBL135aa5bRXrovQSW7
         rRDUcxPlR6rKFJ+igd7H+WkveQoqec0lt9V7g7sYXvzaMEBHWSFcF356sBbAFgrNDi7v
         3lCa/1Ztq0Mfug5C/i0Qip3PH1up60i1da5QyDOsP4U7o4Pi2NeMp9cL/VE2G231bFFn
         lO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6C+RlpuxfUTNBjxdsuDscPKf8gURD41UbbOvyjhZ5UM=;
        b=PUvhOgOs35ByGtu2DuZITGIQEJq45fVlqMrNYPQqcoF7/oU1c3hmsUFKPcit0Xj5cb
         +Z9Lobxc7WGuuIT/mQRWcFh7WGIZ4Rbia6/JIjPxZO0S3V7jDWRk4qMjeCyXQZJDUpR3
         21m349zxorU8/CBYcBCM30ApUjsj/WoL99FVUnKmSrypsu8yNRu5qN4Gk1TZtqiG4PZO
         gfOXLJR/zlyr8PWvlKZszF+P2bAQldQRX7w+5lJeBkKbMlwzB1UohHfmMK5NTCfOQYD8
         zVY2JwrNEh/1Zp2dAvFbiU+H6mMbyIetUTin+2W9qPUXjToESoAcnerXWqDRYb0BhtGu
         vsZg==
X-Gm-Message-State: AOAM530sI4tKvDqDr6PA4H61JMP9Ij8NhZr09uaf8eUP30MA59RlJp+p
        iWdNEIC1F62e2wQCx2oX8qihBw==
X-Google-Smtp-Source: ABdhPJyWXSy8ExZ1MdVnmka39Szc40bugysTRV8KTCfeLGJFz92WtD3rkhpK5+eUClEqKzO0HIdlNw==
X-Received: by 2002:a05:600c:410b:: with SMTP id j11mr1556880wmi.38.1598672340781;
        Fri, 28 Aug 2020 20:39:00 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l9sm1732151wmh.1.2020.08.28.20.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 0/5] wcn36xx: PHY modifications to support 80MHz operation
Date:   Sat, 29 Aug 2020 04:39:42 +0100
Message-Id: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is four of a set of five to add support for wcn3680 at 802.11ac
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

-- 
2.27.0

