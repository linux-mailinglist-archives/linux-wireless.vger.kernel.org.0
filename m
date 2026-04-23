Return-Path: <linux-wireless+bounces-35244-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHGpCxo96mk2xQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35244-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 17:39:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC8454857
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A1E8321E6D6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A59F369999;
	Thu, 23 Apr 2026 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ms53WFcl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdV+1Oj1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB7366800
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957893; cv=none; b=te/6tsBH2Wt4F7S6nb3BU8tnCOgyFVUyp0rcwQ6uUtVqgliL1nAR/AqIzlKYXw1r15tsNqxxIYnTtD1o6H/IjRbYGQFHSjbmLSwPFCUdjE4lUScCEOT7iO7JMHfJ0skm/bJOrLnihhu3s7xRfYBmv0iPaWqXIxy/6KWJlqwzkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957893; c=relaxed/simple;
	bh=8+QSjknPC9+Czt+clcDIZ9CC42/u62f9ZFheT3F/nLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaZaLdJnvSGIlThYoDYSSwel8WOTqbciOc/HVlFs3uOVIsUen9X1NcoXlOgWonpGnwlQEgmICECX0IIYW1vFViK4R0vBjReBYM0tBbU6ehKUC9urzA5CgFbdAqqJKqrTUC9PIpjbaV/VE95Aj6+CdPVh0Z/ECwJmJ9TsltPudKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ms53WFcl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdV+1Oj1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NCkAGu3803986
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 15:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9CDZxY+AicG+LQxv/gyUZ+B2R4sxcezOhmQw6qqkCI=; b=Ms53WFclO/JSYHXh
	G9H7c4JvTFg0mYB2H/YwEI+GFoa7f5nEaqHyaPo4mbb7M/jyNr71gBBfkTVx4iDo
	1CvJvQOfHP04DflpNRy46px1dhh99My050bRb5qJLyAG+4iozitW5YK/LSLjmlGh
	TMVFd649e51uyqyLlqIgjOcUGebRbMuPmSnp1qdW3KgvpfbgASBG7hKEqEbLUAnR
	4PMeeuW0kgmqZyZH3N3eYiKOtxNK0qsloxuM6gf4kcRj6H9WaXnBEGFd0Tz9Ltcr
	BoumYGhQBOW/ThliQKoToN+s+EgX5PXnmZ+t9wmApU70yKWDUTSnsM4q5gv4rolB
	+UmEyQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqkqfrmbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 15:24:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2da19227bc1so12256488eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776957889; x=1777562689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9CDZxY+AicG+LQxv/gyUZ+B2R4sxcezOhmQw6qqkCI=;
        b=YdV+1Oj14GFpIsQERbOSE6aYmDAyCMXQPP9xxw/6Xxne+rcSi1jJ7VVh7V9LY60bfR
         JaTbtOTRva+2onb9m8LuRifJwxC9doW2+fncrrcSt6MCj1VYNXV5iclWcxJ2AhsrcY/J
         q6tMoP6GrRQwgKJxQxYZ+0UO5SlOWPoCP4MPcDBuNuJ/GowmhjlF70S9GysAhs++EfId
         DTQhdQXNxVFLaYUHGTVWrbgDUMtBvpGTydJ5mTiqoFJZJm3VUMKFl4jutBnuPCHt2oqU
         vR9b9susWZNsrYDeBGPi1+9GLModz8wP4Pr8Q1EbSmmD//yW29nj+dTRBOBbz2EaIZ8v
         OrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957889; x=1777562689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9CDZxY+AicG+LQxv/gyUZ+B2R4sxcezOhmQw6qqkCI=;
        b=Y0FJFhGOkxQPfzwuSXqR3yDTiLRkeYLbtgNwDhthiw/BUmj4qRlngeMh7vDdYj9yDR
         PZ9sHPpy3aagnpowH1ADw6CeqN1M81RoiHtueIU0CZQGAjQFS/F5NhMTTeZjmKcw+Plx
         No31IS5C5Od6bguO/ZCcbGyZ5kAfsuPyyfM9PQIVtcmWpGNZ7TQhyzoIOVzCMHDBt8am
         U5Tm41Sl+yflSxLWL6yRcU+24OB3w9LXob4faUgnCthbqBffPO0VJJnrI3IA8GJivFRW
         ti5BSWZUElvLpg7LM2utciOnvYrTsECjaBVoxQJ72CXEM7pagzSc2oV/60dw2l6BwirR
         5IiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SwobR2wDIpdNomMiWz6ZOSnB5Dojfn5LMQcU7aXBrq4+FwNBZGN28Qbv6dpxI7bu18Wu5EAp9p6EuC2H6uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlbSHYYK3TJooyKym+zA4FFmMeSopM6ACdf18qS633D3a+HpBc
	nNZqlKGiM4r9xQ94Xk7natocaPf41mrSXaByGgB59WhzP8MI0ddoIbhm+sRhfNz/em1aXGQI8qW
	VUIHJuRhOkl+NfyGSJfTImSKGGpK2xjlUnKAL65TdnwosePWbNWcty9rVuYV966pfQ7zg8g==
X-Gm-Gg: AeBDieuxWB1QBzsFXETC4Z36i8euDcReqP5XjxMhf24tICmfp5T3z5CYPnF0TI9CZGa
	+KG5E5gk+M9uN4wyDSQZOLwmC2XOJB0Bbljv0YyXsbszW9yXQP7vOlRMrmGm9PxbYuyXPxUNO3C
	iSpT9zOvJxMxY0v9nJ6Zbpsxxx73INx9pjTXxpVikSsntmWYHnRnj0cKqBqZf6j2+TbTUKue+fu
	xcR4UlDLPzf6/TE5EQfnvKZbPR1vit1DEYxSDetrhviFcAHejOCURMQm6cu+8Utwsr2JLUt1Ngq
	LWBnfKRDC7uQuj9PH3v14bZjHReR48M/vSkn4hnnXxnWzwq5nC2jweflsPVRphhXIxZwbfmBu6x
	Dwt+qpYY+QrADM2EULMO13QYJ7ut1WqMSuNwHxwMR2htyf4lzT9HIRJIHYZNKlgWQxp+mSpYqXs
	ly8/lO+2DbZnuZveMM
X-Received: by 2002:a05:7301:4593:b0:2da:10f0:a8de with SMTP id 5a478bee46e88-2e464db026fmr15176448eec.8.1776957888940;
        Thu, 23 Apr 2026 08:24:48 -0700 (PDT)
X-Received: by 2002:a05:7301:4593:b0:2da:10f0:a8de with SMTP id 5a478bee46e88-2e464db026fmr15176418eec.8.1776957888236;
        Thu, 23 Apr 2026 08:24:48 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e7025cf413sm23284279eec.15.2026.04.23.08.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 08:24:47 -0700 (PDT)
Message-ID: <caad3b9c-2c14-4e09-b8f8-840d2ec111be@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 08:24:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: use lockdep_assert_in_rcu_read_lock()
 for RCU assertions
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260422180814.1938317-1-asas1asas200@gmail.com>
 <20260423063020.NAero6Rz@linutronix.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423063020.NAero6Rz@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xDy_1wB6X8jUP7Ij7JNDNOTN-okG1EVl
X-Proofpoint-ORIG-GUID: xDy_1wB6X8jUP7Ij7JNDNOTN-okG1EVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1MiBTYWx0ZWRfX54Lr2TWzQ5mI
 wfULyBXfqANzpemI8oI7YQFORn0Zy8MrRXZTsXVnLhZ78ulozcb0uLoBCiCMANvAKXVUTsZguH8
 MW0KHGYN9CpytXCD+1/7awwnCzCLQulazW6U+LupjNj/er6N5uY1H+Fpy8JNMGbYije8wAMduNw
 3izRgnpEvsO9ucHwrPXNjET00vZn4sViX87zCYUJiBg2wGpqpaQG+6DcrRb/aMgeS//JlMnETtN
 oDRGlXSzsholC60b9iGqqTnLc2qfjS5EfX81IQDNFSSsxzMEAldJFGB0OnjzlljQt02ISgXn4UI
 QETOjoQ3uzfe4wn1tyEz3B9xB4SJIOE33LwQ+jSn89CMmdkJQUih88HoLdap1nFm1p+6JO/TNG4
 7QNKPxodV9sb1YrezJAXv1Laz4b1A45QQAOWg/8+dnGDR5/nFdp2nbg9BfZoWV5rGv574k7IbI6
 kIk4wDF77MmEsxzKLtw==
X-Authority-Analysis: v=2.4 cv=ablRWxot c=1 sm=1 tr=0 ts=69ea39c1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Neo_AiBHE1Wlc-BSriUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230152
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35244-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linutronix.de:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9CDC8454857
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/2026 11:30 PM, Sebastian Andrzej Siewior wrote:
> On 2026-04-23 02:08:14 [+0800], Yu-Hsiang Tseng wrote:
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> This could written in plain english as in "Tested on …". Not sure what
> this "convention" is but anyway.

FYI this is a long-standing convention for the ath family of wifi drivers,
dating back to at least ath10k:

https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/submittingpatches.html#tested-on-tag
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath11k/submittingpatches.html#tested-on-tag
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath12k/submittingpatches.html#tested-on-tag

> 
> The change is okay.
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for your review!
/jeff


