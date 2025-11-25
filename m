Return-Path: <linux-wireless+bounces-29340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 429AFC8577B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 912C84E7AA9
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215EA326930;
	Tue, 25 Nov 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qkqsvkam";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4F+w7Q6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748E32572F
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081742; cv=none; b=IAfyN+FmVBahNzZFlwuB4+8tkwtQJUSjyOKkrOkjTo4kiatotlmPbsqiVONa+N/p5Idy4TKhN3Lwyuzpeg8VkRSvHK3+TMTYTZ4MgbqnMUXFjC7fwqK0mKN6PEvmPSXWhJUHpvWFwH/kEoUfAoGRQGKvGi3QuPUimttcA6tCw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081742; c=relaxed/simple;
	bh=Uq5ookugmQ72g8IgWzLDpg171fUGYgm6eIg3r3MJ5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2DfGzce4ATkygBtTcqS3IdKASdf8aFO88YapfhyhGdMbMaRa9ElFsl1RlyXGJocBOjS+TTEyZIxFDRgbqKHQbzmXsHRoEskBQWnsoGOcUzG5RuzBvSkbsnf1V/6UWxLMfFalOB1JcBEF/BOz6XsbV0L55eM7c7DEzG1uFRGTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qkqsvkam; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4F+w7Q6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APB5NLX3255831
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 14:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QGiwTpNXLbFpjJZpDWsxtZ5m
	7PWHYuQFZ45Lny0LXjc=; b=QkqsvkamoioRLoTPiH+BFPO+NFd4MlTFdH04DBZ0
	ieXoLFG/nmpwbjBLU13avleDcVdB68GGXqqBQDODFySbYIwrXvSwVfNEkYonJxoB
	vY4mdD4QW8r1FlSdZjH74sFAtKeCPQikEVdcqVdkP8s91HTo5XDtkK97BSwWVzb7
	7avs30zshdPDW7aXrBQCXeKv9eVONYgvv2w1SkoqPY1F8qKznEYuAFxGbsdDzIqh
	l+vn/2Lfu33eQ3jSI9mN3MrJQjgNkTfZpTiU1RCVXQ4vDOx4n+6Jwbhug2+Az7Qi
	oBTGUwsxqJCtmtgRA2Xy9xpYazB4c5Yq/SwB0pVQLeLn3g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anb9c0jqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 14:42:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e41884a0so1500429285a.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 06:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764081739; x=1764686539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGiwTpNXLbFpjJZpDWsxtZ5m7PWHYuQFZ45Lny0LXjc=;
        b=Q4F+w7Q6A25iXKED0zrnO8qhrYiuZnn2CJcJg+AhCVuYNSZCusZ6fF23OEO/QLiBfi
         dnR531DkWwlF4V6iDAqq9QviFGqE04jmzmA30WAQSUKEgxMfZQu/OcVXN8sOJTd9rpnc
         2ANqU1bZ/EoM+fA5UnLBpgo61xZ6LT1bLFFuF/4VjkuRuE9MSk3AkkQElZn50LwBbVwY
         PQ4L+QkCtyje0YRxPlnjyEiAlxlOVfP3ANA7oK1C0w4+pbtlAbERgXNswYTo/yRf3mdu
         blsT1r0bngkpZvStbnMt8Fuidscfq0sURkQRjQ3n4v2KFB5Z7R8NwiXujf6nB24YAVnB
         MMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081739; x=1764686539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGiwTpNXLbFpjJZpDWsxtZ5m7PWHYuQFZ45Lny0LXjc=;
        b=o8CkhGp0BBXoo1Gy7Fl6y0VdzcBVXMTcFWg5z/mFz7uyCOkE5qY3DZ0pCTPxfDY5iM
         TgQr0pb3grN6UByWnTiDTC1oQBbV5/eid5hbUn7GsHAKX/JmPHYjnP1O8g4B2/SRoWMw
         TueoRBJadkMa4zZknR0bFkMUCTBSAeppjnRzosqscnW4nWirGk+iy9Z6ix2jt6gfUkAB
         kxBuvG8cVTKksej3AQJdLR3wgCSV6H+Y0G1glmpVDiHPl/h3KKoAlMyQfE79o63ucomj
         NdPgLJnQCXTKP1IM155bYtzmJNLxPP0YImZZ0Rzq21ahWHjOEJheLINvw+XwBTbbFvS9
         sSZA==
X-Forwarded-Encrypted: i=1; AJvYcCUiiM0u/rUbHZtIoB6JGxqfMAi3POrjS/Crs45Ke+llDGzE9B+F2vQaO+8zX0He5AhXVdpYJfhW8eYLtQLWKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZCQ0wPXrPv1LiDcoPELBU5X5KgfSSU857z8PQaMM/IbMhy6z
	/Eslqv3X83JXPhNFeicG+h3wNhQKwm+QiLliadVA4IZ+lGOmQhK2ie+1LS4twAgEP0/pp6MQ6l8
	hZNCf5cfw/Z2ii4vLRFAgY8sRC5T7JegEd+ze0CBXPuwEC6hGng+kQD7HI5Npn5VeTBtKnw==
X-Gm-Gg: ASbGncvljgBL4c8BUmbtL43yROxmDEoasTg8ifHLBhHtiChMa7ptwrmTYKxj05UEyQa
	8L5dc/CgmPYIKf6l0gjwCkw68GuDzUYl44FIA4TKUE0YXwuFetG0xdBfxVOKAHX1CBSuOzmoJy6
	VLMAmRphBCGpB8CsFrlFNEuJKWlHtwOVG3yeEt7xRaVaaLIeQhsWeC742vlQtkbq0AZC5qZd4oF
	Qus1h8A4/nDyHAsgXWyCDyS9EKnfmcj+LBP6gyalMTNyP3yAas0rrIqa8jIYo8rooNPYH3KZaxA
	Un5/TIKfLc5pot7nrtYATkkIBi08j1A4FdQQhwmWZNVVFmbL0sMuU+fxi+19SctV7HZkCg6bXha
	BtyF7yqNx5OxJGcY4OZbDcEpyDHBsW4iV5MT2xZw2qyCYtLgOHMCTqLCV6oHvlsi9K6fH65944E
	4gLvsgp3OY
X-Received: by 2002:a05:620a:3728:b0:85c:bb2:ad9c with SMTP id af79cd13be357-8b33d4773f4mr1898798585a.53.1764081738460;
        Tue, 25 Nov 2025 06:42:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmlMTG7Ip2VPXHNDOOA0wwV0LI0Qd7VntPvkheaXH/P/uFMCXTQC2rYLbRyXf/+XgeIt2wlw==
X-Received: by 2002:a05:620a:3728:b0:85c:bb2:ad9c with SMTP id af79cd13be357-8b33d4773f4mr1898792185a.53.1764081737894;
        Tue, 25 Nov 2025 06:42:17 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db756e2sm5214752e87.10.2025.11.25.06.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:42:17 -0800 (PST)
Date: Tue, 25 Nov 2025 16:42:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
Message-ID: <b7gibtoind5srjk6ncybnen3ikdvwnktg4epyzbltg7alipmex@k5zzpbnmzlso>
References: <20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz>
 <2b34ceae-5e31-4dba-93e5-3fa35754fab6@oss.qualcomm.com>
 <ttka4uevai7tzf4c3r7rgozzpd3hsdhjzf5uyysfzj24ex2o2v@r64z6pvxb6sv>
 <6a3448cf-dd18-4b3d-a8fa-fe282ee779de@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3448cf-dd18-4b3d-a8fa-fe282ee779de@ixit.cz>
X-Proofpoint-GUID: DPIK6WT1cEh7rbOuzqf6E9JjYmNbdTZp
X-Proofpoint-ORIG-GUID: DPIK6WT1cEh7rbOuzqf6E9JjYmNbdTZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEyMiBTYWx0ZWRfX4xrxLu5M6TBv
 blI5ZBCBK1zz/q8DS7HkHVQYUXcb3ZnNuKHg7SG4Sa1fv1EbJMKJgBfUnXZ2L8k2Xif/VJMfiDd
 pIKSdSY3TAQ21LSfyNtn7QRnOHNZhvOA/vC0jiIuz4hXQalLIDuxLO2bp6JQ1FRw5jnZlFfs1wM
 HA43A+BSuZj3mnybgDqfrSgpzFLNS1TUwTaB8YESFPq8aPo/k4MChOyiquBIFA6FbusrtEQ7OKb
 Hcxyl62BzipBbXLbUinlq9d1Wau0aCsJTKhbtWOq+Po7c55qmpYlqGKkkehZSJj5khE8XVhWZSi
 2WKLXzpCgn8aVTHcyUA69Twc4NUMD2PV71wfgudh3/0/KEUQvvzXtEHZz7itn6nu+GZwRMT47Nt
 2lGv6TKmoDbM77EvMeaAwyne5PIzPw==
X-Authority-Analysis: v=2.4 cv=VKbQXtPX c=1 sm=1 tr=0 ts=6925c04b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=pvefKgMU93j4ZQig1qcA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250122

On Tue, Nov 25, 2025 at 10:29:23AM +0100, David Heidelberg wrote:
> On 10/11/2025 21:41, Dmitry Baryshkov wrote:
> 
> [...]
> 
> > I think this should go to the firmware-N file. SNOC platforms now allow
> > per-platform firmware description files, so it's possible to describe
> > quirks for the particular firmware file.
> 
> Since the approach to put it into the firmware failed due to early
> initialization, see
> https://lore.kernel.org/linux-wireless/20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz/

Is it required before we load the firmware? If so, it must be clearly
explained in the commit messages. In the end, if it happens before
firmware load, there is little you can do. That was the reason why
qcom,no-msa-ready-indicator was implemented as a DT property.

> 
> I wondering if I should get back on this series?
> 
> Also, meanwhile Paul found another device [1] in need of this quirk.
> 
> David
> 
> [1] https://lore.kernel.org/all/20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org/T/#m90e8087d4388e588b71a0eff01b88f1721f73b73
> 
> > 
> > > 
> > > So I'm personally OK with this suggested approach.
> > > 
> > > /jeff
> > 
> 
> -- 
> David Heidelberg
> 

-- 
With best wishes
Dmitry

