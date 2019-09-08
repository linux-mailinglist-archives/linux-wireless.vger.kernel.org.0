Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA6DACA85
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfIHEDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 00:03:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37273 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfIHEDk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 00:03:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id s28so9410287otd.4
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 21:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3ji1396mrbGrG9UIB/LlPR5QYTb78qbRQ8vCNITcMA=;
        b=sUJA7GiFxtAMLakxeRi8H8g9Il2cDO1NBkwS0qDnVIggq9jGisibNeG0yQ8VyOjy3u
         3NgRHE9iKSGajArjHPwh0e9pABgJRNno9/MnT3livMORNr2TxKFS0h/0vu5AaLo4daGy
         0KjTd75VPbD0ZyQAxhzZzdxzFQVrCtezZ8xDj7tF8xUJCvPo99q0WWl5dLRbkvokBSAw
         68AU7fAIOCXRJrnEkmXqDaJvf2FQI9OYUV2ixq9QdWJ+S8JV2EoFzYf67S750vzhUmdx
         BnmGmF0JvhN4fyOxrEZ/xoklyzxo61AKe/QDEIezvyRNjRy9WUL4wqbnqjpTqj1mrf9K
         65rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=d3ji1396mrbGrG9UIB/LlPR5QYTb78qbRQ8vCNITcMA=;
        b=WeJTANNOdSLqMajC57y7EVguSewwGlJSZtXReOwCMafA92gWdamliC8WiA/gXtVZmB
         +Q0wG1/Ysp2sF2wY3CfExDBMXtROefa7sQckap7/woNz7HP4OEcOwXars23DzWuFyYyu
         1xoZCvPOj7uhFW0mf0TUkeiOOFlu9yd48vEKZqIbGBewUWMRn46r4MuJR8v+E3aVNvqD
         1RxwvBzm5upZi2fuCPzUw8xXk7ziUUJ6UNIaiAIvI5mCge0o7ONXO2CvoftioLGgPIKf
         UsDEh83KtnRSjBZgMbwozjhdrnwkXeYkTEpQ4zTo9RNaD+03p9/hc9meR1dNO0MlsitA
         qs1g==
X-Gm-Message-State: APjAAAXt9qUcR86CQ3TDYKsN85/WYSuGScr4O8VeBuPeViyNn+HsgrFU
        2TrsqeXykRGwAioFsfc8R+5eHYys
X-Google-Smtp-Source: APXvYqzc6T1OjEhOQrpaDDwvrzwmUFgmFcV54SJwpSq2A6raCSRoH4X9rorc9+3xTuLq3Mv2X06QCQ==
X-Received: by 2002:a05:6830:c7:: with SMTP id x7mr14278727oto.241.1567915419790;
        Sat, 07 Sep 2019 21:03:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x80sm1419178oia.37.2019.09.07.21.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 21:03:39 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/9] rtlwifi: Remove special macros used to manipulate RX and TX descriptors
Date:   Sat,  7 Sep 2019 23:03:26 -0500
Message-Id: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These patches continue the set of changes that remove the special macros
to read or write the RX and TX descriptors. The bit manipulations in the
__le32 words use GENMASK() and BIT() operations.

The final patch removes unused macros for C2H operations.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (9):
  rtlwifi: rtl8723ae: Remove unused GET_XXX and SET_XXX macros
  rtlwifi: rtl8723ae: Replace local bit manipulation macros
  rtlwifi: rtl8723ae: Convert macros that set descriptor
  rtlwifi: rtl8723ae: Convert inline routines to little-endian words
  rtlwifi: rtl8723be: Remove unused SET_XXX and GET_XXX macros
  rtlwifi: rtl8723be: Replace local bit manipulation macros
  rtlwifi: rtl8723be: Convert macros that set descriptor
  rtlwifi: rtl8723be: Convert inline routines to little-endian words
  rtlwifi: rtl8188ee: rtl8192ce: rtl8192de: rtl8723ae: rtl8821ae: Remove
    some unused bit manipulation macros

 drivers/net/wireless/realtek/rtlwifi/base.h   |  27 -
 .../wireless/realtek/rtlwifi/rtl8188ee/def.h  |  29 -
 .../wireless/realtek/rtlwifi/rtl8192ce/def.h  |  33 -
 .../wireless/realtek/rtlwifi/rtl8192de/def.h  |  31 -
 .../wireless/realtek/rtlwifi/rtl8723ae/def.h  |  31 -
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.c  | 212 ++---
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.h  | 794 +++++++-----------
 .../wireless/realtek/rtlwifi/rtl8723be/trx.c  | 236 +++---
 .../wireless/realtek/rtlwifi/rtl8723be/trx.h  | 718 ++++++++--------
 .../wireless/realtek/rtlwifi/rtl8821ae/def.h  |  31 -
 10 files changed, 922 insertions(+), 1220 deletions(-)

-- 
2.23.0

