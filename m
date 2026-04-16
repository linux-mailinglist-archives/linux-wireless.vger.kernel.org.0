Return-Path: <linux-wireless+bounces-34906-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G0HOIM94WmaqgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34906-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:50:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C8F414563
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 876C73016651
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8433BBD1;
	Thu, 16 Apr 2026 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtTKpm0t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHq7bRRZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7863E92B4
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369020; cv=pass; b=H3MDoE3UhcKTr7BZsW5rhKTsKEhO1YyO1TdfSY0pG3zLBMSj12C8X6q8ZFQ6gDrKGEsKVh64Hfjj/aNmWWYhQC8rbCScMdhX77Nn1nrBtFZboSmqsyvHjF/b5ps7EhVUWiO/wCvIDanwpleM5lMmdqCk/aBaG0uNzvLXf3UqGX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369020; c=relaxed/simple;
	bh=yOz6Du1bWQ3JdSoz4JEmDyWm3LAggjlfz67gUVPkKLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxSyLL6aroHYMoNGDTA+Xdy6q4HI6dFUwsOb4t9xGqunFTBqXYbvo8OFDo9UJdNIBhy07a+Nf31d0GVXuwUp10fENeXUyjazo8leq1EkZb2U2S7Ik+EWYki6GtBH4oW1G+ks9lMW6mORk32+DkaRx3z8KfP0zqf53DZgTemBnxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GtTKpm0t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHq7bRRZ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GFdMA8701878
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 19:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yOz6Du1bWQ3JdSoz4JEmDyWm3LAggjlfz67gUVPkKLI=; b=GtTKpm0tVsNd4kCh
	MGTw+VNozVGoV1IW2apyWORdtXg7yv8XRF1WV/8cOIKDvTey75QY2JWnWZFJiXDH
	siPqNq4Y2+/3dK9Z8vlwRil43aOnv6vn4BrkyB/vixeIKs1NocObVZ8D3jBknPro
	wMlh0uZQoXyVAPEbdLD3ZODNasRZqaiZqidUEbEjOedd4ADfypU5uq2poJQVhwrB
	5I6qiwItSti+A6oyYsZgBLcwvqDbbPNGwtYfxDGzzs0KQMFmYL/quqw0KmBmgQMd
	26teFJE6r1AmCdC8dKSmnK+0cUi98agwJpyr27Qmm7aegKg2cw03wI5e3tlYrvxt
	V5pWqw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2kn8yme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 19:50:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8acb85a973cso54704726d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 12:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776369013; cv=none;
        d=google.com; s=arc-20240605;
        b=QOYcZ7/5nPWuexa66D7zEw0AMWgzrmtjIKtgNuNC8//km/8+aMOQjyqLwj3MUzBQiO
         x0xcw24twHHmfTm9K9XmDGpCMi4Ds00T+mD9RpkaSFjSXmrBejlGkx8Et3RcEsDzR+Gm
         ngN5oFSd+bIpx3GYp/ZN3KrrHrWoBmAuXlsDVnyincAhTmTV9fCalG+yoE/wpUsTMJjs
         y8tRRoO2+9mav6hWct6o5ovt0Lt8lTK2ZngWUk1vbplT1d7DepVQBXE8Vj6dZz+mSHy6
         CI1JggcuLoGRCfQF856qYEdh35yQ2JyHZ12OWkmWPLAKtyDhLZpe8NBVt5b8tMRYxnft
         nclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yOz6Du1bWQ3JdSoz4JEmDyWm3LAggjlfz67gUVPkKLI=;
        fh=TSpxmNMawUrxgc+aht9FP98htHdV+1o2AyGUTktfCBc=;
        b=bjD0KhVv6l8tf5iJfNy7FnZ5uPIHqA98Q/mfRiJ1eIIhwQ9nEUVA0hB9LHl90Mh4xi
         W+4HRohPdkJ7sQPSMrcSarhV0puY6HY7necsW0+PJrd8XsD/fyris1VweHu13JBDg21A
         gvOA2pSBAoDZH9IEwK+7Ayeeu1fvjhXX44/eL27B89HefabThpmpkpB6JJebOpDMgxpF
         oEexxZJjfPjquef/fjuVX+/tDKkF4jdIpRwStr/7YnEZzYOK5u27OY4J+neEdG3j2FKO
         +aMM4ChVzKSKZ+nzOdxB6nfsGwYiqkx5zs+V//bJCLziau0ubIOLphuo0cIWKrIPiv9+
         LGLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776369013; x=1776973813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOz6Du1bWQ3JdSoz4JEmDyWm3LAggjlfz67gUVPkKLI=;
        b=XHq7bRRZEsM3b8dpF1Y1NUXGAjAiUcvqR/3u8c/VllYe427FayZLKzg5A7k2WcdwCg
         8RUsuVapYFAKhJ8a3Dasa239y1BdHCNQ0ZTXYzUKVUwSxmMJYFm0axTDYsuJD3mJPw6d
         BEl1afszeX4mNoMD0687prdqsgcEYMQpJH8nr2jsn4+VUrT2RhfNCeqmduj7bmknImJw
         Dd0VjD70ZDIOYQkzluRg2gBa5+FtIkN8Nz1OXdPQqOiY7hQUZ3ZiQnmfIqjwJpS3NQep
         3Lv230Hmlj0h/TScuZapk9kwsV4+FsuMkIBchJ1DHoHdIH3NIvLVOxrS6uvUY6Q5lV9p
         GGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369013; x=1776973813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOz6Du1bWQ3JdSoz4JEmDyWm3LAggjlfz67gUVPkKLI=;
        b=nuttPsTbttk+wIJbQILmhNeTnOJKLyuqpbbuIazPMck1YFvHkkM+hKV+LOOmWkDYdf
         WFoOay0blIu5A2Tm6zJNWkw+mey9D3YXxnQ18HbPE+YKJ06pZ64zHZeEuwtWpVXy/L1a
         +Zi8LhZYi5FExr+88CGdWVcaVVwv4sU+H9YSBbiHHOAxVX9x4SGMIQrOUPCyxv1CuPYL
         Yl5SZffzPwn8SyMpn03YswKtFkosXWQXzqkiglKLFFaxvcgte+HtXFF7wU0K+FuW9K1D
         B45gMbqy5Y5N206IrUzL7WXuc3k+fKx3mwD5RJmwwMBuJOX0PTeSbGRa0wAd9o3jCbOv
         TsUA==
X-Forwarded-Encrypted: i=1; AFNElJ+esdNRi7h9A2lP53+AHqgXQm/QHszi9CMV884J65cGEgHFnqYpqBVrld6i/9vpt4uD4lFRlZQB26onajW3Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIdtdyUA1EeEGEWELOEJLlRHkQJUndD08aebnkkfDtNWwnUaB
	kbxb9RKuxMnGL+89wEPkU3kSMCcUkvsW75P6uA9g4KTgEPF1lk05nkSx+gizGqO5PXXmmgoFyuv
	qlVI1N9wcslT0DXsQ1gpYW1zEbM5JQlo5E1+99eW9wYrjflQDXN63G4WX6CQvKdGXqPirPJokNb
	07jaNGAV0qBx53U2i5ClScWG+EO5k5+5zOLztSh0zrqP4K
X-Gm-Gg: AeBDievM/eXCSkpTpOlQB7AXp+7Mzvt4c9s84EiP8aFGNQVUmi2vxS+h1jaDmWYmhDr
	6rfRnQMUiGI3OYSz/TCIsr4x+diw+4ale78GsjYzXCHznQ9MUlQEJJgQzZbmcrzcOhhF4wUT8bw
	QMiwE2G2WhUfRbsbegOxZAgnfEDDK4JoQx7jWmJ+OfAdSHhLPtRYivjwLs2yVuRvwa43Hwxsh9r
	+Aa2k4DrG0FawMV3HwazPgzkOU4QCjS2LEKgYv7OTV5sVdAf5UBlRJ6Zvg7yydHr74r2oT9qeIa
	hg==
X-Received: by 2002:a05:6214:2d48:b0:896:fdd6:4a93 with SMTP id 6a1803df08f44-8b025f73de2mr10927286d6.50.1776369012716;
        Thu, 16 Apr 2026 12:50:12 -0700 (PDT)
X-Received: by 2002:a05:6214:2d48:b0:896:fdd6:4a93 with SMTP id
 6a1803df08f44-8b025f73de2mr10926746d6.50.1776369012241; Thu, 16 Apr 2026
 12:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415223710.1616925-1-tristmd@gmail.com> <9fa651dd-6004-42c6-8c03-95247d5807fd@oss.qualcomm.com>
 <c29bf32b7f1195a69d86b4f728ab02523675b41b.camel@sipsolutions.net>
In-Reply-To: <c29bf32b7f1195a69d86b4f728ab02523675b41b.camel@sipsolutions.net>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 21:50:01 +0200
X-Gm-Features: AQROBzBIQAlZIE76FlElA-xessdb_M0-SHeE4gmyq6qCgNGgPNBn9oB09dzW43g
Message-ID: <CAFEp6-0u20cnTPBL0LibXO0KudYwTvGv-2ZwE3HOMotSU=vUXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow
 from firmware responses
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Tristan Madani <tristmd@gmail.com>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ueL_eKkfdyYej_xcTunhtLA2FL1GYcxx
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e13d75 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=stkexhm8AAAA:8 a=J_-Nd1mkAAAA:8
 a=paXHt7Kumadp4Y4tDCcA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=pIW3pCRaVxJDc-hWtpF8:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: ueL_eKkfdyYej_xcTunhtLA2FL1GYcxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE4NyBTYWx0ZWRfXwFi3OVws6+rb
 h5g3pAn3xi4VAdnBd2p+31J3mc8itwxf5TRR+uzVjdh6SZ+25VlLDBdY3c6RBvM409gH1P2T1Ya
 grqogKFkRR/p5XKwDw/qiqMlRSexor8/aidFKSGxGtN9LgQqx6bwHxBeHuGVWRAQyGK/8bJof+/
 1qGvBvrVePuFZOwAYbrDetZoTV1WsmOv0iR1y+Km1PogX58tIn6dkolK0XFjAiK/ufjrXmDvVnO
 Y7beeRupcy7PldVzaP7FPeTQ7WqPm/b0Lzi8GgGaDM7TyfjeCEmJBZusI+2FS1E3V2bmhpFvX2i
 UnheXscppMHLw0fvd2vDYexHDQGc9NQ5mzMGt4LrJRzmSmFSfmXapOvdtmISAhksXNGttNx3rEb
 zsMbpgemzQ+CJu9dOzzyzdXbWnOZxGzNZnWi3b3ziEEAsMvJXaDO0SJgeQYWzY5hAvlpQoVwE5X
 njpINVnsbENXi0Q6MGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160187
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34906-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: D4C8F414563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 8:39=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Thu, 2026-04-16 at 09:25 -0700, Jeff Johnson wrote:
> > On 4/15/2026 3:37 PM, Tristan Madani wrote:
> > > From: Tristan Madani <tristan@talencesecurity.com>
> > >
> > > Hi Loic,
> > >
> > > Note: this is a v2 resubmission. The original was sent via Gmail whic=
h
> > > caused HTML rendering issues. This version uses git send-email for
> > > proper plain-text formatting.
> > >
> > > Three issues in wcn36xx HAL firmware response handling, including a h=
eap
> > > overflow in the main response dispatcher:
> > >
> > > Proposed fixes in the following patches.
> > >
> > > Thanks,
> > > Tristan
> >
> > Are you able to cause these issues to occur?
> > My expectation is that this is testing things that firmware will never =
do, and
> > hence this adds code and processing with no actual benefit.
>
> We're not really supposed to completely trust firmware though, right? :)

Right, at first glance, these appear to be legitimate and
straightforward buffer boundary checks. I=E2=80=99ll follow up with a revie=
w.

Regards,
Loic

