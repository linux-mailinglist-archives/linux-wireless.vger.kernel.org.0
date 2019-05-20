Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB823320
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfETMAy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 08:00:54 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35334 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730479AbfETMAx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 08:00:53 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id C686630C09A;
        Mon, 20 May 2019 05:00:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com C686630C09A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558353651;
        bh=SHlSA0kru7mjeLCL92KqU3JRgoPYjIUqmltuDn2qzBw=;
        h=From:To:Cc:Subject:Date:From;
        b=iZCQQVJouf08RmcHUNdxa905qmhJUwJ26skEKhjxWxuFSkyvUTSobc8y9hMokBBXa
         AdV6ji3pKVb0YXohKaBDHas31IO1RnQ+Qnt3eePzbr1pqnO4wek/EGl4rSIuAdsw0p
         P5Dshs0X+YYJPafx4cdiuyPV4Kqg/OuuJTkZUPLI=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 2AA7460D69;
        Mon, 20 May 2019 05:00:52 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 9B8D5B02EF1; Mon, 20 May 2019 14:00:50 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 0/8] nl80211: add 6GHz band support
Date:   Mon, 20 May 2019 14:00:37 +0200
Message-Id: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 802.11ax D4.0 a new band has been proposed. This series contains
changes to cfg80211 for supporting this band. With 2GHz and 5GHz there
was no overlap in channel number. However, this new band has channel
numbers with a range from 1 up to 253. The only place I could find an
issue with this is in cfg80211_wext_freq(). Not sure how to deal with
that so it is not part of this series.

The series applies to the master branch of the mac80211-next repository.

Arend van Spriel (8):
  nl80211: add 6GHz band definition to enum nl80211_band
  cfg80211: add 6GHz UNII band definitions
  cfg80211: util: add 6GHz channel to freq conversion and vice versa
  cfg80211: extend ieee80211_operating_class_to_band() for 6GHz
  cfg80211: add 6GHz in code handling array with NUM_NL80211_BANDS
    entries
  cfg80211: use same IR permissive rules for 6GHz band
  cfg80211: ibss: use 11a mandatory rates for 6GHz band operation
  cfg80211: apply same mandatory rate flags for 5GHz and 6GHz

 include/uapi/linux/nl80211.h |  2 ++
 net/wireless/chan.c          |  3 ++-
 net/wireless/ibss.c          | 16 +++++++++++-----
 net/wireless/nl80211.c       |  1 +
 net/wireless/reg.c           | 21 +++++++++++++++++++--
 net/wireless/trace.h         |  3 ++-
 net/wireless/util.c          | 14 +++++++++++++-
 7 files changed, 50 insertions(+), 10 deletions(-)

-- 
1.9.1

