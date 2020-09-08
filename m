Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74075261A6B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgIHSfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731846AbgIHScN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856E5C0617B1
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so205391wrm.9
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGpNsJWqPY/pZ4gHwu2RPvfDfxoHt4Mve4S4jtSFnt8=;
        b=FRlJqbZs5HRjgw6uNrhwF5BsodZy8Xu8sLy/lYDbrPBEDe+ImQMVoc6CICOblczzRI
         lw+b8vUafZh1yaf0t+PxiQxCZ9+v+C/9r7XKmxL7rJYHftduW8bRXkv6Dv2xIu9egbm3
         KKU2WmNp8nNo/QI8T45VQgHYygO6omp67Oi6lbb1FYovxhscrjImd/f6kxql60Oe8qlO
         TQWoZLZ3OeH/mYCKcSOk8DHVg2efpMB1DydCque5EJKBWeEjZO9gJHWl8OPQO5ghXq/I
         f1OG0+lLgH6U3m8R1MKxYOfaw1OAY3qNx8qnHbMCgpX5KvoRfPPk0pkLeiiMnGLmUEqu
         kt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGpNsJWqPY/pZ4gHwu2RPvfDfxoHt4Mve4S4jtSFnt8=;
        b=WxpkK+p6uND5RsKfA9s816bM/hheCDqDJUeehyM/uUugVBXJK0v5A/hPprNs5G8ptS
         FFVszTc0C2He/8yUKydBd4s9eqEgK5Lz6en+WijJJV4Tbihd73p6JIRc6DZ3DdnwjAk6
         gTheotgooRY4zDzE2Kr1P51ErKSvLRI1bsoQ/xadIny0zvR4O6emf7CiPogimxhu5xZ0
         E+uEf/LEnFrj0tenzn4XskjnDG0yWYqo3+RC1Iqg+F3Sy91T2TuJRlX6Jld+r6X7Rk0d
         oV397TJ/eaLhQGSv6c5HcZW200LFSvqcgLA09pFwaiP9fimNyaR2EQi+Ikp1vmzJz7H+
         nvAg==
X-Gm-Message-State: AOAM5326Y3dL4VkznH3mpX6xmMmy8i9oxz9jh4hfPPFv3u2HtORp+QyU
        ggjAUope+/firuZr3QudYBZZZw==
X-Google-Smtp-Source: ABdhPJw3qW5mSWDLFdHWfxfIuMVV/+biZhP/y9zHQ+ZMNIGAAp0+9YWa2bpIJTBEkKwUiDEnqjafZg==
X-Received: by 2002:adf:a106:: with SMTP id o6mr915904wro.1.1599589467200;
        Tue, 08 Sep 2020 11:24:27 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm352447wrv.72.2020.09.08.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 0/5] wcn36xx: PHY modifications to support 80MHz operation
Date:   Tue,  8 Sep 2020 19:25:09 +0100
Message-Id: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
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

-- 
2.27.0

