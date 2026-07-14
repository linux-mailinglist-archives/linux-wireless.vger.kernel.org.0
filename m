Return-Path: <linux-wireless+bounces-39006-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dr1LJHaiVWrbrAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39006-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 04:44:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B177506D9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 04:44:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=KGafVAMq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="GRr2Ta/A";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39006-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39006-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E56E301918E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 02:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E36366055;
	Tue, 14 Jul 2026 02:44:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C5387566
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 02:43:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997042; cv=none; b=KeLdpLxdbuFgU+JmeB5bc4rtlkqhgp6lVFPz/DDt939qsziUWU3p6gxPiO9+N7EQPtyXjBs+rCD8NYFbuh0jgMeRhht/gvm+mNdcTKAsYrrH39480ecksTlchobQSxVsJ75R6mgzM0zquQDcC9C5yGT/gkhvvCGOKoyNHn58ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997042; c=relaxed/simple;
	bh=ukhgRjGfqm9Uu7g7//lQSE1oXq1PMIppIxqeJ9HyjHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMGHz0zskw69t8THAyvKbsoEIqNukyMZA2U2ro5qDFTVdsGJN9xYlXf+2b5D6SZqN82pZoLM8aZHRfJj+GHtykYmsBP/NQ/jSbAJ2lif7sqorROTjQLoByY2HNYRtdpfBGn5YGM4/wLcx/fKDl1KMgriHVeQiItUkQy7DHv68N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGafVAMq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GRr2Ta/A; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNnP662955179
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 02:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ltdoAZBtEFO/nE1R3kO4JD7BwStlFCI9ybsndDyxNM=; b=KGafVAMqtHkOmRY4
	tmGl+zGa6Hf9/8j9uQc8K73AABn0VXca/Ya2uXn8Sw8G7BLBFjXBoDyolbuVXqAl
	4alGkBIb4qZJ4O3SniPqzWQ96q8fyMyTpQgwvuPzMMuJqMblnNhddQBUqCyzXo4P
	IBXlENchzcdas9zadJb7tmZiyf7GwmV/AW0JKo7XvVttofDQ9gUL2UAZ+Sp7RWFB
	KNCIgvIRE3zxYJ6crdbRNO1pbf8rci8xUlN790cbJJ8KlExGrmzyma6Z/Ltt/2zM
	/KfZJ595nlRZczV0THOtemOOL/RSVFNQeLbbuuX0C5FF7220fijFoaN4Jqz5960L
	1AAAcA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4ucrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 02:43:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc5faecf01so72247915ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783997037; x=1784601837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ltdoAZBtEFO/nE1R3kO4JD7BwStlFCI9ybsndDyxNM=;
        b=GRr2Ta/ALISi+5fczFmZvARAMBubewveZq9hUl0crgum4Jhg/h9p5vbhtyRhuFEmuB
         pu8ziJDcHGWXln/ZlxWsSEEs2bveSx2SkQih8+LEb0mmEyYwqUMWSFOMYhD5ykSdJQjU
         9HCdTHuR3HsjAj8FdSYbHjAjbVJ1NGWMbXc88ixC4KM+g3qde5KSWFJ1P1hbjyZCXOa7
         aV7rnCZfrUDpG0oVi1bPVGw+uZFcoVDxoXxg/5PJzri1EQnWnJrYbEibguS1mhFL5Kf7
         TfJLxHRaKJxh+dLT0vIAQdaoWeGZal8lIFq3t2tjG9n3tUiBbx7obRH5kuGVnPnfMs3J
         SmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783997037; x=1784601837;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ltdoAZBtEFO/nE1R3kO4JD7BwStlFCI9ybsndDyxNM=;
        b=WfUxQjvUXVMYiTUTHufn9+vCnZcoV7+e4oeWDPeOAc0zL4I0IvbeUDbZzKLUQaaCql
         paHbCGrOgkaOKsIqW3oeNoAuNmJTLioYsU8WARz3KVVce+nlka50ZyfS4dXVCHqmykaO
         Ns9FJ4Lus1/LB8145oxHbzLe0OPfXpD8msvYCMKLtOGaQJW5xG+yjPKYfk/0+2pJTLqK
         AFawWf9LRIwwN3BuQEazl1pMzyoN5tNb+ZDd1iKVICaisUDzp0G+b76SYcYpqGJSwRGi
         ZrxfpraByd2z5BaRRqV5TYUeLJ9LZmqg77Sa8nyVWqo4ZRJb8fT5yrdGo0EG5BDu7dDx
         I1Tg==
X-Gm-Message-State: AOJu0Yz7lHESLO8ubYRh63D70Diy9bWFK0tQZafygPpbdXwWzUEDGZqb
	Yp8P9/Z+69GCaohIVawkW8o8ssPoLidsE3z3wmg1GAluuy0LvvRSIX1INzDdac+RzGtWodmN8ex
	AtweVSw4NgV76yRU4Rkun9pjLy7hpBFuPXN5lGondqNgQ0gPHOJVXM9YO5ORviVNaf352xg==
X-Gm-Gg: AfdE7cllZoZlEm5p6VGO+ttGgDKPi95bBnTQ2uSjIqYusrSEbGqfeVWanHvjyVO6o7v
	Avr6T99wKiXveAZDgWq/g3tPQw9aCa7upniJBPSA2uFcEMDC63hSVOgogu3p+cd6LojV8aKb6SI
	UuVXD0Erb1Pz3BiIsj8nd/7VjTvnlQur8pI/nCAuqk13Wlk+j8XG5sQc9N4ueJKXGQu8OwmrvEv
	/E/ppIR4XzPQbCXo9NxFA33buIx86VypaKaiLYLvO6zJNXX75Y9yxXj/neL3EqwNYKVbK2/Iqdh
	lv0izvyfw5mAJEg+TPa94J/udzmJnuwG36h5KYrfSOptbOnRtRDP+Rm3pTO+UwS2Q8/2yvJpN5o
	mm7NoMDA8bw0ILQjqrKTwRG9xZleesDTN0H0XC9WGJwFEZqyGO9sN4xoLJjvzkmBjJ6zN1KntbZ
	1DEgAINEw=
X-Received: by 2002:a17:903:189:b0:2c9:deec:f564 with SMTP id d9443c01a7336-2cee9a8ad02mr17077925ad.13.1783997037241;
        Mon, 13 Jul 2026 19:43:57 -0700 (PDT)
X-Received: by 2002:a17:903:189:b0:2c9:deec:f564 with SMTP id d9443c01a7336-2cee9a8ad02mr17077665ad.13.1783997036665;
        Mon, 13 Jul 2026 19:43:56 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb7ddsm108461875ad.1.2026.07.13.19.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 19:43:55 -0700 (PDT)
Message-ID: <c57ac898-e74b-482b-8993-c4aeed728ac4@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 10:43:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath: Correctly copy the hint BSSID in
 WMI scan request
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260713-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-v1-0-4ffc4a472992@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a55a26e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=fdWN1coKQMrcGTyBBJUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyNiBTYWx0ZWRfX5m+RVjTXoxdV
 KIuf/VJqevNfkbFzgN7910seaem7XdeMrFqCxGhJ8NipFmfUlCB9IzkXDVwC1gC8OKFs6HKqfp2
 HHcmaJFnZIgmDRpXWGVh9tQbyBabvmQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyNiBTYWx0ZWRfX+CnIUxcQ5WH1
 b/u9GWbIav0Xd27DkDTb7YDU3VTajf4kVN+AM/s05PoYG1xK9PmvQaDwZtP1U0Ui18MzUeMyXlC
 Ctlc5eZi4jNDxFLqgiZmcoaEpYT5qyiE+UepgsQgWX2HUSwrIchRlvZy3+xPPIjVHNX+2BWKFeq
 Ndm4SF/wHVgfQzRz3JL0HDaZHJo5a4sQOBvJw3Eh0pgwLuKnngfbQ0hhLQwaIp/Ok99VDdt58a5
 852dBZWbHbB+NKd9bhFnb4OjuPDZlmwi4aLT0mGPrBwYpy2OVu3DjtMz1qxP67wqVVopMrqQO05
 Fs+MpgYab5b5oAHVMnfsmqUSGOZGUNmJIJwM5vjFkYJu8V1iivuFJ0+R26BvExKtF3Nealv1Wsc
 43gMYp6pgSxMN7kpSDH6tMRzw4738nUoPNZo7jTtm7VjiPwa7B4M+xJ30wCbrUbh6dBk7wUlX2l
 0p4s7x4nZxxDlm8lpFQ==
X-Proofpoint-ORIG-GUID: rCSlmZFXnCH7BBhzAtf9M8yLPEoXMgXu
X-Proofpoint-GUID: rCSlmZFXnCH7BBhzAtf9M8yLPEoXMgXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39006-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8B177506D9



On 7/14/2026 12:15 AM, Jeff Johnson wrote:
> Issue was reported in ath12k, but exists in ath11k as well.
> 
> ---
> Jeff Johnson (2):
>       wifi: ath12k: Correctly copy the hint BSSID in WMI scan request
>       wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
> 
>  drivers/net/wireless/ath/ath11k/wmi.c | 4 ++--
>  drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
> change-id: 20260712-ath12k_wmi_send_scan_start_cmd-bad-hint_bssid-8786dbd8cff9
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


