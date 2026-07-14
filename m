Return-Path: <linux-wireless+bounces-39099-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gajCCPp6VmpK6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39099-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:07:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C03757B84
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=fhlhpIaI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=IU+GDnU0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39099-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39099-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E7C6300E16E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701FE3C9EF4;
	Tue, 14 Jul 2026 18:07:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE532ED54
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052467; cv=none; b=kottV1jbn/x9RCqmm0bUa8T0nQwBTLbYBKrPv+Tud9iZmzuZdB3GasYhgFvcn0/dHHdyT5+Xv2fH5hrrvtTZikBVmd85+TwgHfYd3SwGq3rdQNMAaAfZigJ8IqcHbWHqFPZOktFpQj5w4Z5ipxd5L+6x9k1h+FSmuxaVODUdmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052467; c=relaxed/simple;
	bh=j5kBo+99AzsMaxCeN1heEqAJpozeTrWYUyKWRTNCmOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hA9FP3eTHZp0Cq/GqjV1GtyHeyq+sXFnN5llo1CTXrrDve293deoI3u6s9SSP6b5LaZ9ZH1+fP6YLfUuJz39bxESfHamHTpNKVbt6k8GupA5RouZBTfbrPrvGLTSFc0KafKETuVOcrRSyOeUvCR4XwtuVBnHU2/q1Mfy4RQ9nTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fhlhpIaI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IU+GDnU0; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EHAt6m1029440
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A4cwIiZjrWhhujr7Ycu1J4jI0XrF4W5pmiE7ofFwj3M=; b=fhlhpIaIPSgcfDVr
	OsCWFuugZwZ0A0s79OQbT3j9xVY3+szQnupMHU2QwLbRMBDU56S2ymXJMZ4ceil4
	mFsg3jrrAfSKwvOBJNA3V4d8v5k6HR5enHdPXVLA6hoLH2ba38H7v2KKLoj/Wpsi
	z9di22fX9QX+dhfwKvRNsjP3hT3rClj4fyA1Xr/WMNwm1QxZLmCX5mE7y6D3fbjB
	jv1AM8m+c1fMFvYq8ttwehKs5TfOeRZMku/x1/sXOm9UeFDWtMqn5y3Nh5yT348y
	d5awK4bYjJj/MEPYVvz9QNDv2CaSg3Yl+XyWqEJwuyoyGkore6UlDG+hNv2cHet7
	PeRxTg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9g06dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:07:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e4f946461so713075085a.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052464; x=1784657264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4cwIiZjrWhhujr7Ycu1J4jI0XrF4W5pmiE7ofFwj3M=;
        b=IU+GDnU0/vI3EktuhlL84m1sUmoMyJQTvWRlP8F7YhcICDLgj+esiVO+13ERFpggX2
         +2VH8FS9baXHRddnXs6nmPlCcgTsFkwx47gPkg+bxvumHxnHPTm5sOWop4eEqVGter3Z
         ko/cHBa7aPpeUDPAHuWxf/jAeL+8QywQrNlsT7Ftpfc63pBdUA6/G5WreUJqGBp8Q5qz
         jYftl4oxVMPSHaGdH129qXAD8gP2n1B21ZQpJA4UQOwY0rdnWfJtAuDom0D8QinQs/yy
         4g1CpAtJFBxPCthDIMOcIRJm7+RRgpW99t6aFnlEmwVTg4l2RdSvK2aFTvxW3c4DjOpL
         D9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052464; x=1784657264;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A4cwIiZjrWhhujr7Ycu1J4jI0XrF4W5pmiE7ofFwj3M=;
        b=SWPTbkCWafSL0MlFIX0h1UCQquFFBQ45YRX28rSFXnZNWRvRipW/kOt48yvjshUeQl
         zNnj2O1NPraT3qinnKcH2C6FEzej+Wj+7Ba4esZRToTBmhSI41Gs0DE9BKKuaNRuuo4M
         vJ8aR1pRwyqfhclcjnklJfa7f7FR/TDaihtHE7/jLiIKJCDoXM76c41X4yBZ5yaK+IJ/
         +iJr7Tnu3nvguYLd4fniNqNB3NRsAM385pIhIaWLkAJbR8W9d0ESbj2poY46KnQv+ZSN
         rgmV5WrO9VcaHAkyTM9NNWBSYAY/hznMehNQ8JrbQhTi6Zbz3U92bD8Zyyz2pAwO6AAn
         MNQw==
X-Gm-Message-State: AOJu0YyD2TlB6o9K0S2SNXkMBMPE9hdSUwwaCdSt1Ym99wEC2P8SZmEi
	umWmpKuubt/DdXXkdj4Zv9RXLrwxM5qBwsRXvzrgeAB47B2k/iPZfE3GkIsyOrHxeME8zsZ0HXh
	NGSaUu8gOfaJhJAf+1R2XPsSOMdHwGhb+PP4jzUAFQkHhzCE2XV7DHs1/UEWl1FWb76BJbQ==
X-Gm-Gg: AfdE7cniuFNSJADZvnt6w+MimCgCEKF/gGTD2PBWq4NdjbQbFKkI6X/hoU6EnbknJMP
	zw2CYCoPsT+tXO0/SRwCBbphu/YKqGgJEKi37f8al8KKLCmJUv7DBo8ZYRSAVu5rZtSyuWxDTkU
	w8VMPdTwcpmaV4qbhv5UjucUz04AK+VAKLTuCCUnO+bp69pHJFdeq6KUzF6Dg5y5Jk0SOwEnZfi
	7WpTp0upn3c3lAg4Fw5ItGINtIKzwcgisRG+8RSlXc1RZRTyHcH54bGNAyhMBIGtmTnLr2P+e+m
	rZ1m3bWCBrv+RUNj+kz35CMwWP1tcVv0+3TuqHJC7jQQXMNiyYeVP2Q7XFsEKpg8xA+SqyQpEkM
	FWEgJgTbJcgRW+d8sQWjEg6VHQhTWfWTfsqgYJ7y4okh4uqWiKu7FuYccSaU80KWD0A==
X-Received: by 2002:a05:620a:4623:b0:92f:40d:654a with SMTP id af79cd13be357-93083d8bcb0mr448751485a.68.1784052464281;
        Tue, 14 Jul 2026 11:07:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:92f:40d:654a with SMTP id af79cd13be357-93083d8bcb0mr448746585a.68.1784052463750;
        Tue, 14 Jul 2026 11:07:43 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:43 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
In-Reply-To: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
References: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: fix peer delete race in
 MLO scenario
Message-Id: <178405246269.4102418.5502186641350358668.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX5yFam/0RH8gj
 ewgJTklJ43+ZqCxnVJtA4MLh0YdFVCkPYcRh1bX/bqAAt2yCnMzdmPtrA920CpYv9qAa5w2s0If
 yDEdB8r0fW6+Bcu/TuqIhTEkNYDcNtM=
X-Proofpoint-ORIG-GUID: lAtuHfF6eTwSoiuZ-QPU7zHyfjWyGB3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX7VNIIYLj8ePk
 Ue9y6SvbOWSB8ZDkf211IsOiU0X6SCMNxOFoHoijZGvGi0tMa6WEoJQJiMt2Vk9BPFI84QTG7Ox
 eUrWnGu5+AeJ4qJGpPZJOKFOD2ufDUZr7yvvnA+2AGV+W47C8paHeCgueuKkKGwzYGWh1m6sHo5
 K3AywZoaQjK+hqxyz+y+EVQhrN2lYYCwWg/LmWW0B+pVtSMWY7oSRpWVopR8qcvU4rM5lP4GqoI
 C8PQUDoUQW6BLU3TpZOK2ywbTuyvKpYw1bIhl7SScoFklcksWlpJ4nvyfJL8X4oGAvrIXNZfNOL
 3MrCY8ZOTHA0HxRp2q1xIPA8rDPekru5pkrNpHk93+jLfogJN8t+NIE8a9L2oPBBs+3pP3htl2j
 8JnnXx8Xd3mPniS14h3a32sVxBW/ldbkqbcU8xqTCAAD5T3fkN+GWcqINIyDX79xzLq1SkKgB2v
 IwOjOQ+kK88BBOxA7gQ==
X-Proofpoint-GUID: lAtuHfF6eTwSoiuZ-QPU7zHyfjWyGB3q
X-Authority-Analysis: v=2.4 cv=VoATxe2n c=1 sm=1 tr=0 ts=6a567af0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=F5jKS3pZUGwt7ymI3AEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39099-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14C03757B84


On Mon, 29 Jun 2026 15:01:16 +0800, Baochen Qiang wrote:
> Patch 1 fixes a pre-existing UAF in ath12k_mac_vdev_create()'s
> err_peer_del rollback path.
> 
> Patch 2 fixes "Timeout in receiving peer delete response" on MLO
> disconnect, caused by a per-radio shared completion that gets
> clobbered between back-to-back WMI peer_delete sends.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: fix dp_link_peer dangling references on AP vdev rollback
      commit: f066e1a93703c5be0fd905109d00587541711c97
[2/2] wifi: ath12k: fix MLO peer delete race
      commit: 01cc0f59aac3574b6a7b02493a76bc8ed0aa758f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


