Return-Path: <linux-wireless+bounces-33600-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHklHHyLvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33600-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:01:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CBE2DF11B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B63F2302D9E8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075DB313527;
	Fri, 20 Mar 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0W2t+xW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWFmg/IA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC730EF89
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029642; cv=none; b=eLRKuCRyJW6ioLt0Av/v+AIva2KK8izfXamOaUCpGfOXpcqjtOnUyInKawfg3ePRM9urjIkO95chNL+7YrqOuaiP4AqB691Ahh8ZxULycQHQPw+1ufEvsNjD0Ode9jsiOL2pwJgj5KeEmlUvCRyuQzqcuFHMkhCLANpvnMplwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029642; c=relaxed/simple;
	bh=mF/zas6RJlkeixgfFJH9tsUX1pSihPjxB3ojUvibAN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSh0gO9ex956oIa/Kgd2JevCmg1294zgaKG+MBYUI7C9yPYXTavtjDJy28doEpJUslMQajS8MzJUZsMyE62qEdR5k2B79zaAYNN6dxs/JTGZzxvlmDS/JbHawOUeh+ncxC1WHy4jKqtmWuH1MRjVlflis7gh9sGzYPXcSdhn/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G0W2t+xW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cWFmg/IA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KELeoc332560
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kaStYtZBzqw
	5/jIRrWlw+NbNZ74upfsQsgjjum5B4GI=; b=G0W2t+xWgEgRW9R2oKbqZtHIj71
	Mua6ey34hGxwwVaSvP7UuUfkBnU8+XoirtQ35wFXakxfrfL4mhtmD08uG5EctygY
	mxoAsn/xYvMhOs5+kbF3CiWrTGRy49y/CGYbgg2bFjejhnLYLDvi/P46AXwVdgyN
	tpUbN7nMegMLkwArDMAGF01gOVNfkbFaXzV5TgsjTmfP3GRgIPfOjD4K/Li4ds2d
	iSgZiAHwjL/lyvPto7TU2IzJI6x1KcvDxvXpywd3jEip//EqLE6ddBayN4A404ze
	hvCHTvsRIFeXEpwdmF9/hpdBJOYy2sH27DuLxJMMCwmZ07MzzinF56vs14Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0846g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b06395b8deso31241075ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029639; x=1774634439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaStYtZBzqw5/jIRrWlw+NbNZ74upfsQsgjjum5B4GI=;
        b=cWFmg/IAYvAVKMd8w8OtMI58jGE61AUO4u5Nm35Gx/ZR9UXe17zk3ysUQ9IYuiLLvL
         Rr4l19XIcp7zL0tZ9t6FWeWf1NEjDjPOEGojIGtX2c2ZjKDNIvLEYKUtkQcom5lLYuBE
         1vJskchPjdajN3Wnfgi5GM2LcH4N9dNn0jpeoLYdYUy311PO/heDcF4PBSidZi7QFkFl
         IdRbfKU5R9ajgCFZIMRg7Bf0MYxIb0qa1X91g0XNMZ5bGH6NTRINHnrX7D0L11EiKrVA
         jqK1FK8pM48sqQe2AlvzdRDqYQfK8T9qYBl5z4+Wc36qAC64DgAgBELxU1PGaj/ovCWi
         cUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029639; x=1774634439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaStYtZBzqw5/jIRrWlw+NbNZ74upfsQsgjjum5B4GI=;
        b=FecUHu6Jh5CSv8FNtwD1xPwA/3u9YOz1fB7gWUyjfaMIO9B9cU09laO2kehbZZ65RY
         VBCQYwc8wTrKWV41vcZHRYOki9J8eoFJUi/vThZ97X51SmdkeqUPpHftqWEJpNemvDhX
         FCfbFR+HSKepDTzzdLq83ZeDo+7S20/DO0GiPWDm88ZfnU7pMMAg8/j5MH4Z4kWfwmrF
         WQLmm6d9HNpiEnejdnC67ra6/woWPp3/dduACRXVyS7VK75jAWGqmbpPUkOsJI3l6TqS
         xaeWd3GlVCj072/ly6/NnpKTROgNI12/KpSfoBOtvIX+ZLuDuDhYr4C3LLb3LFWaNXXH
         HbqA==
X-Gm-Message-State: AOJu0YxdE2nV6UuRnEWnpCZPHb++9deVaCf0gy9LEBwAOIAoOBzpz2UC
	su2TO2oBwNIoc7iy80vjS0aYTVU7ukVeMNRZLdDN7VFrDQ4CaN2VDC3Jbp8mjDG0s7+Qu3dzrnT
	8TNgLCn++GnQwFC4dYhgd30tYnifr64aUmAeVOIIG8BQZ2TzZXCG9Rf7JyMscHh+0ixEJ
X-Gm-Gg: ATEYQzwiA0kLdjYhqEzv7eqca18H6VglIuoP27DokW/bg7DWNuXiiLMkpS4CIq9pRQr
	qXSBlwKOh4iJ67fa9ELgu+j/ng/iB86plzZrmKmMKz1k2d9eRvYaN/gv21HEX9lrWTUpeLL1Fw0
	aBJiDwiw3RVXnmo++K5J8X4eAJ6hKvScXhIJ+1xIjr+p5/kM99wRxy/JmjqneqNYbtcn3nNIqXV
	aNOfNRN/qcP6wOVbuDU+VQWcPYCf8lOKRjLn/3xOJJicRoCI1oYR9WgoktbgEqv5BLkQ/DBFr2A
	xHhsIb3Zo8ozUdgFYlJZd0Je/CShJ2WMXKfVFea4MNTZhIplIUSfE/2g2GIkHKtKxjMQ4loLwhM
	3huoKSJ8yzBZQpGmYkNUy20LSiTPGQKxdHomGo8Je8UrMj7z+H4RkKwI=
X-Received: by 2002:a17:903:2f84:b0:2ae:a429:fc42 with SMTP id d9443c01a7336-2b08279d62cmr34142345ad.40.1774029639062;
        Fri, 20 Mar 2026 11:00:39 -0700 (PDT)
X-Received: by 2002:a17:903:2f84:b0:2ae:a429:fc42 with SMTP id d9443c01a7336-2b08279d62cmr34141925ad.40.1774029638352;
        Fri, 20 Mar 2026 11:00:38 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:37 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 04/14] wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR operations
Date: Fri, 20 Mar 2026 23:29:28 +0530
Message-Id: <20260320175938.2547288-5-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=MYhhep/f c=1 sm=1 tr=0 ts=69bd8b48 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=TxMjh0AVY9LfnFWMPO8A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: FbX6IIJqo313pGFLIdScDS5cAYdtuYj1
X-Proofpoint-GUID: FbX6IIJqo313pGFLIdScDS5cAYdtuYj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX7q3y7pIy+FGG
 a0zhKVcv0osPEGCbYbywHnquoYp2M7Ie7auZIiBYivfS8CnKc1VoIIZZ2crmE/h+kHr5Cixe2BJ
 8YgY0Tra1ETxWf2mqh0B5EwTqjx8w7g9GYdX1IybNH/GVXUWxivphbdDjHXG9nCVEnSnzkUzHmC
 EJfYhyY0bpW5B0FpWgO7KcKZqIECjJiHviQ3/7ZhJt5rccF7DOwfsf5G/kLJOlGeKq6Jl/hw8N/
 lXwOvKhvBZ07jlXPKFvUcp+fJ8OU2hUAOyqWMZCikM9Q8lBnLKxXSCo4+/teoDGFkmb6DKA0IhI
 pn/oM6P0yJ7iAC0l8HX1pSnmyXpkyDUk2ZgtwO9AoNTvblrgmDXhPEzpx7ElMGKNyv28uNh+MgB
 PhMVA1gAzkYsEMSwxB4/fgnVuA6onugMbAj4DpvcumdfM6zkzvKleYzTvejHufFFqDHAZ/tEn+h
 MjSr2DfZT3EJly05raw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
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
	TAGGED_FROM(0.00)[bounces-33600-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 33CBE2DF11B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new wdev-only interface type NL80211_IFTYPE_PD to support
Proximity Detection (PD) operations such as PASN, key install and
peer measurement operations. This interface type operates without
a netdev, similar to P2P_DEVICE and NAN interfaces.

Implement support across cfg80211 and mac80211 layers with key
management gated by the NL80211_EXT_FEATURE_SECURE_RTT feature
flag, management frame registration and transmission capabilities,
and proper channel context handling where PD interfaces are
excluded from bandwidth calculations.

The PD interface provides isolated functionality for PD PASN
and PMSR without affecting existing network operations.

PD discovery can be performed on any available interface, such as
NL80211_IFTYPE_STATION, NL80211_IFTYPE_AP etc.

If PD/PMSR uses the MAC address of an existing interface type, such as
NL80211_IFTYPE_STATION, then pairing and measurement shall use that
same interface. If PD/PMSR uses a different MAC address, such as a
random MAC address, then pairing and measurement can be performed on a
new NL80211_IFTYPE_PD interface created with that random MAC address.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h |  2 ++
 net/mac80211/cfg.c           |  2 ++
 net/mac80211/chan.c          |  2 ++
 net/mac80211/iface.c         |  7 ++++++-
 net/mac80211/offchannel.c    |  1 +
 net/mac80211/rx.c            |  6 ++++++
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  2 ++
 net/wireless/core.c          |  1 +
 net/wireless/mlme.c          |  1 +
 net/wireless/nl80211.c       | 27 +++++++++++++++++++++++++--
 net/wireless/reg.c           |  3 +++
 net/wireless/util.c          |  4 +++-
 13 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7e139c746c32..62e461ffa0ce 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3677,6 +3677,7 @@ enum nl80211_attrs {
  * @NL80211_IFTYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_PD: PD device interface type (not a netdev)
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3698,6 +3699,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_PD,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ee64ac8e0f61..dac211f9a438 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -713,6 +713,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -3183,6 +3184,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		}
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 2f0c93f3ace6..79124ab31d0c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -494,6 +494,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			continue;
 		case NL80211_IFTYPE_MONITOR:
 			WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
@@ -1436,6 +1437,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 40ce0bb72726..bdb806647362 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1369,6 +1369,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 		/* no special treatment */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1489,7 +1490,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 						FIF_PROBE_REQ);
 
 		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
-		    sdata->vif.type != NL80211_IFTYPE_NAN)
+		    sdata->vif.type != NL80211_IFTYPE_NAN &&
+		    sdata->vif.type != NL80211_IFTYPE_PD)
 			changed |= ieee80211_reset_erp_info(sdata);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  changed);
@@ -1504,6 +1506,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			break;
 		default:
 			/* not reached */
@@ -1940,6 +1943,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_P2P_DEVICE:
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
+	case NL80211_IFTYPE_PD:
+		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 5f398d38d1c9..a2dda1e0ab3c 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -895,6 +895,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		}
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_PD:
 		need_offchan = true;
 		break;
 	case NL80211_IFTYPE_NAN:
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 19c33f7a8193..b7ff16ece252 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4607,6 +4607,12 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			(ieee80211_is_public_action(hdr, skb->len) ||
 			 (ieee80211_is_auth(hdr->frame_control) &&
 			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
+	case NL80211_IFTYPE_PD:
+		/* Accept only authentication frames (PASN) addressed to
+		 * this interface.
+		 */
+		return ieee80211_is_auth(hdr->frame_control) &&
+		       ether_addr_equal(sdata->vif.addr, hdr->addr1);
 	default:
 		break;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 55054de62508..2094ed366695 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2121,6 +2121,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_DEVICE:
+		case NL80211_IFTYPE_PD:
 			/* nothing to do */
 			break;
 		case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index fa0764ede9c5..1eb4f8722016 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -816,6 +816,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_PD:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -939,6 +940,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 23afc250bc10..67a603129c42 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1420,6 +1420,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_PD:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 5cd86253a62e..6d13093ce449 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -939,6 +939,7 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			 * public action frames
 			 */
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 		default:
 			err = -EOPNOTSUPP;
 			break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8547209dd504..75933f7865ad 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1726,6 +1726,11 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 					    NL80211_EXT_FEATURE_SECURE_NAN))
 			return 0;
 		return -EINVAL;
+	case NL80211_IFTYPE_PD:
+		if (wiphy_ext_feature_isset(wdev->wiphy,
+					    NL80211_EXT_FEATURE_SECURE_RTT))
+			return 0;
+		return -EINVAL;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_MONITOR:
@@ -4757,6 +4762,7 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	if ((type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN ||
+	     type == NL80211_IFTYPE_PD ||
 	     rdev->wiphy.features & NL80211_FEATURE_MAC_ON_CREATE) &&
 	    info->attrs[NL80211_ATTR_MAC]) {
 		nla_memcpy(params.macaddr, info->attrs[NL80211_ATTR_MAC],
@@ -4813,8 +4819,9 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		break;
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_PD:
 		/*
-		 * P2P Device and NAN do not have a netdev, so don't go
+		 * P2P Device, NAN and PD do not have a netdev, so don't go
 		 * through the netdev notifier and must be added here
 		 */
 		cfg80211_init_wdev(wdev);
@@ -10548,7 +10555,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 	wiphy = &rdev->wiphy;
 
-	if (wdev->iftype == NL80211_IFTYPE_NAN)
+	if (wdev->iftype == NL80211_IFTYPE_NAN ||
+	    wdev->iftype == NL80211_IFTYPE_PD)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->scan)
@@ -13965,6 +13973,11 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 		      WIPHY_NAN_FLAGS_USERSPACE_DE))
 			return -EOPNOTSUPP;
 		break;
+	case NL80211_IFTYPE_PD:
+		if (!wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_RTT))
+			return -EOPNOTSUPP;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -14028,6 +14041,11 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 		      WIPHY_NAN_FLAGS_USERSPACE_DE))
 			return -EOPNOTSUPP;
 		break;
+	case NL80211_IFTYPE_PD:
+		if (!wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_RTT))
+			return -EOPNOTSUPP;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -14153,6 +14171,11 @@ static int nl80211_tx_mgmt_cancel_wait(struct sk_buff *skb, struct genl_info *in
 					     NL80211_EXT_FEATURE_SECURE_NAN))
 			return -EOPNOTSUPP;
 		break;
+	case NL80211_IFTYPE_PD:
+		if (!wiphy_ext_feature_isset(wdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_RTT))
+			return -EOPNOTSUPP;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 20bba7e491c5..22bbf6d958de 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2400,6 +2400,9 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		case NL80211_IFTYPE_NAN:
 			/* we have no info, but NAN is also pretty universal */
 			continue;
+		case NL80211_IFTYPE_PD:
+			/* we have no info, but PD is also pretty universal */
+			continue;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 0a0cea018fc5..d558c4bc00f0 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1186,7 +1186,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 
 	/* cannot change into P2P device or NAN */
 	if (ntype == NL80211_IFTYPE_P2P_DEVICE ||
-	    ntype == NL80211_IFTYPE_NAN)
+	    ntype == NL80211_IFTYPE_NAN ||
+	    ntype == NL80211_IFTYPE_PD)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->change_virtual_intf ||
@@ -1250,6 +1251,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			WARN_ON(1);
 			break;
 		}
-- 
2.34.1


