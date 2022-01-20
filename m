Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA94494B76
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jan 2022 11:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359781AbiATKN6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jan 2022 05:13:58 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:34404 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiATKN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jan 2022 05:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642673638; x=1674209638;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=haG84iyvbfXWuFHxn8z/Z75Pk+T+kgVVx6jLzWCNP4E=;
  b=iZQt304xKbSU87gDWHIzNYALx2jGDhf6t2KE/Fhb3JTIWLeUhy/kCizw
   zby2gU6/5yM+lolNi0ucmTHdDVGjvk+6sIcwdJarCfGWizF9L5PzxpUbH
   8yal5ALVF6nvOt9xaG5ZPObjMG1zBjKpMPrkzlcVXJ/7OMEAqDvK9MIEp
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 02:13:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 02:13:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 02:13:57 -0800
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 02:13:56 -0800
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] ath11k: support WoW functionalities
Date:   Thu, 20 Jan 2022 18:13:21 +0800
Message-ID: <1642673607-8896-1-git-send-email-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ath11k WoW basic funtionalities are merged from ath10k such
as magic-pattern, PNO, disconnect and patterns.

Hw data filter and pktlog purge are required for ath11k.

ARP and NS offload, GTK rekey offload are new WoW features
implemented on ath11k. 

v2:
	- fixed minor style issues commented by Kalle
	- fixed endianness 
	- rebased to ath-202112161538

Carl Huang (6):
  ath11k: Add basic WoW functionalities
  ath11k: Add WoW net-detect functionality
  ath11k: implement hardware data filter
  ath11k: purge rx pktlog when entering WoW
  ath11k: support ARP and NS offload
  ath11k: support GTK rekey offload

 drivers/net/wireless/ath/ath11k/core.c  |  36 +-
 drivers/net/wireless/ath/ath11k/core.h  |  31 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c |   1 -
 drivers/net/wireless/ath/ath11k/htc.c   |   6 +
 drivers/net/wireless/ath/ath11k/htc.h   |   1 +
 drivers/net/wireless/ath/ath11k/mac.c   | 217 ++++++++-
 drivers/net/wireless/ath/ath11k/mac.h   |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c   | 612 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h   | 353 ++++++++++++++-
 drivers/net/wireless/ath/ath11k/wow.c   | 759 ++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.h   |  36 ++
 11 files changed, 2034 insertions(+), 19 deletions(-)

-- 
2.7.4

