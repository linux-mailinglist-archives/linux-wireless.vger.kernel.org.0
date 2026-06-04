Return-Path: <linux-wireless+bounces-37391-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w4E6KmqlIWpFKgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37391-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:18:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C83641C5B
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 18:18:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HRxdkiBO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QI14cLhj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37391-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37391-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 242183086DE8
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDF3CAA2F;
	Thu,  4 Jun 2026 16:08:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D938944D
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 16:08:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589311; cv=pass; b=r6Cr6Nyh3Xi2Bz610D+4i/m7qtByf++Be4Xe48uhqtCUEk77YScnZBSkY/3eNrohH121n1J2nykIgl6scg1PvuCMrY9QML5R5NvINMSGtvvKyX/EMF7wCXkmdsMJklTgC8jjCsH1Ky/VvZj2lQH6gwqvMPgZNiMVCOIuSnCBa24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589311; c=relaxed/simple;
	bh=F5aSe5/rVsD1+PJg88IQixfP/b4SM6pfkcIFjxWHeUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SECP9WBi5HoNLh8Jz8lXaNYHmjdZ7g23oSjORMDni/aJLuw9W+n1B0/RiB06PVblQAVPqKArp/3p0ohW0ODnJdrThtOjyehnxoCEDVgnPrOvDxDMybdpn8HfPZyEfMOwBItGI8UMmGSQv2K0UOkLpH5hzlJ89iR4jXE+hbLlJbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRxdkiBO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QI14cLhj; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654BKncb012181
	for <linux-wireless@vger.kernel.org>; Thu, 4 Jun 2026 16:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GpXU9rHT8+UFBaNoZ2BGKTBAl9Pj+wMZ9zoeF3dSL7U=; b=HRxdkiBOaznYxwEo
	Aiwq7yMT5tqRcaXELABWont6egOw6V8Q8LXxo7dYKZxEc3sNVZv01DMx5Anr2V/e
	2QJj6wH/bD9Mg8bwMYAm9MTBmxI/cadATtYNhpawX3ndGkV35UKbBNTpNuFFQZLO
	TKyznOPD1zFsZe6EC1SP/42Uk8cXFyiDwJJp8pbmQle/h9u+gA77zg2/eURB6qKi
	zVX53z4If6sWpRQHL+RXdgriCvJ5pP29uxReVn0Wv/ds26K2QGB/BZfnaF/aGxJq
	N3/qZ5B1seRznOEqHvYFRlY0yGs2VIdxPTEu5QhWItGi5pIKpnTVZFiwOPEupMIF
	BlSHBA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8dc19wh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 16:08:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304d8f6373eso90109eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 09:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780589307; cv=none;
        d=google.com; s=arc-20240605;
        b=gUPP2HsTCjcemUXnhf4UBLSaKf+4FoF/dBy7WKJO7VwH9PmeHH+gJdO7zikoATexlh
         9Ur0+5Kgppud8nDSzLN5Rg9o/As74p9WHv1lCR2isUolLFZFIMFOzhFS3wkBk1Ov1rXG
         VAkU9KnsLdvSv8wi2zFi03Zho6CN7czH5XhpLaYPSEn2GNB5awLiNv5hShchJtyFeXAe
         bwPagxTixxoNiZ4YW5NewSLeQ7jT7EiZtyq9tJyoPm4fIZvU3NyXdBIfMeXntl3u0th8
         YpDcBysmisM492pmdT8pWXJn8Lz2QsZDekex91tZNGy1jZOj18YSw8+sIgPi6nefMx0Y
         ILYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GpXU9rHT8+UFBaNoZ2BGKTBAl9Pj+wMZ9zoeF3dSL7U=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=cfYWOSCy5b4urIphIl+YAOFI7XyBQypdO/lfttK7HH5ZTn7wd+i5W9P7i3/LO79/Zj
         5ul80jfP/vTiUCgQyGhsznHbrmpmBfKc2rKQEDUmUWCygiJPDX11Ysu2Mmj7sYpt5XPX
         /IoRUk9aqJkCSB9qTEjwfEd7koWsNcFaKV1xj3q9vnpsv1S+lDr4aS4kX6vbIUYcoC9H
         ZWA0jK15L9wt9vTzdAB25p9BVd1r6Vx92POyEUdf2VWNr55Ylbyz3CMhxMMDge9e3pnY
         IBd+MADem3KDEkHQqPJB9m+4Aga5awUGFVZK8WZtseuYzjD9XXgC9wTntrHEjDgNyFR+
         JIdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780589307; x=1781194107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpXU9rHT8+UFBaNoZ2BGKTBAl9Pj+wMZ9zoeF3dSL7U=;
        b=QI14cLhjLcuoeUNR/4z3A5z0SnsDx/RpJ4SS6GKrAFbyr4qWqSxjEqtC82w51BQQ9N
         /EOpivxH0Krrfhe6jXj2+cCeWg84ib0TPqE4baTlXO2hzjZJmtaaVYmkopbzQ9txx+dN
         ZJArblk7g9e1P/NH9+gCROgNggSahdwwiEr/v4tcnNLGOCpLdiFa5K7cEiBmbtIoE4ez
         gp4wlSSiz6wcujmsyjDpOTuW+F2l9X46VC82cgXrTknOu9vSEfUds0U6WNmfvLNjHrOy
         yAiDfr6W51SffqUAIqR4NdLgL0KZhYQGy0tRScvX7a9iysW3lwkzQhdeXbNTIo3JRbMR
         puZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589307; x=1781194107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpXU9rHT8+UFBaNoZ2BGKTBAl9Pj+wMZ9zoeF3dSL7U=;
        b=dguXNePWeu7EgcT3Tyb/soLsnYmPRtXvEVcmTmBhk6IDFaYcjRvtkaO6PNmjCv22e2
         wKOGKZfKsuVpoNzPyIWH94Oq4Rvm8BUpW03VtElE6yARsFVo4ruKiEF4fwMuvubPDVbz
         UqL17AWQx6wSwaCpSFenJTL/Sx1eHs5N/Tkj4NNJn6ru/eyoinyhxB8fkBKvaSsd9eso
         X8O66jSowjlaJAyjau64mJl0KZSO+1zlgope20yLJ1u3TqxoRBAVE4mtddbFVx7Iv1pR
         ib0O+7yND+3uxBKw+S0ftN41YowbEKEfoDwnV+BHmuNlpZ1/686C6qUFtzg0eC/Hzeql
         N8hg==
X-Gm-Message-State: AOJu0YxCgj2Edkum9lcfQk6h1mtoH1cCqIzIkWa+XY1fswzk6jUVy/TG
	zL13nAiIWUwmFudU4oKFrkmQoFmbT93ltSh6nG6DTs//E7B9MzaU1PtvHsNDwRW4CTjdTb6O/0+
	py1Wtm4fF+XrPxXNy/Es083bmFjhU0vd/Getv9NcG8JGyJpo7p2BRO4VLRzZ+XogkIe3jAWHA2L
	SsWOr4mlIyGWrFd4/xwxAZgXJ0bYLi7JJLV7eFPHteOc/th9pni7gQkaA=
X-Gm-Gg: Acq92OEpzXGaQhxyMoHUx3+jnts56ErzVBye0Uc8ih8zMcW4bKigvMTQEsD/iWRScjl
	zHN/rFngq6LBtXBsnhxkfRaVM1DiPFoxXr6W2FP90YYu6ADysOb32oyHDMx036qjIJYXnosiqmL
	p9u40cynw/vVBRhJFrdLjt42AvBrmzovYW/z9AWPcfMYq0NV/pc2jGqWPOmkfHv2sPbnfhFETq6
	8aTZXwBsZ7Yb0wbjSylzey5R4wYEdw/ifj7dqnF+QCIOgHiNA==
X-Received: by 2002:a05:693c:3b09:b0:2da:b05a:5a7d with SMTP id 5a478bee46e88-30777e4375amr8838eec.0.1780589306116;
        Thu, 04 Jun 2026 09:08:26 -0700 (PDT)
X-Received: by 2002:a05:693c:3b09:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-30777e4375amr8827eec.0.1780589305523; Thu, 04 Jun 2026 09:08:25
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516162900.1981500-1-tamizh.raja@oss.qualcomm.com>
 <20260516162900.1981500-4-tamizh.raja@oss.qualcomm.com> <3b3319752ce919b5e767fbc5be8c4b7916efe828.camel@sipsolutions.net>
In-Reply-To: <3b3319752ce919b5e767fbc5be8c4b7916efe828.camel@sipsolutions.net>
From: Tamizh Raja <tamizh.raja@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 21:38:13 +0530
X-Gm-Features: AVVi8Ce72jCUu5phCECIt9UNz9jzdWZkW1kDW1kFd5AN-BeMeZBhsLanUGA3_pU
Message-ID: <CABkEBKYzojf3P_eC++B_Sa_p1RwqyvXDsJ9NUpV28CKzNNnbnw@mail.gmail.com>
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: Add 802.3 multicast
 encapsulation offload support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: O8LF6G6HJ9gJrTfkSP4WUpg79o0PrtiK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1OCBTYWx0ZWRfXxY+s/rLkDEM8
 O4woBjJMgaLm38q4neKjNsoiG5IHIz4uJ/iV0zsKWbJaO678We/hnwNrJuKfTYqLrAu0VpKS7Ka
 YCAEn4HFhd7G0MG/ts2qPRLddKIF1Qi2YJK/Ha8E3Tz7YrlxkrosjYNjt/xu+E+JyLiUql276UK
 XRx+2Eeb7LsmL73g1H5ylDKjLyYJNBIEb+cwQtt+SE3SRkuw04oc6SeFKVwrUWo34dAbAqyZU6+
 cGvq6KmlZZlDdet5wSWh3l+F9TSVaKm0emdTLBuqrph5AEDgjyfqSYbx70z/N7LboiqjHgQ+pcS
 U0a8kO10ViMSuLgi5YlZO/hdxXwbwFkzv4o8uQb4jlhnxJ8Cj7ke6TGyWpeBwpDSuShJmm6h7S2
 k9X9FNOby7u5ABU2C9fqWINtJ13brOqShZpcjfTFGb4A25cpWUWgzgPk1jrtKNL6O/umV57YuX/
 nICUMMb2ke/xqKEd4Xg==
X-Authority-Analysis: v=2.4 cv=eJwjSnp1 c=1 sm=1 tr=0 ts=6a21a2fd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=stkexhm8AAAA:8 a=g0c9op-m76Zt8UTIqdkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: O8LF6G6HJ9gJrTfkSP4WUpg79o0PrtiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040158
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37391-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamizh.raja@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04C83641C5B

On Thu, Jun 4, 2026 at 4:28=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Sat, 2026-05-16 at 21:59 +0530, Tamizh Chelvam Raja wrote:
> > mac80211 currently converts 802.3 multicast packets to 802.11 format be=
fore
>
>
> that line got really long
>
Will fix this in the next version

> > @@ -4751,6 +4772,25 @@ static void __ieee80211_subif_start_xmit_8023(st=
ruct sk_buff *skb,
> >               goto out;
> >       }
> >
> > +     /*
> > +      * For station mode sta is valid even though dest address
> > +      * is multicast and that will be sent in eth mode only.
> > +      * So, add error check for sta pointer before choosing
> > +      * multicast offload path.
> > +      */
> > +     if (IS_ERR_OR_NULL(sta) &&
> > +         unlikely(ieee80211_check_mcast_offload(sdata, skb))) {
>
> That's not really a good way to write a comment ... it's describing the
> _change_, not the _state_. Also the code inside the if:
>

I=E2=80=99ll update the comment to describe the actual behavior instead of =
the
change rationale.

> > +             sta =3D NULL;
> > +             if (ieee80211_vif_get_num_mcast_if(sdata) <=3D 0) {
> > +                     /* No associated STAs - no need to send multicast=
 frames. */
> > +                     kfree_skb(skb);
> > +                     goto out;
> > +             }
> > +             link =3D &sdata->deflink;
> > +             key =3D rcu_dereference(link->default_multicast_key);
> > +             goto tx_offload;
> > +     }
>
> is clearly for AP mode, so I'm not really sure what you intended to say
> there.
>
You're right, this change is effectively handling multicast offload for AP =
mode.
I'll update the comment to reflect the actual behavior of this block.

> Also don't really like yet another goto in this function, especially
> with the ones that are there now, it's really confusing. There are only
> a few lines that can be in an else branch?
>
Sure, I will update it in the next version.

> johannes

Tamizh.

