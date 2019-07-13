Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2367B42
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jul 2019 18:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfGMQgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jul 2019 12:36:51 -0400
Received: from nbd.name ([46.4.11.11]:41192 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfGMQgv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jul 2019 12:36:51 -0400
Received: from pd95fd64b.dip0.t-ipconnect.de ([217.95.214.75] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmL0y-000457-Jt; Sat, 13 Jul 2019 18:36:48 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: [PATCH V3 0/2] mac80211: add ADDBA_EXT responder support
Date:   Sat, 13 Jul 2019 18:36:40 +0200
Message-Id: <20190713163642.18491-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HE allows peers to negotiate the aggregation fragmentation level to be used
during transmission. The level can be 1-3. The Ext element is added behind
the ADDBA request inside the action frame. The responder will then reply
with the same level or a lower one if the requested one is not supported.
This patch only handles the responder part.

Changes in V3
* set elems to 0 prior to parsing IEs

Changes in V2
* utilise the IE parser provided by mac80211

John Crispin (2):
  mac80211: add support for parsing ADDBA_EXT IEs
  mac80211: add support for the ADDBA extension element

 include/linux/ieee80211.h  | 11 ++++++
 net/mac80211/agg-rx.c      | 71 +++++++++++++++++++++++++++++++++-----
 net/mac80211/ht.c          |  2 +-
 net/mac80211/ieee80211_i.h |  4 ++-
 net/mac80211/util.c        |  7 ++++
 5 files changed, 84 insertions(+), 11 deletions(-)

-- 
2.20.1

