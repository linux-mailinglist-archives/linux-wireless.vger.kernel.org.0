Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF582F7839
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 13:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbhAOMDo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbhAOMDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 07:03:43 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531EC061793
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 04:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pP0MquxMR5cAsIhCAYKLP3jzL6TZCHnX7CweazmA/aE=; b=TxEwWvQZiPCmP0YNSwQcp+OKC9
        i7R1elyoBPw6ee/pnIjFwwVPDjRGEtUzesNEFLsLqD/PQrdoXZEfFk7ULHfK6esM5YhqDUZlZsGdH
        qsLPT3TZ276nJxGq3gsiJvX4fWBrh2MlUMT/M/RtrXbIHNedH1858vTC6K8pSHRwrLWE=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l0NoT-0006Y0-Ao; Fri, 15 Jan 2021 13:02:45 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 0/9] replace minstrel with minstrel_ht
Date:   Fri, 15 Jan 2021 13:02:33 +0100
Message-Id: <20210115120242.89616-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The legacy minstrel code is essentially unmaintained and receives only very
little testing. In order to bring the significant algorithm improvements from
minstrel_ht to legacy clients, this patch adds support for OFDM rates to
minstrel_ht and removes the fallback to the legacy codepath.
This also makes it work much better on hardware with rate selection constraints,
e.g. mt76.

Changes in v3:
- add cover letter
- fix uninitialized stack variable
- add extra patch to fix significant rounding error in tpt calculation

Changes in v2:
- fix using legacy-rates overhead in tpt calculation


Felix Fietkau (9):
  mac80211: minstrel_ht: clean up CCK code
  mac80211: minstrel_ht: add support for OFDM rates on non-HT clients
  mac80211: remove legacy minstrel rate control
  mac80211: minstrel_ht: remove old ewma based rate average code
  mac80211: minstrel_ht: improve ampdu length estimation
  mac80211: minstrel_ht: improve sample rate selection
  mac80211: minstrel_ht: fix max probability rate selection
  mac80211: minstrel_ht: increase stats update interval
  mac80211: minstrel_ht: fix rounding error in throughput calculation

 net/mac80211/Makefile                      |   2 -
 net/mac80211/rc80211_minstrel.c            | 574 ---------------------
 net/mac80211/rc80211_minstrel.h            | 184 -------
 net/mac80211/rc80211_minstrel_debugfs.c    | 172 ------
 net/mac80211/rc80211_minstrel_ht.c         | 560 +++++++++++++-------
 net/mac80211/rc80211_minstrel_ht.h         |  96 +++-
 net/mac80211/rc80211_minstrel_ht_debugfs.c |  57 +-
 7 files changed, 482 insertions(+), 1163 deletions(-)
 delete mode 100644 net/mac80211/rc80211_minstrel.c
 delete mode 100644 net/mac80211/rc80211_minstrel.h
 delete mode 100644 net/mac80211/rc80211_minstrel_debugfs.c

-- 
2.28.0

