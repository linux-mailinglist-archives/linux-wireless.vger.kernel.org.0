Return-Path: <linux-wireless+bounces-35370-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFhlKxNQ72kEAAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35370-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 14:01:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6BA47232B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F9F83061DEE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85311369970;
	Mon, 27 Apr 2026 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffNeDWbD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6QIOSDo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF730E0F2
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291003; cv=none; b=eEGKeV+j/MZz1OZvLbje3F8VseCpeqArdAbXMK2N9hAdrzsDD+bM3R7JhV5CemcYcjJJYOtbpnJ+VsIOShOg2PPzMgMJC2uM+l1+UpqenvOucCOUSLuAoUoqAu4t3tcL8HRxIsQkVfA5xuKZ1VgzFl2srd77sqru6WF4Swf+5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291003; c=relaxed/simple;
	bh=m8D6LpqEX9iyTr3b9hRJPrwQHc9BKAtNQrLo5s7h/Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJcWVp9etNQQHf2Kl3J4De85swJ//GEx/VPAgff3MZxzoSTqKdXeBbfRwiET7weFcjzoywW4ruPDpKZ2LxDGjWVLQV3T39O3DILgSKdjP/Do8wG9CpZzTpvK3+whifVbix3/LApEE9mfpdos1x+WqEOsezspnORpDlkYr9vPJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffNeDWbD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6QIOSDo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TCwt3639704
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 11:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pe/DYnEm2mcAswh5FsvRHLeUipg98o7FWABSmF7Ql4E=; b=ffNeDWbD3B2JluA8
	aOAeSV22qwO52bl3m7HhFr8iDNLcsw/0K8uy85nK9q22R0yBnSGi1ovbKbXVjAWd
	AvKDoyXiiVwGmG4tRBvcNlNZkhwKxKQqgT2bvz7FBJ/vpl55e2p9J7z8ZG+K5B5h
	YAi8XfTHc8+XMwr6Tz7ECjOywZG8/4ZnA3Mp+k9e0A02eG46PtSljh4zURauxA07
	QVhurX3nYz00DMjEsT5RR8+z+RZAGyZ9ebkzICFXm4WCrAgs49ho2UiOOEDUAnjS
	oO8pu6fAeCSCoXrRC0i++RZ75nmr5ofVOw8Ga+94SLIsONBZaTn50dHVfeGk0Hpl
	uB7pZA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya01ww5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 11:56:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa366fb79so10050125b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777291000; x=1777895800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pe/DYnEm2mcAswh5FsvRHLeUipg98o7FWABSmF7Ql4E=;
        b=U6QIOSDoC7gE3KvAexfCzYkbQZ4I91PGkF5+NUMzUCJ0RZlqFo7069QLtQcP4V8hN6
         qP20cOrhGilHgS3cvy0FTw/4xV6Wqqh9HQZ70tsu6qGsHB8J2rQ3j79ChBDnkXTrDA6L
         w6KUO9gb3kU9ss4zsGxa7wqRsq21Rx2Jko+xcgB9zvpTL+4fcPUd09Yy0/0ROMMtOhTv
         72ImM+wdMvZcAKhLptF9SP8/yocNA15xbuhEyZXstBIaa3IPJSH/FazzfknXghVACG9Y
         Tp6+jgG5POajXXWTMzbrl5vjRn9MR9eqUDlNMqmNXJkoZnlAJMY4UTcdOKLD1Z5mgsZR
         ebRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777291000; x=1777895800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pe/DYnEm2mcAswh5FsvRHLeUipg98o7FWABSmF7Ql4E=;
        b=N7vfO5TncjU1ccPTMrT+OyrtfGfGC7VSxBuGZVv4GIyPjnGzG6FzDKH7AjekmUSBcY
         b4KybuFGDjauxKJaDkOgFwNSx2Ad/IYG0s5uD1a5zp/RUNbnmA+hwUd+zamgypot0gPo
         a3ARQtxkIXJM2yrlNzJjD4gq894zUmmJ7mwJGnQTMaSLPTD9Zg/aGmabXXEVz/yEsCJi
         ILWGbSgvQL7xMO8OJp+THah2tsTmuYujuShBE7d43WLltdYh5Aj2nCxZ+Dtxsu1hCFIO
         G8BnORBK+M2m6PNDNgbLaSFGVXa+ATU6XENB7lF65W5XWyCHtYv8fUpegh47sQZiFmML
         3PEQ==
X-Gm-Message-State: AOJu0Yw9KcPrzQ9f91GV1WhfCiWBHJ13pZTHz5evfh6Oap15VKfGEbNQ
	d0qsQAGZyhe3uilY0br1BEsUyxNnLJv7t4Lju1ja61a4gYGXTQviYgA3jF5MtJKSm5TrQGhqwUY
	DHzhU6VffNMWxm8ko67RFsGQmvf+QdYz4pxdikLCtMPkKLSKzhwYECPaKzmI+L4cS2jEM7Q==
X-Gm-Gg: AeBDiev+MPOeyswTRaSP08eXakE6MKI7JTSGu/kYZGhpvGvw0jPNSlTyYYj+h6zLK1y
	zGgMJSnIB488VxfCGD68e2zbqHP3g3Iz8ek+x8my7dPgj7203lTdDESaYoG6IppgzAM03ANloHF
	mF8QTmsGrxpPs3wVyiDaZ0ZbZckGU51rhchlkyS5Bn/2DXu6YhfaDBXkS54DCvKJmAGjxdvllhY
	1aJeSz7WmHRSITwCw9/FopHHIHW9rcOfIBP6fJj/KEp7wmGMjjOILv5nYApQBTRp7G+pXLyGunS
	fLNn5yfPfj7cQf93EKpdgsp2EsQGsAuoVywrpXIGkrUetZ/e1PjpAXfqxn+47hj30AUnSF4sXRH
	ZeyNrz3wfqSlIrXaLEy0f11wa3Hcy+PUVzcPgQRbBTX0N1F4VlMV0FXqJEcVN3gwgZHkv1/7/pZ
	IP9PdOQODEwhPxftWdYyz0tEqssie65b7Y2XwDIa3DsCw=
X-Received: by 2002:a05:6a00:2e15:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-82f8c9024bamr46192400b3a.32.1777291000309;
        Mon, 27 Apr 2026 04:56:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e15:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-82f8c9024bamr46192383b3a.32.1777290999805;
        Mon, 27 Apr 2026 04:56:39 -0700 (PDT)
Received: from ?IPV6:2401:4900:25e2:c02c:2171:a04a:44ce:a6ff? ([2401:4900:25e2:c02c:2171:a04a:44ce:a6ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe901csm40211861b3a.48.2026.04.27.04.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 04:56:39 -0700 (PDT)
Message-ID: <4b5f20f3-f29e-471e-aace-48e9616deca6@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 17:26:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: unify error handling in some
 ath12k_wmi_xxx() functions
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260422163208.3013496-1-nico.escande@gmail.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260422163208.3013496-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: D8YVEIE03fHksX18Mq7p56lG7Hdkg1ez
X-Proofpoint-ORIG-GUID: D8YVEIE03fHksX18Mq7p56lG7Hdkg1ez
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef4ef9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=KE8VTcUQ_TpmJMKzUYYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyNyBTYWx0ZWRfX8FFqC2hav/w2
 38LI2yRqMAxShSxdSe+mwJF6fzNCiAy1xEqwCMBFhm+njhU5zWUkKSu7RbyNh5E+klMTmjZgATN
 FRV/3Op9IRPD5TLvh5ot2mqX52Ag8EPx+dTt3l1dnZIT/25FvzcJ0SFAZAtNMt0x8M2bzea6z3v
 S/WZz5ud8kYLnuIzKd5wd60HtjSbBMAfmGKIXFJaJTQ2QeEzJjbNNQEcwUTbMbv5gyfhyY2Vjxc
 /4i9eYFKqxKr/OGx04Bdk7D/S3+6q65exrpWdA9Pc9Fo2/QuvzJEubAOHEVJf8ZuIjRqD7bG/Rv
 Si3F3pzZ3TVyD2aPHwNfJSDStg2fQ3Brf3+uvWQpwNXVImWS9JcWZ8elhHgE0c6RywM6UOO5kSx
 2I+q4UuBhkoewCq9QE3m1Zd7Hk+TCLqQOvjFWthzmS32YWp71juLIRTrLgjmBAYvhf49NYkdb+R
 7DkLcF6JSC9DmuM6vSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270127
X-Rspamd-Queue-Id: 5E6BA47232B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35370-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[vasanthakumar.thiagarajan.oss.qualcomm.com:query timed out,nicoescande.gmail.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/22/2026 10:02 PM, Nicolas Escande wrote:
> This is purely cosmetic changes that simplifies & standardizes error
> handling for functions that ends with a ath12k_wmi_cmd_send() followed
> by trivial error handling. Saves a few lines of code too.
> 
> Compile tested only.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/wmi.c | 32 +++++++--------------------

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

