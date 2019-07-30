Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA5C7AE1A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 18:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfG3QhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 12:37:15 -0400
Received: from nbd.name ([46.4.11.11]:51038 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbfG3QhO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 12:37:14 -0400
Received: from pd95fd7d7.dip0.t-ipconnect.de ([217.95.215.215] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hsV7e-0002JK-Qq; Tue, 30 Jul 2019 18:37:10 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V3 0/2] mac80211: allow setting up OBSS PD
Date:   Tue, 30 Jul 2019 18:36:59 +0200
Message-Id: <20190730163701.18836-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Store the OBSS PD parameters inside bss_conf when bringing up an AP and/or
when a station connects to an AP. This allows the driver to configure the
HW accordingly.

Changes in V3
* split cfg80211 and mac80211 part into 2 patches

Changes in V2
* fix symbol prefixes
* fix nl policy

John Crispin (2):
  cfg80211: add support for parsing OBBS_PD attributes
  mac80211: allow setting spatial reuse parameters from bss_conf

 include/net/cfg80211.h       | 15 ++++++++++++
 include/net/mac80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 27 ++++++++++++++++++++++
 net/mac80211/cfg.c           |  5 +++-
 net/mac80211/he.c            | 24 +++++++++++++++++++
 net/mac80211/ieee80211_i.h   |  3 +++
 net/mac80211/mlme.c          |  1 +
 net/wireless/nl80211.c       | 45 ++++++++++++++++++++++++++++++++++++
 8 files changed, 123 insertions(+), 1 deletion(-)

-- 
2.20.1

