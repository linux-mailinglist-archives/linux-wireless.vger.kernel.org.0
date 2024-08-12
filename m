Return-Path: <linux-wireless+bounces-11297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A994E924
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6CB1C213BF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F816BE34;
	Mon, 12 Aug 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="g+x9cp8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF61514C1;
	Mon, 12 Aug 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453405; cv=none; b=pbRiewuhxTzkBJ4Vksex6GHw7NxnZmpcVhx0rAdmythznJ3Yq5JpjXnUw8+qk+GB7z0HGfvfq6I69lqWH7FaVLkgM1sC7OWflb3mVCbHZWO6veXqeAUswzf/+KKb51J9a4Xv9qIn8T+PKQBxS3ws8LPfbwmg7Z01FLdpaTSya1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453405; c=relaxed/simple;
	bh=S2nSa3mtirgFjxAtm1oUixwwDxJLlKpFR3WMJU6rS9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcCyKekX+hiMddvUtjexIevqrBLso/OykgTyMbJSV1wVv+u2c9Z01E2VzSxTqn2wWsSolPrE9VJYNhc0OCaMhL/UXpf9JDmrkEbOP9Fg/lOzrvLoaw6ZQqrVbjhIBWS6nxRj0O6ZvvHSG3t6eZmROCU/uB6zwyBTzrUBTSrBUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=g+x9cp8p; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723453395; x=1724058195; i=spasswolf@web.de;
	bh=WMBuSq4Iuu/WRH9zJvE01F27J7ET0Jabx7VI1l4+swM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g+x9cp8prm5viOIC+yvYWKHL9JUuN2VELDADuUHJ5lMOlgwgypHMO4MI0J/zwvd5
	 bZzAdX3Dx50/hcrcPAKhjkQQLwl+sYJm1fuxgpdIfUe5ycfyS3cNGacdkkK/Df2no
	 /5WQLBKIY0YMyb/E8PRLrB34fsTzDK1NaW3/SUTZ2QwiqKY0RmYu629K6mSAwzPFk
	 eRSO0c1CkvBKBwjKxR4Fp5Dw3cxMN41KZTl31ssWB6KoN3DqpCNZBsbz7K99HwIr/
	 AjvajiqhDrJgCGfx5K/s2EwlDWpUlvwLCZ4cjYMGT4Xo3MtcrSiq9t8pbCF+gU3a2
	 Z2PRVUbrcTV2a0LE5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwwJ-1rrltr08dZ-00i3V3; Mon, 12
 Aug 2024 10:57:34 +0200
Message-ID: <62226273aaafafda1a4f3abc0f8c95220407b3a7.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@kernel.org>, 
	deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, sean.wang@mediatek.com, spasswolf@web.de, 
	linux-kernel@vger.kernel.org, deren.wu@mediatek.com
Date: Mon, 12 Aug 2024 10:57:31 +0200
In-Reply-To: <e32ab97963e850b4425e4f5c45d2c502d50be480.camel@web.de>
References: <20240711175156.4465-1-spasswolf@web.de>
			<CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
			<adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
			<4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
			<2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
			<65621cad9a22df881745e9333a5c3696bdbb8df3.camel@web.de>
		 <87frrqkkpm.fsf@kernel.org>
	 <e32ab97963e850b4425e4f5c45d2c502d50be480.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TSnyMGig7txLvS+YfwGIu8/Fod1Z6p3ItsphvzbiOuanqhmLKmK
 lh5oHYxmJ1tIcKTC1KZBKfNAz1eYf26LKhfC8HanopzN37HPy+3/vvS9w8lAwlhLqYkC66W
 AIdQINaj89ppin084Nj/mg7rPnZRjN3o9/UBuCXAb8fsi8vsa+iv//wXoc85cMAjLXzs1CJ
 G/fITTmoiNArMTGqoKo2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CsEWCLOB0i0=;9qwBQZ4M1mgZcoNoAY9wOo1T+bw
 OcfGW6NN9///TZhMLjm5zZJes1fOuzFQ4lafrCvnKS+HWmvBA6kzI3adMY7xa6eEwBjr0aLM4
 ZaPxN4CloQUDvsPwG8iqoVZN7xeYLKILbK/71yGF+BaYvwejGXef3h8HVatZj3qN3BwYW1xbi
 4D/WV3g1UYwiGP2k+9fN03EkTvFEFcigvbgYLNJGW5rwSNrp+dfNToN1FYkPeWq+op1S41Sa9
 7tYF1oCfHCGCtj/tvbjgDdd6OgxHQV79mZg13gFxRr6Eq1plkzI66ODsancYFm0LzFGl6rBOB
 BbE84mlQ4yogIEp+767uCfJJWSnjY6SuOSUj7vcX2ngEQEPxNXDSA+nhKsVeJdlEhTbL6fawy
 HLMK1vg+Z+5mXCESrzywIeV8cMGpw9TulLz0ihYWcWojiOpnmRnVAbxVjcQe8g1CawhZ7TxU/
 UdOOljkzQNFuEFOET9r0FxjOPwybem/eTYBtn3mrY7eE+jqNUVurVGcbSyYyw4SawE56oe0DX
 HgzKqvOeA8bgaeDaZI+XygTTvUtlmeQY1hP1VUPKQxQ8KtEXfsYrn+3kwKirpCTiF8ol1tH3G
 DkmjcHnw3jD1+7Ed0V53mUINkUDukMJw6P33IbMiRL8SdkArt0b8ph4mbKszKHj6oo1Nwnm3Z
 +cbuqSzmWsmoZcR7d2oYP7mntu3jHjZS09nEffpQu5U/gcT7tjmbu8wRNA6SRjNO5qU8IvzOh
 5X/IfLVIdDV2AOpRkQRWMGXGwIkrMsgcgFujT+vo9nqn7FkNXY0kocooj6FWvZhHrW/rD09OX
 Z6K7um7SlRIo6StZeut1oZNJwhaObB/sERzgD29rPCVlY=

Am Dienstag, dem 06.08.2024 um 13:22 +0200 schrieb Bert Karwatzki:
> Am Mittwoch, dem 31.07.2024 um 11:51 +0300 schrieb Kalle Valo:
> > Bert Karwatzki <spasswolf@web.de> writes:
> >
> > > Am Mittwoch, dem 17.07.2024 um 17:25 +0200 schrieb Felix Fietkau:
> > >
> > > > On 17.07.24 16:38, Bert Karwatzki wrote:
> > > >
> > > > > So mvif->phy can be NULL at the start of mt7921_ipv6_addr_change=
. The early
> > > > > return in that case avoids the NULL pointer and mvif->phy has it=
s usual value
> > > > > again on the next call to mt7921_ipv6_addr_change so Wifi is wor=
king again. I
> > > > > don't know how this could happen but perhaps you have an idea.
> > > >
> > > > This change should fix it: https://nbd.name/p/0747f54f
> > > > Please test.
> > >
> > > The BUG is still present in linux-6.11-rc1.
> >
> > I'm not sure what's the status with this. There's one mt76 patch going
> > to v6.11-rc2:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/=
commit/?id=3D6557a28f3e3a54cff4f0dcdd1dfa649b26557ab3
> >
> > But that looks to be a fix for a different problem, right? Felix, are
> > you planning to submit that 0747f54f as a proper patch? I could then
> > take it to wireless tree.
> >
> The Bug is still present in linux-6.11-rc2 and linux-next-20240806. Also=
 the
> mvif->phy NULL check in the original patch is not neccessary (and feels =
a little
> out of place as mvif->phy is not needed anymore). This patch is sufficie=
nt to
> fix the NULL pointer dereference:
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 1bab93d049df..23b228804289 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1183,7 +1183,7 @@ static void mt7921_ipv6_addr_change(struct ieee802=
11_hw
> *hw,
>                                     struct inet6_dev *idev)
>  {
>         struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> -       struct mt792x_dev *dev =3D mvif->phy->dev;
> +       struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
>         struct inet6_ifaddr *ifa;
>         struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
>         struct sk_buff *skb;
>
> Bert Karwatzki

This error is still present in v6.11-rc3.

Bert Karwatzki


