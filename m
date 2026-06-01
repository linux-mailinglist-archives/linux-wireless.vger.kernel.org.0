Return-Path: <linux-wireless+bounces-37256-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEL4Myx8HWrEbAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37256-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 14:33:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7B61F4EA
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 14:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A6E430254DC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8736165C;
	Mon,  1 Jun 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+sOntu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmLeae8k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5B2E9730
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316856; cv=none; b=FjnOD2CB7YcVLQaYjg164m0l8qZhpm48K6IKxDfIE6M0uoLNVA+k6xAX09LyFk2NAAvs8LhF9qSLbMtEmPYjkX5QDAz7E9KydMi45ELLhwBlhAxzkBZN6GGD6zIVWg90mHYIl3C0jmerhJcdlsnneF7K4Dw1ickh2tgkHPgAmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316856; c=relaxed/simple;
	bh=N5IExRHu+QjyrLfRIZCmXxrGL1AFJ5mnNkF0DNebKsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QRk/rkLWH1GP1nQ0FXcQBDYSTdxk2P3eTPs0uejEpeM361nRZ4X58wATtWgyY5orAISzCM8BwWqQQU8zL0Ap2DX8IAljNq6MSV5tuXvmdqEEXSRoo0gGmkQCfPDK+KnI5iLwL8N9CwUror8N7pG4ROftuZRMuxe6shoZpL8JwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A+sOntu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XmLeae8k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518f7kD2740397
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 12:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nuUuljBbgksxvPZFXSb7ZmCvFOgClD/wsWTuDPMfmjA=; b=A+sOntu1GN/c1ZAI
	r033sZvw/cZbjkqQj3rw5B80T50jQjsifugyRLuVKoLBcbvH/mYTWnW4zFtcX4KV
	6EJzi9HBVwwB6quBzhvCSOzU+Yo9rd/IV4Sxzl5lPA9SEMDZxZgt3i7h1c1fwtsl
	s21qVFSor8hOiNcBXmOLByR1GYZKIhD6Zs+q34KmnwjlfPyjKz0B/r2/jJLI4TIm
	czQ7Tu534+ikTuAlZAEG1oDcbuVmcruGMeQ8fR+FHljhL9pUJtC5ibanHbGsKxYY
	5Wq/SqOtuFQzNcYB2Xz+lM9JrDnZhMDSmGGaxGiwlYQf7yg8YR5ym5ryDNXrn2KQ
	Z1G6NQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sqgwtn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 12:27:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8424aac207eso1004224b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780316854; x=1780921654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuUuljBbgksxvPZFXSb7ZmCvFOgClD/wsWTuDPMfmjA=;
        b=XmLeae8kD240cUcpAzFQe8WIIR3Ycy4NdBQeKRANJoP2YTlKyz+3hj0nxiC0GzdBTO
         38AaWZDRIOHNTbAS1tbsjSASTPdM1OQdW7C5JUk8FNMv1CSd1EcR23a18Py8U7DW/4Na
         kxnQutEhFmvh1OUHTQRW2Z/WFArM8Ic5jNhkzgZ6AQ/BkpJZEHdC6VVNU1TOov0CG5K4
         vN5i9RdO9fUboSCeSoN7GlHTuPtmaWPs5cXLYnORMCAgkx4qow4U1UnDX0tHJhX1is7R
         oIHQsiHpsdWfqzNQh/Z2bq3RIvBX/pLLUxHKxMgnZayPWT9hVCp1cHLh/jtoToAdrsTX
         NqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316854; x=1780921654;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuUuljBbgksxvPZFXSb7ZmCvFOgClD/wsWTuDPMfmjA=;
        b=ff2xjFKWZPKHDY1zQiXeMYKLRy+UtsTcT2Zp0s7SQ7xB91j6+NdYYfwLxux1AOO3BQ
         zWcfJ9TzftDt5Z5PWjReJrWOa3YyJkPSPpi3eFaHNeHNvEsCkncpFObiRpZE3neaQvkG
         74nVAdIQcyNylfBO8vbFY3TUp7nvAu0okfm77U/09icpvm05USylFmg9ciM1TQaJq4DF
         59DFWQA0l98hTaC3pNT/GAT/aszKpoqG3IfZPxLWcyS9tpDsvc0Ol6fYLQT5Fksa5WW+
         bDi49WDOxNkuTZKA62MKTS6CSaSNJmO7J/sb1um8qoNinywRDeFklcXI3sYOLASAVR7T
         r39g==
X-Forwarded-Encrypted: i=1; AFNElJ9DtOemWDS0jZHi97BDAhpr1lJIBbd1hA93qSf0M+ddGOIUdyYF9Pk98WfXAl+Vxbfwdxtado5NajxvbGMrpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0qJyZ4Xqly6DMY4xLTpwj3KkgZmF5kSBexS/INpPTmQAv+kc
	2eAToLsPeAxWKaSOLiYJSO0bIUaf6rY2pk/begzkAK/U0H/YiZQPC1F0tH1J9arINXTVzYfe5nZ
	yBCgQP178cUaNu5rqto/SYzvpTX2KgaHjkNHL7B+5Mp3cR7glOm92NH0yRJhaadZA1nmt56UKz8
	TF2A==
X-Gm-Gg: Acq92OF1p4kepUJpgF2Kc97igR13HJnnSd1ypk7cK7eHDFlSAW1qewyBC40JB0Khx+V
	y5tCLm3lyEdEYbEn0AmhB0zIdcMVtugff+1BaFU+R9uRzY0HrPxGZBhT65o7XVU/k5r7zLMg8B0
	BJZPhK18H499CkxevfOOyWQvyEkMZenQkbsgRr1Fqo5EM9uGSCLh8pMHQPuHPgzXZnRBor9C5NV
	2JVx6EisB2dFq1BMibPLPYggeJb/JrWDqmirNLI7JtXPbCAQRq9BQB6e3uiPFmJkVsE7Q17ZG8l
	omqzZP2WrB8AAZ7Jv4bKEto9+KOPptzL7Qzi0nLVwuN0KJfuvH75xuaWzfTm9QfwnI3WYkM0BZQ
	dblvvAGPuDf4kOrHcue7RXFt0nw80AZ7jE7MHpCpeSuo4w8URSdrYoQLKxTwkh8fdV8m4T1wBhd
	yn
X-Received: by 2002:a05:6a00:1da1:b0:842:5c90:736b with SMTP id d2e1a72fcca58-8425c907e5amr2335984b3a.29.1780316854066;
        Mon, 01 Jun 2026 05:27:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da1:b0:842:5c90:736b with SMTP id d2e1a72fcca58-8425c907e5amr2335962b3a.29.1780316853602;
        Mon, 01 Jun 2026 05:27:33 -0700 (PDT)
Received: from [192.168.11.104] ([124.123.82.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm6936467b3a.12.2026.06.01.05.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 05:27:33 -0700 (PDT)
Message-ID: <2e69d977-cc1c-4eca-b7b4-edbab194f5a7@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 17:57:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS
 reporting in monitor mode
To: kwan1996 <laicheehou9@gmail.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20260507015336.14636-1-laicheehou9@gmail.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507015336.14636-1-laicheehou9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E9Z-tYdA5wkAjydgPjANGQVVlNNz4jOS
X-Proofpoint-GUID: E9Z-tYdA5wkAjydgPjANGQVVlNNz4jOS
X-Authority-Analysis: v=2.4 cv=eqnvCIpX c=1 sm=1 tr=0 ts=6a1d7ab6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZCREz13nqshT/on6E9YcPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aFaa_7U1rZJxK4kPejAA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyNSBTYWx0ZWRfX9i940g3UDUMy
 Xj9LWmN51W6pAEJmEzJGbhzAtanujDl8YRrCl77xIeCwyhJnzTDgKZ5Zq3dknlRBcnMW06hCyis
 rRNTFxhDjlmMANqWzkM+9/eQnXsrt0T4cL4MsHiQLjj3wRAXkBV6/vj/qnO9YcaEVcpjG808RMA
 MHgYGoiLX5sibsXRFs31CrK64zf+TWH5PaddMLS94BQZdzgsV6qTfjGrb/NauXAD43rUQSqWmqE
 rpdbFUsJUIXpJtgYYgBsaVLm4qJJ8oJifro9grSjUgal7KMBlAs7nEvDcNdkhVa1OduR+kSlzf6
 kRxiLvVjGKKPB99gTC7h2VNq/10SFSCroeWBSHL6hBUJfVwzautELQxKihnKaFeGtU+ShF0IeTQ
 guxol79dwUORi3PdUMvTNa42t62M7no73tqL0J/eqNzI5PGUD8Tf6GBO5OD9/ymh4HEusXQ4Gl9
 t7smo/eJyMXLtNJlJfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010125
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37256-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 43E7B61F4EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/7/2026 7:23 AM, kwan1996 wrote:
> From: Kwan Lai Chee Hou <laicheehou9@gmail.com>
> 
> In monitor mode, the driver incorrectly assigns the legacy rate
> to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
> frames, ignoring the actual MCS value parsed from the hardware.
> 
> This causes packet analyzers (like Wireshark) to display incorrect
> MCS values (e.g., legacy base rates instead of the true MCS).
> 
> Fix this by assigning ppdu_info->mcs as the default rate_mcs
> in ath12k_dp_mon_fill_rx_rate(), and remove rate_idx assignments in
> ath12k_dp_mon_update_radiotap() to preserve
> the previously calculated MCS values (including the HT NSS offset).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220864
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ
> 
> Signed-off-by: Kwan Lai Chee Hou <laicheehou9@gmail.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

