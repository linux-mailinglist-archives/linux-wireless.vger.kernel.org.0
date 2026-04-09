Return-Path: <linux-wireless+bounces-34552-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDHnLKHz12llVAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34552-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:44:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368B23CECDF
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 958E6300E5D0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E7364E8B;
	Thu,  9 Apr 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLitgAbH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nga81OMW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6E2C15B5
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760269; cv=none; b=et0OI8De28ReH88BEr5g/2fHtVCxLJs5WMs4yDZVjlmyhJa9TGn4BjOlbymQtDjphgF3tCdBAyQ2AyfROD3czIEWpYJ9qyQ5Q55X1jxqBjLl7AMFvfQuWBZnd2pGlHOFH33G1PlOuj6srZY722fYp86dKL25VRPrhsTNlK1dTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760269; c=relaxed/simple;
	bh=8Ud1lKx0ElWCqRyWANMiF+3rbxpay+Dv9DOOD0Voiug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fwABMlQVRrviBPD/uhNmzgVp3LUVWs2PLJzPR0nqHS8SMXpNlP3YU9OQJLrcr+h2sQI1jPEwgte9A+5NHF4bPQa11Frm65JogUz8OOpofS/8yhyoKk27YdG3jkFRZi2L9bO2gT1i2FTCSMLLAS5ydO/8tiM2sgN0SrtoDqNr9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLitgAbH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nga81OMW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639DdRi82812184
	for <linux-wireless@vger.kernel.org>; Thu, 9 Apr 2026 18:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=89pI+kXSa45NboUoHN4veK
	tx+cAShuGTWMwxJuwGRts=; b=hLitgAbHo8iQRwtW2Vc0Z6hVZzTYwBltkttz9+
	aMfHumeY46SCnhbemsyUZHtfRjQnK2/SuLGWi6OcAXAk7OyEbRW5yoLgkkkVQCbw
	VSavD78K/OQ+NTrJdvRMnEfWnzVhZQAmWOGaAREpqqJGgd3bGGmRkgNlSQC35wkU
	SRbWd77XAK/RytJWiXL0iexZMbhsw+XnSAXTKsych/FTgSPWggzw1m/BCEZ8LVYL
	q/ndwTTdJw0kUglwFNNXcqpxjFM7cqIqiZfk4bKIKOwVcLDX7KCChuoG18BP45PV
	eT/Z1Sb7FzcyLEqfw26hLg6CTfIQ2UeLCarMSz3Th5n2Pr9Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded6h94f5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 18:44:27 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1279caef718so11729020c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775760267; x=1776365067; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89pI+kXSa45NboUoHN4veKtx+cAShuGTWMwxJuwGRts=;
        b=Nga81OMW6AfrQP2FwIbzrfZZy8p2xDWKxRzqEFO/0wOfvEHPQcGxfwYXZ9m2tC6Z8t
         +29JrP15YKAjksPc2UvW6ptH1fZD3ljclpi7eXFjBqCOxkGKXLtIviIp3NS/7OcaUdwk
         /jl7tchIlb6SHboM92yVPQpAjJb8Quu7s8uz12jDA9K5eQd78RSh9loLIuNlr9Gw87Nt
         NYWsLainM2LBzltmBUYZ2KE/avj4wpQ3+HKRYWiHq+K5+sQJ49aimCur1u9EPBCBJJU6
         Q+hurWoK5DcKgj7nuJoVqPdAVux0lLn6PHkT/KvVT81cVtLAkoYuRyYhlVo+zuQxJ5Lk
         t25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760267; x=1776365067;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89pI+kXSa45NboUoHN4veKtx+cAShuGTWMwxJuwGRts=;
        b=sfuB24Z/tYJ/ugROjdem8cbsvQoM6oqzQPJzFk2szbDHGKYE4Bi1b2BMNB+ussocE+
         Yuk+n8taf6imZ7erOeMhQifxHZOt+0YW+XmB2LyqDTdo0LAYDz11rrEYCoP0ZQWa+vOm
         uHSGeeciAJZXVWjE+6DnOPH7fNw9+kM8dePeLT9b6jlhQELcoQYW9AlidfxxrqOiM7nm
         V0O2NX6yiuxIUx7iuvNOZy4yukqGuaJ8qCwKp6RsYpW48LyVcekw7MxtgyRX9oLvP2G2
         yUw/C0mz3qnf03fKJQXecZN+b2fnouq9gdQHnOIji+bzG79T27600F3pARZVoSS7tQVo
         tHzw==
X-Gm-Message-State: AOJu0Yzj9Ws182ZTmZ52VhzElkncD6NDNK5bufJMN5JrBDCIwPwYSIwk
	nL1CDTAN/NezeTeHzU06GVjN0gJnx8Mg8DFnuN9BwrdnPlpXd66ue2pVCaUZWsxZ1BZmyIWSFpw
	SuGQQYrqkTIn81ddbBmC5opAjqkYc2DiLkzVt7Yn76Xi88QdLDgoHz/8g0Gj/lJCHc4h0Mw==
X-Gm-Gg: AeBDiesmPautiz5N3dXina/d0nDRx1WTA/saEiS3BwwNx3N91bsUyzNKqAjYbgwkVHl
	ymRmsGhdBgJU8SrOg9bqJvAFT389UQuFiTogitjdVM2HPR6kthTHGJWunw4Wz1dQRHFesfYr70c
	sRdkj6QhSOQuSpQc1WvATFJLrXyuDomVXkJekOpwbBX0swesZosAqWhvIdKQA9inF/aS0EWN9F8
	6qzkLmzl7yAK6ZHiEZEGxeS93VIFVCJ3M7SV+rkaa9qs75QnEllK73OzGuZFj+8Xv+A8kX3nMM6
	LYsk/X6OnLNuOEl1GwqQNCMHdrSMmcqrqWTIU4mSpQ0XisPy9gL7rigPS8h7AENRWXTZINLVDck
	FBiqmo+UKAlU07rq6TgdkopqdZQWr5VCB1v+FDfF0HFaEZTxe+mT4/tKJKQNZdwZwGG7xw2kn5q
	wa
X-Received: by 2002:a05:7022:4387:b0:123:3500:b688 with SMTP id a92af1059eb24-12c34edcfd7mr108249c88.19.1775760266493;
        Thu, 09 Apr 2026 11:44:26 -0700 (PDT)
X-Received: by 2002:a05:7022:4387:b0:123:3500:b688 with SMTP id a92af1059eb24-12c34edcfd7mr108226c88.19.1775760265941;
        Thu, 09 Apr 2026 11:44:25 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm513985c88.0.2026.04.09.11.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:44:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Consistently name struct
 ath12k_base pointers
Date: Thu, 09 Apr 2026 11:44:22 -0700
Message-Id: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbz12kC/23NQQ7CIBAF0Ks0rKUBCo248h7GBYWpEG2pgE1N0
 7tLiAsTu5nk58+8WVGE4CCiU7WiALOLzo850EOFtFXjDbAzOSNGWEs4abBKlrI7tknjKfjksdR
 Gy5b2jTQa5bMpQO+WQl5Q3sYjLAldc2NdTD68y6+Zlv7L8n92pphgLqFpoBNUGH72MdbPl3poP
 wx1HsWc2a8jdhyWHSWhk0ww0+rjjrNt2wcETH+FCQEAAA==
X-Change-ID: 20260403-ath12k-htc-proto-9cdc961f39dc
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=RfCgzVtv c=1 sm=1 tr=0 ts=69d7f38b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=Z1KRubcUBZuEHTMtPaIA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Cq6Bl8bg2LFKcgma4DdgdMnF8v7503z1
X-Proofpoint-ORIG-GUID: Cq6Bl8bg2LFKcgma4DdgdMnF8v7503z1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MSBTYWx0ZWRfXyL883g9zJbRE
 Ju4Ljo+CudGcTFVrI7LG87I8p4K40tcLOEVD8Y5kUa1jisetGKyehbWjiHX5lVgoJ51w3nchASR
 bbU69AZJa3y33rzUPR2dtD7jVoV5L5pmqy4YQhrTNmywpc5o9PzMc5rFYwjL2xbd4eDl8VKv9m3
 kLApWwZ0TAgj4g72+lisaclaIYUTngCm1282FQXJEGJMBQYSeljKKck5bCL30fP9CKSpAxvEe5k
 9ZkhdmlIIfy2FbPrNyh/lReLJeEKXp5k+t4rYUO1BQ0b8RKJ5EpIVGYevh84mnIllX9hW0gkN+Z
 3s0/r5TxGSgJ6vuatGlUCTX5vHrKzPfZT+heV9fQjj7FbOpKPleGqlUHagIBhJ6bLYViFz3JvM8
 6RUC4GLIr0CSoiBvX7Dnj0VlswlYhhUki8Sua2q4itWx8HgaA4S34DA8mGvTDnN/2NYxKscS0XB
 FuuXdoPU8BH5r4wjEow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090171
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34552-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 368B23CECDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Per ath12k convention, a pointer to struct ath12k_base should be named
'ab', but there are a few places it is named 'ar', so fix them.

Note that one instance in ath12k_wmi_tlv_parse() is not modified since
that instance is being removed as part of:

https://patch.msgid.link/20260407095426.3285574-1-nico.escande@gmail.com/

---
Jeff Johnson (2):
      wifi: ath12k: Fix HTC prototype ath12k_base parameters
      wifi: ath12k: Fix ath12k_dp_htt_tlv_iter()'s iter() signature

 drivers/net/wireless/ath/ath12k/dp_htt.c | 2 +-
 drivers/net/wireless/ath/ath12k/dp_htt.h | 2 +-
 drivers/net/wireless/ath/ath12k/htc.h    | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
change-id: 20260403-ath12k-htc-proto-9cdc961f39dc


