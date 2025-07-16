Return-Path: <linux-wireless+bounces-25554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C07B07E42
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 21:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD1B3A5ECA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A2C28853A;
	Wed, 16 Jul 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CfjliOAO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A429B20C
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694880; cv=none; b=b/oDpGGRITsxeFD3xQPi0WJqJaQNGz4JST0J+5TH0Bzr3l3Yme041VyLUGf3w4s9Ma3KUcScAEx70U/0GyNu/liLodtNLtHlUdn8n6Zoc0lf913uesqf5rPd7Rco/het5BOSU53kbxEAr5Sw6T11dKjZ6MZlKw+O2Mw0YIvXwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694880; c=relaxed/simple;
	bh=F+pokThyroEh4wA6nO/q9lUgWfwAgwA4isbxDAyY7OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5ObI5z/IVCbEbKCUkeIeF2Dhiyf/rClJwntmb0Jl6eLzzK8AKIRsO7MjgSTB09oNKxfQIfRgcigyi7fXGc0ljHSPaTQxLJ5M6Yvl+5W7Ce34IZiUDZ7NgWl5oyNx70idfFBB8Swy+ru2zr9T/TAuh4VZma/W97KkwwhereJrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CfjliOAO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2357c61cda7so2935ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752694878; x=1753299678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cBcxFpY+leZiSm2ZlkvHJhd+tn3lpuAd2BWjNqwWsU=;
        b=CfjliOAOHdTU7CryXIhN/TluDC6bJjwIAs2m3nOftmpZgJ4zAeX39tCn3Y8Fa/Ul80
         HW5cW3XBBqZ6xecW72zvwtd3H5WEAnRsFuyw1DJ5gzWjrLqbuFMKB4azuSmTCUPNBYBy
         PzlQALBIP5X3C/GWqkJQ/GwbOr8Adlx3Y8q+CxAIxoE4limX/ox0ztvbtRZ2InICvBUd
         cthpOay0xJGm5Cq+lIfbLHfryW+n1ErwQvy4FfR3IWxBGCBm2iGTVTz0AWIRtGvNN8oM
         qc3JJTc2x3YKsEL3VeJpi5B2x3ZyHi9mOBwpYSrw2mLsUd6S0zrshacm1ggEt8189Qml
         XPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694878; x=1753299678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cBcxFpY+leZiSm2ZlkvHJhd+tn3lpuAd2BWjNqwWsU=;
        b=mNcRCo/tJVMU2dRUGGjMlCaQI06nQKhD+TkGXtdzI2zEn9kyZu221V1EnMY50fd/1X
         z7lQyaIUlFwrtjuMj91MAoAgaTdfk5T/ap9apA2eD8rmxeJrNxkQ4fIXopkHFJ+wEH0K
         vNAlsyu+o9Ya0npdDdEfbOggQj/6LfM6x2xKuV/G+OrTm8Bm1IPIlwMxRtUBFRSu+rXD
         qkqYbVRegLcPB2ALu/iK+2UWPFVcrGOWiUAZ/CAr3I7TUDeC41zVXYnGscjJgXrqEf5J
         8L/SJLjXBvbZ17CNMzj86hW5T4IuCAwyBKvKZR6QtXw4Qe8bWUtq0uCudaQLHX9Wfgc0
         uFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYkR1pVQwO+GP2r9LyhG2sMTJN1xLaHOesUsjYsor0d+aCKBmRoSYXySTHr3jAFx1nGN6rq0JfzPk/6VpSMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrb3NJ1iS+S5q7zVETooUvBe/YgWB63KS9WbDvCMccZ6oGfRKz
	xZtLk75EPlGUd54nbGNLN2FGspIuYLRmIm8skbE21ya33h4y34UBptO4wDCtU3EWDh6sEpPTo6z
	CjYWztC/3lxiEVQiGsPU8Z1oLnEVIGA/ywmo2GWpW
X-Gm-Gg: ASbGncuUfLBe1vCVGU4qqJfRVPyeUxEWDF6VUwzR/phxSU6AiwMBkXjCB9yxvvZVMa4
	KYPgQDJN+IsMjYo6egHxIEOCZ6xbWHXD7fnnOIUOvfrInDac/Tu+5yCSBza+2rL4dLej9Lxy4cW
	fKG9H0JsADNaO5e8A9fBnh1IrjGTglu7i8RRblfQLHNvJjllRox0WJvQ5JrnO+RrMuA+3OfDXog
	ZwDpOEJ
X-Google-Smtp-Source: AGHT+IFyX+XCNjY83DoIYD6wz3oMr28OgEv5cSQ9ojCgkzsna4P0DmbzE8rFt2raxHhdvl1dI8tDi1DCHzWnQLePCe8=
X-Received: by 2002:a17:903:174e:b0:234:a734:4ab9 with SMTP id
 d9443c01a7336-23e2fe3a9f6mr605605ad.20.1752694877565; Wed, 16 Jul 2025
 12:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714120047.35901-1-byungchul@sk.com> <20250714120047.35901-3-byungchul@sk.com>
 <CAHS8izO393X_BDJxnX2d-auhTwrUZK5wYdoAh_tJc0GBf0AqcQ@mail.gmail.com>
 <CAHS8izNh7aCJOb1WKTx7CXNDPv_UBqFyq2XEHHhqHH=5JPmJCQ@mail.gmail.com>
 <20250715013626.GA49874@system.software.com> <CAHS8izNgfrN-MimH1uv349AqNudvQJoeOsyHpoBT_QokF3Zv=w@mail.gmail.com>
 <20250716045124.GB12760@system.software.com>
In-Reply-To: <20250716045124.GB12760@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 16 Jul 2025 12:41:04 -0700
X-Gm-Features: Ac12FXwMabx4wvazw8X8IufyySuAWIkeeHz9sZZKQ1flAeUQa_1pSj5SZBgkO6M
Message-ID: <CAHS8izMK2JA4rGNMRMqQbZtJVEP8b_QPLXzoKNeVgQFzAmdv3g@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/12] netmem: use netmem_desc instead of
 page to access ->pp in __netmem_get_pp()
To: Byungchul Park <byungchul@sk.com>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, ilias.apalodimas@linaro.org, 
	harry.yoo@oracle.com, akpm@linux-foundation.org, andrew+netdev@lunn.ch, 
	asml.silence@gmail.com, toke@redhat.com, david@redhat.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com, 
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com, 
	tariqt@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, 
	mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org, nbd@nbd.name, 
	lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, horms@kernel.org, m-malladi@ti.com, 
	krzysztof.kozlowski@linaro.org, matthias.schiffer@ew.tq-group.com, 
	robh@kernel.org, imx@lists.linux.dev, intel-wired-lan@lists.osuosl.org, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 9:51=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Tue, Jul 15, 2025 at 12:09:34PM -0700, Mina Almasry wrote:
> > On Mon, Jul 14, 2025 at 6:36=E2=80=AFPM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >
> > > On Mon, Jul 14, 2025 at 12:58:15PM -0700, Mina Almasry wrote:
> > > > On Mon, Jul 14, 2025 at 12:37=E2=80=AFPM Mina Almasry <almasrymina@=
google.com> wrote:
> > > > >
> > > > > On Mon, Jul 14, 2025 at 5:01=E2=80=AFAM Byungchul Park <byungchul=
@sk.com> wrote:
> > > > > >
> > > > > > To eliminate the use of the page pool fields in struct page, th=
e page
> > > > > > pool code should use netmem descriptor and APIs instead.
> > > > > >
> > > > > > However, __netmem_get_pp() still accesses ->pp via struct page.=
  So
> > > > > > change it to use struct netmem_desc instead, since ->pp no long=
er will
> > > > > > be available in struct page.
> > > > > >
> > > > > > While at it, add a helper, pp_page_to_nmdesc(), that can be use=
d to
> > > > > > extract netmem_desc from page only if it's pp page.  For now th=
at
> > > > > > netmem_desc overlays on page, it can be achieved by just castin=
g.
> > > > > >
> > > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > > ---
> > > > > >  include/net/netmem.h | 13 ++++++++++++-
> > > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > > > index 535cf17b9134..2b8a7b51ac99 100644
> > > > > > --- a/include/net/netmem.h
> > > > > > +++ b/include/net/netmem.h
> > > > > > @@ -267,6 +267,17 @@ static inline struct net_iov *__netmem_cle=
ar_lsb(netmem_ref netmem)
> > > > > >         return (struct net_iov *)((__force unsigned long)netmem=
 & ~NET_IOV);
> > > > > >  }
> > > > > >
> > > > > > +static inline struct netmem_desc *pp_page_to_nmdesc(struct pag=
e *page)
> > > > > > +{
> > > > > > +       DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));
> > > > > > +
> > > > > > +       /* XXX: How to extract netmem_desc from page must be ch=
anged,
> > > > > > +        * once netmem_desc no longer overlays on page and will=
 be
> > > > > > +        * allocated through slab.
> > > > > > +        */
> > > > > > +       return (struct netmem_desc *)page;
> > > > > > +}
> > > > > > +
> > > > >
> > > > > Same thing. Do not create a generic looking pp_page_to_nmdesc hel=
per
> > > > > which does not check that the page is the correct type. The
> > > > > DEBUG_NET... is not good enough.
> > > > >
> > > > > You don't need to add a generic helper here. There is only one ca=
ll
> > > > > site. Open code this in the callsite. The one callsite is marked =
as
> > > > > unsafe, only called by code that knows that the netmem is specifi=
cally
> > > > > a pp page. Open code this in the unsafe callsite, instead of crea=
ting
> > > > > a generic looking unsafe helper and not even documenting it's uns=
afe.
> > > > >
> > > >
> > > > On second read through the series, I actually now think this is a
> > > > great idea :-) Adding this helper has simplified the series greatly=
. I
> > > > did not realize you were converting entire drivers to netmem just t=
o
> > > > get rid of page->pp accesses. Adding a pp_page_to_nmdesc helper mak=
es
> > > > the entire series simpler.
> > > >
> > > > You're also calling it only from code paths like drivers that alrea=
dy
> > > > assumed that the page is a pp page and did page->pp deference witho=
ut
> > > > a check, so this should be safe.
> > > >
> > > > Only thing I would change is add a comment explaining that the call=
ing
> > > > code needs to check the page is pp page or know it's a pp page (lik=
e a
> > > > driver that supports pp).
> > > >
> > > >
> > > > > >  /**
> > > > > >   * __netmem_get_pp - unsafely get pointer to the &page_pool ba=
cking @netmem
> > > > > >   * @netmem: netmem reference to get the pointer from
> > > > > > @@ -280,7 +291,7 @@ static inline struct net_iov *__netmem_clea=
r_lsb(netmem_ref netmem)
> > > > > >   */
> > > > > >  static inline struct page_pool *__netmem_get_pp(netmem_ref net=
mem)
> > > > > >  {
> > > > > > -       return __netmem_to_page(netmem)->pp;
> > > > > > +       return pp_page_to_nmdesc(__netmem_to_page(netmem))->pp;
> > > > > >  }
> > > > >
> > > > > This makes me very sad. Casting from netmem -> page -> nmdesc...
> > > > >
> > > > > Instead, we should be able to go from netmem directly to nmdesc. =
I
> > > > > would suggest rename __netmem_clear_lsb to netmem_to_nmdesc and h=
ave
> > > > > it return netmem_desc instead of net_iov. Then use it here.
> > > > >
> > > > > We could have an unsafe version of netmem_to_nmdesc which convert=
s the
> > > > > netmem to netmem_desc without clearing the lsb and mark it unsafe=
.
> > > > >
> > > >
> > > > This, I think, we should address to keep some sanity in the code an=
d
> > > > reduce the casts and make it a bit more maintainable.
> > >
> > > I will reflect your suggestions.  To summarize:
> > >
> > >    1) The current implementation of pp_page_to_nmdesc() is good enoug=
h
> > >       to keep, but add a comment on it like "Check if the page is a p=
p
> > >       page before calling this function or know it's a pp page.".
> > >
> >
> > Yes please.
> >
> > >    2) Introduce the unsafe version, __netmem_to_nmdesc(), and use it =
in
> > >       __netmem_get_pp().
> > >
> >
> > No need following Pavel's feedback. We can just delete
> > __netmem_get_pp. If we do find a need in the future to extract the
> > netmem_desc from a netmem_ref, I would rather we do a straight cast
> > from netmem_ref to netmem_desc rather than netmem_ref -> pages/net_iov
> > -> netmem_desc.
> >
> > But that seems unnecessary for this series.
>
> No.  The series should remove accessing ->pp through page.
>
> I will kill __netmem_get_pp() as you and I prefer.  However,
> __netmem_get_pp() users e.i. libeth_xdp_return_va() and
> libeth_xdp_tx_fill_buf() should be altered.  I will modify the code like:
>
> as is: __netmem_get_pp(netmem)
> to be: __netmem_nmdesc(netmem)->pp
>
> Is it okay with you?
>

When Pavel and I were saying 'remove __netmem_get_pp', I think we
meant to remove the entire concept of unsafe netmem -> page
conversions. I think we both don't like them. From this perspective,
__netmem_nmdesc(netmem)->pp is just as bad as __netmem_get_pp(netmem).

I think since the unsafe netmem-to-page casts are already in mainline,
lets assume they should stay there until someone feels strongly enough
to remove them. The logic in Olek's patch is sound:

https://lore.kernel.org/all/20241203173733.3181246-8-aleksander.lobakin@int=
el.com/

Header buffer page pools do always use pages and will likely remain so
for a long time, so I guess lets continue to support them rather than
try to remove them in this series. A followup series could try to
remove them.

> > >    3) Rename __netmem_clear_lsb() to netmem_to_nmdesc(), and return
> > >       netmem_desc, and use it in all users of __netmem_clear_lsb().
> > >
> >
> > Following Pavel's comment, this I think also is not necessary for this
> > series. Cleaning up the return value of __netmem_clear_lsb is good
> > work I think, but we're already on v10 of this and I think it would
> > unnecessary to ask for added cleanups. We can do the cleanup on top.
>
> However, I still need to include 'introduce __netmem_nmdesc() helper'

Yes.

> in this series since it should be used to remove __netmem_get_pp() as I

lets keep __netmem_get_pp, which does a `return
__netmem_nmdesc(netmem)->pp;` In general we avoid allowing the driver
to do any netmem casts in the driver code, and we do any casting in
core.

> described above.  I think I'd better add netmem_nmdesc() too while at it.
>

Yes. netmem_nmdesc should replace __netmem_clear_lsb.

> I assume __netmem_nmdesc() is an unsafe version not clearing lsb.  The

Yes.

> safe version, netmem_nmdesc() needs an additional operation clearing lsb.

Yes.


--
Thanks,
Mina

