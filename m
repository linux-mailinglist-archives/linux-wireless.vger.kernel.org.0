Return-Path: <linux-wireless+bounces-35027-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MzIImTt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35027-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F154428AE2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2241C300C32D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170AF38B7D4;
	Mon, 20 Apr 2026 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrOuH8s9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMfcb64k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3B38F240
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676187; cv=none; b=GegnpcWdaiATeOk3kx8Q+BXKCuVZhBM6ew2vAG1H+0CR1VVf2iMH5sW1S8tIImicNEiBUsTH8/szYvnwwJpL2lR4u14RQ9PA5YEW5T0EYTlWwa+ZdUmKc649ZxmLvGPy5YaikBh0Z8Lys4bvhdE3TP+EV2ztHN6HXrOlMD6U+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676187; c=relaxed/simple;
	bh=DLHRjVYqaS2ECq04xQxieY0YP6MHJGU+d7rG9+GPD6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=queh6pctG2Nni04UFgGwEE5B7Xsn+AEF37copB2RbpGR4clXMKMD3qJsvcpz15gXNeuD8gjR367iclZNFhlgkz7W4zDZN7JU7dKeb8hlu3jUZ05dviXG13GzR0EbOeYUVUey3/R/CtnNYXF3c+Kmz8dmQSpTcl6pdCvFZIJXRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrOuH8s9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gMfcb64k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K8pRUM1977967
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Vc09laNS0Jd
	MFIxpeDO8Al+BZHREBJJOlDf5fuqOgmY=; b=PrOuH8s9OZ30P161sqZSRge2Rit
	RQUG8gNh5cK20wo7AZ/RFDI+6p+omMtNa56DitW8w1bI6SDpzcEaiZ22MsG5YOLL
	ZLLcoPcBooiAf6yruQH6bsnQr/hfkzuqqaNHzL8OnH7ItvxlBlQsEn+IpKb/Fk3W
	zlzXRzCk3Sx42k3+rdY6Qaxcpk+viRn87TUUTENdmDrEN7OerfhS2HTOTAzZ5RRz
	NBZSigd5HNVGUWQyhSVIh5ygRA9XWsb9yAIoFjbszLgG/0STJw6lpKEtpYdEM+Mu
	hdnZnOsxRwDv0SvtTGrUQWHRQ8DbUR3FbgCXwa4qu6lBacNjqMN9QFkhWdA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm388n762-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fc22424d9so5355639a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676182; x=1777280982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc09laNS0JdMFIxpeDO8Al+BZHREBJJOlDf5fuqOgmY=;
        b=gMfcb64klbbIjbPKTDcCTNqZfra+NBSj9E7hT6P+P9DM2jmgH+NWA4Oytcar1xVug7
         W2p3veDOrGW/ILfh3DeKJIn1JVZRFM8ZeV+MxxP463kZdzkO2sYt23Eed+CNP0hs3/zp
         Goqam7zmkWdFPcl7k7gGzPL0smOOOVIcKmxANkNUQKW24hG2YlqwBCZrmdqsuDDGX9uD
         dP8cthtCn3E9JVUF4QNBk9oLXwYUF7ZWIhXkVfr1bEBl6jUcbbrqOGMIojBS+OWY23ep
         TPZO+tbXJD2+5kA8XvNV5SB5sajGJvlQFSoNMY1KuvlbYqzP0JJeeDPE5aidGTo4b299
         NhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676182; x=1777280982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vc09laNS0JdMFIxpeDO8Al+BZHREBJJOlDf5fuqOgmY=;
        b=HE9fvnhmZOQ5l6cuRXqk1MqbWL2vEihzEftegQjmfdB3q6TAPNL+i57s7yTTnQWrqG
         Q3CAHjPiPuQhoCWcwRzhbua3QdYLti1Sqc0x4FDhkWLJd3zts6Ot4ikFbGCSI1ymd6on
         xhYWr9VjxG0Lyq7NR+DVqgQKhDyPyuUXZPybNdd6HvKpnftZeopSSS5dlrlLT76ZpdT/
         Zil7ypSBbyWER0PSrZBxmw+Adn/w3FxzLjIcYo0WvKOOE0PR7dqzsPQ0vt9gP5Y6hq4w
         B9fI6DbAID5jzICuu17mVZxMqi2GUtAtG7tJKLs/+X8UmkF2HvtGrmCxNtGFb6+XmHtV
         bLmg==
X-Gm-Message-State: AOJu0Yymix4ujsxslF5tS7+8m0skhKUUAJQAav3q+Rua8pFXrsqQC4gr
	Fr0+fLwHdE8UO37+QViqse1m476HdG3ZZVZDjSYHi2Xo+rAo0RI2xERVfDtaohhixJmDSKWA0Kg
	+g9bpfD9Q8ZbG2NZMTfzLVd4dB65yFkTlQ/Od0q3vioOoRxuqrpzT6wIzILSn3tO6sXTyqn8aXr
	Ye
X-Gm-Gg: AeBDieveYSVuiMqWQCVsttG/Q1nh6bgs8gpZstnU0ubS4A1wMkjc+uDbKcMyVMKk7/n
	EbDfmBaZUZLdr2bLnJTCnh6pZmlAczvRrbNdRPXPI1PE5xYnLu9NnXhlMVsma2dilwxrmgp6wFJ
	lYlJiUkwHzZe3AuqNV29pp0YTHodDc3t4T7jOyp4QLnEz6L3tOgnUbbI8YcnjDMEIv+hKZPepTv
	qVZEREGUCR07arKytJna1biD4oqoezYq0ThtqwR3ytlDowAMwTzp+oqIhbB7q1sjlrk9YyE5m1W
	EAarDO77UZtgaqiCyzhgJFsqAczW+n7qNiQ2Ho501ie4c9ctDKF/6XDfIb7BC5m4v7EXJBDAQXi
	XlBy17rgjaEM/PbNLoJGKzzr9zjoOO/QXO2Re8yyVgFlc/oLaswza3BHsCqSSth14cg==
X-Received: by 2002:a17:90b:562b:b0:35b:929f:7e95 with SMTP id 98e67ed59e1d1-361403bdcfcmr13547116a91.4.1776676182200;
        Mon, 20 Apr 2026 02:09:42 -0700 (PDT)
X-Received: by 2002:a17:90b:562b:b0:35b:929f:7e95 with SMTP id 98e67ed59e1d1-361403bdcfcmr13547081a91.4.1776676181688;
        Mon, 20 Apr 2026 02:09:41 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:41 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 04/13] wifi: cfg80211: add start/stop proximity detection commands
Date: Mon, 20 Apr 2026 14:38:47 +0530
Message-Id: <20260420090856.2152905-5-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GthyPE1C c=1 sm=1 tr=0 ts=69e5ed56 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=7Ubf0ANF9fMZ6H_vmasA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: yriHl5dPtR7AEIciajr-RZjW8zeGqfh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfX2TBlgkN7rufz
 8oOv+hQ+u74zF4QagP7nA6YEzj/yoUwTef90/EIypJKC71qsB3q7ygjMf9GQqtj8gtV+f6ahH29
 R3YzDmmam6xGf5p/yHk6C2JfMRTpdRriKOBGIK7RAoV0ffwe5CFzTDgdS8EbMvGqUiKSMyYHkl8
 4XWJ7C1G8wVSXFeJE3hQ9brWsSEndTM68xPAc0Fi2K+Yr3A5REhMlBY/76onnhhusG7AN2UJ/oQ
 lCiRQ7bvw5OkkTGkLc3wvVnJJrhhmFnY8gPx7LJO4EvTOvs1IjGidylMEpScIjN7rUcaAGIms4b
 9JrlXMFCkC+UVFCWAMZW9kZmUtCtbhCiTJl1FbR2EgPjofQEPYqTjBFeSPnWr79pfzL5FBYfzDH
 bq/Cc6BcrK+h3Kb6upeumIJgejdduTt4eixd1AkO/alg6RkxYsoVRoz/H8iPiuAsK0ylYgUHRz0
 vhKvpG0rdUp6tbzvkWA==
X-Proofpoint-ORIG-GUID: yriHl5dPtR7AEIciajr-RZjW8zeGqfh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35027-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F154428AE2
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
 net/wireless/core.c          | 35 ++++++++++++++++++++++-
 net/wireless/core.h          |  2 ++
 net/wireless/nl80211.c       | 54 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 19 +++++++++++++
 net/wireless/trace.h         | 10 +++++++
 7 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 25847230428e..0ab0a99fa824 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5085,6 +5085,9 @@ struct mgmt_frame_regs {
  *	links by calling cfg80211_mlo_reconf_add_done(). When calling
  *	cfg80211_mlo_reconf_add_done() the bss pointer must be given for each
  *	link for which MLO reconfiguration 'add' operation was requested.
+ *
+ * @start_pd: Start the PD interface.
+ * @stop_pd: Stop the PD interface.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -5461,6 +5464,8 @@ struct cfg80211_ops {
 				   struct cfg80211_ml_reconf_req *req);
 	int	(*set_epcs)(struct wiphy *wiphy, struct net_device *dev,
 			    bool val);
+	int	(*start_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
+	void	(*stop_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7fb77091f863..53d22194e75d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1417,6 +1417,12 @@
  *	identifying the evacuated channel.
  *	User space may reconfigure the local schedule in response to this
  *	notification.
+ * @NL80211_CMD_START_PD: Start PD operation, identified by its
+ *	%NL80211_ATTR_WDEV interface. This interface must have been previously
+ *	created with %NL80211_CMD_NEW_INTERFACE.
+ * @NL80211_CMD_STOP_PD: Stop the PD operation, identified by
+ *	its %NL80211_ATTR_WDEV interface.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1692,6 +1698,9 @@ enum nl80211_commands {
 
 	NL80211_CMD_NAN_CHANNEL_EVAC,
 
+	NL80211_CMD_START_PD,
+	NL80211_CMD_STOP_PD,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/core.c b/net/wireless/core.c
index be2785812811..55ad4d0bcc73 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -322,6 +322,28 @@ int cfg80211_nan_set_local_schedule(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+void cfg80211_stop_pd(struct cfg80211_registered_device *rdev,
+		      struct wireless_dev *wdev)
+{
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_PD))
+		return;
+
+	if (!rdev->ops->stop_pd)
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
@@ -351,6 +373,9 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 		case NL80211_IFTYPE_NAN:
 			cfg80211_stop_nan(rdev, wdev);
 			break;
+		case NL80211_IFTYPE_PD:
+			cfg80211_stop_pd(rdev, wdev);
+			break;
 		default:
 			break;
 		}
@@ -828,6 +853,9 @@ int wiphy_register(struct wiphy *wiphy)
 		    (!rdev->ops->tdls_channel_switch ||
 		     !rdev->ops->tdls_cancel_channel_switch)))
 		return -EINVAL;
+	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_PD)) &&
+		    (!rdev->ops->start_pd || !rdev->ops->stop_pd)))
+		return -EINVAL;
 
 	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_NAN)) &&
 		    (!rdev->ops->start_nan || !rdev->ops->stop_nan ||
@@ -1387,6 +1415,9 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	case NL80211_IFTYPE_NAN:
 		cfg80211_stop_nan(rdev, wdev);
 		break;
+	case NL80211_IFTYPE_PD:
+		cfg80211_stop_pd(rdev, wdev);
+		break;
 	default:
 		break;
 	}
@@ -1495,10 +1526,12 @@ void cfg80211_leave_locked(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_NAN:
 		cfg80211_stop_nan(rdev, wdev);
 		break;
+	case NL80211_IFTYPE_PD:
+		cfg80211_stop_pd(rdev, wdev);
+		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_NAN_DATA:
-	case NL80211_IFTYPE_PD:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/core.h b/net/wireless/core.h
index ae2d56d3ad90..cbea34005330 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -556,6 +556,8 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
+void cfg80211_stop_pd(struct cfg80211_registered_device *rdev,
+		      struct wireless_dev *wdev);
 
 int cfg80211_nan_set_local_schedule(struct cfg80211_registered_device *rdev,
 				    struct wireless_dev *wdev,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4b387bf1fe7a..e40b1898ab02 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16571,6 +16571,46 @@ static int nl80211_nan_change_config(struct sk_buff *skb,
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
@@ -19733,6 +19773,20 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
index d97d5c08d135..63c26e8b1139 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1093,6 +1093,25 @@ rdev_nan_set_peer_sched(struct cfg80211_registered_device *rdev,
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
index 938fea1fe9d8..a68d356fe127 100644
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


