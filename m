Return-Path: <linux-wireless+bounces-32441-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGmWA1ncp2kRkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32441-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069911FB773
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95AC03035165
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12D29408;
	Wed,  4 Mar 2026 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/D3eImv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ym1SndUU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6B351C2A
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608587; cv=none; b=dn2tHU1BrOJ8I7XeZcBKvQ5hSKIekd/rhRVqDUskJf6pV7t73mQF3X8M2CpDPtLjyVcY3aeX3CjqK1DndeUtQnSOsZCsjeJVC/SYHw+XEho8fwuVPclngKYc3i2lJWvgirr//SteivkKgGSIH0HLb23KuhNw0IK+zbMDZMZSgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608587; c=relaxed/simple;
	bh=bMx5dIamVQgaaYkswevjYpjswrk+/HUH/La/GyzG5Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhCNm+JzXW9jsmMJC/i45jmH7v6qKKEJIXj8dMHzgKxXKlnbv+MZsB1LGBm/MMXZ1P8vkQqU5lddxIIOVCcihvUh/XQql1ZDdzJqyimqAih26cJWzzBFxvKoOhh21Q8qFmYDnWgU/76yEc1u1iqobBfdQqOu2pcrZqaHsAN1xGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/D3eImv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ym1SndUU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SLTu2274966
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=chgdQ+IhSQD
	wxCOhGsTArTNzkFpYvRrHpEtqxgrXw0c=; b=n/D3eImv+lZtYz5EEaKiPZSE3XH
	d29L4s1HfoNLbTRpqBDXrDgQgF5IHVoIEngxb3KE7FPlZQ23WBKtQymR1Nmu7KK5
	KwzuhUt3HP5Y3389WYUGivLT70438zrSCjhS/gG4gG2a2v35XQOI69j8RKEzKf/2
	9g+nn9FFmw/vqeEQNKUaaarcgWNzR2ZAi93jNyvB704WDLK7VLUeeH9hQbnsOG5M
	n0cfiebeNEOT//zHR9mVMb21V1bl01ks0Vo1Ps6tZKFznGO23uFx+ebYqqkr4X4y
	/yPPo3fZ7da4OrvsMQ4B7Oqav5OjHFH9bw2W1TNYrsoBFq8/dRiSyImpPVA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpc4mrssu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4cdfc468so31990845ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608582; x=1773213382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chgdQ+IhSQDwxCOhGsTArTNzkFpYvRrHpEtqxgrXw0c=;
        b=Ym1SndUUOBBZ/6LhjD6VWse+uRbkotT3uJvU/dx+RJmOCVKOF64Yxc/1XjRWqyw+Iu
         GYDLyne9tJ22tAUTIrYwSUTVGX3eO/ZIR4SIjB4vHuXeiY0owa7n9yQYlIEmh0xumcwI
         XPDtfj640cl+paWM3L2pR7ChIhbB2s/7gV9ulozHnCAdq9WoctnjIXSOeY0M4tD5HjLt
         NT+Imw63gEcQJIW95gmG6bdiPfXCfjzTwQ7AAhrQO8suI04BjWBMSkTY/zyNE0g5GduB
         8SI2yE37pFEm5qFbIqf3UVRnsb6ERU9u1xvPx1jnPQ+D93Dm1RoYjdZ6OhuWi/yehNVy
         rjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608582; x=1773213382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chgdQ+IhSQDwxCOhGsTArTNzkFpYvRrHpEtqxgrXw0c=;
        b=u0t5EblRqaGLG2FC5N97HHwnXWLuNrrtO0dAjQsptU+oClsJrpLsexZzfGvQzajjTO
         8JWh3m+MQVfWuga5jUeNjFQLRZvZfQczVJUEFBlXGFLWmOQ5YwtIlVvSMRfFpLuxbyRE
         P9YYTXn36yGMGOf3z8RaUhJ+aKLY61aHc3bFt0/hKzBCbV/83KllYMke5UpaoVR3a13M
         LwI7qev649TFPt+nsONCw/ePp08jLwAu7uoxtRGYM1LOTWt1h/HUYi3GyJkQDpJ1UMSq
         BNBuXohTef0JVd7cU3wsK5cpJR+jlBpb+6SuB0PKpNxDQS7bYOdEPCz0HmFPTvqaEB/x
         ywWQ==
X-Gm-Message-State: AOJu0YwXr91/+OJQqB3cRzxpNlk/dcd1E0Ow8BBlqi9RQEimrvaizdqf
	fkON+twwDwSfwZYqq9u6AJ9/9eLEEQeoUU04B5HkI5rR1xShxb5GBXQDopgj02oT4loLpJNYaTN
	BRpFmgnA2LD+oJYe/PtGHONxzkqNr4n1XtVi70YsBtC0t7W1Q1m3v5kNFnrhn51COW6RV
X-Gm-Gg: ATEYQzxsqpgZuqeJBzrT0T24Nr8fbUNum4ECP0AiQFTjfy5BcF2sBMZxYERk5aNTUop
	22bkI7NMNl2SHECP0dFMKYG0z8ZERGm4MqT8lOsxvrobzuxJa/GzW/M1SZjPgitMThf0PZAdY2X
	pZVWH7o5gIQnWWanaZufmRtyJW+dm4yTr5/o2ZEsnVsdnZWRpaD7p17Dmryh6LS1vIfKkbwF5EO
	zV1K+cX8g9H1RKmGdRY4AiLqMpZ+tmzG1zW08cMg6+AqFtm5mmYJjApobfq6juhci5DxkPX9ia0
	hDjUnD/tDY/fcg6qKAZDixbq8dT8Gt8EnuZ3I20mXM28FhD/mP6sdth+saIFfVCq0G9aWaLDaYX
	9EuXnnZUFGvw4X+rV4MQ9HC8Q6g5EIfO0tYNTNhFZZQrO160P33Po1DY=
X-Received: by 2002:a05:6a21:4598:b0:395:cb87:dd6b with SMTP id adf61e73a8af0-3982ded303emr1006513637.28.1772608582033;
        Tue, 03 Mar 2026 23:16:22 -0800 (PST)
X-Received: by 2002:a05:6a21:4598:b0:395:cb87:dd6b with SMTP id adf61e73a8af0-3982ded303emr1006491637.28.1772608581484;
        Tue, 03 Mar 2026 23:16:21 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:21 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 05/16] wifi: cfg80211: add start/stop proximity detection commands
Date: Wed,  4 Mar 2026 12:45:27 +0530
Message-Id: <20260304071538.3833062-6-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vGIEL0IWXfOgkOWXUdk8hlLwJQoCDc8G
X-Proofpoint-GUID: vGIEL0IWXfOgkOWXUdk8hlLwJQoCDc8G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX2yyKmt1+H7Bv
 IqyDUzXveqgNzMnau8wAawJH+3kQZujxzRUr3hq4VmAymMZlz1wECoasOtRw5sftfjlQygK+For
 Jn02NIjERdB6MonRMCE/dXdQLpIbfcNfvYkOfm5NiV1+k0S3c1URmItQspPmmM3kN4SbUR8e4Eu
 fhQaN8sw75xqVyO2jXurBeZZ5fM29GRotpNiQA2gvJPtXUSMICNQyqBRgo9eWqYVNnu0bRVeO52
 LuzsX6XMTBti81DCBRvsmb1zOQgxovUCNrVYGFmGyDzLV9iZHahed5AF0xgHkG1Gy6u/75BAi4S
 ypHi9H7LNKurgucOcarvdONzIhkGpMIZDZDaPsxF1th90u4naAYAesx6g74tejZe+44frYoSTIh
 hamVPnXLBYaCA1tzRSXpCOTorA/0SHjn8aMiHtLwDji3KsKc5QY6QZfHd61hOolol/werBNEakb
 2m/xyf3MPmupJb+pr/A==
X-Authority-Analysis: v=2.4 cv=C67kCAP+ c=1 sm=1 tr=0 ts=69a7dc47 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=7Ubf0ANF9fMZ6H_vmasA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: 069911FB773
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
	TAGGED_FROM(0.00)[bounces-32441-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
 net/wireless/trace.h         | 20 +++++++++++++
 7 files changed, 140 insertions(+), 1 deletion(-)

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
index 56718e250d31..978c019c01b4 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2375,6 +2375,26 @@ DEFINE_EVENT(wiphy_wdev_evt, rdev_stop_nan,
 	TP_ARGS(wiphy, wdev)
 );
 
+TRACE_EVENT(rdev_start_pd,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
+	TP_ARGS(wiphy, wdev),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT,
+		  WIPHY_PR_ARG, WDEV_PR_ARG)
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


