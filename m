Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8012630BB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgIIPke (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbgIIPgt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886D3C061756
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so2848136wmi.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvvUvEhgziDsAmkcwJk6sQZYqdSGD3IeLCFOO5FY/xU=;
        b=F46x+n66ga1+qgh98kjWmzI0X3NipLcHIYORH3WuZ/++lSjAg7CcgvMWMXvwSMmtqW
         FTWT/0ayWmuyw3D6IpxwJjkPLZlZCcxcDSYotgg6DP2ApJepX+g6e/LUmF9kyrAuCRLI
         VQm3Z9kPahZ5x2agMtkJxXtthTzHhICUPsPTDMagp5XKVs193AOvXkZFCoQ4Vq0MRfcY
         k3zBpFF4/BpQgFekZqLydzofW4GY8Iin9jHQoFLJOXDE9ky1qG561D6wZt8zMIVJEkzR
         pL7645Jb6rQLMF3Pg1066q/84gAjiYTaxtwBClqfIcl8R3wLZYS5I06TFFMlvbr5dvQN
         BTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvvUvEhgziDsAmkcwJk6sQZYqdSGD3IeLCFOO5FY/xU=;
        b=YxzZ/ICNfKxDlmWjtEUVFkWQ8cC5j+Sd8S2PLGA6g6NXlC7Mnh5KGVq8OJ56T/3yAL
         W+bVhbKeOrs6639ExehRinwTavqtaVQfyiE1yIb8fN6avvw6oUthF2PZmfd+qyA7LblI
         LDO5bTEsonpQ2efy72iAb4l8WMocTCsoY3BPGNJGrc0lBrYoiQm2Mm8mHNPT890vPwHP
         pETiNYcXP/7/NRdahAgPDMBQiB+CnNUefw/EuqwcIHTsy2qNJqZ0wm9jPAXUGpCH9EZr
         ZIhXfdWPxAPO51qDagNkiXJw9ZaHCY7YFFayAYindaoHTGNfDg/sg+kUA3L6x9hr+Sh+
         7KQg==
X-Gm-Message-State: AOAM533PX33Ny1DwrR2fFXqPI8oNB06Xm2Rww5ELzyT+hoM3D6LwWIg+
        3XHdR1UUoIvzSwYO3SHUxbgQZQ==
X-Google-Smtp-Source: ABdhPJxjGRVDlI1CI/sGLGofgaGmRGzLMpFGgpgE5u5Bl4UCChTTjfbi7fW217cTKjp9N8UroNV3Wg==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr3995641wmk.97.1599665808214;
        Wed, 09 Sep 2020 08:36:48 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 128sm4470602wmz.43.2020.09.09.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:47 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 0/4] wcn36xx: Enable VHT when supported
Date:   Wed,  9 Sep 2020 16:37:32 +0100
Message-Id: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is six in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

These two commits have been moved later in the set of commits so that the
patches to enable advertisement of VHT capabilities happen after all of the
supporting code has been comitted.

V4:
- Missed inclusion of these two patches in V3 versus V2.
  wcn36xx: Convert to VHT parameter structure on wcn3680
  wcn36xx: Define INIT_HAL_MSG_V1()

- Generated set using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908183331.2871016-1-bryan.odonoghue@linaro.org/T/#t

V3/RESEND:
- Messed up my .git/config resending from my @linaro.org address

Changes from V2:

- Rename "wcn36xx: Add ieee802.11 VHT flags" to "wcn36xx: Advertise
  ieee802.11 VHT flags"

https://lore.kernel.org/linux-wireless/20200829033908.2167689-5-bryan.odonoghue@linaro.org/T/#u
https://lore.kernel.org/linux-wireless/20200829033846.2167619-4-bryan.odonoghue@linaro.org/T/#u

Bryan O'Donoghue (4):
  wcn36xx: Define INIT_HAL_MSG_V1()
  wcn36xx: Convert to VHT parameter structure on wcn3680
  wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
  wcn36xx: Advertise ieee802.11 VHT flags

 drivers/net/wireless/ath/wcn36xx/main.c | 40 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 26 ++++++++++++----
 2 files changed, 60 insertions(+), 6 deletions(-)


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
prerequisite-patch-id: 143a1019813b7e4974a67e9eea1f1d599c0fdfdf
prerequisite-patch-id: f66d9fe9eb731272b825c9430c15dca89d6c6129
prerequisite-patch-id: c8c2d2dd1452c357f73fc4c92e5b564d59a05562
prerequisite-patch-id: 273c13464a69354d32790ed7509472d9c2b11231
prerequisite-patch-id: adbde1c98b85a16a6500b4210d4f055b9493418c
prerequisite-patch-id: 559b6f9af6b26f860896dea4c7eb385ba9bdf0d5
prerequisite-patch-id: 94c091c0c78b754d4c842a097a6db126bf6e770f
prerequisite-patch-id: f2e549349c09f4675775b40bf9bb9b1f2bec6db8
prerequisite-patch-id: c3a6aa788141f5b8782d28dac264470c8081bb97
-- 
2.27.0

