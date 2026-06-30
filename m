Return-Path: <linux-wireless+bounces-38375-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NK/kIIK4Q2oTfwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38375-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:37:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E757A6E43D8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:37:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TGPyUaeI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DRL3tjB0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38375-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38375-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9FA30B1298
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A7A40B373;
	Tue, 30 Jun 2026 12:35:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2AD40DFD8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:35:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822958; cv=none; b=bsU/UH7aWsAseOpJ79dkEeIaopRFVPEK8Z75xODalDVZGpSVdUYqeX/PLgVzIr6H07+xV2ergQUUqvINHy+Es+FLl6o9GRaj6yX8VihBOhypFdBBzoLXTPLCjSqMnh59x1CdVgKv7NZR2wlQx+9dINI/LOeYuwSdjwPB19ZWW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822958; c=relaxed/simple;
	bh=vLLmYFCrj1ZpLwPqXPaPHpgTs7bbyh+LFs7PAoMXyh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfQl75Xiij6Yr90wmvZiLKz6LJrqOaIEE1S6NSW8br5uxeAN6AAXXDY0s8wkr9HtHNbDRZrIF7rpAxTWZ3h9NlX68LjgvDYKOuI/WukBFuwmoGmu8mYEkVyLmCO+xjMsbZMIA0SD+Odo2TFBJh0E8v147sTAk047K+3pn6CHV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGPyUaeI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DRL3tjB0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9ml3t1541144
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=; b=TGPyUaeI7PD0l3ZD
	RXUKwjXocsLqVkkLw493t61d5m5eW5p+GjrblI3HaXwFRFAJyCt8ufcYOL5UMpRs
	ubYftG9AINmVA1xjbKA4MA4O8GENkvzEA/LJ66khEL8Q2SnIjCkWThxNI2Exinrx
	CwNBvO3PSUzn8cYCaTzD5Sl6TUsgjTLZsqkyo89x6+0b/eEMdkChPeMQPDfXxqtc
	xb8mu5qnGtm9zd5IB+jXQLsXM9qt5GxT54Fx/vfUVEYcCnYa9T7TQ6r+4ITYjvUP
	hEA3g2zC/RyAeRNdFTCngAhd1MZnNOYdxGSs2+9rKxnzRV74z1aCc8adLqc1zcet
	HODrGQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp2ey3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:35:50 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9691f63552fso155164241.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822950; x=1783427750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
        b=DRL3tjB0C1m+OndZqS/nYckhtm82nBsO+yYyKPkTfoIPib/7yW6gyUrs6KCNvlqAjW
         +2i49AIzbuscKiBkR6sW5K+3bNwp6TPXtVagzVqDJUZM5DztcPlaL4zScLasgh0EhzhG
         UXXwaGy6dUoFe2LcuGAKpFcVWiOZ3UhOE9j0i4o9tvcntlSaerDSWcyvYq6+BztCvY++
         A9TPvPqxATrs4ZeZYrv4bfbm0n9QSKankRoPibv1SYZ8uOcyU+Ga6XIppjt4QRDNv8DB
         Mm41e5z2LPmBrsIsWBQzOUXw9veyw/HItWOeNmPLxb2FYbwDalIRvLeq5aqlvU0L4I9b
         ntzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822950; x=1783427750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVybOcRg16XfrgNggKu8Y+wvhvzwAUuWo3+dmdHPhFw=;
        b=ro9nGLEF/qGJTQarb4UQRJ5iQSghv8pIlN+CQTypIQsSeTcwFUOu8t+4K1eZdGAEXD
         AkmsdQllIUJbhFT9LgrMLL/Cl+y154CIxw3xHC0aZoAKN4nmsierXUB2uCWJYvcKE/Go
         Ku6LGaJxhYRX/eehvu3oy2NgG+I6uXCk5PLbMI3cCx5MksZv+2dRWTVi73zeg/D+zatg
         q4rGJ/hk6fb3D8uH8EMpbqxZn23Yd/AiwCuwdqf/Tx8J01WZOOp83QksQWEmGYe7VOs6
         pgJU5qgrnlHNu0c7SMRit7o2zhiQeROnE3L7EE0Jj19mQ3xcihnNKuWuRkWW6KQQ8/TE
         Ebmg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1/HcGjoheDETXHZCIeycuFLyLZu4g3vRDcVuyAbR7stCgArytKcaz6fF4WMYZUmx150e98msZ3LzGZo0Qyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhElcJCAEyDhI+sYwrGprFgJ3vi2hzwUQotAzYjKjDwHRWVv2
	gVgbiDUoOW6H2MooTIjJNWQMJTlZFfHOKyEBjhnBbLXmFRIVNb7422qmebaxP1XViz7nb2kRyn9
	iWswpAYJVsz4ela/gZIlTbhi06Rp138+DoDRA8KhNdqfWe0bTuG0puK875ylrJb1WwbSyBg==
X-Gm-Gg: AfdE7cnpp2iRShEd3oIToi+GMmLkq2FY3arTmj3iA7PdD9gnB8YAChHaRJWcLAOR/Rz
	Rvce1SDnYMUqsBNOfkufazwwAcUiGeynSK3jiLyynwXlGUleV7VkdBG2NTtbUlzHd6OgvBEUltu
	ILxA8gd5RYU602AQU6z2W+A1dLF1MVTzhe+SQSesG/ByLLXMSnaOI99nQPTAXC/7xk9liOfpJyQ
	G5mtbOZyF5pBS/D9uZQo1komp1/qUzS1puWvE94vTtK1TIqS5FKMaGwZ0JGO8LTmPsmZK2YA/qR
	H45Sg5Tso9CwJDF0ZhN7X0QglNR73b3bbLXRlyEHTH9RiZul1ipifIwi/b5sKbnmxWe9OiuGuda
	30rJx/Z+fOeLS1bSIyagyDgOLvQ7Yk3zpb7c=
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id ada2fe7eead31-73a333cbc93mr634710137.0.1782822949914;
        Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
X-Received: by 2002:a05:6102:f89:b0:738:9abd:9ebc with SMTP id ada2fe7eead31-73a333cbc93mr634672137.0.1782822949547;
        Tue, 30 Jun 2026 05:35:49 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69885c9e8e8sm441434a12.16.2026.06.30.05.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:35:47 -0700 (PDT)
Message-ID: <049a4aba-1c35-4a47-9a34-25e76ae8e72d@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:35:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/14] remoteproc: qcom_q6v5_mss: Switch to generic PAS
 TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
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
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f4Dgks1eC47CX4NBdoDJRzJNljsTa03Q
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a43b826 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Vkn3R3B67r5ClizzeDoA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: f4Dgks1eC47CX4NBdoDJRzJNljsTa03Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX7FQz5Il1mmRi
 qMtqiz5IAzwNw5MlxXposWgBAmbEhI3Uv/2Smp4UBfgJWXJbip9KQ5SF45c+4k5JLvSe2XepDE2
 baFXptKn1ZvPQjui2RrPxYppfflKxaXkX8bebBjT+KNJglxJTgWfy0Y/1XuKjK062F9bHDF/WBU
 I2lHgc61NcAAaYR8m83nunwywDfkxN+iZdU5U5odPmrorm3Sdnap++H6+viRTukCYsQd+Pt5k34
 z8Uumw9zOz5lXhPJPxuZ8X7g5fFmvTwxXMFYURctJXD82QhY3DxhH5aC7fv/8qZ0F3tMMKgSxJ9
 qz88FhXaeEDj8D6F+5lWny1o7MSFt1WRn0n5YBQuC8jViCkRYWyxeEPCztS25GYyocA1pN+8717
 aMJQFerUgcfdJe32MMAFpN1PVHMEEuGjhnkCtbe7w7XU++/lbyCQH4dzaaKdg4UTlb0BDVR4seX
 WCawZ3GAj9MmhhOh29g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX5K6y+Yy5TgiH
 OZgXiLKHX7pbgakMdw1Qdjt/SsPKpY2aEAIukWPgqR6pdbj77V2w2ImF+4t8MdxwpXjT28RVxg2
 /CHT0YcXlJhRjAkE8MDIsaCmNP1uxZk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	TAGGED_FROM(0.00)[bounces-38375-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E757A6E43D8

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

