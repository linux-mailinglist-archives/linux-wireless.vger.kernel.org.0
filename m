Return-Path: <linux-wireless+bounces-25664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319DB0A5D3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E432F1AA81AE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C915E5C2;
	Fri, 18 Jul 2025 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxBhxMdK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826314F9D6
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847545; cv=none; b=BJybgCat2fnIJFx/aNUxDgdMpTrOQI6B2UTXb2/VjuLrvysPee74vUyE32sDQYXqTkqHI3FIAYa68UUldOWIHae3HpUclosld1IQsL157iGrgGYlIL8WuTkBKDQv87uOnIrIaEBWsSh0G9DUy86ifnv0s2KKls2xMXbc+84ojMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847545; c=relaxed/simple;
	bh=1QMYwowhtlkNhEDOwWm3irbkoviQK3nGOMC8S4w1hIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbW9hrmU5qXZgN31FAqedGAjCBvN1xjAewZ8V8jhTzMS7740DCbAXeZpVcnQpfLnmnjnhHmB/4pux5qqQHGfedRvEwwh+3VA1vnBY5B+UVWjbSVVpSZIpG4bD7nDTnhCRtW19FaIiqOrkw9y+r2oTRzFNgFzxV9WJrtY8Ob/efE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxBhxMdK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8h2mp008487
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zyq4Rp8MOZR1xUO79/KSeqlBWH+OdAsga8pf0MgHcCE=; b=QxBhxMdKYH6lcQh5
	9hUs87g7JS2E9s+/MN8hC5D/YfjH3V6rZDN6RR9FnOYBN0xb3pcwBhplrJbF3oC9
	ehNb9SgrB+w9yKM3qrWR1k79euMWD+xuDBk1oeZHVRK7yYrSMtl1bv+dCYRtrMOX
	LU5Nd0H7tmpeDOlS/y6H3F16jG1Pq4ponW7BBO6F6k1gddr61BqAZjxwz1np0tjA
	exSDTE/961+DI4cVNrTu1mqRGOqg0VBuUFl752yAVsOOT0XZmPT0gnGOoBxm9na/
	2loD1/jWtogUSrrtbSzB+EqFz74u5aNBCngU2Tgzcy2JdIPVEuRmQVDTB/LxRHQl
	GIiyEA==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbbtqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:05:42 +0000 (GMT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e134cebaf0so36124385ab.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 07:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847541; x=1753452341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyq4Rp8MOZR1xUO79/KSeqlBWH+OdAsga8pf0MgHcCE=;
        b=sae3oAwCfgOSjxuNAVWE2wJUELZxw5Cur7+3j9YzgpLYirNoI/U6Q1Nikevr+iV7bD
         KJPsLI1vx24lWKbjp3GkF4+n+mly2t9UMt0Rs6pNt+QbmjKIL6CuU1bcmLr3eJ76vedB
         aAm53EywNxuMVm3LI3eBepcuiDccje/Y5fuTAsquohUsExNiX9CKXaINmaC+QqVXoFIZ
         5GBIpbEcDh0ixjorjjL+T5/8gKYQMUO4tdaVdvkvHgHUwiveFX4/wwwQ+2/VkgRt9r8d
         6fzgty5jVab1LhwVTwi6oeesMT9KyaTfgQnixAlJn53VY1XzZLz4kmZvBUk0tvGaNf75
         4lpw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8F0wX3BdZgyfcTLUVIIZJZagp31fIpPGzRnsh+0bLEfc9IH9beWziSkdt3JQBekBgldGuGce5BRxfDTJgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGeFlj+Nk+I6tuT8v9J6SHNcRYL941E6m5UerfKLoTRAWNzZT
	S8uCVZ6RJqYw9REr0L9EXGRJ/l5GKp/oJf0eMppHOuV3Khz2DR2ZAdp8MBD/FuPpQigkzwTWMvW
	Ufq9lItXi41KLuggX5DIYzC3ckmJD+QUpR3jtidNjB7X+4firOC+9ooETvolUDH//gn+jEGeO/l
	qQ3jYR1PB5TMlW0tvY4S22KYw9K9jOUBvQqndoSEZr92Cb
X-Gm-Gg: ASbGncvMZU6pmNeG+/sakCtr+atP1lLs6RMO8y6RiVx/i1h+07uGp+oD4ENI4G3TdWh
	CmqNe8RIoPZogcftN/9Kw23HmiK5UAMsaRlKRsqeIgTb+CUoWEt7ZmDK1ixo1Gw1S5xFbI9KY8l
	UReAuGrpRl6Ohxl13T7g7+0w==
X-Received: by 2002:a05:6e02:3981:b0:3df:5309:e962 with SMTP id e9e14a558f8ab-3e282485392mr125889765ab.19.1752847541292;
        Fri, 18 Jul 2025 07:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDBjf/hyYGNpctV3HuOKDAPCV8KQACEaP6/w9zosmIlpfDEwcddo1LgpYxZfWgabOw/WiBaSq3a/Sq0j4X5/I=
X-Received: by 2002:a05:6e02:3981:b0:3df:5309:e962 with SMTP id
 e9e14a558f8ab-3e282485392mr125888505ab.19.1752847539496; Fri, 18 Jul 2025
 07:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
 <1ae4000edd954cf492e95bdb059c89b2@realtek.com> <CAD1Z1JK1wnCTeObYAHALkxDVFm0kx=7r4urtA4S0XorLNOPKfg@mail.gmail.com>
 <7859082aeea642e2a3fa3a2829404b55@realtek.com> <CAD1Z1J+M2342-fsyc--MB+K4cd16v-csMKd38Vjm4FSdvatEnQ@mail.gmail.com>
 <429a1fbc-dd2f-4c9b-b8da-73cee76e6732@oss.qualcomm.com>
In-Reply-To: <429a1fbc-dd2f-4c9b-b8da-73cee76e6732@oss.qualcomm.com>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:35:26 +0530
X-Gm-Features: Ac12FXzYvmrXYQpDYnGfSjgnISwRZX6ZUSyJWa8g4lZokl2wGknXr63MC9Jz8G4
Message-ID: <CAD1Z1JKSMqRRMKXEL2RUA2AKdP_FyExZ6U8XAz60aXB=B7iVhA@mail.gmail.com>
Subject: Re: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to
 mac80211 when offload is enabled
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: AK2TC1JFgbu0fTGZH45dH48o74Rj3rLd
X-Proofpoint-ORIG-GUID: AK2TC1JFgbu0fTGZH45dH48o74Rj3rLd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwOCBTYWx0ZWRfX6qOjdNmzJkJZ
 ARXkn6m+MsHXbok3ViLv5ESEaFgRdWMq+WAFyJjoRJLpI96DbYXfRIEUYS1us84oabSZ/r9ZqMI
 JvBc3t59nvI0FB3r7IR7H1t52YHsMiU2ogwulrpg4Qb9+rz9ahTZechniAZszT+YEZ+d2r+x+ug
 92kHa9BTKczZXDEd/ToVXgcGdJFV3oI+I6JOUY9Un5hwMmG7p41YKSSALwSf5p5XR2OGP1ypYrB
 RVe8doB/KlptL2qIQIRFeN7StkhfObs35M2ZUyAQqZXXDda8Ic9U41UvBMvpD4saTGdE1K5ioTO
 AEsuZ0K34u28AkmS3iM7+plK45NMZUoZ3ewArMm70gOL3RCuB9fS19FVSjhhBZo/0Z27HCFgMtq
 3yVpHcYxM5nb5zAYC5xvlDMrRfLVIP1VoWbW87o6Ikbpc5leWAvWoZZdeWPtfLC5CplZgK4Y
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a54b6 cx=c_pps
 a=knIvlqb+BQeIC/0qDTJ88A==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=n9Sqmae0AAAA:8 a=s4K1LNoi-mhgWz5-MRgA:9 a=QEXdDO2ut3YA:10
 a=8vIIu0IPYQVSORyX1RVL:22 a=UmAUUZEt6-oIqEbegvw9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=889
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180108

On Fri, Jul 18, 2025 at 7:25=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 7/18/2025 6:47 AM, Nithyanantham Paramasivam wrote:
> > On Fri, Jul 18, 2025 at 7:01=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.co=
m> wrote:
> >>
> >>
> >> Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>=
 wrote:
> >>> On Fri, Jul 18, 2025 at 2:45=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.=
com> wrote:
> >>>>
> >>>>> @@ -578,6 +579,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_=
base *ab,
> >>>>>         struct ath12k *ar;
> >>>>>         struct sk_buff *msdu =3D desc_params->skb;
> >>>>>         s32 noise_floor;
> >>>>> +       struct ieee80211_tx_status status =3D { 0 };
> >>>>
> >>>> With '=3D {}', no matter how the struct changes, you don't need to c=
hange the
> >>>> code accordingly.
> >>>>
> >>>
> >>> Both =3D{} and =3D {0} achieve the same result, right?
> >>
> >> Yes.
> >>
> >> However, in some cases, it might cause compiler error. But I forgot th=
e cases,
> >> even I can't reproduce the error now. Sorry for the noise.
> >>
> > No worries at all. If you happen to recall the scenario later, I=E2=80=
=99d be
> > curious to know. For now, since we have been following the same style,
> > we'll continue with it.
> >
>
> {} is preferable to { 0 } since the 2nd one causes a compilation failure =
if
> the first member of the struct is not a scalar

Thanks for the clarification! I=E2=80=99ll follow the same approach going
forward. I=E2=80=99ll make the change and update the code accordingly.

