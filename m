Return-Path: <linux-wireless+bounces-31369-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HLNCNu/fGlVOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31369-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:27:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA948BB992
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AC5730041F4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735821862;
	Fri, 30 Jan 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMdX0HHU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NtJsbX+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA41F09AD
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783255; cv=none; b=WqR2cLP4DSKFfX671SoqnXQ0YxRAy7I6LVRdRIIDiQIzIG7e5TOAMw7MQLprkT3ZRIRTTNWCFItd61/Il4VsiBBjQEmURbR7SLV2K/DaTFQVa/otcPpMACmc1sJEZ9/OWYnXwmnYMhi+pf/EoAB7Mb45wPY8AVR2016wT+lNH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783255; c=relaxed/simple;
	bh=OjDbAyCVvGi0HknofnhmpEQkSu+LOt1xeGohpiGNUqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIy+t/w00GpwZIyc2eF2q8VDUDjM0ITxheBjSDhzSPma3lL7y/BSX6EkRMKyDVIlD3ZhnTHqUAu9i9s12fBCEaSYd8g1JEaFXnKA8QMX6oSm4a3j5uSFVwqSwquFXsHJmzMUDS5OacQnpkmFzqfEPX8YbXAkWjceqOp89XgpAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMdX0HHU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NtJsbX+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UApFcJ1022125
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 14:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OjDbAyCVvGi0HknofnhmpEQkSu+LOt1xeGohpiGNUqI=; b=mMdX0HHUNPof+6oB
	Qr49xdZvNQz2AXJNRJS7z4t4phEt8yLnn+YIGAfP+FRUmZL5np1514pI9GhVRcXB
	agvElzqj7NcgUzLD70yKOqBAnZv2wl2xIByvO7dabj5+FslvrJ+GE20t5ihKbiSb
	5uLaSMv1CB+SozFGge6AcOf4Ss6b0SVjtoddX0DMHOph/Xi8BTz4FFxDj3oQwbo8
	lTGL2BzoIMzR7ESgWJoy9lroHb1sqxM2qInytfR7Sc4Uic7sEBdzi6/HhZ6VHvaD
	O6VRDP8YCGLH0DyS0DxKCCOrW0VFS+Zm37PZWSgl60dtBXc70A/FDx0/3sJ6Ys82
	EZ1e3g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0e3kavk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 14:27:32 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-124a95b6f61so16247516c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 06:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769783252; x=1770388052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjDbAyCVvGi0HknofnhmpEQkSu+LOt1xeGohpiGNUqI=;
        b=NtJsbX+skv1UAfgWu1aUpNjyRa+pjwSg76EvU5A6fLnA4YwwXfSTMc+KJk7zPeAMS8
         WYzy6f1LkUM1hzx1Xwsk+ep9fdMz6WjS4DReQ5By2tX3VfclpVy7MaJaanFWshSbnj9i
         FwZfd2wAs5d2u1dSg1LCMu3oEbDoSfV5AQJ+CTeTRu5Z+hJLnDirUzLo6VgOHUajz6hn
         pieD/JamCy4TcMGLdBNgP7uU05WpGCh0dJ6KA3nwg9aOLuZSdJKwqGapk77lG79xAYxE
         zJPHCw0ZzCZ3XlrMx3VzVSNVcFTG4Yzupat2POBizjLqeY5j4Npj9qSnqIRnQokJbXer
         yEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769783252; x=1770388052;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjDbAyCVvGi0HknofnhmpEQkSu+LOt1xeGohpiGNUqI=;
        b=a4KSXSqeeOZZqaUvmjRvt1NZQXV27H8j+/vgI4/nFTdQHEBc1sMTkxbMgoPNOOh6wI
         8kgLo/BJyeLn+vNEiqMh9jT+5rCBRitwzkfYJNp13z4SNHOrWKQD4gAW4OxEjGBd9LHb
         7dUcuc2/mGu6NZYw66d1I7Scpl2GRAOiLVO1aiDYnAOYcA2xCjj5tSVucPKwNBN7EpgH
         s42UmQDGujbNyCljDMMRXhhCCrrXXBb4R4ZUMTX7bqGjdtX6Bdiuohcrz/aneoNKy9jM
         Mqf7sHK/0F3fW1bLHA/ouPiR3Ezopg006pKNwx2cbIs0lhrfYfttDMx8zM3OA2YPmvkU
         rmjg==
X-Forwarded-Encrypted: i=1; AJvYcCWnxzt8lZCK3WL4P65hF/g6FcIOYW1hUGOmK1x3AEpk9bMn+l4YbwE6t9OtwlDfVEXoVVhKj+eLamqpvJmDjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVZR07MbsfaueOKFGd7qkrUZ4c184eUJQi7ONkrXYc1NTyPF0
	O/IT7bG56lKDo9JtXS/yqo/iJHYNOpltcVj+CpCFQ2F9LENjItamNw9ZPFquPxqwTYZWRsUTxBN
	5ZrSlWy+URJ5p6qGeJokdfQkiWVhxgz5I5gRxadAWscnDSLMBM2HBLOpPrjFOU/WiSTLBkg==
X-Gm-Gg: AZuq6aLmYlT3IfGG2iyabqhYuAbnhvrJ9UxtZES9Stiu91Yn1Uh/xCtTR5KE3hNyAjS
	A9+9oycpWjMBZwJpe8SoiTkvNCUA5hhZr38Tn9PexktUWGNjDdxwyudQmG3UQLFfCCt1raHISZ9
	CcxgA1aug1th40E5/bPjc+ciUH6Y+bFnNcL5M2a7adi1jrwBmxp7D3jYO9Mo52hbgesn+9lzobj
	lSjC3ejUTDHdVP2ZxKM1SntmlrG7B19mR7aEt6UDV373fMRfQ9xt1y7MgtoGvb5v1yH0+LwRYYH
	UDmcJWI/RGLdbObisEkQuQwmdRmPFO47+9gNUoLkLZpnPX2jV85QDgITO9kEmdx/n3BccVHVqpL
	yHsUjbpoe1qbG8zCAwMmgPTYk5d8P5ZUtTgPvDfB+GIAdNoOhLUqgRWZu1FBco79QPyAbzg==
X-Received: by 2002:a05:7022:2381:b0:119:e56b:c75b with SMTP id a92af1059eb24-125c0ff91b2mr1588415c88.32.1769783251695;
        Fri, 30 Jan 2026 06:27:31 -0800 (PST)
X-Received: by 2002:a05:7022:2381:b0:119:e56b:c75b with SMTP id a92af1059eb24-125c0ff91b2mr1588395c88.32.1769783251044;
        Fri, 30 Jan 2026 06:27:31 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124abb2c514sm9466147c88.12.2026.01.30.06.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 06:27:30 -0800 (PST)
Message-ID: <b96b9fb2-3313-4c3d-b20f-ea477f72bd62@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 06:27:28 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Saikiran B <bjsaikiran@gmail.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
References: <20260126095244.113301-1-bjsaikiran@gmail.com>
 <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com>
 <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
 <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com>
 <7fb6b431-58ea-47bc-b251-5144575db17d@oss.qualcomm.com>
 <CAAFDt1s_NtY1vXa5STRW7oQn9yDJBC0g7CPSZXn0tFhd+CSHrQ@mail.gmail.com>
 <fbcbeb0f-c073-4da5-9dbe-2518a1d31f20@oss.qualcomm.com>
 <CAAFDt1uSQce_9AG2488yaeeEjCwQwQubW51K51VHiJF8Rp6xRQ@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAFDt1uSQce_9AG2488yaeeEjCwQwQubW51K51VHiJF8Rp6xRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VI3QXtPX c=1 sm=1 tr=0 ts=697cbfd4 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=8ltgOPgcfqXs1Gl5X78A:9
 a=QEXdDO2ut3YA:10 a=6jIDAdUXVGMA:10 a=zZCYzV9kfG8A:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: rCzFatZ9_BF0DlDZhhwcxhnu99fy5c_F
X-Proofpoint-ORIG-GUID: rCzFatZ9_BF0DlDZhhwcxhnu99fy5c_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExOCBTYWx0ZWRfX1jYCA+IvF9xY
 gLmCXb5WjacZfu4DaixfXc4VEIpnkq+S62afG1Xf05RkZ32VnkWSngZxsYa/uUu5kUSWcaUxy4J
 7BtTk4XHE6YUeX8om3GahbNcTP2XyupcNBjceb3UM3wWQDYzNtEE/KGR7UDlnEJJdOraWG1PxCH
 goVNZ0HpKdTiZRZ4nPEWDyTlzH0FzSPd/s5RiMspvdTPgOYDVSBtu0RmKk03d8erKm+kDt/LXEC
 XTO/aS0d7DhqlN0NY7jFosMuz/8iL6+SKDkxjSas3TkiNI22Q71o0eVAsn8AoLhUSdguYJ2wHEN
 gO7PY6d+2VtdpD1G5NmUutY0ghphqjAOoa0G8RUAGp35eFSQVpGFmjvs5Cea533jiIdPCxwifoF
 zvh0p+DfzWXEvCQWQwXZ5V+J96TUcjuNrfoEjtvuvikODAiFQ3a185TIurJkyDbqCxrzhgOFIwV
 blKP7PtExLE8bxuY+BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31369-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA948BB992
X-Rspamd-Action: no action

On 1/29/2026 11:32 PM, Saikiran B wrote:
> I have merged the tag, applied your patches and I can confirm that the
> leak has been fixed.

When I apply the patches would you like me to add the following?

Tested-by: Saikiran B <bjsaikiran@gmail.com>

