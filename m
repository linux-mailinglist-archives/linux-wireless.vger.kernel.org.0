Return-Path: <linux-wireless+bounces-27555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26546B8F03D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509BE1881E4D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B4221FCC;
	Mon, 22 Sep 2025 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pxyo7F0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF41221D92
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518689; cv=none; b=sjA2Rz3OLOpqwaciz+Jifrpb7JuK/aIp79ja9ov4Ywf8fioOoxIsWm0FnFjMG5As8sli42DBwzFlumVa4oPT6oOAx6iQf+DdF/6e85amvlMFb5emfkVHe3qYlVchCHmbXchFcwh74VCzWD5Ye1TkcltSRKtBemxH19XCT39t84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518689; c=relaxed/simple;
	bh=MOLL/mEuMAPhYKIXM/YxhXmRrA7ZvbsWJfv/G4MyrIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVAc4IzU90aF+gQCX3zxxtLZ8IpqjSpOMCHWdw9M12XPdkA6UCk+l6SWoqFHAP3ko9mMbfA4D2TRGxEjJzjIvGk4Zdi/Q7Jnzouejv66BxOF82pVSoKc9H5g9pQWFWC2zUvhHG9PVbkMauzZYEWMvr5E7HJWK6+96fvrMEC/wlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pxyo7F0f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LNok8O027068
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YDwgNTwsiguKdLmdSgRWMnSVzlRydHHe3eF2+MYBItE=; b=pxyo7F0fFq5IVvXU
	0QXvGWkQBNXu3ZhKyHWblh8IZtR0b/A6PrXcSGs7PGXtZ/Nw7X+Q0j7veBtYVsfE
	R+OT2ViTIxjGgIZlkOJj+qeqZvMhjp+QzBqXFSJ9E2X/frKrheOmfwUjG1SoL1Ut
	45svIe9x6+k9awI//mj1UpWWxE1Mez4G+pgZXzp/uzdQxHYDMk1CAuLSaEFFl5h1
	MGjHo40HV5CbTMcHsVT9bvRj+aV136wP6yXU7E3NZEVi3pF2iZC+9V2XFHUmhHQq
	CrgXtWjXb8jpnw/1f4rL5Wf1P9eQ+je7al8Pi2t3LDVQb26oXSMMnx6wPOeHxR9D
	aUudGg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mbv3dgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:24:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e60221fso7180800b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 22:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758518685; x=1759123485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDwgNTwsiguKdLmdSgRWMnSVzlRydHHe3eF2+MYBItE=;
        b=v7xf1HR38/KqO9xKmmeAfQXl0rdhJxMZx7NgIeQf8U+Op2sHtvW35UQsGzOXNvnjE4
         xxZgRUEUNRCP0lQ/C4GhVd+n9g6DBWHLCtsgo610O2yEd6NqHw0xFrZw5ZDe8tYjD6Ej
         Iw0HKzTpcUlgPe5EtzuKlROVgKijzUo6UYa7qiyx7cetosLxruwI2tjV6DBX5IPm3CDp
         V8yQF8/6R3d5I3d8wNgdRtsGgczbx4HRzHO596N5ridai+pHxROUrZTXqfnyJjFjVvD/
         rxfurnPec+nOo0QQApPBOYRDpzAUjtMX9z48nsE6n5K37dSoVqXYaieWkxmDEPMXxMqa
         mVWg==
X-Forwarded-Encrypted: i=1; AJvYcCWyOUGkcR3DMTPjC24D+dzDdLMGAJmLeosfOqKUvsuHcti7W+K/mLYhuyjA1FNtzyM4fNRpT9LKNBUB8UE/Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq89ymhP5M3BOhnzY6rlJNzad3GjSOIIXhgusApUsImT8CYGau
	8nvEWkzNf6hmPsPR9naOpkSso51L/EG5ARWyN5tBS5/EQIf4djdhjlJjc1+xmyWIPi4Hp3CYVoq
	mt+E+DOvpfRt1iJ0UTk3jP7UXX4Rw9QEOdjFhX83mMIAAIhAR6bLFiUMpLUgr2X14vcpjMA==
X-Gm-Gg: ASbGnct0Mx4cJrN0OjmyMu05kJFy7MuSSgEfmb1oPBwA7xdHFMtPY5xAuVRt999vcOJ
	bUEO5V/hAvd24Go8kTWGJGnVoBxYpzeG1aeW27y/V2i/e3mkp3dKdcvPgyjQpjq4NZTFgaanyUT
	kJMU5Of6DhnLXCRFl3aoo7SDZo/9FJOvvenvnKDQpPik46gaUbi2d2weaXuZhDtgUaqVZY+QCXe
	DyivvzjqVIq54owz1ALam+LyFskUkSgLi+72vRXnvUqA+UZf8mEy8btHJcxt7QNm3tYMs0DQsQ5
	SpKk80RU4Wd9ggIvfp6C3g3S9n+NFrC86B/iz4TkyL5D+4YzOjpws5GtdMvaV2SUhMyqhdoXlIf
	/8zYJi0b9dnNWhK81NUnJD153UONhj38YNlRvM3uKX09fPdiEq9k8osAZayO0XmHVbDClCgQl
X-Received: by 2002:a05:6a00:2e94:b0:77f:156d:f5a0 with SMTP id d2e1a72fcca58-77f156df789mr10209935b3a.31.1758518684798;
        Sun, 21 Sep 2025 22:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQBmoXjFr1dgeMFak0+t0aY42sRAs0NZCuUtNqliMPuLWBrYG+63LI0vxjOuHgjOJq17AeTg==
X-Received: by 2002:a05:6a00:2e94:b0:77f:156d:f5a0 with SMTP id d2e1a72fcca58-77f156df789mr10209883b3a.31.1758518683753;
        Sun, 21 Sep 2025 22:24:43 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1815af13sm5938567b3a.0.2025.09.21.22.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 22:24:43 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 10:54:24 +0530
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: extend link support for
 stop iface handler
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-stop_iface-split-v1-1-087403cea9f7@qti.qualcomm.com>
References: <20250922-stop_iface-split-v1-0-087403cea9f7@qti.qualcomm.com>
In-Reply-To: <20250922-stop_iface-split-v1-0-087403cea9f7@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org
X-Mailer: b4 0.15-dev-1b0d6
X-Authority-Analysis: v=2.4 cv=ZcAdNtVA c=1 sm=1 tr=0 ts=68d0dd9e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VRYvVURalBwauZ_nZSEA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 7F_e8TrSDDjtI9RyOU3q_hPEIkPO_XYS
X-Proofpoint-GUID: 7F_e8TrSDDjtI9RyOU3q_hPEIkPO_XYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMSBTYWx0ZWRfXxtxIjSLezV8j
 l21OHOq9BBmYlg/TFQS4Y2YBoP+ZCmplN298E98wBDZYo7v+SImnRA0/ELMRZ+EQvSkoxPDSDTv
 G8j61fFeCaxpcv2Lae4Uh34kkTdTScIW+p/uaHPOSYDFRAa0QNItFI9XZUovQyTsVHXlIBGeU9G
 VzP/kfuWe7uVfnr5xh/9RQnH/cMnYiCfnDvDR5F62Fx+I7Om6zyxXXc/NXKc7boJGXtDP81lsTs
 M0sJNcxuIYsBwxTPGdSf2N6Vxe0Y25UAvPbSwnKpaCLSMjaXTlkIGwOE9q+SNb2iDyQnLP63EnM
 8aYv6ZzjExjm4tcLJFBBJ3cyV0X6AY75+9DnpLWY0G8dp8hnP1zHg8pDuu1KRTygkGlN08QGK/a
 Bvvj+Jm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200031

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Currently whenever stop iface is called, the complete iface is getting
stopped. However, there could be a need for AP/P2P_GO type, where one
would like to stop a link alone instead of the whole interface.

Hence, extend stop iface infra to handle the event on the passed link id
and stop that link alone instead of the whole iface.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  2 +-
 include/net/cfg80211.h                             |  6 +++++-
 net/mac80211/cfg.c                                 |  2 +-
 net/mac80211/chan.c                                |  2 +-
 net/mac80211/iface.c                               |  5 +++--
 net/wireless/core.c                                | 22 ++++++++++++++++------
 net/wireless/core.h                                |  3 ++-
 net/wireless/reg.c                                 |  2 +-
 net/wireless/sysfs.c                               |  2 +-
 net/wireless/trace.h                               | 11 +++++++----
 net/wireless/util.c                                |  3 ++-
 11 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index a395829ebadf0964b13bc3c6c5bf16c501ce19ee..008844218a9d7d46d4f778509afa11b2cc7ec67f 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1606,7 +1606,7 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	    wdev->iftype == NL80211_IFTYPE_P2P_GO)
 		wilc_wfi_deinit_mon_interface(wl, true);
 	vif = netdev_priv(wdev->netdev);
-	cfg80211_stop_iface(wiphy, wdev, GFP_KERNEL);
+	cfg80211_stop_iface(wiphy, wdev, -1, GFP_KERNEL);
 	cfg80211_unregister_netdevice(vif->ndev);
 	vif->monitor_flag = 0;
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc89df4df30e6e623403b4d9ceb6cbd..41bf31687dfdd1419850050f69acd12c2c9bff45 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9559,15 +9559,19 @@ int cfg80211_get_radio_idx_by_chan(struct wiphy *wiphy,
  *
  * @wiphy: the wiphy
  * @wdev: wireless device
+ * @link_id: valid link ID in case of MLO AP/P2P_GO Operation or else -1
  * @gfp: context flags
  *
  * Trigger interface to be stopped as if AP was stopped, IBSS/mesh left, STA
  * disconnected.
+ * In case of AP/P2P_GO types, if link_id is passed, it would only stop that
+ * link on the iface alone. If need to stop the whole iface, -1 should be
+ * passed.
  *
  * Note: This doesn't need any locks and is asynchronous.
  */
 void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
-			 gfp_t gfp);
+			 int link_id, gfp_t gfp);
 
 /**
  * cfg80211_shutdown_all_interfaces - shut down all interfaces for a wiphy
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2ed07fa121ab73d3afd2f841eb53e6cdc0be91a3..9c951c1a2d6b00bc204d6f4097e9b1fe43c039f8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4036,7 +4036,7 @@ static void ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 		sdata_info(sdata, "failed to finalize CSA on link %d, disconnecting\n",
 			   link_data->link_id);
 		cfg80211_stop_iface(sdata->local->hw.wiphy, &sdata->wdev,
-				    GFP_KERNEL);
+				    -1, GFP_KERNEL);
 	}
 }
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c9cea0e7ac169839f883f73186b575eacfe55db5..38d02fa26198c49009404bf36548ce78a7a9032b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1820,7 +1820,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 				ieee80211_link_unreserve_chanctx(link);
 				cfg80211_stop_iface(local->hw.wiphy,
 						    &link->sdata->wdev,
-						    GFP_KERNEL);
+						    -1, GFP_KERNEL);
 			}
 		}
 	}
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 07ba68f7cd817df2085eb6dd1dbdb554be117f56..073b581971f0eabaaf8cce510e90aecd93eedbb2 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -778,13 +778,14 @@ void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
 			 * removal can be supported.
 			 */
 			cfg80211_stop_iface(link_sdata->wdev.wiphy, &link_sdata->wdev,
-					    GFP_KERNEL);
+					    -1, GFP_KERNEL);
 		}
 
 		/* If we are not tx sdata, remove links of tx sdata and proceed */
 		if (sdata != tx_sdata && ieee80211_sdata_running(tx_sdata))
 			cfg80211_stop_iface(tx_sdata->wdev.wiphy,
-					    &tx_sdata->wdev, GFP_KERNEL);
+					    &tx_sdata->wdev, -1,
+					    GFP_KERNEL);
 	}
 }
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index a7e2931ffb2ef5fb3b14dee39c96d4c6d21a488b..5c4f6e4bb89e46b9573a625aa519028315534507 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -344,7 +344,7 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 
 			guard(wiphy)(&rdev->wiphy);
 
-			cfg80211_leave(rdev, wdev);
+			cfg80211_leave(rdev, wdev, -1);
 			cfg80211_remove_virtual_intf(rdev, wdev);
 		}
 	}
@@ -1347,7 +1347,7 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 }
 
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
-		    struct wireless_dev *wdev)
+		    struct wireless_dev *wdev, int link_id)
 {
 	struct net_device *dev = wdev->netdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
@@ -1384,7 +1384,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		cfg80211_stop_ap(rdev, dev, -1, true);
+		cfg80211_stop_ap(rdev, dev, link_id, true);
 		break;
 	case NL80211_IFTYPE_OCB:
 		cfg80211_leave_ocb(rdev, dev);
@@ -1406,13 +1406,16 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 }
 
 void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
-			 gfp_t gfp)
+			 int link_id, gfp_t gfp)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct cfg80211_event *ev;
 	unsigned long flags;
 
-	trace_cfg80211_stop_iface(wiphy, wdev);
+	trace_cfg80211_stop_iface(wiphy, wdev, link_id);
+
+	if (WARN_ON_ONCE(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
+		return;
 
 	ev = kzalloc(sizeof(*ev), gfp);
 	if (!ev)
@@ -1420,6 +1423,13 @@ void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	ev->type = EVENT_STOPPED;
 
+	/* link_id is expected only for AP/P2P_GO type currently */
+	if (WARN_ON_ONCE((wdev->iftype != NL80211_IFTYPE_AP &&
+			  wdev->iftype != NL80211_IFTYPE_P2P_GO) && link_id >= 0))
+		link_id = -1;
+
+	ev->link_id = link_id;
+
 	spin_lock_irqsave(&wdev->event_lock, flags);
 	list_add_tail(&ev->list, &wdev->event_list);
 	spin_unlock_irqrestore(&wdev->event_lock, flags);
@@ -1564,7 +1574,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		break;
 	case NETDEV_GOING_DOWN:
 		scoped_guard(wiphy, &rdev->wiphy) {
-			cfg80211_leave(rdev, wdev);
+			cfg80211_leave(rdev, wdev, -1);
 			cfg80211_remove_links(wdev);
 		}
 		/* since we just did cfg80211_leave() nothing to do there */
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b6bd7f4d6385a128ba8fb7fc82ca4b2e8dd7d7d8..f4a440bf90cc874d676b7eb1b9a3b184d30a2ded 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -288,6 +288,7 @@ struct cfg80211_event {
 			const u8 *td_bitmap;
 			u8 td_bitmap_len;
 		} pa;
+		int link_id;
 	};
 };
 
@@ -536,7 +537,7 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num);
 
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
-		    struct wireless_dev *wdev);
+		    struct wireless_dev *wdev, int link_id);
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 3b0ac3437f81909b69efaccc3c5db8079736fe39..5f85ac0129713ea1b179c57e9fcaec3a8b4a6467 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2472,7 +2472,7 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		if (!reg_wdev_chan_valid(wiphy, wdev))
-			cfg80211_leave(rdev, wdev);
+			cfg80211_leave(rdev, wdev, -1);
 }
 
 static void reg_check_chans_work(struct work_struct *work)
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 62f26618f674741a5163fa8e8d14c5319b2ceff8..848600bdb9f7527d7fdeb1c54ed42feb65162b12 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -88,7 +88,7 @@ static void cfg80211_leave_all(struct cfg80211_registered_device *rdev)
 	struct wireless_dev *wdev;
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
-		cfg80211_leave(rdev, wdev);
+		cfg80211_leave(rdev, wdev, -1);
 }
 
 static int wiphy_suspend(struct device *dev)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 34c584a215e5d4d2acd00651e7d1a24c4c17eeed..88412dadb77eddf638239cae3782224c4e31cebb 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3951,18 +3951,21 @@ TRACE_EVENT(cfg80211_ft_event,
 );
 
 TRACE_EVENT(cfg80211_stop_iface,
-	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
-	TP_ARGS(wiphy, wdev),
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 int link_id),
+	TP_ARGS(wiphy, wdev, link_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		WDEV_ENTRY
+		__field(int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		WDEV_ASSIGN;
+		__entry->link_id = link_id;
 	),
-	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT,
-		  WIPHY_PR_ARG, WDEV_PR_ARG)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %d",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id)
 );
 
 TRACE_EVENT(cfg80211_pmsr_report,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 240c68baa3d1f71a80a36af854acf4aa7ce75d05..6e7f89480a2e75d99aa4e63d1f3ab4caefcef33b 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1171,7 +1171,8 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 					       ev->ij.channel);
 			break;
 		case EVENT_STOPPED:
-			cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
+			cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev,
+				       ev->link_id);
 			break;
 		case EVENT_PORT_AUTHORIZED:
 			__cfg80211_port_authorized(wdev, ev->pa.peer_addr,

-- 
2.34.1


