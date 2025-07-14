Return-Path: <linux-wireless+bounces-25366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB7B03DB0
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 13:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90153B7BEA
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC21FE44A;
	Mon, 14 Jul 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+IEkhgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F5A920
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493770; cv=none; b=Y6Z36hjROZHrN8oTFVFH+Eadgzpktj1g/j/LSPzcdFC1wXRU/O4ZL0UGcp7wouO+jsvITSNxfsVJ3qYtE3cfu96+SGppaorIq44y2K+Nti8VvnOKGWgn0RXEWSl+AqVbVxQrnir11ki7X87ZZo8KrmhCDraOl7i7lZaXk+XDWqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493770; c=relaxed/simple;
	bh=762dgiKgGCeFr7YJ4sOKACyysED2j7yfXsFzGSPz7ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7tiDTCO8w+4kVdmqW6DApAaeFztDWeDX9CU20aeuRrvjf1ETQEOJvopUE6Xisjp5pxt+A4mcYC2rYcEqkH+jjLbArlv0DyrHagnTVxJxb+uG8ATyPVX0xiBzlhDAuh0L3vm2UPZEVKWN2gPc2y24uBDKhYDLPxDYUgnxFegZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+IEkhgK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9sPtq032437
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 11:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PeCnV8o1cw5CZOJDzCZLL2KiKxjXkdRAPAHn9BVtwxM=; b=J+IEkhgKCBmSZG5g
	F1e9H49qZ8pxiU3WK5DSpkric1oLAtFhPTT1QBS3Vj6EydoaNKeb7m+hZ4+C9oMA
	5+niFmHPjeX7zD4I87IxJBu8WOP4AK7HInPOGeT+DiiN3L1a9ek5r/Atvcc4JFv6
	2CSohAA1kZzNM6Wu84qbmfm6fOeObNJ7xgcphExy21/aFRIo0wOilYAMeaZg8cZJ
	g7FC/ololKuToAzea5cLt0t5dNpUPFBojsecSlYDMI33l7UqL/zNkW8b1ppH0ZAK
	anlw1wlN8OZSYShRDvNVFk2rux26hLWoCAZqGG/RsnvlNM55imt1YKABEGZ0h5en
	Xjbesw==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut4ggy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 11:49:28 +0000 (GMT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87313ccba79so850608439f.2
        for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 04:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752493767; x=1753098567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeCnV8o1cw5CZOJDzCZLL2KiKxjXkdRAPAHn9BVtwxM=;
        b=DunPZJ/LtTp64qulMXvqUytyXgiaDXk3PKkJ2dFOTLuySVUzvU6pX/TNSmFJGVuQwu
         6zIYnjx2ayUUiZM60NpA5q0nYRKhab0owobYBwvFwcEH69s95jDM3OVMOGFUI7cbMMDV
         uNRgmqV3mFlM8iuZzfzlLwTB6fyyaA1tWg1i8PyoU8XPSV/XDPSqBqZaB9z5etv3BokB
         YlwOrftavWBolpyas93gNPkY/xx93owZJptLNKrnSeYNhf4R/GQCF4u4W75z6smM/02j
         oZI7azA0pLpFgemNsyI1jTV/0SpgQjN2/ymcfLH0Omtvg+LcCRQtqmaiOHLMI+A/C3F8
         laIw==
X-Forwarded-Encrypted: i=1; AJvYcCUXRcOEP/yi1T22skNW1aqP9C7UoQOuv1RmE+JqUGxgMgWexUUlhQglit3TUjNiwfQkNLc8fkRCXnBjphmwig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC49NXZwDidIBdwhEcFSQgE2LjCuOHcGZ3YU7LBM9mL+/mUblW
	sQwS2EiEgaJWW3elwGh90YDPXYSLR43//DY3iPnThJJyT+Rt1GTTK9daB0yX1hLi/7kf0hYwvWc
	Sevd1pPtG4j6Mb1qMdc9fhMAVScGwT81cJzsKL5h7oNKlPFK0wygicPco+rl/d5z8QBkdjnB45X
	vRC+oWFhtFIa84rWDy3LG9fS0ExM5hlktXfS6JFuJUIIdx
X-Gm-Gg: ASbGncuOW/bm7WiJm4Edddo+i6n0pPw8VCCW54PV+hZLFlLhjSoKn+iosYANdoSaNN+
	cNshZ7clV+w28lmFEL+nrIlisRPVCxjpk9ZH8JvK9wAAx6ej/JYjzzIPOXZmc7UPRxxvu7ENpWD
	xFDoHraTsIi7oz0qbcOnDBDg==
X-Received: by 2002:a05:6602:15c9:b0:86c:f9f4:6aa6 with SMTP id ca18e2360f4ac-879787d8f28mr1373885939f.7.1752493767178;
        Mon, 14 Jul 2025 04:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNrH9zKX43Z0vkUhygJB2rLeONNRWt7aoBZR6C5VsAXe2iQVrajw8qTIwkRGU+r3XF4EmSGwl0toJbZ6F6rCs=
X-Received: by 2002:a05:6602:15c9:b0:86c:f9f4:6aa6 with SMTP id
 ca18e2360f4ac-879787d8f28mr1373883939f.7.1752493766685; Mon, 14 Jul 2025
 04:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313020154.4066212-1-quic_nithp@quicinc.com>
 <6ea8710e-7171-42ad-b1b1-5fe679dd19d6@oss.qualcomm.com> <f0fc942c9a038e4dc78df7ac4c93f805f70046d3.camel@sipsolutions.net>
 <LV3PR02MB102094CE3FBE9B2C79D5CDA689954A@LV3PR02MB10209.namprd02.prod.outlook.com>
In-Reply-To: <LV3PR02MB102094CE3FBE9B2C79D5CDA689954A@LV3PR02MB10209.namprd02.prod.outlook.com>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 17:19:15 +0530
X-Gm-Features: Ac12FXxolCIKDD12OMKTDibNUzR0btQco_vAjLgPG3916jpQnU0gjD5xKtImhlc
Message-ID: <CAD1Z1JJEn_stTgF32x=s9YSBD_CUS3uozC4SV2ghw9a-8mf5cg@mail.gmail.com>
Subject: Re: FW: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211/ath12k:
 Enable monitor creation in NO_VIRTUAL_MONITOR mode when AP is active
To: "nithp@qti.qualcomm.com" <nithp@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=6874eec8 cx=c_pps
 a=WjJghted8nQMc6PJgwfwjA==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=NguHdVNy3_DW1cGeZzQA:9 a=QEXdDO2ut3YA:10 a=CtjknkDrmJZAHT7xvMyn:22
 a=pIW3pCRaVxJDc-hWtpF8:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cTVy3h1QEhC6E7QvFW-Xhm_laz6gL_hX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2OSBTYWx0ZWRfX1N17p5XbvCsX
 v0f6/Y4bQ3Pr8Q+qouHLsF+Giy6Dz709diOkYrtAkNtXfLvZODCbnkjrEx38uvpEKcNRUDsztJN
 I1cPZZZ/DN8GBxMIonvBspvIgCVonZlSs2UYkE90yDQJCzCbcPyUn8aWEELBsGnXNJYRC+z/qMY
 1ESxjThuO1KYe30qHjS8x5M6Wg8YltoWSZT82tR43SFLYr1iAMgjM3MbirxKO9DHIxYehbLP6dw
 bc2heNrH/FAXHq/qn2MdlX9ukTRLCgyCQhOQjpw6fbN5bunUoXpJtFK9KeyBTMC/PRzGe/yjMVy
 Z4c3rtDPXlxIkyT+v/Tltk4RXnBqer8VEbhnyLdU97khBTUEJi3x+7Af0z8bU/0IFAcxSKhRt3O
 XJ1+ljNRrlnAHA2T41dZb3B2k9JJlKeot69jJbkZqcR/Ut95XVZbQWbM83vMytfm7D8EeD0L
X-Proofpoint-ORIG-GUID: cTVy3h1QEhC6E7QvFW-Xhm_laz6gL_hX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140069

On Mon, Jul 14, 2025 at 4:59=E2=80=AFPM nithp@qti.qualcomm.com
<nithp@qti.qualcomm.com> wrote:
>
>
>
> -----Original Message-----
> From: Johannes Berg <johannes@sipsolutions.net>
> Sent: Tuesday, July 8, 2025 5:46 PM
> To: jeff.johnson@oss.qualcomm.com; Nithyanantham Paramasivam (QUIC) <quic=
_nithp@quicinc.com>
> Cc: linux-wireless@vger.kernel.org; nbd@nbd.name
> Subject: Re: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211/ath12k:=
 Enable monitor creation in NO_VIRTUAL_MONITOR mode when AP is active
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>
> Hi,
>
> Sorry, I keep starting to look at this, and then confuse myself, and coul=
dn't seem to offer coherent thoughts so far. I'm still not sure I can, so I=
'll just offer possibly incoherent ones instead now ;-)
>
> > > Please share your thoughts on the following query
> > >
> > > In the virtual monitor mode design, only a single monitor interface
> > > per radio was supported and subsquent monitor creation shares the
> > > same vif. However, in NO_VIRTUAL_MONITOR mode(multi-wiphy scenario),
> > > there is no limitation on the number of interfaces that can be
> > > created (due to separate SDATA for each interface) and notified to th=
e driver.
> > > For example, the ath driver can handle up to 16 interfaces per radio.
> > > Should we impose any limitations in cfg80211/mac80211 ?
>
> I think that question really should be if you _want_ to? I already feld t=
hat the NO_VIRTUAL_MONITOR is a hack that goes away from what this had orig=
inally intended (which was allowing the creation of arbitrary monitor inter=
faces that may or may not be related to the operation of the HW), but I thi=
nk we just didn't find a good way to handle it otherwise in multi-radio sce=
narios.
>
> With the benefit of hindsight, I'd say that to best match the original be=
haviour,
>  * we wouldn't have NO_VIRTUAL_MONITOR,
>  * so you could create as many monitor interfaces as you'd like;
>  * each one would report frames (perhaps according to the radio mask
>    (3607798ad9bd ("wifi: cfg80211: add option for vif allowed radios")))
>    rather than filtering by the _channel_ set on it;
>  * you'd be able to set the channel on a monitor only within its radio
>     mask and if the radio needed for the channel was actually free.
>
> This would require tracking things more in mac80211, possibly creating a =
virtual monitor interface per radio. I don't remember if I thought it too c=
omplex, or Felix did? I briefly tried reading through the old RFC and PATCH=
 postings but not much answer there.
>
> Do we want that? It seems no. All the "coordinate multiple monitor interf=
aces in the kernel" seems to be a fringe use case nobody with a voice reall=
y cared about, or they're not using the latest versions yet.
> I still think it's somehow technically nicer since you don't have to sync=
 things in userspace, but if nobody cares why have it...
>
>
> However, in some way this would seem to move us further away from such an=
 ideal state, so it seems almost like we should then cover monitor interfac=
es by the (per-radio) interface combinations instead of continuing to prete=
nd they're virtual constructs? Even with the NO_VIRTUAL_MONITOR we were alr=
eady at a point where
>
>         /* mac80211 always supports monitor */
>         hw->wiphy->interface_modes |=3D BIT(NL80211_IFTYPE_MONITOR);
>         hw->wiphy->software_iftypes |=3D BIT(NL80211_IFTYPE_MONITOR);
>
> didn't _actually_ make sense.
>
> So I think it's probably time to remove that if NO_VIRTUAL_MONITOR is set=
, and then cover it by the interface combinations. That way, maybe instead =
of adding WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF (and that name ...=
 super long) we can check in cfg80211 if monitor is a software iftype, and =
if _not_ then just let it go through since we assume that the lower layer w=
ill check the interface combinations?
>
> Or actually improve mac80211 to the point where we can do what I outlined=
 above?
>
> As it stands, this seems a bit half-cooked?
>
> johannes

Thanks, Johannes, for the detailed explanation. Since adopting virtual
monitor mode would require substantial changes in mac80211, we'll
proceed with the NO_MONITOR_MODE approach and aim to address the gaps
by considering all relevant scenarios. Sure, I'll treat the monitor
interface as a non-software interface type and rely on the interface
combination checks for validation.

