Return-Path: <linux-wireless+bounces-26970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F9B4190C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC56D1B27F80
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1730B2DF132;
	Wed,  3 Sep 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEXojOp+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384432E54BC
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889313; cv=none; b=LT69+VurZ7QSS+whYiiJ+tp2JjkXTyyREkVUsTkXbIe0fZiWbL93SQC3UTZt2hhfxhwkUL56LLDqrCh+VJnrAnVptpmZBjKKoQuaFqeqzDqgTXlpOa0ddmgQZgutDThJLP2gAKPtULmff5COADjMaE7Um/eSKXBtzzu7q1Iq+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889313; c=relaxed/simple;
	bh=Ck657YA7VnrrDrw0widxylX1jGvD+PUt1Ru5Ny4iJi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQHwnAkumbRvSMPQOSA7AWebb2pVClr1FvazPv1K74M8+qV17drzGyf3+ciG4fBQnty33vf+8/qP8/duhA3doOaO0hQBPNxNWku7y/hTJGB653vuYTWDp2b4k2nD9la2TFUvegWlBgLCVEfmX7bfRoU9wVFAKMxmrD6VTftKziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEXojOp+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58324SlR032759
	for <linux-wireless@vger.kernel.org>; Wed, 3 Sep 2025 08:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ck657YA7VnrrDrw0widxylX1jGvD+PUt1Ru5Ny4iJi8=; b=dEXojOp+KMc3J+sK
	lXaNjHu1zy4/1nadzQ87+459FGZdbmI749rljhPV+OYKIMLXNWXYiSkp4TlZxFlc
	wQNj1kUK5pSa0Ibpb4G9vo1M3UHbW1NijL/rLyGXGw0DazMPwSN2i0/aYK/fMoSv
	wpt6J4daLxCaH60MO7yOO5qr2Lh3fSHUIBK3sX5JZ3uqcOj9360+U877fSOtca5S
	KqWt7GRCaL6oKYmcnarMPyVyExLULNwbWeY+I6BsheYtIspHrgF6GUh8AbE6KmXB
	jL9RFCyeYp+6w+q3TguTbLUAYqZMOfbRLzuEIiJKTCScofMfR8BRoM8ygFUEhmfo
	ipZX4A==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8tv1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 08:48:29 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ec4acb4b61so66116465ab.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Sep 2025 01:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889309; x=1757494109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck657YA7VnrrDrw0widxylX1jGvD+PUt1Ru5Ny4iJi8=;
        b=vjOIZ/ZWOeLles03BT8uITrDOwIgfeTuOzpv/s7l/rmSnUz9JuO8kPDbElFRkzagsP
         djbeR+2chey0W9DOk9qNJ4oWb0rHUy/dJIPPp8rLp4ROrWCC6af4rAiRpe1T3qNc9/yQ
         zPQOMsCNUV6qfn0Wte+nmniwe4aAYFFlH8S5P8igQQFl3e9UHPtG7WUo7cdY86eatzV7
         kChQVMQ539MZz7YmqW88IReyB6+fh+eei2u9dogrPtOwU8zRd4uxkuEATJibXbdAmtRK
         XtS1v0DbZ3feVCVN8T76WUWTYQ/c6Eg1Lri+47GeTIOb45HLnSMto7MG5JRP082UAq1U
         ht7g==
X-Forwarded-Encrypted: i=1; AJvYcCX3Mu8KYjaNbldT0XYYhZzpb9yMf1MDkwOsDhibCObz34T+f7tr22GSVgTL8YQLmD16HpWqWhaJcIZiTgenaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywixn/qAvFSKKhCyUPYXCD1OvPmJA0HQDnOP+l2qCq3LTYym2iC
	mchiW5kaN69LQrtG2LAVSCF5lWAaxPbG/Ea2K71p4k22DlG5Q8HUbaBMaD5oSWypMJNhwyJJXy+
	OlAtQocjkjvGYf7YAHOVw1dvxdR4cdYoFXb2FVZD6DD/3O0xNPm8Nwo9AxcDhOcyWWa8ejDlzqd
	JQvwspvEAITjjvRlPKFJ+f2HB2SIOl+EaxBM23nmtEbJg1
X-Gm-Gg: ASbGncsVjr5BynugrkiOYQU3x/14S9i6FBhkI+bs3n8j5K87jyHbg18xIhFhHZmwumC
	S+/WpSTXHg0rkl2cDv4vZ93D/IOArle0U4MRt97Zy30n8ZBl6WzpKLpOvhm8SzXs9pFVLXQ7BhM
	+ryPqC6ZuwJn1s4n37aYnk/LI=
X-Received: by 2002:a05:6e02:17c9:b0:3f0:2859:4782 with SMTP id e9e14a558f8ab-3f4019f8d2dmr248147635ab.16.1756889308761;
        Wed, 03 Sep 2025 01:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK8j1SCoAdCYKhVwI74VBTy2xMD5jOKSwWbgpF+H0zajn/bL4koFQMxWAEXOqS0zCusYs8tMnsBGWrTpA0Ft0=
X-Received: by 2002:a05:6e02:17c9:b0:3f0:2859:4782 with SMTP id
 e9e14a558f8ab-3f4019f8d2dmr248147495ab.16.1756889308403; Wed, 03 Sep 2025
 01:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822050204.476919-1-quic_sarishar@quicinc.com>
 <6f1207c84db7663c646f0b1211ab7894c53f397e.camel@sipsolutions.net> <CAD1Z1J+3Gvj_zt0C2OE9ksLzxB823gJsheWu1kQXxOukCsCgGg@mail.gmail.com>
In-Reply-To: <CAD1Z1J+3Gvj_zt0C2OE9ksLzxB823gJsheWu1kQXxOukCsCgGg@mail.gmail.com>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:18:17 +0530
X-Gm-Features: Ac12FXygd5AR7wes-sCjTdNynilZE0AqnFqUXDlt7-x69vKF7J09LYW-x_IL0mM
Message-ID: <CAD1Z1JL4z9G9rfAO_Cz5opH3+gtsxbKLQP=R5FesSRtC9Pwsvg@mail.gmail.com>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: Increase netlink buffer
 size to 4096 bytes in nl80211_get_station()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sarika Sharma <quic_sarishar@quicinc.com>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Mm9nvLgY3vY6BKocymRfuON9unfwYI_L
X-Proofpoint-GUID: Mm9nvLgY3vY6BKocymRfuON9unfwYI_L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX1DqeW4X597cp
 KeBc4iq16ui9JAekd1b1uGUcCGO1mU3naEV2CH5Ed6PTEb6o6fwqTQZcC1yFf625vsu8c48Z9Dg
 caUEQgFYuWsnweJRArEF716g2L6DGTjR2mSjGkAeu3TMUVSjgd8Iu10jbbnHTWBWwb6OUVPN4qC
 jz+MMmNyDTT0FZE5zJsNNyl84djq5Kg0RouqN6Y9wZP9FzrQlKBoIXO0ZmlGwuZQhOBgkiWn3bM
 95eJcDyEs+pzYK/kjWm4f9Zn89LtTP9E3pEUaTUNLchIg21w3vloTlBq90tIeEZgtM4dwjztYNJ
 N+A/vK60ROFrWp8OrHAcThnoNi9VDKhWfvzv0Ei2yOih3bWe8MmBaNsWxR5MZloQb+uOTFTgvU4
 0P/PWUgw
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b800dd cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=COk6AnOGAAAA:8 a=D7wbb5NDfiHIq8zT8j4A:9
 a=QEXdDO2ut3YA:10 a=Ti5FldxQo0BAkOmdeC3H:22 a=pIW3pCRaVxJDc-hWtpF8:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Hi Johannes,

We=E2=80=99re encountering some challenges with memory size when including
per-link information. The size of per-link info or accumulated station
statistics is exceeding 3 KB, and with a station having 3
links(example), the total memory usage becomes approximately (3(link
info) + 1(accumulated station stats)) =C3=97 3 KB, i.e., around 12 KB .

Approaches we=E2=80=99ve considered:

Dynamically calculating nlmsg size for all link info
=E2=80=93 This introduces a lot of additional code complexity.

Allocating one page (4 KB) per link
=E2=80=93 If multiple links are configured, this could result in significan=
t
memory usage.
=E2=80=93 It=E2=80=99s also unclear how user space would handle such alloca=
tions efficiently.

Given these constraints, I=E2=80=99m planning to explore message
fragmentation, though it may not be trivial and could take time to
implement.

For now, I will modify the code to return only the accumulated station
statistics, excluding per-link stats, when executing the iw station
get <mac_addr> command.

Best Regards,
Nithy.

On Thu, Aug 28, 2025 at 4:23=E2=80=AFPM Nithyanantham Paramasivam
<nithyanantham.paramasivam@oss.qualcomm.com> wrote:
>
> On Mon, Aug 25, 2025 at 1:41=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> >
> > On Fri, 2025-08-22 at 10:32 +0530, Sarika Sharma wrote:
> > > Currently, the buffer size allocated for the get_station command in
> > > nl80211_get_station is NLMSG_DEFAULT_SIZE, which, in some cases, is
> > > insufficient to send complete output to user space and results in
> > > "no buffer space available" error. This is especially evident in
> > > setups with 3 links, where the amount of station info exceeds the
> > > default allocation, leading to underflows and incomplete netlink
> > > messages.
> > >
> > > To fix this, increase the buffer size to 4096 bytes. This ensures
> > > that the nl80211_get_station() command can return complete station
> > > information for up to 3 links without allocation failure.
> > >
> > > Fixes: 82d7f841d9bd ("wifi: cfg80211: extend to embed link level stat=
istics in NL message")
> > > Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> > > ---
> > > While this static increase is a practical short-term solution
> >
> > We haven't released this code, so we don't really need a short-term
> > solution? We could even just disable it from 6.17 instead.
> >
> > So please let's see how big a real fix would be, or maybe we revert
> > 82d7f841d9bd in 6.17 and do some other fixes for 6.18?
> >
> > johannes
> >
>
> Sure Johanes. Will allow user space to optionally request link-level stat=
istics.
> If this option is provided, we calculate the maximum message size and inc=
lude
> link-specific stats along with the existing station information. Otherwis=
e,
> we use the standard message size to return only the default accumulated
> station stats.
>
> Best Regards,
> Nithy.

