Return-Path: <linux-wireless+bounces-35175-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFRIG/aD52m+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35175-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:04:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350043BB91
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2A2F3005157
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0A3CE4BD;
	Tue, 21 Apr 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isvQvTXk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LsdCw2ZR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3C19D8AC
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780231; cv=pass; b=VACpx9nFOyPiQf/LWoqFchEy3kHMpO+rm0pApjJuat7wSQ2V72byelgkJP2jIG0r9owty3DuOhhrj/a7v9sg8xpwuoSZQpmKTIXGD7dxlCPzefHmuXXWOJKZXDYIGxN8BAGdEMFhFtMa4PwRONQ1JOfEcPtawiwIidPq07YDMSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780231; c=relaxed/simple;
	bh=EWgSU0S4ZApyqxvkQQEAHY1K4COmjuUauD+ISBIugGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhPzIytwMkiD2tRa/LHyQea6c5y9dVTAfdeVMufZZ3qvLN0Ao1Ly2XtHl2bVbg7hCdoRG12CyCGlTpivUgjKVxrzkQNsrFX08LGxQl+UDTTfNKuLJLGiaB6hyGjLV8cGLoYuPj4KLv+dqbRF6CmjT+z8jVf5OWCqXBMpmWFIAUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isvQvTXk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LsdCw2ZR; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCLEF03257313
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RPVxNHutUbeb4xzXqYWhf0lVbTJOTQEQa3TrXnYExB8=; b=isvQvTXkIUNqpNKN
	KCKLImjH8ZDuOeduobMrAgcyxl6UtUKK1hAJNAVg0S9J7qi7wVwXCnbfiHISGRDn
	4dIOgeXyKSenZBiewTwm5IEE5gqASV2EPA+i9i8Zv63Pg8Y/ipgNPDUXZcKD2D5u
	VY7t3c/Fh0wexhe0Vuk4lkbH4yZIl4e30JOG6gew3w59ZvoGGvoCWGRaH9YHsrmD
	MXDH9wSqRNUDzDKY+71/EDN4NJ2Sty0rj+HcY+hvIu75/M2l8cYnAF6bXlvppYH1
	DBxh07BJXnKRgVIaIfRvsxRH4R39XrkGaElSBJF2OVRBkOSRbX6FS/hwI8flW05w
	DYVV5g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp3na9np9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:03:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8eb9f8bbbb3so90248285a.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 07:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776780228; cv=none;
        d=google.com; s=arc-20240605;
        b=FjQIbziNYmTLcvJJ8dCLNU2RM1NXNWNdRHs4cRPyTDb7E2jARkbpRPTahGljKvINWZ
         sHxugDxv+30YUJzUJaVwcWSSr+SKvDtt9M41xca+pjmKiCqlwfkFodXfma3ZawJq6poX
         UXvdGKyKA7Vy2sJP4QstQhfs45Qu+S9rGj7Uquv1c/P5SKIK6JN/HW08kzi1Qdn4Zu6N
         tJ3yL8Ms/D8CtzKoSi3PlI9wrKICkzJ528wWBuZlIdED85oGOJbiVT0Uls1RdADCLZwf
         OLPqyQyBoVtRMDTy4re19cvwdQcAzj0IXZPTkPN6hQN37oT56Ajto2sO+GQ0hEp3eevb
         ZE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RPVxNHutUbeb4xzXqYWhf0lVbTJOTQEQa3TrXnYExB8=;
        fh=livUDcWT5T6x1+L619svQ/fmbmG9w/lMBgPNemPJB8Y=;
        b=Y2zjzI92aSw2dtr0GThfjZkzHqvMKsB7YrihDEwZhiQxiQFCOENOuh5Qo6DRwjGFRa
         VKasrdEZGfLsgYCsdqdrNi6n3jOUeokbF2aaYHk8N7wX2mDJ0aM9GyWDSe6Oj1/F6ite
         Qe5dkTNfAD8JuRXZk4DtfjlJ2/fiRtsQWL+5qygmUfdfGxzMJJSwg8juif/HyoJdXY6z
         Nzu7t75v8b+ZnqBt4Kfa2u9P3Ljwp3xqjyDlR6m+HVE8sG1yHwU0YjVAEdb3Pxoh60uM
         7wLiVsiXLEZXO0+f0fOm9PWcnz1g86UdE/aVbOnfJZBzHpFMt6EAYXY5qadTE53rc4Il
         lbUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776780228; x=1777385028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPVxNHutUbeb4xzXqYWhf0lVbTJOTQEQa3TrXnYExB8=;
        b=LsdCw2ZR7MOlecJhTdgRxH4uOaI0URkuttDM+VF5XhlsrGmSgorvjPrchONjHh+dsf
         35n3Ff/hKes8iPD5Qfi6c/m2NfQCY7IICoKUSOlQA2vyaA7sOH0Vx4Ks4uS6Fvk3MW3A
         alH1Uwv30Zj7RRJLJmMkYu07pQLt7aXzSOSvpHO+P6uRlC2esEfRuvUQ8sdY1zy0gDbl
         QvtVuXMHph3aa+fl4KD7MRRXljzf7juxQW1Yuc1/BI2+UKqxbPKewGhvFjngowO2zWca
         6yX0wAR3TDxVwOAarwP3VB966JuupxVwDUVP5Yqr92VDwjghPmjHnNt9rAfjadlEQwsV
         150w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780228; x=1777385028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPVxNHutUbeb4xzXqYWhf0lVbTJOTQEQa3TrXnYExB8=;
        b=O8IXqXzAmTcjJpJmxKpdilGooAnLFbYZxiHyhUFMADEqct1gSkdqISNBRG/DbwUKA2
         XIJRizQ1Bp7CbmMlKZyuIE+YOfalVdU2oYLRwrnul11Diz12y4iMSJr0buf3B/uzb3We
         wuXnoGP2ebdV6zPSeORxiatR+FYfWnTBkeZQ9HPbhm89lWh+XKbKdGZwdl8QR1tL3fwG
         T4UiZQoN5eny7YBjPAaJPGvdJgPsh0+xlK2QjeCBxlPjDT0iZSiXIobuQGuRsjwFvai6
         NBUgWzh/Y04vn8OaC+YsqQlTstjD285pc1av58uKi+3JbyC44iH7SoxJhhmddZlEv05g
         rsiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ORnbmrQKtmuGrRrrIXfsRh9emkqa5mdOW8317x7+wYHxVOOUc3sV8IF9KeWndTLpSXL4HmFWgktELQF2MgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypyIgWB36V8pxk7Q3qy1Km5i/vkP5cVhEz++NVV3tRI5NE02Dx
	UwFbBZYdxeKZeh1V2ZcmQjEY8f/48NKzzod+3EfYa9vMhtptzgeXrMxLmHuhvGVE9LzPoaPXagD
	ICBEFsLAp1niFQfgT7A39IG1JyesB1cun4Y+ZpsqJ8YGRm8ddMBV+twriTjakHhQp7IjKSZm7Vp
	leeDlom8TmAQ+02QRAxIkc/R7fLjgFJDuPIr+0AgaBoGzbz1JQE2bFa4Ac5/+T
X-Gm-Gg: AeBDietGk2+GuIUEKnLPs1/vz2FWNWa26evX8HSx60V7PkG2HKNP+Z0mD1ehiLybNaE
	A7dvIszl9fzadle94YQga54QLbGq4EFs7Pk0IAqYmCzRGQBXLnNu/OI3YfKFfuzdpFaPIJwOTlZ
	mc8/sq0BL82+fz4Drh1XeXo4LfKCZLH1r53XVya/4F3SBboKLV1EFf8OY7Ut4aHhjm4XfwgIKwq
	P888ohKppu7SeG+NkikcGiYdJcRZT+sdGetGEsCkjzyVCNDVzk=
X-Received: by 2002:a05:6214:3905:b0:89c:867b:a9bb with SMTP id 6a1803df08f44-8b02872e166mr244037926d6.18.1776780227287;
        Tue, 21 Apr 2026 07:03:47 -0700 (PDT)
X-Received: by 2002:a05:6214:3905:b0:89c:867b:a9bb with SMTP id
 6a1803df08f44-8b02872e166mr244036926d6.18.1776780226367; Tue, 21 Apr 2026
 07:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421135018.352774-1-tristmd@gmail.com> <20260421135018.352774-4-tristmd@gmail.com>
In-Reply-To: <20260421135018.352774-4-tristmd@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 16:03:34 +0200
X-Gm-Features: AQROBzCQKmJavrO8rsVvuz5krqkRjVJY0_HMhEzxwcsrpl22UbbajdD4rI0Z1eQ
Message-ID: <CAFEp6-3RtHYjyTPQaQPSVkwEkGA4B0XLzbTC2PBHAxLKGx-F7Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] wifi: wcn36xx: fix OOB read from short trigger BA
 firmware response
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Yjvs68IJjZZi61Cur-l__zcS3yEzrvsP
X-Proofpoint-ORIG-GUID: Yjvs68IJjZZi61Cur-l__zcS3yEzrvsP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0MCBTYWx0ZWRfX8CNP4z6SGhwB
 lATY5U5xBNmcIrLaEkWGK+970N7JwvpEX71cPwYugQjGfZhcoy+OMF8qLJo7SS2L1gLdnMoytjk
 PXG7S1Irrg95hk+/QfXIbgzF93g3k3h8eX7cvJ1YOC8FVeR109pvmXk6nmrPDde9/QplQIWWsdy
 xjoDXYXag5Ezvhnmr6dig4Car9YOfIOhLTgANib1MnvK6aX4COVfsuf7BdkrkiIXCKStWzQWvDT
 pPBi0aoT0GNIUKe+ci4ySKH8YnRM7OcLDPjv8qwL+Fgvc6WD/bV6mRMrtTW0ngbYkuFvw/fSUXd
 t9fEx9lCECaB1EF2sENvPk9beEFcK3C8NMq2SVCQwk2wukKw+EbAm1mTwi7vWKTNDjVvf991Kmz
 z+Tw7kQEhlaTjwCnNdm8Fy4oKFZgJQ==
X-Authority-Analysis: v=2.4 cv=O9cJeh9W c=1 sm=1 tr=0 ts=69e783c4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=J_-Nd1mkAAAA:8
 a=-LKbWVmP-K9BPXClI7cA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210140
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35175-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,talencesecurity.com:email,oss.qualcomm.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6350043BB91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tristan,

On Tue, Apr 21, 2026 at 3:50=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware response length is only checked against sizeof(*rsp) (20
> bytes), but when candidate_cnt >=3D 1, a 22-byte candidate struct is read
> at buf + 20 without verifying the response contains it. This causes an
> out-of-bounds read of stale heap data, corrupting the BA session state.
>
> Add validation that the response includes the candidate data.
>
> Fixes: 16be1ac55944 ("wcn36xx: Parse trigger_ba response properly")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

In previous series, Johannes pointed you to:
https://docs.kernel.org/process/coding-assistants.html

This document describes the Assisted-by: tag, which should be added
for AI usage tracking purposes.

> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
>
> Changes in v2:
>   - No code changes from v1.
>
>  drivers/net/wireless/ath/wcn36xx/smd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireles=
s/ath/wcn36xx/smd.c
> index 2a0c946d81095..c0b477345832b 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -2599,6 +2599,9 @@ static int wcn36xx_smd_trigger_ba_rsp(void *buf, in=
t len, struct add_ba_info *ba
>         if (rsp->candidate_cnt < 1)
>                 return rsp->status ? rsp->status : -EINVAL;
>
> +       if (len < sizeof(*rsp) + sizeof(*candidate))
> +               return -EINVAL;
> +
>         candidate =3D (struct wcn36xx_hal_trigger_ba_rsp_candidate *)(buf=
 + sizeof(*rsp));
>
>         for (i =3D 0; i < STACFG_MAX_TC; i++) {
> --
> 2.47.3
>

