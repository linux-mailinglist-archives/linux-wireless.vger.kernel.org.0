Return-Path: <linux-wireless+bounces-33204-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BgLLR3ws2nYdgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33204-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 12:08:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5344B281EA3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 12:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59AAA301DED2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D47136B061;
	Fri, 13 Mar 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o196izQj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ELywOpK/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76D33F385
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773400089; cv=none; b=OVO5FDAvM2OW+JNdGhB6eO8DKU3kqj8Jc4M+WXTHH0FrSe8xD6d2esRjCqyQk/hHTeP+K6nC3kOp5glBGk+Ckkm7Ce7tUrWxJERKEG7Fg56vQCl3MJzOWYMBT+1MBfsx/jVP9mvIU3Yt1i3oQ43r6LclnNhe26VhJT8KhBlZbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773400089; c=relaxed/simple;
	bh=TtDq0o2Dw3lbYuPS78M79Zhh7F1pn7RAxdkECXLMRX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4crdQ4+ZoZ7roPitggY2cu8NXRaLBf7u3jdqWoSLkT9PhZa0R3/Lewg0NpwdyKxchfoYC+y07NwxXb9xtl2Ou0rLdtSzk7PnzlzweSWbQV0qomFkacQrF369VgkAVtxFJYJhoRt6b7Sbqi9z42XNbqH5iSt9DdGiRTmz83HC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o196izQj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ELywOpK/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7iU0t2262748
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 11:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e36oZbKohafb7XeQZtpNepWi
	ozZ4hMeiBqXvtRWVqgQ=; b=o196izQjMSB7dRp2utfm0eg9A1vgd91ajK0hoPWO
	VjxXAXmOlfZVFoH9jIVF+shxOEVm/0CliQp/pZgJQvU+iNi9YTIPONFXwViQ9i0c
	qteIlXu7jpDy1bYt/sddglAWa1MWur+paVXAKF9FsMiATqZjNRBytxG0CFB370SR
	9/mWKeVh0AHaaW2r3pXcZMHS64os7C2d6atYW6RXUc490RD8F+9bCmEdHKxK4oCv
	sKoe7I7uOapQgiQVqZCRCZdqMsVzRDowFQl45aGX2S6vY1qO9oW9/hg1Xukg5IsC
	sqyW/qYJ2+ZG3JkYimTObHSyBNRlYxRMRU3c3gBvM7Fpcw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4rq2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 11:08:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aed1beaa73so3674655ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 04:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773400086; x=1774004886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e36oZbKohafb7XeQZtpNepWiozZ4hMeiBqXvtRWVqgQ=;
        b=ELywOpK/r1aIOb2I2I8teY/bRIRg4xLFtnJd3NQk7kf5DIP/yr0msU+LD2hnXQ88lr
         1j9fbrf6J9u1fZL4M/aOy5/nSCjBbCW5k6PgzRkszGzpULY+E/iosO34PIMkrztxPJwY
         /IJ3UEcjQb9BHkYpUO82+9a0sSIA2q8wFqUZ1SZAM0LqNi2gOgIcrtOhtamRBB1VlbV7
         qh0PM9Q7nB6cuUJ7nL1bJvJYeTxaHM3g9TsxNJpQ21hadh+copAer9yw7sGm29VQ6++a
         tx+8zCzonjZh57RbZJbiwVjF74hzCvl1IApNfLMnPWa73PDDJjdEM5cLAR8llErV4plH
         6l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773400086; x=1774004886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e36oZbKohafb7XeQZtpNepWiozZ4hMeiBqXvtRWVqgQ=;
        b=R9QZ3A1n7RzB01uX3pBREdmvgdUJBaj4Xf70p+Z0PW0gsBESfTEoqhpiA28adpJImL
         1zd9lUOMEVirx9ntBH8utIwRwZ9/8zTgZVe+eM4rEur+RzVP+QSx3cjRSGvCh+q4iRde
         ZdY3qh70Of4p2b0XCMh/WwDopQ5qKbvPFHk2JQqpQ10pAkWJAP1FzmRhvwqtKpR8vSDK
         OcRg0ZXXqRrdUM3aKRgxbBH1uk28EJ8geOZBtXnlR5eJd3xmX1MB7ROEXiGDHBXKNK6p
         9mh0PwmWIKfiveUu4oQnQ4lUIXW1RXTgFEtdAqTe5mT89qrDZuibRDbD3YoFmsS6g9BO
         ayvw==
X-Forwarded-Encrypted: i=1; AJvYcCXJFULaUfahSYZKx6htVwBwV3hU14YIEamLYTsXHPGiE75ubYKoVbvHuVYO0m49nkUMyOnxVT0OGJq4dGGvJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/DD1HA+RVdDuKMKJYxAW1sDmxcWC7QR8PIQkD9rQJ0b1ZF81
	uDL2gOgM9wRu2gCkI5ecaNVAUqpl1vv1K2X3h7fJfuPVlyzLgIer4Z5z+XypY3LgExjTi8qyW30
	yOILr63ymXdYhfl9Q4B2+bRYiDqJRzfpF0dGQuZhLItmyN7D0u/92Xxod3R3rR5PdBZPk5w==
X-Gm-Gg: ATEYQzy8RA+ScJ7x4uSmusdHFIChL3TBlcMyrFefQ6gX9k6pNaKVxCFyoIi0SWV6MMS
	2MfkkHpM05lRl2gvL/PoOhboapF+6p69Ok8K0S2T0qDMS2Z2Fswt2dOp63w5NTZB/HHNgRgK4BA
	GA1D2bgWFWNBD+8aw/1D3Y1MRX/t84O1KiGmjxH3W4sKOt9mBYV9HFquJy+tt2TN2HOtJCwxn7k
	QKdwpY5gQ/elFS0fFpIehGsX6j/vraKKRNacVdqoCDo6XDyRBbwTp3fchu7ZQDvgRHnw43MMQqt
	d2VAU2wNuvHBYwAB9kkrAbwdWSWb0wKu5PRguuQy7A17b+VkjRsry133xeJkYN8LPKcjx/Jf9AI
	ozwlsJ3vtArz3jWKCbSLycdfP85Q8Q6ruw9bZy5k9ep2+s2iK
X-Received: by 2002:a17:902:ce11:b0:2ae:c34d:8c4e with SMTP id d9443c01a7336-2aecaa9e9c0mr28257405ad.38.1773400085351;
        Fri, 13 Mar 2026 04:08:05 -0700 (PDT)
X-Received: by 2002:a17:902:ce11:b0:2ae:c34d:8c4e with SMTP id d9443c01a7336-2aecaa9e9c0mr28256505ad.38.1773400084516;
        Fri, 13 Mar 2026 04:08:04 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c56csm25454045ad.7.2026.03.13.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:08:04 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:37:47 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
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
Subject: Re: [PATCH v2 04/15] firmware: qcom: Add a PAS TEE service
Message-ID: <20260313110747.v5bx2snpbtyja3ur@hu-mojha-hyd.qualcomm.com>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-5-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312062756.694390-5-sumit.garg@kernel.org>
X-Proofpoint-ORIG-GUID: -q9qh5FieYMXdJO-ehywd8iEOpjCFHj-
X-Proofpoint-GUID: -q9qh5FieYMXdJO-ehywd8iEOpjCFHj-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4NyBTYWx0ZWRfXx6Acdo8ABb1D
 dkrpIvMoUA/det9md36ceEE2oksZNPrMNw01ntOiVFRTxTmYjkPL/IJZncQQuWGzCL1rssT5gz8
 pRrmp8qUg1CKRXAJbQuSckVJUoTV0tFAARX2S6BCcEkz8ErZNgZmZ5uIfGXWXvtPQ6T/vrVht7d
 OyzD17ZfaV4XZOZ31HAI38K6CbOsJevCv/VBZvqMw7g+DRr6OZMfPSPx4z2ST2BZq3KDmAZPQSq
 cGSH8gwq6yxb6swWSZRLx/8MCw/pF+kci+o3/3GIVmLQhDYA6tqK/w5st2E+nMAYw8sDBZj/7Zt
 U3H/6H7h35PhPQhjBd/hrNbPApGnag9wSS/jDrGkk0nvqPYLsNAVtkNg56DVYAKJ3NyE1yYldZG
 DEMbAPCP6SfwPqCel05IeqRyhUrLsXulAV60V2QuPDLOnHhh9c6u0A5ZsUfRTs/iSfQLuSv4X9X
 eu5sZqxIFgqHUFzlBuQ==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b3f016 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JHwwdyD97BAlXG7hVn4A:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130087
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-33204-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qcom_pas_ops_tee.dev:url,hu-mojha-hyd.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5344B281EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:57:45AM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for Peripheral Authentication Service (PAS) driver based
> on TEE bus with OP-TEE providing the backend PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig        |   9 +
>  drivers/firmware/qcom/Makefile       |   1 +
>  drivers/firmware/qcom/qcom_pas_tee.c | 477 +++++++++++++++++++++++++++
>  3 files changed, 487 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 9a12ae2b639d..fff47abdaafd 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -14,6 +14,15 @@ config QCOM_PAS
>  	  backends plugged in whether it's an SCM implementation or a proper
>  	  TEE bus based PAS service implementation.
>  
> +config QCOM_PAS_TEE
> +	tristate
> +	select QCOM_PAS
> +	depends on TEE
> +	depends on !CPU_BIG_ENDIAN
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware TEE implementation as the backend.
> +
>  config QCOM_SCM
>  	select QCOM_PAS
>  	select QCOM_TZMEM
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index dc5ab45f906a..48801d18f37b 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>  obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> +obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> new file mode 100644
> index 000000000000..7db9fd736369
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas_tee.c
> @@ -0,0 +1,477 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +
> +#include "qcom_pas.h"
> +
> +/*
> + * Peripheral Authentication Service (PAS) supported.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define PTA_QCOM_PAS_IS_SUPPORTED		1
> +
> +/*
> + * PAS capabilities.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [out] params[1].value.a:	PAS capability flags
> + */
> +#define PTA_QCOM_PAS_CAPABILITIES		2
> +
> +/*
> + * PAS image initialization.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[1].memref:	Loadable firmware metadata
> + */
> +#define PTA_QCOM_PAS_INIT_IMAGE			3
> +
> +/*
> + * PAS memory setup.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Relocatable firmware size
> + * [in]  params[1].value.a:	32bit LSB relocatable firmware memory address
> + * [in]  params[1].value.b:	32bit MSB relocatable firmware memory address
> + */
> +#define PTA_QCOM_PAS_MEM_SETUP			4
> +
> +/*
> + * PAS get resource table.
> + *
> + * [in]     params[0].value.a:	Unique 32bit remote processor identifier
> + * [inout]  params[1].memref:	Resource table config
> + */
> +#define PTA_QCOM_PAS_GET_RESOURCE_TABLE		5
> +
> +/*
> + * PAS image authentication and co-processor reset.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Firmware size
> + * [in]  params[1].value.a:	32bit LSB firmware memory address
> + * [in]  params[1].value.b:	32bit MSB firmware memory address
> + * [in]  params[2].memref:	Optional fw memory space shared/lent
> + */
> +#define PTA_QCOM_PAS_AUTH_AND_RESET		6
> +
> +/*
> + * PAS co-processor set suspend/resume state.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + * [in]  params[0].value.b:	Co-processor state identifier
> + */
> +#define PTA_QCOM_PAS_SET_REMOTE_STATE		7
> +
> +/*
> + * PAS co-processor shutdown.
> + *
> + * [in]  params[0].value.a:	Unique 32bit remote processor identifier
> + */
> +#define PTA_QCOM_PAS_SHUTDOWN			8
> +
> +#define TEE_NUM_PARAMS				4
> +
> +/**
> + * struct qcom_pas_tee_private - PAS service private data
> + * @dev:		PAS service device.
> + * @ctx:		TEE context handler.
> + * @session_id:		PAS TA session identifier.
> + */
> +struct qcom_pas_tee_private {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	u32 session_id;
> +};
> +
> +static bool qcom_pas_tee_supported(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_IS_SUPPORTED,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS not supported, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int qcom_pas_tee_init_image(struct device *dev, u32 pas_id,
> +				   const void *metadata, size_t size,
> +				   struct qcom_pas_context *ctx)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_INIT_IMAGE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	struct tee_shm *mdata_shm;
> +	u8 *mdata_buf = NULL;
> +	int ret;
> +
> +	mdata_shm = tee_shm_alloc_kernel_buf(data->ctx, size);
> +	if (IS_ERR(mdata_shm)) {
> +		dev_err(dev, "mdata_shm allocation failed\n");
> +		return PTR_ERR(mdata_shm);
> +	}
> +
> +	mdata_buf = tee_shm_get_va(mdata_shm, 0);
> +	if (IS_ERR(mdata_buf)) {
> +		dev_err(dev, "mdata_buf get VA failed\n");
> +		tee_shm_free(mdata_shm);
> +		return PTR_ERR(mdata_buf);
> +	}
> +	memcpy(mdata_buf, metadata, size);
> +
> +	param[1].u.memref.shm = mdata_shm;
> +	param[1].u.memref.size = size;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS init image failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		tee_shm_free(mdata_shm);
> +		return -EINVAL;
> +	}
> +	ctx->ptr = (void *)mdata_shm;
> +
> +	return 0;
> +}
> +
> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> +				  phys_addr_t addr, phys_addr_t size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_MEM_SETUP,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(addr),
> +			.u.value.b = upper_32_bits(addr),
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +DEFINE_FREE(shm_free, struct tee_shm *, tee_shm_free(_T))
> +
> +static void *qcom_pas_tee_get_rsc_table(struct device *dev,
> +					struct qcom_pas_context *ctx,
> +					void *input_rt, size_t input_rt_size,
> +					size_t *output_rt_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_GET_RESOURCE_TABLE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = ctx->pas_id,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +			.u.memref.size = input_rt_size,
> +		}
> +	};
> +	void *rt_buf = NULL;
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);

What is the purpose of this function ? looks like, this is for, how
much Linux need to allocate for output buffer ?

> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> +			ctx->pas_id, inv_arg.ret);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (param[1].u.memref.size) {
> +		struct tee_shm *rt_shm __free(shm_free) =
> +			tee_shm_alloc_kernel_buf(data->ctx,
> +						 param[1].u.memref.size);
> +		void *rt_shm_va;
> +
> +		if (IS_ERR(rt_shm)) {
> +			dev_err(dev, "rt_shm allocation failed\n");
> +			return rt_shm;
> +		}
> +
> +		rt_shm_va = tee_shm_get_va(rt_shm, 0);
> +		if (IS_ERR_OR_NULL(rt_shm_va)) {
> +			dev_err(dev, "rt_shm get VA failed\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		memcpy(rt_shm_va, input_rt, input_rt_size);
> +
> +		param[1].u.memref.shm = rt_shm;

Here, you are passing only one buffer for both input and output ?

Like, you are allocating of buffer of size returned from qtee which I
assume includes both input + output rt size and copying the input_rt
and calling invoke and in return you will get combine table in return ?

> +		ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +		if (ret < 0 || inv_arg.ret != 0) {
> +			dev_err(dev, "PAS get RT failed, pas_id: %d, err: %x\n",
> +				ctx->pas_id, inv_arg.ret);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
> +		if (param[1].u.memref.size) {
> +			*output_rt_size = param[1].u.memref.size;
> +			rt_buf = kmalloc(param[1].u.memref.size, GFP_KERNEL);
> +			if (!rt_buf)
> +				return ERR_PTR(-ENOMEM);
> +
> +			memcpy(rt_buf, rt_shm_va, *output_rt_size);

rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);

https://lore.kernel.org/lkml/20260310140255.2520230-1-mukesh.ojha@oss.qualcomm.com/


> +		}
> +	}
> +
> +	return rt_buf;
> +}
> +
> +static int __qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id,
> +					 phys_addr_t mem_phys, size_t mem_size)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_AUTH_AND_RESET,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = mem_size,
> +		},
> +		[1] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = lower_32_bits(mem_phys),
> +			.u.value.b = upper_32_bits(mem_phys),
> +		},
> +		/* Reserved for fw memory space to be shared or lent */
> +		[2] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS auth reset failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pas_tee_auth_and_reset(struct device *dev, u32 pas_id)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, pas_id, 0, 0);
> +}
> +
> +static int qcom_pas_tee_prepare_and_auth_reset(struct device *dev,
> +					       struct qcom_pas_context *ctx)
> +{
> +	return __qcom_pas_tee_auth_and_reset(dev, ctx->pas_id, ctx->mem_phys,
> +					     ctx->mem_size);
> +}
> +
> +static int qcom_pas_tee_set_remote_state(struct device *dev, u32 state,
> +					 u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_SET_REMOTE_STATE,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id,
> +			.u.value.b = state,
> +		}
> +	};
> +	int ret;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pas_tee_shutdown(struct device *dev, u32 pas_id)
> +{
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +	struct tee_ioctl_invoke_arg inv_arg = {
> +		.func = PTA_QCOM_PAS_SHUTDOWN,
> +		.session = data->session_id,
> +		.num_params = TEE_NUM_PARAMS
> +	};
> +	struct tee_param param[4] = {
> +		[0] = {
> +			.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +			.u.value.a = pas_id
> +		}
> +	};
> +	int ret = 0;
> +
> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(dev, "PAS shutdown failed, pas_id: %d, err: %x\n",
> +			pas_id, inv_arg.ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_pas_tee_metadata_release(struct device *dev,
> +					  struct qcom_pas_context *ctx)
> +{
> +	struct tee_shm *mdata_shm = ctx->ptr;
> +
> +	tee_shm_free(mdata_shm);
> +}
> +
> +static struct qcom_pas_ops qcom_pas_ops_tee = {
> +	.drv_name		= "qcom-pas-tee",
> +	.supported		= qcom_pas_tee_supported,
> +	.init_image		= qcom_pas_tee_init_image,
> +	.mem_setup		= qcom_pas_tee_mem_setup,
> +	.get_rsc_table		= qcom_pas_tee_get_rsc_table,
> +	.auth_and_reset		= qcom_pas_tee_auth_and_reset,
> +	.prepare_and_auth_reset	= qcom_pas_tee_prepare_and_auth_reset,
> +	.set_remote_state	= qcom_pas_tee_set_remote_state,
> +	.shutdown		= qcom_pas_tee_shutdown,
> +	.metadata_release	= qcom_pas_tee_metadata_release,
> +};
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	return ver->impl_id == TEE_IMPL_ID_OPTEE;
> +}
> +
> +static int qcom_pas_tee_probe(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data;
> +	struct tee_ioctl_open_session_arg sess_arg = {
> +		.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL
> +	};
> +	int ret, err = -ENODEV;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
> +	if (IS_ERR(data->ctx))
> +		return -ENODEV;
> +
> +	export_uuid(sess_arg.uuid, &pas_dev->id.uuid);
> +	ret = tee_client_open_session(data->ctx, &sess_arg, NULL);
> +	if (ret < 0 || sess_arg.ret != 0) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		err = -EINVAL;
> +		goto out_ctx;
> +	}
> +
> +	data->session_id = sess_arg.session;
> +	dev_set_drvdata(dev, data);
> +	qcom_pas_ops_tee.dev = dev;
> +	qcom_pas_ops_register(&qcom_pas_ops_tee);
> +
> +	return 0;
> +out_ctx:
> +	tee_client_close_context(data->ctx);
> +
> +	return err;
> +}
> +
> +static void qcom_pas_tee_remove(struct tee_client_device *pas_dev)
> +{
> +	struct device *dev = &pas_dev->dev;
> +	struct qcom_pas_tee_private *data = dev_get_drvdata(dev);
> +
> +	qcom_pas_ops_unregister();
> +	tee_client_close_session(data->ctx, data->session_id);
> +	tee_client_close_context(data->ctx);
> +}
> +
> +static const struct tee_client_device_id qcom_pas_tee_id_table[] = {
> +	{UUID_INIT(0xcff7d191, 0x7ca0, 0x4784,
> +		   0xaf, 0x13, 0x48, 0x22, 0x3b, 0x9a, 0x4f, 0xbe)},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, qcom_pas_tee_id_table);
> +
> +static struct tee_client_driver optee_pas_tee_driver = {
> +	.probe		= qcom_pas_tee_probe,
> +	.remove		= qcom_pas_tee_remove,
> +	.id_table	= qcom_pas_tee_id_table,
> +	.driver		= {
> +		.name		= "qcom-pas-tee",
> +	},
> +};
> +
> +module_tee_client_driver(optee_pas_tee_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TEE bus based Qualcomm PAS driver");
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

