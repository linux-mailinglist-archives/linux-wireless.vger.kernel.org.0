Return-Path: <linux-wireless+bounces-29376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ECCC8DB2F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 11:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42B6734FFC4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813D31A571;
	Thu, 27 Nov 2025 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVJzBWLo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6uTnKDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67B3233F4
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238298; cv=none; b=uW3nWOfZmJqdVLaJmwxbqW2LKJGegZGkpwHDhYtw1w3HIBJri5PVxGzjXc2Kk+oTmueSLOtd6bs9JpD+CzoO48JS7VL/aWhmQvTxSMKSnKRIk9bPIcja0OUcJdWBHqSEpBgkgQac6kHWusRgRrPI3zNteEJ2aHYQtXM1s3IEXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238298; c=relaxed/simple;
	bh=4baTh4sI45I5tOmArx9dZKamD35WdDYX6xnmPr9Re0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ia+0HxwH+SO+II4pWzhdtRCgeDMV0yBvRqas65dQnBypXc4Ksyd01WlZ6u2X/w0UQcq0sgGSY4g8zgr650tH8Li7tbcWOJqzGlnKlLpgiZr/eHhcXCpkZt8TaSWD8yvEwzL7/5RDq3sakaqgsErQjz+dbXXrg5Qta7UjVofs84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVJzBWLo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C6uTnKDx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR85efY2388017
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bI7c6TTLnLdqTlyH/nRvgrHgKUSe4UFXfmIBPkCemKU=; b=SVJzBWLoqgSMp8Et
	AX9pb9BrFfLEdk+84F/LbGRE9Fg/zbdOAx23WpMtw6pIog3/bS9OQYWwlhiuzgfs
	B/M/nGhxmC+1Vbp+xVj9u4fIna7WY5XkJRm8c9/ionjjDJ2wK/UypJ9l4BBHmJ07
	lxiwMaustOUj0pzl8xxRaYL/MB6GbgcHTiF2yM4UwROqYxNmzVxk/qMxSqiRbDWc
	lM0ysLqmD360h8PkTctARXEMD+0gtyOIAcSNOF3ojXRJYWelFFlsvWJho0N3qu0e
	5qOFQnmkHdWWSypEGquEMWtjXZMW4nokEBTLercUwAh5Lfv0wWwHnBOzj1Fiegxk
	4lA37w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap7n8j1xp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 10:11:36 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956a694b47so10408875ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 02:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764238295; x=1764843095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI7c6TTLnLdqTlyH/nRvgrHgKUSe4UFXfmIBPkCemKU=;
        b=C6uTnKDxHLe4MydSjXMC0FG1Y27bWn0pXuUEmyuuyMZRUCjwj//msXkwtZpmHCKVaJ
         g36tfriRN/DQEyiXqcCAPzVPsNYSY6exBriz+wwls94+JPG5H7iZJg55KETIhU0ve461
         dIh1SgiJyRm1VBPCQS9V2G9YLJeMh78i0uA3ycT9AO9SU0eJB4I0BeYfs/O46KsrvGoE
         ferlPvg45NEb2YjDhbgIMFtmG7KL8SCPmB0aHeulC+eiapHb3+lVIfS2RefZuEm55FNC
         ecq12E4nEILPxqS5WizPqQRTbYIJ5+Lru9IUq5yfRfCTwOgxicV23uo5licL8gXNSjtB
         K60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764238295; x=1764843095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bI7c6TTLnLdqTlyH/nRvgrHgKUSe4UFXfmIBPkCemKU=;
        b=Fa7LcMef+ZD8a1UpWGGUTrNSD6lyk3PwSueP4XEUF4+qc0ceA1EEg/Qp7XiKHz3Vys
         NHxrt9+5/GxiYW1H2YefpCIhLJ49dAv4wNVjRoqtwmMox2Q/KNzFwzmVkVXCXsgi0dWi
         ErSyzC47Z+6AAyvwBZFAIV9rf3EciBlmGMtcRBlb3Kzeu4hpMWau/qGbDA8lvmbcok/W
         up2D7SFtLJjhOhhkh4snOVx2O8P6EG6YFlCr/mRfceenVCD786TmqjYJikXf3KF5Xy0A
         FuAY0idi6t/bV6ffLO6THoGoHUQ6N1Bp+oXFRbP83xK8ymRdPkBbN+tWVFGw6J4S6ukj
         657Q==
X-Gm-Message-State: AOJu0Yx7JvfN4Xf/WwteL4gRCGX9REAud1VPzEX5mOqMib/3s3qUPOlx
	jUQGB/dhpYIvPucnSDUvEpDY5VklN3CjjBrhpHlPJWsJMY9u9wX5osJSUfVMnWFoqRjGd6t235D
	ybzu4IcGrgHMF0djIGATeUI2MOLoFENPVxjpCgS/JLJ5/h0qryYfLqOc95A06yIyVMD36HtjSfO
	yxvA==
X-Gm-Gg: ASbGnctGCtGR+aOerxU4egQLVTXyzHnrgMMOmRQM5pSSaEe/EIfy6l/xRVaUFncEI79
	Hs7YTdGCACmqpPglbfxWHlkYUXfos7Jzf5z503q0/G+kzVbmDo2hv9m+zQGJ+pBeX2kJ50LxBM1
	npcPNYAAKvsHjXWD37eDDJgSBBEiNqf89GZZZCR/JPxUXhVKrA6G/N1+ViOouRVIdqzgcAABQvL
	UYKJvldKMd1f4muy3Om+tmpxElRas6t4TYctZMNf3hFUcQb5ZArRs6BNGrKN+YXBvxhAENLPJ8o
	cZHfmD87ibB8CCOvvYguvrKWJWD2SpL9syg1E2JeLZkwnSNdqTxsIBvQ76DcAolP5sh1SqUXshE
	yhyd12Kj92Shnp3yo7TBgDSIhjs+sXr4T90r2vSibTivZ4Bymo33fR5QChMFRYqJSqg2kgpuWzV
	1A5YR6GnLlKvfcJ2pPPag6mSssk/8tqj+qqliV6eU1cw==
X-Received: by 2002:a17:903:228a:b0:295:24d7:3792 with SMTP id d9443c01a7336-29baae4ed57mr118062955ad.1.1764238294973;
        Thu, 27 Nov 2025 02:11:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYeSJe4jXjGAeRTFKVxVjjIkBQSVvWoqwGgB2LN2EVCBZdLvHc8BdDG9mwmLp1zVqh4ZzM9w==
X-Received: by 2002:a17:903:228a:b0:295:24d7:3792 with SMTP id d9443c01a7336-29baae4ed57mr118062695ad.1.1764238294375;
        Thu, 27 Nov 2025 02:11:34 -0800 (PST)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce44389bsm13586425ad.32.2025.11.27.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:11:33 -0800 (PST)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 15:41:23 +0530
Subject: [PATCH wireless-next v2 1/2] wifi: cfg80211: add
 cfg80211_stop_link() for per-link teardown
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-stop_link-v2-1-43745846c5fd@qti.qualcomm.com>
References: <20251127-stop_link-v2-0-43745846c5fd@qti.qualcomm.com>
In-Reply-To: <20251127-stop_link-v2-0-43745846c5fd@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: K5SDfu_KIKEIztySysgCJp0SbCl4DlnM
X-Authority-Analysis: v=2.4 cv=AufjHe9P c=1 sm=1 tr=0 ts=692823d8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=a7rJxSUrcnTCAqgMT3UA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: K5SDfu_KIKEIztySysgCJp0SbCl4DlnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NCBTYWx0ZWRfX3gknUC5ZQ7L9
 gHCi8YKrx81NebDCWs5mcap81WlZdqT4Sj4JaHG11KOxOA7w3Z+RJx3P7nSwNl7wuXGqE/yT0eF
 EIbvCIua3aB/3ugAqDwlYQFv8rHiM6/KDODEyMY6OPrjqzP26JP2Mlv5Mgt68DEGkw/L6FiMA0h
 nTIP78bKrqs4mlVscTYOYuFjhRGfE7NtYikRRJi4RQ8vhfxkygbd2Az6zqqzGfs3lmZcy50Lrty
 9TxzrBsaMVG670MyKV45vCxKTSCHgsIyozz67ZpuYTYm6hZKLboF1zpRes3X54cgSJnCLWL23A2
 rEvxzFkwiQ31GbTY+HPk73R6UYrXu/0kZDzV5MbcLLTpbLWIxKKi6VJ53GiE+Dmx0KwXndJNMSo
 byChjknhgTaxysflKdx2YByl3ktZQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270074

Currently, whenever cfg80211_stop_iface() is called, the entire iface
is stopped. However, there could be a need in AP/P2P_GO mode, where
one would like to stop a single link in MLO operation instead of the
whole MLD interface.

Hence, introduce cfg80211_stop_link() to allow drivers to tear down
only a specified AP/P2P_GO link during MLO operation. Passing -1
preserves the existing behavior of stopping the whole interface. Make
cfg80211_stop_iface() call this function by passing -1 to keep the
default behavior the same, that is, to stop all links and use
cfg80211_stop_link() with the desired link_id for AP/P2P_GO mode, to
stop only that link.

This brings no behavioral change for single-link/non-MLO interfaces,
and enables drivers to stop an AP/P2P_GO link without disrupting other
links on the same interface.

Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
---
 include/net/cfg80211.h | 16 ++++++++++++++++
 net/wireless/core.c    | 30 +++++++++++++++++++++++-------
 net/wireless/core.h    |  4 +++-
 net/wireless/reg.c     |  2 +-
 net/wireless/sysfs.c   |  2 +-
 net/wireless/trace.h   | 13 ++++++++-----
 net/wireless/util.c    |  5 +++--
 7 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..01ce5aa85ebf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10376,4 +10376,20 @@ cfg80211_s1g_get_primary_sibling(struct wiphy *wiphy,
 	return ieee80211_get_channel_khz(wiphy, sibling_1mhz_khz);
 }
 
+/**
+ * cfg80211_stop_link - stop AP/P2P_GO link if link_id is non-negative or stops
+ *                      all links on the interface.
+ *
+ * @wiphy: the wiphy
+ * @wdev: wireless device
+ * @link_id: valid link ID in case of MLO AP/P2P_GO Operation or else -1
+ * @gfp: context flags
+ *
+ * If link_id is set during MLO operation, stops only the specified AP/P2P_GO
+ * link and if link_id is set to -1 or last link is stopped, the entire
+ * interface is stopped as if AP was stopped, IBSS/mesh left, STA disconnected.
+ */
+void cfg80211_stop_link(struct wiphy *wiphy, struct wireless_dev *wdev,
+			int link_id, gfp_t gfp);
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9a420d627d3c..1fac73a76197 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -347,7 +347,7 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 
 			guard(wiphy)(&rdev->wiphy);
 
-			cfg80211_leave(rdev, wdev);
+			cfg80211_leave(rdev, wdev, -1);
 			cfg80211_remove_virtual_intf(rdev, wdev);
 		}
 	}
@@ -1371,7 +1371,8 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 }
 
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
-		    struct wireless_dev *wdev)
+		    struct wireless_dev *wdev,
+		    int link_id)
 {
 	struct net_device *dev = wdev->netdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
@@ -1409,7 +1410,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		cfg80211_stop_ap(rdev, dev, -1, true);
+		cfg80211_stop_ap(rdev, dev, link_id, true);
 		break;
 	case NL80211_IFTYPE_OCB:
 		cfg80211_leave_ocb(rdev, dev);
@@ -1430,26 +1431,41 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 	}
 }
 
-void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
-			 gfp_t gfp)
+void cfg80211_stop_link(struct wiphy *wiphy, struct wireless_dev *wdev,
+			int link_id, gfp_t gfp)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct cfg80211_event *ev;
 	unsigned long flags;
 
-	trace_cfg80211_stop_iface(wiphy, wdev);
+	/* Only AP/GO interfaces may have a specific link_id */
+	if (WARN_ON_ONCE(link_id != -1 &&
+			 wdev->iftype != NL80211_IFTYPE_AP &&
+			 wdev->iftype != NL80211_IFTYPE_P2P_GO))
+		link_id = -1;
+
+	trace_cfg80211_stop_link(wiphy, wdev, link_id);
 
 	ev = kzalloc(sizeof(*ev), gfp);
 	if (!ev)
 		return;
 
 	ev->type = EVENT_STOPPED;
+	ev->link_id = link_id;
 
 	spin_lock_irqsave(&wdev->event_lock, flags);
 	list_add_tail(&ev->list, &wdev->event_list);
 	spin_unlock_irqrestore(&wdev->event_lock, flags);
 	queue_work(cfg80211_wq, &rdev->event_work);
 }
+EXPORT_SYMBOL(cfg80211_stop_link);
+
+void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
+			 gfp_t gfp)
+{
+	/* Backward-compatible wrapper: stop all/default link */
+	cfg80211_stop_link(wiphy, wdev, -1, gfp);
+}
 EXPORT_SYMBOL(cfg80211_stop_iface);
 
 void cfg80211_init_wdev(struct wireless_dev *wdev)
@@ -1589,7 +1605,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		break;
 	case NETDEV_GOING_DOWN:
 		scoped_guard(wiphy, &rdev->wiphy) {
-			cfg80211_leave(rdev, wdev);
+			cfg80211_leave(rdev, wdev, -1);
 			cfg80211_remove_links(wdev);
 		}
 		/* since we just did cfg80211_leave() nothing to do there */
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 63dcf315dba7..6ac57b7b2615 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -289,6 +289,7 @@ struct cfg80211_event {
 			u8 td_bitmap_len;
 		} pa;
 	};
+	int link_id;
 };
 
 struct cfg80211_cached_keys {
@@ -537,7 +538,8 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num);
 
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
-		    struct wireless_dev *wdev);
+		    struct wireless_dev *wdev,
+		    int link_id);
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 73cab51f6379..a8ab0ab22d90 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2442,7 +2442,7 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		if (!reg_wdev_chan_valid(wiphy, wdev))
-			cfg80211_leave(rdev, wdev);
+			cfg80211_leave(rdev, wdev, -1);
 }
 
 static void reg_check_chans_work(struct work_struct *work)
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 8d142856e385..2e0ea69b9604 100644
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
index 2b71f1d867a0..643ccf4f0227 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3915,19 +3915,22 @@ TRACE_EVENT(cfg80211_ft_event,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->target_ap)
 );
 
-TRACE_EVENT(cfg80211_stop_iface,
-	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
-	TP_ARGS(wiphy, wdev),
+TRACE_EVENT(cfg80211_stop_link,
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
index 27e8a2f52f04..cc55b759694e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1144,7 +1144,8 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 					       ev->ij.channel);
 			break;
 		case EVENT_STOPPED:
-			cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
+			cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev,
+				       ev->link_id);
 			break;
 		case EVENT_PORT_AUTHORIZED:
 			__cfg80211_port_authorized(wdev, ev->pa.peer_addr,
@@ -1203,7 +1204,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		dev->ieee80211_ptr->use_4addr = false;
 		rdev_set_qos_map(rdev, dev, NULL);
 
-		cfg80211_leave(rdev, dev->ieee80211_ptr);
+		cfg80211_leave(rdev, dev->ieee80211_ptr, -1);
 
 		cfg80211_process_rdev_events(rdev);
 		cfg80211_mlme_purge_registrations(dev->ieee80211_ptr);

-- 
2.34.1


