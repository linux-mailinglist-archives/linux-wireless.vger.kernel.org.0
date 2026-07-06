Return-Path: <linux-wireless+bounces-38640-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oQhhI80FS2oZLAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38640-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 03:33:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E60ED70BED8
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 03:33:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ddyRh7dR;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VCMOSBDH;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38640-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38640-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C608300765E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 01:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55A23395D;
	Mon,  6 Jul 2026 01:32:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BF169AD2
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 01:32:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783301577; cv=none; b=fhnFG20aVH9oqoIBTJfWEL7+E7wpgwYSMNyxWidm1wLNzBhjsENrWzSAtnYdORya42WbXpVB5Hg7Mf5PbsKWNo26p3VtWyjfBaJTCis84GiVEFJHRBFvQMUVtD8vG1NYqV8MQjbPbRrYnPE9OCsXZuyUR9LdpdLNnVBNAm1egXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783301577; c=relaxed/simple;
	bh=lRhq4R2qsJNTbmvmcgKeq8yVotOnTD6W4J9fcameIgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+3bK2VKZ0xVSWrqR+e8QqjzS5Qac9F6jnklBgRHPJlR02JoljOdvEdY9woO6ZqLAc1pnudS9iI+O8XVZNv9pGf4kDHY8WAy866B4WmEwqSI6PK7zzJ5DIsy9rQkmSEo3M2l0LV8jL7uz8ikfTziycyk1coRaJnjR9cfpZKvsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddyRh7dR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VCMOSBDH; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665LxQsg2840724
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jul 2026 01:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GHdfImx1yTltlv7sKfVOJsO/J23lJUnb8b4imCz9Wy8=; b=ddyRh7dRycdLq5GY
	TuSTkI1GMFedej8uY3HiYBNBdjOPVDFoZ1JeLeHJ05yGfNP/mzC51QCgSkWXLaAY
	kLFfgFZ/a8Xk6Nd7LIzSkJV+opil9mW0alUI6h73WYrpaveBxl4p7XFaxy/6wyh7
	3OiPA+TVc/8qKmy2PdEuTrDKMY165Q+m9tP1cLuVIVcb0FbsoVOCdt0f2Z9wzkOS
	5vQapML1qZMj1EL5B1cP/U6LDFZ04unYKypXkFTyfgHXR3lJNBJMxhRKm97K587f
	ekYxsKFCU5Tq8OEjFWbOnjlr0zUxY1FCEvG5i7IQLu864oPWid5W8kRHQDQW+T5P
	m1zasA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh3xwd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 01:32:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8479586724eso1926478b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 18:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783301574; x=1783906374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GHdfImx1yTltlv7sKfVOJsO/J23lJUnb8b4imCz9Wy8=;
        b=VCMOSBDHTy4jX9LcDgCb263clL9C/O4PGGcUByqx6rvhm6787XoZiwFW2++Yglexpq
         zFbtYO6PpRZM5wENUfM/1yxU93h1/P9UpQgpCFgcrkowbeNGyjnboGHiXGYjpTZ0OB3N
         7Cf83ih+7Hshu4WWHLe6RzMarlDUhVrKzwesqsXLYcxjFq3x8fZjYkUk9JgsO4w4gkml
         p54Bp7/3hEYtX73uqmmg/6nSsANug4ZAnoY3Nhfnw99AgyRfCjYutYXdCA3HxuDLC1lx
         i1MK4J11OoLPNnsYouo1hqdE5F/qX2qejCjZldEG7NFpdI279yb0RjZAoyFdL1kCCR0M
         vgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783301574; x=1783906374;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHdfImx1yTltlv7sKfVOJsO/J23lJUnb8b4imCz9Wy8=;
        b=SQVZy4z7ePImEQ912elhs2L/ALmQpQOx/NSO4Yq+EtMXQnc9wjmNEsfkS/h69SJ0Q8
         rkkV0ZPswL7MLJNgNJrgLkHIFF2UKFfj5og6aK8c7N5evIsam/38JcpHOGczvx7/57yY
         qXdMU5uARiPadoRrxNZ1NH29qyAdI0jfTHdzitIRCW3GKxxAf1/kwqRnRmLEvqiNXmeH
         2AIJS0kFHgH6mRMmzZgKQioZxBRRC5Apaw5XuolkhrQ50c1ykpPVVpAH/ogCRrgCDLEG
         iinl/OnBg6cdYwI7NlL7Cfc8MC8z3p8WxhQ2We9B9iYkevLYLEsh4rDt2tcBJQNhUBwd
         3V3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrVLuPGYqd7gnqUYQn3rHSCuxaoJrL7ng/DR3jYwmqTFzF3rkXvRs2PaZQp+KFhKeDZvfnnOzYQ483k0rRvJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpT6fzwQtgVvkxe3dG+NU1BMzOCAPcxDlVgLJPSO7qTMA6Zrv
	pa/10nDIwzzhGMfDXYQXCD0riZb2Gu3xlbi9h76ChgnqzqOmgw498/pHH0S3mJfjv1NEp1oJ/2V
	6z+MCppV0zpTF3KvX+S/x5VPJU1OH+zToxLpE10PsoLfpAuZ3ZwVbbAc9W/+PDatmnRo1xdqOW4
	VTgil6
X-Gm-Gg: AfdE7cl1/M+LaDkjfy3bxaa4Yg3YOCdpKvtHksFrQ8QTPtMTCUzT546dHsNEGdP+nf5
	23jQsmsaYfUIAzRMIqI+REd1JZV3IT/5fEqUlSyZpsGW9TBnf2FD3IOiTrOZvPJKMkGI4d81vtf
	Ug6xLhifAkd+XlQuvFJJGSB6PjRjfIcHd/HStbTQk1Vc/9br7MfXWqmWoR+xRgaGa7cLwId17N8
	ana1Ve9E9BiZDyfqZBRQNJjyp5+jbEqQX0zPNMV0VNzVdAsBPxzSn4h/i0KY4xBcosP7F3nukCK
	Q13sUy2DfmwlVLGyiieWXSvFZpFde/EX9tNNUUgZFoLwkCstsTCcDGbhUIOtos1MUoctUS503dA
	8hkGMirB7qezd1A9dZZtahPs1k/hOirYpkhmtkHx4d6hdtAdPEQUU1SbnHM0VnOs6x1MbK6q/gN
	50BDyG79H4
X-Received: by 2002:a05:6a00:1303:b0:845:d4f0:98c6 with SMTP id d2e1a72fcca58-847f6d66480mr6892996b3a.4.1783301573613;
        Sun, 05 Jul 2026 18:32:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:1303:b0:845:d4f0:98c6 with SMTP id d2e1a72fcca58-847f6d66480mr6892983b3a.4.1783301573124;
        Sun, 05 Jul 2026 18:32:53 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm2916220b3a.7.2026.07.05.18.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 18:32:52 -0700 (PDT)
Message-ID: <0ade08f0-05cf-4c30-ae81-3748fe6ffaf6@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 09:32:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix ML-STA authentication timeout
 on QCC2072
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260704073000.3300099-1-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260704073000.3300099-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4b05c7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=J60ckWpfDA7ZE0iGEaUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDAxMyBTYWx0ZWRfX8r4gk5dksjGd
 290SHaAawHQefAHs8ZwxQaIcol/ehfIWLvM+p5fB5fVVK6FYBA4Tfne3E8uRBDDXRCHnenQvAty
 mCOD4v9KoHI3X7gZrNf1bLESmsWIfDhM1kPkhKWGqfYyqj+EU5x1KRJMOUFripSI2hZTSNrAhko
 DAV8HbPagclIM+1xj/MXM/C3H3OcCLd5zeB8nr+7/ZsxhsKT040PUAMn+cBwLv5k+AZ4jlJDyfN
 b8SiL9xvQ5OY7fcMFu36wZAcNHUbwPn7wwZmGH+gAk5FNMEne48PrdqSLeeAlZ7Nvx5gwfMGEN6
 JvzlpEx6TUYQusBUO+km30BYjgFIqJubVpCBdF5VrkRRKOHJmV4wcxcrpoi6gmzGzInV8rQOFbl
 BHox7BC6ojTHCJ3kUbF15uDeIOGaH3jk1bO7HV+QwR7ziHEAz0Pul9BeKwHQDdblNMV/CTEuzIq
 zQRCs/+sQJPavNZfFSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDAxMyBTYWx0ZWRfXyjUhsNOB23ge
 PDlHYi0cSce1W+LiAFx+Nd+xF8MH+Rq08p00Ve6CjZ+bECixRYssqybVLQz6eGwckKEuIJuZSrz
 SEIjCcvUQOPILEIyXY7w73BZSMsow8A=
X-Proofpoint-ORIG-GUID: S1hQ31sgrIx5uxVspcqyBgDu_TuP3kmh
X-Proofpoint-GUID: S1hQ31sgrIx5uxVspcqyBgDu_TuP3kmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38640-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E60ED70BED8



On 7/4/2026 3:30 PM, Miaoqing Pan wrote:
> QCC2072 firmware interprets the MLO_LINK_ADD and MLO_START_AS_ACTIVE
> flags to control the link state during MLO vdev start. MLO_LINK_ADD
> indicates that a link is being added, while MLO_START_AS_ACTIVE specifies
> that the link should become active during the start.
> 
> When an association link is added without setting MLO_START_AS_ACTIVE,
> the firmware may transition the link into a suspended state. In this
> case, authentication frames transmitted by the host can be dropped,
> leading to repeated authentication retries and eventual timeout,
> for example:
>   wlp1s0: send auth to <AP> (try 1/3)
>   wlp1s0: send auth to <AP> (try 2/3)
>   wlp1s0: send auth to <AP> (try 3/3)
>   wlp1s0: authentication with <AP> timed out
> 
> Avoid triggering this behavior by setting the MLO_START_AS_ACTIVE flag
> when MLO_ASSOC_LINK is set, which tells the firmware that the current
> vdev must not enter suspend mode
> 
> Note that this change relies on firmware behavior observed on the QCC2072
> platform. The firmware on WCN7850 and QCN9274 does not use the
> MLO_START_AS_ACTIVE flag, so this change is effectively a no-op on those
> platforms
> 
> Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: d8e1f4a19310 ("wifi: ath12k: enable QCC2072 support")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

