Return-Path: <linux-wireless+bounces-38528-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IAVPE8awRmrGbgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38528-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 20:41:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E36FC32C
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 20:41:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DSxXa9j4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HcXisEQC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38528-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38528-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2B231E8761
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67CC346FB3;
	Thu,  2 Jul 2026 18:06:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C1339719
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 18:06:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015583; cv=none; b=MfjAMy4XE//Urr7zdrD9hqEuvbGTmd01RDtf0/7S9hea/bZ7z9ZljZscAgKfUBsb5RvivDo27djqrGMkt9tPE8UFPzoPD92nIHtRBvx09ljrhaudMffh0WzbFfSarsy2o4Cd6h9Q9mlqZcNX3izrzPHUZvABl+nauBJynzeZoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015583; c=relaxed/simple;
	bh=zWJEmjyvqcMyeuzV8tn7G0eL/VomiTr+4CoSU0Dx8KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhqze3+M7h5SRWKO8t9v3SaWPPpytujgw6jwQk3TbSy6GnJzeOuQo2+EmlLlsrSX34p0stjxIM0mjA0lm8bxlOGUq8j/Vlp10wmUpvWGBu5BHNjg88vZDwEfZ7hx+o7NE2Tx4Q/4uWJza7OI8jda0XN++NMGpOVVBDlPJO+Cisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DSxXa9j4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HcXisEQC; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3d26560417
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 18:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NiePhak0dMAegnCxGrFfwKb+IHV27vZ4JEKE5uV61kc=; b=DSxXa9j4COb6M8/T
	D2IiS5GmOs2+NrEqSXVaY8OrF88Dt2YszNIZBc2b4df91iB5OoUXSELXdgwDYf8U
	x3F86PCpcYi1YWqyGNMJbMWdDzBITL/uvdfNDRn0p+nusu1EiJ2hR2c79QQVcYLg
	78eaUQpW5nB/DxVrCMRKiEz/LIlksWXiJcsfU+3y2qjzMfkzGTClCDChhKiuqJOj
	w8P4L6dXJ3wNoQWJT474AOsA63egDwvMBi3NJHo3UIU3hQicBx8/vmcEnYu16lKn
	iTm6+j0f7NtyZ8YQXtCXd6xVRVJUM6PnzgtSjJ97Yne6YntgDQJmz+6BvsM5ZBVM
	y6kGDw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bj8b0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 18:06:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c889d1eebafso3973132a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783015581; x=1783620381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiePhak0dMAegnCxGrFfwKb+IHV27vZ4JEKE5uV61kc=;
        b=HcXisEQCN2Nl5C7UWQ/g0i4PAfJ1Rc+7IJX+rlXayGidFpBtbQutg3DCR3USPlFgZ4
         r3nw0zDHetFIEvPpdF0fUvQ1PxUG+fYnlTcBj8DbItpe01KncwO/TwydzeFYoarQb/ZP
         ABHFUsIybYt4nIaU/BsawmvUsxRlsneI8AoRRJinxlN9jqRRMuJwYfrD9QpODjerqKYY
         3Qui0YkRRbCBp/2kFQmGhszYV/bkfFg2MHxSsGy4+njRmgizG6YNYeprsMuZQ+2AYw8r
         HrmphaM6evbWiP+cs6WZKV4vtuy+/FgNv2pRhQGoKTvnmimD2rNKDHpfPsYZ1I1fn/KO
         nhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783015581; x=1783620381;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiePhak0dMAegnCxGrFfwKb+IHV27vZ4JEKE5uV61kc=;
        b=RNR95jsCyptRT/vgRmMWFmQsunO5Q3nTQ/RBqsflSYiSc8zhPRAx0zKgmI1T24rnQT
         8HHeJGWJ3fSt4tdMCrPFp7i46PQFc9yLyzQWHh0hPW84rmetdKYcgQP3oljvzIAazygy
         OaNRBFlCXyybJM7FJQAqF81q3BFGWOcP1IDwRoCtx+WMePsRWOlzrrNIQscO0MKqDnRf
         AFTD/wRjkhFtIwpjhFfGeV5jpWkngxcXQG0uNh02RrdCS2r1Omfk5/h+5F6/Vek5P5LK
         Lre6LkfdTeY0PE7LQKMjY33JMKWzf5IrLUlttiP4uHLsrNNAkljw/wofPM32pQSFrz5q
         BeRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jCs8sdmodXOGlJ1ciDVcLJl9RabEEPAMpgUHUiQnygz5TraAYfngao67xFzn5trqqye9HsAzaoIDZYuB9SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTJE8aEt2175EkbheyQThgaaBeEhhySofYIq3yLxhpIKPhl04
	0LDi1WlEj8VyO0sTuqWTiL0OrOwV+EZ/E+KPXCMMSE90HHKVZH3XofHI5rXZEd6Y3UeUrlQaUiS
	4A8fhcE8OAXWH0hUPGYoTP0/KW0ummN7H0qvyYsFlnzbbkLwB2J5knbJnkDwpIrg4l8VMkA==
X-Gm-Gg: AfdE7clKDZAyanvMibHYXO+hx52MeL72dx2uXg8szkrPjVe8ADfaauWzDYWDHk66Fpu
	UcOwwGmA3S4Gz3x2+hzCM5qIorP0NbDK5U1A8bZeM+0REUxjWcVVJ8vYWt8bLNHDISqLzn+msru
	gu4DZ6ZmzXH13K1tvSdVgPV9eoa6FIpMrhN4PwrJaEUcc4itrwYYL5fWN7WBzMVwaRJcg03KArT
	dOn/mFwwt8THl+C5ZWt2qe5nBf+KV/AHVIIBZLNB5EHwV0xrqDV3hLPeQo+jKeS8D1BVww9NCHS
	sCp2/WNJNUF/IVowfV73eAVxpfW9QuP5NxMeIC7+bNfCFz8IUIc8P3VONn1b/88aKxRLKnRfKZm
	LQ9oJ+ywSnRfo7uNPrgtI4kcNZCeCxaqj70dHfLv8tcBujpMg0tJHb3M=
X-Received: by 2002:a05:6a20:4c8:b0:3b4:8f57:3205 with SMTP id adf61e73a8af0-3bff4235bd5mr7540982637.36.1783015580527;
        Thu, 02 Jul 2026 11:06:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:4c8:b0:3b4:8f57:3205 with SMTP id adf61e73a8af0-3bff4235bd5mr7540930637.36.1783015580062;
        Thu, 02 Jul 2026 11:06:20 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.80.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc3ea61sm12164081eec.30.2026.07.02.11.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 11:06:19 -0700 (PDT)
Message-ID: <8dd4aceb-48e8-45cb-abe8-af7ece2285ae@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 23:36:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix survey indexing across bands
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20260702-ath12-survey-band-fix-v2-1-75b5bdf72a08@collabora.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260702-ath12-survey-band-fix-v2-1-75b5bdf72a08@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4NJYIvakikDLfAqBb__kRHlHdS4ocTMI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4OSBTYWx0ZWRfX1X2UsAGT4gBe
 RbnhMoXAAtN0JKFEQyfbc5YCXZIHmxj0Ui8cfTWcSlRueJEibblqGEOqZgxwqYarNivvZg3uqkq
 MJ+Fc9TbSuSbhd1sIr+MO4sSKTFLVHQ=
X-Proofpoint-GUID: 4NJYIvakikDLfAqBb__kRHlHdS4ocTMI
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a46a89d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=kllYWVK2JqQtNyhMtAlpJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=QX4gbG5DAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=Z1bz1sYHDrk7OavG6BEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=TjNXssC_j7lpFel5tvFf:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4OSBTYWx0ZWRfX4TJeZOISQOLp
 g1wPROrpm5kZde8IPIWdrhI+oF6dwCZBAb3wmrWkAykLdiW7yaIokIImgi91UmCYArubtKQd0lB
 m1JRjKxOi7KAK+QIlikLSolk67DGOaTipFIrShPJjI9ex9KXQVWdDJvbOVjlc9Y0DrZraui3VI/
 4eERZpjb1Go5XA311fYFqXEzXEjWNiomDI6ISQcDkQZq62w2b3VlvrCnziTO6m4aEYMcvSe+8w8
 bGEQ9NsfnpGMe5YuxMYO01EzSxv9GzPu4M2e/0HivLTBdrUNTj9YZkCrHvZ/lgj3+Yj6Mvl3/RE
 O3PJRXxzaKBg2mQEgQJkEo4hmVZPMXSltQlhbzb7g3cw+n//hi9OsI+k0XYhF8F3uBlZS/aFK/A
 LAJV8ludg98WaUayTo0sE+8EwOuQ2QZt+OU3AvakU1m11xK4N5cTyd/Xa2kNXJVdnXNsFapDJBC
 ZEg+uPBhASgiSWheQQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020189
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38528-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:matthew.leach@collabora.com,m:jjohnson@kernel.org,m:quic_vthiagar@quicinc.com,m:quic_bqiang@quicinc.com,m:kvalo@kernel.org,m:quic_pradeepc@quicinc.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kernel@collabora.com,m:quic_ramess@quicinc.com,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,collabora.com:email,infradead.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B3E36FC32C

On 7/2/2026 4:20 PM, Matthew Leach wrote:
> When running 'iw dev wlan0 survey dump' the values for the channel busy
> time have the same sequence across bands. This is caused by indexing
> into the ath12k survey array using a band-local index rather than the
> global index passed by mac80211. This results in surveys for 5 GHz and 6
> GHz channels returning values from 2.4 GHz slots, making the survey
> unusable on those bands. Further, there are redundant survey slots for
> multi-radio/single-phy instances.
> 
> Fix by moving the survey data into ath12k_hw so multiple radios under a
> single wiphy share one table, and index into it using the global
> mac80211 index. A new spinlock in ath12k_hw serialises access to the
> survey array, which is now shared across all radios under a single hw.
> 
> Band busy-times Before this fix:
> 
> 2.4 GHz: 9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 5 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 6 GHz:   9, 2, 2, 2, 4, 2, 10, 16, 4, 12, 5
> 
> After this fix, times are independent:
> 
> 2.4 GHz: 23, 5,  5,  12, 2,   12,  26,  5,   3,  1,  27
> 5 GHz:   30, 40, 29, 27, 118, 118, 112, 120, 11, 11, 11
> 6 GHz:   1,  0,  0,  0,  0,   0,   0,   0,   0,  0,  1
> 
> Tested-on: wcn7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00018-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: 4f242b1d6996 ("wifi: ath12k: support get_survey mac op for single wiphy")
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
> Changes in v2:
> - Move survey[] from ath12k to ath12k_hw so multi-radio single-wiphy
>    setups share one global table (suggested by Rameshkumar Sundaram).
> - Drop the ar->mac.sbands[] filter in freq_to_idx() so the WMI event
>    handlers use the same global index
> - Add ah->survey_lock to serialise access to the shared survey table
> - Update Fixes: tag to the correct commit
> - Link to v1: https://patch.msgid.link/20260617-ath12-survey-band-fix-v1-1-e7d9555bb478@collabora.com
> 
> To: Jeff Johnson <jjohnson@kernel.org>
> To: Sriram R <quic_srirrama@quicinc.com>
> To: Kalle Valo <kvalo@kernel.org>
> To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: ath12k@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/net/wireless/ath/ath12k/core.h |  6 ++++-
>   drivers/net/wireless/ath/ath12k/mac.c  | 33 ++++++++++++++-------------
>   drivers/net/wireless/ath/ath12k/wmi.c  | 41 ++++++++++++++++++----------------
>   3 files changed, 45 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 8be435535a4e..6ce2f7b3fa50 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -712,7 +712,6 @@ struct ath12k {
>   	 * avoid reporting garbage data.
>   	 */
>   	bool ch_info_can_report_survey;
> -	struct survey_info survey[ATH12K_NUM_CHANS];
>   	struct completion bss_survey_done;
>   
>   	struct work_struct regd_update_work;
> @@ -774,6 +773,11 @@ struct ath12k_hw {
>   	 */
>   	struct mutex hw_mutex;
>   	enum ath12k_hw_state state;
> +
> +	/* protects survey[] shared across radios of this hw. */
> +	spinlock_t survey_lock;
> +	struct survey_info survey[ATH12K_NUM_CHANS];
> +
>   	bool regd_updated;
>   	bool use_6ghz_regd;
>   
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 2cff9485c95a..daf9bc8722df 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -13348,52 +13348,54 @@ ath12k_mac_update_bss_chan_survey(struct ath12k *ar,
>   int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>   			     struct survey_info *survey)
>   {
> +	struct ath12k_hw *ah = hw->priv;
>   	struct ath12k *ar;
>   	struct ieee80211_supported_band *sband;
> -	struct survey_info *ar_survey;
> +	struct survey_info *ah_survey;
> +	int sband_idx = idx;
>   
>   	lockdep_assert_wiphy(hw->wiphy);
>   
> -	if (idx >= ATH12K_NUM_CHANS)
> +	if (sband_idx >= ATH12K_NUM_CHANS)
>   		return -ENOENT;
>   
>   	sband = hw->wiphy->bands[NL80211_BAND_2GHZ];
> -	if (sband && idx >= sband->n_channels) {
> -		idx -= sband->n_channels;
> +	if (sband && sband_idx >= sband->n_channels) {
> +		sband_idx -= sband->n_channels;
>   		sband = NULL;
>   	}
>   
>   	if (!sband)
>   		sband = hw->wiphy->bands[NL80211_BAND_5GHZ];
> -	if (sband && idx >= sband->n_channels) {
> -		idx -= sband->n_channels;
> +	if (sband && sband_idx >= sband->n_channels) {
> +		sband_idx -= sband->n_channels;
>   		sband = NULL;
>   	}
>   
>   	if (!sband)
>   		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
>   
> -	if (!sband || idx >= sband->n_channels)
> +	if (!sband || sband_idx >= sband->n_channels)
>   		return -ENOENT;
>   
> -	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[idx]);
> +	ar = ath12k_mac_get_ar_by_chan(hw, &sband->channels[sband_idx]);
>   	if (!ar) {
> -		if (sband->channels[idx].flags & IEEE80211_CHAN_DISABLED) {
> +		if (sband->channels[sband_idx].flags & IEEE80211_CHAN_DISABLED) {
>   			memset(survey, 0, sizeof(*survey));
>   			return 0;
>   		}
>   		return -ENOENT;
>   	}
>   
> -	ar_survey = &ar->survey[idx];
> +	ah_survey = &ah->survey[idx];
>   
> -	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
> +	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[sband_idx]);
>   
> -	spin_lock_bh(&ar->data_lock);
> -	memcpy(survey, ar_survey, sizeof(*survey));
> -	spin_unlock_bh(&ar->data_lock);
> +	scoped_guard(spinlock_bh, &ah->survey_lock) {
> +		memcpy(survey, ah_survey, sizeof(*survey));
> +	}
>   
> -	survey->channel = &sband->channels[idx];
> +	survey->channel = &sband->channels[sband_idx];
>   
>   	if (ar->rx_channel == survey->channel)
>   		survey->filled |= SURVEY_INFO_IN_USE;
> @@ -15055,6 +15057,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_hw_group *ag,
>   
>   	mutex_init(&ah->hw_mutex);
>   
> +	spin_lock_init(&ah->survey_lock);
>   	spin_lock_init(&ah->dp_hw.peer_lock);
>   	INIT_LIST_HEAD(&ah->dp_hw.dp_peers_list);
>   
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index b5e904a55aea..aa70d2a61d38 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -6617,16 +6617,12 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
>   	return 0;
>   }
>   
> -static int freq_to_idx(struct ath12k *ar, int freq)
> +static int freq_to_idx(struct ieee80211_hw *hw, int freq)
>   {
>   	struct ieee80211_supported_band *sband;
> -	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
>   	int band, ch, idx = 0;
>   
>   	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
> -		if (!ar->mac.sbands[band].channels)
> -			continue;
> -
>   		sband = hw->wiphy->bands[band];
>   		if (!sband)
>   			continue;
> @@ -7507,6 +7503,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>   {
>   	struct wmi_chan_info_event ch_info_ev = {};
>   	struct ath12k *ar;
> +	struct ath12k_hw *ah;
>   	struct survey_info *survey;
>   	int idx;
>   	/* HW channel counters frequency value in hertz */
> @@ -7538,6 +7535,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>   		return;
>   	}
>   	spin_lock_bh(&ar->data_lock);
> +	ah = ath12k_ar_to_ah(ar);
>   
>   	switch (ar->scan.state) {
>   	case ATH12K_SCAN_IDLE:
> @@ -7549,8 +7547,8 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>   		break;
>   	}
>   
> -	idx = freq_to_idx(ar, le32_to_cpu(ch_info_ev.freq));
> -	if (idx >= ARRAY_SIZE(ar->survey)) {
> +	idx = freq_to_idx(ath12k_ar_to_hw(ar), le32_to_cpu(ch_info_ev.freq));
> +	if (idx >= ARRAY_SIZE(ah->survey)) {
>   		ath12k_warn(ab, "chan info: invalid frequency %d (idx %d out of bounds)\n",
>   			    ch_info_ev.freq, idx);
>   		goto exit;
> @@ -7563,14 +7561,16 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>   		cc_freq_hz = (le32_to_cpu(ch_info_ev.mac_clk_mhz) * 1000);
>   
>   	if (ch_info_ev.cmd_flags == WMI_CHAN_INFO_START_RESP) {
> -		survey = &ar->survey[idx];
> -		memset(survey, 0, sizeof(*survey));
> -		survey->noise = le32_to_cpu(ch_info_ev.noise_floor);
> -		survey->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
> +		scoped_guard(spinlock_bh, &ah->survey_lock) {
> +			survey = &ah->survey[idx];
> +			memset(survey, 0, sizeof(*survey));
> +			survey->noise = le32_to_cpu(ch_info_ev.noise_floor);
> +			survey->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
>   				 SURVEY_INFO_TIME_BUSY;
> -		survey->time = div_u64(le32_to_cpu(ch_info_ev.cycle_count), cc_freq_hz);
> -		survey->time_busy = div_u64(le32_to_cpu(ch_info_ev.rx_clear_count),
> -					    cc_freq_hz);
> +			survey->time = div_u64(le32_to_cpu(ch_info_ev.cycle_count), cc_freq_hz);
> +			survey->time_busy = div_u64(le32_to_cpu(ch_info_ev.rx_clear_count),
> +						    cc_freq_hz);
> +		}
>   	}
>   exit:
>   	spin_unlock_bh(&ar->data_lock);
> @@ -7583,6 +7583,7 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>   	struct wmi_pdev_bss_chan_info_event bss_ch_info_ev = {};
>   	struct survey_info *survey;
>   	struct ath12k *ar;
> +	struct ath12k_hw *ah;
>   	u32 cc_freq_hz = ab->cc_freq_hz;
>   	u64 busy, total, tx, rx, rx_bss;
>   	int idx;
> @@ -7623,15 +7624,18 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>   		return;
>   	}
>   
> -	spin_lock_bh(&ar->data_lock);
> -	idx = freq_to_idx(ar, le32_to_cpu(bss_ch_info_ev.freq));
> -	if (idx >= ARRAY_SIZE(ar->survey)) {
> +	ah = ath12k_ar_to_ah(ar);
> +
> +	guard(spinlock_bh)(&ah->survey_lock);
> +
> +	idx = freq_to_idx(ath12k_ar_to_hw(ar), le32_to_cpu(bss_ch_info_ev.freq));
> +	if (idx >= ARRAY_SIZE(ah->survey)) {
>   		ath12k_warn(ab, "bss chan info: invalid frequency %d (idx %d out of bounds)\n",
>   			    bss_ch_info_ev.freq, idx);
>   		goto exit;
>   	}
>   
the scope of survey_lock should start here and ..

> -	survey = &ar->survey[idx];
> +	survey = &ah->survey[idx];
>   
>   	survey->noise     = le32_to_cpu(bss_ch_info_ev.noise_floor);
>   	survey->time      = div_u64(total, cc_freq_hz);
> @@ -7644,7 +7648,6 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
>   			     SURVEY_INFO_TIME_RX |
>   			     SURVEY_INFO_TIME_TX);
>   exit:
> -	spin_unlock_bh(&ar->data_lock);

end here, may be a scoped guard here as well ?

>   	complete(&ar->bss_survey_done);
>   
>   	rcu_read_unlock();
> 
> ---
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> change-id: 20260617-ath12-survey-band-fix-4b5e78579379
> 
> Best regards,
> --
> Matt
> 

Rest of the changes looks fine to me.

