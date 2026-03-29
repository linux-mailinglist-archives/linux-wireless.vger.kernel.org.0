Return-Path: <linux-wireless+bounces-34122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CNXGOZSyWnrxQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 18:27:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FB352E6C
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 553CA3002F77
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Mar 2026 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103337FF51;
	Sun, 29 Mar 2026 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LH4yN1xU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="abN0mbML"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5337C922
	for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801632; cv=none; b=ssVwiXSIxRuRGYPJzLC+q2ElIZRei+wlh64YsnGqfTEgMyjbSw6fxV3fbW5U7D/0i3f0RUQ/9Afs6w30VXNaVhN3Hf8nqNgkHM4wCCuaGNBYOTFCqVFjhCklQWgQBSKHPqm4yLGMVQhbO1mByNQBNqJYAmuXSoKAJeuKaxGSpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801632; c=relaxed/simple;
	bh=xlO662m0unxoo5rjyx3DFIhOEQX0knSmHVlA5hbLlKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfHyaYDVZRV0qZiQFpDBb8YdzOFwuzF/x5nwvb3H369+QPM0RD8QIiyov7KlRxBZAffY2+fW/4a3HwF5p3Q1BmNeJE2TrBRGgKTVouKWP9PJSp7lu4puzIWQ7IhpQBMKDWAYyeRgcgw/hsm9e3E6c1R/MxID9gJ9IQfQLmiKE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LH4yN1xU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=abN0mbML; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TAiWqZ867602
	for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 16:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2DRZhCEGAhiBuBP1YCe5luWO
	TveYo+3ES/uCRfsSr/U=; b=LH4yN1xUjGDj4Crv4C/8ISiVOaWv0I2qSshRYCPu
	gVSDiIq3RQ1WWt/rZjqfmoOkmG0FnZdSkBOpuWhqmVg/CchnULzkjGOBgqtV+Sdp
	hmNDBcxDNLtxRu+2sbXcWglE0EQYjCPJ4xy/EM2jO3QG3SvRQ7/zGcTIXhvCKad2
	owC9hl/9rrJ7sGlClsPS9yOp8vZj6YMYxgT1Q28ct0nWpawKFW3rxw89BKoelQm0
	DCczyUmhqSCj5P6F5sTK5Js93VkiTii+LlvBhlctBV+jRNbpxrUCA3F8Sr9f4S1K
	CfH7PkzDd/XgRDvCWdQWjspoROOv6E4RU9OjCTdOdv32xA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d685hb3c6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 16:27:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b4661881eso46264391cf.0
        for <linux-wireless@vger.kernel.org>; Sun, 29 Mar 2026 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774801630; x=1775406430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DRZhCEGAhiBuBP1YCe5luWOTveYo+3ES/uCRfsSr/U=;
        b=abN0mbMLI2Ul4k+1JlPXqKNwyfx+0VeFw84+g0l4JTS4jtbiMib4WHdpZYWZ/4Lid2
         iM42L0Hxp/VmjGjYPYxjlCksEJAUJHWbLLcy10/IzmZCjr95UemdvK0lHSOfWs9y3UhQ
         PUQL2Tt9vayzuLekBc0IifjTQfkdqtVtuID0fex0vNfDPj2JXk2VA0IIXUB3S0PgwX9m
         cANiR1kUY6OmAIk1v1OCi2LEdhbFFQ6XiblkpYN53CksMDOWM0rnrrHz3G3KW0+NYlP8
         Nauo0W5od3v7EGrNwrhcUO9QtH8l825o5ld/MUS1jt6OY5Zu6vHgAWgKKf7bOSZFlOXi
         AnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801630; x=1775406430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DRZhCEGAhiBuBP1YCe5luWOTveYo+3ES/uCRfsSr/U=;
        b=VVoPYzEMPsnzLGvc4wWZcOEAtuj19fDEJcJ1e6r1g47J0z9KyS9EH46svgNEfKltS5
         ELgo/2FI7gDe5SbXlNLQPbWIDbAk+ZA5Lrr+59jirAIFxUVOZZoR8tivaTbVXiGUmG+f
         cmEX1ePigiRfqgmDXiHIwLdn/noU7O0AugTcZvR0sxEodYbAMUDqmiyoP3AiJ57sRyko
         Zn3LKah4gZmrZr1NiU4F65YfxcDP4TApl5Ul4mR0gLbC7ahNKv18EhV6PPYRkB6HCfDQ
         uzRGr9DnrayQVBpQn99gUObBS6nBGFFrLyEkO8E17WmU6aiwfbH1wy4v1H+KTwlq48IV
         O8sw==
X-Forwarded-Encrypted: i=1; AJvYcCVkaIEpqvJmYBstuewbuT+p7GlO3OBgOAzoMjKQFy3y14d1xwulD0Sbu0w5foANtuyk+OaltZyc79eEj43jLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YylvUU/4q9gF6/RdhJterKTK3dWGnDRNnB5//L5QDDb1LXIvml+
	a+iAZydjjV8VzE5+No4y4VMGag7lWaVyMPPS7wbGnE3SDNKleRuux8BW+VcDcct5CmSIcucwKmT
	M5yk0/c2F+4JV+StvQR9QkZdSGbZXAePjncGWCUPsbvgQom4UJ/C0HeSKvU3jeUm3G47zGw==
X-Gm-Gg: ATEYQzwc84eScCuWtzTo9BPR/KWS/TT9hPN/+4TrBV+TtPY9iSE2dYz7/An8hp4tBen
	SgfpuQbJ2v5/G7qaAjRZ9W61mc+FBu8nKFglxOpE/AwqiTt6VouFz4y1+nZTAGKzvU4SUb/kC1N
	UCARKD0EwKt714r3mxjKey328AJMGBoP3oBL65EWPBXs/ynMkKLV3I7qjzd082E8wHmo/mVYt9j
	sLR3kEV0YEbH91t7+t0D6TsYnclrmV6jb8Dkx4VzCIcOUSv1GICLoVZm2zGGb+sLOm99hNgulm9
	Vwi+7eM+Ev96uZrrovNYrvaLtL10OVQmFD04oiRlZTzspBX9y9hiaW7umGGEJ8zFW3gKqoEyp8J
	F4e+qUrcPZ0TwrkSrnvIVqyfMySAtbDo59vDe9HvtEX5joMXA1aT5vQAuonv4/+EgaQfCzRF1iD
	cU85UjzQXCpkLTLywMm0m9pAA+ykmFyZAnCmk=
X-Received: by 2002:a05:622a:4d4d:b0:50b:26d7:eaa9 with SMTP id d75a77b69052e-50ba398f174mr111884971cf.64.1774801629998;
        Sun, 29 Mar 2026 09:27:09 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4d:b0:50b:26d7:eaa9 with SMTP id d75a77b69052e-50ba398f174mr111884651cf.64.1774801629485;
        Sun, 29 Mar 2026 09:27:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c8389524esm10059401fa.21.2026.03.29.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:27:08 -0700 (PDT)
Date: Sun, 29 Mar 2026 19:27:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>,
        Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
 ath10k host-cap skip quirk
Message-ID: <iudca2llwe7dgisilievlwz6t4vbswfywmz43v3oski5usbvxo@ll37ug7adaoe>
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
 <20260325-skip-host-cam-qmi-req-v4-3-bc08538487aa@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-3-bc08538487aa@ixit.cz>
X-Authority-Analysis: v=2.4 cv=csKWUl4i c=1 sm=1 tr=0 ts=69c952df cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=I6QQIrWB-BqS60JhQb0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDEyOCBTYWx0ZWRfX/RB67TKBnDwE
 xRfHB70g+m6wNBRRpCBPaeBimy/8etukNMrafnmKWdwasCqIFyR4azoWfM3WwvpRG6PBbXvxOYS
 acPX2ttsXQcGQgjHHTBxqH9EdWx+ZsPwcMmPf6Px8ZQAvfpO2x6gRdlN956g2sJBnd20R/YprGE
 SzkiK6qMPb28evB3GD8divvkaXMQr7BMwz1IxM/gU0clEAi5S4j9ol8aLVJ+99EI0IO5r3CEpT8
 KE6RVRjzW62o36wEbJZP8RRNOWc7efzXLyVR5kYTd5KxGZORRUpUy/SSv5TRpjM3v0ryo4lgzib
 guxR5BdS+ZE+7qCoafL/QHEp7It8xGBZehcjXs/olaDZYOwenTTb1I+/dKb+yc7R25jPUgss5rg
 VMCkZUk7wI2Uw5ujRqeyDy9jN+Yi3U6sP03mcpRa9vSNZsQPE3OumkvWX7c0KP2ensPqQloF6sW
 /E+aDyLZ593OCVqh/5A==
X-Proofpoint-ORIG-GUID: C7fENZJkLCc41OXF8C-R6V0mwtq13Ols
X-Proofpoint-GUID: C7fENZJkLCc41OXF8C-R6V0mwtq13Ols
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_04,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290128
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34122-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 643FB352E6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 06:57:17PM +0100, David Heidelberg via B4 Relay wrote:
> From: Amit Pundir <amit.pundir@linaro.org>
> 
> The Wi-Fi firmware used on Xiaomi Poco F1 (beryllium) phone doesn't
> support the host-capability QMI request, so add a quirk to skip it on
> this device.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

