Return-Path: <linux-wireless+bounces-30829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0DD20A4E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 18:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9164830034B9
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174972C11CB;
	Wed, 14 Jan 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmgL+lK3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZtWVSHFU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6422FFDD5
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413066; cv=none; b=G8dUCjLaVO+ketVcIn3+g6c02N0PjdxQkT+WrhLrKEKTbsds/++W67OZV5DT4D3n5BGZMnK3dIQEe35K30fclyw95+DQbyLNXuTdi/RyPILiHhEmA/zq9cEDRUPpLMwouHxmTSoV57cx337JYwGoRKxD8n45RzhHP8DnSGcOfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413066; c=relaxed/simple;
	bh=XEpuz/P8ogVHyM9urkTZue07YsEhKr5wbkRm7Jdp7Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuuFBdmDNp1ArixUrGjSF8IA9t7pJ/b4SJIqeXEda+uPBJUG5L35FKznDEKbBpg1rzmjwgyRViCmsD2qDl8fZEqv0n/2wrhK683achIh3O/7ZwnAWqumDZOBNVqmc4huSYZFQhMjBKiJxTaCFTkF1gHFo07Qo9IBmufdV2rBLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmgL+lK3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZtWVSHFU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EETP9f2497479
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XEpuz/P8ogVHyM9urkTZue07YsEhKr5wbkRm7Jdp7Vo=; b=gmgL+lK3KszhCY5E
	qFNPzBhDI+duHbKtpNnxGSIl1bYFgVgSsGEuMacg/B8a8kYn1En/t9o2jegQsCkZ
	OkQ5GLj762nSpe1NJsVcwQi+ZlsGZLb5W8rZm2Rjzxij7p/8yumhlp7ruq6+8Hms
	uHbvC72tfSAzcIpOZlnnSn8ckNJIP2y6qtVG5TxnynrpaEAqZB0h3vO0DXvOxbkg
	uBbTWYulu0YuPeSwFaFfKCIE9p7YFI1wK2TT7LQZDKPoWIQ98HAwZu3rB2a7cBIb
	IvQrBsK8ZFmV53wpfC12TJ2U6ScR959nqLjOP0F243Ua4EZ/7kxUoxoBBgcjuLtg
	cCPzeg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp16x3hnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:51:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b0531e07e3so105120eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768413063; x=1769017863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEpuz/P8ogVHyM9urkTZue07YsEhKr5wbkRm7Jdp7Vo=;
        b=ZtWVSHFUsGytR67SUE0G4LWWJN1Bu9c4od9dIAuSsecIrpZDpaknb7KcMkM0zlICpj
         XUtXPe/BQ7UKnV2LT8Rq54DfuzuAVjguXG6KIKzcLkq4JzYTz+usAqOcwg6w7BtdyPc4
         AX71nfAzWcnQX57+hPwHInaqpK/8Av19lqqz5KxyuTHsXEp+owNltqyA+TTieYOsxkaV
         9XXZ/WWDq1TJBBMwhc0Bf9JNiusRsMqeMQlWet2IWnmg9eCOlVjBFgj5f4nb8BJfqGwA
         HiKWHt2pPMkUjoG87l1i8kWxa5EviuH+NkauTp3m87j/TqZWCe9Z1zsPOseb0Hrq6zlA
         FeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413063; x=1769017863;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEpuz/P8ogVHyM9urkTZue07YsEhKr5wbkRm7Jdp7Vo=;
        b=gwGHS1QMxTuy9aP4LDA0cufJh0s0J/WLJl0w61h6eevFMtPrfYQCwPR5l7gyTs/l5P
         tpFAZycnq6UEknh8ktZ0JFtnxjxxbZqGrniuWi07wuEPOqAW495d05mUJfgNPZbYDYrj
         pgjkOSaaIpAHl5fio2RVFkQAo9aYubsuaSuPRe2XVps+A2AUaNTbHCReokQ3sLYmg8gL
         m8lY9PhhM7jorqsSTTWvmpdP+dspjLQ+ChkyG9rqqWEGLtKro/o5ewJm5xTTeNhLhbYu
         Tydf1rOXIyTeyThxsOZohsvD7dRyhaJLRFTQ3ix1cDJXiiRpUA1YVdVq++wCpQwQCRHh
         R5RA==
X-Forwarded-Encrypted: i=1; AJvYcCW6gSFZlWja8fstQBBG5JeOme+s4IzvIss/KoUsTRssCnIShEebq6IVTb2LHRZ2NSsu3tr5z3j/qiNJqWhP0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxR7nsdq77KnuM5nTNbRIPTopRD7qRD4Ftk1m20NrE6N1PNo5
	qSSpdR/zNYc3jinJsHlx1SAo555SOjGNBKYBKwqIGKzhFBvYGPKF9o/3O+i+YcIyVgxDL4lpzPd
	WMP1jVr0fuLRar0BmzzeENPPXRSKOlxWGBspex6tVHxTlaYLATTmHJftfJZr0qlKYwMhqCA==
X-Gm-Gg: AY/fxX4U8Nx6CPWhmgiBM8LAcZjgMnl08rBShFIBhTqVOKkr2/D3vcKMjhQzaJ2MpE5
	A1i4EpuHkyj2z2dlWTugnUmSaVyQsq4kZhQEuAUSLpkGqzxvwNJqKlijem92SFEEoTrNbCmUKKc
	JxgHJ76gLBNPh/HllBTBtLfPQgTt7rdZqS9SZa6nGmKWcESfImaI7CcsD/pL9BbDa5/726AmcHS
	fkpKmqvAq9IWRozrASLGgEFhEbrPIBZMEBI71km1wPMMh178mnzNm2rk8+j83xNa6zQsTrxR0zA
	QWeO3njG73jI8tKNmuTHnWfZ/IAqRVcntXzvEfs9kNRBl7N+aziABaeNg2u/R+h+jJG6Ma9a0e6
	qIDDFrvg5p5jFQBqG2x4prpI/oo4DYT+0KYjVY8a86o32FnekOI8QeGBPM6cTErNPgcGv8A==
X-Received: by 2002:a05:7300:5388:b0:2b0:5306:1773 with SMTP id 5a478bee46e88-2b486b72cfamr4211579eec.1.1768413063460;
        Wed, 14 Jan 2026 09:51:03 -0800 (PST)
X-Received: by 2002:a05:7300:5388:b0:2b0:5306:1773 with SMTP id 5a478bee46e88-2b486b72cfamr4211533eec.1.1768413062713;
        Wed, 14 Jan 2026 09:51:02 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673b2esm20529879eec.6.2026.01.14.09.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 09:51:02 -0800 (PST)
Message-ID: <e78d25d8-8741-4061-ac9c-606f3654b98f@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 09:51:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-current-20260113
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <98386125-c0bb-495e-b2ba-2765aaed19d8@oss.qualcomm.com>
 <33d998cc225a7aeef4731ebc53c28a32b241ca7e.camel@sipsolutions.net>
 <f12c186c-c76a-4d39-8591-4c8d7d04d307@oss.qualcomm.com>
 <22746c254c4c43561e2e3deaf49dadf7c57dae17.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <22746c254c4c43561e2e3deaf49dadf7c57dae17.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: clquhaqCtw8v-GaKpt6154dVNVtYiT7b
X-Proofpoint-ORIG-GUID: clquhaqCtw8v-GaKpt6154dVNVtYiT7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE0OCBTYWx0ZWRfXyYc0dgKkzifr
 O50j1WJex61wTAwDEIYL9w8AMHWCAq86JmFmfY3w6z5xTAqfnvfgnk8sb0hEXTDBkLFSCeu12BS
 kjZSG/PRgxZVvWBgo20pD967KZJtajY6fdL0llZD1vcCei2napKwXEkg6Ln9BL6J56S6n54ZJzu
 EmAzfNMi+5kstFeXAKRgTMncXdQSD7DXaSCaPCEgURrDkNttpCnsiuuu306/I5525lm3K418lQd
 dGiTK31k+7Ih4PdHgiOqLmfehStGocGApOKeDkVobk3Uw55cxH7eA3U0WcUHf90fh71zN3Flt48
 iSo88ZDlkVOX5smr+lKfs7AmJQlg7wZhAEagxYUhTEHs+uahif4wsjfrhTQS7GsgWk+pEp8r9BC
 bNMNGNkewzLIiBKfEyM+E5YVlNef1ELahUyMqysO4IL/NjuTF0hF7udObGDWcoBdXCIGF/hvWDe
 YQ4ZnXyJoo5GkgJSD/w==
X-Authority-Analysis: v=2.4 cv=JvT8bc4C c=1 sm=1 tr=0 ts=6967d788 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iu6Z6aglds9mpAdrEcIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140148

On 1/14/2026 9:08 AM, Johannes Berg wrote:
> Do you just want to redo it? I don't mind backing it out, nobody pulled
> my tree yet I'd think?

My opinion is to leave it as is.
let's not add extra work unless netdev or Linus says otherwise :)

/jeff

