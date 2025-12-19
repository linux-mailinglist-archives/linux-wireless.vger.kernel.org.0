Return-Path: <linux-wireless+bounces-29919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6FCCED6F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 08:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A5413008894
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034002FDC25;
	Fri, 19 Dec 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZxJbtS1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FAfFlGiL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3F2727E0
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130597; cv=none; b=jQT7Q8vkYbkT4sSolW9tWtcSBwgazGQ7X4Ur5CEGAO7yV7as5QxqJDU16C359yXssJrwIJrNvHpc2EhgNT8JIiNVueUy4hxCgEnEhOiuqUBfkiYv6LNncfHTmG+A5Arrv1WOrkw8T5yoJFddSV9MSy8A9PXGTblwuvcSxp4lCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130597; c=relaxed/simple;
	bh=u1nqXpoKUqnz91oo4RRHaJ6BqI0Bn3Yn9+6jh/B4hfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyNeB/kko+PqT/Fvft7/kuIWutgHomCiMJUCeS3ShllRcS1rfzkuOaNqxn4XwKB37jfARTVUAmIl58yRo4zigWI+vahf6kAmlQzUH+aK8daHuXmaY+Brs5dyvNYiZVkmquoFW2N4p5ixJjWHf1148UBre/MzQQcmVS8gNyBfFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZxJbtS1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FAfFlGiL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4c7Y43999351
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HZlzaaEJ6wxrrcHssXM1jJEht5vIfXbpqNRS80n6cZ8=; b=jZxJbtS1W6GgHqih
	mSQIj+D1ySnkzbLM9dida1U9KcUTKSx7SCo3yNCosar9C5FdSiSlcGLC001spZHQ
	rZK+aFA9mgjPeGU4XSe+caMW4MGosjZjDHKNnpM/1L/mDnc45vwlQ31iO1P/VN8x
	0qN1eUDM5kCCxh76fBV1/pigynGoeSm0KOcdknRO/5lCE3LTWSfEOU9nNOMgNDjL
	sQOlG3eG9lOyT01j2BVLjSDJkEFaxEtLieb1Bh0NNM20yFsAdVNnO2v2YtecgMzU
	6lYXXzw8LFLtjWFGZuPO83cJwyrcAPwevp/vTFg/7YgzBmU1953+rg7CFiWnWk3x
	kz2cZQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r29hshh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:49:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f4a5dba954so24767241cf.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 23:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766130595; x=1766735395; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HZlzaaEJ6wxrrcHssXM1jJEht5vIfXbpqNRS80n6cZ8=;
        b=FAfFlGiLlVx0VqJSeC3/ur9Wc3iLHkmBZgl/4XJ3m/QTEXCCoj2zp7rkpEXmnWwE7k
         lKa4I9hFdKkOl3Md+Zer2OsjhsKdv5ekB18vcp94g0ztU9rUsH06q6v1YSIqnFv9y05x
         k2hkOfTEMC3zl1VQMRuNNVzyWmuHNiviJ2n2alVrb8bTAEQzsFLldSdRYpy0Tfv1zJ1D
         YjSGQpCupEf+adhSd1MToqjOI0auIUHcAu4GZT6wGb7Ak4erEkL+YtF4TM3oSc6J/4Jh
         9yzWfA0zDeFWY0xbAH47oPmrpp0k+z6UtIcOeCJCux/y3b82sxNg34Cjfu8b5elMifot
         YWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766130595; x=1766735395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZlzaaEJ6wxrrcHssXM1jJEht5vIfXbpqNRS80n6cZ8=;
        b=YN7Jb0psre0x/+JdP5gp3wiF4AixRKMrwu80ZzWJTq017adsLdTSX4h3Beg3nGHnh1
         EO198taL8tztWaK06bWPtx2kmUizh0D1KH2u3+vEQNEnvs95gitgcRi935Qm1BZuq+yT
         J1NYcxIYLM5Lc0LVmFxRC0CyEBgdYAnHthqxklu2cHWrfOAVE/GVWDVg2kBlzCvb33OB
         I2Y7809FbD7RS5ojQUBk7iQ6Gdx6sTuwrTXaqsmQlPn1O5AsXqEQg2LEALTtQAI1Ii+x
         mIBQlHHmLILh31t2uiERF9NAAb86xF3HN8Cgvd/YqQGM70aFMjpS//KiFJetuC6LaF9o
         RcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5taUzgA3+p+kNVI/sgFj0pIYo535YvLGLkq29l/Lx9aWD2+HtPzC6wET5QT2bt/3eE1OXv3vGTNM4w1Fidw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBa/RGZox8PoYSv9uIidQ7+1ZE/y9OT/L0Yx3RoHUYt+OeIaX+
	tfOrzoyJZZJ6Lw674vDG/1Mjd01LW5C/RRnaVJcbWXqPCTzSIE1aR2qjPXmDxwzTQAukMBHcQpt
	SzsdgKaoY9Lw1b8d4FR790Kl9/KiwbJoPIsL6PhL09jfGmRenvShVJbnaU45O4RgeSlR98g==
X-Gm-Gg: AY/fxX5btNTSv+ODrCtuMJ3Qd+bw+XlYEAHXnt6XVQsisRJ2l6J17zjG+QEqlWFSquN
	RhFojiuKcwGeVYtrvE2ca6fkQx/1D/c569e21UpWiYVw/C8pcv/TPKwAzdNILyc5dE4p7g5Oaux
	DY+BOdPAoyLsufLOk3z0vkMSMKepZFZmK5tgC+IOiMVVKXkybWu+Se9R2kam238pZENgeeSE4Jr
	SMIb/vUm+DSG8fPLXEqK/KMOQ/8ZebAXwu8vpMUlVWTryKuRha1ckkWnVlo3hC+8qCAt3UtEd9U
	zUdyeufQfBL4R7FnnNLD6fUM3JSJgpzj3AUCujypfFI8vyvpGlpCinhLhQeeWGH2gz8FzSc3aOM
	dym4Ph52ANEHkl4Ed6VcbDr9qioNtJt/juVTgVoMqUDkAKIlOFKXYhKqTGYDnlBR8K8OLqJkbBw
	iTgefxu9xA3hv3whW1DFknshU=
X-Received: by 2002:a05:622a:1f15:b0:4ee:87a:4d10 with SMTP id d75a77b69052e-4f4abdb63a4mr23026361cf.78.1766130594715;
        Thu, 18 Dec 2025 23:49:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0rwAFeOYFYWNd8aqh9qwfojG37bl+Qt7bAMn6Hl/AMKiwrZmA4fsYM77wdMC6YdUhqmP2Xg==
X-Received: by 2002:a05:622a:1f15:b0:4ee:87a:4d10 with SMTP id d75a77b69052e-4f4abdb63a4mr23026211cf.78.1766130594219;
        Thu, 18 Dec 2025 23:49:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5ea6sm487096e87.5.2025.12.18.23.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 23:49:53 -0800 (PST)
Date: Fri, 19 Dec 2025 09:49:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: jerome.debretagne@gmail.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ath12k@lists.infradead.org, Dale Whinham <daleyo@gmail.com>
Subject: Re: [PATCH v4 4/6] platform/surface: aggregator_registry: Add
 Surface Pro 11 (QCOM)
Message-ID: <njdekii3plrcrbno743lpspc7vxozbfkf2s4vdft5huoo6iyan@usu5pn4527kx>
References: <20251218-surface-sp11-for-next-v4-0-7bcf83c1504a@gmail.com>
 <20251218-surface-sp11-for-next-v4-4-7bcf83c1504a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218-surface-sp11-for-next-v4-4-7bcf83c1504a@gmail.com>
X-Authority-Analysis: v=2.4 cv=P6c3RyAu c=1 sm=1 tr=0 ts=694503a3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=3uxqv5YaM5NtnTnEUcoA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: puqmhG75bQO1tbGpUvs5H1ZK7Ap-9ujt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA2MyBTYWx0ZWRfX8sfcDsrnow7x
 LQM3DaP1JfmJF8wiO+BgnbiFtrv9TJLG/pLuMAWaZXxbfwt7hzZS9Y/Qy3sa5ppSLV1MmkFC3vD
 6ZrmyCeFEbsv0WkQxbOo8F7NGCsHXDqbOcARuFh1CJVxti6iNBNgiyzqf8eQVRY2q/fkedZGo/W
 LyxroL+zGR4uMUTf9yVEyv10Rx2NlIYM9iPATgszmSDMaWclza+rlNLgDbDuIHEspAkLT4Yji27
 54qYOw4dU/NNd9n0/Pe04HRpC404xWCcUbSQKNCwbyp8h1EvLs617Ncc1Oe1qieHwyIWg9ufHsa
 ZwnYWUBqa/Pr6ISso2DHzn7VbNxBUTFy9DonVmkvaC9ma0TZUXxiYaIVz4ON8kR28vWqCiSBPJb
 yAGjEetq2DM8T+Y2ck6GFd4takZg+CNH+hGu9zLmagnzSbjn4wZLjrSqs7YZSLY05iGAABvywnX
 UbLhBpCfh9no3K5EF6w==
X-Proofpoint-GUID: puqmhG75bQO1tbGpUvs5H1ZK7Ap-9ujt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190063

On Thu, Dec 18, 2025 at 11:22:10PM +0100, Jérôme de Bretagne via B4 Relay wrote:
> From: Dale Whinham <daleyo@gmail.com>
> 
> This enables support for the Qualcomm-based Surface Pro 11.
> 
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>  drivers/platform/surface/surface_aggregator_registry.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

