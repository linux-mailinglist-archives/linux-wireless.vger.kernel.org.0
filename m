Return-Path: <linux-wireless+bounces-37918-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DiQ3BZXoNGpkjwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37918-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 08:58:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5836A42FE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 08:58:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=D+RuCDuP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=F4Ctd5kK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37918-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37918-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3063630038DD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1F23254B3;
	Fri, 19 Jun 2026 06:58:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E068322A2E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 06:58:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852306; cv=none; b=sKEqf6VN7mx0jh81N4GHn+yRJcOHBSHdFHuC5WDO4UNxxW/HQ0WcE246QW4o6sXGIVf4Xv54+H+25XziWbkkM+jUtug9wRl6AsrXXSZJJd/PGIKRdLiZIDDLOemZvail75Xz+KOQhMxCHMiOpWiF/hNQDvtIyMVvJDfzGgYKI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852306; c=relaxed/simple;
	bh=VYDEDtj/G32V1Vbu3LjofguDXlJr2ko4vBto2VdTsd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ujEFczuaMMvTxZSWDVCK39aQYsVS+Hy6STR8rfEZ2wZbF5PgT6OFxIBAOBwrPxuQIKsC65Nocjv2rS7C8lgmKvzIyOZu7eJeOLj6iONGbSufd3MLYRZ4NPAWGjLxvOJOcIUDNzdJUv3qEiEqhDMuGFptIQwT5iv+HyVIhDA42/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+RuCDuP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F4Ctd5kK; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J2smZn3039489
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 06:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xOtmqStDoUGhma7QcihIweAGCbgOFJi/DML
	IntRLZpU=; b=D+RuCDuPKF6K//qHbNHkkIfsw3TVBqU0sz8D9+9h17aozl2YxH8
	MjMFnxTw9an9PPC8rkoPyTzO7Cq1lbDsYpRC4W5/rvoJaLdqQ+7RsL/r39soCgJ9
	TDD9zzDKX9nsHmfdyxNVNq1pMs6hO0oWx1emqMXWj95IwHO8L9URFH80Z+ONSai6
	P6rw4xO/qpIO649JENq5QyFhklSgd+dQobDkL5aBSoJpwpJjAhduv9+G+F8vuvoH
	bWqCj6mogANxiyNqpfpIZ/BjqU/8zLsxe9OWOa0HL7dIYf+YJeXY9N+8TzI/ESoA
	w3kffo9GLLe1OrJxmCR5fZsYLBec5M6lMMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evkvf2u9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 06:58:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c2b64850easo38107795ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781852304; x=1782457104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOtmqStDoUGhma7QcihIweAGCbgOFJi/DMLIntRLZpU=;
        b=F4Ctd5kK4eg5DBUM9WhMnAd0rN14Xiju8V7B8tGpgHlH3k1z2XPXkTAXrd+qFEJs41
         J846F5oxjLER80/NXfOKm0l3z0pwkDvMp4fcmvqReT0zEAVU4hiPuvJvlgqsZ8Kz4P+g
         NE/R6jEmgCGH0XaoRNhub0aWldgMJn0gmiernte5cGAYr14EBQW3s+w1PHczhVHQZdcj
         Kh83FV+avs4aJB+L+/S7l9/x5WPQ2Uhf8tXWo8cNKjG4nq75PK8kzA5TtNTJpKvRZN6v
         v6p1hzaY8k86hNgnAEouj85qDZvuReAKuqlluxuHjKTJyQ+4Y3isUF40+XucrHM33fvc
         vhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781852304; x=1782457104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOtmqStDoUGhma7QcihIweAGCbgOFJi/DMLIntRLZpU=;
        b=NeZL1x9nVUAXCOAfxLTb6CEztWoPytNwXwTRQ7AjuthEfsGhffIcjqt0+8UW80WlW7
         Y21UA65LVtuDTcDHsvbielP2BAG1dbaynDFFZMAROGWYupxOIWVu86IOv4Uub+IGjpo7
         9sLK2CyBJgRISXdOc/6Y9xhHbJhJo6SL6m3SNW1kSwwTGZ0yyhS0LHd4i4xL8jZLz2Os
         tMoPtrTTza/+O/hQsoz7TYK68LLZ6p9tqrA6ZW+E3efkhR+amTG6M2CbYDf38CK3tH6H
         Bn3pRmY+6uRq7zPU9XHrhi/fhWxdhJWHhRrY8tz1ng/j2gn4jlTv7Txstx+Z3amSbgEb
         NB/w==
X-Gm-Message-State: AOJu0YyeubW/77XT/7jvLKzF+JYhZAlgIReGerzbxppn5yfNqyJ3J+dD
	6pszpc3ZiELYnaHcnPnvF0LF90772RoI82WExrxaXnssqDsJzCMoIPa9TT2gr6Vs3CFEj8en+n+
	t2Prfk5K6HBWt0TM3+pFem7cwaSOCK+9MprW7P6c4XZKgDRAv19msrVj0uakwsnizdYZFfQ==
X-Gm-Gg: AfdE7cntlbihHIaFgdhBNufkXFamad4tAwmDa9XcRbsszc8/kMys04a5rUUg5+85To7
	TSChyyCmQwyM26siFMjxUoXiR2Jv6pXaEepNkIJtRXgB2DpteklsRkpVwIWl1jmuYQw+JKpqz0f
	ptHad3ze528rljOl1adt5ZzSaiSrjsh17D/BtKlm9qo1gUjpG4IUFa9PHBhrFB3eTbHGdpzRRU9
	H7tMyOw1PRY4gKY9fjdr6lri4OfDijhtPNGCgrxMkIt8oFgYxdiVU/MBaTmuPm/DHhlYCLfxBXs
	xiD8utM5fY2KJ3zQfVtCYT2uvWdNdd/T6weRvZj/j8MfMvDkjMj3SzeQyd8R6minugp6P4hesXQ
	GiAeJySqMvVyDVoGLWtnB1Hv5IhuD/wwwEciTIXYUew2ITiOkMqOjB2LQxXfBj/UHcHvh3QXEcw
	d8xiMUElMY42vYqEuO8Xe85fDqSLpzsJoklg==
X-Received: by 2002:a17:902:e807:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c7185ed173mr30060435ad.0.1781852303563;
        Thu, 18 Jun 2026 23:58:23 -0700 (PDT)
X-Received: by 2002:a17:902:e807:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c7185ed173mr30060155ad.0.1781852303045;
        Thu, 18 Jun 2026 23:58:23 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c72089a6a7sm12373025ad.10.2026.06.18.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:58:22 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: add QMI capability negotiation for dynamic memory mode
Date: Fri, 19 Jun 2026 12:28:16 +0530
Message-Id: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2MyBTYWx0ZWRfX0JqzCgc4saCG
 pkRSC4nwOP9P+Z/mbO3O3rxSZdAB9QRp5BmkTBB7gTsztDngriZVsprxQjNxfN/KW9+uPy5gZB/
 3QEQPNmudU/OEfIJWB+5uQZWR3dk6A0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2MyBTYWx0ZWRfX+xc3nM6Klukx
 QjXVXt2FFSfCnBkilocdgWWYZrvTlH7pt0tU9AbhjxcpVo1oTJKeUlpoMcL36e2enabdmb9WzdT
 H838rsdF+RqWwjzoPii4yF6IoLIRKh4+L2AoQ2kV3OO7bnczyBmBHZhOrhK4DTWJx4zkin7FbFu
 jDDYqcUFetsc4gmbiYkgd/lwUEksNUHn+shuQhF6S66jw4IYeWeU+Io758bg/amEv6NNaGHlYp8
 Yy1ILSeVJf7WE0iTa+V3Hx02PwYfkhj9xi8UMVfxxd7IJOeOFiMGcL3O/Dbi73MNEzAqm5gmn0M
 EJ+2lh3KEYQSogSXKPqJ4XMNm0oyXqo1MFHyNecvUrx7GG+y9Yg8gJZNgV4C02D7DpeiNC1x3vD
 4grrRanR/moyMQfu2ZPU7rpwCty81Bbb9J+MKgi4vmda3h8hrtrO66Yit9j03X1QFxsIp1c7GiH
 5OWO1HTb8j45BjKOdmg==
X-Authority-Analysis: v=2.4 cv=H/3rBeYi c=1 sm=1 tr=0 ts=6a34e890 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=m70HO3XBkMWC9QqM1QIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: PfL_EXedkeRWN-IKhsou1WRt5Xv48KCg
X-Proofpoint-GUID: PfL_EXedkeRWN-IKhsou1WRt5Xv48KCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37918-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:aaradhana.sahu@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E5836A42FE

On AHB platforms, firmware operates in two modes: fixed-memory mode where
firmware uses hardcoded addresses for memory regions such as BDF and does
not request HOST_DDR memory from the host, and dynamic-memory mode where
firmware expects the host to provide memory addresses including HOST_DDR
after the Q6 read-only region and relies on host allocation for all memory
types.

Introduce QMI capability negotiation to support both modes. Add a new QMI
PHY capability flag dynamic_ddr_support which is advertised by firmware to
indicate it supports dynamic memory mode. When the host detects this
capability, set the dynamic_mem_support flag in the host capability message
to signal the host is ready to provide dynamic memory allocation. This
triggers firmware to send the HOST_DDR memory request and use the
host-provided address.

For backward compatibility, if firmware doesn't advertise
dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
where firmware uses predefined addresses.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
v2:
  -Dropped QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN and QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN changes.
  -Used %u instead of %d in the debug log.
---
 drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h |  6 +++-
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..e15a0c0120d3 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
 		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
 					   feature_list),
 	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x33,
+		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
+					   dynamic_mem_support_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x33,
+		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
+					   dynamic_mem_support),
+	},
 	{
 		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
@@ -602,6 +620,24 @@ static const struct qmi_elem_info qmi_wlanfw_phy_cap_resp_msg_v01_ei[] = {
 		.offset         = offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
 					   single_chip_mlo_support),
 	},
+	{
+		.data_type	= QMI_OPT_FLAG,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   dynamic_ddr_support_valid),
+	},
+	{
+		.data_type	= QMI_UNSIGNED_1_BYTE,
+		.elem_len	= 1,
+		.elem_size	= sizeof(u8),
+		.array_type	= NO_ARRAY,
+		.tlv_type	= 0x17,
+		.offset		= offsetof(struct qmi_wlanfw_phy_cap_resp_msg_v01,
+					   dynamic_ddr_support),
+	},
 	{
 		.data_type	= QMI_EOTI,
 		.array_type	= NO_ARRAY,
@@ -2248,6 +2284,11 @@ int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 	if (ret < 0)
 		goto out;
 
+	if (ab->qmi.dynamic_ddr_support) {
+		req.dynamic_mem_support_valid = 1;
+		req.dynamic_mem_support = 1;
+	}
+
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_host_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
@@ -2319,11 +2360,14 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 
 	ab->qmi.num_radios = resp.num_phy;
 
+	if (resp.dynamic_ddr_support_valid)
+		ab->qmi.dynamic_ddr_support = resp.dynamic_ddr_support;
+
 	ath12k_dbg(ab, ATH12K_DBG_QMI,
-		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
+		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d dynamic_ddr_valid %u dynamic_ddr_support %u\n",
 		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
-		   resp.num_phy_valid, resp.num_phy,
-		   resp.board_id_valid, resp.board_id);
+		   resp.num_phy_valid, resp.num_phy, resp.board_id_valid, resp.board_id,
+		   resp.dynamic_ddr_support_valid, resp.dynamic_ddr_support);
 
 	return;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 2a63e214eb42..08225242d30a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -156,6 +156,7 @@ struct ath12k_qmi {
 	struct m3_mem_region aux_uc_mem;
 	unsigned int service_ins_id;
 	struct dev_mem_info dev_mem[ATH12K_QMI_WLFW_MAX_DEV_MEM_NUM_V01];
+	u8 dynamic_ddr_support;
 };
 
 #define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		261
@@ -258,7 +259,8 @@ struct qmi_wlanfw_host_cap_req_msg_v01 {
 	struct wlfw_host_mlo_chip_info_s_v01 mlo_chip_info[QMI_WLFW_MAX_NUM_MLO_CHIPS_V01];
 	u8 feature_list_valid;
 	u64 feature_list;
-
+	u8 dynamic_mem_support_valid;
+	u8 dynamic_mem_support;
 };
 
 struct qmi_wlanfw_host_cap_resp_msg_v01 {
@@ -281,6 +283,8 @@ struct qmi_wlanfw_phy_cap_resp_msg_v01 {
 	u32 board_id;
 	u8 single_chip_mlo_support_valid;
 	u8 single_chip_mlo_support;
+	u8 dynamic_ddr_support_valid;
+	u8 dynamic_ddr_support;
 };
 
 #define QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN		54

base-commit: 83f028be15fe071efbee8e27837538d6cca77e87
-- 
2.34.1


