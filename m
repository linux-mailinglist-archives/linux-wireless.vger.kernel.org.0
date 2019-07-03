Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B8C5E1C3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGCKS4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 06:18:56 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:36490 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGCKS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 06:18:56 -0400
Received: from sven-desktop.home.narfation.org (p4FCB2E24.dip0.t-ipconnect.de [79.203.46.36])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 889DF20925;
        Wed,  3 Jul 2019 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562149134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GWacOikOO27w4Vc1YkeqaWgUpo5xLkdp8jozJ4Jy/mk=;
        b=PNLoT7xFEuftaE6MmitOWGUU3fBEt+CWEA82xEmqukFua47wJpYTgZJpSTV2LbTHC8JDpZ
        pujWAsh37q2uGTagIyYnPQX+vqhet8QX2Yv5hk8Wom2fHi10oIAcllUXIOQHGU1+/6Eeh5
        R7VyNmh+Bcly8iQ32BKFWR+xUST16hA=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v4 0/3] mac80211/ath11k: HE mesh support
Date:   Wed,  3 Jul 2019 12:18:36 +0200
Message-Id: <20190703101839.18827-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562149134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GWacOikOO27w4Vc1YkeqaWgUpo5xLkdp8jozJ4Jy/mk=;
        b=wkZxNxd3A48PNHdSmZHQC1nzhFlJLmgipQUXARdAZ1yCuBDGkNR7Al5NxGs5OVlOlNL0mG
        xph3vKB4IHhKpV9gnGbi/CbhDMyqS1wh6U9ALbwBlle5oFYLZaQYcf3K/GWqvIzzMnzRXb
        AwgumFaEyMszJm4ZdXuWei7XZtST6X8=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1562149134; a=rsa-sha256;
        cv=none;
        b=NiNFxOybjNL1bUPrUojvnEeAs/I0Kvk4S01Zh2qeL24h5p16fbHdyszaOifCWZ1TdVqU/M
        3sscwYyQb7NgqHaR43GDmqaG6//Svk13lhwJ580FqKOTzvmzxnx3M1EJfGq+ZTqCphPqpZ
        Jbfb323HR686g4QSj4uo30ikuL8YxdY=
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

Sven Eckelmann (3):
  mac80211: implement HE support for mesh
  mac80211_hwsim: Register support for HE meshpoint
  ath11k: register HE mesh capabilities

 drivers/net/wireless/ath/ath11k/mac.c |  56 +++++
 drivers/net/wireless/mac80211_hwsim.c | 283 +++++++++++++++++---------
 net/mac80211/ieee80211_i.h            |   2 +
 net/mac80211/mesh.c                   |  62 ++++++
 net/mac80211/mesh.h                   |   4 +
 net/mac80211/mesh_plink.c             |  12 +-
 net/mac80211/util.c                   |  49 +++++
 7 files changed, 373 insertions(+), 95 deletions(-)

-- 
2.20.1

