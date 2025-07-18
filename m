Return-Path: <linux-wireless+bounces-25659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2CB0A490
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE601C446DA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3FE2DAFA5;
	Fri, 18 Jul 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QONUvnxl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EB1E51D
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843435; cv=none; b=UN5h6Fy/yfYaymk6U2F8/qwqf3uSlRx8tVA5Q8Kj07FGBs+VMES9JAcBXurUuDa/0YQ32cBCXgn9E0mZIfbP1lr6n7JQ12Y+xqgjf8uAJdZFw8SjPQ3KBY6LsAkM1ZTaTyJtNWPw8HOUEuREwkEs7/IZ38vx3Dq/9AtK/rkRf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843435; c=relaxed/simple;
	bh=AFAGPYnEcAwy7Qs//72IHEv/HVU0acgkn5UvXzeVAx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlIW3Beu+Em3eij6NCSf1TPqlvlFps9LqsmYa0iRGI9KdGJkEwf+LsJ9jguGmkpzRqcD6MlS1HEsRVjCrNoJ94psmoeYSYOMoGVW0L9cVsS9AJrPLbRiKIVn88rhiXzJwVepgnNhsAE+3lbzuM4XTPBd0EQ04hVcHFfwAuZNhJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QONUvnxl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9ql6p016095
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 12:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	958/RinuFcl6Ih5iN+hiL5YJlPhwmJUylOw4mZu4SiE=; b=QONUvnxl0+5mdRDb
	tvG1m+gCfJRaAwcgqvxpysa/IEYfncZkL2l5oV7MG3pWtlulPJIUxThzI49NPLUA
	8NYLDKsR8uCTv9bLUC4z1JAsGqekKc/pzt/dSXeHb1gIY3dfM5mLE8xjIsgGZvtt
	Hi815JfmiF5tS2o4MT+LsyGIeSC/v9/i8kc3wD162PsccQeOexuEuYq/vfPq7SdZ
	icpjMdYF36ju6kkrKMOHlYHfEmGLGP5vTOsZDm+LJGMI02QiMNginfHGnu7UodSt
	XXGtfEtlt+7DoXkJg6HJ7ZApJsdHTGQTzD1g2WeCqyr2bSPNiORVpBewlwhMuiF3
	b49R4g==
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc3dhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 12:57:12 +0000 (GMT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c13b0a7beso36827239f.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 05:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843432; x=1753448232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=958/RinuFcl6Ih5iN+hiL5YJlPhwmJUylOw4mZu4SiE=;
        b=fBDWXFs1B7XmC6gr5hTjUBNi7SK6YPhGINhpVl4sgYxD4nM/UxG7yXHgitxXXiBYup
         6RTbej378C8jyw9O22rq8zeCAcnhf115TjzRILjAfvv/S8ORCt27pfBev/iO/R+OIjW6
         YLkkcIYiVMkhUVC9Z3sbdwGGsBtukJyrRgl+ayYJGGpuGo6tjJEjcoYq9qQSRfNZbh+H
         W6kz/izAW2ZfXhzKeQaPyNjpY5FSrcpHTHMTpTqqCoobsjPUm+Vc1trhY6bS152I7bi9
         Al+meo2LT7pvFMRcKtiKRGseT2PgDa566GnxQisEyUlqstBZfocXqwR2pQ/S8Ztlv/n7
         XCaA==
X-Forwarded-Encrypted: i=1; AJvYcCW6xZnaqUx4r6oA43+e3gxdcLnO5Pu8g6OMQ0qMaqfyTg7evodlJ01KexpSH/gkpPCgLxXZFs/ymH3PhU+hfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BlrQ9E7pXSvN6oE5GR9Ggmfmd/pmj9dYMzOfa1P6wINkF+u/
	9htKJrnfqyWmlhG0AOVBkulXVQaqYv0wH1m46yJ6P+M3mtD2PJd48GdvQTcmaPhala6hYaaxfm+
	qKxgLFCnmvviCKJbetcKAIJeOO7nHVJ+ySjLNsF6qJIu+BOrLR8szPYVRKRZxVZNQakOQx1zcKT
	qIufD8Dwm2Ch1M7JmfRH5KGe69gQxWaTofpY8VBzfh+G10
X-Gm-Gg: ASbGncsSFKdVT7FX48SC/6qP6MIDRk9I4Hzopb8xpeWG242J77iva0hFCxNMR3gkpxe
	WSQScZ8b9qbMG5Rq4CDFE5fS1JQjplCbDb4aMGKCMYaY+4W0iMq0fc7ftiB/JOQpeJ9yBdkrp+v
	borvtLufpKwxVbNL4eCttGag==
X-Received: by 2002:a6b:5110:0:b0:87c:bf5:c242 with SMTP id ca18e2360f4ac-87c0bf5c480mr322168139f.3.1752843431766;
        Fri, 18 Jul 2025 05:57:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXjBAut55aMcXApNG4TXougkXbkFdUFxCa9fi0cw8T0llYEk9LYmRpcxB//1U2UmmX5Fa41z8ZEZcnS9XiIEY=
X-Received: by 2002:a6b:5110:0:b0:87c:bf5:c242 with SMTP id
 ca18e2360f4ac-87c0bf5c480mr322166439f.3.1752843431339; Fri, 18 Jul 2025
 05:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com> <1ae4000edd954cf492e95bdb059c89b2@realtek.com>
In-Reply-To: <1ae4000edd954cf492e95bdb059c89b2@realtek.com>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 18:26:59 +0530
X-Gm-Features: Ac12FXzj0DPu3TurVc7e4btFCp14YjPiNSUwWHpykNU-GLFU43LlmfUBl8e7Bvc
Message-ID: <CAD1Z1JK1wnCTeObYAHALkxDVFm0kx=7r4urtA4S0XorLNOPKfg@mail.gmail.com>
Subject: Re: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to
 mac80211 when offload is enabled
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a44a8 cx=c_pps
 a=uNfGY+tMOExK0qre0aeUgg==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=n9Sqmae0AAAA:8 a=EVJh1RV3RwhRAVzL0QcA:9 a=QEXdDO2ut3YA:10
 a=61Ooq9ZcVZHF1UnRMGoz:22 a=UmAUUZEt6-oIqEbegvw9:22
X-Proofpoint-ORIG-GUID: miK8JdVo0MCDezFTBEQYGTXoxOO5ocRB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5OSBTYWx0ZWRfX4jJ9Z8qIH+Gm
 +MxY3JioiWRAmvOnXk4LxSIbpKgH1GwY7qTWYqmGWHkLJ6gprV7asBvWKgxKa+JxUSWb5Uhr9Qb
 DkH1MJiBdKIknZBXHaXXm0R5DVKIpAd7b6lbVUpEI4R50rPC5BHmJ69nptseUI8pYbaEOUETWnZ
 rN6DxR4IF+es0R1Lt8I8kWRwJJK64dlWAL46N3Y33e8c6+rbCPWyAV1vXZV9l6s9aBYC9vUHP3I
 R7w7WC29WSmb9kupmDS+oaTDx7hdBON/eyiFxAZBXgM7TZTgxSr9kgUFnOAEgGl4UYmdu3PGd5k
 e70oPOs6f8dXXhUa5nIi8SW0CchkWHkUswJ8FXwcHZB4voebTN2OvcNePp2f5mK2633fSbzMD+M
 2WkK4ajKRnJiOerzq+8yHR38U1v+tzpeJRhUP9YZ80FmtUbwocFMugK6fNYOa36uF7WQAMev
X-Proofpoint-GUID: miK8JdVo0MCDezFTBEQYGTXoxOO5ocRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180099

On Fri, Jul 18, 2025 at 2:45=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> > @@ -578,6 +579,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base=
 *ab,
> >         struct ath12k *ar;
> >         struct sk_buff *msdu =3D desc_params->skb;
> >         s32 noise_floor;
> > +       struct ieee80211_tx_status status =3D { 0 };
>
> With '=3D {}', no matter how the struct changes, you don't need to change=
 the
> code accordingly.
>

Both =3D{} and =3D {0} achieve the same result, right?

> > +       struct ath12k_peer *peer;
> >
> >         skb_cb =3D ATH12K_SKB_CB(msdu);
> >         info =3D IEEE80211_SKB_CB(msdu);
>
> [...]
>
> > @@ -805,6 +830,12 @@ static void ath12k_dp_tx_complete_msdu(struct ath1=
2k *ar,
> >         struct ath12k_vif *ahvif;
> >         struct sk_buff *msdu =3D desc_params->skb;
> >         s32 noise_floor;
> > +       struct ieee80211_tx_status status =3D { 0 };
> > +       struct ieee80211_rate_status status_rate =3D { 0 };
>
> ditto.
>
> > +       struct ath12k_peer *peer;
> > +       struct ath12k_link_sta *arsta;
> > +       struct ath12k_sta *ahsta;
> > +       struct rate_info rate;
> >
> >         if (WARN_ON_ONCE(ts->buf_rel_source !=3D HAL_WBM_REL_SRC_MODULE=
_TQM)) {
> >                 /* Must not happen */
>
>
>

