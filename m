Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6907D4E13
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjJXKiB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjJXKiA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 06:38:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D769E5;
        Tue, 24 Oct 2023 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=UQe5qsO91Lw4qUDZ0AOdGhyhApPjPXBszYhO63qJTUc=; t=1698143878; x=1699353478; 
        b=G80kx5f6Vxt6k3u027gMFHesoYU0F5osDUcWRPUCrgnWsc/UbiDTY6nRLVw1SKLoUhOIzlKVwRd
        ci3xo0J2WQedKCj/EtOYBmROTU9vdlGXnersDZ95WI4As2533CZqS92TrCo+Q5wlWDgIB/8+BDXQx
        Y37ww0Q62h2uj6jAtyZ69BGC3yM7vCc1P1XOW6IrNsCd7aiB/ueKnSCo1d4PB2QVGNfrb6MHj2A35
        whqufl3Oft1ZkGwywpKuFQJEC16sIsHhtbDEIQQRrMugcXRHTgqsxe5Lsc/FG7s1A6X7sYB25Iuxc
        C0tGjxfraCBlJzgv3twnkZu6LgW5cLhZhlTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvEnL-00000001Mg6-0hPM;
        Tue, 24 Oct 2023 12:37:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-10-24
Date:   Tue, 24 Oct 2023 12:35:41 +0200
Message-ID: <20231024103540.19198-2-johannes@sipsolutions.net>
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

We have a couple of last-minute fixes for some issues.

Note that this introduces a merge conflict with -next,
which Stephen reported and (correctly) resolved here:
https://lore.kernel.org/linux-wireless/20231024112424.7de86457@canb.auug.org.au/
Basically just context - use the ieee80211_is_protected_dual_of_public_action()
check from this pull request, and the return code
RX_DROP_U_UNPROT_UNICAST_PUB_ACTION from -next.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit f2ac54ebf85615a6d78f5eb213a8bbeeb17ebe5d:

  net: rfkill: reduce data->mtx scope in rfkill_fop_open (2023-10-11 16:55:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-10-24

for you to fetch changes up to 91535613b6090fc968c601d11d4e2f16b333713c:

  wifi: mac80211: don't drop all unprotected public action frames (2023-10-23 13:25:30 +0200)

----------------------------------------------------------------
Three more fixes:
 - don't drop all unprotected public action frames since
   some don't have a protected dual
 - fix pointer confusion in scanning code
 - fix warning in some connections with multiple links

----------------------------------------------------------------
Avraham Stern (1):
      wifi: mac80211: don't drop all unprotected public action frames

Ben Greear (1):
      wifi: cfg80211: pass correct pointer to rdev_inform_bss()

Johannes Berg (1):
      wifi: cfg80211: fix assoc response warning on failed links

 include/linux/ieee80211.h | 29 +++++++++++++++++++++++++++++
 net/mac80211/rx.c         |  3 +--
 net/wireless/mlme.c       |  3 ++-
 net/wireless/scan.c       |  2 +-
 4 files changed, 33 insertions(+), 4 deletions(-)

