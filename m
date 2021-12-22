Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C9047CEB9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhLVJFi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:05:38 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:48225 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhLVJFh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640163938; x=1671699938;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HFGcOaLOpht93TO8OOk5h+Q+Lw9306SrZNuEq6bat3k=;
  b=Zw3p1rWrV+iIhr2C+CgRum+niQffJCJE4DshNNi8DMlNCjyS2gubQYUH
   2Z231LnRI6ZxVH0stns18ebm/qwmwNaQjxOufc1bTbTCJqwFMxntC2nO3
   l+MLmzWM4tYwJQAPlDwGEJtn8ELVRqWyGRmnimxi7Ntl4qeoNtQUrRRbo
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Dec 2021 01:05:37 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:05:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:36 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:34 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
Subject: [PATCH 0/6] cfg80211/nl80211: add support for EHT
Date:   Wed, 22 Dec 2021 14:34:37 +0530
Message-ID: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series adds support for EHT and 320 MHz channel width in
cfg80211 and also add userspace API to send rate information out,
conforming with P802.11be_D1.3.

Jia Ding (1):
  cfg80211: Add support for EHT 320 MHz channel width

Sriram R (1):
  nl80211: add support for 320MHz channel limitation

Veerendranath Jakkam (1):
  nl80211: add EHT MCS support

Vikram Kandukuri (3):
  ieee80211: add EHT capabilities element definitions
  nl80211: add support to advertise driver's EHT capabilities
  nl80211: add support to send EHT capabilities from userspace

 include/linux/ieee80211.h    | 702 +++++++++++++++++++++++++++++++++++++++++++
 include/net/cfg80211.h       |  79 +++++
 include/uapi/linux/nl80211.h |  89 ++++++
 net/wireless/chan.c          |  91 +++++-
 net/wireless/nl80211.c       |  67 ++++-
 net/wireless/reg.c           |   6 +
 net/wireless/util.c          | 131 ++++++++
 7 files changed, 1155 insertions(+), 10 deletions(-)

-- 
2.7.4

