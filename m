Return-Path: <linux-wireless+bounces-31786-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG75K08UjmmZ/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31786-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:56:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CAC130196
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F86F306BD33
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F72770A;
	Thu, 12 Feb 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLjrV4z5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cdkRcXqU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380F176FB1
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918984; cv=none; b=II6zYDrrFdyp1Xokgo94IBMwa24qMW/N2swrKxYFkeZSaa1AklIJxZfPFkljqrBeX9LvcgN9E3hx2mNKo3uyA+tbZNuqjpRZaz4COorEYhpaxMzXVdJxc0F4Hd6KgAOOqvPbarf/sOTvGWiIcbO+hpEM5CyOyM+UWGQ6ADbSCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918984; c=relaxed/simple;
	bh=3Vz2nKU8a0wbrOrwac9F3ZLVjJRW8tG/493kB9cxhHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VO0ZG2T7qnEBmYrZpvnqWW+saVKVcBhH521Wv8/D5L8uSZzCfXJsFIRGvm7nUYcwli/iblhSmdmmv3RStTM+maIuhzTRhMtSk1XJoSzgA+brMymKv+kKUNFF2NyoMW7VE9HT9BBxCoamy4rQ/+5NZ6/+y7wuhEISqLrp+dQVmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLjrV4z5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cdkRcXqU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CHMOvv2095153
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yNFMnkQwEqkzqo8EPtIIrfOp/iKUGgcUM10hA4Cz9Sw=; b=gLjrV4z5L6iTyFqJ
	gvHEWIMBJw+ogxQ5pDc4SPGTucSdbur8fINzYeNXMxB8BYMyCZTvXq27bxrcgp3b
	iMpWrzzcHAew1OdUsr8QAtpwpEKv1aXumuCsqmJMl8KRt1SQbosDlDdkA/X0P5K0
	m2IKF2eY/lftWl9FmcoTGTIjrfPS33uchkq82GwboO/VzrYLjBTJhwGoRaA7GkfV
	XF2VoGitHnKIBkbGVj4nZAAa74DZ2QdvI0te9uD67fE2Uyzy1ubLJQy7w6mvRQqL
	FF+LzJJOVCHBeAN/Vucf+MfO0FnrdpTgD/4V3Fq1yhKiflZafpw1QEFumIsnoe1w
	BpOBOA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k6y05t8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:56:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba87c0e198so82241eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770918981; x=1771523781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yNFMnkQwEqkzqo8EPtIIrfOp/iKUGgcUM10hA4Cz9Sw=;
        b=cdkRcXqU1PjwXOu8GC4Z3bT8D6dj/rGm8vTduEfLBkqF+pAbzjBmUufdZamIHR/+5v
         ZnJ1AwwqNQZ5Xzu0dqtl4LnHaDLQ677+T2aaLN+Z+gOy7qRXpzeFTARWzEuIKIM5Sl92
         32BSyfrpW4e/9THOBvjCxmPdvBiH+tAVOx9OnEreS1MNwg9H/KU9JxruvHCLdQ4OD4BS
         WAaqDvNteiJ7e4qv6/Wk8pXspFBEVthwLLG8qQbh4tSNKKTlZNLlpaOLE8RQOKwHTObg
         dvmR5CtCrGDHbBPVoJkIsLE960T44AVUuSfz7afR7Ke5mtrAzx7R7XD6wTdyx9zZ2uc2
         igtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770918981; x=1771523781;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNFMnkQwEqkzqo8EPtIIrfOp/iKUGgcUM10hA4Cz9Sw=;
        b=YiJO17yjprVfbotquBgKgLYnmeFLco2yJXD6+lSvju3e25bh/5cfa/11PSoTmsV9Av
         T1oBM29iRDZGATtvjoknwo133zRAkLBSGG/haxiROegnZxE05iTG8sl3MsIGs/VL+/Ci
         NFkdBHhpNqki969vIemAjQygEYnwfuOYlDV8JfpdPFIwXC8d4n0KalnUbPxVtXtD62nk
         2X8yMJ/wt3sYrM8zz4uZyZJazO07nkyOT4NmU5lsZOpgNwPMXUjvZmqWYPSQPnuJse6z
         9AUujDMSQBWBGJchAN0OzM2OR5NUubdCA/06sRvPzMknDeJ1AtVLZw4BiT55jdRTUysg
         1z1A==
X-Forwarded-Encrypted: i=1; AJvYcCVuyN1Kd2mdGoYwyhTI+aJgOluneSROh6j7ZibjhDT2nWmKCBnnNDQ/hWtHUCvY+gjKniMgiujH7bT0JE40Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDV1HJ6bvjs6pxugz1WkwJM72e17TBaxP/N4y8n2+0PVUs9dy
	cgvLDC6uk1kxXEvubUPKFIb9c4y8fQkkaQsulPO6nyYHRJaqPUeIYKMpaYcV5hfRMoKq/ilEGhS
	HZckkukNbyFZpfOtSo8n8tqvbRC2hsUWrCZ8hZ9q7X3ofW+zDo7ntUkEinkwd7FhEaUPfTg==
X-Gm-Gg: AZuq6aKF/meoMbDfYmZ18RfA2AB89g33mCjUjDCbrRRD8zyPt8bXsztwcGcdLUXkY+t
	nQcDTRdIEMlg+iZpJcl8T4TBFvri9+nTnBxDrhS6ShW/IvfPeT913fa7X0r5aSZfWSQlo5FL6RE
	cDYCAk3rvaoG2v9C6/s/IrRCGIP1Szt/4CzgQUJL0D8aetLx5M9I8F9RJh7twaDFGsoF/mOsOYi
	jDECJeE2lbR5LrfaP5GGoKoXFfZ2frIYFswfXXFinIYBViDmh5qytpEaAXYGy6FfX8BeEkGJoBg
	IDIP1MyVYq0t0/s5Q0b8vcQD8M12Low/dl5q3s2lrHkNtXOm3ChEFFe0E9wDuC3mQ6W+K8N7tnp
	A+gGSwAe0BNItnf8zGlkdC2wpjxatE38rFbA3u7M6mQjBIisjNME4g2iRarCfhZRQFpjZ/uA9dN
	/0ZnV0W81veMcBog==
X-Received: by 2002:a05:7300:cb86:b0:2ba:6aef:697a with SMTP id 5a478bee46e88-2bab937bf6bmr55497eec.24.1770918979882;
        Thu, 12 Feb 2026 09:56:19 -0800 (PST)
X-Received: by 2002:a05:7300:cb86:b0:2ba:6aef:697a with SMTP id 5a478bee46e88-2bab937bf6bmr55473eec.24.1770918978774;
        Thu, 12 Feb 2026 09:56:18 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2baadb97452sm1656357eec.14.2026.02.12.09.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 09:56:18 -0800 (PST)
Message-ID: <3e1274fd-fe95-420c-94e3-ac34f497b7ae@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 09:56:17 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
To: James Prestwood <prestwoj@gmail.com>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-3-mailingradian@gmail.com>
 <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NsTcssdJ c=1 sm=1 tr=0 ts=698e1446 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=SN0R1ueHmLngaVVglCAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzOCBTYWx0ZWRfX6+n8+JHIbWQ/
 AMcezh+RFojY/WfO6VXTgg3QwVIxkdGBLkxHKG9jVVeh9/XnqDLcvEyPq3rde/F52VS0FIYaEVr
 oPAIM9Mr7kl31ksxy2FT/MYmWt1JUa2kTCd7WH09ps5aOT7t2UMWfJzWZAa7Cdw9jSZDUKw/fMq
 Gcmt+FH2kwfCoCrif8eqMxyFi86f4nIA4lsgJ9hgpovdn6cuzUrKhnj2NigfbRFr+C2uKSkjcKb
 6LEbQuxNQSXvXQEo56dbo5ZjAydWjWjqy91KizE1PsGplStkxBbVUkssj3zACCsDwigSc9WE1Wn
 wWuH/ZvwrwpUdsgqH0COfTwstON17mG7YCCK6p836m5X79kFZRIZeSdZOx4JpglRC189QDZadzD
 KsqV+Iw8HQ6g34QnHPhsS4RJ2JrsJ+/332q5+pwJCi/CBeGx2voFC5sQAfv1fdPcXE4SyhinfNn
 RTBNZeo1axYgOug0lQg==
X-Proofpoint-GUID: FoxxEEVCXkEhNDhhmBj3dtdOsiDPDKbz
X-Proofpoint-ORIG-GUID: FoxxEEVCXkEhNDhhmBj3dtdOsiDPDKbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120138
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31786-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B9CAC130196
X-Rspamd-Action: no action

On 2/11/2026 6:11 PM, James Prestwood wrote:
> On 2/9/26 6:12 PM, Richard Acayan wrote:
>> When sending DELETE_KEY, the driver times out waiting for a response
>> that doesn't come. Only wait for a response when sending SET_KEY.
> 
> We've run into the exact same thing on the QCA6174 and have been 
> carrying an identical patch to this for at least a year.
> 
> https://lore.kernel.org/linux-wireless/b2838a23-ea30-4dee-b513-f5471d486af2@gmail.com/

Baochen,
Were we ever able to reproduce this?
Do we normally always get a response to DELETE_KEY but in some instances it
comes very late (or not at all)?
If we remove the wait, is there any concern that a late arriving DELETE_KEY
response might be processed as a response to a subsequent SET_KEY command?

/jeff

