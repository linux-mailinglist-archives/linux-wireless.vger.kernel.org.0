Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB98F401
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfHOS6Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 14:58:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43005 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731649AbfHOS6Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 14:58:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so1678286pgb.9
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mihG0ndhubnkGoVW/x1aM+cw4aNDXlresYz4WctbSK4=;
        b=gA+927w1zh1TeXls9VGjoTxGZRDF2ZXBjjz+4VKAXyCTBM3kGq1n1+0Sf7Zih5zv4L
         5ooU7SyG0hrAnKEAMQGIK5AMr/sAcWcfHW3mC8+tS49kQh3tXTOZTqEZiZp8/GG4sWOj
         3Q33ytEOuBIE4u5Dm6yw1fEXWiqDmZIT1UCFkx+PzGcFalAOTnOv6p+Z8RDj2ToX2Zfj
         kWG5adhFNalsRxMjg3EelJ/TWKW1Me1l9A2sOtCqZ/aJBUHKfro9L8vm7kSCiZJJou3G
         JY27Mc4Bn7L+kIIOakNrn0ZlNnGYRNTija1Vu92AtCegxXve5lereIVnoOQjEYaS+G67
         YoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mihG0ndhubnkGoVW/x1aM+cw4aNDXlresYz4WctbSK4=;
        b=gxjLCMa5SgtL7dp6lMBmcfdYHLd0PPkQKwQ/l5jvcd8SmSEzuHoukU9g5tZkqI1U/T
         Oi6K/rcGnzOhVnZ1mjxvyGypc33C5IaGX4t9qcKG8mo8RBFTqIh8pIEn89eUXsk/QG08
         Q2GLXknly1Tq415WxH2ytWpLXSwsByibBKIu6qHGwJ1p2RK3W31uixRAvblucSoXbvZL
         IwDl26bfGAEE5G4fPsGIimZTlPseLgwjVxQXISlo9JgRzkWWTcnkoURgkYrzfcmX5+S/
         Snfilrt9dzQmBObebEw1/y+5GiIhQajK7mLZXnLldvCaR++NYBxSldWS19lXrx5NacbF
         RiOQ==
X-Gm-Message-State: APjAAAXpGdFEKXvSttWQi4Z1MIzsLrtInI0miAbuHNtVUtIyQubsYGj5
        5pO5V/5zYGmt6XodrFZ/rrcGTwwo
X-Google-Smtp-Source: APXvYqy2+DWiLIqdIQaDNgKTuub0w7XgieVKXeFOZaxRAcDX6B2M356v528OWO+c8KC2XxPYDEX/xw==
X-Received: by 2002:a62:1b0c:: with SMTP id b12mr6780401pfb.17.1565895504431;
        Thu, 15 Aug 2019 11:58:24 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id 67sm2469878pjo.29.2019.08.15.11.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 11:58:23 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/1] Allow MAC change on up interface
Date:   Thu, 15 Aug 2019 11:57:01 -0700
Message-Id: <20190815185702.30937-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an example of how a devices MAC address could be changed while
the interface is up. Currently RTNL and mac80211 both require the
interface be down before changing the MAC.

After poking around a bit I found that some drivers can actually
change the MAC while the iface is up. Allowing user space to do this
while the iface is up would elminate a few potential race conditions
that arise when changing the MAC from user space.

This commit does a few things:
 - Adds an EXT_FEATURE that user space can check to see if the driver
   allows this MAC changing.
 - Adds a new NL80211_ATTR for including a "random mac" to     
   CMD_CONNECT. This MAC is passed down the stack and gets set to 
   the net_device's address.
 - Set this wiphy extended feature in iwlwifi (just as an example)
 - Relax checks in mac80211 which check if the interface is running
 - Set IFF_LIVE_ADDR_CHANGE on net_device. Note: I know setting this
   where I did is likely not the right way to do it, but for this
   proof-of-concept it works. With guidance I can move this around
   to a proper place.

James Prestwood (1):
  RFC: allow mac address change on up iface

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 ++
 include/net/cfg80211.h                        |  1 +
 include/uapi/linux/nl80211.h                  |  3 +++
 net/mac80211/iface.c                          |  5 ++---
 net/wireless/nl80211.c                        |  9 +++++++++
 net/wireless/sme.c                            | 20 +++++++++++++++++++
 6 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.17.1

