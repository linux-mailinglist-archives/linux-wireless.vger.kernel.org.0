Return-Path: <linux-wireless+bounces-39120-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GyhsJlzoVmoTCwEAu9opvQ
	(envelope-from <linux-wireless+bounces-39120-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 03:54:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE7759F84
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 03:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KCjNuPmj;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JSxNNksE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39120-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39120-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E27302C0EC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66838F64C;
	Wed, 15 Jul 2026 01:54:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E17379EDA
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 01:54:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080470; cv=none; b=VbwjHUKalSJzehR08jSyrmkyJKSAqZcLh0C40ITbPXWAylRy1CDl//JvwZs14O71m9YTaDnypAA2C8o5Lk8LbGykJhKurrRgPEK9FVEQH/GEJMtevAdJfbA9a8gdfbKGYO7MBrNHf5hkzDUnbCH7dPlRLhVYlkWErfou9Iz06ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080470; c=relaxed/simple;
	bh=lJijTYg/4kaEo6ctMpeCZ/QXup279k1R3GiSLOswGvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1R4d18DQOGug9xaBp3ehouiCBNozzvCIcPpR5HN76WrMLFtK6js4ddCoyww01vFcdEpwlxYQsLWCRjJDMzgEZ7Wo0EYT+y/bAak2Sea9FbaWgiTUBklfQ5ww4evCTwhIwnxU52G0omDS2++Moi8kFF+zZpsEZz4pFSZ+0qTJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KCjNuPmj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JSxNNksE; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F0IYdQ1953756
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 01:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BsLhDqDBDnNRlsHM/2Tqm5id7aGedP3eAqNDjF1Xv0M=; b=KCjNuPmjU7fY2J5S
	PyvoC3SUEkfEXr5PyJeKR07ACPRN2WGqnQY/q+l7AHLQPue2kr34otrxiDI1mSdM
	2AphvMoD+PIYgNd1ycGZCgJPnw77v/6oAHYdDW1TOMmleOsvw9yEb2qd4IbpHnV1
	MXPhSRHxQWQtts5cvQMWm4IFFfambP7xV7XxxD/chdLPvN7U5VYNm1c9ryqXYwEP
	0RXVeEHimu6onZTUe6kvWtgPAtuLqwkNz5KSRqyZt2hogxsPPNlcx+eVDPrals/Q
	T4/S3QwcaMnVHiDxmBFIr/3IU+VSHrmfmtQUTm8eOqiqGC1gVjUnGfKXWM5kYlKE
	7wOM+g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnp0jjgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 01:54:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8952346bb9so4157832a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784080468; x=1784685268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BsLhDqDBDnNRlsHM/2Tqm5id7aGedP3eAqNDjF1Xv0M=;
        b=JSxNNksE+32fbJOFK7hFFAWeWFUHZtMfYxIbz1p/L5/yXPWlaWKMbKUJhdfEACcWTY
         yeNWmZsPbOaj11MfIiRzuIEstbIgqfOHDYw390j8ticrReyCeWvbaiaQDjhhCPYdPPvJ
         NurCm+t/3J368Ez5SGv7kqXdubY4Y5v9i3s0eVLXgJMs3hL8c4V6QRaC9TS9+oKCzv8L
         kFfWHcNw2cb5+5T/BQlJHpXtII+QIXb+NfpeMURRYR57MGWlZWL6vkhMbpSQbKGZ/FFk
         1nCXf4a2C3rF6svJn7rKR5fKEZ1VeHT0Meo9a0sPJqEUzy/9hz7fSnGMZn22G5ja767U
         nQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784080468; x=1784685268;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BsLhDqDBDnNRlsHM/2Tqm5id7aGedP3eAqNDjF1Xv0M=;
        b=WWEhMtDCplMMX/aEq6iPPrVtbS5pEQKQ9L/HHILrpRt4qLMmrRTIz7cGA2gEBVti/V
         +YurUQnvCjJ/gdoEfLXe1VOY1+sDphEOzk6pc3qis9B4ub1TO68TOs62xcrk0hQXsp9D
         uWXaPcJTxLVZrusrDKHUCT6CVzNRVDHpZauQFkretUztSpXdKeAUx9mB0/3QVTjaLtnb
         1HTGafbjNMiAVr7edQ3wnZy71cqdQyqVf4ck1tafvZo+bXkDpjqu8DtTCce/zxJUcuiN
         wpQK3yE3e7sunXcgq5s2vj7EdL4hD3VzeE5XB2Wc1fnZYEPhDBm44X/Vti0hpRI//flN
         PO4w==
X-Gm-Message-State: AOJu0Yyw0fT5l4myde2MF6Gw/eTcnsoNiLhNhff3bNhRi9xt5W73ui2z
	XWUCB4x+Cf4xnkFu1gsyyvX08JePxp98ZNbxHrnAUDyrXPqDKgWuzBV7+trcT3BKj2qrBxgce9z
	Ns+CjkZ/9Rhb7YPXGdoe8v94hKHTfeKhSnAmUuVQTwhgZlGXE4Vl3Ppy80v11mqgBoe4b4YMJn5
	b/i/C3
X-Gm-Gg: AfdE7cmIhAtc24/zlwpWvv724Ez6zqf/onRJ2Ey7zi0Q5DKx3Yvc9hJ3yZHHu7qdJw+
	O3rJCmCSbOCyspw1Vq8sCMHrIlr49iXnvud9y2i9y+gA80cE8AOn7fDXdP1GtxidL5hwFED0KYi
	/k2qKzH3cRp/FcZ31AZohUQjIsCEClLkR39lcF19TT68g1C2jqZf6O4BxC43d+4fBdzQECC5Sg0
	O9o+J26YmAkfrOADYz3syWU0+ZO/HVPVk/3Cd1gj0DFR/WlL/ymGQantDk0/i1Mc3sNAaJqmgbn
	cX0O5UIJHXCfFHdcInfePo/eX4AX1Gt/QP9fkEulN6PBsuRfHPsE6RpuDo4RunPaJ4ynOXh6vOw
	hgehC1YQnqraGyMFJz67MllFtagfIKVCgDA7FaV9FirYctbiUo0Bz9Zgl+zYpGL9IPZdQ06OY8M
	eyHtG8n0U=
X-Received: by 2002:a05:6a00:748e:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84a67241a16mr609289b3a.3.1784080467623;
        Tue, 14 Jul 2026 18:54:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:748e:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84a67241a16mr609276b3a.3.1784080467092;
        Tue, 14 Jul 2026 18:54:27 -0700 (PDT)
Received: from [10.133.33.98] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f26d82bsm2345392b3a.14.2026.07.14.18.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 18:54:26 -0700 (PDT)
Message-ID: <23b870da-f913-42f6-84ee-0f675b4498ba@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:54:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Set congestion control max MSDU
 count
To: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260622062614.760166-1-thiraviyam.mariyappan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622062614.760166-1-thiraviyam.mariyappan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxNiBTYWx0ZWRfX1WlPiEgYNEeZ
 2Idp1TX5Fl6+pmNL+0gF1C2FM2n9pS8ehDxv38o0LjNh+FAh1ifiODB4li3dhx0SYknaP9YzoO1
 akUQDV592qv4MQlxYedniFKcyxoakLQ=
X-Proofpoint-GUID: nwhE2d8mlClOOLHmIZRPdGw941xhMAp_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxNiBTYWx0ZWRfX77UZtVgL31v8
 W3hL731AAhQERCh26VUVUQ1y0npq/Ca8vWPw/AdSGQ+wK6VawUrBuQkH1OAgjy5agKOaEydk69L
 cn0cnUbjaTCmSUV53F/CJNqfTvd5SkTtyJSQeUbFquyqyhG6kOs52Mee73XJcw+22Xh6EcXAdsq
 hF3xnPDhXBGNOoIcXcfU4eP9zZyCW1hOXRFkLqLHa2PFxDNIXDz1RHdn7bTEqHaLZ9+OftY4il9
 wdS3FZcleODoZUDzf2cadTgDGWhX6+OPDAzV56Q0yEZS4TM5rGZn/kOLa0L8ZA8p8OyyWaL0EhX
 xgcLEKlA9YzX/FiQzgCGehMBAWge2Tj6euh8z65TbNf3ZJxZJ7gx73ghjT2kmu/KgJ/kNnZ0SNM
 S1Ole5BAkaxdyFlRgR/Yl+JP9Lc8pXpbZyZIBtVYEzfif4dCCg+2mQCCs/nLKxxMJnO4XbPLHH2
 V4aabCKu5+xyxEj9hbg==
X-Authority-Analysis: v=2.4 cv=FtM1OWrq c=1 sm=1 tr=0 ts=6a56e854 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=APCbmnoeBd6G2hkCapYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: nwhE2d8mlClOOLHmIZRPdGw941xhMAp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150016
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39120-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thiraviyam.mariyappan@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEFE7759F84



On 6/22/2026 2:26 PM, Thiraviyam Mariyappan wrote:
> Currently when running 128 clients UDP DL test in 5 GHz HE80 (NSS 2x2),
> firmware uses the default max MSDU count (16K MSDUs). This lower limit
> causes the firmware to compute a smaller TQM drop threshold, aggregate
> packets at a reduced rate, and results in increased packet drops with
> TQM drop threshold as the completion reason.
> 
> To fix this issue, set WMI_PDEV_PARAM_SET_CONG_CTRL_MAX_MSDUS to the TX
> descriptor count using ath12k_wmi_pdev_set_param(). This increases the
> TQM drop threshold, reduces drop events, and improves throughput from
> ~722 Mbps to ~1060 Mbps with 1200 Mbps ingress.
> 
> Add a new HW capability flag (supports_cong_ctrl_max_msdus) and enable
> the WMI parameter only on supported platforms.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <thiraviyam.mariyappan@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


