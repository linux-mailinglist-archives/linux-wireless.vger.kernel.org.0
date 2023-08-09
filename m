Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3157B775FC5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjHIMvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 08:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjHIMvd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 08:51:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C2F270E;
        Wed,  9 Aug 2023 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=aZQWf/K8HNLfBQWYDbXm4FI8XA7TMSl3It86/u7wHo0=; t=1691585480; x=1692795080; 
        b=kJizWXBPo9r+SCScQ1mOX1xG7yiIAb9BNKqKWf3OfbL88aHZtpYKMMpdUxyfjG66Yy6FxSuiqvA
        STgCPimVBkYC4EO5FVIxfG9kOI8ogcv8cDN3fA4z+8liOkWlT7gv0lms0OCipQIkyPNwThr9Ch9Iw
        XR8Nn6Zl4tDLlzymgX77+1U/ipd1oYBTLiBibQecsB16aRXO6f1gDJ2JkzAfxfihyezw4AnPkXabB
        gAefHkSn8MnYX6wRwg61J50ix+itxMvedHgST9oEGnwHanBsuxhySgqrJyHcAwYO2h9flTqZsz8Ns
        rONmRKsK3GoFgGhaBy8TzPjqOJCd4hHlI5Ag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTiej-00Eefs-1V;
        Wed, 09 Aug 2023 14:51:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-08-09
Date:   Wed,  9 Aug 2023 14:48:19 +0200
Message-ID: <20230809124818.167432-2-johannes@sipsolutions.net>
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

So I'm back, and we had a security fix pending for an
issue reported to security@kernel.org, but Greg hadn't
gotten around to applying it, so I'm handling it here.
Also, covering for Kalle, some driver fixes. Since we
want things routed to the right place I also included
a couple of maintainer updates, but to be honest now
I'm starting to have second thoughts about it. Oh well.

In any case, nothing major here, and I don't see much
else coming right now, except there this:
https://lore.kernel.org/linux-wireless/20230809073432.4193-1-johan+linaro@kernel.org/
and I'm really not sure what to do - breaks one thing
as is, breaks another if the code is restored ... I'm
hoping somebody from Qualcomm (other than Kalle) will
take a look, and Manikanta did, but nothing yet. So
I'm holding that back for now.

Please pull and let me know if there's any problem.

Thanks,
johannes



The following changes since commit 16e455a465fca91907af0108f3d013150386df30:

  wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1() (2023-08-02 13:34:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-08-09

for you to fetch changes up to 06f2ab86a5b6ed55f013258de4be9319841853ea:

  wifi: ath12k: Fix buffer overflow when scanning with extraie (2023-08-09 14:44:14 +0200)

----------------------------------------------------------------
Just a few small updates:
 * fix an integer overflow in nl80211
 * fix rtw89 8852AE disconnections
 * fix a buffer overflow in ath12k
 * fix AP_VLAN configuration lookups
 * fix allocation failure handling in brcm80211
 * update MAINTAINERS for some drivers

----------------------------------------------------------------
Felix Fietkau (1):
      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN

Keith Yeo (1):
      wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()

Larry Finger (2):
      MAINTAINERS: Update entry for rtl8187
      MAINTAINERS: Remove tree entry for rtl8180

Petr Tesarik (1):
      wifi: brcm80211: handle params_v1 allocation failure

Ping-Ke Shih (1):
      wifi: rtw89: fix 8852AE disconnection caused by RX full flags

Wen Gong (1):
      wifi: ath12k: Fix buffer overflow when scanning with extraie

 MAINTAINERS                                                 | 5 +----
 drivers/net/wireless/ath/ath12k/wmi.c                       | 3 +--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 5 +++++
 drivers/net/wireless/realtek/rtw89/mac.c                    | 2 +-
 include/net/cfg80211.h                                      | 3 +++
 net/wireless/nl80211.c                                      | 5 ++++-
 6 files changed, 15 insertions(+), 8 deletions(-)

