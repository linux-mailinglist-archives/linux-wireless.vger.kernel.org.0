Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA722C2E4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 12:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGXKP3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 06:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgGXKP3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 06:15:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51579C0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so7773912wml.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qs6BR4el7anmcaF5o/42Yf/+zTlR0nDHk0hbGDcqlnQ=;
        b=FLavtlC2aauJwyxlYTlyy00sJQZV1ockGp2kNVapCorrzuss7tOgRhgySY4zWVS85L
         C4Upg626spKv3o2lQYJY/AhCnBNLi3vYo+xKvNOYLEK1qY6T1qYlzX9zAf5SHHIy0lLS
         bRHhMoHOyV1KwKoAGmVk1jQlB8QEvlLWno+75f19tfKkIqrD1ERUCxMQI8gwRQFjoiqy
         GzHDFcGBuO2BaIggjD6UP0D2toiH7cjIyjXrBI6DVbjsGwsMmQcdaRfEaY1/anPUcRw0
         5TucrBOLv8OXZYCfIk2mZJ9xvFah/UcrGeC3Opb6lfLgZj7bv1Wv2czSsEB6sEotu/FG
         uN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qs6BR4el7anmcaF5o/42Yf/+zTlR0nDHk0hbGDcqlnQ=;
        b=ES661/eWlOu29FIuDQUVuC6OUXsx8a5A0UPTlQSEn1XvqnZFDOwwpIfntTJ1os/1aD
         ejSo+9FBSf9js/FK3tckmq/6wP6H5aS2AYEVJ6Za8ai4GueKZq1lxzQiTrjrJ1V3Ss9C
         YIxZWK+Mz6d4jL8x3vRlJTZJ5V7Cd2HeBLRr/LGVa8NP2EDyhq1TCmRpTJ5CVeaN8sIV
         Xn+YoAmCllCjHAOssIw4+599YrCv4YfUyi1SmvpRVIU+EaUDe66MeT59yJUqiRdOZs/r
         lq7tji2ZLEFTTsVz6YD9YKQ18et8L4iDdePkVcOXv8USKNHh5HkuPgdUexsxF4o0L/pp
         YqGw==
X-Gm-Message-State: AOAM533yM8fPqG+acq0tcn8aKXlbkLPbt87VBPmLiuzJPdUU3e4qik/i
        vcXnr7HjCC0efsvCbbYTjv1VVw==
X-Google-Smtp-Source: ABdhPJwqc69E8jbV83lgQHDGQvyjwdDUwoSHk1KPADMNqGIeK1dQx3mLWIHzop3UDKM13KaS6F/PQg==
X-Received: by 2002:a1c:9c0b:: with SMTP id f11mr7922775wme.0.1595585726986;
        Fri, 24 Jul 2020 03:15:26 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id d18sm774714wrj.8.2020.07.24.03.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 03:15:26 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v2 0/6] wcn36xx misc fixes
Date:   Fri, 24 Jul 2020 12:20:46 +0200
Message-Id: <1595586052-16081-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series contains various fixes for the wcn36xx driver.
This has been tested with wcn3620, wcn3660 and wcn3680.

v2: - Move TX retries change into its own commit
    - Additional patch for sequence number assignment
    - Reword TX ack commit log (timeout detection)
    - Fix checkpatch issues reported by Bryan

Loic Poulain (6):
  wcn36xx: Fix multiple AMPDU sessions support
  wcn36xx: Add TX ack support
  wcn36xx: Increase number of TX retries
  wcn36xx: Fix TX data path
  wcn36xx: Fix software-driven scan
  wcn36xx: Use sequence number allocated by mac80211

 drivers/net/wireless/ath/wcn36xx/dxe.c     |  57 +++++++++-
 drivers/net/wireless/ath/wcn36xx/main.c    | 172 +++++++++++++++--------------
 drivers/net/wireless/ath/wcn36xx/smd.c     |  59 ++++++++--
 drivers/net/wireless/ath/wcn36xx/smd.h     |  12 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c    |  57 ++++++----
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |   7 +-
 6 files changed, 241 insertions(+), 123 deletions(-)

-- 
2.7.4

