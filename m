Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF6B3B4DD5
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Jun 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFZJle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Jun 2021 05:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZJle (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Jun 2021 05:41:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E007661920;
        Sat, 26 Jun 2021 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624700352;
        bh=FBF2v2bS7UEhwJdddSrxXL93l+lkzI2SiWIf1KJQ434=;
        h=From:To:Cc:Subject:Date:From;
        b=LZ84yHxqxzbckJC4iWwrHOLTsWBwketSFtxym3pXs/3axmSevvcbsBrcIvDUikOgq
         865eSFzL0qI1+Wy5DAzx5NfZmgFA4VtC31LVy8SWGdDk67jm5GJds9iTFmkYOqSLlQ
         5QBVFg4YuqI8dGwsW9dsMY+hdFdi6rewpnZPWciQ1IgjK6jAM6PeOJDpgRkw/sb63S
         dTTcEMXEyrkJZgpzR0k9Ia0OWCMYazFjaHW7HIzaQcCqwxIyGcRisS81Vcn2J7ycG3
         AMpEe1m4x1KWP79ZFNCySxTlUIXwTcYlQZPfhTIi65EildfEd9Bi/V4KWk1Eij3plA
         HD7bukh2pibWw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, john@phrozen.org,
        ryder.lee@mediatek.com
Subject: [PATCH v7 mac80211-next 0/2] mac80211: add BSS color change support
Date:   Sat, 26 Jun 2021 11:38:58 +0200
Message-Id: <cover.1624699891.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series adds support for BSS color collission detection and change.

Changes since v6:
- rebase on top of mac80211-next
- fix check_patch issues
- alloc nlattr tb array dynamically in nl80211_color_change
- move NL80211_ATTR_CNTDWN_OFFS_BEACON and NL80211_ATTR_CNTDWN_OFFS_PRESP
  in NL80211_ATTR_COLOR_CHANGE_ELEMS as nested attributes
- remove unused definitions
- remove mbss series dependency
- remove ath11k code

John Crispin (2):
  nl80211: add support for BSS coloring
  mac80211: add support for BSS color change

 include/net/cfg80211.h       |  92 ++++++++++++++
 include/net/mac80211.h       |  29 +++++
 include/uapi/linux/nl80211.h |  43 +++++++
 net/mac80211/cfg.c           | 234 +++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h   |  11 ++
 net/mac80211/iface.c         |   2 +
 net/mac80211/tx.c            |  25 ++--
 net/wireless/nl80211.c       | 157 +++++++++++++++++++++++
 net/wireless/rdev-ops.h      |  13 ++
 net/wireless/trace.h         |  46 +++++++
 10 files changed, 631 insertions(+), 21 deletions(-)

-- 
2.31.1

