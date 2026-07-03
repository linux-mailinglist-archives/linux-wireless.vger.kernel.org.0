Return-Path: <linux-wireless+bounces-38596-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hhW+NSjQR2qnfgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38596-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:07:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73989703B6E
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 17:07:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=I2laStE7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Kk2Nlrbt;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38596-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38596-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CBC4301DD2D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A953E44FD;
	Fri,  3 Jul 2026 15:07:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066563C5848
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 15:07:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091232; cv=none; b=IFjAMjG6YqJH2E68rCmft6dpYf1x1MlnYbMlazrX8oDBkg5/Xa6njb2oS9E9BStqhkunDRTOD7ATcXxHt/DQRMuCzRsI4cSL7Cls/5Fj2t7ZabVVvbQog5VG7FFnFh0CEjVpA3drXn7qL5n2+6fCU0yXAc/PNNlayhdWikRGgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091232; c=relaxed/simple;
	bh=0w/d6iSpR9UaaKp/rDddcaeduOnJK9KBBmjSerbTYtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIz3r17reXzmQJVqzKmBtEXRKF7g6qMXPqsMW4r/rE7LtqNxUtguT4p7YUZJY57QXtRPviBXfDr0lTyFFvSn0qJfBwmerUl1j078ymEB5+87AzDYvyyiGBZpRpM/W5R8hY4GFKVFDkEiuoH9zjwkBnYseGCWD4z6V0NPKv6Mja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2laStE7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kk2Nlrbt; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BUCRe2994880
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 15:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=; b=I2laStE7JVO14Zny
	RUxphdbyneMw1OsRlTiKt0N99oI1NUu4z/tGStXgdRwGaWC+kYOJ+B0YCoFSgdZk
	3kFuL3t4LyLKsVcAQDoHbZBAdp6uHK+DAp1Lvyg/4TDPszJd3VK2f1OAfufBvxXB
	HWDTC78TO/jS0BMzX1rmYzGuPS6h6LYKvonLQlGWwobLQEmNeTVNVD4wtPSFw69b
	/YWG2WQvs0zTl/iG/65M0nNCwOOvyH982WAl8ISIzOHiWx6RisnoNPrGzuYlQBIy
	r2Ayt+rO6n7GP7/qDetmB7+9Y3D3G/UW048SZ4923U0oQOznFMwLEf/z/Q75j3d6
	OswDTA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n2wpm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 15:07:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e4ecd1ae4so11700085a.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091227; x=1783696027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=;
        b=Kk2NlrbtX5tIlouE3x/4D2leuzq3KKQeJkZ6SIOpP4gpp+0O27zN+6VCWCeQthxtEw
         COoV1yLlqG2x0C1GWyGgS7EE0O3/H4eJ5pTDqKN6vBdI8oPkqHoxwg4wEsM5lN7INizC
         MLJUunjdENKia5ngfeMH5UkO8M/IzRjBUjg/6jyaAfHuw8qZ/QP1Gzi33R0XrTczBIPP
         Y5DRjclspOpKfHge5B+AkA5Et2N8q1sVrdaTUbPOtL9+BPP4FeUgoOlofaNgD05nObgQ
         yrgKIoph51MbdBib+UuE2TFfcvym3ohQBR3yKVI7oFOhQuDfC9vJdkjqhjG6ZkHVL+Km
         pYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091227; x=1783696027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=;
        b=kFycI4sPxdjXM0R8oYcbtg8sKpGD0L85jMsNJDlc0nZap93KdfnduJfGNzyXxJRmy5
         lgndVQLRn9+71ucdoiw//aHiawczwvwbjWmYnKvik0Uk0ryyY5W59Y2uh+KD0NRvdhyE
         sLZiVQcDWQd1gs/ibds/kS7RRVu1zsl9DLPM9NP14ixkLGXMSkuaXaA3N7uSeozRRjKz
         miECABAJOxU4My4t6sLTW6TF/E7hZV04gOkiJtspKnb0EAamQrvYcfOJX5PDOJnnNWoV
         3vhauvgL4ih3tf+5p3HS6X9A5m5o1Zi9Zc/85Ebu67+F29c5WF+ohjPHE/tNthigLGDd
         IZVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xow8YtrIbWrwoEGe6HDwmfh5dFMmpOpgx8/ilBBzvaCQDXKYyb9vla/doWj0aWZtFF59peiSTpw/0CF9+pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzReDpZlsntOakhGkXRBQ9hMTc9ygtql8aVSqd1GFyZc/EIp+RM
	FjSKh1iGaAMST9LSYj0I+ozZ5yZxlRvQD1dx4iKv1/h2xTU07iQkHSJaFbJw/2BsRC+xg5C+LM9
	RRYp1DKUkbulajyzx1Npjfni44KssDaGsiplYGNqZrGLZo/D7lPg71Ru0eXpxYsjQabEi1w==
X-Gm-Gg: AfdE7cl9zqCzBrh5d0nnwDHMaK720ozVeHEc07mFfmrB7kcxVB89nlRZ8oBJrfT1QBg
	XXRCJ2P+FQDYrymICHGq29cT7bDswMXfbUgUu5dhuE02efMlloT0Qts3HiPTmpHPwVDpGkWvADa
	jtEuE6+UVFOjW0vVJSv/cjVG81uvSgns/3S1/gnjvt3CidaeBByVTpnEyx8gmUeMqMEzOXdiIue
	ULuVSXdCfW0nKxYUgjiXyZ4nw0KGg6DX7ApbHFJ4Nyf9o43uNt1ayAQ7w6muie1TvLm18D9R2M0
	U9GY6emCcWp38lPzklWZG/NqVJay5iAtSBehBLMKtuAiLJVmq1gtBK4Z4E3m8yLLwbZziUEIFzR
	ysyPyOjRk8n+CGUUv92/sT3cs9buHhdsH7Is=
X-Received: by 2002:a05:620a:171e:b0:92e:705f:1626 with SMTP id af79cd13be357-92e784f65a3mr825404585a.6.1783091226801;
        Fri, 03 Jul 2026 08:07:06 -0700 (PDT)
X-Received: by 2002:a05:620a:171e:b0:92e:705f:1626 with SMTP id af79cd13be357-92e784f65a3mr825395785a.6.1783091226326;
        Fri, 03 Jul 2026 08:07:06 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628d65dsm295433566b.35.2026.07.03.08.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 08:07:05 -0700 (PDT)
Message-ID: <a2dd4a61-2585-40aa-9d05-18b66f3450d5@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 17:06:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfXz1nUDreQL8pk
 VQiwlRfVW7dnu7mJSzYwxNLQwG3i/hFwdAw+r9pdYf+fRKxhIsgsUrYXW0a5BIp5sqj0Gl7Zn60
 +ZrtS7ibPhgUvk9WRskmI//4+DqUIrU=
X-Proofpoint-ORIG-GUID: OVNAqU0TwQA2XwuZklqbpHAsM2IiX9Dp
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47d01b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=DWWpLck2SfFL7czMIZ0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: OVNAqU0TwQA2XwuZklqbpHAsM2IiX9Dp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX3LNjpjcykojC
 6Q17lEqV2WQQBnlykplyXmYZMu3uM1t4A9GsMDJus5ds6nwQvn9T+qlrlPfHHlZyQWtys8YYx79
 Arg3eKvLulOIpKksPlUCVbLwHFyv4sKTiYlnlk3a3pgwWnirhxxwsk5B9Vy9t6wxV4EqOp3tL2t
 QWLUfPu5ox5ZxdCB8Zuup9xtuVNNZx7iz8IiNrCxOObOhWjclU06MLRGPDZ87NMSivPV/p1fcj9
 oqyzFjE9Sz/dmNh1d1EHYRw2AaADsql4NXiTohlcPq277L/qXV+sUwLv0Cd3Xsa3mwOmvKIc6Ke
 nxf6MdfbIVGssjbiAm6UwmuQobrPLwHTzlyAK1zvG2cRj/JZkTsTuFu58P3TX/dlTXwGDkpW8gu
 QzGSwOuLqa9/3B4cazRi2BN+w+F+SYbuEdULKXfE8K9XlQ3u2WNd4W6kUVYq+7FGoW1jNv0/mQd
 tr6vx4P5TDSIoS6wwNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030149
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38596-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm
 .com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73989703B6E

On 7/2/26 1:58 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

