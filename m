Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013DF520397
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiEIRiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiEIRh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 13:37:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96738201385
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652117645; x=1683653645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TC+GfVYRiN38fTBglCzBfs4nZS4Dy0F9brBEut7fqys=;
  b=Ukxc6EypOZXABZvYIL0rhjsbVJMnUjpfc5+JOj8bSOKSFdZ9I5kGliyk
   Y1oph9K9OjbECFwXRdbdiwkZpOc+25zxFWT6CcArCQYAjj1fd8/eZfj2L
   PKlGegKTcxifugpzrOP9mHkf0xLuPSDdjcEZSB9HtgOdDIpxnCqq62UvK
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 10:34:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:34:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 10:34:04 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 10:34:04 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3 0/2] Additional processing in NL80211_CMD_SET_BEACON 
Date:   Mon, 9 May 2022 10:33:52 -0700
Message-ID: <20220509173354.2482-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace issues NL80211_CMD_SET_BEACON command as these
attributes are not processed as part of this command.
Add the missing implementation in nl80211 and mac80211 to fix the issue.

Aloka Dixit (2):
  nl80211: process additional attributes in NL80211_CMD_SET_BEACON
  mac80211: process additional data in ieee80211_change_beacon()

 include/net/cfg80211.h  |  2 +-
 net/mac80211/cfg.c      | 25 +++++++++++++++++---
 net/wireless/nl80211.c  | 28 ++++++++++++++++++----
 net/wireless/rdev-ops.h |  2 +-
 net/wireless/trace.h    | 52 +++++++++++++++++++++++------------------
 5 files changed, 77 insertions(+), 32 deletions(-)


base-commit: fc20106d6e2086dd37bf286605c28b28b4f2492c
-- 
2.31.1

