Return-Path: <linux-wireless+bounces-38195-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gn7OLWj9PmoAOAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38195-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 00:30:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 241D26D06F5
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 00:30:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ILKppnX7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bx0iJbEB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38195-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38195-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2811A3015A71
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2873AFD01;
	Fri, 26 Jun 2026 22:29:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6223C1989
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 22:29:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782512996; cv=none; b=O00aMT8n+9G/UX6JMgJf1WwPRFoAx9X7IAteTPqn4X25oQbChn7Eq8cB/UvZj8QhmH3paQoBNLMIF1E3uMsLom1m8NIj5Y3wpWjxY3Fbmn62/lYlB1rJoVGzpR57kpO5UyocN9xRtWex+/hFKttXi6zr//8a2Dijs3ec/mzHSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782512996; c=relaxed/simple;
	bh=cpTIccj1jSFJcXJxkNvk9/xSpYGk0g1bhthA7MGUXpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0nfd2tncTR/F9mbb28oP6iHavmQ2r/T1RcBgq57KjW3/EkBA8oxqOVCWYZBKfBvSbF2JCV3n9SKuTWl6YxIGaL4GRHBrsK3z4ke+cQRo1GKy4YSM9ozxcm0urDAcgLN+6B2fpClHQ3aIh85ayIytabvxm8MLYVQbjFFyTrbJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ILKppnX7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bx0iJbEB; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QJ8g1w2005194
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 22:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cpTIccj1jSFJcXJxkNvk9/xSpYGk0g1bhthA7MGUXpg=; b=ILKppnX7QLtEwsQn
	h83gwfk5PKqOYothTWR7zhuSoQUttv/rg0G00mvtKQGDNe+gxLpaXfRcNn47Bp/6
	mbj8EIUCAek6TiG7GMCdNSsfKh72neDI+y9KwCGkSxYYqrvWDPOngs8hwfzzWN32
	aWiW4aqRjFwKMctkI5KvJT1OsI7wvdYmVhZpejrVjAx6TGiQzvbX0m/kI9jsRciL
	HB96eeyHN5IA9jgLT2hFjIauBoo25rGAia0MxA1kgypui9nMumsK70LxFVl26Z16
	BPAxApOvQjQZl8MZA9AJ41ZU+aNyw/JBuGsbuvmhOjO29jeoB8cdS2gLV9Yf2+xy
	AxQLbQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1wsdry24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 22:29:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1717878eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782512993; x=1783117793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpTIccj1jSFJcXJxkNvk9/xSpYGk0g1bhthA7MGUXpg=;
        b=bx0iJbEB+rioViMrp14JmuDwHkJ5QSbbqm5VHbK473cTTjrnoXOY2lVvuACAISBstF
         n+g6L3sPhtkvn7qV0wRoAEYR00t6FK0mKbT3ZyTw2hQpq9XDynsllCnWZqexRvmvVq88
         KcqPPTyjxjPXGUTQDx7tDzWPkacj6eapHbdfn5L7DhqZEZG1xzSC664bFC3H70fZ7vQ6
         R+5aqrKrhU/vj95kxETn7Xw507n2GCUujPy0B4Qb5IPf2RMvj2PDhwhkwHj/5o8Fhzi1
         m1bwUDbTUkTrT8Z6wKTxI9TRl15zQQBoIQZSch6nm3t9qOF21IuGtkGhcIztMChl44B2
         Ub5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782512993; x=1783117793;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpTIccj1jSFJcXJxkNvk9/xSpYGk0g1bhthA7MGUXpg=;
        b=RoK/OypEVzd/IZ/r2iyoH6X/1hv0xuijW9Dant7xD4dauEytEYXjtkKyzxUU/ZnNcf
         5AYySTlLFVaEDilj1Ce+4tKN/f1mouCNazZVFrG2OpCLcr3MBXbNi6eXXf5yMuitiq4p
         4hdrRK3yMoi3LXIl6HqzXUPHNkodwFTwaohW6CD4tubXROt5C1DRdA0S/lwBpwFJfOHp
         2XysINVyaMvxJADGtqAJ0xtkbLQ41cqCzRmlR0/VfTLxORhMeioMLseB4QbR7Q/I1b0x
         mLFAddKpTluBIlLFp5CzIeM8UgGrObY0thiQ/rnuzYUg3ZemFKPuFGPlV19PZy771LFQ
         lAnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpylVIL2Evw+b8UcUN+WjjBa/ZtHjpOCV7KGIs4n3c1GdsTLtK8oklh/4hcBfY0SIuENvH5KfkR0r1EQFhI9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNs2l67XibnwkqsUwfzaJysvS1tsq3eZbZTxI8QSzXYMAoDmj5
	TdlsHO8GSNyu7kkdRAJ8UAmNMI+Bbex1YjesVN2PfsNTuR2B336GM5lLpQUuXoIsHyszAOyzpLu
	sq4EF78gswZynjBXk+qotF6vuy1MwZgEeIGIkapBbaJ2aVVgu7wi8hZVHKg1GmBIHW5/Mpg==
X-Gm-Gg: AfdE7cnEUVBJnR6K5djNLx9pT07Eu5CYEw8cjLJloYhYlrEQpMqwMGTI2xd4zN+C3oG
	/AvTeew3MyxiwyYXHXQHeKsj6G15Op5hZlIXloMv9FuO13k8npvRGGxdkNAYWffeGbDgyXm3LDN
	ENyq/w5zdRiXvMKJy1NGMjQQInFaTkLFNJta5A1wudJ74FDNv8mPNDhquerIwP+RI/2YZaFwrqS
	dpAw1QY7voUX9HBHZXVW9i81b0y3I4/KwNqHUWrrwDYJaIF6hcGYwkf6FEBAn+EkKw1Nk+cHoQ/
	gKJOW1qaQfJJTcAekIPzGELs3e82m+QzIKIaLtJTFWvQnn9AWqDHgi1F+tZ6HyN6fTuHpo7vz+s
	xLKnVXSTdJvZJsYvlAR8mgMb0Cl+e8koP/e6R8eLzKWVWID7noU2v46NiBtOB0Y4enizQ
X-Received: by 2002:a05:7300:e410:b0:2ed:e12:376b with SMTP id 5a478bee46e88-30c84d9c58fmr7591917eec.33.1782512993299;
        Fri, 26 Jun 2026 15:29:53 -0700 (PDT)
X-Received: by 2002:a05:7300:e410:b0:2ed:e12:376b with SMTP id 5a478bee46e88-30c84d9c58fmr7591889eec.33.1782512992738;
        Fri, 26 Jun 2026 15:29:52 -0700 (PDT)
Received: from [192.168.1.11] (222.sub-97-215-84.myvzw.com. [97.215.84.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c570b7bsm20824461eec.12.2026.06.26.15.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 15:29:51 -0700 (PDT)
Message-ID: <a59d54b6-54e4-4d79-ab3e-6e6cd2233e5a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 15:29:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: reset REOQ LUT addresses before
 firmware stop
To: Tamizh Raja <tamizh.raja@oss.qualcomm.com>,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        P Praneesh <praneesh.p@oss.qualcomm.com>
References: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
 <CABkEBKYmknpO09Yc_hM0XM2ck3F8zjmgCuyBo96usXtgkGeo_g@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABkEBKYmknpO09Yc_hM0XM2ck3F8zjmgCuyBo96usXtgkGeo_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RNyD2Yi+ c=1 sm=1 tr=0 ts=6a3efd62 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=i4k25I72rCCN9bAAQd7+Jg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=g8aG6eahwlamQC_Jy7gA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 6jVUm-0NBxhFA_RUPem9uexr3-7SPY-B
X-Proofpoint-GUID: 6jVUm-0NBxhFA_RUPem9uexr3-7SPY-B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE4NyBTYWx0ZWRfX/O3WqJWvqzHE
 xcXbsnYIbUAsXV3DeX+k4JABZWo18AQefbRmX3Ag03tojzdUjpo+aBXIk6KTPmvwSIPN5KFCNEM
 rnQZebPJp2JiKY7FsfdJ8ekMqIncBjQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE4NyBTYWx0ZWRfX8wwKSzBkCQrq
 nUdpfgQ9PbWp9SdiSazEtnvgo5m4s4xAM464qsfzaSroBtt5btXzK+ahgpfICLUkXJNtLdfOlEX
 G5MTN1rXN7mFvpGh2fifcFCQFgoHHCfhpu3Ho/ybjU4NFW2rEzyAHAWZIVGqjIM5PEZ/qwNvntt
 O0BU21odvH+yQ1cmAMmR9zUS6uUaxXrj8mrODsw6fMEfStFsa+P1xB6+oJMwvbdQEv8dEfj0B/I
 POx16KmQOLsZj+tCbnPifStNFPf7BueOetl5ZuUanCrYskSeVwWVW7uPIq2+XP/rd28MZPpVRBU
 Mg772Bjvqw51vJy9CAiF3e0oSv6dEJig2GeXuy4xCLwiBn1Xt7FqsZBvDcvqonTqmYoPPFgDQNu
 TOW11mnUACBBM+qBolnBjpki0ntniLOEI1y4kozfzUXTi1V2gF9hXHJDnVFIHuTk7DjvF+mCKJa
 hl7DJ7wIVWAFo8rbjoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38195-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:aishwarya.r@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 241D26D06F5

On 6/22/2026 2:10 AM, Tamizh Raja wrote:
> Reviewed-by:Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

Reformatting so that 'b4' picks it up...
Reviewed-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>


