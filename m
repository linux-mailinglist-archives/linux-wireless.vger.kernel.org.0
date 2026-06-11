Return-Path: <linux-wireless+bounces-37682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mEocOwAWK2qa2QMAu9opvQ
	(envelope-from <linux-wireless+bounces-37682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 22:09:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9869674F8A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 22:09:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RAqxCevD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="X2g+2WX/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37682-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37682-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 164203144B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79436CDE2;
	Thu, 11 Jun 2026 20:05:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A56349AF6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 20:05:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208312; cv=none; b=kvpapXP98pMM6uoELSME2cG/bZudUfS1rrmFDvNInx6aCw3RII+S16jhQBZs3y71Ahas/N6dL0Eo99IpmKAkfe8jreHbwVw0LWHWZk0JUFDa7SPNT81FjGl7QEo68/pfIxPsnp51AX3vE16aQM781uV0zoiF8JQogImvJX5JHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208312; c=relaxed/simple;
	bh=/PJ574lbgqCaoCMVo1Yw/p6bzvW2kDDxvFjQvuxEDpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/2CklxlDpd7Yg2UQoKjV7OJ4SvUMQMYg7uiQEI95SLXkT9E1ESuuWHvAvT6G1cn8eonMRWsJksZfj/yrBv8oljWGK7sAiMYU0Ca9z2w33HuilM6XkL5y0r804eFCB/9bp8RfxbugX802Smmq2J5XXhrDTCMjQpzwqgC3owi3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAqxCevD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X2g+2WX/; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3GQ11426639
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 20:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YmR4e1Tj2lOm/nlzcOpM3CCI
	VcV17DTEFBWvUeS7yO8=; b=RAqxCevDyP6U/Acy9PUbea+A/i5HTILTR2AhhSCx
	axV4TvFQkK+2y+J+3UBiXH86NO0WvhLTnxp3XcSfyOr31elHHO9BbsXERpAI/UhU
	8d0OAdRJz7pbQez+he93JLmCBmawgEYH0JsgtbOB+jjNIprXGN9Hjpp86R5PoLvM
	RVfN2lstzHtk/3Bu9V/E/dtjnRhqFjg8SJmiF3Z2MUTSTdIOemd1nWXxANZVvHow
	36X/KozWcnl5tYGNcECKkGUsL7jL92jVkFg0noGxjO6NoHbPD1SDkviSKf7VFLsr
	bQ0S8hNEiDDAYQC4PvCwCCpBRRTufHAfQTGkmVuwl4ixew==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcggbu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 20:05:09 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cfd65ab97aso191543137.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781208309; x=1781813109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmR4e1Tj2lOm/nlzcOpM3CCIVcV17DTEFBWvUeS7yO8=;
        b=X2g+2WX/l+L1CJ1IGpESXQzyMVNspKqXaY1cgTxLaXdcWoowXjyj0IGI08T8R3KUFC
         dLAnHRvP66toLRqKIHbnge5CQYs/Ahfhr0Rbo90xjksd2LT83aG7OiQLm6rfo/YpCYFe
         sxspH+WjZ2f0/B8tUMgfHFf6oVlRPi1RwkASy+OVqOyHtNTHkMF4cGYslZrQCjT8RfKG
         qOpbPe9659EyLz+YAIvmY+zVb6Y3GY4ZGG2Q4Yqye5Vo5BStZx80031jUhkSbwQkmcQI
         MdmPxgwGV+mfs2i+oxiNysoO43BwpIF9oeP6yLH7gjRKmyHPsyVzFnUx3X2If9sL+0PJ
         96Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208309; x=1781813109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmR4e1Tj2lOm/nlzcOpM3CCIVcV17DTEFBWvUeS7yO8=;
        b=BWCIvSQLMkIF6JYtUYw2WWf3xrFAwETiCMW7rImeRKcdYSX/DSprc0WnfqeiQrUyRw
         /xB3OESsYENtfU0gJu9YZLv4Ds/ZDe6HhdKLBaJxOfwyhmdP7pB7wFUEsJcLTw/uJ/RH
         7bXjK4CXoJp8w2G64jBH1QNnXCD09qcLIVAaIaelo5CHErwHaSYPFWILJ5pW8qHl89IA
         zDKcRtvB6lw3d5brJmORkt+71CzyyTH0I+OFjtwDTSIXZjDQmQQqqC0a8yyG1KoB+wXc
         JI/QPmKpZ/kZFnmR4+mmEWSEJWNR/d2xOWcPF0Egz+oijYiF3/ER0U+p0qZo4Bxaw4AQ
         zkgg==
X-Forwarded-Encrypted: i=1; AFNElJ/y3TgpVIJITKj7SA2PwEgBD7HqKgGH/kuYT5AcoSAUffHLeII/JLRCVqg0v3JWw2NT4jpxGv3wEgqBJAzwsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3La4GOZwFTdzqXdwxrQOtMOnwKflZ5LD1I0sjTosgkwplFrL
	9WEEw5GbxbldOEsihiXmR71v1HD/k0olti1IWjn0u8PhhGUN4IPpzGCO8V0U6q7SBlSU+c1CJtI
	AQA3Luon17lELP0iPUA6qSz0mSnyki++bFNM8bAE2afDpDJ95qspIdk3JL866IZazg2etnQ==
X-Gm-Gg: Acq92OGZtN1Y9A+jjs761HVqkm/jqilk3330HMEQ2innDTQhLZIrFOU+Dm6+R7mvThJ
	508wz9R9rUOs8f6lXbXg2KByxK04ZX7aLZs/lujSqMPsPQAzHlF6tKglV4MuLHQFtGoJccDrsBO
	BmrdHoRn9ZCJZv71QwB0hOMF/44B6Clxg4xvuIahAs7ScCaYUvVhr4SGOvGjWQR78a20Mk3LuYe
	dFoba7ztuk9pIgMzNjUQ8+dk8Z/mSvwCyMymnH5j5zHk0H4GLLOKDo141XID+2RhjUAAkWO1+uv
	ulIHgH/7l1MYvwuCks4K0F9MfVG/tPylek/VF5QH6U/+nJ2PsbE4dbM8Y29erT1XRdm+v0fEA4Z
	pICNGea2CYTwZQGFkvBmayrBwKRQhgzKm2jelGzawO+Kv63eOK9lGcbt/p6Z+YGzII5K8RZPEh6
	MxsHW20dNaHUheQA8duPHbnZZoaKx4m5pVjU8=
X-Received: by 2002:a05:6102:5088:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-71d5c4731d1mr3076985137.17.1781208308983;
        Thu, 11 Jun 2026 13:05:08 -0700 (PDT)
X-Received: by 2002:a05:6102:5088:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-71d5c4731d1mr3076940137.17.1781208308534;
        Thu, 11 Jun 2026 13:05:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cd98d97sm108447e87.80.2026.06.11.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:05:07 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:05:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/7] wifi: ath11k: enable support for WCN6851
Message-ID: <fiuuh6rwohtlmwdiy7cwqee62e7jrtdgii7fklfy7jkgh25yul@mzlefhqgzo55>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
 <20260608-sm8350-wifi-v2-2-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-sm8350-wifi-v2-2-efb68f1ff04c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwMSBTYWx0ZWRfXzGczt+h3SsV9
 XRb/r47yadoFnY6S2BgKrOEcqtBRYADb6henzDTH5NYk9x5u0pO1OSfFI5end5BZuujctQQ76kX
 t+4ONwdcy02MxM26p4gpd+oS/Lq9aub5YAcLY7uIylLzEfua8C2dF6u0y3qKdck7omrj5XV4+fj
 Y+ANjcm3W5EaHHtV8+LPpsS3Y7eSfYwy5zZ26HDeq3HjzmGdQA1TcBOhsFnc/VuvMdYFtSQuBpN
 7LMuMnK9wbesi77jI92xOBusXpoZ9PRkROWx3MJ40hcA8XjLFmSD9n6L2g1wRt2l/UclmOwdqpA
 759M69xbPcGUw8dKHNOjM0EZqY4lFfeeZjQgC4q9LOvO7y7HifpyROh/n6ytl5xLeAZyJGni7rp
 QPf1TFiks6hztCdAZUSWCvRGvaqn25QtIvI/sOyyhEUQf72n3yh7g2IrbpO9vJWKbl1dUMoQYVY
 4+NJxsRnTm+sqJ5IPGw==
X-Proofpoint-GUID: veGXUqV5S7SLj_VAGV-IEncbdNwzj7Ah
X-Proofpoint-ORIG-GUID: veGXUqV5S7SLj_VAGV-IEncbdNwzj7Ah
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2b14f5 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=TUQ72T3Q6eNCQUusxowA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwMSBTYWx0ZWRfX2Epujw0Manam
 2Q46wAliGlPlfniwnqUPyfgZtuUD+ByYnzLty1yWG7fvQGgmvtkYYEQMh/ZVWVFGhQQwvPwTe55
 T/aJJTRfgVNl6ppIYIwtjL/dPvI/6c4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110201
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37682-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,mzlefhqgzo55:mid,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9869674F8A

On Mon, Jun 08, 2026 at 09:59:20AM +0300, Dmitry Baryshkov wrote:
> The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
> WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
> configuration to support hw1.1 version.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 92 ++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>  drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
>  drivers/net/wireless/ath/ath11k/pci.c  |  9 ++++
>  drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
>  5 files changed, 114 insertions(+)

This crashes with the firmware that came with the board,
WLAN.HSP.1.1.c3-00200-QCAHSPSWPL_V1_V2_SILICONZ. I will revert to 3
vdevs for v3.


-- 
With best wishes
Dmitry

