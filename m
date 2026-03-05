Return-Path: <linux-wireless+bounces-32554-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKePNQisqWmtCAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32554-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E6A215408
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3969D30131F9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275823CE492;
	Thu,  5 Mar 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="URro4RAa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kKJeb3gr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234943CE483
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726883; cv=none; b=Xc0+lENOiyLx8I/i0aGVAp5ue+m+uKNMe1PiCuLYhdkpvH2QSU8tmBXzA7nutvNW7texiCIe5F3rGj7zicXsWW6auI/upG3z2h6BdoMxFepNz6TfaeBQehS3g4RBfi66+0t12cujrrX8BO+HpQfzk98+b/aCL6xe/U7vUTDaJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726883; c=relaxed/simple;
	bh=WqdtA6H9ye7NDH26hCa2RWaselrrhj0hKHBf670W2ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HP5E6nkeKJ26Q3Yffm1CBCN2E2MwGP6VucfwNBkY9oGNRh2A1pDegVPTQt1xlHhbp47xZn9WrA7ysLmY5moj9mcMHLfh9LDIfpXrGeJYY4E6XAbJM54BYqtLDssooQNb/rPPebvfe2JGd1cMj5Vzd/R6AxnhuoeKLoJO8UqmnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=URro4RAa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kKJeb3gr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AG7RZ2118360
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=duYpSs0742f
	Gz4eBQO3/VuGzMWJ7c2sikKEHda6MdP8=; b=URro4RAau8eULBrY2ysbZKw3Xd8
	yZc/y+9nrlrs49K8DSCoDkfumNnf69n6dyiMnKsz3S6a+HGlJ4G63lU6ncl5jbhL
	ZQRRfcAu9jAZ4Yghiqax0Fz2WQPw8J0lAB2iiFvQzJnwb9e3zthwVLjhBwZrWW8Q
	7vAv2/d3ZHtKrBTgFH9DM9aYFc+ODKtwR4ZVuEMZrtuRvULdy43qLM5vEe7XnnGL
	Sp5MvRj8RHE4CcQyuYjkpprdbLNZxcuNYauzEdVHPSUocfZrwokT1HR+vghNdBRt
	Bz2jWZRd5B4olUfz7hZF4Whjcbv1g+fmiMPyGxReSbna0CFB+RMwGimC3rw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0m41sq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae4a6bb316so48823765ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726879; x=1773331679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duYpSs0742fGz4eBQO3/VuGzMWJ7c2sikKEHda6MdP8=;
        b=kKJeb3grAl+igaYP3YQP1en+uKd/WcKCSGfaZg4ik2jxsRS7sCzwYsN//5fBxpgKrs
         pIqTmMg2cGCIGV2JKBIjeHSjno9lXG4uHolrm0ZQRf/uvh9k+Z6Wic6c3hRkvRI59bzW
         DfuBUkcZiSCbMQ7IbQCmsWsItxent8Ps7T9lg3n+xwztiQ7gFl8RPGnHEd8fxgHnwoek
         fOM64K+nKSnNo0voyBUj/rIzi14BEUVfW2CzCCcxael/AVSu2nePBhGMoPInVjOD4lc4
         OzDBdsbeliqIp7FKqkSWbwLfWuVo2t/sIdjg+Hy3DB7uqEww6FxGZXkdUsG9aawwc5Ab
         Aghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726879; x=1773331679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=duYpSs0742fGz4eBQO3/VuGzMWJ7c2sikKEHda6MdP8=;
        b=ofAwWwK98YWbEKRyjK2QGFFf1/NJOFdBMBy9qfZwCakh0UbLBS6EksH2wj+pYpx2av
         PE7DkK1FHg7oNWD1rjQ68wJEWeyHlXl8z3QGXZIkrADCwCs99qdFmPRDZ06EQMahAnyX
         PkE8AJRUi1cC8lq+z8NzEGZp4BEyykB7ZDdoaGyGXwLdjuE97V06Fm7z0sNjhGKYMAia
         y0W/dmb3pV7bEnjCUYrYDyxLK+6p1W9BQuuY60dUUQaPSQGOOk8Yenw1qHQwXMVCYIGx
         nmzzLMNiHU8+qRHQYvgPNKJWDy8IpoVXS9InGb93N8N3tyuf51ZXNShd/r6LVy3B4jtl
         BYOg==
X-Gm-Message-State: AOJu0YzMbFWx8yz16aveRehhy/Rft7CVMYFldcU4GUKpVAdjr6zsL5OJ
	BBZd8bJxOarwBECLybFHU53++XsmvecOxicXnv/xFPH4XhmKTCuOCryfE1yHUluniO2hk/c7hxS
	SFu0xbV+V4BrUfk/yw+OOhVHZnVbYsHRcoK1+/4mwIcvzbN01ZqfRg+nZ0xzZelFbFTz3
X-Gm-Gg: ATEYQzwYDpS9dJ0+uh48rGVuI9hHFUb4U++8xpGBztqqrFl1MGNcrPdday4CNYtkBYu
	2MmtYZsBFjHuKp34Bg+daFzHINmDn079fS3UVr9jiXJoxBiwJckSumulH8IjXEln0el9vhsevaw
	kIOxujUF4+vPki7+BCqtKXRUzrSAF6b73YuqjXLbNulfV6DP1wwXo6WU8jHgULBCMqoszX1GA0g
	1ecuLrtUfvn196ofvk88npsNnPOBkOGm+rJiumu5eT6EP/1MCnQuU2bQ8we5h9Kf+aU2Emur6E7
	mQtCqgo2YTK6mrN9q8EjaQ0ipE3v1hYFEVZyVdeYAFMEo9hkKNh9xW1yBqzVB1dtOQFhSXrpqRO
	IQV7FRxm5D7BxC6Hpd+N2g6pYDXo9a1TzUiLlICde68FmVpzFsVoYO8w=
X-Received: by 2002:a17:903:2446:b0:2ae:483f:b239 with SMTP id d9443c01a7336-2ae6aaf9469mr63265305ad.30.1772726879311;
        Thu, 05 Mar 2026 08:07:59 -0800 (PST)
X-Received: by 2002:a17:903:2446:b0:2ae:483f:b239 with SMTP id d9443c01a7336-2ae6aaf9469mr63265015ad.30.1772726878642;
        Thu, 05 Mar 2026 08:07:58 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:07:58 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 05/15] wifi: cfg80211: add start/stop proximity detection commands
Date: Thu,  5 Mar 2026 21:37:02 +0530
Message-Id: <20260305160712.1263829-6-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e6wLiKp/ c=1 sm=1 tr=0 ts=69a9aa60 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=7Ubf0ANF9fMZ6H_vmasA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 0UC0r8mv19MFLNPmC3lAoLivnj-0nBzZ
X-Proofpoint-GUID: 0UC0r8mv19MFLNPmC3lAoLivnj-0nBzZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX0dIdBdWwdcb6
 +mp05aFHlJFZg5xGlwDEFCMYrY8EmOSW9xzCHPxWuTzJxTpoNjTc5YZU98vzMAh2wfKTt9CjkTQ
 YDg3rGpbcC6zkucihz/25NyqtlV+isF/uyLDxhD7gZd+0f9+LVgnO4WoRtEQLMXNVt6nfRXqWI+
 cq2GWqd0vu17bmUSN9rFtCnlvQbNOJvbQo+qcxdkcjcIHOTMbS8y++woGF0sOVMvKuMRrm0la0X
 DUZPLU57qWEB3UirWzg9IS+/GCViabhHWKFcOA/yVQGV77FegeX4IWDU8VHnyYWO+DT8bNAu+uZ
 k2ppLgJqjNgyz4OaAVWv0Q+FXEPcoPOt6PHC1HnGIOl4fMHNsrTqCHV+5SIUOLTs9fc00P40xrz
 ofQnZAWddVmZLW75/8CuEzYrmHHtjT1n20H8NNK1VwL8nOT8zi27CERrJd+aQODsUj0IvaGM/fG
 2mZKxewEpm4AjRVwvPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: E0E6A215408
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32554-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently, the proximity detection (PD) interface type has no
start/stop commands defined, preventing user space from
controlling PD operations through the nl80211 interface.

Add NL80211_CMD_START_PD and NL80211_CMD_STOP_PD commands to
allow user space to start and stop a PD interface. Add the
corresponding start_pd and stop_pd operations to cfg80211_ops
and ieee80211_ops, along with nl80211 command handlers, rdev
wrappers, and tracing support. Validate that drivers advertising
PD interface support implement the required operations. Handle
PD interface teardown during device unregistration and when
the interface leaves the network.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  5 ++++
 include/uapi/linux/nl80211.h |  9 ++++++
 net/wireless/core.c          | 32 ++++++++++++++++++++-
 net/wireless/core.h          |  2 ++
 net/wireless/nl80211.c       | 54 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 19 +++++++++++++
 net/wireless/trace.h         | 10 +++++++
 7 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 73cfe1a14c01..099a2ff9af58 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4900,6 +4900,9 @@ struct mgmt_frame_regs {
  *	links by calling cfg80211_mlo_reconf_add_done(). When calling
  *	cfg80211_mlo_reconf_add_done() the bss pointer must be given for each
  *	link for which MLO reconfiguration 'add' operation was requested.
+ *
+ * @start_pd: Start the PD interface.
+ * @stop_pd: Stop the PD interface.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -5271,6 +5274,8 @@ struct cfg80211_ops {
 				   struct cfg80211_ml_reconf_req *req);
 	int	(*set_epcs)(struct wiphy *wiphy, struct net_device *dev,
 			    bool val);
+	int	(*start_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
+	void	(*stop_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b1f0e72ec953..55a882535e2b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1369,6 +1369,12 @@
  *	%NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP. The current channel
  *	definition is also sent.
  *
+ * @NL80211_CMD_START_PD: Start PD operation, identified by its
+ *	%NL80211_ATTR_WDEV interface. This interface must have been previously
+ *	created with %NL80211_CMD_NEW_INTERFACE.
+ * @NL80211_CMD_STOP_PD: Stop the PD operation, identified by
+ *	its %NL80211_ATTR_WDEV interface.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1634,6 +1640,9 @@ enum nl80211_commands {
 
 	NL80211_CMD_INCUMBENT_SIGNAL_DETECT,
 
+	NL80211_CMD_START_PD,
+	NL80211_CMD_STOP_PD,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 67a603129c42..7bab8c4fb873 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -270,6 +270,25 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	rdev->opencount--;
 }
 
+void cfg80211_stop_pd(struct cfg80211_registered_device *rdev,
+		      struct wireless_dev *wdev)
+{
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_PD))
+		return;
+
+	if (!wdev_running(wdev))
+		return;
+
+	cfg80211_pmsr_wdev_down(wdev);
+
+	rdev_stop_pd(rdev, wdev);
+	wdev->is_running = false;
+
+	rdev->opencount--;
+}
+
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -294,6 +313,9 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 		case NL80211_IFTYPE_NAN:
 			cfg80211_stop_nan(rdev, wdev);
 			break;
+		case NL80211_IFTYPE_PD:
+			cfg80211_stop_pd(rdev, wdev);
+			break;
 		default:
 			break;
 		}
@@ -760,6 +782,9 @@ int wiphy_register(struct wiphy *wiphy)
 		     !rdev->ops->add_nan_func || !rdev->ops->del_nan_func ||
 		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
 		return -EINVAL;
+	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_PD)) &&
+		    (!rdev->ops->start_pd || !rdev->ops->stop_pd)))
+		return -EINVAL;
 
 	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
 		return -EINVAL;
@@ -1309,6 +1334,9 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	case NL80211_IFTYPE_NAN:
 		cfg80211_stop_nan(rdev, wdev);
 		break;
+	case NL80211_IFTYPE_PD:
+		cfg80211_stop_pd(rdev, wdev);
+		break;
 	default:
 		break;
 	}
@@ -1418,9 +1446,11 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_NAN:
 		cfg80211_stop_nan(rdev, wdev);
 		break;
+	case NL80211_IFTYPE_PD:
+		cfg80211_stop_pd(rdev, wdev);
+		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_PD:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 6cace846d7a3..f631b6997988 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -550,6 +550,8 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
+void cfg80211_stop_pd(struct cfg80211_registered_device *rdev,
+		      struct wireless_dev *wdev);
 
 struct cfg80211_internal_bss *
 cfg80211_bss_update(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 293fdd07ac7a..0ae96063c032 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16296,6 +16296,46 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
 	return rdev_nan_change_conf(rdev, wdev, &conf, changed);
 }
 
+static int nl80211_start_pd(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = info->user_ptr[1];
+	int err;
+
+	if (wdev->iftype != NL80211_IFTYPE_PD)
+		return -EOPNOTSUPP;
+
+	if (wdev_running(wdev))
+		return -EEXIST;
+
+	if (rfkill_blocked(rdev->wiphy.rfkill))
+		return -ERFKILL;
+
+	if (!rdev->ops->start_pd)
+		return -EOPNOTSUPP;
+
+	err = rdev_start_pd(rdev, wdev);
+	if (err)
+		return err;
+	wdev->is_running = true;
+	rdev->opencount++;
+
+	return 0;
+}
+
+static int nl80211_stop_pd(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = info->user_ptr[1];
+
+	if (wdev->iftype != NL80211_IFTYPE_PD)
+		return -EOPNOTSUPP;
+
+	cfg80211_stop_pd(rdev, wdev);
+
+	return 0;
+}
+
 void cfg80211_nan_match(struct wireless_dev *wdev,
 			struct cfg80211_nan_match_params *match, gfp_t gfp)
 {
@@ -18977,6 +19017,20 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_START_PD,
+		.doit = nl80211_start_pd,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV |
+					 NL80211_FLAG_NEED_RTNL),
+	},
+	{
+		.cmd = NL80211_CMD_STOP_PD,
+		.doit = nl80211_stop_pd,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_NEED_RTNL),
+	},
 	{
 		.cmd = NL80211_CMD_SET_MCAST_RATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 3c0fff3cb5ac..921566fa802d 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1061,6 +1061,25 @@ rdev_nan_change_conf(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_start_pd(struct cfg80211_registered_device *rdev,
+				struct wireless_dev *wdev)
+{
+	int ret;
+
+	trace_rdev_start_pd(&rdev->wiphy, wdev);
+	ret = rdev->ops->start_pd(&rdev->wiphy, wdev);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
+static inline void rdev_stop_pd(struct cfg80211_registered_device *rdev,
+				struct wireless_dev *wdev)
+{
+	trace_rdev_stop_pd(&rdev->wiphy, wdev);
+	rdev->ops->stop_pd(&rdev->wiphy, wdev);
+	trace_rdev_return_void(&rdev->wiphy);
+}
+
 static inline int rdev_set_mac_acl(struct cfg80211_registered_device *rdev,
 				   struct net_device *dev,
 				   struct cfg80211_acl_data *params)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 56718e250d31..1ebb6e90cf8f 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2375,6 +2375,16 @@ DEFINE_EVENT(wiphy_wdev_evt, rdev_stop_nan,
 	TP_ARGS(wiphy, wdev)
 );
 
+DEFINE_EVENT(wiphy_wdev_evt, rdev_start_pd,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
+	TP_ARGS(wiphy, wdev)
+);
+
+DEFINE_EVENT(wiphy_wdev_evt, rdev_stop_pd,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
+	TP_ARGS(wiphy, wdev)
+);
+
 TRACE_EVENT(rdev_add_nan_func,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 const struct cfg80211_nan_func *func),
-- 
2.34.1


