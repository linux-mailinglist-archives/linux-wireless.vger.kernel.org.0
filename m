Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A393CD3D1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhGSKpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jul 2021 06:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhGSKpv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jul 2021 06:45:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CCBC061574
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jul 2021 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=7u2HT3nzPqHbcqMVAGgjDMbCpopCzodFtnUMUYY7Me8=; t=1626693991; x=1627903591; 
        b=o8LXh8bR3brWaB7E531KFpI3G0d2uwgaoNItVON9AF0dPwhQo0DRtgPDSx9bJ7YkDIBEn24zrwy
        xeEyGaUgzS+LTLrDYAKI7Fvbc4tVg+ZSqGw0tEXHctg1AYmYSEhxfOGMeG0Qro19F0nongHYcEHJp
        SXxFiTNkyvUSapk92ctuP6TY9HQ3bUohaPoUddD4ksO9xUGmCjkUq1xhiP0DyqoPNBA45bVK+ZiX5
        E4O6mmLl8gDUgzCg0rNWjf3fMmmF0id+KWcG8vntbFhto554PDG83WkKc0xnORnC2qX7+LRlv+stn
        qmdIq22a0WLxX4UrVpwjAF1YWnwS8o3f5GQA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m5RPp-004L70-4L; Mon, 19 Jul 2021 13:26:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: iwlwifi-fw-2021-07-19
Date:   Mon, 19 Jul 2021 13:26:20 +0200
Message-Id: <20210719112621.21043-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

We've got a new Ty device firmware image, along with an
updated PNVM data file.

Please pull and let me know if there's any problem.

Thanks,
johannes



The following changes since commit b7c134f0d3491113958276d631b4e69771a6c5be:

  linux-firmware: update NXP 8897/8997 firmware images (2021-07-16 07:55:21 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2021-07-19

for you to fetch changes up to 5de082d4d0f2db7722c9e6f5c9cff1fefd8073be:

  iwlwifi: add ty firmware from Core63-43 (2021-07-19 13:12:20 +0200)

----------------------------------------------------------------
iwlwifi: add ty firmware from Core63-43

----------------------------------------------------------------
Johannes Berg (1):
      iwlwifi: add ty firmware from Core63-43

 LICENCE.iwlwifi_firmware     |   2 +-
 WHENCE                       |   3 +++
 iwlwifi-ty-a0-gf-a0-66.ucode | Bin 0 -> 1477864 bytes
 iwlwifi-ty-a0-gf-a0.pnvm     | Bin 27456 -> 27480 bytes
 4 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 iwlwifi-ty-a0-gf-a0-66.ucode

