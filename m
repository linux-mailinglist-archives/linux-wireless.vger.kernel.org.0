Return-Path: <linux-wireless+bounces-33601-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C39KP6LvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33601-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:03:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C82DF1CB
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21302302B51A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C3314A9E;
	Fri, 20 Mar 2026 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgf1yue5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kj9JG3YA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0730BF6F
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029646; cv=none; b=rLRUTHFsch07JELpoZ43BQ9+pX15FCqD6tHMKkYwLHpVxxjtksheO394KDyilw06vtv/hFB8A8wvGEwiSrPsk+D976dH6mJMIiUsjSWMhFM3PjihZEA832UyhGqE6canZP+ZLB0z6EkS372D2ovLNs+Q2Q7qWkezW1XcnBN8XG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029646; c=relaxed/simple;
	bh=iRBJKemBfCLwlkVRZlUIUesmJABVVLI6V/NuyHqOLP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sz7EZdVQlSwasfDIh79nv9l9VdVzQ54mN+4mk6sswIkv2l8AtFG3F+j7fCNrGvdZv4yWOXsxDMkCm3ZUlBO5i4ev6Laf2YggDNxLGyFRt+vy7XE7iozx/cAOka5jdrC9O7UzZpVZmHypZ0waKEeU46kDazMQbr/fFtOdRFN3zvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgf1yue5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kj9JG3YA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEiVdv989534
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4kUfTCo9DLx
	CIy7y1jdlFaUddYxAB8XYUD7MkA84N2M=; b=fgf1yue5v2kFvswapjixpwbBW0K
	e5ZSoAG1NNoSfI2qXbjDQTsiktByEi02FXfcEPLhx7PG7F3PlhNEm9JiaBYC8oSo
	RFOkJ+FffRF3ddWwqQYMlO1tAqg7AnGjk275klBK1Q6KqFm+WrfaaVLoLs4CnRkI
	g0dMLHk1V4zs8Zht2JBJzNyKJogh0L2QggBZ6oAUAbf9anxMOijakiQYewheN0mu
	8T9lr9wMycqHd8TLymAVZijROx5SawJH1pR4Cu+xmn3m9Bcbr4K7vYEy9aulYU8T
	R3TdjObCrxjg5IcjUtczq250WdLumtsqf1F9/WIpNFJh3YaHjAnO49MDa6g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0vc6cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b04911610fso27530855ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029643; x=1774634443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kUfTCo9DLxCIy7y1jdlFaUddYxAB8XYUD7MkA84N2M=;
        b=kj9JG3YAr87XpUiDQpjI7OPlhhF8B3uHy2xoREEJSsdTkc/Ikaa/tZfUDWJrYPFFft
         SC9HsHPuUiujc9Tww8pBuPxYyNAc9JRBES6j8Hg/Hko83Hfc+Yv3UzrfMbGOACb4MzCd
         E0abcbgk0Pwbmw1WxSjC10d7ZdJis6VN5J4lQyUntnVJ3EJTWvGRHDLax9JoQyQfwEQI
         TQPH26xNI7YAbeFz3TuWtzs/Xb9jIEVHPqHAl2l92cO9pDA+bAr3vPeShpFQNfPR2O23
         9LH1HcodaO0ED9xbG1u5eVx5l3VzmnVTdEd0DYh/WQYkrs2P09PemWpE1gpve1KfcdLk
         m+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029643; x=1774634443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4kUfTCo9DLxCIy7y1jdlFaUddYxAB8XYUD7MkA84N2M=;
        b=gphpLoX9ScVt9PHC8jRDNC1zWyI2/Vib739/IW0DULoWrpwXmrtdHCllKupA9m/uG5
         JJEmC79H2ELcQ8OWf3lSqQ96Nvb2Nm5nSmQP0/r0VMuisFjZTORRVe6QNC2IiMpIwqZs
         wzvXJJ9xUs75FrVtrNvi7R63ZbX7KZtc3GmsrS6EACzPLcGQtsLFplQuOL4qRIIvR/lG
         8fFE0NVASZzlXOtJBNvMzAB0Ft5ihbffU4n81x4ggMSdLM55VaWJTC6DWAHu5137BjcX
         42AqRYeGVJkQJRV28yAiond8FbzNAtvcaDk1/coQJt0J0F7V0yx6lx61uRL3YjDo4JWZ
         HYrg==
X-Gm-Message-State: AOJu0Yy7xEQ5EIfzw49WOANoVab7p+uDHvuuCXVe+0VlN+GrTSz1Nn5q
	8m1JZjpttZLROMzaMwrsElPEaJzgFMMiCRiBJ2x5PpZz0Cy8osn/ODUFSRveUCm94it+IbeLYBt
	EdEaywtI19Zxk0UQhXJ9zLn1McyYSvBwh4uPqEfjvSjzx49t7bWboqTBgR3CfX5CyaSTJ
X-Gm-Gg: ATEYQzxY+8vlPcAkYyZy4ZoXN3Boyu3qPtr7154gRWFVawpkn6ir+4qP4DmwNLrkYxc
	JGub6UA321aYVzusR88BiR2KmAK5k3wbSNQ1rsXj/5sKcZN5qWEphsmTdz6QbnQjzjZN0c9GYWk
	aU72s+5FOZ3umxWDcYjsgQkM5tqHPZxT4/CJB3JxHzu8yVF5yyDtOnoZpCMAwLEJ0TZAa9MLm1t
	BZAcn7KLAlEdu+tdiVGpWdroZPb80miPdUAf+xJ7H9niuM+dLq4Wmt8H18skgJzBjcHObZ7DP8R
	YzpatvGp7pCRPCGDDbs6sHFRP/VE1vR2amjIH5VW8QpHlMW7jGxwmQgycRttWZiUjW32VB0VkUz
	nPSbrFHpXdNTQU1dIRSdda3xGejlK54bY6gnwt13pH5Y41xGE+grEsH4=
X-Received: by 2002:a17:902:f690:b0:2ae:803e:6c0d with SMTP id d9443c01a7336-2b082764904mr37592145ad.19.1774029642784;
        Fri, 20 Mar 2026 11:00:42 -0700 (PDT)
X-Received: by 2002:a17:902:f690:b0:2ae:803e:6c0d with SMTP id d9443c01a7336-2b082764904mr37590965ad.19.1774029640611;
        Fri, 20 Mar 2026 11:00:40 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:40 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 05/14] wifi: cfg80211: add start/stop proximity detection commands
Date: Fri, 20 Mar 2026 23:29:29 +0530
Message-Id: <20260320175938.2547288-6-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4yo5PHkbPIdMoelajzzRA3_Sh7eFDerZ
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bd8b4b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7Ubf0ANF9fMZ6H_vmasA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 4yo5PHkbPIdMoelajzzRA3_Sh7eFDerZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfXxnk+TUre/YEF
 j2NBjIPacrmPRTLFSZxUAKI43L/qK0HCxkDakrvliJn2gIO310kJbW/vuWELeqowo82b4T+pBkJ
 X6iyRgQz5f1jm//kG7Uld7aebl4jEp+W4Jqjcp1ZjP5QYXaZT7JZyYuvPAM/M+I38KaSfJYI9TQ
 XDw4r1da61Eh7eqH7rjKby0OtfQhqVBY7kjOKmxnj+DMI1l2hLOUR+AzfuwUolUMWKQxX8n4QlF
 EUEdtupTB4UyVtaOzafY6HmAJ4048ud8Di4fm12agHl7NLRnd6U86Pqq5P1tnT6dYMbe3/vMi0F
 qvyNGWNscNtbZyBJe+N1z03aH7xFT9eZ+09Y4MAQk6xIL6drg6G7JF78GnEhiCfO37tb5oxhCB7
 jkdN8B/AP2IsECZ6bidyouUwnKeQdXyTrXu/DHfftIpugJx/gw+DJpn1lEC74fWSn3g6Zbxus9/
 b/dKNVKfQrgSPdPLAUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33601-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 220C82DF1CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index ce5ed86161bc..7bc4fff024d6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4899,6 +4899,9 @@ struct mgmt_frame_regs {
  *	links by calling cfg80211_mlo_reconf_add_done(). When calling
  *	cfg80211_mlo_reconf_add_done() the bss pointer must be given for each
  *	link for which MLO reconfiguration 'add' operation was requested.
+ *
+ * @start_pd: Start the PD interface.
+ * @stop_pd: Stop the PD interface.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -5270,6 +5273,8 @@ struct cfg80211_ops {
 				   struct cfg80211_ml_reconf_req *req);
 	int	(*set_epcs)(struct wiphy *wiphy, struct net_device *dev,
 			    bool val);
+	int	(*start_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
+	void	(*stop_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 62e461ffa0ce..4fd2d3fb84ec 100644
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
index 75933f7865ad..90953194d0e3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16307,6 +16307,46 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
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
@@ -18988,6 +19028,20 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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


