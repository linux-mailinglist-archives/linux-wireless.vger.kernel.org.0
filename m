Return-Path: <linux-wireless+bounces-38658-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzzdEsdpS2oGRAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38658-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:39:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE3C70E321
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:39:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SgSm04Aw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Oe7AB0Ri;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38658-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38658-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D10BD301D326
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB89279DC9;
	Mon,  6 Jul 2026 08:39:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602C3F39EC
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 08:39:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327158; cv=none; b=ooCguDCdWR4rB7GhDUXNpKeO6jG2v3CY4n0DMefS1xBx3QaF2N+HgrGe5feTHhL8jzJTzwgMeAHrynf8n9jZSn5/PSeOtJ10TL0dZxpWLf/c/ApKmRO/MHaZU0s0grBXR9gUPiaDWX9XF6KD8Ycb7hPWmpBAd7ND0WzfOdv+r/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327158; c=relaxed/simple;
	bh=yYIvx/7sDTXc/tF5CeTXb73963GdpGznJzBQeFA8Mkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQMJlN0nRDdWtqjV5r8br1e+JJIt/wLz3EaLnpbnnRTbw/s+8g9Jz369Nf4+/p7JR19CZJfdIXrTV1AP2hI/RubnAoQuGohWGTPqzG2BSJxwCdWp0RSGZ+bszMk/qHuJ9fG7cJjCwGA5FosuASwFjWgQoIduQtCNIXpF9ywiFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SgSm04Aw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oe7AB0Ri; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666857f94007029
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 08:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8cCUED+WKOM
	Tjfk+NJYpMOHd3h9YMIL+mgA+oxh+HtQ=; b=SgSm04AwjatgXlfw/OHIPKseokN
	yHGwpqiKKsa3KQY0NBhH6VwwRGApC54fFHhpvF+Dl++y40cIFKvYPayxJ6/+mwxe
	QKUYY6z9/yVB9C9dq/QXBFIV7dIa4pAq44KfvYjQujAJn1AqfTnr0Uf5Y1E8lD37
	IBd3bPGyEQazqkeGbCGIRsl6kYgTpPtzemnghrFPr0AnYPV9+n8c/Bxu1yy5MlDC
	qnU5k9sBGuLU6SeXhWs3zV8pWM+o2yBtrszOyBL/hF7p71XhrV3jCvTqT2BNIwAm
	u9Wc8UqGWt89ZWnOZkad0WaaZgfu4UoWLLkVckKmx/i3YQ1nQqXiNokNVTA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs851t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 08:39:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc77a6943eso54667275ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783327148; x=1783931948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cCUED+WKOMTjfk+NJYpMOHd3h9YMIL+mgA+oxh+HtQ=;
        b=Oe7AB0RieCM+1GRI9XxvKBDXDRwqS9uCKvd3xWC6lgQh/hi+Rx+e+DEoxLPAmOSgK3
         j5jwLSYFrOewzmDtC8hNGa8TsdBtq5JrI59gb6JzNfUOAtLBhqoD2Z63pxWfbroJz/KZ
         5eGp5HYGY5TNnsGWVmzyS4ltG3LnRJH3rguL6gtYuZsBjyyEH/klcAGSxzhaLzpL/1GC
         hyjHzV0WdrHH8bhsqqPuv+vt8gaYmlTlzEl4xyLsHDEKvMqLGLFRwkPADIqu3nOXu+HH
         O8oYf6I3PUwgeicLk/oQqU3Q68WHEHh5FMgOQUXkSX4NkDQA+iC/a18TyoRntVxNzOoV
         w/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327148; x=1783931948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cCUED+WKOMTjfk+NJYpMOHd3h9YMIL+mgA+oxh+HtQ=;
        b=S7ZHCrSyHNnnN9QKTOMnZO7yZ8ROM+naxO8JPavNwO5rOb5gnDhUxfpMs23VaXcxLk
         XnPmDxARA5+FnSFBwGpXSDO5YkP07h8pwZNRJUZCKNNdjExgq15GAYiYmVG1Xozyu80P
         D78OTDb8JbRq4N+2Aaz84RLKG52naWlxej0sFiS6uduLOaKUc6Kclbgeh2bvaW+5ogcA
         VqHVQZvCdaeqeObyykK5ugfE3wo3pQHxjNY6gfVEkYVlaH7LFUvPz1V0cEiMlpm8yWZG
         ik4zCploPpfKY6O+b9S1UHcYY9i7QUxJQxSoxpbg4//hkqFB6m45cyqYm82ohJF5ZcWx
         bu7A==
X-Gm-Message-State: AOJu0Ywn375mo+X65aR2HJ2drEQsoz795bPX8kZZaStjqbzPvoRAFZgV
	tV2XOXi2PkUlXHPQFqj3VmCrWlMi/u7K7EmnFv2kLkGdObI4dxg+thV5+5ZSY84m2k3kycz9Hwk
	nIF1DKgHfQ9r+QUglCodTre22HHbuePeN2fqnmveyaBB1HPO4zrYfIcjEwzb5QXSjHPfs
X-Gm-Gg: AfdE7clAlsG9lRx04GNAfQN2hQwXbL6KqAq4+bpOuCNsT1fCAyTbf+TaNGNhoTJCwuF
	tice0oNi+D90g19GQoRRD332EbhldVh23iYe4JU8UqzEnr1VZ9VvvxRmhDoDFwkdzGtJcs2TngA
	H07qX1ei2Sm1A1XGFKxQXXOy5ft/yBnav/4p/T91XDBGNLsEOEv/Lbvg6YLmDVastXI8NCdkh6n
	ZMVk70SiS2U7Cb4bCshkCtJhtJVGvms8uKNQ0aS+YZod1K/tmLncaDvcy36e68fM+xYPQuRKM04
	eA0QgYXmeZQx2opnnU/zbT9IXxNr1haz0FA/e+h2KSYPN9gy9HUQ4gmTo1oGiksiW12ZDJgTqQ7
	d69kOzG4FpS3rYjI125OmgUMA8Dp8dObCYNK5Akk+PD3z2IOqzm3EVEeD8Vw1jVHOJXtKX7W6A+
	rd8jBiZ6KikG3Ggt70iFzxEXTpgvDw+xp/jb6W
X-Received: by 2002:a17:902:e552:b0:2c9:97a9:2096 with SMTP id d9443c01a7336-2cbb9ef52c1mr98515635ad.42.1783327148097;
        Mon, 06 Jul 2026 01:39:08 -0700 (PDT)
X-Received: by 2002:a17:902:e552:b0:2c9:97a9:2096 with SMTP id d9443c01a7336-2cbb9ef52c1mr98515455ad.42.1783327147683;
        Mon, 06 Jul 2026 01:39:07 -0700 (PDT)
Received: from hu-pshashik-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25f92sm45656925ad.9.2026.07.06.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:39:07 -0700 (PDT)
From: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, cgopi@qti.qualcomm.com
Subject: [PATCH wireless-next v2 2/2] wifi: mac80211: Pass MCST element value in ch_switch_started_notify
Date: Mon,  6 Jul 2026 14:09:00 +0530
Message-Id: <20260706083900.908140-3-shashikala.prabhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706083900.908140-1-shashikala.prabhu@oss.qualcomm.com>
References: <20260706083900.908140-1-shashikala.prabhu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kBL6jvQ8QAAKlETfTtA7niLWYuyXI_-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX4fafP0N1+WPX
 gOXFsoTy2kEpP/S/CGGIQ6xpeD7c2BKcuxZ0d2dssdLZWqkQydGPUGRvxdbT7/h4DkAjqco6MQn
 cyDGdnBD+QownbPWvFiZ5AUqGGHrB9LsL50AXVFQLxK1n6++tIQ+H5pxNNwtLQjXO3BDqAhbbkS
 9jdDSWOCOObassO/0phPNp1C7UjkvMZTylgWUqztSQJ5fh6/RqzcFCNHDZX786hC4RwNRILIVMJ
 AeR1W5z7v6uL2uS9OWVL/XLz6HrsNHzQnSTRw15uqo8vWLruK+YWIG/S27Of99N43kT7ivgrlCz
 n8eZqlkJO7LWPqrbYdLJtzh/IfmKJRL9dBUTXgtdXCkzgR5I7CP08DlyJlH5hznKxmhtJaTMrya
 /IOxmn5sj880yat5OXuSzdbEM18KA4LSBnYpw5O2dq0Z7pJqciLu8BrZALci7itgwlmiOEuIXdB
 BxUYNZuEKIroRz3NGwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4NiBTYWx0ZWRfX6uX9EVkEZdzC
 0YrE2dZTOOuUNSX6CRDTbzik9288u4pc1AEGRFc8VXIqtmTl/2tA+qmx1hH5zfb16biJkxucp8o
 R5qL1nM0pyEIGZOvWOXrcb4zULFLTcI=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4b69ad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=qGnBH85BPG6j4nX1zRsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: kBL6jvQ8QAAKlETfTtA7niLWYuyXI_-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060086
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38658-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:cgopi@qti.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shashikala.prabhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shashikala.prabhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE3C70E321

From: Chandru Gopi <cgopi@qti.qualcomm.com>

IEEE Std 802.11-2024 subclause 9.4.2.216 (Max Channel Switch Time element)
defines a Switch Time field in the Channel Switch Announcement (CSA)
element that indicates the time delta between the time the last beacon
is transmitted by the AP in the current channel and the expected time
of the first beacon transmitted by the AP in the new channel.

Pass the already-parsed MCST (Maximum Channel Switch Time) element
value to cfg80211_ch_switch_started_notify().

Pass mcst_tu=0 in the __ieee80211_channel_switch() call to
cfg80211_ch_switch_started_notify() since the AP-initiated channel
switch path does not carry a MCST element, as this element is only
present in Beacon/Probe Response frames processed on the STA side via
ieee80211_sta_process_chanswitch().

Signed-off-by: Chandru Gopi <chandru.gopi@oss.qualcomm.com>
Signed-off-by: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
---
 net/mac80211/cfg.c  | 2 +-
 net/mac80211/mlme.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 3b58af59f7e4..70cb8e39a64f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4802,7 +4802,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &link_data->csa.chanreq.oper, link_id,
-					  params->count, params->block_tx);
+					  params->count, params->block_tx, 0);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, link_data, changed);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9e92337bb6f9..507d7e81ddcd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3470,7 +3470,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
 					  link->link_id, csa_ie.count,
-					  csa_ie.mode);
+					  csa_ie.mode, csa_ie.max_switch_time);
 
 	/* we may have to handle timeout for deactivated link in software */
 	now = ktime_get_boottime();
-- 
2.34.1


