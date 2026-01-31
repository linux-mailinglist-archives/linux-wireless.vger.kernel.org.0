Return-Path: <linux-wireless+bounces-31417-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBlMG8ujfWkETAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31417-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 07:40:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591AC0FAE
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 07:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3B343003704
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E93093C1;
	Sat, 31 Jan 2026 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqe1TvuT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jlwEXv7W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0052DB7AD
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841605; cv=none; b=dLfA065/3ibLODCM6lzy/IQYF383jq++ie/PtbUQgnMDrTj/QeL5bZj2vaOeXbyiX3jL3lXSvZgQRxDULHTJJA37Mc152eV6oSi0Thfzy0A37AZ1Gb/nN9FdYiXzzfAeYfuAhM7G6z0ZZTWciSEGCgO1zmf5t3vyLZd4cjQzsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841605; c=relaxed/simple;
	bh=8vJfCl4Wb+I5m0XQZ3032LmP4vlsjPEeVAkUXsI5DYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgJYG1KW9hnvviubuHCWtrv63QePsnOGGsfP4zFM7c26eVf6GE+teXcwIziYch1MoTWBcxco4dexu6779Qx7kR+zwqWIDDCibgBnhr9yXc4a/m8D5hvzsHJQKErrXfkYg7wLfWD+6cAoIfHtbhat+sVmCJNukWj5Z3rTYIqRCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gqe1TvuT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jlwEXv7W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4U0Oa447021
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 06:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zfLFnX/pj06+42VOeKs579fA
	r4gQfJugqfCbVka7R48=; b=gqe1TvuTQykpAnbs5syhyV19Zb0JB4DvSwyMCrZ1
	rXFdenj1qvete+UFM6GVhAF+ZGfa3lT0a2MxDs/bgjDM+FNN88BVqwFf3CsWVHmB
	Y57Rmn8/QONQhuLFez1LyzSnZYKngkJPMRQxgigpHjWJCnsdNqPoL5yhGSur58eB
	9d1bKnId1uQfRwR2iZbBOZ+T1gR3/EGdBBUsPs9hC/BQKWmL3rb0AaqDeDIKT/zj
	8Jq80h2yHDSudSYnPzQ/bXTZmvfGRk8+gjLj8XPpoj6+ckV2kX2H0lCRCCVQFExh
	P8YhLPBZTVrQXwKjfMq3GTiiZvHV7bChU/87fDDnRvuA9w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrr943-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 06:40:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70ab7f67fso1196767785a.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 22:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769841602; x=1770446402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zfLFnX/pj06+42VOeKs579fAr4gQfJugqfCbVka7R48=;
        b=jlwEXv7Wfjv/2wdqGj2EdvatgK1O2qxSmWxpqmuIwQqzh65zPBVKbWbWi2yIr9SLXk
         WT59Lc+0aD6+h/IM/Qf6JHM11uqE8WJjNIZRlvI9v/fzzVG0C6a0L3LuAZbvcd++EmYu
         O4YDIdvLSqFHE/XJPy5glh1bg2C65RNMjlqUXMA9Sy3eNBWt1n8EhJts9549CFnfPYGp
         bkoB2h/hCiCDSiiLdMp/OYsZ+Ik8f++kgdqa3u5Affqid7BJmjvKfDlYmtRCnvYGyG36
         Y9d+vu0kRa9oU7eVfejtE3YG1BC1Jot2I9pl5ZJ6ReEirz//GAJF/ShzHtZKm+B6KgPs
         VYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769841602; x=1770446402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfLFnX/pj06+42VOeKs579fAr4gQfJugqfCbVka7R48=;
        b=I7wTiXh7oG5XqBuRKsIK/j9WTM59edzNQErMv7kJru/DUBuJXsk5xvNs3CUc++LGsp
         OTH6V976letVhv0H6JA4h3woBsO7m3L3IwgyEIY+T2c8hrwMOc1d+ugWL3ypJB8rzLpg
         UD+llevg8S6U2jeF6KN0PIJtu0jkK1nSnYXTGklhDvTPpqVvb3OlyMu8SZOSYvygWmYf
         RebC51qu6sdFfJk4zKIe5UxxFNjU0ecwVPZwujINNZxKjcVPtsDIV943e+jwgLky5jyE
         Meu7UhUrGBoYO9LdFquAYNnpQb9jmfJa+2ueeQIgfaBeaBRPkAy6a8ok6uy1qZBTpgzl
         7img==
X-Forwarded-Encrypted: i=1; AJvYcCXY6tJTbRNHG2bSdzqVW6aHhRdUy/WYb0JOfJxi9zCcWLwXbijk0O6dPM0t/Q+eAvTRkoJ5g0irtzEpztwH7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnL2qBegfN5GqeIOegsDSJlPTgaBC8CckguCiPHC74lEJdlWdk
	+uh3WOmUPJS72LwzTECI9NoOmZcCluPO13yPBFDo98PIKfc+XNPOyU+K+Z2bq+12nZfIUetUPH6
	o4o6ei8l6z0rtE3sdHYy9dI/U9e/WhQ3Gfuxjih++Y7bM8lz+M175HEglTXkf+q13NjuatA==
X-Gm-Gg: AZuq6aI7uPD340+pAuV1zt/BqfHRYvTS3bDaFkVdBV8CHwO2fum1EOeJy2FgTHgHjcn
	A0GAMbe1ZcHqYksEX4UNaGXyfsTBwerbD8d2+mh/kB5mA6WWOzp8V6je7qeq4OK1fY36HJj/fWt
	ZkA19GZR6KIEP4XBUiBEexb3FbOK+jIEE9z3BRFuTOMrveGxcaEbKWtrTFOo2OohGPbtQLGmFGR
	55CjGzcxZAzFs1xd+OdfYx1eKkZj3GG+pkLv6V1hk8C3+U0g7N2LaRb9MzHuCj8EO5aeKaoiw8W
	OY5a64o6CnPy2rU29d8FPSLugwenGHfHA6QCbRtKdi9AjyCiwE1pzvkggm4+xkrwxsKrJpJhW6V
	gQjIsN4Qx2+TUb8zQmtdBK5zSkDcjTl1FgLUgn6vik+QJcYY/r/A23mFNxiPKK61huqk7eQdbNy
	qUXFLqi3dgzsKFYgdg9r2phG4=
X-Received: by 2002:a05:620a:f10:b0:8c7:10cc:758e with SMTP id af79cd13be357-8c9eb2d3ca0mr723604285a.45.1769841601707;
        Fri, 30 Jan 2026 22:40:01 -0800 (PST)
X-Received: by 2002:a05:620a:f10:b0:8c7:10cc:758e with SMTP id af79cd13be357-8c9eb2d3ca0mr723602685a.45.1769841601226;
        Fri, 30 Jan 2026 22:40:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625c621basm18212161fa.13.2026.01.30.22.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 22:40:00 -0800 (PST)
Date: Sat, 31 Jan 2026 08:39:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: Re: [PULL linux-firmware] ath10k, ath11k and ath12k firmware
 ath-20260130
Message-ID: <34lnv35rbicqk6duyqhhidunulcipttsj6ryvzw6embgablnpl@gh3wtsknmcma>
References: <ecf412bd-7bd3-42ed-bea4-d7aa837ddcae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf412bd-7bd3-42ed-bea4-d7aa837ddcae@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: F1Bq15itnIuNIxZ_qqeJahyQTOEf9pZp
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=697da3c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gcp-Y-p2_AVPb3T4FLMA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDA1MyBTYWx0ZWRfXyS6sFCW8AqBu
 lb2A8pkF0IwhPNRYgc9GSMD/d5+L2Bj71iWkRUJ4NlLVT5TJgwvSVuIZDHMWj0OwYR/r7qArBXY
 HnPBV1VKR1OL3FzTNRp3topiJQU/XHmF4J3n3MHraQCAcvsHH/J2u+gkhrm2kHJZ5QG2yWlnYMN
 jQIk4xiUlguM7hLc9okaOmD9g0W6zglMdDV/QoJgpElBnyg55Jek5CE6wn8zrvhwnC0xQDAgHp/
 7SwBa6lt4WHz8EfeJWazPtYYhZ6cbebXV3S9g/wNtJNfKlxnXC4AsdhuT+dNXY7p8BP9gP1+aqN
 FwtdjxjWwZVLGI3HFb1NXzskIBtQ+qCa8qqAWMt0ryVuPdBAbd9rurQoQICPrKJN8ZIfHb6gief
 s+9e0KPqDR7+F6camWDU0iNWsO5LeWO8qF+cf7u9qAA317Nh0zp5IKmVlm4eQDL+FQCguLG0iaB
 rUsbsLp/hCxIkHke3ag==
X-Proofpoint-GUID: F1Bq15itnIuNIxZ_qqeJahyQTOEf9pZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310053
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31417-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8591AC0FAE
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:29:48PM -0800, Jeff Johnson wrote:
> Hi,
> Here's a new pull request for ath10k, ath11k and ath12k.
> 
> For ath12k:
> 
> Update firmware for QCN9274/hw2.0.
> 
> Update board file for WCN7850/hw2.0 to support:
> bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8001,qmi-chip-id=2,qmi-board-id=255
> bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8004,qmi-chip-id=2,qmi-board-id=255

These two were not a part of the previous upload, but... They again have
board-id of 255 (unprogrammed). Why is there no calibration variant?

> 
> 
> Please let me know if there are any problems.

-- 
With best wishes
Dmitry

