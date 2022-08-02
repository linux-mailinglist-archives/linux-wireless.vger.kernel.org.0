Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110FE587744
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiHBGup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiHBGun (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 02:50:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410B05FED
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659423043; x=1690959043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uh8Qc5pW3+fMKEOTk3yGfLLSEG/0y3ODm/zGAFvEG0Y=;
  b=jt4NzmOLemiifKhAmSFarc+wxnVzDI/EA+78IqBBpEX5sJGvmYTrJFIg
   FCsyqitCi7Ysu6jrgp05xlYG6Idc7Fn9ZGPgGcqu0AcW0PrnJGi3e+wds
   sD35aPf314VmMj7M85I9uHD+GegWnVCoSvB27Ieb1rQG5VR6yMvFKQWpw
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 23:50:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 23:50:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 23:50:42 -0700
Received: from CDCCSTEX0180100-LIN.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 23:50:41 -0700
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [RFC 1/2] wifi: mac80211: add a new field in ieee80211_rx_status for link id
Date:   Tue, 2 Aug 2022 12:20:18 +0530
Message-ID: <20220802065019.20791-2-quic_vthiagar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
References: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In MLO, when the address translation from link to MLD is done
in fw/hw, it is necessary to be able to have some information
on the link on which the frame has been received. Extend the
rx API to include link_id in ieee80211_rx_status.

Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
---
 include/net/mac80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f198af600b5e..23bc34657b16 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1480,6 +1480,9 @@ enum mac80211_rx_encoding {
  *	each A-MPDU but the same for each subframe within one A-MPDU
  * @ampdu_delimiter_crc: A-MPDU delimiter CRC
  * @zero_length_psdu_type: radiotap type of the 0-length PSDU
+ * @link_id: id of the link used to receive the packet. Applicable only with
+ *	MLO connection, valid link ids are in 0-14, link_id 15 means either the
+ *	link id is not known or it is a non-MLO connection.
  */
 struct ieee80211_rx_status {
 	u64 mactime;
@@ -1504,6 +1507,7 @@ struct ieee80211_rx_status {
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	u8 ampdu_delimiter_crc;
 	u8 zero_length_psdu_type;
+	u8 link_id;
 };
 
 static inline u32
-- 
2.17.1

