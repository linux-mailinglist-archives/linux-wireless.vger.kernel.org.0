Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F80263397
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIIPha (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgIIPfK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21FC061757
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so2724561wmi.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsBk9ZTmHyUEKaf1VR1wQ9lGXpW7Dr+mR+KO6cJf93k=;
        b=brDiTtlkjOGzwQMsjhtrpJ7bnVDKB/AsCS0dxyu55LZqdmegTe2R0H5YjYWpS00R97
         WoWEVgABeLz3c+cmWf2BJ1jXp7h0i0Yg93Nym1h5zB4dXfM06meShNpcVeEGfnKwE1Lh
         p/vA8S0fpqPJJh7tvsh9MbNeA8nOTDXDJruSFeGcwkm1EkGtc6fDS7opYd1BH3fuLoRO
         34UmWbq3NFB83xnAKX21t/Lo2mgrFFbwBkskBdkT7NHRjg/HIEwG79SxpPCWXtWy8GW6
         XuNwId0a02P1W8RkTDq7NiE1cv2Nxc3dsUFuxwQ8cLmrdCRImuEoJmtLWO45QaC8Vxiu
         LcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsBk9ZTmHyUEKaf1VR1wQ9lGXpW7Dr+mR+KO6cJf93k=;
        b=G4A0WM2ImVfMh2i7PfHpvOHUfdLtMEMQ5EInZt+7LgIqvuB0/65pVlDEX3EVeY9fIt
         ijmrF9K6i4khm2V0K6dLckCpvELzBzGIYlh2tVvsv7toNGZs6AKpn9EQgfFQW0trXI15
         ZCkbYoKsrjpw0PtGZpmN5xKvNPn+wlZ8WyQOSHvCHfK/unIC3+1roiXbLxDRmTAWyTY1
         7EQv58MyDTqrTE0Zanuah9VmrLHpAoaCD3SmAxivTUmjxcGgd6XnjHPhb14kyudWqpuf
         YVylIR+YS5j9k0sSl8LxJ5Z2kuRW/RA76XyOwBHJjNkFug5Bt/jY9cVIYuvXw3XcjJcj
         iJNw==
X-Gm-Message-State: AOAM532WyVLTd3ewWEMC92aeSA68oAiPN1JFVYaVhEqD+VqUORAhtZgp
        hy0OUgZ6xmBKZXglrNIudYmFkPGj4bEE7w==
X-Google-Smtp-Source: ABdhPJwbpnLsbwq32s0OplogfUOy9wBshk8OXgDQ/SQ+uLr9n2GaU4hUQREdnwSQP6UHUiih1bKRaw==
X-Received: by 2002:a05:600c:2155:: with SMTP id v21mr4347569wml.118.1599665705990;
        Wed, 09 Sep 2020 08:35:05 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c4sm4922120wrp.85.2020.09.09.08.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 0/2] wcn36xx: Extend V1 data-structures
Date:   Wed,  9 Sep 2020 16:35:52 +0100
Message-Id: <20200909153554.2904762-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is one in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

V4:
- No functional change.
  Sending out full set again using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908182428.2870226-1-bryan.odonoghue@linaro.org/T/#t

V3:
In order to pass VHT parameters to the firmware, we need to extend the
parameter data-structure. In the V2 series, this was accomplished in two
patches.

https://lore.kernel.org/linux-wireless/20200829033908.2167689-13-bryan.odonoghue@linaro.org/T/#u
https://lore.kernel.org/linux-wireless/20200829033908.2167689-2-bryan.odonoghue@linaro.org/T/#u

However since I was rebasing this series anyway I thought it would be a
better idea to do the conversion in one go, so that if someone is
rebasing/bisecting in the future every single patch will still be
functional and testable on wcn3620. If the data-structure is extended and
then the code is subsequently updated, then the patches in-between the
data-structure update and the code update will not be testable on hardware.

As a result I've opted to front-load the conversion. The first patch is
atomic with respect to ongoing functionality on wcn3620, which I think is a
better result for not much extra code.

The eventual enabling for wcn3680 comes in a later patch in a later set.

For a similar reason I thought it best to front-load the conversion to
using the extended V1 data-structure for storing parameters internal to the
driver.

Bryan O'Donoghue (2):
  wcn36xx: Add VHT fields to parameter data structures
  wcn36xx: Use V1 data structure to store supported rates

 drivers/net/wireless/ath/wcn36xx/hal.h     | 14 +++++++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c     |  7 +++++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
-- 
2.27.0

