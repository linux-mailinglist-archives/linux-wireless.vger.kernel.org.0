Return-Path: <linux-wireless+bounces-20667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542AA6BC31
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6313618991D5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D270810;
	Fri, 21 Mar 2025 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ4GNdwc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C742A94
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565298; cv=none; b=uJAiQnOxlbf/nJNYUKWV9TmEgd+kfHTv6o5hPJxHR8MxFc//tq2QMmc4SHSpCqKMAdT3XfETLYvCTMCmAJsNjwtPz7+MmEOInegXqDBJwIKTJgKH8tLPmFxLj6YkBtb+Jbb6rU8dLWghnxrXzYw02kqGb9jwVTU43iohKEIemxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565298; c=relaxed/simple;
	bh=fHxtT8gFvT4FKtxPn8fZtyxgXV8JxihMBGCsFvBv64k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trX114KdLB7zwPQwOHONSAnEKVZ2cWnWxZlDce5RqK0w4f2h48AwFzMd0PBMTqsuDochoYN7J3jeWITQR7SjMh1qeD5jUsScsUGXCvSZMsUNeTPiNc9xGGwnRoXtrsSeMTrIRQPmE1Jq62E86kWXFnDZXdNQc+HxRJxicT6SP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ4GNdwc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso182693166b.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742565295; x=1743170095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb2sejbtb68pqms6Kmyq53KuCFaYL00+nLToYQCj1ow=;
        b=IZ4GNdwchT99Oq0RAkrExQFzVaD94n5A+LTIl6406NSgInhhHj1LEJSDHPQocTKHVn
         qHfL76ca2jjmzWmaeWl5oig3pZp6i6Xzkwnox4nU82Upc05+3QlL2dtqx7NVljpEzi90
         ZzeLp6o2rZ0ZstWtgF7z+iqeDqcwX9uqTamVf/B/99XJMu85QaCiKi3XE0F6DjPTAcUB
         jQAnI7LIWE2ZKw4KFFYgZogGAmH8C9evqS9cvXvHW+pGP41LycK8eBhRJc48YFpImSUE
         LHMzHYWQiVUi815L7HPOEqbIqWhWGLItFP8zXQnvBNzO1WeDJWSf7SxueCnpNDafvuhD
         Qm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742565295; x=1743170095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb2sejbtb68pqms6Kmyq53KuCFaYL00+nLToYQCj1ow=;
        b=YKmAeKNMijQl3XuCRZ1HiEstGt7VPc+0cmtR+TyDmteS+whSHPEX088RPpyCctGWCW
         2vJGdf+nlLi8D5ZnV709pevnItfWzzLCHSPK27i+lBlo94tjHSXVfs7J7jfM2xoOkCZ3
         SujmaDi/sfkYsEP0q3gQ+Ds9wHojzMVd22E9eRgm8+kzClT3C89Yn38AtFpqT05KgVa6
         a8dBI9tb0EHMZT/sEm6rrriPUqdbrqBxwye+DfNsCmOY/PU8Jbu3aJI8P6/25BvDzDYw
         11Y47w8tbOnmIsz/P4RsXKfzqDwb6qABum+Ur2txv/ufho2qLsmarCX250wRGsomZgOF
         657w==
X-Gm-Message-State: AOJu0YwAvPmFGdojR6e1yuvN7vbptu8H7eHBZtkHFpEbqzRjyZTYQ9pq
	6l7xF5QdbLBeDmlMHYNk1rNyt4tJeFfgZ1XzDwk0ZLes4XUFu7lmTAzd9huFXc9pD51tlqGuElN
	ACaa8v1YwQYPVAmRdeB20FYNzU6z4Cg==
X-Gm-Gg: ASbGncv1kz2cuNCzB0cmyNxdZgNLUiy2KBxeLAhXLJ3gT3pnZU4ulwbBVV8H3coCcYT
	4xDXOFntAABgvU4d5OzhkF6NNgcPLuXBqNCGnkfjBNAPz2p0cyvRSQRG4y00ETTExMj4UzSRB10
	HVPtvAa+6ZuIU1UcRvelmqdivc9/Ii
X-Google-Smtp-Source: AGHT+IGHvSGQAyjlfJawf7AfLCRNackjS3mAzAI8MqBsjlCJNg+cwaJQqxw9UY08mtg08noqM+m+Z0yAXNdoNYwOlV4=
X-Received: by 2002:a17:907:e84c:b0:ac1:e5b1:86fb with SMTP id
 a640c23a62f3a-ac3f2100602mr378360866b.10.1742565294740; Fri, 21 Mar 2025
 06:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220074657.120288-1-janusz.dziedzic@gmail.com> <c5e627da-5822-4fc0-8575-431435add7f3@oss.qualcomm.com>
In-Reply-To: <c5e627da-5822-4fc0-8575-431435add7f3@oss.qualcomm.com>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Fri, 21 Mar 2025 14:54:43 +0100
X-Gm-Features: AQ5f1JqZ_oEDbgQ4oc_27Q9_fdg76btaJk3BTQ54Kl5doj4yDx66ZrtAXZBYjZg
Message-ID: <CAFED-jmQ=vEhB53pTTmgX2yx63ni=PEqzffpp_yFNfnRnP=ugg@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: report real HE length
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pt., 21 lut 2025 o 19:40 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
napisa=C5=82(a):
>
> On 2/19/2025 11:46 PM, Janusz Dziedzic wrote:
> > Report real length for:
> >  - supported HE-MCS and NSS set
> >  - PPE Thresholds
>
> Are there observable issues with the current code? If so, perhaps describ=
e
> them so that anybody with similar issues will be able to find this patch =
via a
> search engine?
>
Not critical one. Just found it in my app when parse nl80211 HE caps.

> Is a Fixes: tag warranted?
>
While not critical, no.

> >
> > Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
>
> Actual code LGTM,
> Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>
> > ---
> >  net/wireless/nl80211.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> > index 8bd09110d393..c0772e24cc2e 100644
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -1873,6 +1873,12 @@ nl80211_send_iftype_data(struct sk_buff *msg,
> >               return -ENOBUFS;
> >
> >       if (he_cap->has_he) {
> > +             u8 mcs_nss_size, ppe_thresh_size;
> > +
> > +             mcs_nss_size =3D ieee80211_he_mcs_nss_size(&he_cap->he_ca=
p_elem);
> > +             ppe_thresh_size =3D ieee80211_he_ppe_size(he_cap->ppe_thr=
es[0],
> > +                                     he_cap->he_cap_elem.phy_cap_info)=
;
> > +
> >               if (nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC,
> >                           sizeof(he_cap->he_cap_elem.mac_cap_info),
> >                           he_cap->he_cap_elem.mac_cap_info) ||
> > @@ -1880,10 +1886,9 @@ nl80211_send_iftype_data(struct sk_buff *msg,
> >                           sizeof(he_cap->he_cap_elem.phy_cap_info),
> >                           he_cap->he_cap_elem.phy_cap_info) ||
> >                   nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET,
> > -                         sizeof(he_cap->he_mcs_nss_supp),
> > -                         &he_cap->he_mcs_nss_supp) ||
> > +                         mcs_nss_size, &he_cap->he_mcs_nss_supp) ||
> >                   nla_put(msg, NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
> > -                         sizeof(he_cap->ppe_thres), he_cap->ppe_thres)=
)
> > +                         ppe_thresh_size, he_cap->ppe_thres))
> >                       return -ENOBUFS;
> >       }
> >
>


--=20
Janusz Dziedzic

