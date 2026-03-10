Return-Path: <linux-wireless+bounces-32911-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JMUAg49sGmohQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32911-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:47:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF9253E86
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 017A931D97AD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936F93101A5;
	Tue, 10 Mar 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ji5yva3h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dbHVj7Yn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB12749C1
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155779; cv=none; b=TFXmCh0ypiys/K2bnev+IuEHOk+9+ND3UI+goeECL0y+U3KgLy6JkenO6/oVWIcqokBqwq+9CMsvmGuljt9grJmGxGTTCOMpma4061qh4Jyi8tKS1DSgfU/UUuWaRCznUBMwkPVRVzwV1IvfRbFi6MdBPrTLQRG2tvNz9k+z8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155779; c=relaxed/simple;
	bh=BvcHCgk9YlRYwrsCyQQnh5kAYutdU9BmzBuH819OAws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BpRQaJtdsenDZNWKo6Z6TesD9WifXoEUBwty1BXDj29pf4yBNOaYqe19U2Lve7/pCGb3qP2r5MjcYJ217AQS8ULQD4aEvuCMDoEo45xxN/63r2DzGao07i9EI+Jgs3EWkKOP3Z61+JyIFfAZbW5/VxKSoderQiUK03v2WDTaTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ji5yva3h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dbHVj7Yn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaTtM1502932
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2OeWWoBlrn+hE57o5R4HFj
	P3760nChLdkyVHkv5+C6Y=; b=ji5yva3hyKNemHmtCY2/pi6hpnAdLwiB9mPTcr
	Q+7zSxCYLjg5/NyadbW8CX8EbVGbZMACwsB7QZCcy2d2L1gnPZrPg8FCoUZn00Vv
	IbdLbRtUnmbo42HZUyRyxpPMBuI0sj2oOJI5iMmmKRFYWLfklz85mTaFRKqpoNwY
	t8+GbqQbWbY0ygplYUbAUMB3YTyhEOsrW0P6eHkS+/vdGpWBgMHnyCjSv/wTklza
	UpM0PNY97Xbw8h29MJ8/Fet5/4EsNEP8GPpZsFMmuJrGEE5mbqAhjUDX4RmL72Yd
	TWB3RvBEcUR+6N3Zt3LXQpYI5n7yUhfOigV86drz/LWwEPiQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctdf8j3tq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:16:17 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d7543bc61cso16846621a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773155776; x=1773760576; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OeWWoBlrn+hE57o5R4HFjP3760nChLdkyVHkv5+C6Y=;
        b=dbHVj7YnNX9/K/8sJ2c5OzTXZ8lPUhnd9XGh4KTHrgTqU5/46T/JNErWyit4CSAgXu
         xyKon36wuWHHiDuXNUfJosTdsPopmxpXpd7Q52giZw9LVY58mwt82q1wtmxDwMcCUdFI
         ibbRKhrRega8nxcj+F2tpgAHHG7d1byFIU7UD5wDIw6ZIJ9ve91UiBYZOqpa0n52bgAu
         iTNS7i/eAssv6AuUx4lpaddOZTryz5AvSy38383b4WDfK/niudlWgvCBmJ9c76TOvEbZ
         p06+mdE1BONvf3sGNdkCCQv42Qx2Ue2BtbXMu2OyGWx3+kE5g6kNuO+7VNipENNXPVAp
         JmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155776; x=1773760576;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OeWWoBlrn+hE57o5R4HFjP3760nChLdkyVHkv5+C6Y=;
        b=kNGhf9gOwscxBdTtD1AwEcMqVMlXP0ApbD8xajHg2DawD1A9UMUtuO9KXfZWG8bjrq
         UUNOKMEjifdGWLZg0w3DKYIURqUUnCsa1y2oHTVcecs/DnR+pI9S+9iQoe65JKYiMTPD
         DIKbpl4pxV0xVLEyuZcvGgp080kw0iZ9KH0+uZEgEPt8JS6IDM3V/J8p+1HhTnBKdvEW
         TKoKsR2rjkpusK0/NNF52SrddECyAunrZb1KeDc8zWS54IXuVriHhi7G9WvbCS5BiMy9
         ADINtrYJb58t8rhfbjBssUTnGfFvN+0orVbq3qkTvdSRANmpEVMOaDHHlTDZn9WKglbh
         bJAA==
X-Gm-Message-State: AOJu0YxmRpNx78G+BIk9rD5OjPgSSc+5ZOtO7RWywt+CLc/MM3zwHuT1
	ReNt2FLRNzR73YqS2w2s3KSvXp/Mw/CfBMJWDqGe0w1GmMGvy3GCMFC2TAeSymKOQ6DOkhFRXRW
	YJreFT8sZTF1YQ0Z2gX+0lkJ5Sp41B+JzPRESExkPUC9JzGLM+lBxNa1Lsmn8zbri6+CaOAuE1A
	pudw==
X-Gm-Gg: ATEYQzzMv+oCIRlfrdb7oiEM8R8eW/rI6E1BwXRnh/KtK3ibv6p12DE5hojTpnLNv62
	59EP2WAyx9m6yQz02MOKymua/V0hbOC5aslia7KR4y2/Yjmely2wiAQa/M+g5ryDwUY5M5mYpcD
	Ucj+q3oDWZ6WvmzIup9vuh2ZXX7zuHKRNTQ31PaV63wXsrTbk3AtN24yC3oylguqf0nLzanOh/p
	6l6s0la6XU7/HIZE3/aZWPzey1gmVBE5E8eKSCKei/GRdZouvOSKlluQlpKJiF665J9QX5smMfJ
	F/1RXEndkCLFbKwmwFMNDapwyUhZya5mm3GweRfW9QhqkeFK9UKZXyTax+DMfIFjqWLNaZYKHcl
	CiDAh6SkdDOCidXIrbp44YELuqL5o3Th4SE2aFnDdchDkcebNmBEultYZZTeno6TWV1HzCuiB7N
	lR
X-Received: by 2002:a05:6870:e090:b0:417:23f2:6d6b with SMTP id 586e51a60fabf-41723f26f05mr5018717fac.52.1773155776332;
        Tue, 10 Mar 2026 08:16:16 -0700 (PDT)
X-Received: by 2002:a05:6870:e090:b0:417:23f2:6d6b with SMTP id 586e51a60fabf-41723f26f05mr5018704fac.52.1773155775807;
        Tue, 10 Mar 2026 08:16:15 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756dbc7afsm2714603fac.14.2026.03.10.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:16:15 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Clean up the WMI Unit Test
 functionality
Date: Tue, 10 Mar 2026 08:16:11 -0700
Message-Id: <20260310-ath12k-unit-test-cleanup-v1-0-03e3df56f903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALw1sGkC/3WNQQ6CMBREr0L+2k/aSquw8h6GRVO+0ggttoVgC
 He3IW7dTDKZvDcbRAqWIjTFBoEWG613ufBTAabX7klou9xBMKHYmUnUqefihbOzCRPFhGYg7eY
 J2UUJoeqrqesKMj4Fetj1UN8hU+hoTdDmpbcx+fA5Phd+7D+9+q9fODLMB6yS0lSSdTcfY/me9
 WD8OJY5oN33/Qv/OR5z0QAAAA==
X-Change-ID: 20260305-ath12k-unit-test-cleanup-07622698c994
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMiBTYWx0ZWRfX94126z0a/a4K
 P5k9CpzJNVCvYV4jvqC+Ntnl8o60BrMD1Q4y3cZZyuy+2xiXpEPGiGFqslFYAdoYwpaEw/QEMI1
 EPxId7+pJK6EmLbwRLC1DN/baaTok0ZSWeDCknjhLznyKBVSqnioZMnw6n8juw3c52D+wi1dDGp
 Nkh+F9ApQ1fNusOyHea3Po7KfrR5GUNHxtRGlKTEku/x61Vef53M3PUWistBlzIrcCnBN3tqA4G
 UB10nmRuYVpSHhJkEq7ts+aOfK3+f+9AQCeJmwJn7InL2lTuGZjPyEWs7t5i6TaNrYg3SQqxMHD
 51uMKPB1RtZv277PjNM1/TNx1v4hJut/AZNSzmq9e5J5YVioc81c56V/GDycLbHC4r9mtVWBcvp
 m1niHrleonD6ppdpufBG7Bbz5pt7FlUuXhhrfYQyLqGlI9gcbQ0Vc8IJElYqEGwF2UWVeLa6Xu4
 wlY0zi3YA+Q/qgdesPw==
X-Proofpoint-ORIG-GUID: u8u1pEJW9KdyNnb7yAEjtsbfeRow0OI8
X-Proofpoint-GUID: u8u1pEJW9KdyNnb7yAEjtsbfeRow0OI8
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=69b035c1 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=RTxW1uq26efjKX52IksA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100132
X-Rspamd-Queue-Id: BDBF9253E86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32911-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Patch 1 updates the core Unit Test functionality to address multiple
existing issues, and patch 2 removes unused DFS Unit Test definitions.

---
Jeff Johnson (2):
      wifi: ath12k: Clean up the WMI Unit Test command interface
      wifi: ath12k: Remove unused DFS Unit Test definitions

 drivers/net/wireless/ath/ath12k/wmi.c | 58 ++++++++++++++++-------------------
 drivers/net/wireless/ath/ath12k/wmi.h | 14 ++++++---
 2 files changed, 36 insertions(+), 36 deletions(-)
---
base-commit: 9942b3f80f4ebe6852663e0d35ecaf6b7a97c8da
change-id: 20260305-ath12k-unit-test-cleanup-07622698c994


