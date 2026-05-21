Return-Path: <linux-wireless+bounces-36768-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE0XG9Q/D2pNIQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36768-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 19:24:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DED05AA2A8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48DB30F5E8C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368BF38331E;
	Thu, 21 May 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIMj+4ky";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XoY3Ws0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7F383308
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382169; cv=none; b=FLWWr9pfR/8WxNazHaSALMts3gpkG/bPzBfaiWbUw/ExoG5ArPwBoDx3W2VLxCXcE+wmM+N2+a1esv7bO5RfNLufBa6ChvLT/7qQ79maXIAZMWHujPy9FC3kMTAs4kfq/oyINjo1euFMnv/F1nSXPnVoJRRFvfDH0JcuQONVxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382169; c=relaxed/simple;
	bh=OluPDvAZeQ9J5Fc7QJbpNDRGziE0W+ZxyotII0ZoQds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPNIGCBybLCMlK8GPmtreWadcJI9bLgzZ3nnH5a9Y6cDWqBgC9z0ZpFAyww9a6FtE13sPGsb5XemkBBUPUHtuzU5mvMfvHwB6Fu8di65UZWQZhvYosepCZ5zV9Tl8B3yQeBTChccSw6yrHmrIlYsisxW9XrK8JfqRocTelmbrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIMj+4ky; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XoY3Ws0J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGk7GS3532312
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tTyTyN0cmmgXE5HeBgXrCK1YngdMjkwlUOKAnMDVc6o=; b=eIMj+4ky2HCaefTD
	qNNvbqbHw6K9YQuc2ovatWuCf8SgB3+3VXVCmhKoiOR7ALi2Yn6gfZCmU8805tRR
	D80Fe4sIR73KyCaFX6CcRp/pDlnXegZTcspUTa8FsopULE6EvUiVGag7Cd4fQDXY
	+E39b5V8sbWC6jh101szmAgq/rXx9f4kSQhxIHPh4O73zDPYSwUPIf7/IUtc9BWr
	rkrO3BDOkO2cUx5YyrDXaVmVBgwyiJEGo+DQW3vuxQ2s3EuNNHGBPqzCH7qGdeXW
	BDIOsx5wW23JZ9ZQBZBaVfmMDvDyFFyPyCF0qiFbmg+S++COdf8lT1/mRZO7PADV
	zr6q9Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39grt1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:49:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2eebb099efbso1401972eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779382166; x=1779986966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTyTyN0cmmgXE5HeBgXrCK1YngdMjkwlUOKAnMDVc6o=;
        b=XoY3Ws0JSePEeius/CAD1ynpNjaVcMzHV98HHbbMVuexG5tFfVPwrhsaJyp9vGNHEG
         mNE2MDTAfvYNFi9qk3IBTFIF4cUI73c4QXSS1ki2nqPWKwlDp3AgWVp+FDdgxjDViv7s
         NZoIkCqDP9NilHEhN4b9ncgzOcKo3PtftKV08NQdTh0UJtJInZDruEECZWaWm4WiGBxI
         gDq4VlLNrfQifpl1SflmAAofuUN9+cMrj+zpO/tjTLgJBRY3JU5f3LYnLFvB3tAM0LDU
         UxCSO4rowkY5vnjL/QWuHesymM82fnTNTCj/VV7sXI3Cl0fuMIa+fD40ZCxYpupozNza
         C8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779382166; x=1779986966;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTyTyN0cmmgXE5HeBgXrCK1YngdMjkwlUOKAnMDVc6o=;
        b=Et7jyhf84o0B26zhv2rAAQQPjLTy9BYY8ROc87sLe87hg7EkXCvpXBWNp0+7/bhn/c
         iHtiQa4xP0GDVopIacBZ3MZDgooUcEgsKSI4Bc0Fpfj5g9L7Y7oMxy3IcLnmbK+PGPE+
         5AWLhZ1r0GzVVdQyuCFPtzLHDNLOA3vsd8vEQJHMyKRKA8hD4Gz4uo8ExWULsni4UPrQ
         rWCv2O6mMK2pwr0dubgPtBpoHhLKNWriHkX1iEJ2cZ0bWQGMss/cEr1uK5TZX9auPM8U
         pnAUjAOGz96qENoEFugENBfN758QkcV4y5HPIeg7fMIIUc8OnIdcXPtCb8OQhfZO2L7Z
         rGvw==
X-Forwarded-Encrypted: i=1; AFNElJ/1vti9Echm6ta8KMXaz39U64kQI5us3NChRdFhcjojL2iJJIo0/KGvKhcxk0QJnCzfTIfc2tpzDDwjBpeiKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxWCI2sMc1sqzLC1PHhObFzq3UhBflJD9IC+MWqj74/hCRyxy
	6mxV0y/7Ww9HNCVWZ6QO5cZb1pd0cxKsUShaKiRMVSYhv4CXjqZDqTwPmd7QD8KytG6m1jOzSOp
	1Ktu2PhpLs647WyxRIAOcKZO2bZRrIOTpOQj4cCOERUsW+jw56EyfkcqDvr472CSMzX33rlTiON
	21Xw==
X-Gm-Gg: Acq92OH8dNGkAfJkqw5EPrmTY0EoVYB/2XKtfgtPC1dYdEq3FKIXLPFkCioTwKI2QFM
	SMTt62DwU6IbvDg0onGBTYI/S3Q+umLbzJf1je0Ptm/w4iFfOHzhfh8basKRx/KzVVD6SIZ+edp
	atGs7nMR2glIHthW2ziqY6P9OgdCHt5Xifa2vOxr6Pwqx96yfUInRAZ4bgbty+Fn0X0G1vrBfcN
	I0CFRHCQFO+xCzQv7pqGC9lifwwvuZbAuBJaEsjozS+4QWnVe08qMlN6Rohf4iVSxO2WH9e3BT1
	YSnVW5OZoOa8RJcaI/hf4diNDG6oH6vPqLd43O8uOGzA3Gyoe0bxD/9C4fJHLRfKLyE412SL9Mo
	eHjwF35UkdF7hDdBqzsk75Yq+JRBxxM2CqV7C0CgR0BNJ6JEoC0d8ifDUH4c6vcS6As1sTLj1yt
	YgnLUzTQ==
X-Received: by 2002:a05:7301:678c:b0:2f4:3a9c:818c with SMTP id 5a478bee46e88-3042fb0cff0mr2290265eec.29.1779382166333;
        Thu, 21 May 2026 09:49:26 -0700 (PDT)
X-Received: by 2002:a05:7301:678c:b0:2f4:3a9c:818c with SMTP id 5a478bee46e88-3042fb0cff0mr2290236eec.29.1779382165808;
        Thu, 21 May 2026 09:49:25 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304432dd21dsm909393eec.2.2026.05.21.09.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 09:49:25 -0700 (PDT)
Message-ID: <87dfbe33-7705-4ee7-bdde-565d2dfc8287@oss.qualcomm.com>
Date: Thu, 21 May 2026 09:49:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20260521085647.394151-1-masashi.honma@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521085647.394151-1-masashi.honma@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a0f3797 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=A_8pNdP6YmOvI854vckA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: gj7xAosZ9DuzE0xq7_xWKQCwMbC44cEQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX+IeBOkJ0lnA/
 YSpIOASZsTd/IOOCUQxYcj/b6il9xdRm0TxISaYtn5sB0OUIhGQCdi/yR+ModHpqaXOazmkqUiF
 QuqJ+2wCe7uJUQV0gURTbRdF/9fxEGk9GblgRjegQ8FSTQTriy4m9b6FRvbZFP5UXA9938IOZgj
 IGAAQ1rxg98gD5IenyZ3OteO3EsoXxF/pB4D26xetRDZZeYT61L0iNuGD7QnxJG3HPdXxRQt4N9
 VcQc3SuySq8cSqpLsUrNwTWUvUhFbKFzxB7N/6zRp1jlQbhVKpcNVsJP4ry2IPvcjE2NpcI8z6g
 TzAYcVVjWZR9xdMFiX5fDDSdovDXYmxULviiFX+zntezT81PIpB5dSqlJ1VEA9m2Oqo4SwJxrFS
 s5WDMawYDhqn9yg5I6EpRiHLKaoHQU7LJztzJwbOk/Khj1x8YkoFSvtzmvnm+h1VCoEl8qAr0NS
 rsZWarripDqNaxekYXw==
X-Proofpoint-GUID: gj7xAosZ9DuzE0xq7_xWKQCwMbC44cEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210168
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36768-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7DED05AA2A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/2026 1:56 AM, Masashi Honma wrote:
> In preparation for subsequent patches.
> 
> Signed-off-by: Masashi Honma <masashi.honma@gmail.com>

I'm surprised Johannes hasn't pushed back on your sparse commit text.

We have guidelines that you aren't following:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Having commit text that fully describes what you are doing and why you are
doing it makes it much easier for folks to understand and review your patches.

/jeff

