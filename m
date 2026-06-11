Return-Path: <linux-wireless+bounces-37655-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LbLmM+lUKmoOngMAu9opvQ
	(envelope-from <linux-wireless+bounces-37655-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:25:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370D66F01F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:25:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=klYYvMGh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Ee3T7DrC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37655-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37655-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 062E431EDE8E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 06:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B03346AE8;
	Thu, 11 Jun 2026 06:22:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F4360ED0
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158973; cv=none; b=p9T+ioXPe6g44VM3zbhu83dgrARxdifbx2/f/PYc4h5pNaOLTdwUyK+jgkc4BbON0w+8X9oo5UIz20SEOyDB7F5hlft+qF4AFqGN+Y4enFuvxr6OGXdLFVZY2NV4NRUHJ0ctjLFPINTemf/nLOXQsHWSQRhu61BxNQAQbrrci8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158973; c=relaxed/simple;
	bh=NaIKTuefvZEZjS8ygE6v4yTDdjvwNMLCMNmmKNZgs6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tju1uI38UB8+f6qUA90ZEGkiV5sqeaYhyneNodbd+J4QdsCPU7nSlNQhF6qfCLr3IVQPkQPc5KQZcGhT1i6FqYUsJBizn3r2D74ylragMXiL8YDweJdQz0wjd2qYkudT4kkRPA9m/nRsUUfAYt7PIVqf2acoQlqOiirsAYt96dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=klYYvMGh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ee3T7DrC; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GKT53761261
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BWBKr3n7evk
	UrCcxUX443WyGoegnXWv+UT4oLKhUg48=; b=klYYvMGhM1xhEzRBaIALu+D+PIv
	tyCyMBlzSvxmhAH62LOZCvpVsJ23LGp9qS1K7ovhkL9zERHbRCgN4x2/n4NpR0p8
	XNNkMNUO2YMhhceeYZEt6xUNzV3IfVqyBW+GtxEwokqA5bCnMDR1VkMeXALuyNsl
	Hz1Jn6cxbLC33uZyyYghL0da7XG57CLr4mcjfaat5/+94JoX8dFmMrYZ5qgp0C44
	E3IxUSz1Er+at1pifiFg+4muEzdz0qt+ujUhLy2uCvOiqrG6eUI49F/XGMYArnD8
	ZJP6MwV/pwtFMjDS4Kdh5OqOVNeEttNEDOqt00iHMTeM3RPj+ogHt3UhWbQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sj128-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 06:22:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d97415004so14672372a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781158970; x=1781763770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWBKr3n7evkUrCcxUX443WyGoegnXWv+UT4oLKhUg48=;
        b=Ee3T7DrCjBSBsDmxhK0cKBkcLTBMpl0Jf2ivI9bMBs93mvG8cRUFee2hlN8kFlDB3L
         wVmpggpNQGg0ogwDajYB9eS0F0CsRfnSgF/h9GFS539Gv8/whpY6hP7HP/V4OfIXpGHQ
         9HCAC1Bkam/n33CS2FdoBKcnpt7r7bqQL9+sOHAKm+wA3opEecnizJkKgXzzG8eQO9JP
         +0R207twpGgXi/vO5GvbwBDiX/WpOFBvDnX9Aqn/CdhImGWMr6XySOxYiF+uFk6B136K
         PziuqnKnHuPFqDX3LHAu/A3lUEuLZtQpMsp/xglSXDCjQy8ZEkavYTjPo/xTdXF7f9bJ
         FOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158970; x=1781763770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BWBKr3n7evkUrCcxUX443WyGoegnXWv+UT4oLKhUg48=;
        b=TN3xT7Yb6ujby5M9txxmQ6UUEkD6HGyguMUAvBmegZ1nNx1DPukl+xH9FADU75CMMK
         V5xGBK58zUjRRUOneW8Tn9qC8x0HITgZVxINU77mhkzoSMQAdeJCD3YM846vWrkEB0Xb
         22BowJJyN8aCqgjaD2yTVefPTGMhtCZMh9AICVA1S/W5t7ET448Fl8oeRD6LHnStQ7Zb
         j1QPnx6O8SA2jqDu+HptN9uzlxfb+cu/rweuvbHxUYwKyVpXsUHCpD58tG9ecyfVVI0b
         mus5oku4pRrWIQ5TUy45vnyD8s65/NNVxQadKNZsjhQY/T330xAkLV80OUEGuCVvoHQd
         OsSA==
X-Forwarded-Encrypted: i=1; AFNElJ+SxXCJ1lUYMhnhZT34IjNOZgJTpz2LvNXFy8Cf12ZZVjpd8rKy0A/XX6ECF0VktWz68HJrKBT3ht+xUIMdkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAyYhQabJAvQDSg+PSFHNKwh1cWbo3nVLCi7vtf/efssyy7b/P
	bLbij6LfSCn5O634LkFsRW8OtQcH0veGIeK1xsv/iUf+Z2QnsquhuMTUvvDGdas9D6fHja/4/1z
	KqH6xVDb0J3yENskC7f1W1n/n3g/DCRrXy0Be2W3Q8lyipyeTY0/lSf38z92GU9PWJ/3dPw==
X-Gm-Gg: Acq92OHlBwvvwmGvD1E9+piCEn94QfojNXiJ1E7n682LSO7jMUD6FBqiLLs/CoqrVLu
	iICblJxKfmg4va7cbj8hc7JO39+PPuA2waF0vZcNXgqE5ZGl9AIMdEmDrwNsIkLTsvTBT9PGHRP
	Eq+ccvug83gh0c4xCWHoOSgRfCeLpbr2p/nqL29EaKt/rNz/vzGXahEXZQJafOICWJlNvJNgp0r
	/V+mWrlV2WdK7EQojftCOqnso8mwTRJsfI41YtEf93yvQSQBUjMbcEUbKz9Y7lr1GefTZ+yRKsu
	zVOF93YYtfpzbfAt9pHJkIEtOCWO/+TGjLAaKLNt6JXvY7sw+azCNQPFAmfnL4Kay+q3oM0i5KA
	5CiVnvrJKSN6UStF9w9ak0ztlreiPkDzcTqSR7m/KrsxLw6/4IXkIofr/
X-Received: by 2002:a17:90b:28cc:b0:369:de03:29c8 with SMTP id 98e67ed59e1d1-377aa3c6341mr1400652a91.23.1781158969622;
        Wed, 10 Jun 2026 23:22:49 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:369:de03:29c8 with SMTP id 98e67ed59e1d1-377aa3c6341mr1400645a91.23.1781158969072;
        Wed, 10 Jun 2026 23:22:49 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37752874fc3sm1247507a91.5.2026.06.10.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:22:48 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: veerendranath.jakkam@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v5 2/4] wifi: cfg80211/nl80211: add STA-mode peer probing
Date: Thu, 11 Jun 2026 11:52:23 +0530
Message-Id: <20260611062225.2144241-3-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
References: <20260611062225.2144241-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a2a543a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=_MN9sPK_sje123sSk38A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: a-5dXrskRWZbId1cRlnZ2mLhXnzA5xcq
X-Proofpoint-GUID: a-5dXrskRWZbId1cRlnZ2mLhXnzA5xcq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfX6BxrDps7ArtU
 7HRQVmL8MZqeoaSr89iA7FGtaXv+DUrc9ieLT4YjPg/mwu1zcFKbvzBPnayIaPVTwI1fUpEJYpC
 WU+vGDwhDHRzkl/oZW/2Z3svXlu50HUcO9remXORoPlAj8Yjsm/h9uAhcZLDyQ4B4AoF8783rDp
 o9TxrcIwXQYNfa5OqanYptt5KfRzoK6gmK/g+F3b06KXcqADKIGefjjZHEsgrrHr9A1fzNKHYiV
 mEddvaDv1Hm+tpVCdsV0A8Bjwh4XhWRi/+Fq7fizRc1gqskkAACtal6y4/Ptq5hlxNG06kZGz7E
 IMlprc8hJfo/psU/Ql0HJzAylToSIH7t7+MoFetMsue7+Gg58sGE+zuu20odxUhshOWmqGFk8bE
 6rB/zCAm9R/DTv7d3C3QHhjkpXeDWjMQhmXvIrna+WOtEzdNCoSJ3MhcgwL29E2il/Sxo2Nnqq8
 4JTYSfen+WRayUZNfpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MCBTYWx0ZWRfX9YEA3RQFmelE
 RXSQ/RAqVszINniVus9ig/mjS/WeqjrI9LMPoNDnTZyRV/VKTWp3mmmAEn/0Yzv7DAUBSzlCuu/
 1SS3zJxv2BWSjIjYu/7ez8JjiRVWHIM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37655-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:veerendranath.jakkam@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2370D66F01F

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Add NL80211_EXT_FEATURE_PROBE_AP to allow drivers to advertise
support for probing the associated AP from STA/P2P-client mode.

Extend nl80211_probe_peer() to accept STA/P2P-client interfaces
when the driver advertises NL80211_EXT_FEATURE_PROBE_AP; in that
case the MAC attribute must be omitted (the peer is implied by
the association).

Update cfg80211_probe_status() to accept an optional peer address
and a link_id parameter (-1 for non-MLO), and include
NL80211_ATTR_MLO_LINK_ID in the event when link_id >= 0.
Update all callers.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c |  2 +-
 include/net/cfg80211.h                      | 14 +++---
 include/uapi/linux/nl80211.h                | 20 +++++---
 net/mac80211/status.c                       |  2 +-
 net/wireless/nl80211.c                      | 52 ++++++++++++++-------
 5 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index a85ff2a4316b..5f2bd9a31faf 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2326,7 +2326,7 @@ static void wil_probe_client_handle(struct wil6210_priv *wil,
 	 */
 	bool alive = (sta->status == wil_sta_connected);
 
-	cfg80211_probe_status(ndev, sta->addr, req->cookie, alive,
+	cfg80211_probe_status(ndev, sta->addr, req->cookie, -1, alive,
 			      0, false, GFP_KERNEL);
 }
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 549b2214e833..ddefe5acc5ae 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5086,8 +5086,8 @@ struct mgmt_frame_regs {
  * @tdls_mgmt: Transmit a TDLS management frame.
  * @tdls_oper: Perform a high-level TDLS operation (e.g. TDLS link setup).
  *
- * @probe_peer: probe an associated client, must return a cookie that it
- *	later passes to cfg80211_probe_status().
+ * @probe_peer: probe a connected peer (AP: STA MAC required; STA: no MAC),
+ *	must return a cookie that is later passed to cfg80211_probe_status().
  *
  * @set_noack_map: Set the NoAck Map for the TIDs.
  *
@@ -9846,15 +9846,17 @@ bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev, const u8 *addr,
 /**
  * cfg80211_probe_status - notify userspace about probe status
  * @dev: the device the probe was sent on
- * @addr: the address of the peer
- * @cookie: the cookie filled in @probe_client previously
+ * @peer: The peer MAC address (or MLD address for MLO) or %NULL if not
+ *	applicable (e.g. for STA/P2P-client)
+ * @cookie: the cookie filled in @probe_peer previously
+ * @link_id: The link ID on which the probe was sent (or -1 for non-MLO)
  * @acked: indicates whether probe was acked or not
  * @ack_signal: signal strength (in dBm) of the ACK frame.
  * @is_valid_ack_signal: indicates the ack_signal is valid or not.
  * @gfp: allocation flags
  */
-void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
-			   u64 cookie, bool acked, s32 ack_signal,
+void cfg80211_probe_status(struct net_device *dev, const u8 *peer, u64 cookie,
+			   int link_id, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp);
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d1907dd12a80..6b8071606e6f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -922,13 +922,15 @@
  *	and wasn't already in a 4-addr VLAN. The event will be sent similarly
  *	to the %NL80211_CMD_UNEXPECTED_FRAME event, to the same listener.
  *
- * @NL80211_CMD_PROBE_PEER: Probe an associated station on an AP interface
- *	by sending a null data frame to it and reporting when the frame is
- *	acknowledged. This is used to allow timing out inactive clients. Uses
- *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_MAC. The command returns a
- *	direct reply with an %NL80211_ATTR_COOKIE that is later used to match
- *	up the event with the request. The event includes the same data and
- *	has %NL80211_ATTR_ACK set if the frame was ACKed.
+ * @NL80211_CMD_PROBE_PEER: Probe a connected peer by sending a null data
+ *	frame and reporting when the frame is acknowledged.
+ *	In AP/GO mode, %NL80211_ATTR_MAC is required to identify the client.
+ *	In STA/P2P-client mode, %NL80211_ATTR_MAC must be omitted (the AP is
+ *	implied); the driver must advertise %NL80211_EXT_FEATURE_PROBE_AP.
+ *	The command returns a direct reply with an %NL80211_ATTR_COOKIE that
+ *	is later used to match up the event with the request. The event
+ *	includes the same data and has %NL80211_ATTR_ACK set if the frame
+ *	was ACKed.
  *
  * @NL80211_CMD_REGISTER_BEACONS: Register this socket to receive beacons from
  *	other BSSes when any interfaces are in AP mode. This helps implement
@@ -7086,6 +7088,9 @@ enum nl80211_feature_flags {
  *	LTF key seed via %NL80211_KEY_LTF_SEED. The seed is used to generate
  *	secure LTF keys for secure LTF measurement sessions.
  *
+ * @NL80211_EXT_FEATURE_PROBE_AP: Driver supports probing the associated AP
+ *	in STA mode using @NL80211_CMD_PROBE_PEER.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -7167,6 +7172,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
 	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
 	NL80211_EXT_FEATURE_SET_KEY_LTF_SEED,
+	NL80211_EXT_FEATURE_PROBE_AP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index dd1dbba06838..c3d29aed93fe 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -655,7 +655,7 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 								GFP_ATOMIC);
 			else if (ieee80211_is_any_nullfunc(hdr->frame_control))
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
-						      cookie, acked,
+						      cookie, -1, acked,
 						      info->status.ack_signal,
 						      is_valid_ack_signal,
 						      GFP_ATOMIC);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 29505f64591b..e339ea116a13 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16148,16 +16148,32 @@ static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct sk_buff *msg;
 	void *hdr;
-	const u8 *addr;
+	const u8 *addr = NULL;
 	u64 cookie;
 	int err;
 
-	if (wdev->iftype != NL80211_IFTYPE_AP &&
-	    wdev->iftype != NL80211_IFTYPE_P2P_GO)
+	/* Allow in AP, STA, and their P2P counterparts */
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		if (!info->attrs[NL80211_ATTR_MAC])
+			return -EINVAL;
+		addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_PROBE_AP))
+			return -EOPNOTSUPP;
+		if (!wdev->connected)
+			return -ENOLINK;
+		/* STA/P2P-client probes the currently associated AP/GO. */
+		if (info->attrs[NL80211_ATTR_MAC])
+			return -EINVAL;
+		break;
+	default:
 		return -EOPNOTSUPP;
-
-	if (!info->attrs[NL80211_ATTR_MAC])
-		return -EINVAL;
+	}
 
 	if (!rdev->ops->probe_peer)
 		return -EOPNOTSUPP;
@@ -16173,8 +16189,6 @@ static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 		goto free_msg;
 	}
 
-	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
-
 	err = rdev_probe_peer(rdev, dev, addr, &cookie);
 	if (err)
 		goto free_msg;
@@ -22588,8 +22602,8 @@ void cfg80211_sta_opmode_change_notify(struct net_device *dev, const u8 *mac,
 }
 EXPORT_SYMBOL(cfg80211_sta_opmode_change_notify);
 
-void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
-			   u64 cookie, bool acked, s32 ack_signal,
+void cfg80211_probe_status(struct net_device *dev, const u8 *peer, u64 cookie,
+			   int link_id, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -22597,7 +22611,7 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 	struct sk_buff *msg;
 	void *hdr;
 
-	trace_cfg80211_probe_status(dev, addr, cookie, acked);
+	trace_cfg80211_probe_status(dev, peer, cookie, acked);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 
@@ -22612,12 +22626,18 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
+	    (peer && nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, peer)) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_COOKIE, cookie,
-			      NL80211_ATTR_PAD) ||
-	    (acked && nla_put_flag(msg, NL80211_ATTR_ACK)) ||
-	    (is_valid_ack_signal && nla_put_s32(msg, NL80211_ATTR_ACK_SIGNAL,
-						ack_signal)))
+			      NL80211_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (link_id >= 0 &&
+	    nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
+		goto nla_put_failure;
+
+	if ((acked && nla_put_flag(msg, NL80211_ATTR_ACK)) ||
+	    (is_valid_ack_signal &&
+	     nla_put_s32(msg, NL80211_ATTR_ACK_SIGNAL, ack_signal)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
-- 
2.34.1


