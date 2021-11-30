Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83180463D41
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 18:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbhK3Ryr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 12:54:47 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33628 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245158AbhK3Ryh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 12:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638294678; x=1669830678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=AehaPN9mAVpFKqjj4RHvCuU9GRZ7+GwKC1WV+P6Ie5U=;
  b=Ns8+L6SdB0Jaog0R6yyG8R+JTSU7kkmUjYWad82KoswKZt+EQlQmqlzk
   PFd14fOC6RDCocHklN+P3SB+Se+DsIWoK9humBqydLehSuQDlUDmsPPBr
   PJiMlXF0VtFaKcXp0Y94rZAVzmmZzeZ9y7I3BYLFUiyXkcCvk7MdBTHcb
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2021 09:51:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 09:51:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 09:51:17 -0800
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 09:51:15 -0800
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 1/2] mac80211: fix FEC flag in radio tap header
Date:   Tue, 30 Nov 2021 23:20:47 +0530
Message-ID: <1638294648-844-2-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638294648-844-1-git-send-email-quic_ppranees@quicinc.com>
References: <1638294648-844-1-git-send-email-quic_ppranees@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mac80211, while building radiotap header
IEEE80211_RADIOTAP_MCS_HAVE_FEC flag is missing when LDPC enabled
from driver, hence LDPC is not updated properly in radiotap header.
Fix that by adding HAVE_FEC flag while building radiotap header.

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 net/mac80211/rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 9541a4c..be12fa8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -465,7 +465,12 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 		unsigned int stbc;
 
 		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_MCS));
-		*pos++ = local->hw.radiotap_mcs_details;
+		*pos = local->hw.radiotap_mcs_details;
+		if (status->enc_flags & RX_ENC_FLAG_HT_GF)
+			*pos |= IEEE80211_RADIOTAP_MCS_HAVE_FMT;
+		if (status->enc_flags & RX_ENC_FLAG_LDPC)
+			*pos |= IEEE80211_RADIOTAP_MCS_HAVE_FEC;
+		pos++;
 		*pos = 0;
 		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI)
 			*pos |= IEEE80211_RADIOTAP_MCS_SGI;
-- 
2.7.4

