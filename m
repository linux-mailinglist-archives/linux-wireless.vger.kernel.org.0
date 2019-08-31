Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84041A45B6
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfHaSHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 14:07:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36392 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaSHA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 14:07:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so10038074otr.3
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2019 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SqqfLHOj1RbGZ1DaNx6rXctmBPiXr7vXzt8xVMbrFsY=;
        b=rAB4mEns9n4djeo18V+mU4adm63rH3ykE9mj37j9jDjWjrZ9grbzlmQNR/YHdj75p9
         /kg7yJ33feCns4nwxuDOEUIcna1kV/4p6Gz19kd1//xHDbmOKlQ3FAhGYu1Zi+QVY4rc
         CJDGB/fG3rvbGaFbD761J6B/89dbkY4ciXJ+KAADR1MtpH1l7xIxZaLp/u5zqVOmSE2f
         AQBLMr4sw6q6C1FxmeQLjafgZNSYn4bnmPga4wN6XVsC66MpOUMRAOFdPruXNHaelyBl
         N06fQO0PZN+9fT3RILjd9LiBC/t9sU/KD3ueNaCOB3/ezZ4TGCd3JIkvKAbiek2lOf9n
         PB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SqqfLHOj1RbGZ1DaNx6rXctmBPiXr7vXzt8xVMbrFsY=;
        b=AXAljOkflukBQvJ63N0eqQSB+1UIPe6+OESDt23sXZncjqlI0QDPWYAHLxOLDi1gpU
         WZ60DRcafr7Zc5bZ+1kA0zmpj6Ci6hRHRQAz6hlngnXJ8Xw2/9jOOQ0qzDesMYbIs945
         Ma7tBHzCGne3mtL6ceZ/7FVGMO3hspNkMKSnT/WI1tQifT7IHPGQ81fO9g6zizaRXJ6h
         ZTVPIWLzd7odvZJ2xCIf+moTye7k/4+A0AUeUP8r/vqU6C68R6o4RAd0eh/aqV4Cb8j2
         /Q9we2uvNlgpRUzkKhZVcHvzEglVuCBuvO0jr9mYi5R1Ot6owbHxJF1rdV5b2kMZ41NQ
         HVeA==
X-Gm-Message-State: APjAAAXvKsAx8gJgFgJ6piq+OzQ7h6S0zYDDPZ3DLcdtQohYv214Vlmf
        /b4bnkdB0Hy1XCPQUhaQY2M=
X-Google-Smtp-Source: APXvYqzv7e9audE2H74s9ekJKiQY1Yx2Pd/MsuS/55R/iyS5pChBtKOxxYC6ner/59348et4iblPug==
X-Received: by 2002:a9d:7c93:: with SMTP id q19mr16600873otn.343.1567274819333;
        Sat, 31 Aug 2019 11:06:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c11sm3222346otr.54.2019.08.31.11.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 11:06:58 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/5] rtlwifi: rtl8192ee: Replace local TX and RX bit manipulation macros
Date:   Sat, 31 Aug 2019 13:06:39 -0500
Message-Id: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These patches are part of a series intended to replace the bit-manipulation
macros used to set and read the various descriptors with a set of inline
routines.

The final patch removes some variable initializations that are not needed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (5):
  rtlwifi: rtl8192ee: Remove unused GET_XXX and SET_XXX
  rtlwifi: rtl8192ee: Replace local bit manipulation macros
  rtlwifi: rtl8192ee: Convert macros that set descriptor
  rtlwifi: rtl8192ee: Convert inline routines to little-endian words
  rtlwifi: rtl8192ee: Remove some variable initializations

 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   | 314 ++++----
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   | 860 +++++++++++----------
 2 files changed, 594 insertions(+), 580 deletions(-)

-- 
2.16.4

