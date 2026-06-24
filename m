Return-Path: <linux-wireless+bounces-38047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5FQpK6GaO2r9aAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 10:51:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 272866BCB14
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 10:51:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GOPTW1TX;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JXgKG++g;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38047-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38047-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27446302736A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3863939B0;
	Wed, 24 Jun 2026 08:51:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670B397694
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 08:51:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291093; cv=none; b=Lh0OFDirCGkxlVTKK1Pbk2icwaf9sGGNOWCSOcf/9J8IlOTTeERirUN8yb274Q5fgUT0WwfrgRXTp/TCqGKcppAyPEWuB5ginwhc42q2Wq1lkjqfcqa42vufJ4GkYshQ6tpVBAgMYe82na3UqwaxrzBiQxo2YtwAaIkqd5jGrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291093; c=relaxed/simple;
	bh=G25+NAQTvnuvw7qiAMU51RCYt15cCE1NBhaxlM9oj+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bm4FshB5M/pjnVwzimecNggefQkPENk8lm1U7QR4Ax+zbDrhEx3TyYx7VhN7KoALgvV92VqfumIzbrltrZRT2dK8Y7oGFgOREDcNNrhmXMOsBGfD0ixc0Pji1ddxRWKF+5q8y3Bqaof7Dg2KJ386pvtBcmv2Y8ZYsdPmmgJhZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GOPTW1TX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JXgKG++g; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O7FtNV2440420
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 08:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EgN2nBZRYrVFza8IUD/ZWGoBup4NDb6eH4d4Bf2TnRk=; b=GOPTW1TXY7phSwyY
	6POo2RRwTBeRaje2sJNMUY7fraCgtcqHGW0koWG04D1izIkXTtMTnEsjHmeydwsM
	F2pNXzVjUgJZkX87LviOx0e7BMgKS3i13na4u7AIm4BoupKKQk/aRUnjrjgU4qSN
	IZ6MT8a4x6tjOJkKpxE7WPg+S8Jm8UxzOBHiVyshFVFY0SYX7y9fccycjj9G98z+
	Y//qGebwGba6nFfjFpFed2iCD9mjTd08Xac900z+vykDYfv9kcKvTcQNj8n7HCdH
	XXxgAoFH4jQRcJZG3iI9C7fJfyaDJBrq3BQobXuEziZOaJrgPPcf9GG49mruf+FC
	LxN9Ng==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0apq0ank-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 08:51:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d97955899so669010a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782291089; x=1782895889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EgN2nBZRYrVFza8IUD/ZWGoBup4NDb6eH4d4Bf2TnRk=;
        b=JXgKG++gInAzDJFFhe69Er1lZ4wfuY2SOybNJ54XrvZsEOBJ9zfqv6Y4GM6lk8yQC7
         bGocxMwg3GWnQEI4ah3P+ebgCOK+d2Nhauhd2l3SyWvC8AhkzuMfVGr1wBo/OjPjpCQ2
         NAAlwfmmMyz8apCm4F+mI/+SLJSqfmmu9FSOhlZUUJL7mBIjHuh7qRwVnZQuweGP1CDq
         1aXAHnyOVxyOlQbmqRBqabJdovCFJYc6pyuymbNjVhzddEciJe2bxfeyYr6vmh+1fo9J
         Idn7rEANEbtUsh52Uac/U9wkbohbnCI2tTiWsT5wP1ZRSfIRVjMdtQaXCzahdL0nWP1B
         nlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291089; x=1782895889;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgN2nBZRYrVFza8IUD/ZWGoBup4NDb6eH4d4Bf2TnRk=;
        b=NEPKXA+PvRj9PIphjG/eUT1oEz8iqQbM6+KM0wFmKsCuKrlvvxvGKvbktsl+Kg2vGz
         XTCmi3KbYUfV4dpNjXvXdGP3adgCEYKqBjxWytzYLPnxRqQSDeTAr2iCp/66/I8b4+W3
         lt0TUpJfribPXSW6ioeJVZEGD3hhxY627jADVS5xXMnQaX502I4QjvRTLdrfiHuwtz+5
         P6oTc2Ebr9NYMPa+PWLApTlIkxPl1p2r3wmd+eNCZZL8TF0cOW/CJjuLWizL8uB3lgVE
         bLPHsNSwTBBgW+R1A2BE8y3vPr05dnzMLAj9rabc2icj6BJ/nFfplJr84ja9r7e+1VOL
         C4fA==
X-Gm-Message-State: AOJu0YzOik5d9WDBEDPBy71BUOE+NRLG2hcHZTWF8POdrDgFSqlB4cAO
	I9nZdSkCJfWEPQSdPTj4J10bawB89wmxnU2s2xI7QSLTTtG64NjlXjb938kYnlFxk5bBI+Vrrli
	7FLFWYRLKEngiJAPuuZ2CuRIb8iSa28/z8D6dbHQCOYHWiywfhcKwM28O1w8y+Aj1d81M9h3gaw
	ABvg==
X-Gm-Gg: AfdE7cls4LhXJq0+CaYTGyxnwxbNrGpgX1MsEsZtmgsZXgecGq/4tUUEuHHyZzGZDFG
	mBNhcYJFqqUF9a4NBUYQfV0WrCJBenpDdMkqWVJ7rIoXF+sSJXjrA8PS1mKid5Mha0TTSRIVAbx
	JfAlHaXexZhE0uDHbbA+XgfH40LyjC7bxLAEK/11ePp94apL/iW3vMQ91SPWhot/d3aty4fwam7
	GkvXduA/j8VOYj86evPF1EsCu6AKeHdJZId7SRKkNX/yOfQozSgmxmSzQdwad8D3knvKhcexCd1
	TEFNEb6QmJmB2kG+iPRSukWtrcrajEBXI2bgCTTc+TJT7PRS4b8A5QCjTNVJz69WKN6QSVIClwE
	iRGqpZB3GPfR1F9jpjL0zNE5LH2SSovSv2Q0Aq/VPKA0HZyPY10TwstinFQ==
X-Received: by 2002:a17:90b:55d0:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-37d4d94047dmr19616665a91.10.1782291088992;
        Wed, 24 Jun 2026 01:51:28 -0700 (PDT)
X-Received: by 2002:a17:90b:55d0:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-37d4d94047dmr19616642a91.10.1782291088519;
        Wed, 24 Jun 2026 01:51:28 -0700 (PDT)
Received: from [192.168.106.30] ([157.50.13.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3ba01f6sm2083429a91.15.2026.06.24.01.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 01:51:28 -0700 (PDT)
Message-ID: <6ec8de84-8f0a-4e88-bb1a-a7d45603fc2a@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 14:21:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix inconsistencies in struct
 qmi_elem_info initializers
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623-qmi-inconsistencies-v1-1-0fc17f2b8338@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260623-qmi-inconsistencies-v1-1-0fc17f2b8338@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA3MiBTYWx0ZWRfXxfqIVWgKQpJn
 5XwAgP0ayJ4F1QhHG/NG6Ad8aQJZcZm0Mz6gzjy4+/1/TWS2jICbem9UqvHLWOzRFo0NLbkoXAV
 pkUE3v6jSELdlyzNlh4jHZNEpxiGmC8=
X-Proofpoint-GUID: XnDPDMv4Jdb4scnXciVoy7O0GCVNgz2Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA3MiBTYWx0ZWRfX3F6Fkqb4U6mI
 NgWV5mYl+/Ki8JDVMpZAjEyKfE+kbRimGp6q3cB7g1TsOzWILP7D/bPXyAAe8VS9d77oXFSgdqB
 Nq2xA9X0c5SFUHN51KXpWgWg9UmqR9/BJCNJCIPtCaHxUn9Bd6uWbwdBjUQWqtExeh6pztz5zII
 DFZtY6GZKoG1tyD+w3LhIK5KKLrCHaUVc5/0fc7b75z6mscukupUxtECgGvJjk1TDTrFVlPpW0c
 3XQCv7V6H+Skx6UwlpjmM1mbckLl/x3EQ9KF+RS3oPHk7pRwX4w5T8C3Cn6bSgWz/yVIW7gc7f7
 +MPQ4CbU2aoqRqWB+7Pxjh8RScFZP1UhshrVfOEDmf6yDQlVuB845ToSHt0sSsZYjAkh7BoQFy1
 UaDdlgWAZg0Hg+LG2UVzP9ttQ8i60Q==
X-Authority-Analysis: v=2.4 cv=NpbhtcdJ c=1 sm=1 tr=0 ts=6a3b9a91 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=DysFi5wBN3dAxe50r5uYmQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ZoZKXFMULng3zEwbkoQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: XnDPDMv4Jdb4scnXciVoy7O0GCVNgz2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240072
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38047-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:raj.bhagat@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 272866BCB14

On 6/23/2026 9:43 AM, Raj Kumar Bhagat wrote:
> Currently, the struct qmi_elem_info initializers in qmi.c are inconsistent
> in how they align the assignments, with tabs being used in the majority of
> places but spaces being used in some places. In those places replace the
> spaces with tabs for consistency.
> 
> Also fix incorrect and missing terminating records in the following
> qmi_elem_info initializers:
> - qmi_wlanfw_shadow_reg_cfg_s_v01_ei[]
> - qmi_wlanfw_mem_ready_ind_msg_v01_ei[]
> - qmi_wlanfw_fw_ready_ind_msg_v01_ei[]
> 
> Tested-on: Compile tested only.
> 
> Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>



