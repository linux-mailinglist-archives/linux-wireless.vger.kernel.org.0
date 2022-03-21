Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DBF4E2032
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 06:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbiCUFpP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 01:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiCUFpO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 01:45:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1C3467E
        for <linux-wireless@vger.kernel.org>; Sun, 20 Mar 2022 22:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647841430; x=1679377430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HAur4Qv3s+r4ZYeU6xri0n2RledHIZ3CB3ZRWxT01MQ=;
  b=W6hJGnCKd4CmqzxjF77LjCftBmvcyVpf5UiPtPmRZTIXy8ZJzuwIHADU
   Svq4SO5xdF+XXEjEUGoMNNwUFsRDZIlUHM6IePPoPx+6mqsLZatN3lcHg
   0QrlHGiC3Wvg3/XXAKSsjOWof9hCGV2qwb5XV2HUzQmacJZ8/mW4Jmb7E
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Mar 2022 22:43:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 22:43:49 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 22:43:48 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 20 Mar 2022 22:43:44 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 0/2] Add support to configure 6GHz non-ht duplicate transmission
Date:   Mon, 21 Mar 2022 11:13:13 +0530
Message-ID: <1647841395-20213-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

A 6GHz AP can decide to transmit Beacon, Broadcast probe response
and FILS discovery frames in a non-HT duplicate PPDU when
operating in non 20MHz Bandwidth to enhance its discoverability.
(IEEE Std 802.11ax‐2021-26.17.2.2)

Add changes to configure 6GHz non-HT duplicate beacon transmission
based on Duplicate Beacon subfield of 6GHz Operation Information
field of the HE Operation element in Beacon.

v2
* Addressed Johannes comments.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Rameshkumar Sundaram (2):
  mac80211: add support to configure 6GHz non-ht duplicate transmission
  ath11k: add support to configure 6GHz non-ht duplicate transmission

 drivers/net/wireless/ath/ath11k/mac.c | 38 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  8 ++++++++
 include/net/mac80211.h                |  3 +++
 net/mac80211/cfg.c                    | 15 ++++++++++++++
 4 files changed, 64 insertions(+)

-- 
2.7.4

