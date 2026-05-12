Return-Path: <linux-wireless+bounces-36290-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIl7IAu1AmqSvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36290-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:05:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E954D519BCD
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5178301CFD8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2A24BBFD;
	Tue, 12 May 2026 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSFNvU0B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBBjM1wE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654F1DF75B
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562313; cv=none; b=Knks+IaRRyWoqcJvqBjsw1iu2lvtIn/y+pFBbcxj2J1qSSk5uv01HuV7o8wHk61hpbTshKb5kz85Q+YaTXH3nNEGEjxKUYxXzZrAZ3/3lqFSf/VRsm2I02iBr/z4LIFKQhH/EAxh4YLW02J5zdgqzwtL1Ov+yAjV523gGhlOUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562313; c=relaxed/simple;
	bh=BIQt3/q3n+gOzx791Jl3d7bAdwfFzedVUKxEGRH1ewE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzmaFpn/ZdwDt/ZPQBqtmvPLjKIS/DOd6H0udS4SXHdtcABdLAivT2Sm9i4reGr5+cY4b5G73SVIPMlV48KxLjF+Tv4e3JhjcHrpWn3bm85nB5c3f8bbPCP7PHchIMD8fHTNCRaSjSnIXQeuze88hIUx8id+OsjvbLab31vDOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSFNvU0B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TBBjM1wE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6mWW2186456
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R3WVS27hxBhKrbgJ3+rq5wwXRFIK9loO1HMhH90xRqs=; b=dSFNvU0BI7IGOcSm
	0H6pJ6Mvfmm9XNLiNyQo/39EqNXgU61zDQT3n2iBYuKJ8DIpaPxTkhjPOfjwNvLz
	8hPliQTXIDI0lOOiXhw95ALFPZasz+luNdBrkB+BHIczgwA3JnIHcMXwxQ1RkxBm
	jN49lezAmBkvAcXOzI/ChrY/wYV8aRi14yMmetM11lrfIct+YZAA9gPZg32TzZcA
	Uiu9NRIDyEO4eFX76GxA9/rZiYTaTrVe3xGsKXwxK+H0zzB44Wi9aVmJB8xTMexZ
	FHsOi0m+fUNsr6Tnz267vBhWlps5CYP1T8f0Ll0BYizPl7oehY3T3wWDA9smbDQo
	gRUcAg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv29j09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:05:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so3076306a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 22:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778562310; x=1779167110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3WVS27hxBhKrbgJ3+rq5wwXRFIK9loO1HMhH90xRqs=;
        b=TBBjM1wEOLNF6cf+sfwYzjSSw8UPzKasd0o4SzbavoVkSfaeTopFQFtZf0qu8jk17x
         B27cAFf2Lmu/A99syc2zITvIUfoB5pRt+NngVx9nP+nV3lu/iZuZusbeFARiY1uW7wtm
         qvXSXBlOBjpLZU7meHI7pzE35lKu1ujR9b3CQStlfVpPLlVRsZdT+ja34d6lGPj1nNZx
         y73eJyQHzP9RrFyqV9RfHzIkI5nXx/R9j0v4MFSdlL4pmo0RtuEftrxEffGODEAdKxFL
         mFdc3D7NNRpO5szEFl6HwLhUrMHClwW6gwSQK7zpNoTPlZ9feEYFSn2qSu4bsP3JchO0
         VaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778562310; x=1779167110;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3WVS27hxBhKrbgJ3+rq5wwXRFIK9loO1HMhH90xRqs=;
        b=hSOVEAKFs6oGdOoEoOpIrld99F7YxmYBtS8MINLed4QAQ8ImQ3XcftrlPwBiRzorJy
         JgGKJmNwCVK5byXVEiZKw6WFPvPNsPF8n5ydVNrMUT8Rs0MTwK46sCxV3vVSak266lak
         2nGSnPl4+tnWlN3T1gg9EA6RZ/UbR70hLUz6495hu7gAjYjCbEApDSw+XawYIAQGEF0c
         Hg7EwJ9mdPAauRvJOmNwP7D6Dt71I59lXzMb9pvc1Xftc7UEPn2V+HAJHpeo6LHtYJ07
         qHDLOFtl5jEQEy9vhh4VCUeLs1gyXCR/GKlfCOijO1GDI5XhNte3pQLJTKJz6vEAF9X4
         9b+w==
X-Gm-Message-State: AOJu0YzhGEbAGDnPLM3UuVQEWtarK+tlXSQohzVoTr+X7YlX9K0srhrQ
	ePOlcwsYfyywff2uWVeaFcwbnb28wIXvFdp/5TVAE2A8hHxXxoRomZF6y/jRiFEXFfbO/4/Gb5q
	Qk9Xzk+GYtMXMeUg+afMzX9uPDiFtT/t1Q3+IbwsDoUSOexcKDZ0BY1PjKRvVp4DeObXc5w==
X-Gm-Gg: Acq92OGZas4sy3Rq1qvjy6FRlEpOqKlRnXjYXN+PsR2RPs9Uf1puIbGPyHSaqFuXk2S
	CKb7FjFG0LW6O5I9eJE4VWWOWKg9DFSvZcjgi6XPBOFZmwbUI/5olz67ZDDLnKuPcQQ/8PgD0Es
	uQ9u/2KCpXgIF/r3wmSRqhDvL48iz72EElH0X9INECHywTv4wcD0v89XiC8iiXV4i7Jo2Kszx9q
	k+TUV2AX1adahyYGT3ZtHjkVQcLhwZbtZ5cwsbZx+HFYo9mtz0IObbK8Yo63qpO97/xxPcpbuHL
	Tx1Zt6DagGyyxUPUSTGofKmyLvC5WeuS9ZIz80qSBEmFWCJfBkOxbxJWvPcrwOFPp8ADrNR1yaB
	AwCOdYwruNb//NXNb0UHah/odB0RJyslLvpfzRGeDThKqRHyHbQmaJ/DBc92QHOrAdupr3z8I5J
	MjUtqEP8jp2fkSu28Zn8w=
X-Received: by 2002:a05:6a00:a0a:b0:82c:8c6a:682b with SMTP id d2e1a72fcca58-83a5b9d81ccmr26070548b3a.19.1778562309707;
        Mon, 11 May 2026 22:05:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0a:b0:82c:8c6a:682b with SMTP id d2e1a72fcca58-83a5b9d81ccmr26070510b3a.19.1778562309138;
        Mon, 11 May 2026 22:05:09 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d35b3bsm20464683b3a.24.2026.05.11.22.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 22:05:08 -0700 (PDT)
Message-ID: <ba888d18-6b05-45fc-b8c7-a6f5a5470342@oss.qualcomm.com>
Date: Tue, 12 May 2026 13:05:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath10k: skip WMI and beacon
 transmission when device is wedged
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260428061737.37-1-kang.yang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428061737.37-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9JyhkO8-yiTrvXESiim8Q4x81d3J4ypN
X-Authority-Analysis: v=2.4 cv=CeM4Irrl c=1 sm=1 tr=0 ts=6a02b506 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EIYY-h-vi8t0s74smRsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA0NSBTYWx0ZWRfX81Cc6hEp4Ggu
 4FeepepR/4leMD4tpIe5MtaOZwtg+5Ni+m2HlJBM2wQAXuGQhpDySxtIC3Dv27QNVD4+Avp6jRZ
 4Jp5HKrIJB4YBiYMnjCRmUlnPOhm/nVuTJThMipUXOZ8h47SnRbSgRaJjnjOhmD2/yKltg/bUfS
 XjvEtg9p8dE2lbb5Mdyk9PcDduBjh2dD+VGNJLwu4I64gZp199Io7vRIngjOk9i46dlkS/y6tmJ
 Adwd4MKmOWlnjORUrvMLuLsDpKPVPwTVZMHw8hP7UiNCnAdSzmcU/aSmbZsXEHOGPWzCcb/RwOc
 rLfLs3SOeh4mXn4pmokhyyDYmnaxV5oD+VSR8v6w7MbLOpAm4heRlFeM8un9p5dkhhqeh3rPrAA
 CJ4wEPaPbnB/owKUPdZGkr0o9VMYjEhDRwlFY119BMSao3RGW5Xuh5cDGSv79X5J85vjQVy4xCt
 IXZrS2q1s0pI5pjwnVQ==
X-Proofpoint-GUID: 9JyhkO8-yiTrvXESiim8Q4x81d3J4ypN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120045
X-Rspamd-Queue-Id: E954D519BCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36290-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 4/28/2026 2:17 PM, Kang Yang wrote:
> In ath10k_wmi_cmd_send(), the current code detects ATH10K_STATE_WEDGED
> and sets ret to -ESHUTDOWN, but still proceeds to transmit pending
> beacons and calls ath10k_wmi_cmd_send_nowait().
> 
> This can lead to incorrect behavior, as WMI commands and beacons are
> still sent after the device has been marked as wedged, and the original
> -ESHUTDOWN return value may be overwritten by the result of the send
> path.
> 
> The wedged state indicates the hardware is already unreliable, and no
> further interaction with firmware is expected or meaningful in this
> state.
> 
> Fix this by skipping beacon transmission and the WMI send path entirely
> once ATH10K_STATE_WEDGED is detected, ensuring consistent return values
> and avoiding unnecessary firmware interaction.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189
> 
> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


