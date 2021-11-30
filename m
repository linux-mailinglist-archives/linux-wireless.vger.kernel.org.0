Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5B463D3F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 18:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbhK3Ryp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 12:54:45 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:27973 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245201AbhK3Rye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 12:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638294675; x=1669830675;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2IKdhhCjaL2qt7idoUOQkSwxJJjrvzuuIwI6+Uzmgfg=;
  b=rHKSAsqSeN4uyWDfRp6Rq6qpUP8KxmG7GDaDaxZMVO+D7fayY3vIPHZU
   JTjqm0L3faeT0y70Lkv/055oTBNthvu+S8NekVgfZthTIJIoli07e74x/
   OhSxmVq/XeVMae4j8816KEI9Baq1mpqoveeG3YZKGnp9aATR7bLWy55Fp
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 09:51:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 09:51:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 09:51:12 -0800
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 09:51:10 -0800
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 0/2] mac80211/ath11k: add FEC type in radiotap header
Date:   Tue, 30 Nov 2021 23:20:46 +0530
Message-ID: <1638294648-844-1-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series adds LDPC FEC type in 802.11 radiotap header
in the captured packets.

P Praneesh (2):
  mac80211: fix FEC flag in radio tap header
  ath11k: add LDPC FEC type in 802.11 radiotap header

 drivers/net/wireless/ath/ath11k/dp_rx.c | 12 +++++++++++-
 drivers/net/wireless/ath/ath11k/hw.c    | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 net/mac80211/rx.c                       |  7 ++++++-
 4 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.7.4

