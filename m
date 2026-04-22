Return-Path: <linux-wireless+bounces-35233-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK3+Gcop6Wn9VAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35233-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 22:04:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D245C44A755
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 22:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0FB302295A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850E13F2117;
	Wed, 22 Apr 2026 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtLDY9uF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgovRglL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE0E3F0AA0
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888259; cv=none; b=ineW2VjPHqYFUij4Xxk7e+oJ/l4Qv0RrZdrRRBMxWylnP3qvm4Ae4QT5xx1lIsBx9GFHUqs4EBqEn3sB09GecOkzb5V1DiUjo9kFn2FSlQEnVG6FAUXBns7BB+0Gf+mOd7AKFyYz2VklTLs1t2xYvFcRrnD0s6AWSCiVNhH7d6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888259; c=relaxed/simple;
	bh=Vw5lbIz93bfPivnPlgZTf922sy3wFpATm4HMbXkasxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuTkCx84IalYZQi5fLTTiYJbhzhN8vVCfLJ7VhKIMKlzxMfZflINGO7t/V4lYcuIHjo0dPNX8ftzQZVxp2hoNeQdKFG87uwHyqnGz141MswDufNZY4MUqTkdObuAgyGqPPY0R1BRvqxss6ttmvy2EVfY6kLtKnuJ3t9FaTXgTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtLDY9uF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IgovRglL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGqYre1218418
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TWNv/n77xtlQNACjJ3+8jJLY
	WYV7KxtU3j5KJIFZm9w=; b=YtLDY9uF5xOkCoR8E3Hapt6dWg8lw9y4CViURo4X
	3sj1xGiBYjfiOlGRP6eA/ix80qQtgSD5BDXQ3OUdZi2TY8vDwvtnHONVZG5N4Mtp
	Evjab88v4Ddg4qOo+pRr/xWx9Ns8qPgqG9+E9Y5FUY1c+m9NyDi490VZ+5rT9V3X
	rNy5DzOcpX3JpNZdLuhslsk3tCP+DLqiJIYsqlrsEn3PjEuWX87GqgAERsSGEPLs
	4Q9NPD4F4ixz33UAUspYkKvlTw16b6m5PgJ3Hig/XunesxrltP8r2sSMMsafu2is
	qNEkRl9ZPlkFePAbtM2xVw8xZtpC76DJp4eX5vb3NdhhPA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282rp1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 20:04:17 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-620f5085c37so42939137.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776888256; x=1777493056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
        b=IgovRglLjqALlavWRYhryS09AZfjTpUyQgJZvl5VWXz3kRma5ipHqIJlski6CIlXtu
         4lCkRaR9TqzZxGL9HQaTCtf+5AZsN8okA4UlztxlaRh6pmY9DbJGLPq7gmKzPSoNyo5V
         qPsROGu4eN6JFKo9Qndiw2Zbf2YnrUlLQPCC8gNJpO9E54KFvVKe8VY7O4AZbP0WcaEm
         SHBol4kMEsW2iKDBlIiwnmzUAKb2rzp49f1Y/RL8NJ+UA8/4mY+ErZ7WyizGV0U37hJ3
         eCocGU1RM3QOuh7wHHnNaLDuv43OSkf+j2Tf2elJRQjWPJgo6DjsjHM8DK3o0zwRsrLv
         In2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776888256; x=1777493056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
        b=LFr9NBouPAIGTz8+ZhbXci+lvttrwnIbDmDN1lc4Uapt+qq4OByFXNtjaWs5AQoTKB
         v6CYeysuEuqZ36bFkWDTXSecuLu7E5PmpcEK23iMD2krfKIeiTlPhTapE4dauD+Rj3cN
         d+vPMrPYpQOZzY2M05wfb8mz6rDHAT9OwuSGh8yvv69eR6VLGe+ufXrjOIFmpqwp4wyM
         5o8hUfXOrEE6BSTr4K4LMwpRv0phJVA1x/45Y5KLHfAgl0EnsBSwCKDDkAPbvKCvBspb
         hTVskqRcaN4VF9QEPc7sva3tT5F8OLGVpa2pXK10t+YWSWrgBN0tF57NJlFUk9FoHrB7
         c5tA==
X-Forwarded-Encrypted: i=1; AFNElJ9Y1foR/e5DnRdjIAVuwoXwnLH9RqZtBu44gaHXlAbbxZQItyIp29Ry8XsCWJU3e/qWByUHYHxMmryLv3SILw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqIEwAZFKLZC/+t+PPgRQfrgZlQWBeCd1ktA1sD9pvrRHeliD
	P9I/x8zlIUt0GvrHYj1eSGg2x33x0h2JbDf6UEo0/HYwuVK++Wxjb4D+YUJ1r//R5lP5kSYnACb
	u5qhG5pqYNaTauCeOuWqSERrBrvgNpKcWvemcYzD+Xb7bxDIBfnxrVyPrYWL8M7LEIATIRA==
X-Gm-Gg: AeBDieuxLaj5Kz0u2azO1MsNCtTKKf+iv0B5GmGx3GavNd5Bfxmw6mipHq0j4zDfagw
	vyVbjicuX/ouFOKSk0BJbKUgRcN1qlFMtw3+IH0MqlokPO9CzEFS8j8yd9hO3uw61pG7fQ4CmFR
	qBAwK8CppxPEzUW1vrn7Ye7/M3Bhmc7v2iKvJ2e+/jUnRgCBU6143QZAnR0OESld6SAglOqLMpm
	iBVoFMXOER4Y0M8s10esKMs2FSDss0tB3ORVpNkGTlRuj8sBlmxOJxIam2+Yk8p5HHy6YtnK4bs
	dwUHY6BhRmHaoofmFv8HdB2bcrAhi380+WOvxsX1Ef7uGZQz/FYfSvdZNiMnVwFpnaVLqMaPoM/
	ru5jhGlAm+20U7uY5wkwlBy2PUZ7bgr/lu5xguZrWQHEs5WUzJn2Sxk1y/Lq3Vnqnmd6Dtp4Srk
	wcsBQ32z6qymvg93SfysgYYalsi5cl3hjqJsQOiFVq0tT8/Q==
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id ada2fe7eead31-616f73fb077mr11984443137.24.1776888256341;
        Wed, 22 Apr 2026 13:04:16 -0700 (PDT)
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id ada2fe7eead31-616f73fb077mr11984380137.24.1776888255894;
        Wed, 22 Apr 2026 13:04:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc25csm4689196e87.26.2026.04.22.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:04:14 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:04:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: lumag@kernel.org, robin.clark@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, sean@poorly.run, akhilpo@oss.qualcomm.com,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
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
        skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <fuypqlwseulyvlsgiq3dnh3kwhernjid2yqljiwmrxufzfuukq@mfy343uq5gs3>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-11-sumit.garg@kernel.org>
 <aeduRrAMOAW4f5TU@sumit-xelite>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeduRrAMOAW4f5TU@sumit-xelite>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5NCBTYWx0ZWRfX8wG9J+l+9RiU
 lyJLK3IBgeAmpLHu9k+4or55GI785W+3xMuN/huciUeu6ydgdwY/eb0x3QTYQWa7zyo30fy0QRi
 YSM7He9quJb3rnxgSwc7rIBrtX6KDlYEEw3WmvHaQ1SNd5hoBeVR0LuQf56KRStxUGY+jH2qcid
 sYhWTYrzyy+rmhDupMbROjwrWQR7ym2ckgHbK9FFZEsEKYGCic4OHtKJlnkSE3Re6D4sHRquxaY
 YCI/Ts1Mug8V56nOmzuTfCzwU+ueW/FThmO5rbBH/leemmnlU6Z6V2RswIiVCM3+HZOEL3VXRaY
 OG6rCfCdDa0jPUy6OmJTWpxTcleKPE2nRYnlQ+ZpNBfzLvsQApQPT8vdUdE8Ygh04K9QZ/Fo5gy
 LDFBdt6+xgH45FjB5XvgewQoqrLLOdHruI5jXI0nTDWyQO4U1ESNbDWBX7BMC97u8oA/HWu7yGF
 HsCWhjxd5fBAXFfyc2A==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e929c1 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=dgZ2eqGgcVFd7X0fNysA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: Kk5wZclHx8YTy3NCfBaRg_9TRg55tRyy
X-Proofpoint-ORIG-GUID: Kk5wZclHx8YTy3NCfBaRg_9TRg55tRyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220194
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35233-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D245C44A755
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 06:02:06PM +0530, Sumit Garg wrote:
> Hey Rob, Dmitry,
> 
> On Fri, Mar 27, 2026 at 06:40:38PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> > 
> 
> Can I get an ack from you on this change? I expect this complete
> patch-set to land via Qcom SoC tree.
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

