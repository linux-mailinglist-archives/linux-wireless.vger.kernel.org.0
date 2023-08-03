Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC676EBAD
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 16:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjHCOCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjHCOCD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 10:02:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04E844BC
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 07:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8097661D74
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 14:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57476C433C9;
        Thu,  3 Aug 2023 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691071258;
        bh=/foCZRvvss/yRAsl+5zHrD+NgMyBF8g5MMVUgnFuFzk=;
        h=From:Subject:To:Cc:Date:From;
        b=WQ+gDcd4l+uKiataaEKvh3VbEboegMLZcbemrMa1ewyc+wAvKHsVQD2XUB3c62XGg
         EcCbp4y/yYGdz128x6xGsi/8lTyMreMZ+ZhOfxgBS6xVaMED10YE0kk93Dg/6OoyEV
         Ds9ENWPY5RRfmXSQKTCcDMPgiEYq0AS5SJ81ww3UC3zblHzl1167+GSwhKVvU8bQRs
         X9LQBGrOx837f2pmNluIpKbE37KDclscsy7o7iKTZgpZ3hhFDhkeOaXzzANtY9kByA
         hpiiNjDsBR2ZgkUiV9RrpaYFIeGZH0wKrq9GMiB6ECgAFCY8hBCJgcwPh645cYuYIM
         Ri+bKvs0JwAcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2023-08-03
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Message-Id: <20230803140058.57476C433C9@smtp.kernel.org>
Date:   Thu,  3 Aug 2023 14:00:58 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit ac528649f7c63bc233cc0d33cff11f767cc666e3:

  Merge branch 'net-support-stp-on-bridge-in-non-root-netns' (2023-07-20 10:46:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-08-03

for you to fetch changes up to 16e455a465fca91907af0108f3d013150386df30:

  wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1() (2023-08-02 13:34:16 +0300)

----------------------------------------------------------------
wireless fixes for v6.5

We did some house cleaning in MAINTAINERS file so several patches
about that. Few regressions fixed and also fix some recently enabled
memcpy() warnings. Only small commits and nothing special standing
out.

----------------------------------------------------------------
Brian Norris (1):
      MAINTAINERS: Update mwifiex maintainer list

Hans de Goede (1):
      wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()

Ilan Peer (1):
      wifi: cfg80211: Fix return value in scan logic

Kalle Valo (12):
      Revert "wifi: ath11k: Enable threaded NAPI"
      Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"
      MAINTAINERS: wifi: rtw88: change Ping as the maintainer
      MAINTAINERS: wifi: atmel: mark as orphan
      MAINTAINERS: wifi: mark cw1200 as orphan
      MAINTAINERS: wifi: mark ar5523 as orphan
      MAINTAINERS: wifi: mark rndis_wlan as orphan
      MAINTAINERS: wifi: mark wl3501 as orphan
      MAINTAINERS: wifi: mark zd1211rw as orphan
      MAINTAINERS: wifi: mark b43 as orphan
      MAINTAINERS: wifi: mark mlw8k as orphan
      MAINTAINERS: add Jeff as ath10k, ath11k and ath12k maintainer

Kees Cook (1):
      wifi: ray_cs: Replace 1-element array with flexible array

Paul Fertser (1):
      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

 MAINTAINERS                                        | 36 +++++++++-------------
 drivers/net/wireless/ath/ath11k/ahb.c              |  1 -
 drivers/net/wireless/ath/ath11k/pcic.c             |  1 -
 drivers/net/wireless/ath/ath6kl/Makefile           |  5 ---
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |  7 ++++-
 drivers/net/wireless/legacy/rayctl.h               |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |  6 ++--
 net/wireless/scan.c                                |  2 +-
 8 files changed, 25 insertions(+), 35 deletions(-)
