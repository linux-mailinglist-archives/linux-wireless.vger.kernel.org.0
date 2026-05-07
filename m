Return-Path: <linux-wireless+bounces-36097-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /1YtHTUG/WklWwAAu9opvQ
	(envelope-from <linux-wireless+bounces-36097-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:37:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0624EF62F
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6250F302F5A3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6E34028D;
	Thu,  7 May 2026 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TR2l94Ri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j9AI43kt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C1344DAC
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189812; cv=pass; b=oFdmV0ChnlFP3WLEN+fT0N2jBIfuacZUVuyAuzn0QjrXpiU3+hjv97T/tm69KEjGKt6zGm+fexqz7QSbti0yLQGk0vuavZPXHXhwyIBdeJfKoXFCjOOPNqG8lh/Irl3n2fujl+MKXGQwQVHxCMA3EWgXUzcCWfB9qrxxQ7zkQp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189812; c=relaxed/simple;
	bh=ArOdP62IsYNGRSjfc6Y0bJJzLkfin0ETeIhXBknaK3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0f76YilZGC1UDtupCsQWNx3VZ5rMaipzcFYo/1iiOIi6jv2LR/P3mkyVejuvOrORa0lJc7dPtTWFJvNLoJW0UdSR7U1F4Va1eulPA7bPE2keG/Iea1srG+O0YGy2LiMgkOB1FJdghqPBAYUE2W7DPSylSiOOlag2Rp2FGBpzMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TR2l94Ri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j9AI43kt; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647IBdJN2770992
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 21:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pYrXCeosSkUk/BLwqx35IEtBdm2IGkFdKvoUtb/X0CY=; b=TR2l94Ric/CR/TRJ
	WC7IHUExrLqcSuWSA/xaM/aQsW991jb6VINvGydGRXhnZaQE73Ut1QqSt9kvyEJV
	ackuxqz47FAgLu9vaDKmw4fUAZ2ACb6oMC6OTajJrBY6NDqwR1+YkyMCV9vp6XR9
	tZPsGkxnOZykh/yk0vJLIWtYjoDOU89f9tIzDbVbC+RFcycysPYmAOiTI2epriI9
	KX3Q9G+eL5jBJ3JAu5xl04LKwtGbjNqJirIIwrF8xHCU7zMO/wKV+b/P3h9GEMB9
	DPSdPYr0JAwrq7UMzBV4MZyI1MdoNmrwZOMZInTYF9CQ3ZtdIOTqykehbrY4FKTu
	9PHOjQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5gne9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 21:36:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8b597b14a22so45687246d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 14:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778189809; cv=none;
        d=google.com; s=arc-20240605;
        b=PganX2+2VFcXRyE0VmQ8eso19WLPG3wtnUSgXacYuEotniDeKkPaP7SVXbT4pM1zsX
         npxhu2vKv0uVgXJU2e4HfY8vecKrECnsenG58W6Z80i2Rr/vAkVvRe7MAmFPhDT7wPty
         bNYQw2wKWQf29rzWpmdu7McIa1MXvGfdFNxyEf8Vg/3YbfjUFB8zl7RHPe69fGYfv8ki
         QMv9SxpETkIxEIeB7702MhzBQybfHtbHh2pLm15k+5K6ufAcPAVRE8bE5lUrYAJIBur7
         ehli9mcMi9ROAUzvFnrP3WORZ2sKZbfg3z/gI5wNF1UnF4HTdM61/hTZHozn5KmONl4o
         lKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pYrXCeosSkUk/BLwqx35IEtBdm2IGkFdKvoUtb/X0CY=;
        fh=F4sp1AxOeCNICGzzU11oM9g08u8SaRnmkwqbsrgXuTU=;
        b=fnbk1Z1Rfqncv6OEcrRIBzCl89IgNDvHcAwQxCPR2m9QgVmesMzAGAGFczk7ZMWYXn
         pXDmU6RHrKKmoQWp4CXz+xMDPhgv78MuyFoliQGnG4iDIRruPXuvXkr097zb+LAaTftT
         4R8O/jbxTFJ+YMUU5Z1VGjwfGHbFrhlRVONfE/fIR4IbbzDE6ah/30fNqYUNImH7btkj
         uCK9L7hif76GXUCYuxQrzFEWf2re1x+5Kt3yc2U6jnUw8dBdhDRugYX0zL+pFA4EO5Rv
         Tx7St4ZE+ZqgeRxxG3ukHQiYfC/LKOqpRsa6t2f54nnZOzjnyGPeCPre66dC+eUT5DD0
         KZQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778189809; x=1778794609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYrXCeosSkUk/BLwqx35IEtBdm2IGkFdKvoUtb/X0CY=;
        b=j9AI43ktvOJ7LX74UJsXDGdcANKwLkNyv3pcwYL0adZFJiETkCtY24kUEGzwT9xTEO
         6Mh9HS/tEbA0A3m51vMvhNpDcd6IHJ1sKywenJHIHEAjdhJL6Jpd5u43MN79/Nwt4Bdm
         JcAuLVI2Tpe9lnX058tXkkH87WnH/OOm2ECy1C58AqJmHV151MIZvncQIKGn7Vgupeva
         h5ke+KWUDhxmxpTpAMOyEpnf/W6CFiZZmOH5MisUADzqn+TkSkHuXRpVQ/QXZCuppjWU
         eR55QQDkMGdWqC/t16YON1l8lfgBfcq0fLg4Jf5FaznhyMWyteDgGYm0MTc5NzIpO0mi
         dkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778189809; x=1778794609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pYrXCeosSkUk/BLwqx35IEtBdm2IGkFdKvoUtb/X0CY=;
        b=D602QlketGOAAFUiA+bPjdQb0HhFKEyG8TD1VGMrgMy0xWw23NaJx61G5OkttKsD+e
         T8/pfndYTUu+5EroU8DK8m+bbwS3GQs/bUtJftckyMxlZIshAWjMzMec9dJwReZcUdau
         5NAgTZYfeJdRnF8lcNiex6wi/SeBwHYorbu71Ze/mJ45f5RUNViX6Z2lu79Ak7xrgBLY
         AE2Ep3qRbgeNZhNxKDFJx4rU5VFa48M22cLBmr/bE8Bo0INtAP98cVn+yOfVhOIom5oV
         ZthIh1QTY58Ce9RGY67PG7kYSQZJqw+IEu9MQNKZxcaHadXaQblN0uP8yGEd8EQ/XDd1
         nDgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gGr5pEn5zDTcbjfj5hDcN9HrwE3BzhY9tQjr240C7Fy9UW58r0gN+DdjLAwlJa927kOrfLVGmeNTIPy/6LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWc/Wn09iQ1rX8A1IUiiGKO66clTB7ZPEfGE+7X9jwlHUMbWEI
	4dXwd6YUMFLt1K0um/hqzLDfodxmSrtreeZ8yPZpDSxPpC+GerscDNj/6E3PCMaR9hjoBep/xLU
	OhBWgEWXCa05698yV5FDQL5wICORTYR4AkJW4Zn8ByNjQ9xc8uTWXzkryCe7Et35QvUltKJ/1n1
	3xZCO/laanUIzpDUEYlexraWRfOARX8L5DagPU7QEdKJh4
X-Gm-Gg: Acq92OF9aTgZw2pR3qRrEm+bDpSAdP+xTaWGEmUt/oo6z06MGNKJvj6HfzwTRvvgpUf
	5Jj15esuIAEEQbm83GrU4DtawbGkey/i0vhEL5cm//Q9A/r9BnmuIHQlMe7kDinQIwKHfdJtp0h
	bwNPIr9HLRc6XljgRj61AhF4Wzn2TU3nwhnGR0YzpaLxaaRI+0vFdk1taNYBz0YbW5/UDHUiIlR
	+A0vvpAA5wA9vL4O4JEr+DwkfE5Li4FGHf5CGwC
X-Received: by 2002:a05:6214:2422:b0:8ac:adca:231f with SMTP id 6a1803df08f44-8bdb79708f9mr66629386d6.14.1778189808969;
        Thu, 07 May 2026 14:36:48 -0700 (PDT)
X-Received: by 2002:a05:6214:2422:b0:8ac:adca:231f with SMTP id
 6a1803df08f44-8bdb79708f9mr66629066d6.14.1778189808588; Thu, 07 May 2026
 14:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415223710.1616925-1-tristmd@gmail.com> <20260415223710.1616925-3-tristmd@gmail.com>
In-Reply-To: <20260415223710.1616925-3-tristmd@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 7 May 2026 23:36:34 +0200
X-Gm-Features: AVHnY4KHONndGOXuRMoFanRlSka1O6k9OQdH6gJnlD_bBH1grdcfWvKa1L069Bs
Message-ID: <CAFEp6-1zfFx1iv1BmdkEG6snx_ggM8s+4uCe2R5h94_+SZrgqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] wifi: wcn36xx: fix OOB read from firmware count in
 PRINT_REG_INFO indication
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fd05f1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8
 a=OdziNuKvR_mFwENv-1UA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: zMynqqG2N9J0fnZljKxgSpafiuMduvcS
X-Proofpoint-ORIG-GUID: zMynqqG2N9J0fnZljKxgSpafiuMduvcS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIxOSBTYWx0ZWRfX0xv8J4CQFPhn
 jJKosUsIkd9qFpU9tn6/TDIw+7AKNiQqH6ziBLX3ZQSbsjpjAlBjXlsBuOJ8h+fSVC9wF9m+9JN
 VReR4VMHx8r3MQfPl847V+nXThLFKdxAN/tJ92f4le7cbtiyxcZ4tknkbpQlC1pQ75EelVM2KnO
 I3DQZxPeIjxWhfFsfF690Jk/kozICJJ4lfNBpVd//XLnfOhEJyQX6JaAS72526A/Mgz3iVgZCww
 G8o6YwbkzJeWITT1RDIkD9g9uOZE9fpk0CgJWZx1nx1N2lEbghsrQqLT+f2iD4Qcw7g9pFmLGfp
 9OwjRBNsOqs5frEzCCDp25nbtrjPT7qQIA3aqS6EpFQgw0PVM+25NFBEOzqI9MC558FHeugg4Li
 zZJQmE64QGtQ+3cQiqg4cwRLhcIckNIu4y0iuWtcx1+Zu2fPyqV3knQBGbB3l7hG9nuUTuv+gId
 53n8mtcean89NDKVtYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070219
X-Rspamd-Queue-Id: BE0624EF62F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36097-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,mail.gmail.com:mid,talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim]
X-Rspamd-Action: no action

On Thu, Apr 16, 2026 at 12:37=E2=80=AFAM Tristan Madani <tristmd@gmail.com>=
 wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware-controlled rsp->count field is used as the loop bound for
> indexing into the flexible rsp->regs[] array without validation against
> the message length. A count exceeding the actual data causes out-of-
> bounds reads from the heap-allocated message buffer.
>
> Add a check that count fits within the received message.
>
> Fixes: 43efa3c0f241 ("wcn36xx: Implement print_reg indication")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> drivers/net/wireless/ath/wcn36xx/smd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireles=
s/ath/wcn36xx/smd.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -2803,6 +2803,12 @@ static int wcn36xx_smd_print_reg_info_ind(struct w=
cn36xx *wcn,
>                 return -EIO;
>         }
>
> +       if (rsp->count > (len - sizeof(*rsp)) / sizeof(rsp->regs[0])) {
> +               wcn36xx_warn("Truncated print reg info indication: count =
%u, len %zu\n",
> +                            rsp->count, len);
> +               return -EIO;
> +       }
> +
>         wcn36xx_dbg(WCN36XX_DBG_HAL,
>                     "reginfo indication, scenario: 0x%x reason: 0x%x\n",
>                     rsp->scenario, rsp->reason);
>

