Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37467F5FE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391127AbfHBLbX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 07:31:23 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:49784 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729311AbfHBLbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 07:31:23 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7B35F30C01D;
        Fri,  2 Aug 2019 04:31:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7B35F30C01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1564745481;
        bh=G5e+JGOyV166YLy4c3OwCnZcCBYt9L0e2IfkDnUpWY4=;
        h=From:To:Cc:Subject:Date:From;
        b=keSl5RXEmykU/8ot/ezmvPl/7be5RZ/taa8v8uXCbZizrux4/wUCIQH5sOTCSLY1W
         tnTWSgH23KPjxoAzdxoI9UvLltS0fjc1MFrHANGFCYDDJ6ZhuVEQS9u31VmIwkrGZc
         DU8I+8jzJDJs00dyArQcZpyavi6CsD7Ff9+QA09w=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 4667B60C88;
        Fri,  2 Aug 2019 04:31:21 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 05E41B032E8; Fri,  2 Aug 2019 13:31:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V3 0/8] nl80211: add 6GHz band support
Date:   Fri,  2 Aug 2019 13:30:57 +0200
Message-Id: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Changing to formal patch series instead of RFC.

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
 net/mac80211/tx.c            |  1 +
 net/wireless/chan.c          |  3 ++-
 net/wireless/ibss.c          | 16 +++++++++++-----
 net/wireless/nl80211.c       |  1 +
 net/wireless/reg.c           | 21 +++++++++++++++++++--
 net/wireless/trace.h         |  3 ++-
 net/wireless/util.c          | 14 +++++++++++++-
 8 files changed, 51 insertions(+), 10 deletions(-)

-- 
1.9.1

