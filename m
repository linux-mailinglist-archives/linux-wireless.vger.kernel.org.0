Return-Path: <linux-wireless+bounces-37581-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3SMKlr1J2pZ6QIAu9opvQ
	(envelope-from <linux-wireless+bounces-37581-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 13:13:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45065F5F0
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 13:13:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RGDhzDnd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37581-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37581-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0ED5303E20A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186EA3FC5C9;
	Tue,  9 Jun 2026 11:05:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E63FBB6D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 11:05:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003115; cv=none; b=ULe1o5MR2nJD4YgiD/Qz3j+wdrXJNOXSrWsSPcgKNEIY2OfSCKZMjcGn3YbmoqhCtrsQjFPt0zDIyri3Qfl+cCRnZoeqg7h3BF8AWbGOpIAtjOEQtztIucQ170umb/Z9DuhudF9WLVt0G6DOUPyVlBQEjV4V/hbx7qJX32D2Iok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003115; c=relaxed/simple;
	bh=FzHeD0sMZk02bfUIOVbZ7vcbl5dWXL2/Txt+74srelk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doIATg+WoU9BLdAtRyU2l0EgC+vgzxLfNUhdrgIt6Qx0aYOlgdHz2pOP7txGUrVWiVUCaF/mrrweS+PMAZThYEAcX2UXWprXEspq9sGLDfINUCaEYC9GaJg4rQ7zQecssKO2SoPo5oEAcz9/ZjJs9cu1CAyF48OcyUEA9qvUhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGDhzDnd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9A31F008A0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781003113;
	bh=+sX9ATTxluLYTPpyn9xT27ptWmmBF8CPbs0HcxCOGLE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=RGDhzDndKBB2dkoo2ExWmstsyWaeZ8qJ18zZpU/Zh0vnaXRYAMzekOdsxjslSMmMP
	 Zz8+CTH0TaVqx9FQtV3+0bfwMumlGnwVxTC4XbD3pQ9vXv5cjQPwxw+p/urFIYe+M1
	 23mhKFfJTqrlZpJV745TVZPiLITUlVY6C7d5E8xA1cDZC81W784rbDYRkz7hR5lGZL
	 64Iy0/HNkiWIMrL9ECwoHOiIF9wCFEfpU8Auj711VfrHHZui/L8EP/HRqjhrowKr2W
	 OxVlAEX7eB4eXwfcJe6BQDfh51Xjtyo6bbEDsj8hF5jBGM4+Ii4e2FKcVqq3Vj0HgK
	 9xuzxLAHXn0zA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so4662412e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 04:05:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8iSzUiH4OuUj3GFffesOhCVb8C67xBo3F54v3L6RXm2T7nQDaHyDt65JF3gnZTU/+AqYI5FzJKx2rexkftDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgSVt5/kyxJ6TipurS/SOSBv+T4sG6Mx4TFOKNxNZfEXDoJ+W
	gE9R+Iei29g0pe4hkq6jlCnzaX2zO6lgg1VqSmiZotFiMqmWMaOeaaGa8RoIJo/Ey7sf039exqj
	jAuW+igfMSQkht+TYw3eISxHq73minUXXUouV3ZZVfQ==
X-Received: by 2002:a05:6512:2253:b0:5aa:5c8c:9cf4 with SMTP id
 2adb3069b0e04-5aa87b5f803mr5428916e87.17.1781003111998; Tue, 09 Jun 2026
 04:05:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 07:05:10 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 07:05:10 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAFEp6-1syMQsvuQ+dLU39bnDeL5Ok7vK1mA7CS0v1m7cjhyMQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-4-45712e6b22c6@oss.qualcomm.com>
 <CAMRc=MfuiPMkSm=-G6VEJpqKhos0TD_pf0ScBGqfwLHT0uk8yQ@mail.gmail.com> <CAFEp6-1syMQsvuQ+dLU39bnDeL5Ok7vK1mA7CS0v1m7cjhyMQw@mail.gmail.com>
Date: Tue, 9 Jun 2026 07:05:10 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mc=-G0+ESPJUUgxd+jJWwuEzBcVXSJyAbAhx6BFkHeimA@mail.gmail.com>
X-Gm-Features: AVVi8CdBM8fdpM7hiE50yrSmJrPYo7K9sdF-J87b4PfgsolvJ2MbyT4LVehGYdI
Message-ID: <CAMRc=Mc=-G0+ESPJUUgxd+jJWwuEzBcVXSJyAbAhx6BFkHeimA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] block: implement NVMEM provider
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37581-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:brgl@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,config.id:url,config.dev:url,mail.gmail.com:mid,vger.kernel.org:from_smtp,config.name:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B45065F5F0

On Tue, 9 Jun 2026 12:13:08 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Hi bartosz,
>

...

>>
>> On the other hand, we don't want to not provide the block device just be=
cause
>> someone added a DT property on one that's too big. I'd say: warn, but re=
turn 0.
>> Does it make sense?
>
> It=E2=80=99s still technically an error in the sense that we cannot provi=
de
> the required nvmem feature. However, it only becomes a real issue if a
> consumer actually attempts to use it.
> Also, the block device should still be added, since the return code
> from add_dev is not checked. In any case, I=E2=80=99m fine with either
> approach, as long as we emit a warning message.
>

We don't check the return value now (why?) but if we ever do, the safer opt=
ion
is to return 0 IMO.

>>
>> > +     }
>> > +
>> > +     config.id =3D NVMEM_DEVID_NONE;
>> > +     config.dev =3D dev;
>> > +     config.name =3D dev_name(dev);
>> > +     config.owner =3D THIS_MODULE;
>> > +     config.priv =3D (void *)(uintptr_t)dev->devt;
>> > +     config.reg_read =3D blk_nvmem_reg_read;
>> > +     config.size =3D bdev_nr_bytes(bdev);
>> > +     config.word_size =3D 1;
>> > +     config.stride =3D 1;
>> > +     config.read_only =3D true;
>> > +     config.root_only =3D true;
>> > +     config.ignore_wp =3D true;
>> > +     config.of_node =3D to_of_node(dev->fwnode);
>> > +
>> > +     return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
>>
>> And that was a wrong suggestion on my part too because I was under the
>> impression that we're in the probe() path, not device_add(). You can't u=
se
>> devres here as the device at this point is not yet bound and may never b=
e.
>
> So I understand The bd_device is purely a class device with no bus, no dr=
iver.
> For driverless devices, devres_release_all() is called explicitly
> within device_del() .
>

Right.

>>
>> Which leads me to the second point: this is not the moment to add the nv=
mem
>> provider. This should happen at or after probe(). Once nvmem_register()
>> returns, you have a visible nvmem resource but nothing backing it in the=
 block
>> layer.
>
> There is a short window during which a read attempt will 'properly'
> fail, but this does seem somewhat fragile indeed.
>
>> Either do this in block core when registering a new device or schedule
>> a notifier here for the BUS_NOTIFY_BOUND_DRIVER event and do it in the n=
otifier
>> callback.
>
> So in the end, it seems that the simpler and more robust approach is
> probably to move away from the class_interface driver and instead
> register/unregister the nvmem directly in add_disk/del_gendisk.
> If that's ok I will move to this approach in the next version.
>

Yes, I think it's the right approach.

Bart

