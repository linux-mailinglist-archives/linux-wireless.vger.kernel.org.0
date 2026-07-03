Return-Path: <linux-wireless+bounces-38569-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N4/HD9poR2qAXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38569-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:46:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AC6FFB5E
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 09:46:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=OWmroleq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jjY1GbFS;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38569-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38569-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99529300F950
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2935AC33;
	Fri,  3 Jul 2026 07:46:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA93546FF
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 07:46:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064791; cv=none; b=Y0yVmChgxYwTk+GjIbfGiSiuPgjjLf4hSKBVg0qbZha9UnNko7oImXBxIMtyH24uMC7vrjWxsYEs9lRldsOkm5X1yElCObs0MJDwyp5NUE6GIT8gEhyfPBwnK1SJIcuImZRgUgDrJWOCUBtaw6dkH/JZeXFFbJh0Go7Bn7+vFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064791; c=relaxed/simple;
	bh=P1ytk5/PcGkcJOVgETbfScYbP+Q1q4KJH/BVIhcYMvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEKO3fnS9Jgre5Azt/yBkEBwWDv8DslkcFA3U4VKBT1DrBRpkhlkyOWvLVLBE2ao1ZnzxvwOaqgA3xazzt31EwTg/lMt9Y9bL6pZYvsloTX+crhw9UaW9av9cxUnqHK4BsLZ5+YFr4wPHxf7NLCOM9taybDXykR/D3rY5ZPbAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OWmroleq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jjY1GbFS; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rlDr3147437
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 07:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ngijrW1o66RPMM4l7xoEqLhLY7J5j0WjVIKSD1HqKY0=; b=OWmroleqjOQlzNVT
	hcm8Jmx2h34kH/oard7T8UMcrd7OuaLWw0fMqNI1Wp4zGEhoUlwvM6uQLNpn078i
	H8LD50c54FYuH3tQ0pq6IpRx+9H1sYCtgEVqXp0oZeQEz94wo8WMk4FkUX7Y0zMM
	7bXgB7wYTZ4Kh3AIqYXCXrKtVVmOgGuQ1YuA6m7i3yRZ+gFN3sizrVs8J2TbWD7X
	HtHyYmEvPAJ5c5afF88PifMiLEjznynhQx+UnM5W05xNbnayZNwdFpW+Ex6sz2A8
	EkTtbzyDR+JrG8xl7QJ7B5AApVABfJcInlsQWKpC8T5xoS3ODpygo6cQXmmH6jCW
	sweSiA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvww4hr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 07:46:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c8018f11fbso3444725ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783064789; x=1783669589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ngijrW1o66RPMM4l7xoEqLhLY7J5j0WjVIKSD1HqKY0=;
        b=jjY1GbFSXdSie+62IAO7Hp35dt/zZ16MSKcVlvlp70CYy7/uXCajTyOI7I8kmAK1xP
         Qw4ucevMagSoDWtkHa3epVlZF77Z6gWZsAl7K8/NdRNXgU4a2tim8cHeG4x/nQI95Qlk
         e/khpbQMMDLFSiEb12aAVfRDtPeqgMX2IbEDd6hA2BZR/NNBPgqJE1mdSLyDBc3Q2wHS
         gbPa2cLXXHQ3WMzV+RYZQ+P3kWCQ/FCfiFvQLrXzcRuKeSg+3uaIibS7ozJ5YiYMZGz/
         XXmBlbluR8i/xBzzIJDUqfPmzRNF3NSuGqw7y8+6xWdGB2Np3iM3hRZFRZXj0dcUzJuM
         yrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783064789; x=1783669589;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ngijrW1o66RPMM4l7xoEqLhLY7J5j0WjVIKSD1HqKY0=;
        b=CjrQVrhrjwInEssTXkLPnA47aBpPVKlIvN1BRZiu76gHJQsWgM3UBJY96uznC3uR3n
         iXyTmdPXU8jHkMMFJwxmkn15Kmh+Uepx0SbSfLz4MT8Pfzw5NnbhfGDNwft+aTw0sGLD
         2k8UolXFVeOOSG84d9UcftsKCr6X3m9wkQUGi/FXpYe/DO5Un1wlL5m2aHF16+IZhzo3
         UVnRs9L6q9YQdf43+iFb2KVVNq3ASnhK9p08zsvtZnfDS62T2W9dzblyCXT9vWH51klG
         gf2IDRxtJmlW0qeObjm+s4NTVa7KlcuhpDqR8MPReRYBbZ7sDJQec9o8EJbuSFZxG7P9
         vQtg==
X-Gm-Message-State: AOJu0YxoCi/5c94VS7Epkid9zBFdtpY4CpBBO9DLTfzRGjYCGTiiCDlY
	0C5xyNbeykIA7/dRUZ+hsUdKEKxbo5McF1YLZUSaxGa4HLj/8vnJjnZXrbt1rEyAbdbqTNPqlb9
	wbGdeToQEXsPjSmghFC6Qkjw6m0M2dSuDslaxlMoVYZ4NV9O7DDzPccuIrO3FOuJxUut9sA==
X-Gm-Gg: AfdE7cmqroelqnAz3rqjfgEuQ1z+Vs/2KJfv7aIV+A+MmFW2zRrEIXoNbq/Ajky1HHv
	6jak31JTev8DaigdIm2qW8R7eBWRV6TaXTPZqjyqNAo1X7/ihjs6YeZKkqrYtTejTI55XeUDuxb
	01rYk2x203vu3JnJEGIDX2O+McWtL0rJ39mN59PutL85ZcZvXpxMU6pEg/6vNTPHnWyKpNYKCE1
	dSHRv6yzur74JVGs8LOBboD+awcUMH3eE/L1CF1dfFP/RgIM6ODtPk2IX7annjhmwped0FH5DRh
	pQFAchoYCKERN2uZv54oDrqmz1W0Ib1+zqCox6K6NO9A5xKFZe5jlx0ua8dHgjg0hTuqjJSTO+o
	ubhL+pnIoeqGtOYtyo3b4tG21nqvHfrtMByQG/yZ72oEkAOr4AYeYUbhO4SIQMyAFY8bNGO232J
	ZtHee6nC6k
X-Received: by 2002:a17:903:3848:b0:2ca:d873:3b34 with SMTP id d9443c01a7336-2cad87346f8mr12510715ad.36.1783064789274;
        Fri, 03 Jul 2026 00:46:29 -0700 (PDT)
X-Received: by 2002:a17:903:3848:b0:2ca:d873:3b34 with SMTP id d9443c01a7336-2cad87346f8mr12510515ad.36.1783064788820;
        Fri, 03 Jul 2026 00:46:28 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6bd7611sm5516185ad.0.2026.07.03.00.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:46:28 -0700 (PDT)
Message-ID: <46b956ba-a168-4594-823e-3f27b5daadd6@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:46:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix scan command endianness on big
 endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260703-fix-channel-list-copy-v2-1-372c39306d79@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260703-fix-channel-list-copy-v2-1-372c39306d79@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GME41Pg5aXvezsw5FbQnBxrD71vwrSaW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MiBTYWx0ZWRfX1YOxaFFN1TnO
 bxKCH5UztEOYXh5i5dsd41McVMRdcjmRsvInpVSuc7Rp2CrAjf/c2V6gYvMYkXjY2y2SQ2JHYbT
 U+HlLY5hrqt0wUnE0a305ZR977pzbGuBjcY1c2bP64U9qEGcjcWmy1Ek0n4GQjGWNgT4ZQ2PjNO
 HBXHYA3GWCMIsWqfzy0tSYQQRNmknqi1WzEzOIocHLpL6it6GVbWKF2FO5+/6acjqDHUZhZ/h68
 pFWMBr0jb0tsHhPqLg/Fwotez4uuk7dGoKUb67hjF5arzEnJELJachsLcwc17Zq+C4ssLwxDLjd
 SpiTd/CKNEMBfb7PrCvLYZMYRwvLrvreIIlHBoYy6rtUkFTGEy9hdRLbhCphcjYMnAf1N8C5yMX
 7VvXtJP6o1J1mf462ElQBRBdX72jcRlUqT3fFZvBHeqKLDEMjjiN0eqNSpWym6FvW5hD8xLxtHq
 II9Avb2aiC7fBYOILZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MiBTYWx0ZWRfXwHGhvxQoRu1p
 /GpQwc6jDgZwsc8XNU8tXH0REyHA2Qgva+1Vwwuc7VN/L8a4Wiv6efLC1r6za97kOUmylKLeUag
 5bU+/UMnn3YTcvdfGmxKa//BL0YspFk=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a4768d6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8 a=gTOcNWQQRDhoJBoYzwgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: GME41Pg5aXvezsw5FbQnBxrD71vwrSaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030072
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38569-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[westermo.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B8AC6FFB5E



On 7/3/2026 3:35 PM, Alexander Wilhelm wrote:
> ath12k_wmi_scan_req_arg stores scan parameters in CPU-native byte order,
> while ath12k_wmi_send_scan_start_cmd() writes them into a WMI command
> buffer whose contents must be in little-endian format. The existing code
> copies the channel list and writes s_ssid and hint_bssid related values to
> the command buffer without endian conversion. As a result, scan requests
> contain invalid parameters on big-endian systems and fail.
> 
> Convert the channel list as well as the s_ssid and hint_bssid related
> values to little-endian before writing them to the WMI command buffer. This
> preserves the existing behaviour on little-endian systems while fixing scan
> requests on big-endian architectures.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


