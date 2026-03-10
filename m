Return-Path: <linux-wireless+bounces-32790-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GYQOANgr2kDWwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32790-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:04:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A37242CDB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 01:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13FB0300BE83
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 00:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941504A3E;
	Tue, 10 Mar 2026 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nZkP6IpY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HL136g9U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4310E3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101054; cv=none; b=To5Q8yuqlkMeid4eMyj9cYo3cpDSik90WAEekDkCtbCJr7JbG5eyhOpdloOh3lXi7L2yNaj81fge43Tayx6NOIE2EPa0r+t40FWfti46zJXx7B/UksDDvivjMqgJ5ZGlrH3oVsN8g7/axMdizxKesn3Zk3DfTuT3MOYiykJqcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101054; c=relaxed/simple;
	bh=VQWCIUrbKweKNWorNf7KFwPTbOnRWvHmue3DUd7hCW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgTkXM0kOrC9OixD2PcE0n9tfe12YVmaA+gJ+tCLPBsryTU7UA4AZwVXEV/2lWF/NTWPAamdyVtFiXVWXbihBvRGlJPWvOxwyg05QPXpYsIt/pf87mLhEW+VEwvA0IDtAcveS5YgyJw4vIj+3fdy/1sMlEcMAd9Lb0ZBSswQyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nZkP6IpY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HL136g9U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629JG7lM2872979
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xDBB6MSWvIU+uCb142BM52FL
	425T3hgvc07Yy4sfD2U=; b=nZkP6IpYkgOyZjCtuUwwRI/ObSj6aw7Irq10/R97
	PPiuu9fKLJwceK/Xpa/ltlNYRujyeGcThKXjnd1ZPj5BOWnCNOnOT+tuwIqX/9kg
	KPHv56GsLwKOToA1ScWSDHUqqWofqSFma5li/xOf+VFsbJXzKPscn2meX2n5aZsf
	XtSa6ak0iWjrflH7/qf8aiyE2D1I5OaO4RYJrfzuX/e3VtNDkNowVusVOqEC87Nz
	wJ5TX8ER5EDtnxm7bXTGnP6qHbg93W0JM7UpnEpZ2OW0EXBM4a3Wqe4flApHSn5I
	uOLdhni2r/07ThP2hR/CEJLCeB4ZAOY0/M80kRu9WTivcw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477gqf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 00:04:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd81be6f05so1122700585a.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101052; x=1773705852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDBB6MSWvIU+uCb142BM52FL425T3hgvc07Yy4sfD2U=;
        b=HL136g9UKbHSedrtjUerN3cCib9lfxyUL+gVy1If8gubrc5bFeDRE9KktfjMH8KeDr
         wUitAU1ORz6QySSi2SvmBdOq41kGbOdWSAb/iHbt9/gmHJ6kijPybCcrdnb8yUwV1Cna
         g3uORZV3Hc98o8ZbXAgApWj3gxm18s0szdrQ5567FBaK557TRRWDsQwUTggUaCaCEF6V
         x7UD02LMSFvajQ3bUccJXPlkqxbCtDWcKdsgjksy+Bc961OrWXNjszzx0hviwvyaGwmm
         Hr8p4AQrzW+FCgA9WlHoB5wpaKbK2KWI0ZfXr2TPdhUf/vOc1OjKusRLptBT62qLXm4c
         U5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101052; x=1773705852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDBB6MSWvIU+uCb142BM52FL425T3hgvc07Yy4sfD2U=;
        b=DvO3WfNDo2+T7lxAO/j9gH8oflnIxOHbJRu9xmA7qs5Fsa8KJm/UDQu4qqP5w91HfY
         ZR7vWWPjObkn4wUVSC/A1TtV/csYPOqJOBH8ciGfGwy6iNR5Hq8WEkilN45oOEVZQPWq
         AHts+mAwoNMyQO5+a0B/8iargDY2r2Tv/Kgt/K8DwaL2pQwZbb3ReYH9io/QYxDeprgC
         6AwNBUIHxqm0n02mmKSAuD7ZzRh2mwyIrxFKXbLXuqDB00O4uZ23VtBTpqz3FF2D2vCw
         5X3O92PcVs7e5ESVk3HpjN6fOLJ+OYE2uNyRySvfvB6XwWVLFW7OEBw4+L1bK3EHfyrD
         yhKA==
X-Forwarded-Encrypted: i=1; AJvYcCWLaI5CyI+MZ9N1COkDpvIja9d+CE1BObf3dDysu1Muo4pk/xy2HCdxIftk8oQFuGAP9x11gy/a0qWsMsIRFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVv/kzXhaLjSrFpEjTlySrwhayGIN5hPRt9WgSJxypIN0qCgA
	MoB7xZjN6iM7zIZxjQZ2xMtHZkp9Z8SwoyKyjfg2X0fVv9bEFj+YptkMv2A3L1B9iUEb1bcOa+c
	bz26Ljj28FBvl4bwQiaQwS7Ag6R5AXGoWVitoTm5ccDRK6iFfm3blrSg/vUjYjtgPfBsOIQ==
X-Gm-Gg: ATEYQzxwgClOTipmwZsMBVLPm2OZB/IvapZ3BUSkM82wNI0rhEj+6QI/fx+wwyE2UAO
	4n/aySNs4BAeDZvIfvEBdsRtmKH7cLcpuG1o/OOOXoppT8qZaCKHH4AFfoYtfAISHvMuRmDhYwL
	5ZSsoPSK41UB9ND9iKipwh2Rg0eAxXfCRBlyTW3FP7QBaOqMT4RnOmkR1dXUiVIJHZGITDfbM8s
	7hUXDz0AyWXik+XuOZypluHwH5DcGoUSP4d0/pVkgf9l4a5OdYEKG3XgwUCp+CmrxA0VaS+79VW
	Llcg+VjxEmMzO6i5WOV8yiVpt3ERJeNOeqE4l2ZAEgK3WHflKCnrlIM5fz9Y20QE6Xswvc1uAye
	YpU8/f00OV0ZrTtaO8AoVDAqoq6MfcktIwqyDs+hbHhxirOklzUrM1kH7b8QFUXSyCrGiwTiI7W
	NHciSHkioW6B5uK1Nrw4mPmaaSXyz1Hr7XX40=
X-Received: by 2002:a05:620a:480c:b0:8ca:2baa:6658 with SMTP id af79cd13be357-8cd6d4f7dd7mr1634214685a.70.1773101051661;
        Mon, 09 Mar 2026 17:04:11 -0700 (PDT)
X-Received: by 2002:a05:620a:480c:b0:8ca:2baa:6658 with SMTP id af79cd13be357-8cd6d4f7dd7mr1634211085a.70.1773101051178;
        Mon, 09 Mar 2026 17:04:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d085ee3sm2378748e87.62.2026.03.09.17.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:04:10 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:04:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 1/8] soc: qcom: qmi: Enumerate the service IDs of QMI
Message-ID: <3yzmnaovl5dwhxc7r5dr4pjrvcqpmlec5vrlzhnj2cnpobqpq5@uvfiuyakrg6b>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-2-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-2-daniel.lezcano@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX3Kn7vTY5xYhy
 TqHx8NdnURcWeme4ZqcjAZAiHk29ffQ68edGP15jgaA5AO0k54eXtBfDT1YNmPNwt3QLUp4AhCN
 irtvZZAh/GhlbxamlkNDVYBcqjt5hT+yoaNCNHCNZAPn95JS5TwvI3+lIxacb62mwNQHdwDDQ6D
 VQzCmbqyu6MHQ+Y2CWEc5Q1ah/aBItTe6z/6UyYBT9HFNCSgxy4s16rq6wHZz6s2NRaePb/Cp1/
 xzueoJLbNU1u/Ik9xkAuZdw9FxR4EjRhEXg7ugY0BOLHxYnMsZ7piW/1Xbjx9ZQ5CWqaQXA/4vl
 cKS83q77rl1p/DLxKFsKbQYdmpfRKWLMlN9oO35aotRHQWDBzMLOLEK9CRzWKEhcvLiscUHkZlp
 Nj8wyQpXGbMlfgURhlu/gKRFAO1MuRS8n2euUFVlbuD476hzinrAf7kFzSwlA1LwtFKezwd55BE
 /A+S0inXxsa+zbOSUig==
X-Proofpoint-GUID: 9BmSHmuGaNMev1lPYXpk05aPVdET1hRZ
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69af5ffc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=cjxZHsy2hmLZGnxokmcA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 9BmSHmuGaNMev1lPYXpk05aPVdET1hRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: E7A37242CDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32790-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:30AM +0100, Daniel Lezcano wrote:
> The QMI framework proposes a set of services which are defined by an
> integer identifier. The different QMI client lookup for the services
> via this identifier. Moreover, the function qmi_add_lookup() and
> qmi_add_server() must match the service ID but the code in different
> places set the same value but with a different macro name. These
> macros are spreaded across the different subsystems implementing the
> protocols associated with a service. It would make more sense to
> define them in the QMI header for the sake of consistency and clarity.
> 
> This change use an unified naming for the services and enumerate the

Nit: see Documentation/process/submitting-patches.rst, "This patch"

Other than that,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> ones implemented in the Linux kernel. More services can come later and
> put the service ID in this same header.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  include/linux/soc/qcom/qmi.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

-- 
With best wishes
Dmitry

