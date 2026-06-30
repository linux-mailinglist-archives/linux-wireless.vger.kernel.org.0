Return-Path: <linux-wireless+bounces-38316-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W3mTA7NUQ2r/WwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38316-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:31:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C9B6E07C7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:31:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KbcpTCXy;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jgiEt4lW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38316-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38316-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED37C300BD86
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870303921D6;
	Tue, 30 Jun 2026 05:31:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61234360ED4
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:31:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782797464; cv=none; b=KyJg9LaperdQF2PQ7oBj0Q7+HAUOEzt1F3SXZltQlVc0ID+QRrUBtscwWV4YJ5pJiMWNjEuhB0TEljYP+vbsW8MN4ApB2JvrVcoVUCMyKgZevshnxuLJHmA2EBsvPgXZoeNv1YBRe53JvLEsojapfmKHP1/35UcbiISMhrz3m1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782797464; c=relaxed/simple;
	bh=mLnezUI54YXWT2owCQATvsfP6pQai8laIAuzreGL5SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjffT32bk+TPEgtCH7DWDFtQ//jUIn/2sH7zIAzbQINknRXcTAkezoXl3pzdVcfu49HY0iYZoZ6qJ/Vv4EhnHEpuZAuYyEn1FTJ6kSTgkMneAyp6g/3RY94cDIdOqemScGFgZSDAP5HgC077YrcuxusSJKu7MwFSdeuJItVdmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KbcpTCXy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jgiEt4lW; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U2J9ML515695
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wXOkF6nHrxM611sZfpXBYGGRvXrxtTKPNCPO+f/c4Qw=; b=KbcpTCXyotZBz5JY
	W3NSHQ+AxhZkAY3XxSbSncqNs0ItKoBXMF8qTpAGjNoOEAj8OKZfhwD0VTkvjUo2
	Kmv/BhSf6mwC4Qb26sdBqKZ/+PDiLzskeLYUqyiVcyVSgdIsk6qdDnlvJzBLaYfd
	BIKAO4ekZefHcXPIVPi3tT0SXqBB5fWP4vh79ubeO9UkAKLt7w2Khb3zEE9Qg6zO
	3hrMX2Bnx3GYZDpklA9WadV1oFFtciWBbH3j8DtPaCYeRqggwVzCVEg10ou4tiZY
	tZ1iV6YakEoE5GJlmTOSCZPWCi1KSmtUoTDa+GmhNjwoO/upze9CxR3+9jMQrvhD
	TaABxg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp0k5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:31:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845e3ede1f9so1863312b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 22:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782797462; x=1783402262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXOkF6nHrxM611sZfpXBYGGRvXrxtTKPNCPO+f/c4Qw=;
        b=jgiEt4lWV+qY028ZtdGE5Cea6SpmtJVIq6Z3C5q3Eu4SYdA1kNj7RZ9zmRYCemPuXd
         Fskjep0opmZueQd0LXPT4aBGO0RbenTA6jyHrtPePAMP3UIgLywQ7ZNZDhdE41oeRxyw
         Q4xF/eiXlju0wv8cNa6ykyG8XtKmKXsDf4oY2BaefokLmraj1A2qTG/4bWJu646UIKTL
         ggCB4YIKfAe06y6VGunapr52ssAiUuni+Jw4niFknPHGC53pgGpp4pPjlWQX03/PbUXe
         xhyOtpH9Il+d0kDfbHoY+L6E0jYp0+AsZ0Axk9eICt9YOLsHtp9sG8NerdR86oVsym1e
         aojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782797462; x=1783402262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXOkF6nHrxM611sZfpXBYGGRvXrxtTKPNCPO+f/c4Qw=;
        b=J+kZ3e+npxpdeTf5NmdGgWqyGoHdaLVubKcXNsn0MXsDE5OKtr/GrtDEvtKaErNYaz
         YnV5e0jSTaCy1rgz6Uixnp40FnIF4Vnj8tQuEhdrb8NtxQwMtrNFgoR3JLxQU+t5zMXD
         CYmECnYAtz1UiQ5QsQCx7tIcCI7meHR8sf9m1tX6IcqwQcP24zP9zKeti/Iyge0D7gyV
         t8iQ4orazA4vJyax94Bl9lW732ds/7BVdRNxZg7xwOQeG7+FB/+tr90VF7xM71jV8piG
         b5FL+FXBAx64JPFyciiA1ca1gjaZyQf1A1Hp14JEZO/qUiyj7edYY3XiAAIiFK8ZPv14
         w7aA==
X-Gm-Message-State: AOJu0YxGpIw9pG/l6q4L/JhO+85avKTBoWw/C+joX6W5XjF8wlvREjLo
	bcJWKjyV7oKz1kjXuY8GB1luJFVhEWsuWQ9vTIZCkmVpZXJFFDlC4hsR6+Dhv9jBXoyV/o5tgCZ
	G+OjD83CeHzR6wwORulvICnfcKDzhIYTshV0kX+X+7elPnisHJy0WRaWf7BB5xi/YunJ9kw==
X-Gm-Gg: AfdE7cnFl6QkV1MLGy4Vw88l3CVbL2o6k20rN3oEniBJ2krirRF+rEacYrn77HCT0x2
	K222cgpm7wEdd/jrmVXjKRjlUt768bUsN5WcsX/Psd59tEB2ckD4eVpHavnEMTGLhT9Y50cQd7v
	7cMB3yk5kmWsGake2eAmSq3s7ZenO02hZSb6e1IQKAmwUR/oCKTPT8w23/e0sDcY5l1xpdWpxG/
	Q4jrUhHLQe9/2Qsfpqv0xsTt0Oft2GuJ6TvfTe4YZ53tlgULg3dZOfGbiaAsPWsagLt4Uym6wL3
	qOOF3sPqv/LjqFwd01SXL31WsexRexpGNR8/dC3iExrvKlewfYU8u+jyRA7JIQAM/Lgo/9AA8B1
	N3aEAdxWRi0WCLHbX0LIejyQY1uBOGjE/I1T0o7J+PJ4i
X-Received: by 2002:a05:6a20:918c:b0:3bf:6c07:b2ee with SMTP id adf61e73a8af0-3bfc52cb7d8mr1910883637.49.1782797462083;
        Mon, 29 Jun 2026 22:31:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:918c:b0:3bf:6c07:b2ee with SMTP id adf61e73a8af0-3bfc52cb7d8mr1910865637.49.1782797461631;
        Mon, 29 Jun 2026 22:31:01 -0700 (PDT)
Received: from [10.152.193.243] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm804560a12.19.2026.06.29.22.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 22:31:01 -0700 (PDT)
Message-ID: <1d307fe7-49df-4616-bfb7-e2050c5ddacd@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 11:00:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 3/3] wifi: ath12k: allocate HOST_DDR and BDF
 regions after Q6 RO region
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260611033314.2330-1-aaradhana.sahu@oss.qualcomm.com>
 <20260611033314.2330-4-aaradhana.sahu@oss.qualcomm.com>
 <2d776c69-51d0-429f-b716-b5302d657047@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
In-Reply-To: <2d776c69-51d0-429f-b716-b5302d657047@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VlFwCvugx1ZM1GVhUlJBauUHnMr-z28z
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a435496 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=GDVKn0GNZQE__RHKs1UA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: VlFwCvugx1ZM1GVhUlJBauUHnMr-z28z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfX3XSz6f3uj803
 +Z/Wc2MDbS3/TNGIC/JviK/W1U7vXY9H8KNdSIrtctCcioO2W/k9oGi9QuptCTCqeYC1Rk5fWoj
 1RPdtYnYsTE2WwQsYFVmmAw+xzH3IA+rmHmxszYScmN0vYtRceb6YjRXgjZ+N48Zvx7wwwhW8+F
 ibIbbGQKJ98GqS2FZLikkArpJPBa3JXhF2EIREO795GHu4xAnvjrZqMqut5aQBGZYBtOD6bqc/v
 dU1UYx0sCuD5u+Ffrz4A2ivU1+O5HNKnKW0nbDUXsRTKUp8Oie8tfgGr5O0ZN6wIE0fekMJLqaS
 ZEu85cdyWnXSQRnbtRiwn2TmcfRIy34ELyMiDPeflr7cZ38Qxjv9LjU4v5bMwI5SaRkHDyJNU7j
 DhUR3+ACBugjNuDM7WtEe92B9CRbwUGu1Euyz9Vf58693LGLmmaehWHu+G2NmJxSIoscdu2Pk4V
 R4qvFxvolnLcJOhN9FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfX50qXZb2ao0NK
 6UMd13QT0Ku7pVjdFT4DKlWTfDpBrQdY3GaMjHpmW1EWYWOTi2BsOPIrPbE9hnKxf6oL8MipW0G
 HNfGzltH8LV/XgFBpsfRdPoa6NRSwmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38316-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54C9B6E07C7



On 6/30/2026 6:06 AM, Jeff Johnson wrote:
> On 6/10/2026 8:33 PM, Aaradhana Sahu wrote:
>> @@ -2781,9 +2781,12 @@ static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
>>  			goto out;
>>  
>>  		avail_rmem_size = resource_size(&res);
>> -		if (chunk->type == BDF_MEM_REGION_TYPE) {
>> +		if (chunk->type == BDF_MEM_REGION_TYPE ||
>> +		    chunk->type == HOST_DDR_REGION_TYPE) {
>>  			avail_rmem_size -= ab->hw_params->bdf_addr_offset;
>> -			res.start += ab->hw_params->bdf_addr_offset;
>> +			avail_rmem_size -= offset;
>> +			res.start += ab->hw_params->bdf_addr_offset + offset;
>> +			offset += chunk->size;
> 
> avail_rmem_size is size_t (unsigned).
> If bdf_addr_offset + offset >= resource_size(&res) (e.g., DT
> misconfiguration), the subtraction silently wraps to a huge value, the
> avail_rmem_size < chunk->size guard passes incorrectly, and ioremap proceeds
> out-of-bounds.
> 
> So seems there should be a test to sanitize the DT values.
> 

Sure, I will address this in the next version.

>>  		}
>>  
>>  		if (avail_rmem_size < chunk->size) {
> 


