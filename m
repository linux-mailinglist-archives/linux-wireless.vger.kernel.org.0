Return-Path: <linux-wireless+bounces-21278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FDFA814E6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 20:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB571BA7D47
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9A230BE2;
	Tue,  8 Apr 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNMLwAN1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880E23F43C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137908; cv=none; b=gHviOut7i2dF/Ene647bQWF6k3gQMlHyDeq+xAr12Rr2IrF0uvdCvGqFq26mtGKCOfnbywdsRIAEO6mY0a34OPXvsMmP1UtmLU4y9WV885j16y1ZWUPOd1d5emlhch5W1iz49UgoFtihkejAM/aGLF3KXWbyigwLmbHrXez+2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137908; c=relaxed/simple;
	bh=cBREigUbKcFUeeUestacV3Y/k4EKDqb/ckbNhnL8ly0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKzX6gGoIWLH1o83OSxbxIXQI+83D+cm8dOsTOgE+B+P49cMlLG3YjKt5h5s49Wk2XbsR8+NUjJYY1Iy+Ikr3EUB3LoGmXJvgvuMzOf0GteSE3xysiYL30rwJw4pNuFXBMzD0yxYckmYhqilmX1OgAlH/sVyi6NH7zIajfZUAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GNMLwAN1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538AcPJu014098
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 18:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nGewVlGR5Rw
	3EAn1ECySsP4zNMvSdf5+Gq5+AeTqVY8=; b=GNMLwAN1/geTCrT3bfp/FuFFkAu
	3N+qTtt/bxlRYRaQydTX9/vgXCfqCd7WMB2+aJIZ/uoeKdczdYqDKX7r1n6xkQmG
	0ZhmY0kA90X71TxvDOjFjn/W8cvzuMaCXbvEI1OHg2amOb1QGmgxppBNniV7vbPv
	tdCGQAVo/SBwm7CBkB9KVfLtbszdTGIn4EkFxEFFwv1ltbVukL9gE48KTVahv2wu
	p9oLf9w1sN8UukfNwvnWmr1PEFLFBZMSKOssP1aYfW8uuf6xSKdJXm2RGQ+pVSr7
	Y+jaa1NmTQgYoiL9lkHlrozTVj+KadNIw2DpoPBs9kM7PlPOh6TTYXc2aAg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpm8u1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 18:45:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso3031323a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 11:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137904; x=1744742704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGewVlGR5Rw3EAn1ECySsP4zNMvSdf5+Gq5+AeTqVY8=;
        b=lfIOQSmmB4XNE9ArdT+vuFk4/M+Ja0RmAHiSn67CsTJjwEpxK/TRnDt97VBB1GLcEg
         +XGUduBtaofZJ4P+d/VKKDM0NNCvIxlZgsECpwz737j+c3hWKQPOaWZqw7d2pW7c1WSg
         KlJDignVZB68y927RAvQ1WaFRrFCT7FbF9LIIk37MbqlbfCD38HHTuGVxsvvxAQBk7p6
         X/M7YgWx6+m6bCrr98wGeGVPY7dDGqkzgYmjmz5YiQ99NMS3nb1Yw+0+AiNg0V6Bt9MK
         l3c6dqFVWEOrZiYlmoualc82vZtbNS4WfYRQUpDltFDEz4hjyRtJHTH0eeHwzKxOTfsU
         cHhA==
X-Gm-Message-State: AOJu0YwxqTk8LqM88dAItitjrFGeyCuKQxquzj0JiTqQfLPrHSuSuugC
	VTE6aaTE7aK3sIfeOBAmLtzjb6RSmHR7JBpTSv56lTuEIRFcA7NIuu5vNjKyuCs+lRGYVaWpSs0
	kUYGUBinLzg9BDd0L3mntqoPd6aMs/G6VZK7Sc7V88kgawtBJPibUUjpu27VEIa6yv+irFW7vDQ
	==
X-Gm-Gg: ASbGnctUd7JrYkDBq7I8gxiLADPXHm0qX0KER0Upo+zHy0rY8UFvYQOQmSMUs1AForP
	+rJGpCRaDnYz2smikE5HCCGAF+iGb+NUo4j0+Yj2cbio4ohbaX1aFWhDvq7d10G8O7CMnignLnr
	tjRQy98PMxg1e2y1Ad+s2gUYbfAgeR5b7bShmm2yj5x5VGitarhf0EasBT2k90sYIiPZVGPIbaE
	Zt1Bd1da7ctqp++i2mAD2dv8NpOJhJLqiN+GlmlFX8vZrtfFc5iFzuEEKLW9ghdQcYEg+Xt0RnE
	JtfVaqvERdCIoBEUeLpBjMUtmFJFVMdh2+PV9qQVLS8hHpcYjkDh9h03o6tQJQjepuggpIo=
X-Received: by 2002:a17:90b:4ece:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-306dbb8c16emr404209a91.4.1744137903927;
        Tue, 08 Apr 2025 11:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUOVLwRfGhy9gwHXSdQAnOWYQikjdvGvb9IJL52qmnY3UBEm9qZ17YKSWTwjSbsRDxb3wagg==
X-Received: by 2002:a17:90b:4ece:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-306dbb8c16emr404186a91.4.1744137903551;
        Tue, 08 Apr 2025 11:45:03 -0700 (PDT)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb9500dsm12882212a91.47.2025.04.08.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:45:03 -0700 (PDT)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org
Subject: [PATCH wireless-next v5 1/3] wifi: nl80211: add link id of transmitted profile for MLO MBSSID
Date: Tue,  8 Apr 2025 11:44:59 -0700
Message-Id: <20250408184501.3715887-2-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408184501.3715887-1-aloka.dixit@oss.qualcomm.com>
References: <20250408184501.3715887-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iGuYys24jMY9t90KvUVI58ySBBsb5gZK
X-Proofpoint-ORIG-GUID: iGuYys24jMY9t90KvUVI58ySBBsb5gZK
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f56eb1 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=voIm8Yqn4N3_T5BSyJkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_08,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080129

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

During non-transmitted (nontx) profile configuration, interface
index of the transmitted (tx) profile is used to retrieve the
wireless device (wdev) associated with it. With MLO, this 'wdev'
may be part of an MLD with more than one link, hence only
interface index is not sufficient anymore to retrieve the correct
tx profile. Add a new attribute to configure link id of tx profile.

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       | 24 +++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index efbd79c67be2..ac51614fedff 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1300,11 +1300,13 @@ struct cfg80211_crypto_settings {
  * struct cfg80211_mbssid_config - AP settings for multi bssid
  *
  * @tx_wdev: pointer to the transmitted interface in the MBSSID set
+ * @tx_link_id: link ID of the transmitted profile in an MLD.
  * @index: index of this AP in the multi bssid group.
  * @ema: set to true if the beacons should be sent out in EMA mode.
  */
 struct cfg80211_mbssid_config {
 	struct wireless_dev *tx_wdev;
+	u8 tx_link_id;
 	u8 index;
 	bool ema;
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ddcc4cda74af..e9ccf43fe3c6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8036,6 +8036,11 @@ enum nl80211_sar_specs_attrs {
  *	Setting this flag is permitted only if the driver advertises EMA support
  *	by setting wiphy->ema_max_profile_periodicity to non-zero.
  *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Link ID of the transmitted profile.
+ *	This parameter is mandatory when NL80211_ATTR_MBSSID_CONFIG attributes
+ *	are sent for a non-transmitted profile and if the transmitted profile
+ *	is part of an MLD. For all other cases this parameter is unnecessary.
+ *
  * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
  * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
  */
@@ -8047,6 +8052,7 @@ enum nl80211_mbssid_config_attributes {
 	NL80211_MBSSID_CONFIG_ATTR_INDEX,
 	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
 	NL80211_MBSSID_CONFIG_ATTR_EMA,
+	NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID,
 
 	/* keep last */
 	__NL80211_MBSSID_CONFIG_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f039a7d0d6f7..bc48365ee188 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -469,6 +469,8 @@ nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_MBSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
 	[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX] = { .type = NLA_U32 },
 	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+	[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID] =
+		NLA_POLICY_MAX(NLA_U8, IEEE80211_MLD_MAX_NUM_LINKS),
 };
 
 static const struct nla_policy
@@ -5523,11 +5525,13 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 
 static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 				       struct net_device *dev,
+				       unsigned int link_id,
 				       struct nlattr *attrs,
 				       struct cfg80211_mbssid_config *config,
 				       u8 num_elems)
 {
 	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
+	int tx_link_id = -1;
 
 	if (!wiphy->mbssid_max_interfaces)
 		return -EOPNOTSUPP;
@@ -5551,6 +5555,9 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 	    (!config->index && !num_elems))
 		return -EINVAL;
 
+	if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
+		tx_link_id = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
+
 	if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]) {
 		u32 tx_ifindex =
 			nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]);
@@ -5572,10 +5579,25 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 			}
 
 			config->tx_wdev = tx_netdev->ieee80211_ptr;
+			/* Caller should call dev_put(config->tx_wdev) from this point */
+
+			if (config->tx_wdev->valid_links) {
+				if (tx_link_id == -1 ||
+				    !(config->tx_wdev->valid_links & BIT(tx_link_id)))
+					return -ENOLINK;
+
+				config->tx_link_id = tx_link_id;
+			}
 		} else {
+			if (tx_link_id >= 0 && tx_link_id != link_id)
+				return -EINVAL;
+
 			config->tx_wdev = dev->ieee80211_ptr;
 		}
 	} else if (!config->index) {
+		if (tx_link_id >= 0 && tx_link_id != link_id)
+			return -EINVAL;
+
 		config->tx_wdev = dev->ieee80211_ptr;
 	} else {
 		return -EINVAL;
@@ -6325,7 +6347,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_MBSSID_CONFIG]) {
-		err = nl80211_parse_mbssid_config(&rdev->wiphy, dev,
+		err = nl80211_parse_mbssid_config(&rdev->wiphy, dev, link_id,
 						  info->attrs[NL80211_ATTR_MBSSID_CONFIG],
 						  &params->mbssid_config,
 						  params->beacon.mbssid_ies ?
-- 
2.34.1


