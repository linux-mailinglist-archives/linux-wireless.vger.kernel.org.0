Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73410566E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 17:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKUQEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 11:04:48 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:6582 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbfKUQEr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 11:04:47 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALFu718003199;
        Thu, 21 Nov 2019 08:04:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=o/oIGGHPmwt5MFTKPl2GcISKabBWhPBOdPXPhlV+8H8=;
 b=nkGygBtmdc1LxIp0VzpsKssm8mQFI+syng1Rek/N5Fx3Vz4o2KAlRceJkhXNdV7WpjTG
 XDtRj/LiYd+OAIqSLM6J2VNtOKOhaNSDydtTUnIi4imHPzYoAdESDQW5aFV8JKZqOfYx
 0oQTjw6AhdjJCsngL+bImzmnJoZsc2gUu3BAic/kW+6Uj0JCgQwoUFBH9rNaO+Q33BY+
 dZy9MdKD905LxSBE7A5xWx5GEgrqRcvfxSOu2K78FQhsJ20suhvWSobxpYE0LIrajl6s
 oQGuDbTsdOO/8v7D9Xn7zObUH6qZ08AMxDZNaBLqiKpjFY/RA7LbR2eulwEnhjCLDQfK uA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wd090yntp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 08:04:44 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Nov
 2019 08:04:43 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 21 Nov 2019 08:04:43 -0800
Received: from testmailhost.marvell.com (testmailhost.marvell.com [10.31.130.105])
        by maili.marvell.com (Postfix) with ESMTP id 898743F703F;
        Thu, 21 Nov 2019 08:04:40 -0800 (PST)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Mohammad Tausif Siddiqui <msiddiqu@redhat.com>,
        huangwen <huangwenabc@gmail.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: [PATCH] mwifiex: fix possible heap overflow in mwifiex_process_country_ie()
Date:   Thu, 21 Nov 2019 21:34:38 +0530
Message-ID: <1574352278-7592-1-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mwifiex_process_country_ie() function parse elements of bss
descriptor in beacon packet. When processing WLAN_EID_COUNTRY
element, there is no upper limit check for country_ie_len before
calling memcpy. The destination buffer domain_info->triplet is an
array of length MWIFIEX_MAX_TRIPLET_802_11D(83). The remote
attacker can build a fake AP with the same ssid as real AP, and
send malicous beacon packet with long WLAN_EID_COUNTRY elemen
(country_ie_len > 83). Attacker can  force STA connect to fake AP
on a different channel. When the victim STA connects to fake AP,
will trigger the heap buffer overflow. Fix this by checking for
length and if found invalid, don not connect to the AP.

This fix addresses CVE-2019-14895.

Reported-by: huangwen <huangwenabc@gmail.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index 74e5056..6dd835f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -229,6 +229,14 @@ static int mwifiex_process_country_ie(struct mwifiex_private *priv,
 			    "11D: skip setting domain info in FW\n");
 		return 0;
 	}
+
+	if (country_ie_len >
+	    (IEEE80211_COUNTRY_STRING_LEN + MWIFIEX_MAX_TRIPLET_802_11D)) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "11D: country_ie_len overflow!, deauth AP\n");
+		return -EINVAL;
+	}
+
 	memcpy(priv->adapter->country_code, &country_ie[2], 2);
 
 	domain_info->country_code[0] = country_ie[2];
@@ -272,8 +280,9 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 	priv->scan_block = false;
 
 	if (bss) {
-		if (adapter->region_code == 0x00)
-			mwifiex_process_country_ie(priv, bss);
+		if (adapter->region_code == 0x00 &&
+		    mwifiex_process_country_ie(priv, bss))
+			return -EINVAL;
 
 		/* Allocate and fill new bss descriptor */
 		bss_desc = kzalloc(sizeof(struct mwifiex_bssdescriptor),
-- 
1.9.1

