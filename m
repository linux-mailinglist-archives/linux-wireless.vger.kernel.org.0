Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32D752F7C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 04:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjGNCid (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 22:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjGNCib (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 22:38:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23907272C
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 19:38:25 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E1Sb3g028002;
        Fri, 14 Jul 2023 02:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=coCaSuNfjnjrftL5yRtiqUG7jnNvt4U6zPmiTJ04z2Y=;
 b=TPRe0N819fhOasGMOcLY9cKUTeIZDk/KBp6/g/kozx67tdIlhK9Q6pWc8dnM8PNKysek
 apymdvrg3UABALNZ8fCxQzskFBSSxgsfbWEjOjKI+LkDDdT9gP2n14nt3p4r/f8AyuT7
 7MoAc1Hz31UHtp+M6ctga5D6E17cFGFArfmuob1Ub1a6bZzBxrrZOS96M9B4yXQjDXkb
 jdmOtMd6zJ/sUKUgnq6hN0ci4NdxPDFdBQF5rNIOhoJPV+n65IlwE5L1G4mmUcybqIqt
 sP0qgAMkikxZA1anvo2jBoQQfeo21SS6sIAj6oEVWMHNh3BR/iQoYtIrZNJmt440RGYy Dw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptu8p8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 02:38:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E2cK4G025913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 02:38:20 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 19:38:18 -0700
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: reports address list if chip supports 2 stations
Date:   Fri, 14 Jul 2023 10:38:01 +0800
Message-ID: <20230714023801.2621802-3-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Dq5eX5oHZuTAxKAqN57ip3e8c9vbEFR
X-Proofpoint-ORIG-GUID: 9Dq5eX5oHZuTAxKAqN57ip3e8c9vbEFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 mlxlogscore=821 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report address list to mac80211 layer so user doesn't need to specify
address when an interface is added because the address can be allocated
from the list by mac80211.

The derived addresses have LAA(Local Administered Address) bit set, and
only the first byte is changed. Take the 00:03:7f:xx:xx:xx as example to
derive:
addresses[0] is unchanged, it's siill 00:03:7f:xx:xx:xx,
addresses[1] is 02:03:7f:xx:xx:xx,
addresses[2] is 12:03:7f:xx:xx:xx,
addresses[3] is 22:03:7f:xx:xx:xx,
addresses[4] is 32:03:7f:xx:xx:xx.
However as only 3 addresses are reported now, so addresses[3] and addresses[4]
aren't actually derived.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3a9494bc944c..f3cc6f140c8a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9268,6 +9268,33 @@ static int ath11k_mac_setup_channels_rates(struct ath11k *ar,
 	return 0;
 }
 
+static void ath11k_mac_setup_mac_address_list(struct ath11k *ar)
+{
+	struct mac_address *addresses;
+	u16 n_addresses;
+	int i;
+
+	if (!ar->ab->hw_params.support_dual_stations)
+		return;
+
+	n_addresses = ar->ab->hw_params.num_vdevs;
+	addresses = kcalloc(n_addresses, sizeof(*addresses), GFP_KERNEL);
+	if (!addresses)
+		return;
+
+	memcpy(addresses[0].addr, ar->mac_addr, ETH_ALEN);
+	for (i = 1; i < n_addresses; i++) {
+		memcpy(addresses[i].addr, ar->mac_addr, ETH_ALEN);
+		/* set Local Administered Address bit */
+		addresses[i].addr[0] |= 0x2;
+
+		addresses[i].addr[0] += (i - 1) << 4;
+	}
+
+	ar->hw->wiphy->addresses = addresses;
+	ar->hw->wiphy->n_addresses = n_addresses;
+}
+
 static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
@@ -9391,6 +9418,8 @@ static void __ath11k_mac_unregister(struct ath11k *ar)
 	kfree(ar->hw->wiphy->iface_combinations[0].limits);
 	kfree(ar->hw->wiphy->iface_combinations);
 
+	kfree(ar->hw->wiphy->addresses);
+
 	SET_IEEE80211_DEV(ar->hw, NULL);
 }
 
@@ -9433,6 +9462,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ath11k_pdev_caps_update(ar);
 
 	SET_IEEE80211_PERM_ADDR(ar->hw, ar->mac_addr);
+	ath11k_mac_setup_mac_address_list(ar);
 
 	SET_IEEE80211_DEV(ar->hw, ab->dev);
 
-- 
2.34.1

