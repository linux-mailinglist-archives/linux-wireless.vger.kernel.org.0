Return-Path: <linux-wireless+bounces-38394-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id smevBxfZQ2qAkAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38394-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:56:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 153956E5A25
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 16:56:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Wr0/59mF";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OWg8F6V0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38394-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38394-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34376300BC56
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CAC22370A;
	Tue, 30 Jun 2026 14:56:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464823BB9ED
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:56:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831376; cv=none; b=JKjwuBWpAJ0qEkN9GeOjyI/mU0ZxH5AamF9QAxzhxfxN/KbNQD2/qId4O/C0Z+hHDd//B9O4CAA6404qoj3oqg57vLvveaFoiy8sGndZ+2e3e2zXakus8Tw4ATIDEq903ojo0Hqietxf2JdE3bjRqfmREdr6WFezKXS+m5irvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831376; c=relaxed/simple;
	bh=L5Lwhy4eroz9T1Ks9h0aC6xjEPwY9tHUk8isUGec8O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUrVyLzViCJhY3JJg/T2e/r1F4HQf2KBXdvOzLXSo9BENK+uatvxyLXAHm+7HCRwKLYgExTAOY3QT6bwWVfW0/sIbB1KoOm/wLQFvFeIqbeH3gTA6EuN5QwkXky5/vbMYD31diAgVuWasdCKhjOY0ItivxadhjgAFsgu0ycfpIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wr0/59mF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OWg8F6V0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDGp62216877
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L5Lwhy4eroz9T1Ks9h0aC6xjEPwY9tHUk8isUGec8O0=; b=Wr0/59mFc9OTU80n
	nXLT2cQCdAV9GJ3cu5zPIhSXd/2XztxVhHbqZHpt6P7nZbkiKKRZUYJtsSVrc6zE
	HPTE8IuqMEFXeGRWJtGrdXNKcOLL3JEFdBG0mLvCq1hRiAwX6dKZFdUiXL4z6ytq
	unzRk7zoN4F7o4GtOdybXzQqT5dtXQjajm2j/CGsk3P6ABiCIeIdj4ha8eF0GNh3
	scrDIbjuMmuHCtbcvuotSMhcX+ps9q7zs9rJVaZEOEMGeETpmfsUh8XHDzkgtKjl
	9E3p65bBCLcYhLtNL0UqSPOhsuxnNgmPRXTKZ+IzT80psyxTVYDSgpmEO0i+C1jL
	mUm/lQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfk9ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:56:14 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-13b0686d13eso6256163c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782831374; x=1783436174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5Lwhy4eroz9T1Ks9h0aC6xjEPwY9tHUk8isUGec8O0=;
        b=OWg8F6V0MHbmnjDFfZvdIYrCrWE9kE4Ep1PsJt9XJpAHB08jfwHUeieUjRJZycuRMg
         EktpM0t4B4aPzFhnJRpew3cr5tG0ko708tqbAWCU9osJPmjb1sSZvssD8igw4CUkmfZ/
         9QJNH302sA+nAPqSNh9HtW9t98Apubht5NsaJ6EX+6m3meTXgwWOb945wxkP3P5QVPJ8
         06qiCofOT74Trwf38PoGQY2R1nelHTX8MsuCKXLA3zZ9oLN9RFkXc79FLnwj3DyWHC+W
         N0Uqg+JpbUpL6EMb5817Af65BBCAmIUyHZ9v8dDnR2x14jHAQAMYmq143Pu6Sr96+jvO
         9J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831374; x=1783436174;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5Lwhy4eroz9T1Ks9h0aC6xjEPwY9tHUk8isUGec8O0=;
        b=b70vSC8g3e7i8EhdwIf3beQ3md24lHiua7jNmld+08El4bkD7YzvBy3y0Oyt+8xKN4
         3EHi6YRw8C5Yyto/DjMEZL/rxN2xE7sX/AubT8NbKaYkNxM+7lPonUNElqoT1O+8UGti
         wfDPwBletxb99iFi/jsgMKEeehogBcqTsCC1TkFQ/l4fqAfPLfFlh++nSDg6HMU+pO9F
         CiiOviXCpbTyY5DwNpD8+cy2heBtyco43omWoj2F1QaR2eK5iNT23Xthh1FJaZzRKqMr
         1eRdEvhmfpkwN0mPwluZMAq+Qrat71pivXlqPDHSRFT3WTCMm0IJVfwO7f3FvBHSx/AW
         d7Ww==
X-Gm-Message-State: AOJu0YxvmoRPc3RdjwdGo0Vn2bYczKUSfc/KMpGDX1jWuOZ/tFjegFm8
	hv4J4rVfVoCA+Gdntsvt6d4wa9w+7VwwtuNbZSUidSGtLMZk9Impoj6Oo0xdBiDZH8AySrMeiK7
	IxKQIKTjqz6jrz/4HruW6eZ03mlicHhYEc/8uzkHTknd9+9xFXXQmDfHbcf3qCqSbV2qK5A73+2
	6MKQ==
X-Gm-Gg: AfdE7cmDPjpIaPzHKuqLytj3x7H54xe1QqQE1gwsX+hTGZ3We3j1GW0M7Rneb+DF/07
	hth+ZhLuhxnzbd5IhzG3nybXZqQlzo5tHc5NjJmAQaPT/HAWvKcanhQkV64S06u9lQYtaReZ6yp
	rJhzPOGUCTrkzEqz57hu0iOUnU1Dv5+lWHX5MqnIDvKEknRE5wyfkrFjF2l2v+t1yUpPlFZg++P
	/5mEY9uS8c9KBO3vdTLnNXZJfBgnocshWStO2YNSHekRSATMSq5LVwVO5uNMK01LFuL7+II+I5G
	75aSIQ3dbTANFkeLEgt442zMsTy9rbIw57yctsTqL7/oOrHAPlSEA8gn0d+YluazfR55OhWsPvB
	3UuPBKvuofQDR351zeVdT+na2uNyNgj09PYkGXgCgtQQxStQX0dJmKgbpfZ0XCuRia6DI28E=
X-Received: by 2002:a05:7022:672a:b0:139:ed5d:3b9 with SMTP id a92af1059eb24-13b2a1db527mr2558602c88.50.1782831373829;
        Tue, 30 Jun 2026 07:56:13 -0700 (PDT)
X-Received: by 2002:a05:7022:672a:b0:139:ed5d:3b9 with SMTP id a92af1059eb24-13b2a1db527mr2558575c88.50.1782831373158;
        Tue, 30 Jun 2026 07:56:13 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab21932sm9280479c88.5.2026.06.30.07.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 07:56:12 -0700 (PDT)
Message-ID: <dfc7b6a3-7c76-401d-bdd7-8f4a036c0ec8@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 07:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: skip unknown direct buffer ring module
 IDs
To: Nazar Mokrynskyi <nazar@mokrynskyi.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260505172415.566328-1-nazar@mokrynskyi.com>
 <20260505172415.566328-3-nazar@mokrynskyi.com>
 <89f30996-3210-403b-8c9a-52cf6d5fcb51@oss.qualcomm.com>
 <07a1e340-cfdf-4027-861e-8f2a940bd21c@mokrynskyi.com>
 <6f46ab6c-c7c0-4865-a68b-992ace4225d8@mokrynskyi.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6f46ab6c-c7c0-4865-a68b-992ace4225d8@mokrynskyi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _al32oa_D3GaaoJSnkn63oq1-_IIscsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE0MCBTYWx0ZWRfXxYhrPYZ1xJlX
 F3Xfct8/P5Z6f7qjWXP+skjZpeNp7/FIkECB+tWqRut1nJXYRaCwvzG/2ZIGzYmScr1cUx9zIAT
 6nSF3vY3O9N39TMrJqd/15JD6dRNSmitwnPV7GIiEVFowiXzBmC5rnAQPEWzQfVjgFxBmvdK11h
 72AJdTjPEXCjzei/BvqEFfzlyikD/Gp2GTTVH8mLVLwLjo2dCpMrb2F2H5iSVMb/K+rRrIU5BmP
 C4WO/L87Wy9iGDaPGU2KURNhx5zgQJRikGfJAetfn2xRkYbP0qr2bZKccZ5AoFdfYjHHQAJf6dL
 yQwH89e0IrFJt6AejTHi9d2N6JFiggXXmwnw5qN6/DTdlEWvn6lWJ5l81bOl1eS46eWw5BqUdo0
 2oMi+u34vOFJ9LT86WmbrcZU6yHNJ29Rb0Ww+e5eGhuYpe/9JA9j6Z66amdTegj4vSpnozxj39J
 rgi0NKB6s0suhMSJq+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE0MCBTYWx0ZWRfX/UF7Ukh+3V0i
 GBg6/RrEMyS8HDBwLtQcIB71b4XbzAMxXg/rIAWwdZc2OrtDQQRkjnbTrxkdCTN594wqOQSwRxl
 964IqE0UNyo0Xg+Gvg/sn88NBBw9RJk=
X-Proofpoint-GUID: _al32oa_D3GaaoJSnkn63oq1-_IIscsA
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43d90e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=LXdXwiECwZ2lVVnCtgQA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300140
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38394-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nazar@mokrynskyi.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 153956E5A25

On 6/29/2026 8:52 PM, Nazar Mokrynskyi wrote:
> Anything else I can do to help upstream some version of these patches?
> I've been running them for another 1.5 months with no issues.

It is still in my patchwork queue.

/jeff

