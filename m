Return-Path: <linux-wireless+bounces-37911-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dlUwEl6gNGr+dAYAu9opvQ
	(envelope-from <linux-wireless+bounces-37911-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 03:50:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8704F6A3949
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 03:50:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SAeptQi0;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37911-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37911-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 258FA302F981
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3833344A;
	Fri, 19 Jun 2026 01:50:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAA27453
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 01:50:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781833819; cv=none; b=cL70BJEht8hUvBrvTkUUzemyVPP4q5zpRxvnyU3vvB0W4kdR4Rz2/ia76x8lxjnDP5Vm+aPpPbzqOag5F0PgkTYP5fIstaQEz/tMpcjm9iFmgXPxPpOBDiXVQ5awqVnk7fF1A55AxmLwXG3haaQho4UiWo3bMd6PfHgpSKs9K2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781833819; c=relaxed/simple;
	bh=BJ51igLEiNSOqU+Oprmh7TY8ZldodOtpB0GApKHNHmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SzS5z1MJIcOAXXDHuhNqRtcZhJ4peAxmIypx2+IAGm+3vSqPugXjX0BqPFR7+s8qBiSaaUPjQ80LqCnRAk+PTQktF+2GJ+AhI1Q8ztY8kp2qSRXe6qestktKBzdcyRrHQd8m6wT52MHEBvMSPkX8VkZlhIVAkjhp9D89zsHebao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAeptQi0; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37c8e7c8137so829441a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781833818; x=1782438618; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrtOo2Dm8vwbUCXe5Oa40jPMn4I218rLCkoAsNCnLeg=;
        b=SAeptQi0uGiRBlU1eBkKod/U7B29nNfWL1i6miTAOCx36pSzKLzpk1kmUz+rKiUQeP
         nW9vBrdU0cXEgUql64xvRywVtM/f29BCA3qSt3z42Rl4DXv8s8E5V6uiOJIGKWJXuukL
         gUCrS/hPev2tLlkMszLYiHfSU5hJjD4cfLTrD0IhBTT4lkaPYlX+Gn7th5hzDJSZQb3C
         IlYhiHEInenOY3YArrfB1OtWEg4eKab5+J2/T2ALWZHIcHqBQVvks2PG/zG+KG0nbWQH
         oJPUlzhQ8PhZ1B5Wr4X4iRma+tAaOU5GxiaDBEYOlpeJ0S/kDIxKzp3zsq8ZJBjKYjJD
         sgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781833818; x=1782438618;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrtOo2Dm8vwbUCXe5Oa40jPMn4I218rLCkoAsNCnLeg=;
        b=T+3taCAaJ/pq9rzd7p4ermkP4cC1WP/m+HSQWzu5796Vz9nGpAigIU3j6N9xt/N85F
         CMI8kAE4VVYww0n4FFAwA2vOQjVsV6smKMzuBkaWAlbvUpzCGMjW1FKQw4qhXzyqjCC/
         Wq/Af6RhUKRr6y4u/oR6VPZ0kGRiv2J0YhlfbGzaG4XCX21KMXbOqeLsXURoexJSvAyF
         ZNBBtcDdtrs7OXPRAPE/9yUlmLiFizgByvVc1JM8iZ6Z5JDF0wEaqRlOjC1NE1wy7tX2
         EBm9woIhSrD9XHs7b6W8YWPBU/UIrFcywF7GzuODJxwuH5YsxhebKW1DalVk+hCD8GKd
         fseg==
X-Gm-Message-State: AOJu0YwS73oWX3RCaoNo9IJUL9ai2jQhcLEcXOwDgDJkf5rhmAKgmx1k
	dR3IPd37JsWvOLTwJ31/tX3zgmY+Jq5rCuG7blpGJV5d5x1kM/CiHBAh
X-Gm-Gg: AfdE7cnLn7/DY8iqQH5dfr7h17vdgRXlNCNg58i9ED03PUUT2zUpD6VKS+XlMHMdQce
	YDAtq6dJ7upVv3m0/pztxQSSIz8rL8QATZpxWVOcYpV9chk8UJTlsPg7e/qRs4elCUYABuQDZjQ
	+KyQptbOg28RHJ5NNRhQHi8OcJ5XkkmN18ThbHOiJ6sd+8HiEJ+8GsfGYtsS8VSE1KPIo4IKFF0
	k5rOk+TyDAFrSsqvenbgFh5tDypIdI8z69HF9z3//gwW0QOVEfSMyJeyULObcjMbFj8p3kw0LPx
	hvNmnScbRdhGeHfZ0YSERTdKD7zt8AGLpll/fNFca0w4YzWyZWXzNVVrjWGBn4WkNH7IX8fin0z
	TtYNrTmc79TDrJHfWrp4sU/6ibulsWmkcUJftbeB2deLcEvErUF6VwB+0m1CqgmJmywLYIs9PPA
	pb9ZqdfMB4jhZtsnP+iOUM2lpWIvtO3CsUpxklEybXMbPPjKwqIf6DMLFTxoD2AM6n4Pfal4y8w
	iO3WnJmT7J+yIeUnnReV4Fs+W8mGw==
X-Received: by 2002:a17:902:cec1:b0:2c6:b3dc:b82a with SMTP id d9443c01a7336-2c725d33bccmr5323065ad.24.1781833817630;
        Thu, 18 Jun 2026 18:50:17 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:3804:5798:1282:ed9e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208e2e66sm4690245ad.34.2026.06.18.18.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 18:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 18:50:15 -0700
Message-Id: <DJCNDEE8JMPL.1DL49X1EUDFCE@gmail.com>
To: "Klara Modin" <klarasmodin@gmail.com>, "Rosen Penev" <rosenp@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Felix Fietkau" <nbd@nbd.name>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Ryder Lee"
 <ryder.lee@mediatek.com>, "Shayne Chen" <shayne.chen@mediatek.com>, "Sean
 Wang" <sean.wang@mediatek.com>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "open list:ARM/Mediatek SoC
 support" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-arm-kernel@lists.infradead.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix of_get_mac_address error
 handling
From: "Rosen Penev" <rosenp@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427051746.954704-1-rosenp@gmail.com>
 <ajRmlyx_AEGybykL@soda.int.kasm.eu>
 <CAKxU2N-gfH8Tq29-j2MArogLZuO7JEqtN5LNPVygJzrAERa3cg@mail.gmail.com>
 <ajSDtsJCmYnMNJSD@parmesan.int.kasm.eu>
In-Reply-To: <ajSDtsJCmYnMNJSD@parmesan.int.kasm.eu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37911-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:klarasmodin@gmail.com,m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8704F6A3949

On Thu Jun 18, 2026 at 4:51 PM PDT, Klara Modin wrote:
> On 2026-06-18 16:01:45 -0700, Rosen Penev wrote:
>> On Thu, Jun 18, 2026 at 2:47=E2=80=AFPM Klara Modin <klarasmodin@gmail.c=
om> wrote:
>> >
>> > Hi,
>> >
>> > On 2026-04-26 22:17:46 -0700, Rosen Penev wrote:
>> > > Check return value instead of is_valid_ether_addr. The latter is han=
dled
>> > > by the former.
>> > >
>> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> > > ---
>> > >  drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/n=
et/wireless/mediatek/mt76/eeprom.c
>> > > index 93d91264687f..0f6ccf6ed53d 100644
>> > > --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
>> > > +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
>> > > @@ -93,7 +93,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
>> > >       if (err =3D=3D -EPROBE_DEFER)
>> > >               return err;
>> > >
>> > > -     if (!is_valid_ether_addr(phy->macaddr)) {
>> > > +     if (err) {
>> > >               eth_random_addr(phy->macaddr);
>> > >               dev_info(dev->dev,
>> > >                        "Invalid MAC address, using random address %p=
M\n",
>> > > --
>> > > 2.54.0
>> > >
>> >
>> > Recently I have started to see randomized MAC-addresses on my x86 lapt=
op
>> > with a MT7922 and the above message printed in the kernel log. I have
>> > CONFIG_OF turned on, but since this is an ACPI system the device is no=
t
>> > described by any device tree and the earlier of_get_mac_address() like=
ly
>> > fails with -ENODEV. Looking at the !CONFIG_OF stub for
>> > of_get_mac_address it always returns -ENODEV, meaning this will always
>> > randomize the mac in that case too.
>
>> IIRC, the normal device_get_mac_address supports nvmem now. Does that
>> fix your use case?
>
> I tried this:
>
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wi=
reless/mediatek/mt76/eeprom.c
> index b99d7452800f..243a8f2c7bda 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -174,10 +174,9 @@ int
>  mt76_eeprom_override(struct mt76_phy *phy)
>  {
>  	struct mt76_dev *dev =3D phy->dev;
> -	struct device_node *np =3D dev->dev->of_node;
>  	int err;
>
> -	err =3D of_get_mac_address(np, phy->macaddr);
> +	err =3D device_get_mac_address(dev->dev, phy->macaddr);
>  	if (err =3D=3D -EPROBE_DEFER)
>  		return err;
>
>
> but I still get a random MAC.
Then the original patch should be reverted. Unfortunate that it doesn't
workq
>
>> >
>> > Reverting this patch fixes the issue and the correct MAC address is
>> > used. I'm not sure if there is any case where of_get_mac_addres() coul=
d
>> > fail in a way that results in a valid MAC address but it seems unlikel=
y
>> > to me.
>> >
>> > Regards,
>> > Klara Modin


