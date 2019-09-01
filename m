Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34EBA4A1C
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfIAPrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 11:47:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42500 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfIAPrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 11:47:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so74806otd.9
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YFqAVTwF1NLxHJFbD4Ro631AGMiWCtNnXDK+T4vOGqg=;
        b=lesnYIS5GWUyt2gnu6jPgXF7gfG7MUgdkvb8L7dTWc65Ci16s/7P++sOCZSLoJgXS+
         4Y8hq0AIOyz4I+Sh7xtHL1EnvjgWD/6pp3mYBXcWZRK7Picf0TfW2f/D0padw6/O63jh
         3wBgLr45RoE2ocgyV4NVMEy8YkHRrRjALeDBywQ+t59MRV9eekCzbdsDirS3RkbipaeI
         Mummd44FeMZCgtgCgSV45ea2EAV1TxYCq4ZDlF4mqUwxwBR+4c/PWSlw8aZHFk3pwgOu
         YhqCu0qHSnkvRRNkgfzHyugEbXv/VdQewSWoLbSbzqzIEh8sllacddJgRgwi/QsHh3gi
         l/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=YFqAVTwF1NLxHJFbD4Ro631AGMiWCtNnXDK+T4vOGqg=;
        b=aVmAgaQv1bva2X30fVWsFOm5lZXNAV73L+U2xm7uKVXP5OGeGcfdI9FXPE31XxFBjJ
         B1XKNinOhvs9wOmUZ/4i5N/nmBVzEiG9xr+f0i/HS5+nkUYoyraGuAZtjkZQFK7F8Dy5
         KWZJNIbJcNabqHDFp8H5u8A5Fg2edwIF6DlMPoernSRzg1KBbnmfq5J/nDaxzavtaZ9/
         2QZhTTQXZOfnwsmoqq7h1oXIXYzus8y5uQBFvesWrT2PBpGRI5O+oq0JorKj062n6h6X
         2RxQotnbondwnM1lV0TSWI82nPf1ZArnORElnHtpsOEY4NsZAX1/Ja2VhNtpQxQRS6J1
         RW/Q==
X-Gm-Message-State: APjAAAV1V5/db6ABZkgPCLqWIF9keBXeDyVMxhXG06KltD0xpKPvJDrB
        NhhWcclg87g+nBOBjwH6tXo=
X-Google-Smtp-Source: APXvYqxouVzkvkXw2sIgKaUfZmVsXcWOA86csbHdiulEnOW1w9Mf0AwtbKSyMYIUv/C7WVuyfgvS3Q==
X-Received: by 2002:a05:6830:13c5:: with SMTP id e5mr18465011otq.68.1567352830027;
        Sun, 01 Sep 2019 08:47:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b19sm3186440oie.34.2019.09.01.08.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 08:47:09 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/4] rtlwifi: rtl8192cu:  Replace local TX and RX bit manipulation macro
Date:   Sun,  1 Sep 2019 10:47:02 -0500
Message-Id: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These patches are part of a series intended to replace the bit-manipulation
macros used to set and read the various descriptors with a set of inline
routines.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (4):
  rtlwifi: rtl8192cu: Remove unused GET_XXX and SET_XXX
  rtlwifi: rtl8192cu: Replace local bit manipulation macros
  rtlwifi: rtl8192cu: Convert macros that set descriptor
  rtlwifi: rtl8192cu: Convert inline routines to little-endian words

 .../net/wireless/realtek/rtlwifi/rtl8192cu/mac.c   |   8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   | 272 ++++++-----
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   | 529 +++++++++++----------
 3 files changed, 419 insertions(+), 390 deletions(-)

-- 
2.16.4

