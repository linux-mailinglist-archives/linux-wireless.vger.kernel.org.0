Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3E7E80F7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjKJSVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 13:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbjKJSTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 13:19:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D228130
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 02:22:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63945C433C7;
        Fri, 10 Nov 2023 10:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699611725;
        bh=AMPU4LRyX+OkgHTzmLqYpkHVXivN15INxbcqDW+e4HI=;
        h=From:To:Cc:Subject:Date:From;
        b=f25paLpmrrOypJkE+2mOFhXwjwmYKnrZzre9uvCGJFfliCC3KoHtyiViJoXGT2cFi
         b++rfZtaMcghghE2dF3fFBgMn+UB7HUphttZhtMwguSh9I3D6IJTbHHj9B/jPCdD1O
         MV5Zya/1VfTCFtMACL/Yl7WhXzNgjoqP6VsS/kul3cyhGif5Ogyp2Sxmp+DP/r907u
         wX23PukQ4ay1o7U69473/LRzGr7DOzWQMVLlLrs5PaxXAvsEZAPqE4TURk4zv4RwBE
         +y2zB+cIyrJQIDcDORId+jQeoRTJLr4v5xKKpi8NnolmFYVPswBMa144n8zgG4Ljxk
         M5keyYeN+XCrA==
From:   Kalle Valo <kvalo@kernel.org>
To:     mhi@lists.linux.dev
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH RFC 0/8] wifi: ath11k: hibernation support
Date:   Fri, 10 Nov 2023 12:21:54 +0200
Message-Id: <20231110102202.3168243-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Currently in ath11k we keep the firmware running on the WLAN device when the
network interface (wlan0) is down. The problem is that this will break
hibernation, obviously the firmware can't be running after the whole system is
powered off. To power down the ath11k firmware for suspend/hibernation some
changes both in MHI subsystem and ath11k is needed.

This patchset fixes a longstanding bug report about broken hibernation support:

https://bugzilla.kernel.org/show_bug.cgi?id=214649

This patchset is marked as RFC as it requires changes in MHI subsystem. Also
this has been tested only on WCN6855, need to test also on more AP based
chipsets like IPQ8074 and QCN9074.

The patches are also available at:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-hibernation-support

Earlier versions of this patchset have been tested by multiple users with
positive results. Takashi also tested this latest version:

  Tested-by: Takashi Iwai <tiwai@suse.de>

Baochen Qiang (7):
  bus: mhi: host: add mhi_power_down_no_destroy()
  bus: mhi: host: add new interfaces to handle MHI channels directly
  wifi: ath11k: handle irq enable/disable in several code path
  wifi: ath11k: remove MHI LOOPBACK channels
  wifi: ath11k: do not dump SRNG statistics during resume
  wifi: ath11k: fix warning on DMA ring capabilities event
  wifi: ath11k: support hibernation

Kalle Valo (1):
  wifi: ath11k: thermal: don't try to register multiple times

 drivers/bus/mhi/host/internal.h           |  1 +
 drivers/bus/mhi/host/main.c               | 91 +++++++++++++++++++++++
 drivers/bus/mhi/host/pm.c                 | 26 +++++--
 drivers/net/wireless/ath/ath11k/ahb.c     |  8 +-
 drivers/net/wireless/ath/ath11k/core.c    | 44 ++++++-----
 drivers/net/wireless/ath/ath11k/core.h    |  2 +
 drivers/net/wireless/ath/ath11k/hif.h     | 12 +--
 drivers/net/wireless/ath/ath11k/mhi.c     | 49 +++++-------
 drivers/net/wireless/ath/ath11k/mhi.h     |  4 +-
 drivers/net/wireless/ath/ath11k/pci.c     | 55 ++++++++++++--
 drivers/net/wireless/ath/ath11k/qmi.c     |  7 +-
 drivers/net/wireless/ath/ath11k/thermal.c |  3 +
 drivers/net/wireless/ath/ath11k/wmi.c     |  1 +
 include/linux/mhi.h                       | 47 +++++++++++-
 14 files changed, 268 insertions(+), 82 deletions(-)


base-commit: f24dee89bb8a7ef33c28e31632b1f3dd4e196413
-- 
2.39.2

