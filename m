Return-Path: <linux-wireless+bounces-36287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IM1G1CxAmonvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:49:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9242519A7F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 06:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6151302516C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10F2C3257;
	Tue, 12 May 2026 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IuTmsgVL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fp419KCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDB2C21F2
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561357; cv=none; b=TiFqXESypQh0MH0FraP/qYdFTWQ7TeVSjTNv3ImQcBt0LdPE7BdyFaLrRy5l+aGg3fgM/AR71RUpQfdPvn+kzLPYfyYmbEXTRjAYLzqNMCqO5uoYpkzwQ3jEO9Lj98iuUHJ4cK2MRrYF7lTnXsHlRdtnR5aovs1G+HkospBah6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561357; c=relaxed/simple;
	bh=FBmut5npg4s4ETQF7AKszdVuJ/TKr9w3qW2XrxuPKKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hn0Zcw6BuIT5EU0ZNh1uW9kKD0QISuWOKgJHSYGwOgwn9Byv4c2rCEY6fG032sRQRZQGznGvyLzGZ1kezEt/hiq/9elOIwgAiHAlZOhRl/F6xem+hlmD9TK743QeoXkf2XtaBBJAIAAvpXrATn1YTUpCH2vdhFHUeGGVamJMfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IuTmsgVL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fp419KCV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6OCm1183940
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mHl7ymRRDRRCpw1X3DdWS0B92buiELgNhVr
	2GCgQ7XQ=; b=IuTmsgVLRTBuwG/NZ10a8ErPvEdLGXpR6gLAKm0Jjzj5W1cRUnG
	+EslD/mgibUyA/SQqUWkgQvCna7+zO+oxadMQ2DOt5qMoUKHesk+d8SEQe2KNhko
	rXrxo2G1CyL4jieuHCIYJf+GHHJvLIbTePZwSsVG40Do/uo6AFy3y2BXSa+qF9mh
	PGHuZaJNsmIr0Xg5yJD5Juy01w1IKIv4zlk5kQsiIiLiy8oldUu/opKp6X2xHy09
	4k9TkIVfcM2zLupt03SC5vOEj2LSmKbYW2/0ohUINLGB3EWbA9U6YtrtNX8Sibp8
	TDnmM60JVa6SjkFn1MMhz/rwMvRY4Tpt3ig==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuy9gd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 04:49:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so8212398eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 21:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778561355; x=1779166155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHl7ymRRDRRCpw1X3DdWS0B92buiELgNhVr2GCgQ7XQ=;
        b=fp419KCVZGYsccxr+Jq3h5sa2203eVOWIOfyz08ag9YSo/ImQPZmjC59nX7byeagSn
         9FMXK0lSngSvrQA8eQIGNDaN0pLMKddZrEXA0GpTot5vnFnSbYjq/mAlptgGdDmNuSF4
         SHvM+WlKZS0c3MZJ4prkkhN9u198flptQ4TAuBUbTYod97v77++ECOsBu1PNGVR1akPh
         Ux33IMGuCYG8GivZd5xwBOekWuIAgiseOI2OoXZPP1txwSw13qYNKTNX84PTIUxlmBA8
         OfgdPNN38QoAkgQzfY5TyJbjKcMJUWFrA5xGv/fJcfs7itPm0xrOhnWkQm71lQpau7h8
         YX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778561355; x=1779166155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHl7ymRRDRRCpw1X3DdWS0B92buiELgNhVr2GCgQ7XQ=;
        b=jsBiTatGEMlRUWNLGHXN8drOS+hAELfSBXDNutagOCve44QnRVv5qn1pHO/6iWylPm
         iBqQD1Ab6dbNgPIEYWxeTYkbKESgXFaWD4rlzYWsKCtfwHwwLMmP5EW2uJK9Lfa8Sq8R
         umZF1hYUbdp5C1VMkvHp4McSmj2KkHxINFJ/XcRHbskv3t/cDqqcPcroq9MU2MYZfmCC
         EJM3mslNuoCPHB/sOTJweAZlAGTImt5eIwzxuQbrKjGUdhrNX3cJdejnbXkaDRmLqRiF
         sp4AaNv0xzFwJ4iGErGaYqMEweEFfWk3xaSBrvsb4gxEdD1DgNDn16X3E/FD6Cy40bYU
         6itA==
X-Forwarded-Encrypted: i=1; AFNElJ9M0O2rIhCxoFDJ5SqeZn58FfdGr1mE0TyI6kH04dBFa/eZISaemeFriUU3O9v+mAxwHUyFHg4mCB1nsbH7Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQXIbaNMhzbtZ8MTDRdCOOebTHouMjhD7v1O3JvEMWA2LoH1v
	2RUvRdiMEPIE3ORo8PQ98yk/9nl3I8LnxTxwrsl0eNkby0fh+pWwqpUjdDxfSBsZNZfLZnEKm0h
	dvn0f4toZ224nDtxPuSjSSjgP/gQFEIWvYptvWjMapu5Xur5JBt5A7Yygul3Y2uHq+bPlYA==
X-Gm-Gg: Acq92OExyTiCvigZ+CHcMiXg0F8upMbGymdHhrucLfPRO9NiSx2sCCc0JYZ4skZ5ZIR
	rx3DQ5+eoFnc5WMnn4pBvuX5QAU9kK3cxft/Pq8L3EhGu6Ztkoi5zKQ43g7ZFbs4nPScHSRuwwG
	YeDO8fQkgN6uENhwyMbWONeHA1NVG95UIqrdVqtzFoZrfwWQggSi5MclrapTKaaEjvvo9SKnJKm
	Rf7WVHmjl8leuCxdz93KWCtcI+p2iOVDIFs9Mv9NfIAkmrivmK96FFTPxJ0ct7Ov9dWR+KNOL22
	aYyiJDT8fqs5R1ixZu5tAYYR76crehVNzpF6yUYLXJV3M6+r3k5IN1IaqdzAVX2uelMF1FKtNgU
	PxHk8ZS6sqpMWjafaJkgj6z/EymZRDJGoZ+YTpzTyVeMK/CjCImPr6qnt7poy1j7MIkSmvKh4lr
	0sCQ==
X-Received: by 2002:a05:7301:9f03:b0:2f3:a348:a2db with SMTP id 5a478bee46e88-2f54c280b01mr13358611eec.10.1778561355041;
        Mon, 11 May 2026 21:49:15 -0700 (PDT)
X-Received: by 2002:a05:7301:9f03:b0:2f3:a348:a2db with SMTP id 5a478bee46e88-2f54c280b01mr13358600eec.10.1778561354518;
        Mon, 11 May 2026 21:49:14 -0700 (PDT)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d43b4sm16032926eec.11.2026.05.11.21.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 21:49:14 -0700 (PDT)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next 0/2] wifi: ath12k: fix NULL deref when MLO link activation fails
Date: Mon, 11 May 2026 21:49:03 -0700
Message-ID: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GeamLUjBsjX3ZIretG0dcj3LSYAY80rF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA0MSBTYWx0ZWRfX3eVHrX8dHX3M
 5L4LGKMiF9Vi/GzSJMEajw4+Dm5OjhmiVMxG+c6sE6M+0WrTTMpiFLb8fXtyzjn8vi4EJtf48Kg
 X+dzL1mjSkI8KBrNH7WLg6RZKXwrN99He8JNwcHf0XRW16j6LU0mRi9LGgPgVmPwy+dFFYJOLeG
 cnuH/STjlIrqNATGrMrKROQqxOT9TMRuDpdPlQq7TODxa8r5hgHSbP+MLTlsjZZEJNEZ2DKfJxe
 q0YAOHW+OLQf7xuf54UH1sP0h40vFDsA86UNiFZSKLCWlaBH76ri7BuTX5DPijD3gWak730Q0tl
 yIIeb5NYUkVs56xo+EH5vYwD9VHBOix/RGIbzvdKvvDM0KGHXy53D390r9jxx0bXCAMJfyyCRHh
 rpnIA5RYNoqGNVvez/+LXU0CgY0BDvFQj/ee9VznAaYjgLPRFk2VscBQnWBJ9GbisltYjS5cuMn
 CXIN7biPxgdwx1J3OKQ==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a02b14b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=AAKCvc--jUWDOs3SvV8A:9
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: GeamLUjBsjX3ZIretG0dcj3LSYAY80rF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120041
X-Rspamd-Queue-Id: C9242519A7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36287-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

ath12k_mac_op_change_sta_links() adds a link to ahsta->links_map
before verifying that the link's vdev is ready, allowing broken links
to be processed by subsequent operations and causing NULL dereferences.

Patch 1 fixes three error path inconsistencies in ath12k_mac_vdev_create()
that leave arvif state or vdev resources inconsistent: a direct return on
wmi_vdev_create failure bypasses err: which clears arvif->ar; and both
failure paths in err_peer_del skip the DP peer cleanup and vdev rollback.

Patch 2 uses arvif->is_created (made reliable by patch 1) to guard
against links with no vdev before allocating a link station, preventing
broken links from entering links_map.

Wei Zhang (2):
  wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
  wifi: ath12k: fix NULL deref in change_sta_links for unready link

 drivers/net/wireless/ath/ath12k/mac.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

base-commit: 7b25796f571fc09a7aa6fe7efb23edccd326917d
-- 
2.34.1


