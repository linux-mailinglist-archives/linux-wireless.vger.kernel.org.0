Return-Path: <linux-wireless+bounces-31961-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OqFDGBblWnKPQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31961-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 07:25:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1E1536CA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 07:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E97A301B907
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 06:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF825C80E;
	Wed, 18 Feb 2026 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxMnrUGq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GGUQGd/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E031A9FA0
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395932; cv=none; b=iiMvrh7rDjMgHbKuv8lXdGjN2cLVaKy7HANOunYJq+FufWGp8GWUlhPwuDNKMoMS5QWN5L0MsuRpb+fTxRqOkaFBxRDU+6k+oINpYQBn+5OFUNv2FXkBUjBxd5B0/KUGKLvcEljR8t1Fuf8SuEoY5TJD743ySWvGu4R4CI7maIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395932; c=relaxed/simple;
	bh=o1r7HhfL5QuxBT2I/XUy8HayBiB75f2v0Ma9PvVEhxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0diFbZS3+hb5k/VYj5GMnozgWJv+NYyiVa0AjmIPQjn/Y1yOl5U5IcQ7Kd6MJsdv+QAMc3VQB5mRqFBLY0vyZqkNHyTAZ+vWL962/qGB2WXTqh9FN2K7NO6K8FY3IYiEMfy8xaW2y4CXx4Y1HJYONsTx6keGWzxRIGsVNrumYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxMnrUGq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GGUQGd/f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I0teqA1167965
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 06:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zL1ugYee53gWJrOhFqX77A6DTFFCybS1nvXYn0esiQA=; b=YxMnrUGqzcF+qyPj
	5i+qCK0HuSJHsdn85Cwg1sfv1v2NvGFdHGb55WcCvAdtNI3x3bSc2nOHZlbTtbPT
	VRK1BC3OEENdmJC6ylAeqdNzDKF1AUQ3y33+EPB1gSGf22/52oHczYQkHbHKBJpp
	kh4zdm7BBXlbLdG9++8OWv5vZy8Le5ARZATvbghvRWkdOX/wwtz0QxTJdiokjw33
	casZTJRSBVQTdXy/yxIUKNZq3RACQ+cFfrYQUqXHWWLjtXt/rydg37Xq2qyB8C6z
	W2g0Rx/I7qKEdk3Ye+niTrk2C2+/0rokv3BXj1l7GWDCr7tImt2K9p5l7AFdaZWD
	TjKVqg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd3ah8k77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 06:25:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a7d7b87977so58570565ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 22:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771395929; x=1772000729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zL1ugYee53gWJrOhFqX77A6DTFFCybS1nvXYn0esiQA=;
        b=GGUQGd/fd0KPSJ9Yr/SzorW4zrj4q18ZHMWLBTve9oiXabVemrUuPmQsn058mbFplU
         JxuuOYSauPBUNVu16Ys1LYoFPawvdklsA0kFSdbkOlTsHEd9gzUmHC069tFA/btw7vpv
         6Jt2QBWA2Zg5+kYmhDQmf0C64ay8LvS7Ukd8ZFlDIxPVVxy/D1j1dhQVGu/GqCGGwH64
         PH72s1mCN+ImRLMYu/zOZjK1Dwuj+t+S4g9fVlMohQtbtj0o1IeaMQCrILAK3ni2ZzA3
         1Z0bVU1Tp/4E1UjNEOPZC9SYQWn02AZV9q+5Cim5FXPVLilplFg+WaQqCpFCfpfMAcqz
         YsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771395929; x=1772000729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zL1ugYee53gWJrOhFqX77A6DTFFCybS1nvXYn0esiQA=;
        b=ja9KkLGEEDgqfE0tW5Wj4tlNl5opZDtFytfk8i43S3gRE1+850L6Dtodr8FccLQK8l
         AedN8wLLH9gYZwJHT+A98QR1XPUiDw5mqfxm8Q4iLqS1kx/ODkWH9SJ0+BmIlri7/HMY
         4CuFaJxJG3hmrGP+mp7QEckN8PI7cokTXK7WmSqpFsnFuEWBSlfSWB3AQ+TIe5YxUpPY
         7r9ni/FbFLJDsAZ8ipBHnIOBXlKTACt3QrEYXABQcHwWgHFnT9u3WTxdD2Tb8vabdYrI
         x9GUlEg5OkJ7th48rZpnswpomlQppqXfpI573oWlkquNViyP+M5ZliJ6GQPzmXliqmS8
         PxKQ==
X-Gm-Message-State: AOJu0Yy3BhypgXDcPu3h86RsiOORwoeD5kT5VFLpqmazG5BuMX0H8+p4
	r9Sq55JIy89bKD0rYhRmHXEwK1QDP/iguXc4MYUCfzmdbTBH//Pgtdn0JGrQnItFsW6E0jhGbb2
	Olh3WyccyE5KQYPBvQoXI5U0S9gg5to5Dkw751dszm55IaGS8XxuWR9t6CVaLWo12gHB/4w==
X-Gm-Gg: AZuq6aI9fJrLSRM4/Xl3eRoD7pc5WMxITjB0y9RFSeLtrZo1StCKXxh8wmL9EcfGz45
	97nfwPvnnAiPzPELt0aUnPjZNkq4il6R1bw6hoxJDrP1H7yQolui7SrxQmN43O3JZvQzA1Qmhli
	nwUkJ3fwgQi+nFKbu0gh1XBzSGlfKJCkYpJvf+KQnDr4oEpKzYlhA3TOHmHIHVM87lItQe+vv0s
	8nnTcS7av+KPTV2WjOTgh/wFnfJbLjyPjxKdtsmoYM8lndnYnJ572pEtFYAhc+ggSADtslOVTRI
	HPr4GBW8xoh6KEEVQcpb/DCoBcw8xePIVtbj1xAWsgYq7C9cPQN3NU0FCa6f2Z6Ft56zGc+USIx
	EZNejoolebZhczzR0SK/Xc2QNwUTWORcy6Y5UvEQce4Xo8Dg=
X-Received: by 2002:a17:902:f687:b0:2a7:3dbe:353d with SMTP id d9443c01a7336-2ad50fc5f93mr8749425ad.53.1771395929383;
        Tue, 17 Feb 2026 22:25:29 -0800 (PST)
X-Received: by 2002:a17:902:f687:b0:2a7:3dbe:353d with SMTP id d9443c01a7336-2ad50fc5f93mr8749175ad.53.1771395928901;
        Tue, 17 Feb 2026 22:25:28 -0800 (PST)
Received: from [10.152.200.28] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a61cf8asm175683525ad.0.2026.02.17.22.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 22:25:28 -0800 (PST)
Message-ID: <31ca6599-6816-4d73-a766-9daac2383ef9@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 11:54:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: Fix AAD/Nonce
 computation for management frames with MLO
To: Chien Wong <m@xv97.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
References: <DGCW7TTCQC89.2G77C3IBE4SRC@xv97.com>
Content-Language: en-US
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
In-Reply-To: <DGCW7TTCQC89.2G77C3IBE4SRC@xv97.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zo3g6t7G c=1 sm=1 tr=0 ts=69955b5a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=1_aVZONaAAAA:8 a=DYlwmoq1SwP4PbYDfowA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=AoRcCS2iqqjlCIbQeai0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA1NCBTYWx0ZWRfX3FzoVV3Xa+8o
 zQSgKnPJjoSW0kGE/g8bsWBXrRUZ4jVXsDTpR6pgPJKuHfmuELZjxG3zybI2/2MyMf50rxAw+fU
 Tcf6S4ogiInyQ/lMjY2TPSh52IhtYz1eTQFoSbJwEdGDbq3jXIpQrmcvgksOXU85fJ37n7JYinR
 T8c+C/PGSP/KOatS43mESDqNSVjmU3Bf5C9hpnRVDlGziT8mwpnxTySOCAd9p2lydR+nMEgpuuJ
 4DtVuA2iutyjF4J6aTYP3SRDuaN2Zb2Bb7OHiiV8V65hyXPhTpmhGfkAnW14tdWzIMnzL+hoXzB
 jtgzQNygjA+jJCYJt4Ge1AwAp/P7rvvNvKhFJoG0mi/HVpHC40RqBFZ1kbQK5XjrQuVd9j0hmQs
 ipYTW/SwMC2SZ0aE1H8CekaltblgpBiF74bvjFULjS0ftd4nYn0daBeWx5JeVOWsVWDhf7F3r34
 /tXJa1czhr/sX8HS93Q==
X-Proofpoint-ORIG-GUID: N71bS2APHiT6CKtZBlG7m-kzP3QSZwA2
X-Proofpoint-GUID: N71bS2APHiT6CKtZBlG7m-kzP3QSZwA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31961-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sai.magam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86F1E1536CA
X-Rspamd-Action: no action



On 2/12/2026 3:28 PM, Chien Wong wrote:
Hi Chien,

> Hey,
> While adding MLO decryption feature to Wireshark, I noticed this issue that
> mac80211_hwsim handles MLO management frames encryption incorrectly.
> It seems that wlantest can also verify the correctness of the encryption?
That's right, wlantest can decrypt protected management and data frames

./wlantest -r eht_mld_sae_two_links.hwsim0.pcapng -T <file containing TK 
without spaces> -n decrypted_sniffer.pcapng

> However, I couldn't get it to work—wlantest keeps reporting 'No PTK known
> to decrypt the frame', 
I gave a try to pass over-the-air capture of one run without this patch 
and another run with this patch. Without the patch, wlantest would fail 
to decrypt the protected deauthentication frame. Yes it throws an error 
- No PTK known to decrypt the frame. This is actually a decryption failure.

In the second run with the patch, decryption was successful.

but at least I verified using Wireshark that the
> encryption of unicast data frames and management frames in MLO is correct
> with the patch.
> 
Thanks for the info. As far as I know, Wireshark had an issue in 
decryption of data frames with MLO - I suppose that is because it needs 
to use the MLD addresses for AAD computation. Good to know that the next 
released version of wireshark will have this fixed.

> BTW, the changes to Wireshark are already in the upstream repository. If you
> want to use it for verification, you need to compile it yourself because
> the currently released version does not yet include these changes.
> 
> Tested on base commit 05f7e89ab9731565d8a62e3b5d1ec206485eeb0(v6.19)
> Tested case eht_mld_sae_two_link from hostapd
> 
> Tested-by: Chien Wong <m@xv97.com>


