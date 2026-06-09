Return-Path: <linux-wireless+bounces-37554-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EykEAEO4J2pN1AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37554-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 08:52:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE165CF41
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 08:52:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GvS+AjLJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37554-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37554-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBBE6304C2D2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 06:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB2135F16C;
	Tue,  9 Jun 2026 06:49:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A442A82
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 06:49:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987748; cv=none; b=meUo+tkYN1LL3OkK/UZm9AmbLU7DMHYipwfLmE+7tgbL4uQbBC8oQq7zEnLwKYolRrVEvMxDkQ/krpnOlpGFUpHs1LTlQFqMMvBhlfeNezJjylA22SfFDRkgrcAuYTgH5Q46mFgHRtmaPWhGDOSXuVxzQz9OZK6DL21a308aNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987748; c=relaxed/simple;
	bh=ORaabT7Zdrhq564xBSp9xrgE3iuZbncCEoWfBX7j7qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PdJs/T2h3Le/5Kn0GtN4DB/6SNWN73GWzFbcAHH99kfmh3qAKl4WmLwh453bEGSxhxfhY9k6toifd7+MsLgia44RUoQENCotWGbHogz7TKEdUmpV3OJm9eiqE1EJPTs0W9syloH97IO/gMe/2ZxtvQblr06mb65uC/Q162p0BlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GvS+AjLJ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596HcJ41364848;
	Tue, 9 Jun 2026 06:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0o/Dwk5pYGi/rWQXSmQRzZfxUpMbhm6UghH
	6rGHnabU=; b=GvS+AjLJjcyaOpMH1o+F2Cu80UDLXmIjexSlznpcqvJ3rwxbTHq
	Ca0cZn/cSZqVkR9fgdPt+wsDVCEY4yxyHwck6qyEI7TNsIXc/vNBvqAryi1Qcna5
	16Vom7sW5Z6TqNPZszmusYfIh43acP0CEhD5Zzeg5Jp3O1CCO5P4Ok+Angz8YXAr
	YLC2eoIYYsmOSafHQq3kyZG0i3ywXqOAq0qGJc+ecH9OU+IKAanI/ApfrWnSIpXP
	Y8SiTPLGqxfFqwG+AxXVvX0R8mBzWPfEzh0Bl9Y8WQELhxGGarptVlQ9NyLprF7W
	kl6deNfFTKbs4Vx5ne8eqDCxF0p1kyBmRaw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdeer49f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 06:49:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6596mxRt031243;
	Tue, 9 Jun 2026 06:48:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4emcmj9c12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 06:48:59 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6596mxYw031229;
	Tue, 9 Jun 2026 06:48:59 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-sbutta-blr.qualcomm.com [10.190.109.146])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6596mxkr031224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 06:48:59 +0000 (GMT)
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4181700)
	id 5CE49413AA; Tue,  9 Jun 2026 12:18:58 +0530 (+0530)
From: Sushant Butta <sushant.butta@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sushant Butta <sushant.butta@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: correct monitor-mode RX metadata handling
Date: Tue,  9 Jun 2026 12:18:54 +0530
Message-Id: <20260609064856.547032-1-sushant.butta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=H+DrBeYi c=1 sm=1 tr=0 ts=6a27b75f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=J-3CPfT0p-nbuL7Fw-EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2MiBTYWx0ZWRfX94dnhKIcEW65
 WP/gxbhq/VtrV2dJi6d1dcifKqRJNXbqWMl+nGginI+pqXagWsxYcbPPlfo6cbfQhTOc7ickzvK
 zc9kIj8b2wzip6ul3gDdg+Dy/NtXvZglNVoEQuCObVW/iSp2JF9L26wu6I7oqMaw4wDlt+9s+yX
 gkvOTyfHyMNg/JPRMdq88svdqUFKDRA6kij4PBxWz32dVx/DsymMoZgYuOhetyeRpb8w/6uiXy5
 jZdhS90UR3KKVa0LHI48nwY+EEIfe2AWB0hoSd/XTVVGK9/yUSdZa8pK40hgh9TPSspqhJNzp1V
 jjVCUf+JphbGyo1TlyG8d61RbJgm18UlfNbLVWd23848p4udt6soYwJPf5sBaLzr87QrxBrDuy9
 3VJS3k92j9/Mm708fWxAnaif2JGTyRUNvFAjMCb+XRj3awC/RDJ/kW2kCM8g2FC01wbT7MPd/Ea
 RSDgbQJohG1MSKvgVhw==
X-Proofpoint-ORIG-GUID: MAAN9InCCX7J-lBs219VLGBVUGCywhzg
X-Proofpoint-GUID: MAAN9InCCX7J-lBs219VLGBVUGCywhzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37554-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:sushant.butta@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sushant.butta@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sushant.butta@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56BE165CF41

This series fixes monitor-mode meta data handling in ath12k and trims dead code:

Monitor mode delivers raw 802.11 frames should not set RX_FLAG_8023 flag,
and populate peer/link metadata in ieee80211_rx_status for monitor MSDUs.

Sushant Butta (2):
  wifi: ath12k: Skip setting RX_FLAG_8023 for Ethernet-II (DIX) frames
    in monitor mode
  wifi: ath12k: Skip peer link info update in rx_status for monitor
    MSDUs

 drivers/net/wireless/ath/ath12k/dp_mon.c      | 70 +------------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  4 +-
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    |  7 +-
 3 files changed, 4 insertions(+), 77 deletions(-)


base-commit: 38b2fb7d2df16f5801f7d88a4739942b95a5f6aa
-- 
2.34.1


