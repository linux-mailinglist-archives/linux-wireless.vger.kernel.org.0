Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D956C5238
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCVRTn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCVRT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2675566D04
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:14 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VnAwkvQsv+iR2BpWJEGJXvX03ziFlRmpzSGqQQ3X2bU=;
        b=ALbDzjZM6aaiZt9QTnaL/pZYox4LlCnYed1jqTZ+Nnp6RwJEdODrzDBRR31qPW6PtF0jR/
        vpRkKpwcZQZY2hMBPRCofV20vjUuREM1QRZnmAEJA6Wn+NJYaa0dtTrmOCI54OD9nS7lGL
        YWjoDIhdUt8NJOeP2eruigGVoEHyq6/2l+nfM3WNlDhFSVKMFl2JqU5hIfo5785J1/ryr1
        P7QViKdw9Div+J1QG3ijZPCJvKbV/RJTUllivX1mEYG1TKlb+XGnFkIPjcoxyxKqHTpIzm
        gLOlqZP2O4EhwZsbxPos0Q3nlgyajDqq+I1u28dmkkOgT+FtGoaSsP19iYpVbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VnAwkvQsv+iR2BpWJEGJXvX03ziFlRmpzSGqQQ3X2bU=;
        b=Km/5gTg/Q79DED3f4KvUEgh5tTLHCDYh10zOGiWLaPrCYtSHJUoKkliccIOfyfgoeBqs10
        nA4VisaoLHGPBdBA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 00/14] wifi: rtl8xxxu: Add AP mode support for 8188f
Date:   Wed, 22 Mar 2023 18:18:51 +0100
Message-Id: <20230322171905.492855-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series intends to bring AP mode support to the rtl8xxxu driver,
more specifically for the 8188f, because this is the HW I have.
The work is based on the vendor driver as I do not have access to
datasheets.

This is an RFC, so that there can be a discussion first before
potentially implementing support for the other chips in this driver, if
required.

Also while doing some measurements with iperf3 to compare with the
vendor driver, I saw, that TCP traffic from AP to STA is slower than in
the vendor driver. For UDP it looks fine. I hope I can get some help to
fix this.

* vendor driver:

  without 802.11n:
    UDP (AP -> STA): 27 Mbits/sec
    UDP (STA -> AP): 33 Mbits/sec
    TCP (AP -> STA): 24 Mbits/sec
    TCP (STA -> AP): 26 Mbits/sec

  with 802.11n:
    UDP (AP -> STA): 51 Mbits/sec
    UDP (STA -> AP): 35 Mbits/sec
    TCP (AP -> STA): 40 Mbits/sec
    TCP (STA -> AP): 36 Mbits/sec

* rtl8xxxu:

  without 802.11n:
    UDP (AP -> STA): 25 Mbits/sec
    UDP (STA -> AP): 31 Mbits/sec
    TCP (AP -> STA):  3 Mbits/sec !
    TCP (STA -> AP): 25 Mbits/sec

  with 802.11n:
    UDP (AP -> STA): 41 Mbits/sec
    UDP (STA -> AP): 36 Mbits/sec
    TCP (AP -> STA):  3 Mbits/sec !
    TCP (STA -> AP): 32 Mbits/sec

Thanks,
  Martin

Martin Kaistra (14):
  wifi: rtl8xxxu: Add start_ap() callback
  wifi: rtl8xxxu: Select correct queue for beacon frames
  wifi: rtl8xxxu: Add beacon functions
  wifi: rtl8xxxu: Add set_tim() callback
  wifi: rtl8xxxu: Allow setting rts threshold to -1
  wifi: rtl8xxxu: Allow creating interface in AP mode
  wifi: rtl8xxxu: Add parameter macid to update_rate_mask
  wifi: rtl8xxxu: Actually use macid in rtl8xxxu_gen2_report_connect
  wifi: rtl8xxxu: Add parameter role to report_connect
  wifi: rtl8xxxu: Add sta_add() callback
  wifi: rtl8xxxu: Put the macid in txdesc
  wifi: rtl8xxxu: Enable hw seq for all non-qos frames
  wifi: rtl8xxxu: Clean up filter configuration
  wifi: rtl8xxxu: Declare AP mode support for 8188f

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  28 ++-
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |   3 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |   1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 226 +++++++++++++++---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |   2 +
 5 files changed, 222 insertions(+), 38 deletions(-)

-- 
2.30.2

