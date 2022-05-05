Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3351C636
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 19:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbiEERjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbiEERio (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 13:38:44 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABED5BE47
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651772103; x=1683308103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MGPruOtKwHBXaOEME50xKey8/+ae64miPwtEjFaDvGs=;
  b=p70sycuXuWJNn1H1gVVCvSXx7OZgRgbfiS/B1OlreCW9g3qMWsxlSd3S
   H0672bbzPBJ5ha+bGT4vJIRMSjFI2CfuEGLaqaLBSAUutL/u1XT2Uawps
   rOzGssqb5LQdrf2s8nPjRVYwP+IqptTczhgLHnQiIFiljAawtrW9d1Msa
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 May 2022 10:35:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:35:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:35:02 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:35:02 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 0/2]  Additional processing in NL80211_CMD_SET_BEACON
Date:   Thu, 5 May 2022 10:34:47 -0700
Message-ID: <20220505173449.4424-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

This series addresses the comments for the following series:
https://patchwork.kernel.org/project/linux-wireless/list/?series=417807&state=%2A&archive=both

Command NL80211_CMD_SET_BEACON is not renamed to NL80211_CMD_UPDATE_AP
as part of this series to keep the changes to a minimum but it can be
done if necessary.

Aloka Dixit (2):
  nl80211: process additional attributes in NL80211_CMD_SET_BEACON
  nl80211: process additional data in ieee80211_change_beacon()

 include/net/cfg80211.h  |  2 +-
 net/mac80211/cfg.c      | 25 +++++++++++++++++---
 net/wireless/nl80211.c  | 24 ++++++++++++++++---
 net/wireless/rdev-ops.h |  2 +-
 net/wireless/trace.h    | 52 +++++++++++++++++++++++------------------
 5 files changed, 74 insertions(+), 31 deletions(-)


base-commit: fc20106d6e2086dd37bf286605c28b28b4f2492c
-- 
2.31.1

