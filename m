Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B127354D54
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfFYLPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:15:35 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:44906 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbfFYLPf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:15:35 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 8A43D30C00C;
        Tue, 25 Jun 2019 04:10:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 8A43D30C00C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1561461030;
        bh=yMHU74gXN/JCRn0CIItFQze+J4m2uoXx2y48lrkR9nk=;
        h=From:To:Cc:Subject:Date:From;
        b=EjU48dPLUmIcNIORkkrhH4t8iUcIN+Y94LEEfrRWsl38TMzs61iSloQ75LXQep1ii
         9PV6/2pjdlDcxJtf/fA0lJSpKdEan0Q4WkMhpph9DC6K5nhOoaW2j1IRPOizkWTSNS
         UyCTY6D5wO38Iyu6Fz2bW7XX+rHtXI3cMEfhixjQ=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id DA7C660D34;
        Tue, 25 Jun 2019 04:10:30 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 4F17FB02E92; Tue, 25 Jun 2019 13:10:28 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC V2 0/8] nl80211: add 6GHz band support
Date:   Tue, 25 Jun 2019 13:10:19 +0200
Message-Id: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is more or less a resend. The difference with the previous RFC is
in the nl80211 API as the previous RFC was breaking ABI.

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

