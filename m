Return-Path: <linux-wireless+bounces-31377-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJIXE2rLfGlAOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31377-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:16:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4DEBBF2A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14B4304DD4E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF04E37F10A;
	Fri, 30 Jan 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aauuBK87";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="avKebVzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED537C0FC
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786143; cv=none; b=CPBR7sM8XTXJsoR/Lan0KNAjVowL6bouhiHYyXffyI5vJ7jx2J6UBaMTsVJTfBHIQER6ZOHb29eHBAmyvu0e0cQLbDdC8gyuaig+Hp0qqllfG41cixQ2h1wuXL022hTgNvCmiIxP9SP5rKniWZdSSe7jthmYjrLZTTvOfp136Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786143; c=relaxed/simple;
	bh=+3EeeTci5maD5oxt+awJ3IJPq1TBl7SA5DAwgmUExmY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B7Xf5FjFn+faPNzxY+pLY3hwqq65OieXVuG0eEiO8BEOLftRxmoVmXNuF7t9bQsDKTN3qET0edc/Q2WF3zrSsNS4Fk8AXYvt2ik8fF0MeA98A6+tmQVeV+cAmVEqlpJs6O/RY6kd8wkkNlBYiu7rG245v/t0jeLpuAgzxnCFy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aauuBK87; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=avKebVzJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UF5Nbp2415234
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kBvbdI2G34GOfuAAi5s1uPoIgFs5fdLJlqnUnDwfYVg=; b=aauuBK87ukCUp1We
	ktljfUAqX0kr8RBmOTlfqMr65E/5prbhvInAdvhXbWRNBG6A4AjRjr6iPA7/W/++
	RohiBr7gZJCcmhdZXHrINUXw+kjxi90L/CdsWyKtXz+ACi4xJh8Ci1zaHMVY+Alg
	isp1uF3tvOBQOQoUBZDTHV2OzAmwZZ2kHp9oNU1NKk3GFjvHbwLi+1uh7+sdU6sH
	65V/nqe65WH2CUoPa/+C6nlBP5VzX2W14KwO0LZorV6YVddHMOpRiNrwlBcHK8UQ
	CvpJ8bUG0/aL+WwFOHb4nb71vuEFhBD5DPmeGNVt1OgRq3rlDIVyC8JRyV2en/ZY
	lYCL5g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0r41he2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:41 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12339eea50bso12836832c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786140; x=1770390940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBvbdI2G34GOfuAAi5s1uPoIgFs5fdLJlqnUnDwfYVg=;
        b=avKebVzJ8Cs6CnKEVm43KESELoDAFuR6syaJU5g65+MtK2YiGr0L4x14wYeUD4k0zH
         KhWZR5QN4ASeMaz+ccU18jVPDBF7cW65kxXog3VEQkTNAsD7jXWb+3NiFdwhmE3rn1rL
         RSagrDza4rqkr9lKaAQrTBomol2dIsB4O22ih3RTWXeifTbW0qkhN/BybrLx9AUcyqb3
         tOPP7geYCMY1AY+LcAgYhuQ1RXkuZaEgjXS2Vjryvfmljh1ot8K7e+CZVYhkbqrdCQ5X
         kUujocmcss7vSxxX/8MjxwleXLCqo5vaPZyQId6b/mIEBcqfqTochlHInuEKcx+xOxZ9
         XAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786140; x=1770390940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kBvbdI2G34GOfuAAi5s1uPoIgFs5fdLJlqnUnDwfYVg=;
        b=UfwzZlH8HEBrXYIU42RBff+dUk2aZTk/ng3iaC6Xj4mkmS0TkNCAoD24kAN9LjqJT0
         EoTbKvnkW+XpMmeHOv9wrK93xiV25Wr2CzPgucb9MpuJOwvSJ4kLbcLiEHOEjvH00Yy2
         qbkRTvC7JkJzEcIvGFYRnfaQhHVdBhocl8R3r/56nWUUc3GVDeCHWg4YUqCXnkFr0Fmz
         1PsYWlv4dDdmP2ig5ryNGm4D3tfk5jER5oGl5rGHisNHvU9qmKpqI7IHh/SX3e0NaU8t
         WSgtzQkvgNWoVzmE98Xjm3uDUTWMuKSGIPB05wuGbAN1iwIFC2UksAaseCWLegnrnQPp
         FaZw==
X-Forwarded-Encrypted: i=1; AJvYcCVg5wGmNS884B2M2jf57UPBN/ow6PtLljMLdoUWO+eU6Zpk6ehGu+TezJ0oKY3fEpKZLQz2ZsnH/wJNuzGogg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUNmJrWZe1gmYs6TY3A3wvtZh5l8Hh+EkR3iHjJP68utC3tYh
	tSUwwtbydhZ6jrCq1iXrtGI9oWhzQcUk4MUEtVstImR2WCVYcOBj5PET/8QV+S5xEhHet8cIzcW
	WFSTJts8XM8jusIe1IFqHzqWEQCSKtjQnWW8rK9R+OXHwWhEOTQVRbDtvnWL/Fs9PkBWsjA==
X-Gm-Gg: AZuq6aLTNLOhkrMrwhpsXX8DAdnIQ5tzYhpawYvuhm4EHX3nLzM//e2ERe32FB8ECkx
	ICju9ccwT3LVnwwXMLKQPNmQ2e2hD+e/Dgkf903sfvmX/dvid4ibnXl6A+9z4FTOWAFH65AgQa3
	ws+IQN2nLYQSNLRqoHwb+Se59eUmpg3SqEC+Q3qrrvNKhyQLL4xsPZLsYrHx2Jel05gvEc8JXPN
	0Dg11aOGEJ4R7C1WA880931+hjKgRFBZ+g7xPrsqwfF/cmKr/aV2D5MDO9496rL9VWulorUnV9Y
	kGm9GvYyfOBLK+0va1wb394Ete8uqAf1Xy5Wq/f867yfEmf94XT7guCS0gB7HP4A3v42jTndxe1
	VavuGh197oogHElhhbT50FLvXwBv3s7qIC+7AcKme3CC5tOvFrvrRBKHoRziR58RY
X-Received: by 2002:a05:7022:faa:b0:123:31dc:e8b5 with SMTP id a92af1059eb24-125c0f13fb7mr1559595c88.0.1769786140097;
        Fri, 30 Jan 2026 07:15:40 -0800 (PST)
X-Received: by 2002:a05:7022:faa:b0:123:31dc:e8b5 with SMTP id a92af1059eb24-125c0f13fb7mr1559577c88.0.1769786139432;
        Fri, 30 Jan 2026 07:15:39 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:38 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Wei Zhang <wei.zhang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
In-Reply-To: <20260123064817.364047-1-wei.zhang@oss.qualcomm.com>
References: <20260123064817.364047-1-wei.zhang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Add pdev-level OBSS PD
 configuration
Message-Id: <176978613866.3951544.11589420933593336710.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: NSzmnBohd5Qcxo7ivj9oXsA5r6Ln1-9I
X-Authority-Analysis: v=2.4 cv=W541lBWk c=1 sm=1 tr=0 ts=697ccb1d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=x-WexUlhkf1kDxQ1nFgA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: NSzmnBohd5Qcxo7ivj9oXsA5r6Ln1-9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfX1Mkl8YLplncq
 KavTtlz4bJo4SO8OPzHIggxDK5r60p3aYtOeLbK7ZkjYxEdfSAZlvR6W0bW5Kx6FvS5WA/pUmKU
 QNu0rtTH2p34Lr6Z8GYouZdnkR05ywVmiSdGhnlIfvf3qvrtq5sX82FvYljZchJ8ukpvSoG3AtZ
 z+FTVLfkEOch8E+MMlxT0yPF3eIhlCkq+gDOd4xoZUYZ6lgpOFOuxRhYvLPm7f1AR7grVyRts7b
 kDrwaepSq3euNszRIgVe8wUaLaowFcH+dYukslcEtKY+7iLPWTpNywM58PK7xUf3kHPh5O4Y31T
 ucCg3M7EQ/wnw5ZWuBtngiV12bmiFN4aPXYZor7ecN7NtQiY4ZOslLHeL83+1C0vWaXSv8KdU6O
 Pq4lyKABJnkEn/wxC/HB3qBrjQ9V/wOTi52Yt+ErE6Khxsv+WfOZR/hbH8gDkZwQlKJ5CmHDCb1
 GiVRZmUinWkTxRF3LpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31377-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC4DEBBF2A
X-Rspamd-Action: no action


On Thu, 22 Jan 2026 22:48:15 -0800, Wei Zhang wrote:
> This series introduces WMI support and AP-mode handling for HE Spatial
> Reuse in ath12k:
> 
> Patch 1 adds new WMI commands, TLV tags, and a service flag to configure
> SRG/non-SRG OBSS PD bitmaps (BSS color and partial BSSID) at the pdev
> level.
> Patch 2 switches AP mode to use the new pdev-level configuration path,
> programming OBSS PD thresholds, per-AC enablement, SR prohibit control,
> and SRG/non-SRG bitmaps based on mac80211 HE SPR parameters.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: add WMI support for spatial reuse parameter configuration
      commit: 6dbd496a170b62c7ac56a0cb3aaf170b3ecbb515
[2/2] wifi: ath12k: support OBSS PD configuration for AP mode
      commit: 7b789ea390457d5751ae5b1ede81ca8564a618d1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


