Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAF1CB217
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEHOmV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 10:42:21 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:54259 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgEHOmV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 10:42:21 -0400
Received: from legolas.fritz.box (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 915B8580247;
        Fri,  8 May 2020 16:42:19 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 0/3] nl80211/mac80211: add tx status for ctrl port
Date:   Fri,  8 May 2020 16:41:59 +0200
Message-Id: <20200508144202.7678-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When sending EAPOL frames from an AP to a STA, SO_WIFI_STATUS can be used
on raw/packet sockets to get notified of (un-)successful frame
transmissions in order to trigger retransmits earlier.

The nl80211 control port currently lacks such a feature, which therefore
gets added in this series, in order to function as a drop in replacement
for using dedicated AF_PACKET sockets for handling EAPOL messages.
With this series it is finally possible to run hostapd in AP mode with
mgmt and EAPOL control port frames solely over nl80211 and data frames on
the kernel data path.

The intended behaviour stems from tx notifications for mgmt frames over
nl80211. A cookie is provided to match request and reply, furthermore the
frame content is also included in status messages.

This series has been tested with a modified hostapd version. Patches for
hostapd will follow soon on its mailing list.

Markus Theil (3):
  nl80211: cookie arg for tx control port
  nl80211: add control port tx status method
  nl80211: add feature flag for control port tx status capability

 include/net/cfg80211.h       | 18 +++++++-
 include/uapi/linux/nl80211.h | 12 ++++++
 net/mac80211/ieee80211_i.h   |  8 +++-
 net/mac80211/main.c          |  2 +
 net/mac80211/status.c        |  7 ++-
 net/mac80211/tdls.c          |  2 +-
 net/mac80211/tx.c            | 83 +++++++++++++++++++++++++++---------
 net/wireless/nl80211.c       | 73 ++++++++++++++++++++++++++-----
 net/wireless/rdev-ops.h      |  9 ++--
 net/wireless/trace.h         | 17 ++++++++
 10 files changed, 193 insertions(+), 38 deletions(-)

-- 
2.26.2

