Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FF1B6A78
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 02:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgDXAth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 20:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgDXAtg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC18C09B042
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g10so6231719lfj.13
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2020 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f08cb7U4s52Iwp4a+PehJ8M9wsZgnk9E31y3+KZe3PU=;
        b=IdjTEfngwiCJoEIk2I/1hs4fKweS2a6SQ4h0VhpMiqWLt4EMpNNt/UjrqdPAyCDGdE
         ZKvjVqxUZpWcBOqELDPpenHM3lJEZVo72qjL8G89KGjtQq6jUtxJ3xAoqD9835DIZjqb
         ZvP7n7PxB6dqXdoZ59bf8T0nQjPW+CzrldLfv/21PHhOQ2byiXLj81HW4KUS+VLmz6IK
         WbKd7hMgkpJR+EU8e6xZRvZd9tUgKs2CpSqwRMVmqNCs1xgqT7Z5NbM/fK8ecx5zA4FB
         m5cJb5JQgJjxvQc4ufBuyRTi65AHZW5MgV9oHDyzME1tPeqbP8Qe4aUNQqAT9m/g3RVG
         eGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f08cb7U4s52Iwp4a+PehJ8M9wsZgnk9E31y3+KZe3PU=;
        b=lcLCCoQWSadndjbDSmlyBg9CnFOiocubNj19+6joag2eMLMR+YLYcoxV26+BBXBoYx
         N07CUxR3mCo64VThhfZvc/UAbG5WBhigW0cXfe9pS/s2hpmypr40H+ZMZYO2SMF//Lnn
         JT19rmrwMJnuUQ8XmtYrD1BCWCOPzwdqxpwog+h8BrgQ05rSEP4zRT2LuzlvNjApct5i
         Gk3PmzEpBNYrUdXImQlO/bp2ls+2fruuuGvyVHiW76Sb584izaA+h3HGbctb2KdBl/FQ
         ctQ6SYxIN+/BUcFUCawavcUoHwRHRjzOD25k/56PWPoCHVTk/CyhH1znO20NAF0v8e7q
         Ez/A==
X-Gm-Message-State: AGi0PubZdmUHPAU5kLTfBjVxewQXzedyp2PdGqB8QMEJIrgqlLFtacqD
        lTPpyN2AMih914jiiWskh5UHD8bU
X-Google-Smtp-Source: APiQypJ0VudDFeG0cxPFQASl9c853AtyXrX957ygJKN2dHwHDjSFTmSfTgkAoIXMugNrY7I2UFvgZg==
X-Received: by 2002:a19:7411:: with SMTP id v17mr4278198lfe.27.1587689374941;
        Thu, 23 Apr 2020 17:49:34 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by smtp.gmail.com with ESMTPSA id r12sm1555056ljc.12.2020.04.23.17.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:34 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] ath9k: AR9002 calibration fixes
Date:   Fri, 24 Apr 2020 03:49:17 +0300
Message-Id: <20200424004923.17129-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I am faced a situation where the AR9220 AGC is goes crazy in case of a
low Rx signal in a noisy environment. It seems like it turned off the
internal LNA, so low signal neighbours become completely inaccessable,
and RSSI of neighbours with a strong signal drops by around 30 dB.
Periodic NF calibration perfectly solves this situation. But the NF
calibration itself in some cases could be blocked by the ADCs & I/Q
calibrations forever. This series is an attempt to address these NF
calibration blocking issues.

The first patch disables ADC gain & offset calibrations for unsupported
channels. The second patch is a trivial code cleanup.

And the last four patches together prevent the NF calibration infinite
deferring. They limit the run time of individual calibration, allow
correct running of NF calibration in between ADCs & I/Q calibrations
and prevent missing of NF periodic calibrations.

Run tested with AR9220 based NIC.

Sergey Ryazanov (6):
  ath9k: fix AR9002 ADC and NF calibrations
  ath9k: remove needless NFCAL_PENDING flag setting
  ath9k: do not miss longcal on AR9002
  ath9k: interleaved NF calibration on AR9002
  ath9k: invalidate all calibrations at once
  ath9k: add calibration timeout for AR9002

 drivers/net/wireless/ath/ath9k/ar9002_calib.c | 49 +++++++++++++++----
 drivers/net/wireless/ath/ath9k/calib.c        | 16 +++---
 drivers/net/wireless/ath/ath9k/hw.h           |  2 +
 3 files changed, 51 insertions(+), 16 deletions(-)

-- 
2.24.1

