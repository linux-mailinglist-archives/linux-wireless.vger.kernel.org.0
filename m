Return-Path: <linux-wireless+bounces-35512-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCUHA5UM8WlOcQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35512-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:37:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E51548B365
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A2C303D2D2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A838BF75;
	Tue, 28 Apr 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O6hhO0Q1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iPifU1RT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2937EFE9
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405054; cv=none; b=mEbT+2NcmZlL5eADzQurxNYHzhAcV1wzwMg/kKyapqED3YIh5J87exhvn3YM/6brvy8bBSkF3sX6v3jgKrRM+ThvwqHMEg/K+JoxjLGIGCEu+JqPaGUQqFBUKNHnIMfec6APTgD8JICeK4w/rLjib6UeUny4mvCpALJ7iLiwk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405054; c=relaxed/simple;
	bh=I0fcDD/ten0VWuouw58AC4kCjDBHjHx6WSSZlL48Ckk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvoOTt6iG8brA8NnUJdVp3hZXYqpRauk2J3+SGiJg5C3/Ue0+Qhynk3ys/vcSS98rdqK402tAD43JeR71N0HgAyB4duig7KnM5/C2CstgrTNEVoZk9l7yeTlUn6MhfzfQjYU+8yNYNuekXIFxpB/NpJYxCHF9kMvz49lIznDlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O6hhO0Q1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iPifU1RT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SH0Zep831092
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 19:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/v2MbDPTy9gk9OluevpeqWGn
	rf+zZgQf7rxJQUu5J4c=; b=O6hhO0Q1fGugTxYhCMSUUbDUN5t2Pdu/vKOlaThi
	H05CGGgHaQdwCuYOV3aP47RiijriQEj6C00oAGaMD+Fm7mDAtK1aQXGpI0PX9sWe
	kPdGM7eCACgtfV7xSphqQ+Ar+jTEq2fQMIL4tQe5rSsT8jeRo0eB3jvyilJ9qIOL
	AO4gllsWQN1CIqrPA421U9tED5JrR6lO3evdfyxNp3NOaBZSz6pn0EZMapUMptnI
	ukV9df2ig8AE28JNOW+I2an4sq7TnGa3FJ5K/Uq07rGAToyfFCw/VF2Kp3aI945B
	ZTBn7lq2+1SLRgpd9UiJ6hoFABuSnlSJYNjmA6jKVcsX1A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0wq8hky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 19:37:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso5664220b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777405051; x=1778009851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/v2MbDPTy9gk9OluevpeqWGnrf+zZgQf7rxJQUu5J4c=;
        b=iPifU1RTF2zijLASr1EPyi01rQnBJ3Xn9ZW1PlWZ6u1J8UTnmF87RDu86pOXrceZ+x
         SN9E6TakJZ3rgxlHoNY9jGIVFN7osUvJAFoTsA+iqQwwc3X2aeay3LYvBCP9BVbvT+Sj
         PDTli9IOkgDIVstJRrWrnk4vic0erEB1M2OEK2/9sqXPq4otESFjNa+1COqQRg16sREJ
         OESF9w4c18u2W5fkXhtwzl/XqISxInufiWtmFG9kIHH4vZtxHPypHU8ejhL/Vfa+WJ8p
         Yz68uba2Y41G4qqRm52wleRyZ/1BdU1EQ15rpfY2zxezkXMpjKEg71G+ZtkcAna9aTsx
         PRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405051; x=1778009851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v2MbDPTy9gk9OluevpeqWGnrf+zZgQf7rxJQUu5J4c=;
        b=ILwpApMzQT7yTnV0x+/C7Yao/2uVjnoBvcySkkOLSGCQp0qAEClwpiUaKOSAgApKtD
         cV2wu4WWyB1k1nIivUVI5PbZRHKUtnGf5wyHXAp5fVKc8d8HSIIIcxme9+Mh6O6Xz5Tu
         bELCQXhomlAS8oKQ0rGQAkW/PSDVDSDliIGhJT3Q/Q6QASihKLK6lp74ePmRDRORFP4W
         FfKTOZ/LsNpSiK7UOpBQoBp1znPJTLDXuipODoZTyDfp76FvEmeZAtA91/oDRLYCQPgk
         tWQ7KMnRADIBgkSHBBAWsl+5dC90HE2kS3JKGCzRwBFX6uqFFttO+2oAi5wUpBkgolST
         wKwA==
X-Forwarded-Encrypted: i=1; AFNElJ9gEFar0kB6Yvn+VMz9fh3hPdmd+7yB0sX2bOuFr/eYKVYeQnFTT+bFftkFcPYE6P35JbShUX/+03PtqJUlpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp942H+asNq62G6FHOMAOgxXpodclJxsfl2GGtMGO+BipaKJf1
	pQg6GZcf7YyBDW5JYYLYwsAeZwhEGuEhiVtjtnkPT6DRF28V+HJC9jgO/r+HfX9KyvfhA9w79Rb
	HFbns5Br3yAk8xgZBz9bJRpWBpMRFod3RCKy1kqBcGSJrKzCvihzgviRsx3Qi3sdSFDIIQg==
X-Gm-Gg: AeBDieuOuieMq9QzFigLRArn4tmAwyDCDeck2Xg06hkpySuvLSJPTNXP4yJwJBdoQz4
	kGkdChxzepTD0RzWjsqSNrA97XTkES8X3eAQKGL8EIkCt5iqneb4nzHUkYVgMdKywC1cf7No0rt
	F9kwNhEmFS5gw/z/Laai5QvOqFuYN6feh8iQQMzdVMOUnuUhKsnyjERgGTGNAnh2g90RdfiXa77
	oUQ8F/Z/wZ6tSKN9h8xLdWSpk+TeG83E9VWz+qQk5kSRYRdmJ4sJtBUfk0VDi6p+cM4s1LTcRIo
	slSC463HrTK4QFOJYwcKFrx3bJ2ngyAZ/+ZVEBzK25h7idk91ZytXFsHlbMqhS4PIBxRmARMFTM
	PDyCPnXm5xHI3M/b1+D1OUbKx02TyHYQTUmzAS8f49q2S3iIba2eJdfQ/C34=
X-Received: by 2002:a05:6a00:a804:b0:82f:761:2b49 with SMTP id d2e1a72fcca58-834ea81252amr598159b3a.49.1777405050721;
        Tue, 28 Apr 2026 12:37:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:a804:b0:82f:761:2b49 with SMTP id d2e1a72fcca58-834ea81252amr598078b3a.49.1777405049990;
        Tue, 28 Apr 2026 12:37:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf35093sm3444849b3a.28.2026.04.28.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:37:29 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:07:14 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <20260428193714.sg5n3tntww2nuquu@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-12-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-12-sumit.garg@kernel.org>
X-Proofpoint-GUID: PsxvHLkPN5Uf-F1qjf22Z8JdJ3dJi5wr
X-Proofpoint-ORIG-GUID: PsxvHLkPN5Uf-F1qjf22Z8JdJ3dJi5wr
X-Authority-Analysis: v=2.4 cv=BfDoFLt2 c=1 sm=1 tr=0 ts=69f10c7c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=IA_ug8NyWMwr6sB50gwA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE5MSBTYWx0ZWRfX4N6I5uKhn8Nh
 qy8hA0d7NSgLptFE1eRe757I2qgpY8+QA6iDuG0c1JzGRYMvxyptBJN+qxulbee7inf2dDE1VFd
 zuvBEyP9uM7lZsWbMee78I9L+qOXGrlRTH7FnTGnEJHD63fzI0x3lO/5KfiSGPXXVzWQjwgmMHm
 LzmwCH8VWd6pceXuzqyE7hB9PBESjHrRIHDl0x1QEyrFU8zL7CZi8TmhPQs397uifvPwBIi57+9
 T14PR4+j1uZM2aKWcc5yBB83ku5MG1Yt8YOtNP6f9q0Z8udWYoVttW4b6JAeyGKcD4I6fTC9w3A
 6CituzvTkFbXume8pGXdVrMoIhX7WMbOoaTgCXehz6J3K49yNukyNGBEacHI1tyhaRGL3vr0UKN
 S9K3ZmiWzIXh+ac7pN+aWPF41dQNK2c/u1jGo7uY06swp3BqtLYP4BjSXwmW4wEBvSooZFfeiYt
 ILQk2yAd3jhVYXUEbaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280191
X-Rspamd-Queue-Id: 5E51548B365
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-35512-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hu-mojha-hyd.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, Apr 27, 2026 at 03:25:59PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Along with that pass proper PAS ID to set_remote_state API. As per testing
> the SCM backend just ignores it while OP-TEE makes use of it to for proper
> book keeping purpose.

When we use 'Along with' or 'while at it', patch is doing two things and
not one.

> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig      | 25 ++++++++++---------
>  .../media/platform/qcom/iris/iris_firmware.c  |  9 ++++---
>  drivers/media/platform/qcom/venus/Kconfig     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c  | 11 ++++----
>  4 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> index 3c803a05305a..f54b759c18aa 100644
> --- a/drivers/media/platform/qcom/iris/Kconfig
> +++ b/drivers/media/platform/qcom/iris/Kconfig
> @@ -1,13 +1,14 @@
>  config VIDEO_QCOM_IRIS
> -        tristate "Qualcomm iris V4L2 decoder driver"
> -        depends on VIDEO_DEV
> -        depends on ARCH_QCOM || COMPILE_TEST
> -        select V4L2_MEM2MEM_DEV
> -        select QCOM_MDT_LOADER if ARCH_QCOM
> -        select QCOM_SCM
> -        select VIDEOBUF2_DMA_CONTIG
> -        help
> -          This is a V4L2 driver for Qualcomm iris video accelerator
> -          hardware. It accelerates decoding operations on various
> -          Qualcomm SoCs.
> -          To compile this driver as a module choose m here.
> +	tristate "Qualcomm iris V4L2 decoder driver"
> +	depends on VIDEO_DEV
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select V4L2_MEM2MEM_DEV
> +	select QCOM_MDT_LOADER if ARCH_QCOM
> +	select QCOM_SCM
> +	select QCOM_PAS
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	  This is a V4L2 driver for Qualcomm iris video accelerator
> +	  hardware. It accelerates decoding operations on various
> +	  Qualcomm SoCs.
> +	  To compile this driver as a module choose m here.

Here, Space replaced by Tabs just for one line.., should be fine.


> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 5f408024e967..856fa6a79064 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/of_address.h>
>  #include <linux/of_reserved_mem.h>
> @@ -79,7 +80,7 @@ int iris_fw_load(struct iris_core *core)
>  		return -ENOMEM;
>  	}
>  
> -	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
> +	ret = qcom_pas_auth_and_reset(core->iris_platform_data->pas_id);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;
> @@ -93,7 +94,7 @@ int iris_fw_load(struct iris_core *core)
>  						     cp_config->cp_nonpixel_size);
>  		if (ret) {
>  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret);
> -			qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +			qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  			return ret;
>  		}
>  	}
> @@ -103,10 +104,10 @@ int iris_fw_load(struct iris_core *core)
>  
>  int iris_fw_unload(struct iris_core *core)
>  {
> -	return qcom_scm_pas_shutdown(core->iris_platform_data->pas_id);
> +	return qcom_pas_shutdown(core->iris_platform_data->pas_id);
>  }
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_scm_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, core->irisi_platform_data->pas_id);


Should be a separate change for qcom_pas_set_remote_state()

>  }
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index ffb731ecd48c..574172724e8f 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -6,6 +6,7 @@ config VIDEO_QCOM_VENUS
>  	select OF_DYNAMIC if ARCH_QCOM
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select QCOM_SCM
> +	select QCOM_PAS
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV
>  	help
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 1de7436713ed..3c0727ea137d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_device.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -58,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_scm_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);

This too..

>  		if (resume && ret == -EINVAL)
>  			ret = 0;
>  		return ret;
> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>  		return -EPROBE_DEFER;
>  
>  	ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys = mem_phys;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
>  	else
>  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>  
> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>  						     res->cp_nonpixel_start,
>  						     res->cp_nonpixel_size);
>  		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);
>  			dev_err(dev, "set virtual address ranges fail (%d)\n",
>  				ret);
>  			return ret;
> @@ -274,7 +275,7 @@ int venus_shutdown(struct venus_core *core)
>  	int ret;
>  
>  	if (core->use_tz)
> -		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +		ret = qcom_pas_shutdown(VENUS_PAS_ID);
>  	else
>  		ret = venus_shutdown_no_tz(core);
>  
> -- 
> 2.51.0

with above change

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> 

-- 
-Mukesh Ojha

