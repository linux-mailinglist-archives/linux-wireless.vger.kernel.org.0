Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2542F105C5E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUVzU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40019 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKUVzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so4383658otq.7
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYiPnssT0dAgGr4L4yOVWPrzWFKvnJsOKHP6Dsu7FXo=;
        b=obIUtP1NMe1y2sBLOT/soUZxTr7jNa06XIWNQyJzNVrvEOjEsovX0Er5+dCrvYoqX2
         RIPEKzlqmLD+oYpcIIByCpTCXpui76oV1/yxyNw0KAyzj9IyG/OR3XhqNY5mgCSUNlW6
         EgjLBiadd4CcqYo3FwVSS5sx36O0KeWR6vgpbyCaQnZ/3ZNexHXHYUCyIJfaaDImy4+b
         67CwtwwQgnRSKweLy1DInhbmyNJJHzsRtprjBaKWrwxRs8NfaRaFnVktS/AwQX7shsnm
         EprANwEPJJOcahVddP8TH2lpWg0XLF+Kx1KOV59iUeQnipNoltNgYe1gI2cIZa3Ebu+q
         28jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OYiPnssT0dAgGr4L4yOVWPrzWFKvnJsOKHP6Dsu7FXo=;
        b=loMX7osgffjkx9WzZcuMxg9BZic15cRV6uz0uyJpYs7HcUCSF5s3OBvkBP6sWoKdjy
         K+peJ3y1jsekrN763d+tUIc4csZT9tCTqrnr3PWS49ZJAXXwLruGd/8vCsrRXo9KI0b5
         rVoliWYuLcCuKpu4/3MYm6tEz7/QpfSB5JEEZ5CHOCTskxl1jyAP0zvgYVdli88pSPQA
         3bmpWsbBcSiXgYUULLrpauMx5D+7PlVsdU6Z6h6zVTPxA4aTrOZsJ73Z1O8NV720sFD/
         TgJm9j8zEadHuMa3ck8MmtckP/ZHsO0wf6LPGN9y6pDTdKa5BSIfoapg2Sg64Qq68LK3
         FaJg==
X-Gm-Message-State: APjAAAWsaoW8qTEeiA/Qw1TLdXEbylt6NB7ZOIp49VBzSKkeTezCvckN
        esYKgWbEs0SsRH8a4gnpxKoLoF/F
X-Google-Smtp-Source: APXvYqxfy5SM5iaCo4zRUhtLS+/YifYEUeoW2o44xqbxS9NWIaNXnQAnsLP1WOt6oV6XWaP3s3dj0w==
X-Received: by 2002:a05:6830:1da:: with SMTP id r26mr8448062ota.186.1574373319358;
        Thu, 21 Nov 2019 13:55:19 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:18 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/9]  rtlwifi: Complete removal of local bit manipulation macros
Date:   Thu, 21 Nov 2019 15:55:05 -0600
Message-Id: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These patches finish the removal of the local the bit-manipulation
macros used to set and read various quantities.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
Kalle,

There is no particular urgency for these patches as they are part of
a general cleanup.

Larry
---

Larry Finger (9):
  rtlwifi: rtl8192de: Remove usage of private bit manipulation macros
  rtlwifi: rtl8188ee: Remove usage of private bit manipulation
  rtlwifi: rtl8192ce: rtl8192c_com: Remove usage of private bit
    manipulation macros
  rtlwifi: Remove dependence on special bit manipulation macros for
    common driver
  rtlwifi: rtl88821ae: Remove usage of private bit manipulation macros
  rtlwifi: rtl8192ee: Remove usage of private bit manipulation macros
  rtlwifi: rtl8723ae: Remove usage of private bit manipulation macros
  rtlwifi: rtl8723be: Remove usage of private bit manipulation macros
  rtlwifi: Remove last definitions of local bit manipulation macros

 drivers/net/wireless/realtek/rtlwifi/base.h   |   4 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c     |  20 +--
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.c   |  12 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.h   | 103 ++++++----------
 .../wireless/realtek/rtlwifi/rtl8188ee/hw.c   |  11 +-
 .../realtek/rtlwifi/rtl8192c/dm_common.c      |  19 ++-
 .../realtek/rtlwifi/rtl8192c/fw_common.h      |  14 +--
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   |  11 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   |  61 ++--------
 .../wireless/realtek/rtlwifi/rtl8192ee/fw.h   |  36 +++---
 .../wireless/realtek/rtlwifi/rtl8723ae/fw.h   |  14 +--
 .../wireless/realtek/rtlwifi/rtl8723be/fw.h   |  30 +++--
 .../wireless/realtek/rtlwifi/rtl8821ae/fw.h   | 102 +++++++---------
 drivers/net/wireless/realtek/rtlwifi/wifi.h   | 115 ------------------
 14 files changed, 173 insertions(+), 379 deletions(-)

-- 
2.24.0

