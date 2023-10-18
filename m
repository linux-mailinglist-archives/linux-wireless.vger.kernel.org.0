Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB17CD55A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 09:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjJRHNc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjJRHNb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 03:13:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E0B6;
        Wed, 18 Oct 2023 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=wG/jppn5wAJbUG660quwsOFgGaPB3YrezpAQFZpUfiA=; t=1697613209; x=1698822809; 
        b=lhX/3hmuj9Uw6dzXBt46J5RBIMT4W4astAvVA031vLoUwpZ/7/NLyGHSqgFHRcRpL9N23+w5qt/
        36xan8ipCBYKjg+6Yngg1xh2y9Bb8WdpuARoLD6PsFcblx2szbAatFMrmP3SkEDg3uoIIrrl7CQ5X
        FOePEXMMWjcmjwP4CIux+ukByKP6+LNbwHZ+nVmG0MG3M2jgYScPsjDofie9HZGRsF1T4pDYnowU4
        0X6sxc/lsDh2gAUu2+T0A/YOC2stNBaX3In0O/5s32t+ib9GBWbbykH6xNqndBPts4hwaOeCKFEcd
        C5ClzejSt/OIitsfjU35PKNxTSrqMJ0Jx6ow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qt0kA-0000000Bb5i-1dSB;
        Wed, 18 Oct 2023 09:13:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-10-18
Date:   Wed, 18 Oct 2023 09:10:42 +0200
Message-ID: <20231018071041.8175-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So we have a couple more fixes, all in the stack this time.

Unfortunately, one of them is for an issue I noticed during
the merge between wireless and wireless-next last time, and
while it was already resolved in wireless-next, the issue
also existed in wireless; as a result, this causes a merge
conflict again when merging wireless and wireless-next (or
obviously net/net-next after pulling this in, etc.). This is
(pretty easily) resolved by taking the version without the
lock, as the lock doesn't exist any more in -next.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit f291209eca5eba0b4704fa0832af57b12dbc1a02:

  Merge tag 'net-6.6-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-10-05 11:29:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-10-18

for you to fetch changes up to f2ac54ebf85615a6d78f5eb213a8bbeeb17ebe5d:

  net: rfkill: reduce data->mtx scope in rfkill_fop_open (2023-10-11 16:55:10 +0200)

----------------------------------------------------------------
A few more fixes:
 * prevent value bounce/glitch in rfkill GPIO probe
 * fix lockdep report in rfkill
 * fix error path leak in mac80211 key handling
 * use system_unbound_wq for wiphy work since it
   can take longer

----------------------------------------------------------------
Johannes Berg (3):
      wifi: cfg80211: use system_unbound_wq for wiphy work
      wifi: mac80211: fix error path key leak
      net: rfkill: reduce data->mtx scope in rfkill_fop_open

Josua Mayer (1):
      net: rfkill: gpio: prevent value glitch during probe

 net/mac80211/key.c       | 3 +--
 net/rfkill/core.c        | 5 ++---
 net/rfkill/rfkill-gpio.c | 4 ++--
 net/wireless/core.c      | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

