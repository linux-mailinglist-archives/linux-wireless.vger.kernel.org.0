Return-Path: <linux-wireless+bounces-37228-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OCpBPkAHWq9UwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37228-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:48:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB036194C4
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 05:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5CF6300AC23
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C55F303C87;
	Mon,  1 Jun 2026 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghWtBNoS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fo6bTDEZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E7B640
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 03:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780285686; cv=none; b=qfqyqCSqx254BxelJ4wddw3VozRZ+N9SGHtK9OkoUGRyHnTYTbhv65G13Ep0dH0DShs+VdEwYQst0FnLoLRY1Zkf+PNjgPRh7amoReqIUghQiXUZcvmiD/yKEsXChYA9V8cWNZT6kKil9AQrQRaERV8XR14UcYQyAMf8AKFzAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780285686; c=relaxed/simple;
	bh=CjAHOvwHzD+qf1SFdplloCWG2abWIQvC0+lNBdbDJqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X29FKSnfaMDjIdSWZMvBIz2kVLxbEekoqKuKjG7e3ExnhxTgVMhVqAT83IVvAMkWygfRcuwZ+Y/qtka8ieNLjAziJfvKjEVP8HYPYPQ56z2O6/tNCgObZb7bhjmc0tkuDpeK8ug1Wj0vlRSBQRBdIoJRbD14Twc21W1ZzDlOA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghWtBNoS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fo6bTDEZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VNUABK2363299
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 03:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GewhgQOsTKD6IeTpbfegwOqTd0TkgJjwShQlC2DMXKc=; b=ghWtBNoSIfX2hhm5
	+SUz46w/qSt727+26XkJNz1YmCtkCH7dd0gXEGpDvC0/7LwLcVlU1DJUaIme8p3u
	AOxJR4bFZoXHoMfrfFdudY/b191qDHXbCz20UYdgkv5/8KfnHefF8QnyUaLrAURY
	1+IEjurIIykmqyjHv1zrczColKii1mG7iugEnE6Rc4uYyCrz7Tgmu0RCJTq+qx5y
	9BJXZgqQ7smqK9Ezq38Ff4KIyg8OkDSVwpCSIQ5/nfDSPUF+d096E44sq2qqkpZw
	+QDymR65XESDhEZwV7kHWq3VFqVxHEyVOEh2F/Xh16n4/S/wioJO5dbG4F3KTFGw
	+Uzu2A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqfxwhte-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:48:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36bc02d28b6so2114748a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 20:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780285683; x=1780890483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GewhgQOsTKD6IeTpbfegwOqTd0TkgJjwShQlC2DMXKc=;
        b=fo6bTDEZjpxFWvPVthlBVncK3sgGC5ulaoDZWaUKfBYL6t5A5c08qD0187zE4vxZsN
         kmcR7XrgZyg3mOOzTtz3LJ6BuUPqB1558+9p7Kb61OJLkkfEAodgRYajhzvbvv2Q6UTz
         k+dakqmkMYHLPiWwgXq3wBUw1FIiGG2eGk1f/bLI5u+M2f/3c8kp1U7dFfqGBc9cWcvV
         RALjVi84+Fvj6zt/1w0yMx1sfIkcwVWQKhytB+XeinzdcHBNuROyKRvrtKQXZa0k9haK
         sicYkJ614FYrj1YR4vjTJ9hSPp3uG9bNlG8133XmLIMGQGgMaesSX+opOA/r83j7Ka+0
         6vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780285683; x=1780890483;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GewhgQOsTKD6IeTpbfegwOqTd0TkgJjwShQlC2DMXKc=;
        b=kMg8kICUPnK9/vDs2FD+AtcOehgr99WUMoJLDMyeVHQw1IECZ25bV7yFqq8pR7wbyp
         qYM+AV8SpMkrNa+i6XgiJRR7+bl1cFqt8erbFjp+pUNsXkBdzZbol7eCJ9pSxHZ1ItUi
         +wY7l9WTRjhgI4EYh8+SMIJgPPXMLXoN5PTeTdUYzgNZOc2eGJ9PqvbdHFIRJgKBGllA
         x7eLa7KVLOfIrMxqOQncQwxOnzDQgN61IZTPWKmq52SpkWEV8U5B5qW8//8K6uIjjVfR
         bHOsjcwttgJpDbohXJr22Wp5XRazdEO0w/4iLd2noL4AO8EE2lbmXbzznhVBxG19u2AE
         qUug==
X-Forwarded-Encrypted: i=1; AFNElJ85WAB5fL2WMvnrDLhRcORAhXGLKWUCba7qIkXq7SJb4w7p0mW8S9thiASvVoUsNOHg3uHFBpLoMkIItFdW8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2n9BU3NC6xn07jagVQtg32Mj0FnHn8n5PBe7t+ltW8EuUaJs8
	ZtK3lA8T9O24iqHkUzVWO6fV+5JCqIuIuT0snyDjUA/nSAV5o4X7nkAsrg/jxzEcpTUeJTvfiOo
	0ihIjZ933OGDxDmOIpXHyTi+9DnBB0LfnMVhj/P1Nr9lNNn3SGJD5I0BTMaJ/4ID1KVzCtA==
X-Gm-Gg: Acq92OGLktuB0KS4Td1CTkeF1wdcQritV2NjtT6eI+mG7joCq3T7g9lNGOqYKGaQR1P
	bJXHNG3eoEf89lVssBw38KTdav18aT4dAjHsHt+Kre5VcTnPYF9tk7QV6ODMY0YIF7immhRlfNv
	NcaAHi+ftnTWTBWsmI/DrowvopTUEnFd+3e5HWTs7Ei9k+A0r2SHxxK96aS/GsGaTcmkohztJ82
	RkjNb/p9NNJLRzrX6DCI5acGj94FUs43jWw17Y8tRyGqRqfOS25PSlVHNwCQBJSd4UC7Zkt/F2S
	xjhbt51ydyBOWGFVGzCRrld7mL3lq1ZHvqQztHcArd0q62OJ6ahyW9sXbVDs/O5SjE65mubAuPZ
	wE3u03puQRdsHaEw1Z6gM5OKxzSgQu1eg2MKfxqVyP3xAspSpqS3wm2HXp4fRFSH0/6zFR89jTD
	mnTcZ3a7UutVsAvNUfSgsHVCrdTDnj
X-Received: by 2002:a17:90b:2ec7:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-36c4fefbc68mr8435918a91.4.1780285683141;
        Sun, 31 May 2026 20:48:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2ec7:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-36c4fefbc68mr8435885a91.4.1780285682670;
        Sun, 31 May 2026 20:48:02 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771d367esm8218586a12.11.2026.05.31.20.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:48:02 -0700 (PDT)
Message-ID: <83065a6c-21ee-4e69-bbda-b499caa0b6ea@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:47:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath11k: dp rx sanity checks for
 invalid length in error paths
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512022351.2033155-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dw3N9nkUS6k9rbAoyPoHkXH8taaDf624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzNSBTYWx0ZWRfX7Xallpk6V3ZW
 osbXN9CCmHMPzeySMQIghu99KJpF52id2hSXPYyJvRe4EGErKN/PBlZtRb5QDujfT/ivr733Ren
 KBcS+ip/so8zPuJNpnifIRT+6+f9weaqPMZCJRpm97mE3eY8bBkTgP3MffX/G9mzihsZeR2+Teq
 IOPh5y9qMd2rrsNIimUZzmrJR0S7lg4rNWLal+XlSgj6xU6PiOyGZdffs1KPgJ+BRkQKx4QVJTj
 mLjaxr8mkz1Ds/pjGRDJHAO1GIxHA2S1RY/Xh02+s4D9WeEkpBW4c26URdBaGRRUrxdo0QrkbbG
 KnPH3c3nTB6BCr7JDhiR7MFwnAuTuhju2gnub698UKBRPdCR1QAwoZu/KjhpkRr5RHTIw/PKpmH
 ugnsSYKwRI29WizijPjh8po7HmbgUp4EmppWpwteEMixIqaHSg7HrhKDqBKMzyq7ZPaDT5crrmW
 /m2vePnWb9+HusTTpLQ==
X-Proofpoint-GUID: dw3N9nkUS6k9rbAoyPoHkXH8taaDf624
X-Authority-Analysis: v=2.4 cv=Zq/d7d7G c=1 sm=1 tr=0 ts=6a1d00f4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=tUsMSZr-IjeWTF3pStMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010035
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37228-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7CB036194C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/12/2026 10:23 AM, Miaoqing Pan wrote:
> This patch series adds two defensive sanity checks in ath11k DP RX
> handling to prevent invalid memory access when hardware/descriptor
> contents are unexpected, especially in WBM error scenarios.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
> Miaoqing Pan (2):
>   wifi: ath11k: fix invalid data access in ath11k_dp_rx_h_undecap_nwifi
>   wifi: ath11k: add MSDU length validation for TKIP MIC error
> 
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 59 +++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 7b25796f571fc09a7aa6fe7efb23edccd326917d

only nit in patch 1/2, so

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


