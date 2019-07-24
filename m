Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39EA733F4
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGXQeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 12:34:14 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:39098 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGXQeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 12:34:13 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970DABFC00000000000002FB.dip0.t-ipconnect.de [IPv6:2003:c5:970d:abfc::2fb])
        by dvalin.narfation.org (Postfix) with ESMTPSA id DE9FD1FFA1;
        Wed, 24 Jul 2019 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lGz8RJPt+qsMGyzLmgaZRkgNsHID8NT/51Jha+aRXVs=;
        b=mRmy02bWxTsNh/92ZuMCCv/kDQRFcn4JosA7h5AjUkJuy/sP+7nIjPMhGi1EICFsaAmCe7
        99tVhTy1aMvSvTV6UODJyI4+cobrLy5cSzFczbhRP9HWDGUDAdBRV0RqI6wIiFo4DjHKLO
        kcaTj2CQAC1hiIEL2eZWaK9CTiFI0lY=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v5 0/4] mac80211/ath11k: HE mesh support
Date:   Wed, 24 Jul 2019 18:33:55 +0200
Message-Id: <20190724163359.3507-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lGz8RJPt+qsMGyzLmgaZRkgNsHID8NT/51Jha+aRXVs=;
        b=o/WmH7/j0D2wLdJf5ovpVxzlmBV5NWEOQ8zrpiFwJiJKly1aRQ8UtH8lVfqj6xnjSF9UAx
        +qyL3UTsQaSQHEowNjumVMsp8wZ+NhDtrzB1LdtKJEiPVTWGymrqFydAQsKAkxd61xpDiV
        Wg7AYOG/5cDwfrFIq5cLXz0kgMJPBqY=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1563986051; a=rsa-sha256;
        cv=none;
        b=1UByc25NiidhR54MpovWZLnXMSUGlaUqTeQLyTFaPfRI3MXsh/bYcoJEuuZry3mlQ4Bc9r
        lAX5z0RsK7S9XEGnoP9gBSBoohIdWcrI1z5A8VBTZFwuci2YU+YKq79+Y/mlXIMdZbzFO3
        OfpjqP6YsWWChWxHBfDYjADVLLVDR1E=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Some features of 802.11ax without central organizing (AP) STA can also be
used in mesh mode. The main goal is to get HE mesh working with ath11k.
For persons without ath11k compatible hw, hwsim can be used in the as basis
for further development of these features.

* v5

  - rebased patches
  - moved ath11k meshpoint HE capabilities filter to avoid lines over 80
    characters
  - add patch to disable HE SU phy capabilities to work around problems
    with WLAN.HK.2.1.0.1-00629-QCAHKSWPL_SILICONZ-1 firmware

* v4

  - switch order of the mac80211 HE mesh support and mac80211_hwsim support
  - drop ie_len variable from ieee80211_ie_len_he_cap and
    ieee80211_ie_build_he_oper
  - switch to function ieee80211_get_he_iftype_cap instead of implementing new
    function ieee80211_get_he_mesh_cap
  - allow ieee80211_ie_len_he_cap to calculate length for non-mesh HE cap
  - dropped he_support workaround in ath11k because now all phy_modes are
    HE phy modes

* v3

  - force ath11k PHY mode for meshpoint vif to HE mode to avoid hang of
    firmware when HE (or VHT on 2.4GHz) device tries to connect

* v2:

  - add of ath11k patch

* v1:

  - initial RFC

Sven Eckelmann (4):
  mac80211: implement HE support for mesh
  mac80211_hwsim: Register support for HE meshpoint
  ath11k: register HE mesh capabilities
  ath11k: Disable SU support in meshpoint mode

 drivers/net/wireless/ath/ath11k/mac.c |  84 ++++++++
 drivers/net/wireless/mac80211_hwsim.c | 283 +++++++++++++++++---------
 net/mac80211/ieee80211_i.h            |   2 +
 net/mac80211/mesh.c                   |  62 ++++++
 net/mac80211/mesh.h                   |   4 +
 net/mac80211/mesh_plink.c             |  12 +-
 net/mac80211/util.c                   |  49 +++++
 7 files changed, 401 insertions(+), 95 deletions(-)

-- 
2.20.1

