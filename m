Return-Path: <linux-wireless+bounces-25017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C9AFDD7F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D299F5682B3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EBD1D8DFB;
	Wed,  9 Jul 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kf1+kyAj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93A1A9B53
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028540; cv=none; b=nPNzMioBcnwtUgWvC5T58VWDyS9icZw81LkuOVRrapWO4osBwEIPpTkAlIzSLtX2uF9EvyzhuEMKGtByE1uGaJL0P6iMEvv9UHRALIEaCtweD0NluOWghrBSRl7n0ErOGijyP6YIApP3Ej50xX/RQsHzGPKV3Qv/F6YZKikx2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028540; c=relaxed/simple;
	bh=tSN6YxxeeIwfNVtJUqNjYCzWvla7VBhlmPBH/aqTAKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHb+C3cn69zH+LYVR+VL8myoyPOudaxewp2EyzgP7oDgIhS6JLDrn8OUgi8KXun2mzL9H9S9V6sUTGuuXGyFtZudSSouAn0Y5TSxN5BYw73KqnU4gBpmipwMehICsy9Lk6SVL1RYAShtDXT+TqqjY7w7qzIeYbodPGCd6c7jfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kf1+kyAj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568HhHva029361
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 02:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LrC/7rgM5KIH+dR455FE6P08mwk11Z/ujo/JN/gT4BE=; b=kf1+kyAjDxkNDOMU
	kg6a4SruPw77esycZRlUOLQ6nP1pruOR+PuC2LNkv4DwlqACWt/2JAxNkBlFHYm7
	CfdlH9th4Ww+tXHvxXCA6IQnmTxTJV0t+/cuIMO48OJGt126h2uDzOlYhxwk5KH7
	qZL0ACh/ARBmHXoKoV1JzDsmmwE6eMJNZLm6L3F4VqaEj1XPglwkirbwZ3Oq7mua
	i33l518yhbgjm+n4FDY+BAO2d1mwGKs+rU1ZRNkGOilsC3yKkoY8MABvH7nnPFhQ
	jp4KxSto5Zp5FbYNVX9PZGKwgqKr5SnZG3ZK1R54RclvU0YBugTYns5ti+DOrieN
	VnEtlA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv4y33vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 02:35:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b115fb801bcso6257254a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 19:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752028531; x=1752633331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrC/7rgM5KIH+dR455FE6P08mwk11Z/ujo/JN/gT4BE=;
        b=TLK8DeanPTjOMRORElD7irJfzG4iNn8p/G568Un/A+2u5Te6IrPXQ2FuCYMYxrJCth
         hXhhL/hlCyRtFKpiU+BSSRW3EBFIy/mqxz2wEPKuF6/9XSbFGT+ZX1SJzdWuH4bSjWhk
         NqcNy++5aM+GoAOVJXy2tOCrg4m5PvLR6oVYfaF/XaXyf8pPNtX99ZN0+soJvy2WUSks
         xlxY/373TmzVpIGUL+0IdDJJrc095i8q8+XNlBlx0zLVXR1AlTpS+roc6A2qmbXFpU/h
         mMecpDRA7tSdijNTF2vaCXxFwub7IfELocz3QxXtheCNJH+rG/cls0WaTnJMNjEOgl60
         z4lg==
X-Gm-Message-State: AOJu0YztKSW+hT7t96plAVxwwulCRcF/Kg7H+fVnIpaHSr2nb1ULXhw/
	FbOjViQuVcGS1hK+Ac+qSFhZjP6ZF+xeqQMuPoQLjXwESp1Kd1OBEdSZMmK9YNfYP70U8OOdXl4
	zL6Gk/t+nSm5DkuA4y/zPisVUCjNxnHcxMBAspdLqLQOyEZbXs5SWv2Njme/t49kVAV5DRpfi2e
	MIXg==
X-Gm-Gg: ASbGncvKg3dGrQRGd9I60KbOSG/zDIvScrjv9udd78lXzqsTt5iJoJRg6kiZ0Tpm7U6
	kC7JBYMntsTBxlf/dhdWZBXPF8zYlwuF7F1CB/9cFVxNVyyJjINPFeQZVOcY2NNx2mRs7+aT+lQ
	F9vGwkwk6Dsd63BjrcoxwxJ5dau/D0sCSAJB8CQWc/TZwqsJLyVxuzkjzbWpSd7yoFaIm57iupQ
	BwhSKGb/hmiCrOPAjwopsrS9KtieJcfedIimPRvEKRoraCD9Rvq8j7wdOsyg92ZVX3ffs9RA23D
	D8anPDQ3ZTZN5jnWk6D+zCyHw5JaM4JKDwcpOsti5TFqwAt376A0b0SytrGHpD9SMTMnvTi4MCu
	wtkScwDs6rHkK0Xoknjd+NWGbT+dBmn9hgr50RihaA3CCcjg=
X-Received: by 2002:a17:902:db0c:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23ddb2f2c2dmr11512885ad.30.1752028530644;
        Tue, 08 Jul 2025 19:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAiXM0+YO7Lp5Y+AfPt1p2QIqNQp+OFLPNYizvEHO6VeMDTvLi20N2reU0NN2eXsOgIKyofg==
X-Received: by 2002:a17:902:db0c:b0:235:caa8:1a72 with SMTP id d9443c01a7336-23ddb2f2c2dmr11512635ad.30.1752028530234;
        Tue, 08 Jul 2025 19:35:30 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ef2bsm133169315ad.33.2025.07.08.19.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:35:29 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 09 Jul 2025 08:05:18 +0530
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: parse attribute to
 update unsolicited probe response template
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-update_unsol_bcast_probe_resp-v1-1-d3323ce9a7b5@oss.qualcomm.com>
References: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
In-Reply-To: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyMyBTYWx0ZWRfX7Gps+wtCiC0c
 RCoue0AqlbEr3OX492UZZYxeNOCPTrcdtydch6Is2ryrpmJKJ102t9za6bc9qE/If7PyRncy0Rt
 do1TBCjmkUvTSGCcghHnHrGdQO5oUkEFKR5lEmDQLCvovgWJ88qP1KukYSigkEyHRvN4+AqfOnm
 RUQV51bih3ChlFYYzFahJoS70UAfMQmkje4DFdOypBvbbpxi//iFFPFfrbKA2PgX0IPidSDTzFk
 2l5kw1gDWE+zwMwadqXvOvCYSryb27N8vbuTZiL4IA/9RQwRaafDtBUfH6yEdnjsG+3fnFvVlqX
 OGCOItiXL6w0B5srQhecO/Fknt6NY4r7O7v5+U0S1SrWE3vVPDQWfaZOm0M9yGmkwNknkJJgetS
 ohl0lNh3lWVMmmvffLcqSUXTCXaAz+BlvVFazg74BcZg3+qoS5e+PseIxnJER8AHJJzDjgsi
X-Proofpoint-ORIG-GUID: 162CUiCUmqMU4XBSbrOiLKu0HXvGM-v0
X-Authority-Analysis: v=2.4 cv=DNCP4zNb c=1 sm=1 tr=0 ts=686dd574 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=E4CoA09qZ1gvW9aZS_EA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 162CUiCUmqMU4XBSbrOiLKu0HXvGM-v0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090023

From: Yuvarani V <quic_yuvarani@quicinc.com>

At present, the updated unsolicited broadcast probe response template is
not processed during userspace commands such as channel switch or color
change. This leads to an issue where older incorrect unsolicited probe
response is still used during these events.

Add support to parse the netlink attribute and store it so that
mac80211/drivers can use it to set the BSS_CHANGED_UNSOL_BCAST_PROBE_RESP
flag in order to send the updated unsolicited broadcast probe response
templates during these events.

Signed-off-by: Yuvarani V <quic_yuvarani@quicinc.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 include/net/cfg80211.h |  4 ++++
 net/wireless/nl80211.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4a092da3a9de80df62e9c0e8792377a7bf65c739..0b903b4aaf877465c163fbf7ce9552ec9a430129 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1526,6 +1526,7 @@ struct cfg80211_ap_update {
  * @n_counter_offsets_beacon: number of csa counters the beacon (tail)
  * @n_counter_offsets_presp: number of csa counters in the probe response
  * @beacon_after: beacon data to be used on the new channel
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @radar_required: whether radar detection is required on the new channel
  * @block_tx: whether transmissions should be blocked while changing
  * @count: number of beacons until switch
@@ -1540,6 +1541,7 @@ struct cfg80211_csa_settings {
 	unsigned int n_counter_offsets_beacon;
 	unsigned int n_counter_offsets_presp;
 	struct cfg80211_beacon_data beacon_after;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	bool radar_required;
 	bool block_tx;
 	u8 count;
@@ -1555,6 +1557,7 @@ struct cfg80211_csa_settings {
  * @counter_offset_beacon: offsets of the counters within the beacon (tail)
  * @counter_offset_presp: offsets of the counters within the probe response
  * @beacon_next: beacon data to be used after the color change
+ * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @count: number of beacons until the color change
  * @color: the color used after the change
  * @link_id: defines the link on which color change is expected during MLO.
@@ -1565,6 +1568,7 @@ struct cfg80211_color_change_settings {
 	u16 counter_offset_beacon;
 	u16 counter_offset_presp;
 	struct cfg80211_beacon_data beacon_next;
+	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	u8 count;
 	u8 color;
 	u8 link_id;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 70ca74a75f228d27057d0fdf4b13bd2fba3f2536..6cb3c173343301835176206976ec2ff798ff1105 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10988,6 +10988,15 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CH_SWITCH_BLOCK_TX])
 		params.block_tx = true;
 
+	if (wdev->iftype == NL80211_IFTYPE_AP &&
+	    info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto free;
+	}
+
 	params.link_id = link_id;
 	err = rdev_channel_switch(rdev, dev, &params);
 
@@ -16790,6 +16799,14 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		params.counter_offset_presp = offset;
 	}
 
+	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
+		err = nl80211_parse_unsol_bcast_probe_resp(
+			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
+			&params.unsol_bcast_probe_resp);
+		if (err)
+			goto out;
+	}
+
 	params.link_id = nl80211_link_id(info->attrs);
 	err = rdev_color_change(rdev, dev, &params);
 

-- 
2.34.1


