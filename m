Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405AB4C83A8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Mar 2022 07:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiCAGEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Mar 2022 01:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiCAGEL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Mar 2022 01:04:11 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F7F60CFB
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 22:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646114611; x=1677650611;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=OYbuFDWj682ibRpmzI10PRt6i53ppm9DvP01f/vxpXw=;
  b=yes5EsqrSFXoax+Q7/IoKsJDAOArL8ckuRsZE00W796n4W/Q5zybUQRS
   iVURXser9k9VTvb5AGpegPjV/eayWQEFecbx6U1HRdckQ58bnJnqXICNh
   /Ek+oYOIHy2s23Z4BxzHsWYLMBgcFn+5mZ/luMWeLmfmwa2Nz9h+R+uwJ
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2022 22:03:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:03:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 22:03:30 -0800
Received: from hu-ssramya-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 22:03:28 -0800
From:   Sreeramya Soratkal <quic_ssramya@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_ssramya@quicinc.com>,
        <quic_vamsin@quicinc.com>
Subject: [PATCH] nl80211: Update bss channel on channel switch for P2P_CLIENT
Date:   Tue, 1 Mar 2022 11:33:20 +0530
Message-ID: <1646114600-31479-1-git-send-email-quic_ssramya@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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

The wdev channel information is updated post channel switch only for
the station mode and not for the other modes. Due to this, the P2P client
still points to the old value though it moved to the new channel
when the channel change is induced from the P2P GO.

Update the bss channel after CSA channel switch completion for P2P client
interface as well.

Signed-off-by: Sreeramya Soratkal <quic_ssramya@quicinc.com>

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 578bff9..8e0caaa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17816,7 +17816,8 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	wdev->chandef = *chandef;
 	wdev->preset_chandef = *chandef;
 
-	if (wdev->iftype == NL80211_IFTYPE_STATION &&
+	if ((wdev->iftype == NL80211_IFTYPE_STATION ||
+	     wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
 	    !WARN_ON(!wdev->current_bss))
 		cfg80211_update_assoc_bss_entry(wdev, chandef->chan);
 
-- 
2.7.4

