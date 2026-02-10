Return-Path: <linux-wireless+bounces-31696-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I71BSssi2lEQgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31696-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:01:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A4611B12A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 14:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD3FD3026C21
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05086323;
	Tue, 10 Feb 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MESHmyfu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fkWrURo9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0D632
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728483; cv=none; b=VxT78+LAsT/uURqYMwZvreZx95HHBwyHh0pTbQZiy/ex70LIPvTcksWDFVCp1kXaeiKFMGQXi0fTaXNtKV97JPROmF0ctbt8E4fvML8+mJiqWIBFJrsJRrawt3YoW1lVdVYTaYsa/z0M5rCdDU3Ap5MRw3CRrTp0/QSFNBadb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728483; c=relaxed/simple;
	bh=p3iiGQtiULvb0s5fcwxKU5c4fvbEJM9C/xn75EpLd6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMXXNye73Td+WkrB6CH9+nmNEP40bL4Zlu8ROFKunoRGC5RFydg4PIulc+NCU/zwzOfMV46ARiXSk0cLg++ou19+RJ4qstRTZWzqhnVio6wMltHqGC+QENTpKCfiIoZdZCCnwCUd5rsK7sTg+3aExSSml/dDFu4Ej0vmHME+C+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MESHmyfu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fkWrURo9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7FCBV4003551
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 13:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vtxekb8OY6Fevu+6/oomAv80ecqtYJrZhNWrilx/KRQ=; b=MESHmyfuNXylyEMu
	h9UC1FDXX/Jpw2kKnKBo9dM19HY3IzsHEuo2q8Ewc0SThqEzamdGjpxV/NYxxWn8
	PLuhcrvyaE6au9OZcgpx29b4mkb3xmaHIOkgEzTx+ZBh5Czef1K4xBp0xm5tTXLw
	1Rq2t3yTpnrKgfcZFNudN4Qh7ooWCUnmlJHN6yDPjTx9TXZOeMVxroBCvHTiykRh
	3kz7po9vHOoUpoD3sg5ZgD+58xQluptwrGNJ/ewt0S5poiA2wJikwYReVHvWQOXH
	tVuGEtioJ9kZ1K7S8AtadM0KKaqQ8xOxnXAJi82XCFJLRGDVbpVcXXUVaG29E3VK
	yN8+8w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7r23jkvr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 13:01:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a863be8508so56550445ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770728480; x=1771333280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtxekb8OY6Fevu+6/oomAv80ecqtYJrZhNWrilx/KRQ=;
        b=fkWrURo9qAsQ+B1eE1PCvZTzMiJI9h2TgN5sU7btqh+Pueb72SyVEmxEaduciuiJPh
         EvlJfksEyCxaRTab4/ERbQ/SPNl4ieJvLvERCUK8LJbGgEOpKFxEzY9/lzz7pTcoDz5Z
         3wQKfjQgHRmQpysrp17c1usc0LmbKkwZaQtfPPLwKMVX+e+jgDlXhdUIJyNPEe8fFFWi
         q77+vQDBU/8fbOdR40RQ5/YrCov7cD/Z14IRsP18612LPs5AYzSMu1m1owYqNmBZOBxL
         aiOfCezJOjWGHHugnxchtaB19+966TGfXOQjhriW1mPGOTG4Nj4F6oYp927BRSBozNVb
         EEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728480; x=1771333280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtxekb8OY6Fevu+6/oomAv80ecqtYJrZhNWrilx/KRQ=;
        b=GezNTg9dyfGSTCL7Dw+GyTabD+hxlK0coCtFUcmFVNEGqYGlPYMAiEmW+PgL7ilPr7
         ssL+AQncrU884XgAzY+i4nr5rOPlcggouR7BN2MIBw5jg1wzueO155upDaUWWw18DLj2
         8j8zyjFRMXhzEyAH9xEWscS9OAgO9QeGnzfvoIu1MDW/MDn89zN4V41chBg/EiZ/9oIq
         RLEt6x9aC5UnFoJcVJOHIirLXHFosBryFC3IS2GwltM2ZEghcpV5D8RS2tZKfWI/jn0r
         HiYrjS5dLYLUyezQCFmIQ401E1H+tPn0G3BBii4WaHzoolKsh82P3XnL89aynRKL3Pd5
         W98w==
X-Gm-Message-State: AOJu0YyFlZR0NGUnqxFnAdw3CrE9yapRz35PrurSp6rGt7jK/GQvhlYt
	YQG+xp2/IoGrrbua61+K1iVTOCJirAVwOrL3Z4NXq0MoXBB8ISihWaR/QyrfsPGZ0xAc6+N7kwK
	9ymFQ2pwS85qa+yi94A+Yr9W3CvNGwJyTJh1z45R3EyR+VjDT3Sw1MR5V6Mkfr71EXKcyCA==
X-Gm-Gg: AZuq6aKIHGjdlgPJs6JKeUcx8ZH4oR7kwrJ97AUlCfI8gXbO8c2CyEk1g5qGHkEK7Q5
	jdPYUhivPH31eK1JUbMBjLsIvX4OcvTsSHdJpEqsC6Hs6epeBUzWDPXJNlAvDYbKZeUY8BLVkDt
	74udj9OPK8xGYtJRhagH/5yUfvUQAj5gSRIvziuGeoHBQJ7rFAA3xgtLoTjvXZsQaP7jLBc0pxL
	8rqb/ynDfE8CDyAiF0Sb9noXDWVYu069ZNfeetk/nhBGVM7DFkbCQesIM8AorSlTLJ6/U8N7Gk7
	Fp0piJCFngXvD3Vrg5kZ/GHoD208wgx/7kCA2QFL+yqXLLK/LnU5PTsNu0ciRp+BdcD2Gzw6S9K
	QYBQLTnbXlvXyssvCZhsK1ScQ1qV8bKykZ7prHTLOZSPQ05s=
X-Received: by 2002:a17:902:e842:b0:2a7:7e00:6a96 with SMTP id d9443c01a7336-2a95165b8c5mr171854475ad.25.1770728478907;
        Tue, 10 Feb 2026 05:01:18 -0800 (PST)
X-Received: by 2002:a17:902:e842:b0:2a7:7e00:6a96 with SMTP id d9443c01a7336-2a95165b8c5mr171851505ad.25.1770728474256;
        Tue, 10 Feb 2026 05:01:14 -0800 (PST)
Received: from [10.152.200.28] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9f5esm143213815ad.51.2026.02.10.05.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 05:01:13 -0800 (PST)
Message-ID: <4a7f19a4-97bf-4dae-9020-27da3297fc68@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 18:30:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Fix AAD/Nonce
 computation for management frames with MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
References: <20260208081854.1080048-1-sai.magam@oss.qualcomm.com>
 <ff9330f7e17da9c7c1ba87b9400051a9bec29aa4.camel@sipsolutions.net>
Content-Language: en-US
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
In-Reply-To: <ff9330f7e17da9c7c1ba87b9400051a9bec29aa4.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMCBTYWx0ZWRfXzFD+cnwL8tLx
 zd4Gvm7I5Nek3AWg/+6eJUBKZ/U17U0B9GscZioGLahrp128dxnG2yW3Q+skvlcdh03xQ9XOxSM
 oisyyiIS35QQet0X5IlhF+s3XZPCi6QQ2coYch0rdl9LU7DSigrk4Wci3UWADmt2dXhYAkQUwOH
 Hb1w+WZa2pBSC8HvtYYfmgR2pBsEok6a2IV458JrjHHYlwGisyhmqH2WUUtpYgXYwgz+0hFE3Pe
 YVJBSluO2+/mk+pfyO4k/FcnTE+N+nX43iCCEOJ0tA+OF+jKde9tIw54mtoWGO6ycqYyMmkFJLZ
 7JfnebqjyPomOMEVvYWvxScp3ND/t5T/wk9UDsIZzFakgqlpFaCAcYOVQ8VZd7LP1Mx8q2EP2bo
 zZQpNxc0uDi38kR2sJ60ZjwGA7c5kk4ttugo9+E6dJj26QMsDAk+2ObLAE0BAiYzwiKCJM4ZgUC
 WN7AngKZUbv/p4q1LUw==
X-Authority-Analysis: v=2.4 cv=MLRtWcZl c=1 sm=1 tr=0 ts=698b2c21 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=stkexhm8AAAA:8 a=wZa_fFI2A4IWcTa_QrMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-ORIG-GUID: r43HcOjGi-Ou1w_0JPlqK0kjpYk6IEOp
X-Proofpoint-GUID: r43HcOjGi-Ou1w_0JPlqK0kjpYk6IEOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100110
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31696-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:url];
	RSPAMD_URIBL_FAIL(0.00)[oss.qualcomm.com:query timed out,sipsolutions.net:query timed out,qualcomm.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sai.magam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A7A4611B12A
X-Rspamd-Action: no action



On 2/9/2026 4:57 PM, Johannes Berg wrote:
> Hi,
> 
> So that looks like a huge improvement to me, nice! :-)
> 
> On Sun, 2026-02-08 at 13:48 +0530, Sai Pratyusha Magam wrote:
>> The hybrid way of having both HW/driver based crypto for certain frames
>> and SW crypto for others require that the fast-xmit path be skipped
>> when the above mentioned key flag is set, since data frames still rely
>> on software based crypto
> 
> I can understand this sentence in the sense of "A => B", and it
> describes why B follows from A, but ... why do you even need A? I.e. why
> do you want to do this for management frames only, it seems the encrypt
> function and having hwsim worry about it should work just as well for
> data frames?
>

> If I restrict hwsim [1] to only pairwise and CCMP/GCMP (clearly it
> doesn't handle TKIP due to Michael MIC, WEP is irrelevant, BIGTK isn't
> handled in hwsim), then it mostly works without all of that extra logic
> for me for the tests. Maybe need to think about IGTK here though, some
> tests are still failing.
> 
> [1] https://p.sipsolutions.net/d101bc31582cadcf.txt
>
Hi Johannes, Thank you for [1], yes the extra logic I had added 
(IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD) to prevent offload for 
AES-CMAC/AES-GMAC, i.e, MMIE addition for beacons(BIGTK) and broadcast 
robust management frames(IGTK) and for WEP/TKIP cases was not needed and 
the correct return value in the set_key ops was all that was needed to 
selectively offload encryption for CCMP/GCMP. I missed that.

Today, I tried with [1] , removed the redundant logic around the 
additional key flag this patch 
introduced(IEEE80211_KEY_FLAG_MGMT_TX_ENC_OFFLOAD) and data tx 
encryption offload, i.e ieee80211_encrypt_tx_skb() before address
translation.

I was able to pass the existing hwsim test cases that include test cases 
for beacon protection, broadcast robust mgmt, WEP/TKIP, unicast/bcast 
data and encrypted Assoc (EPP)




> 
> But if we do that (even if I don't like it, I'd rather fix the remaining
> issues), then you need to document reason for it.
> 
sorry, I did not follow this?

> johannes


