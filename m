Return-Path: <linux-wireless+bounces-25662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC1B0A588
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A350A4329D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445631624DF;
	Fri, 18 Jul 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mVqbaKZ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F995EEBB
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846456; cv=none; b=Vfl+eQIjOtjZYfIq0j11fChsK6lOZ33Q0tez/UylOEUOfK2Iz7H2n7nfLwla1kxD5451xIYpILACvq0KrmpC3VpSrQbTaYavX0BrO7SCnoxNnhBLZ5MGOwX8oMgeC0oXElJ0bT/9S0yWFBhhIN2ahtqsxZRgHIuexHW+uL+E7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846456; c=relaxed/simple;
	bh=4o1padaevOu7Gv+BM53sALu69Bv1EFhwzRDIvBx7XFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGsdVEkISIX8fVfrxbq/RFhmNXXHTpNdJ75xJhQ9sfRA7Vq4Mn5n6T5NE33wLm8Zr4CXT6NJgTCcfyjQKkn+xxqvEau6GXAPMDZdwjYySBT8FoCP3kutzQG+f9dNz7UPcf0W+HQrBiVAh4rdDLi5kmkuE81qnDC5D0TDfUT0mGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mVqbaKZ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7nbQR032365
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tbI8J9O2+zxZL8NR2oitBmHDfKTt1IwVAj4U/Nrlyzk=; b=mVqbaKZ1ipzzY3Jv
	5NMpT38Iyq4biEpM4N0pmaBwUtM/zL+pNYF7oAF+CPruDCPiuMnef+ufs1o90jTc
	nMoZJItAEXUSw4NBHh8KFcICzwvUqOL5gOakpSqax7tg09T6JtQE85JdnIQwVbyn
	+wSl/PHY8jnswteCcI4QPBcrl1CYkFyx0OFKTI1a4zWNz1+ithOozkFDekO1PI4Y
	PYMdraqj9fbUJ7kNQ8325twUiRz6egoqOIHCZxnzVzWsFrBZsMMdVIqG8fKO3zOk
	Qt36LIjXEXrsxBBeMa+T8G+S5rN1nhwpl/6Y5eh9E/FNik9bS57ENfKw8F8HMH7o
	9JNa+g==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38bwjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:47:33 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e055be2288so18482605ab.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752846452; x=1753451252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbI8J9O2+zxZL8NR2oitBmHDfKTt1IwVAj4U/Nrlyzk=;
        b=JKR5hHgJSBzA7WvfLQVZHRt6jb8OqZ6Qg/uELWiEem29OopjpwONSry5n28zfxQFPR
         vDH+qVG6VrSuRDuHqFFRO9KCFGXGU95FcvMputnK7DCr/HN6S0OHMBVbbAOUcbBZKvQu
         mwQYVQSAIrkOBNaAkSG5OcGjqQD0qBVDwMXRkRZ23TvOV0+rjVEhtjQxssws99Vycf9c
         6dKlTrDSgBTZxf9IrsqlFHUKKlJpNxsv616HUqvPUlPhc7v32fnW0eCox/XwTG6tpOnp
         3y7nRR2NYZiW/9YFd9SWkkNp6SVIh9WLCkaj8Vq/Hmc75WOD4kYgpEbYhr+9/TKJliBN
         cPxw==
X-Forwarded-Encrypted: i=1; AJvYcCUP5j82uleJHTfLzfI+2f28wh3hna4yTLcye/AkgvZ2WkOZhPk9y2/LeQaWxj9n97spOpclySH5gFGT+2kHPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72rk5NMKdnIDfQ/b/26nkvrJLpnOstglYveCB7+s4h8O3neo7
	QmnQKuf2bl4jDUKXwXE3trA1BxBDDg8ZwDuXBYhfbdr/Z5+ONZhqTOL2xu6xSm1MFrSuMoSjaHb
	EJYvWu/GdvfGCv0dgJFo14rhEUtl1BWKOB/R0tfzLrBR7kfNfITenom4fMrK3whMKbXUOMZfA9t
	PRFBktJO75kZVoqXMVRKJwa9zEJ1DmxyqvSumVA/aX1VHc
X-Gm-Gg: ASbGncuyrnamiE7c1z5G2TOiJYWCmIXvOofOruBH0zRV+FKsUtg8MdctVeu+RmUsm/Z
	nSDM3x0Otsxy3IEIbFSbNByBfySrakd2dzHndKGVZinP53zzB3JndVwODjL9OP2VTnOmBtApsJd
	nskFIUODrYbPNzMDHOjArWRg==
X-Received: by 2002:a05:6e02:3045:b0:3e2:9715:df3e with SMTP id e9e14a558f8ab-3e29715dfd6mr32977455ab.18.1752846452133;
        Fri, 18 Jul 2025 06:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9bxuew9zb97voGVI4MzPe+RL+B5AtQ3WNBvMb6CeyMPwOseiKljnYhL+hrMygO9s5udjn7YslrryOk8B9I6s=
X-Received: by 2002:a05:6e02:3045:b0:3e2:9715:df3e with SMTP id
 e9e14a558f8ab-3e29715dfd6mr32977105ab.18.1752846451734; Fri, 18 Jul 2025
 06:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-3-nithyanantham.paramasivam@oss.qualcomm.com>
 <1ae4000edd954cf492e95bdb059c89b2@realtek.com> <CAD1Z1JK1wnCTeObYAHALkxDVFm0kx=7r4urtA4S0XorLNOPKfg@mail.gmail.com>
 <7859082aeea642e2a3fa3a2829404b55@realtek.com>
In-Reply-To: <7859082aeea642e2a3fa3a2829404b55@realtek.com>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:17:20 +0530
X-Gm-Features: Ac12FXxzO3FU6wVNQeBYlfveatpj4wyfZ3x4hv19i9wYyAGTdHHgNpo9947r-9I
Message-ID: <CAD1Z1J+M2342-fsyc--MB+K4cd16v-csMKd38Vjm4FSdvatEnQ@mail.gmail.com>
Subject: Re: [PATCH ath-next v2 2/3] wifi: ath12k: Fix TX status reporting to
 mac80211 when offload is enabled
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEwNiBTYWx0ZWRfX5S9zdw5J8aqM
 vvzHZZmwefAPGLmsVnXvgqnJHiBoO/Yevhb0iIZbchtRbJO969xk0AIq36G1ENEDHFHGs5EEGtC
 ymcNg+fQBShJ4JUFB2E3WW85MSOFa8OT/l/sYyfcs47fnZLYYTCnz1H+z+Bo4vJoQBbNY9fjhNR
 NCETcBAkAymEgJf57oKmJ64tJkl8XO4f8Ep7D2BHlhBzuPUkjKXjYBYF43DIkHmpbMbm1AL1DkT
 HYNLkFwpW/4MxFiLoUoxl/2WOq2frg265KA7clnX/nN2mdLmTwfYef8WrIFkbEg0GvbCcx3cZal
 QwRcPV0sxkmL1PKspcOB9ABVgvYu0eeano355zpVw8K0UkGntfbj6ouZnWFxoMtOeXvzcCDLiH4
 Hlwi0ptqu7R8yCCg5E8AUBocAuaO57LUeDiHmN4Hn1CJoEYoRqI5BikTksE9UvhcQgCEHQ6m
X-Proofpoint-GUID: KqAMjadyFKA1A4DjMzbnCQhA2zhiEDzZ
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687a5075 cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=n9Sqmae0AAAA:8 a=EUspDBNiAAAA:8 a=JM9kfKmArtAwmz2DbJ4A:9 a=QEXdDO2ut3YA:10
 a=Ti5FldxQo0BAkOmdeC3H:22 a=UmAUUZEt6-oIqEbegvw9:22
X-Proofpoint-ORIG-GUID: KqAMjadyFKA1A4DjMzbnCQhA2zhiEDzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=871 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180106

On Fri, Jul 18, 2025 at 7:01=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
>
> Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com> wr=
ote:
> > On Fri, Jul 18, 2025 at 2:45=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.co=
m> wrote:
> > >
> > > > @@ -578,6 +579,8 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_=
base *ab,
> > > >         struct ath12k *ar;
> > > >         struct sk_buff *msdu =3D desc_params->skb;
> > > >         s32 noise_floor;
> > > > +       struct ieee80211_tx_status status =3D { 0 };
> > >
> > > With '=3D {}', no matter how the struct changes, you don't need to ch=
ange the
> > > code accordingly.
> > >
> >
> > Both =3D{} and =3D {0} achieve the same result, right?
>
> Yes.
>
> However, in some cases, it might cause compiler error. But I forgot the c=
ases,
> even I can't reproduce the error now. Sorry for the noise.
>
No worries at all. If you happen to recall the scenario later, I=E2=80=99d =
be
curious to know. For now, since we have been following the same style,
we'll continue with it.

