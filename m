Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42E261A5C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgIHSfB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbgIHScb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C49C061796
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so229550wrr.4
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3s4aFu9WOgZEB/ykUx7rMmQlbdfp0yRUuRJCuSjvOTs=;
        b=HIshVomCeQ2qVybS7PRZgvbOcJHLz1fcBG5oPMJd2ewfPSHVR4DSGi6oi3ZEJ/WSx9
         8eTKjcODDPYRTx/YLcIs4ddVegPmkgWBANuhvOT41zDaWpzHEQ//pj3counFxrykCdBd
         27tWbb9nNLx6pzpE+v/i0tlaH8GFDODGyCT10ID2XrF8F7jyr43r4rz6A+lOXEy2nQTs
         Z6uyubcIIj3yD6iy6ejVG7NDi0Ytc6CLK0hL2tvS4aLiNbmEAA5vI9dfH3xZePnCDcEm
         /KkCh4cQhferVWpotjUOFROz9eS7ydDzdczPB2MO8ftonbQihGfoCXANM8i6ddb2nGPp
         K5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3s4aFu9WOgZEB/ykUx7rMmQlbdfp0yRUuRJCuSjvOTs=;
        b=IlOZUaMhMkBbDK3OB7DMtakBWKjtYe7buCIcuzvh2Jp/DuhGKfe8LnAfhfHpKhhxJ/
         qK/7FVzGO7q7pALBsyGy4uBSl3lLm8zzHbaFEPdvlpjwCKyMXs5IIoudzJ3B+gNC2Yg4
         3dtwKXkb9VwNlJwFGS+S2ziWAjZ/dziuso6LwUGDV8DYpNmIVYhj2MO1cvHa4St0NnBe
         7J5oHFXE8i+ftZaN4CxZ9cRO3yU45LF17rf0L5ME1v0X+zJzR3e0Qw9tOl0vWTWR/VTo
         p9oDm2YvodVKQYktfC0owT1kFXTXG60khe50AFylHcvYbV1aNlZrcqdsV1cBmafwJpGI
         YL4A==
X-Gm-Message-State: AOAM532wfKAY4XT+nhVUQLpAVmJTE4wdLFGBnzMzMZhpqCfrHqRWfj9P
        031cc1CXK6/4l2igBSdt0EHRCg==
X-Google-Smtp-Source: ABdhPJyQVdg/KTL54uxrywFc8/Z0yCpC0mCiCUmzbsPOvT4gJVrW9Es2g4Y8QYEqFh3zu6JDTMuhXQ==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr872500wrq.424.1599589430498;
        Tue, 08 Sep 2020 11:23:50 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:50 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 0/7] wcn36xx: Add a set of helpers to enable VHT parameter passing
Date:   Tue,  8 Sep 2020 19:24:30 +0100
Message-Id: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is two in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

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
 drivers/net/wireless/ath/wcn36xx/smd.c     | 88 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  1 +
 3 files changed, 97 insertions(+)

-- 
2.27.0

