Return-Path: <linux-wireless+bounces-35538-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMuSMZci8Wl8dwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35538-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 23:11:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4A48C3DF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 23:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D43301904C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB616132A;
	Tue, 28 Apr 2026 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJZxqSjU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hIwvh2Pj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34A359A81
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777410699; cv=none; b=BZyGwckeWv6IbBN/0LaeyqKggD1xAs4QrUi0W26MJh/+Wg1cdp3VVsHcRWsqahspOPiph7Rmr4pcoxR6eEpyPRlVZ7E3O0nlyQtOqEEZFyNIi/ZHoO8pNXYZTrdPHfunKoYujlhfOgf9O4QwQXohU0UgX0jXOgGPNWq86sMLBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777410699; c=relaxed/simple;
	bh=aYhhcOclawmX7KzT0CX9wy+UrSFWu5e2RxW/+w/K8Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPE+8Ee8EOj9pSSKMIsP3aqTlgzao32p6DiZcu6k6uoq65tu5rNVAirrpx0MzXC3Qd8US5pOZUMJIrgzapcdcRPiUINVkoC43+utmZsS7nyC4ScRP6KVKN5vrGDlNAYNOggopurw1gHhFZncwO8z2wJY7gfRjWYm/X/VAlzoZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJZxqSjU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hIwvh2Pj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SHZuwE017610
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 21:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uQWMWxZE9s4RXdihXMUKwpnL
	HXgPoeU7U4KZbQGpN+w=; b=HJZxqSjUiKOm8VEsWVv0L4s6g45tqjhJYyLpVtF8
	omdhBR6tsjZu6wQyb3hzaSA5u+3labYE0XmHzj7LEofDozZeb3hSR1K31/AermaS
	Ro+/wODH+2GcrJiy8u5mkDvYwxwjcJE/7iDalih8PdAnmfiQ3Tfav3yzd/RkQrot
	N5A74q7N5hBbXsagogz0n/i2osKqn0yV+K2ibCCAcrZy87vAiUEnHFrLRy6TXHKK
	roz/hkksFuCS+CxRhvBeEnqdO1O5IUlyaJ9LeoTe3EinD2RrlDw0BfgbwW9NTqeR
	kryGS2YldzrE5rqmyhiY7SQn9Wu8tbmdvLw4BjbzjVmZuA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du1ee8pcj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 21:11:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-362eaa3aa61so6200301a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777410696; x=1778015496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQWMWxZE9s4RXdihXMUKwpnLHXgPoeU7U4KZbQGpN+w=;
        b=hIwvh2PjpJLHiCHy5mMRZOme5hyaE3jVKpLk1xKhqFnA26weHSrwZDETninGRAMiKf
         mp7Ia5p5+4mDGYrOSLnf5xHM1zWJJHW6JV59+rkdceg1tdRNYf//DqdyH6ldOcdUDgyr
         j8aH6kHtM8m0mL0FRtOWhHqtAaHVZDI77oqmFGy2keANCZDFkbcuQREVbZ0FwVbpnHqz
         01ZahGQQijxvM+nto/3pAAMsxq9cOH/pH87ju4xH2XHrDSX1YTlcMY2NLcsownDsKmMA
         kBeHt6XqxvX4GspE3kEYs5Pa8woQNGSkafbkoTMOZSp7QzlB5tpN/HSn1POjPW4sezf/
         A0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777410696; x=1778015496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQWMWxZE9s4RXdihXMUKwpnLHXgPoeU7U4KZbQGpN+w=;
        b=QdbdG/Z7ZjXHDzD22Mq0Y8qg/ZMqmm8V5DPDFcBSGf4VlXSp3KDSDqZDfjFNdDU1u0
         kbos5ZsyM63sQeMm4bp35oM1tiBprq7XKSpeSYkvXFALys1TK0wPwQShhw40ML3nmx4x
         MwEKZGHVc8TQX+pSrlMzlegtstMuFStcVzJaslFXnSyS1JgpE7XMm3XbdAiY65FwpJvi
         WaqaKUzLd3d/WkHy2dNxO861pOedrMdfX5vtHrVhNAKbc8MnIMOmM0ds2XwvSGu9AHQY
         p2ggjhrRWmz9Ec2qzmtVhvCB7WCZ34OvaRyZqloY2aATNma8Q7GBGs/NTAtyILIq6iWp
         tdTw==
X-Forwarded-Encrypted: i=1; AFNElJ9iMk8/7lnantsTeM2a86lDZmddFPedTZPtpF3IEpBqfkNLCY/6rP5MWBDcFWYZtnOuPrK2mdnzYaRMOdfwWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfOcmxGqwSZeaomGEatIQ4kz7S/V0vPmxcQFngoO44qIuzrJq
	9p9Fa51PmOqR7FYMZpsEjdC69KaDwT7s+wZqqDhGFY4jJprRxY6MS7ysUOmXmUZyGVLcyznjtXD
	9hByEUG68bUk3SE7x540P62wETEnDqI/OpXqc/dtlV7sEJTkw81VdkzRyi629d5XdEApJ4w==
X-Gm-Gg: AeBDiesa1yCZpceD91zPBIeHtWH+ZOypuvAQsejoqBp0TnNu0WmEw8fkZvdcmbCPi9q
	w/09Kse5eqS7uwfc+dp8hwqsJ8MYV2Z9kRHV+9KlwyCc0ERRZ+ayQWygNpoN1iICHXGgQq/h/pH
	CJihFmUEmI81K1Fvw7cNM/A1Y7kjooE4wNH9PX+MbCKE6raDNX18wV7n7guc5H5AuLoLoP4ebKb
	bv1iL7BaQGNeH+r5xvDsrFw5SdKPdwjS7Rx+cjtpxHISv7469WQU+gjBsHXeor/+0nTb7stPOnb
	g5hQabTMwpwxob/iXcE4PxuxR+t7yckPXK7F0gca/CfYSQUtzLVw7+jXUaiPby8xFnPCS/W9+5U
	WpkFl7+jw9unRhzuc4SYEcrpNksebTF/+LoTgJ/1YreQhB91K2UXkGyi2K0I=
X-Received: by 2002:a17:90a:d2cf:b0:35e:d012:5a39 with SMTP id 98e67ed59e1d1-364a0d2ca44mr884065a91.14.1777410695772;
        Tue, 28 Apr 2026 14:11:35 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:35e:d012:5a39 with SMTP id 98e67ed59e1d1-364a0d2ca44mr884009a91.14.1777410694957;
        Tue, 28 Apr 2026 14:11:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0cf4940sm171118a91.0.2026.04.28.14.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 14:11:34 -0700 (PDT)
Date: Wed, 29 Apr 2026 02:41:19 +0530
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
Subject: Re: [PATCH v4 02/15] firmware: qcom: Add a generic PAS service
Message-ID: <20260428211119.megzlvaw23uw3gnn@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-3-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-3-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=C/7ZDwP+ c=1 sm=1 tr=0 ts=69f12289 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=B9m6UvTZno2CEb395rQA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIwNiBTYWx0ZWRfX5zgunfs0pG7/
 xZaBLtMZBk2XgzX5qwVMpy6z3WrM5LZpsgD50PRYMIgGH6Ja34HZH4lR0f48CSE7rNAnibs2L5P
 By3WX4+EWa8Yh/Itc9hZYNpHvUVyOWwXKadRHlQDcyJwTIrd7aLhPmcdNlxc+Px6ZI3qeYyH53f
 SomgSXn8DmFgBvcvKfdncnpSoF0JVK/0cEE4gjMdXZ5rDAPbCrXOwRqzUlLO3ToE12ic7KaohY1
 L3VzRPK8R/iEP4Gtewpel4TJjQEjZHyMJoeNBU6QKqS+VheAyvWRZOWqmpF4Z/lgkF5TBoL82dd
 mEuGAMfBnq+uZ9kXMfLvISm3yGyHhPropyc5iQh5nyHhHgmxMRhNxmWdeVbJUWDyvkoc4MXptkc
 zKWDf3ty8lDI7mHV2dPdZObtIUZyWkJ34/G0OmHXKqo+aE0QNZQi5R8Gj60/cQC7PpuhS25CSGD
 aLFbUc7NqK3q2XdKZ0A==
X-Proofpoint-GUID: YupobpJGlPWSZSGCyfviXyNM2mJ3IYtv
X-Proofpoint-ORIG-GUID: YupobpJGlPWSZSGCyfviXyNM2mJ3IYtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280206
X-Rspamd-Queue-Id: 59B4A48C3DF
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
	TAGGED_FROM(0.00)[bounces-35538-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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

On Mon, Apr 27, 2026 at 03:25:50PM +0530, Sumit Garg wrote:
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
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/Kconfig          |   8 +
>  drivers/firmware/qcom/Makefile         |   1 +
>  drivers/firmware/qcom/qcom_pas.c       | 288 +++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_pas.h       |  50 +++++
>  include/linux/firmware/qcom/qcom_pas.h |  43 ++++
>  5 files changed, 390 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b477d54b495a..8653639d06db 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -6,6 +6,14 @@
>  
>  menu "Qualcomm firmware drivers"
>  
> +config QCOM_PAS
> +	tristate
> +	help
> +	  Enable the generic Peripheral Authentication Service (PAS) provided
> +	  by the firmware. It acts as the common layer with different TZ
> +	  backends plugged in whether it's an SCM implementation or a proper
> +	  TEE bus based PAS service implementation.
> +
>  config QCOM_SCM
>  	select QCOM_TZMEM
>  	tristate
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index 0be40a1abc13..dc5ab45f906a 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
> new file mode 100644
> index 000000000000..caf7fff33e5c
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/device/devres.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "qcom_pas.h"
> +
> +static struct qcom_pas_ops *ops_ptr;
> +
> +/**
> + * devm_qcom_pas_context_alloc() - Allocate peripheral authentication service
> + *				   context for a given peripheral
> + *
> + * PAS context is device-resource managed, so the caller does not need
> + * to worry about freeing the context memory.
> + *
> + * @dev:	  PAS firmware device
> + * @pas_id:	  peripheral authentication service id
> + * @mem_phys:	  Subsystem reserve memory start address
> + * @mem_size:	  Subsystem reserve memory size
> + *
> + * Return: The new PAS context, or ERR_PTR() on failure.
> + */
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size)
> +{
> +	struct qcom_pas_context *ctx;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctx->dev = dev;
> +	ctx->pas_id = pas_id;
> +	ctx->mem_phys = mem_phys;
> +	ctx->mem_size = mem_size;
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(devm_qcom_pas_context_alloc);
> +
> +/**
> + * qcom_pas_init_image() - Initialize peripheral authentication service state
> + *			   machine for a given peripheral, using the metadata
> + * @pas_id:	peripheral authentication service id
> + * @metadata:	pointer to memory containing ELF header, program header table
> + *		and optional blob of data used for authenticating the metadata
> + *		and the rest of the firmware
> + * @size:	size of the metadata
> + * @ctx:	optional pas context
> + *
> + * Return: 0 on success.
> + *
> + * Upon successful return, the PAS metadata context (@ctx) will be used to
> + * track the metadata allocation, this needs to be released by invoking
> + * qcom_pas_metadata_release() by the caller.
> + */
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->init_image(ops_ptr->dev, pas_id, metadata, size, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_init_image);
> +
> +/**
> + * qcom_pas_metadata_release() - release metadata context
> + * @ctx:	pas context
> + */
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx)
> +{
> +	if (!ctx || !ctx->ptr || !ops_ptr)

reverse order..

> +		return;
> +
> +	ops_ptr->metadata_release(ops_ptr->dev, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_metadata_release);
> +
> +/**
> + * qcom_pas_mem_setup() - Prepare the memory related to a given peripheral
> + *			  for firmware loading
> + * @pas_id:	peripheral authentication service id
> + * @addr:	start address of memory area to prepare
> + * @size:	size of the memory area to prepare
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_mem_setup);
> +
> +/**
> + * qcom_pas_get_rsc_table() - Retrieve the resource table in passed output buffer
> + *			      for a given peripheral.
> + *
> + * Qualcomm remote processor may rely on both static and dynamic resources for
> + * its functionality. Static resources typically refer to memory-mapped
> + * addresses required by the subsystem and are often embedded within the
> + * firmware binary and dynamic resources, such as shared memory in DDR etc.,
> + * are determined at runtime during the boot process.
> + *
> + * On Qualcomm Technologies devices, it's possible that static resources are
> + * not embedded in the firmware binary and instead are provided by TrustZone.
> + * However, dynamic resources are always expected to come from TrustZone. This
> + * indicates that for Qualcomm devices, all resources (static and dynamic) will
> + * be provided by TrustZone PAS service.
> + *
> + * If the remote processor firmware binary does contain static resources, they
> + * should be passed in input_rt. These will be forwarded to TrustZone for
> + * authentication. TrustZone will then append the dynamic resources and return
> + * the complete resource table in output_rt_tzm.
> + *
> + * If the remote processor firmware binary does not include a resource table,
> + * the caller of this function should set input_rt as NULL and input_rt_size
> + * as zero respectively.
> + *
> + * More about documentation on resource table data structures can be found in
> + * include/linux/remoteproc.h
> + *
> + * @ctx:	    PAS context
> + * @pas_id:	    peripheral authentication service id
> + * @input_rt:       resource table buffer which is present in firmware binary
> + * @input_rt_size:  size of the resource table present in firmware binary
> + * @output_rt_size: TrustZone expects caller should pass worst case size for
> + *		    the output_rt_tzm.
> + *
> + * Return:
> + *  On success, returns a pointer to the allocated buffer containing the final
> + *  resource table and output_rt_size will have actual resource table size from
> + *  TrustZone. The caller is responsible for freeing the buffer. On failure,
> + *  returns ERR_PTR(-errno).
> + */
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt,
> +					      size_t input_rt_size,
> +					      size_t *output_rt_size)
> +{
> +	if (!ctx)
> +		return ERR_PTR(-EINVAL);
> +	if (!ops_ptr)
> +		return ERR_PTR(-ENODEV);

same as below

> +
> +	return ops_ptr->get_rsc_table(ops_ptr->dev, ctx, input_rt,
> +				      input_rt_size, output_rt_size);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_get_rsc_table);
> +
> +/**
> + * qcom_pas_auth_and_reset() - Authenticate the given peripheral firmware
> + *			       and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
> +
> +/**
> + * qcom_pas_prepare_and_auth_reset() - Prepare, authenticate, and reset the
> + *				       remote processor
> + *
> + * @ctx:	Context saved during call to qcom_scm_pas_context_init()
> + *
> + * This function performs the necessary steps to prepare a PAS subsystem,
> + * authenticate it using the provided metadata, and initiate a reset sequence.
> + *
> + * It should be used when Linux is in control setting up the IOMMU hardware
> + * for remote subsystem during secure firmware loading processes. The
> + * preparation step sets up a shmbridge over the firmware memory before
> + * TrustZone accesses the firmware memory region for authentication. The
> + * authentication step verifies the integrity and authenticity of the firmware
> + * or configuration using secure metadata. Finally, the reset step ensures the
> + * subsystem starts in a clean and sane state.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx)
> +{
> +	if (!ctx)
> +		return -EINVAL;
> +	if (!ops_ptr)
> +		return -ENODEV;

They should be checked in reverse order, no point in checking ctx if
ops_ptr is NULL ., 

> +
> +	return ops_ptr->prepare_and_auth_reset(ops_ptr->dev, ctx);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_prepare_and_auth_reset);
> +
> +/**
> + * qcom_pas_set_remote_state() - Set the remote processor state
> + * @state:	peripheral state
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->set_remote_state(ops_ptr->dev, state, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_set_remote_state);
> +
> +/**
> + * qcom_pas_shutdown() - Shut down the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: 0 on success.
> + */
> +int qcom_pas_shutdown(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return -ENODEV;
> +
> +	return ops_ptr->shutdown(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_shutdown);
> +
> +/**
> + * qcom_pas_supported() - Check if the peripheral authentication service is
> + *			  available for the given peripheral
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return: true if PAS is supported for this peripheral, otherwise false.
> + */
> +bool qcom_pas_supported(u32 pas_id)
> +{
> +	if (!ops_ptr)
> +		return false;
> +
> +	return ops_ptr->supported(ops_ptr->dev, pas_id);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_supported);
> +
> +bool qcom_pas_is_available(void)
> +{
> +	/*
> +	 * The barrier for ops_ptr is intended to synchronize the data stores
> +	 * for the ops data structure when client drivers are in parallel
> +	 * checking for PAS service availability.
> +	 *
> +	 * Once the PAS backend becomes available, it is allowed for multiple
> +	 * threads to enter TZ for parallel bringup of co-processors during
> +	 * boot.
> +	 */
> +	return !!smp_load_acquire(&ops_ptr);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_is_available);
> +
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops)
> +{
> +	if (!qcom_pas_is_available())
> +		/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +		smp_store_release(&ops_ptr, ops);
> +	else
> +		pr_err("qcom_pas: ops already registered\n");

pr_err("qcom_pas: ops already registered by %s\n", ops_ptr->drv_name);

> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_register);
> +
> +void qcom_pas_ops_unregister(void)
> +{
> +	/* Paired with smp_load_acquire() in qcom_pas_is_available() */
> +	smp_store_release(&ops_ptr, NULL);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_ops_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm common TZ PAS driver");

                                generic ??

> diff --git a/drivers/firmware/qcom/qcom_pas.h b/drivers/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..8643e2760602
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QCOM_PAS_INT_H
> +#define __QCOM_PAS_INT_H
> +
> +struct device;
> +
> +/**
> + * struct qcom_pas_ops - Qcom Peripheral Authentication Service (PAS) ops
> + * @drv_name:			PAS driver name.
> + * @dev:			PAS device pointer.
> + * @supported:			Peripheral supported callback.
> + * @init_image:			Peripheral image initialization callback.
> + * @mem_setup:			Peripheral memory setup callback.
> + * @get_rsc_table:		Peripheral get resource table callback.
> + * @prepare_and_auth_reset:	Peripheral prepare firmware authentication and
> + *				reset callback.
> + * @auth_and_reset:		Peripheral firmware authentication and reset
> + *				callback.
> + * @set_remote_state:		Peripheral set remote state callback.
> + * @shutdown:			Peripheral shutdown callback.
> + * @metadata_release:		Image metadata release callback.
> + */
> +struct qcom_pas_ops {
> +	const char *drv_name;
> +	struct device *dev;
> +	bool (*supported)(struct device *dev, u32 pas_id);
> +	int (*init_image)(struct device *dev, u32 pas_id, const void *metadata,
> +			  size_t size, struct qcom_pas_context *ctx);
> +	int (*mem_setup)(struct device *dev, u32 pas_id, phys_addr_t addr,
> +			 phys_addr_t size);
> +	void *(*get_rsc_table)(struct device *dev, struct qcom_pas_context *ctx,
> +			       void *input_rt, size_t input_rt_size,
> +			       size_t *output_rt_size);
> +	int (*prepare_and_auth_reset)(struct device *dev,
> +				      struct qcom_pas_context *ctx);
> +	int (*auth_and_reset)(struct device *dev, u32 pas_id);
> +	int (*set_remote_state)(struct device *dev, u32 state, u32 pas_id);
> +	int (*shutdown)(struct device *dev, u32 pas_id);
> +	void (*metadata_release)(struct device *dev,
> +				 struct qcom_pas_context *ctx);
> +};
> +
> +void qcom_pas_ops_register(struct qcom_pas_ops *ops);
> +void qcom_pas_ops_unregister(void);
> +
> +#endif /* __QCOM_PAS_INT_H */
> diff --git a/include/linux/firmware/qcom/qcom_pas.h b/include/linux/firmware/qcom/qcom_pas.h
> new file mode 100644
> index 000000000000..65b1c9564458
> --- /dev/null
> +++ b/include/linux/firmware/qcom/qcom_pas.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2015 Linaro Ltd.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */

Here, you kept the copyright but not in the C file.., from my view, both qcom_pas.c
and qcom_pas.h are derivative work(>50%) and should carry the original license while
drivers/firmware/qcom/qcom_pas.h is new work...

> +
> +#ifndef __QCOM_PAS_H
> +#define __QCOM_PAS_H
> +
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +struct qcom_pas_context {
> +	struct device *dev;
> +	u32 pas_id;
> +	phys_addr_t mem_phys;
> +	size_t mem_size;
> +	void *ptr;
> +	dma_addr_t phys;
> +	ssize_t size;
> +	bool use_tzmem;
> +};
> +
> +bool qcom_pas_is_available(void);
> +struct qcom_pas_context *devm_qcom_pas_context_alloc(struct device *dev,
> +						     u32 pas_id,
> +						     phys_addr_t mem_phys,
> +						     size_t mem_size);
> +int qcom_pas_init_image(u32 pas_id, const void *metadata, size_t size,
> +			struct qcom_pas_context *ctx);
> +struct resource_table *qcom_pas_get_rsc_table(struct qcom_pas_context *ctx,
> +					      void *input_rt, size_t input_rt_size,
> +					      size_t *output_rt_size);
> +int qcom_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
> +int qcom_pas_auth_and_reset(u32 pas_id);
> +int qcom_pas_prepare_and_auth_reset(struct qcom_pas_context *ctx);
> +int qcom_pas_set_remote_state(u32 state, u32 pas_id);
> +int qcom_pas_shutdown(u32 pas_id);
> +bool qcom_pas_supported(u32 pas_id);
> +void qcom_pas_metadata_release(struct qcom_pas_context *ctx);
> +
> +#endif /* __QCOM_PAS_H */
> -- 
> 2.51.0
> 

With above change, 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha

