Return-Path: <linux-wireless+bounces-35026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OUyMGHt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2334428AD4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57F7E300752C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B88438CFE9;
	Mon, 20 Apr 2026 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TU4JieUT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GV0X2o0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3038C40C
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676183; cv=none; b=pcxbLGpdAOo8sexQB8wSbz1vpuaO1Oskb9v+H8A1PPgLc7puQN8AMWbpr0FcbfUUiAXn23qSPm5g4wzafzXQXStV8RJiKxZiIcxfmvULaSandY7USkMNbT37HRvPspy17NHVcGOwe8asiLpVsIFN7vqg+/Ny3POjtRcXl29iOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676183; c=relaxed/simple;
	bh=pAFtAnxJnFUJ/aCV1dwzPPvRwy7vEvjVccnhZL6zZwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKA7lFmllXRgwAVPruGUykizS6DT7JADpNbt5uUvRkGB9arxhfYHhO9p+GkzFaT+AHyXugpiOzwCNmr4NzyTVG8YSVaXjIg6W4qd/lnqBBInpYPgMfZWicqSJx6II7EBmHQgGfWcwx7COftl7EzRqvoWnTaFbvqbeBd5fTjD4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TU4JieUT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GV0X2o0J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7Wtg81532093
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cSKALYMxM5j
	+DHM0FJZ4dKt9gtxc1hduoJIA2qrHyqI=; b=TU4JieUT2gyL8PqW4MwqSSp1xRJ
	8Mmn9ZvgLohbnR/gYuHulgTxadtH07LGvPgUVA08jIRHaymOsCsdY7n6808w+rQr
	RePIkWx8xKGdatv7cXeFu80Hv7bhXACy93QgB4WZ1VvkPmhwlasYB69qLUoGR8N+
	uRkH0zzRdiGgPtJDYKR5OLoVIWTX7MfjsLWLuzFXobxVYBils1+r/R2L/jSaMIyA
	kjy0njJKI2yJPK2ZcUjYF52pBOkv1DoWIc0XGbVfiwgW2K8IFGju82SWRHQM17r1
	oT4N0Nw9HyWmK9O78wLwp2OYGBXYWeCx7ivHo3/4fM1OxmeKdyW5zlBFkMA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus0nqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35d9467e85aso2952528a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676180; x=1777280980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSKALYMxM5j+DHM0FJZ4dKt9gtxc1hduoJIA2qrHyqI=;
        b=GV0X2o0J97hH/L0eIuY2mjUZ5lpQPxnDG59Ewz/gvqIraU7hMtk6kTNz90GvXiHMRZ
         FqhN/0Bt1ktFsHAcGgtP0P9lfOYwcOUUsgz0EIDHXoCO+Al5V+Rz2GhiR7ChOJeHbBxn
         KEAtGAN0zHqPkRQJuBw8H5ALpV93Y/xswmVGsB2ruys3rmjuJ0CZ8RB+2TYSzoUAH2Ut
         Yw06c1u8pfTSRmzV8QpN1wJoL1Ri2KvlSPhKq4Dyci9AHFCkQ6T+Y6By4U6inZIJnzhD
         16i75dF/ifI+kW/5JcB4G2ugY0vMyYv31RaSOo8y0IlOlMraf4Gc0FA7VGZGrvoagQ9h
         itUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676180; x=1777280980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cSKALYMxM5j+DHM0FJZ4dKt9gtxc1hduoJIA2qrHyqI=;
        b=fO2FuA97BeqbHkeRsvoPb20P4N/CU4llBNPbeEqLQoiEHk2WHTLyJBsK9U7aMSvKnE
         8Hp1C2C6wtT3iHwXKuzW8cXrDYI61XzvIphEps50t1+NqZhSdl4k2QCKG29XxpCuCqwv
         /j6kH/4nA1i6yh0IFXSIsxtukxOqsFhhaUB9PjjrAzcCHI84/w6s6an54aXXAGMjlUqB
         GyfmdTnmX+7+5wKlAeZf+UUXBiVDHCr9YX8vzSmfinsujVs1H1xwZjOVw2S/4pyVot1g
         RxiSl5GnKYU1djCoS4aEzEgdJSQ/dacjw3d9IpkmxkWDj5cfVUSkjhx5pQkSQbWD3s+9
         Q+cQ==
X-Gm-Message-State: AOJu0YyDbOGVMVZ4gArrICHVJEvPTlyw6wTBwq+Ojio+IS75GLWoQRTt
	+noSILsQLx5OQxkjeitX8hdoeeYttoq17NyyNgPut/oJFlh4gDnLmpCwRkSHU87lq+JmOSPdWO3
	TfwGxRDjdwmOcAmeJY002KEBr4yhmxrP6I9VYy26ksn4K18wYBwJTVtdPdzZBT0frMnO8
X-Gm-Gg: AeBDieuAVcKhK1YwqRyu2L0FnIOIHlKyY+aa+F5YIjd6aMeQcEqL2tf5qacXjmcvWET
	W0abRugvZnzUHr5298eabe8AlsEhqZn9ZVtStGWHqz5jVcBow/P2iqkZJauavGDIL4GHVl5i+ib
	xn74oS9jVa8U1JcXrjxpjr+E0d7BY5iYMmZpvQbBpQGw+KhGNs0Wqhq8sjcEtwA8ZiM7Hq6NRKK
	QeCa7BMJgRU9WieOGhVXSTbTA4QcV8CJFBZnmmGaJlHidx5g6oM2V1WYTL4u7InAe1AFIFwB3qx
	gYn1f30NiFgqIggdxyzgJRPZA/LkQ4Z/erKwKOfBtvIblTRmF1NPyEXoHQLsiyiSoAh+AzlxT5F
	EfA618As1sitWBSrx/aEIOv4eLyTl0WtjhxTXDKzZsMtpboGB7xOHnNfiEQbad/iybg==
X-Received: by 2002:a17:90a:da8f:b0:35f:c1cc:feee with SMTP id 98e67ed59e1d1-361403c3263mr12791532a91.3.1776676179904;
        Mon, 20 Apr 2026 02:09:39 -0700 (PDT)
X-Received: by 2002:a17:90a:da8f:b0:35f:c1cc:feee with SMTP id 98e67ed59e1d1-361403c3263mr12791506a91.3.1776676179381;
        Mon, 20 Apr 2026 02:09:39 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:39 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 03/13] wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR operations
Date: Mon, 20 Apr 2026 14:38:46 +0530
Message-Id: <20260420090856.2152905-4-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXwkZEByHYmCC8
 TXuneJPdEp5LK9E4OUmuyqy02rqdW42mkzOIrQOvga+1oIIkNMIF+PWzQMlHmpBAz3HwPQlreVO
 w6kETJvYt2DPt2K0WK9sD86uRPTCBcmSSIxxtGN7S7a++kQcF0AVyJX4CEHAGvfXX1YkYl2c/zK
 Z42KwhNs6GKMhM8qUjARcDOIA1WS8wkI3TVmC160BD4s8gPw/03X8icuIfbtWVhPOEphqYMogkj
 To2mpmxPtRkmtAVxq7/2PO1+7UAtrdDazr6yXYKebka+lNvE0WYFb+aOJge9r8/dIwWdrAZl8I9
 XyJGfwNRxNAIqzwvowL7LjNQTLgvzflzmTs4yPKGuPzhIoJiu2W4wBKn4KGMYZFGhXQx2R1Xvpa
 x8uZyOsqBV7VjvuI/mhQDsQ9wGqMb88j6XMdEMjGoE41FwArWdupTEK+ZCzVQ+z2H+GnT+8SBct
 ZHwAcUEl/NEsTogNxvQ==
X-Proofpoint-GUID: _act1hLF5mYobAerx6FZsez47yD1K6GH
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e5ed54 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=TxMjh0AVY9LfnFWMPO8A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: _act1hLF5mYobAerx6FZsez47yD1K6GH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
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
	TAGGED_FROM(0.00)[bounces-35026-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A2334428AD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new wdev-only interface type NL80211_IFTYPE_PD to support
Proximity Detection (PD) operations such as PASN and peer measurement
operations. This interface type operates without a netdev, similar to
P2P_DEVICE and NAN interfaces.

Implement support across cfg80211 and mac80211 layers with PD-specific
checks gated by the NL80211_EXT_FEATURE_SECURE_RTT feature flag,
management frame registration and transmission capabilities, and proper
channel context handling where PD interfaces are excluded from bandwidth
calculations. Update mac80211 to recognize the new interface type in the
relevant paths for this management-only interface.

PD discovery can be performed on any available interface, such as
NL80211_IFTYPE_STATION.

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
 net/mac80211/iface.c         |  6 +++++-
 net/mac80211/offchannel.c    |  1 +
 net/mac80211/rx.c            |  6 ++++++
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  2 ++
 net/wireless/core.c          |  1 +
 net/wireless/mlme.c          |  1 +
 net/wireless/nl80211.c       | 27 +++++++++++++++++++++++++--
 net/wireless/reg.c           |  3 +++
 net/wireless/util.c          |  4 +++-
 13 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7f3d6d60b8ea..7fb77091f863 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3831,6 +3831,7 @@ enum nl80211_attrs {
  * @NL80211_IFTYPE_NAN_DATA: NAN data interface type (netdev); NAN data
  *	interfaces can only be brought up (IFF_UP) when a NAN interface
  *	already exists and NAN has been started (using %NL80211_CMD_START_NAN).
+ * @NL80211_IFTYPE_PD: PD device interface type (not a netdev)
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3853,6 +3854,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
 	NL80211_IFTYPE_NAN_DATA,
+	NL80211_IFTYPE_PD,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7b77d57c9f96..f984e3cbe3e8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -716,6 +716,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_PD:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -3335,6 +3336,7 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		}
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index fda692316f08..590f2511de53 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -551,6 +551,7 @@ ieee80211_get_width_of_link(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_NAN_DATA:
+	case NL80211_IFTYPE_PD:
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -1546,6 +1547,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_NAN_DATA:
+	case NL80211_IFTYPE_PD:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 95b779c4d627..87773022fe2b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1400,6 +1400,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_PD:
 		/* no special treatment */
 		break;
 	case NL80211_IFTYPE_NAN_DATA:
@@ -1532,7 +1533,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 						FIF_PROBE_REQ);
 
 		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
-		    sdata->vif.type != NL80211_IFTYPE_NAN)
+		    sdata->vif.type != NL80211_IFTYPE_NAN &&
+		    sdata->vif.type != NL80211_IFTYPE_PD)
 			changed |= ieee80211_reset_erp_info(sdata);
 		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
 						  changed);
@@ -1548,6 +1550,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			break;
 		default:
 			/* not reached */
@@ -1988,6 +1991,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
 	case NL80211_IFTYPE_NAN_DATA:
+	case NL80211_IFTYPE_PD:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
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
index 3e5d1c47a5b0..f1bdae2314ed 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4664,6 +4664,12 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		/* Unicast secure management frames */
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1) &&
 		       ieee80211_is_unicast_robust_mgmt_frame(skb);
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
index b093bc203c81..84d1fa498340 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2210,6 +2210,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_DEVICE:
+		case NL80211_IFTYPE_PD:
 			/* nothing to do */
 			break;
 		case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 8b94c0de80ad..8954ac1659c1 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -817,6 +817,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN_DATA:
+	case NL80211_IFTYPE_PD:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -941,6 +942,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_NAN_DATA:
+	case NL80211_IFTYPE_PD:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 6783e0672dcb..be2785812811 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1498,6 +1498,7 @@ void cfg80211_leave_locked(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_NAN_DATA:
+	case NL80211_IFTYPE_PD:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index bd72317c4964..86ef34211de2 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -944,6 +944,7 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			 * fall through, P2P device only supports
 			 * public action frames
 			 */
+		case NL80211_IFTYPE_PD:
 		default:
 			err = -EOPNOTSUPP;
 			break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 541da67fafe1..4b387bf1fe7a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1841,6 +1841,11 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
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
@@ -4937,6 +4942,7 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	if ((type == NL80211_IFTYPE_P2P_DEVICE || type == NL80211_IFTYPE_NAN ||
+	     type == NL80211_IFTYPE_PD ||
 	     rdev->wiphy.features & NL80211_FEATURE_MAC_ON_CREATE) &&
 	    info->attrs[NL80211_ATTR_MAC]) {
 		nla_memcpy(params.macaddr, info->attrs[NL80211_ATTR_MAC],
@@ -4993,8 +4999,9 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
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
@@ -10805,7 +10812,8 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 	wiphy = &rdev->wiphy;
 
-	if (wdev->iftype == NL80211_IFTYPE_NAN)
+	if (wdev->iftype == NL80211_IFTYPE_NAN ||
+	    wdev->iftype == NL80211_IFTYPE_PD)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->scan)
@@ -14223,6 +14231,11 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
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
@@ -14287,6 +14300,11 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
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
@@ -14412,6 +14430,11 @@ static int nl80211_tx_mgmt_cancel_wait(struct sk_buff *skb, struct genl_info *in
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
index 5db2121c0b57..1e8214d6b6d8 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2412,6 +2412,9 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		case NL80211_IFTYPE_NAN_DATA:
 			/* NAN channels are checked in NL80211_IFTYPE_NAN interface */
 			break;
+		case NL80211_IFTYPE_PD:
+			/* we have no info, but PD is also pretty universal */
+			continue;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
diff --git a/net/wireless/util.c b/net/wireless/util.c
index cff5a1bd95cc..df407ce9db3d 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1201,7 +1201,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 
 	/* cannot change into P2P device or NAN */
 	if (ntype == NL80211_IFTYPE_P2P_DEVICE ||
-	    ntype == NL80211_IFTYPE_NAN)
+	    ntype == NL80211_IFTYPE_NAN ||
+	    ntype == NL80211_IFTYPE_PD)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->change_virtual_intf ||
@@ -1266,6 +1267,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_PD:
 			WARN_ON(1);
 			break;
 		}
-- 
2.34.1


