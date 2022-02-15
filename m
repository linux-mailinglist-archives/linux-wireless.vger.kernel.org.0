Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2A4B665E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Feb 2022 09:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiBOIn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Feb 2022 03:43:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBOIn5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Feb 2022 03:43:57 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA15111F86
        for <linux-wireless@vger.kernel.org>; Tue, 15 Feb 2022 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644914628; x=1676450628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wUfS1QBgvP0sLxhnfiDnevssPUKVFCs+k094FnHVCNY=;
  b=uD42fNzBwthaOzt061L/mYo4ZSJpCzE/YMl2Y2NvZk8ePkrEg4D0fwVy
   t9rkBOA9uYnFevaLrz3wgPgf82sIUQ9F0mdH4N4Z2AYXMLTJzYHjlE3Df
   AazkUgvtOUmKpNADi7czW+pwLHLIs96qDPzWQuNEbUmnCj8GxDX8zF9aj
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 00:43:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:43:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:43:47 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:43:45 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH 0/2] Add support to configure 6GHz non-ht duplicate transmission
Date:   Tue, 15 Feb 2022 14:12:59 +0530
Message-ID: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

A 6GHz AP can decide to transmit Beacon, Broadcast probe response
and FILS discovery frames in a non-HT duplicate PPDU when
operating in non 20MHz Bandwidth to enhance its discoverability.
(IEEE Std 802.11ax‐2021-26.17.2.2)

Add changes to configure 6GHz non-HT duplicate beacon transmission
based on Duplicate Beacon subfield of 6GHz Operation Information
field of the HE Operation element in Beacon.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Rameshkumar Sundaram (2):
  mac80211: add support to configure 6G non-ht duplicate transmission
  ath11k: add support to configure 6G non-ht duplicate transmission

 drivers/net/wireless/ath/ath11k/mac.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  8 ++++++++
 include/net/mac80211.h                |  1 +
 net/mac80211/cfg.c                    | 17 ++++++++++++++++
 4 files changed, 64 insertions(+)

-- 
2.7.4

