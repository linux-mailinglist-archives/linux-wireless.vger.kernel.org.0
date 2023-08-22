Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CCC78410D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjHVMnU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjHVMnT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:43:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04381196;
        Tue, 22 Aug 2023 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=PY+bsAgi3bDuH7vUp2hqTbQFPyW1J5EqPhjyCuqe+Uk=; t=1692708198; x=1693917798; 
        b=Huk+b/+skwKWpLJlQAwBw5MA+nHSPE1CuFDMTwDXXtMSHcL39BnbUJAZTBivhBR5Xs9b6waRb9T
        /S85GSRZPA7VHLkS/FCaQ9VwilVrCjBuLBAp16T/3FkDruBMADjdPRUabujGFymI9M70WCLxrzsch
        79wU3tSP+mrWJeiWIhfF5yOyhzAZPQTcUxZJNNN6LDCF5C4lQL176PjMCqWglIXY732AsmLOX+CYH
        9YPJNg0G4P3lWL7JDoBXW8epRH9G7hP4i6+g9d6LMscH6eLMK0J1jgYw/8tm+KY0XvLl+GdsS0gW0
        O8Ait0Eyy3yrSOkXRcw4rngX+n9sZF4m5dqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qYQj5-0058Y2-2B;
        Tue, 22 Aug 2023 14:43:16 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-08-22
Date:   Tue, 22 Aug 2023 14:42:07 +0200
Message-ID: <20230822124206.43926-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

We have two more fixes - one stack and one driver - for the
current cycle. I think the Kconfig fix would be appreciated
more than the other, but if anyone runs with UBSAN they may
find this problem as well.

Please pull and let me know if there's any problem.

Thanks,
johannes



The following changes since commit 06f2ab86a5b6ed55f013258de4be9319841853ea:

  wifi: ath12k: Fix buffer overflow when scanning with extraie (2023-08-09 14:44:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-08-22

for you to fetch changes up to b98c16107cc1647242abbd11f234c05a3a5864f6:

  wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning (2023-08-21 09:49:54 +0200)

----------------------------------------------------------------
Two fixes:
 * reorder buffer filter checks can cause bad shift/UBSAN
   warning with newer HW, avoid the check (mac80211)
 * add Kconfig dependency for iwlwifi for PTP clock usage

----------------------------------------------------------------
Ping-Ke Shih (1):
      wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning

Randy Dunlap (1):
      wifi: iwlwifi: mvm: add dependency for PTP clock

 drivers/net/wireless/intel/iwlwifi/Kconfig |  1 +
 include/net/mac80211.h                     |  1 +
 net/mac80211/rx.c                          | 12 ++++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

