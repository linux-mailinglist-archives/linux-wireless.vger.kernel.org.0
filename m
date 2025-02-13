Return-Path: <linux-wireless+bounces-18947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C59A351A6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 23:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BF61891AD6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A072753EB;
	Thu, 13 Feb 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oc83GJrr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482352753E3
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487047; cv=none; b=rSAj/DqDmjswIFpifMCkVkJ7/7fzcG1cU9vwMkKpWFxgik2tCgZfz5WDsgiTMCt1kCoDS39JM5Nak1KlU1XD9kM+BB9Fik79nEtzr1H3g7mZaKCPkVbLjwtdxika0bm7drfyVQXdzBRl2djRMhgr3MSZoGSNawKvT86AytbDW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487047; c=relaxed/simple;
	bh=XzXIBlyrCOplQ0ol6YYBObeeQdNbOVEmV1pdhfWDggU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLDNNBy9urU9mS42jjH1TUcecSv7mKxabjRUABSrlqdsiz92YCWKBTPn7ol26JbDh8aKyjvwDgIAiLa2bInC41fPpx/TSRO+DfNug1AfM7WwA5GRhYCxso8JvOSVhBKw95j1bIK6/zrRZTnBxWXrq9lCIfxKCXh6V7Mz8Gcv9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oc83GJrr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DJ6Xi9020976
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=p6grw8wuFGe
	/gguOVhEpgEpd6veb5fHEaE9GwGP73BM=; b=Oc83GJrrP3tiTxtzl4TPWGI3C25
	EQF8QaZPD/DPPMF4PBwigrfn1vuu2KMVrrNhw2LFSwktsFoZXfiWsQ8coLS0FzUW
	GDlLwflXjZqmZUoykBqhHqGWaLjdf2/nZzTFAoIYPr1r5x/G5fEA0Py3SzA043Cy
	xXOCIMW+4xSMm8ijPvd/hCQSKSWipOslFOCL0WI4rlkRwCvkvSwEUHlOxUxv/3U0
	slrJ1xwf6LMb5rYUWGHH5jYdK2/FmhQctJBNGsMl1fbwocgKjcPO/0EBO+1HcxP5
	E5lLq1497PwJHtadLdD6fTtQoJO4qlvVJ7Nz+kAzmqNYnEUoJmSymDvMIpw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sdyxsy2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 22:50:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f7f00c75eso26164285ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 14:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487042; x=1740091842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6grw8wuFGe/gguOVhEpgEpd6veb5fHEaE9GwGP73BM=;
        b=MBU4o2KIChmIdl/hF9DtiffOzc1KxbIHsOB3DSCYypgHr5b1Jvw8m/26uGMTWLjSdJ
         EqDucggME6RceCQjtkZYsIoTK62l2fPtiRiCAntwXS6x1CPjlRuq5Fkl8xZKTtyF+4ZJ
         +jSWLiRslZ62IUoaKAN7GeB/+104/0do5ktdDpvkUlawRcnpKH5YFW+H5wJclBryjpO+
         bL72TJQ7o84yuKDa+a/x9yf58o38Pqmcr3Iqt+Yl0gFbLuwXfJW5Iqe3BJ0ywsGeHOA5
         th0Rbh+kPryEeTMsN0dJ0T81VCaG1A4jsPZMgn8azkDTGXVxifYYo83zvbfmjukUpnbj
         9hGw==
X-Forwarded-Encrypted: i=1; AJvYcCUFZrfwLloWguCiIejRdMOuekGrQC4CB7lwxWo8s/GTXy1RMb+KWNwbkIGoOCaaBjL1jxuw0YI5pcNoVZ/KGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWBs5T9G8EttagVEDbRCHY0kAR8mtDCDG7clfZn13K0XLFCzIc
	MsBFz5Gyd5PFZfFABXe/H4IE3y+7qRtZ6sV0Pe2PASlEwCniNquR+sSaxO0n2CjV047HgFo1X03
	qprASa3PQjohHIz15WCJ1JMvWUuGZU8RS+DptGMkpyDMq90pqEFzZLuO4e6nLNzqsoQ==
X-Gm-Gg: ASbGncsRHqCbBxpipYqiztiz78C/aXqZLj8Om71jruBI1cVfRLx3nOH6utH2hCMRxM8
	OCJlPN8Qg7fCklFD+ABn+dSQzkK6lFtW0ULJyM7GzOiJm1FJF0nKEM3NbzVZOYFj5xJqn4bLrQ1
	AZJfrs9sNPGCZNKWC3ewIgn2MzlkLEHyd1QBhbINwProA1tPwn9vsdCOzuJrxmIUmvzlSORT48Q
	8qjjJEesMY5lx2vtc6ccHiufTsRYuBwSw028NMU6jnRaNg8aKneuHvttQAw1tvJ11ZPSQLtR7ap
	e8rbL/C1K6APEIBcMYUC+S3yjxOJJuxc2OYYkK2L4xHnhe2NHLggimgPVRB6
X-Received: by 2002:a17:902:c402:b0:220:d7f9:9ea8 with SMTP id d9443c01a7336-220d7f99fc9mr51790625ad.26.1739487042414;
        Thu, 13 Feb 2025 14:50:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbl+ByEJmGsoi3MIiBDk9HO865Pptlkod6xeE/FgmeLuvCEu8A5fRJ/bY82qQD4lJfd4D3bA==
X-Received: by 2002:a17:902:c402:b0:220:d7f9:9ea8 with SMTP id d9443c01a7336-220d7f99fc9mr51790315ad.26.1739487042011;
        Thu, 13 Feb 2025 14:50:42 -0800 (PST)
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm17571665ad.243.2025.02.13.14.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:50:41 -0800 (PST)
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
Subject: [PATCH v3 1/3] wifi: nl80211: add link id of transmitted profile for MLO MBSSID
Date: Thu, 13 Feb 2025 14:50:34 -0800
Message-Id: <20250213225036.3118133-2-aloka.dixit@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
References: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iNP4K4o07lP8_RABV_hFr2_oUrWOCSRZ
X-Proofpoint-GUID: iNP4K4o07lP8_RABV_hFr2_oUrWOCSRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130160

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
 net/wireless/nl80211.c       | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a72e7eb7027f..d0e5e146704e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1286,11 +1286,13 @@ struct cfg80211_crypto_settings {
  * struct cfg80211_mbssid_config - AP settings for multi bssid
  *
  * @tx_wdev: pointer to the transmitted interface in the MBSSID set
+ * @tx_link_id: link ID of the transmitted profile in an MLD, default is 0.
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
index 9d8ecf20ef0d..ed2a181a2557 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8022,6 +8022,11 @@ enum nl80211_sar_specs_attrs {
  *	Setting this flag is permitted only if the driver advertises EMA support
  *	by setting wiphy->ema_max_profile_periodicity to non-zero.
  *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Link ID of the transmitted profile.
+ *	This parameter is mandatory if the transmitted profile is part of an MLD
+ *	and the interface getting configured is a non-transmitted profile. For all
+ *	other cases it will be ignored.
+ *
  * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
  * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
  */
@@ -8033,6 +8038,7 @@ enum nl80211_mbssid_config_attributes {
 	NL80211_MBSSID_CONFIG_ATTR_INDEX,
 	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
 	NL80211_MBSSID_CONFIG_ATTR_EMA,
+	NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID,
 
 	/* keep last */
 	__NL80211_MBSSID_CONFIG_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bd09110d393..13fc03858474 100644
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
@@ -5561,6 +5563,18 @@ static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
 			}
 
 			config->tx_wdev = tx_netdev->ieee80211_ptr;
+
+			if (config->tx_wdev->valid_links) {
+				if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
+					return -ENOLINK;
+
+				config->tx_link_id =
+					nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
+
+				if (!(config->tx_wdev->valid_links &
+				      BIT(config->tx_link_id)))
+					return -ENOLINK;
+			}
 		} else {
 			config->tx_wdev = dev->ieee80211_ptr;
 		}
-- 
2.34.1


