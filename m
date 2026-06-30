Return-Path: <linux-wireless+bounces-38419-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PCYxL2M5RGohqwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38419-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:47:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215D6E8347
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:47:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="D7/fwntI";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38419-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38419-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB8EC303258C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9EF31F990;
	Tue, 30 Jun 2026 21:46:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68292D8390
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:46:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855969; cv=none; b=m3JnKK2PJtwknyZMtIpw0DMU98byU0h7Hm3DHe5SYd1fWpt/IEoVjLL8ad2FNmG28LTMOVPaFhMgd2Y1VcOBsO8k+B0VNCBIl5sdOGlVBMJfYW3lEw8O6C8XKrKWndumiplYH2tHtz6vSNkN35/6M21ZMgKZB/tABmMuzfwy3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855969; c=relaxed/simple;
	bh=QWuxanpR96XxW/AQtuxKdVFi5wsx2VqMS5+/jhKwVBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4VQ396hGwVwkPWx45PUioZF6k2060T16veCAyDqKaSxxeuBQb9dm8qmO6y5NC7yqHJzySwbTEXgnCoPIscaoOTO94KIf8sKKQbFPowl5Il//qQyH/8Vp+o/a+Y18IUYeuQ/MKm1YB+AvtjaaHAZNvabLEzKYc7NtuJnj0so1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7/fwntI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFB91F00ADB
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782855968;
	bh=pUvDaNXzQAJTqE61fbo+DfZd1bDU6D/qLMCG5IKiMGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D7/fwntI/3EHRu1rhEkf/Sxm5cxtWYBPvIyeiHr4BbeE+U3AC8KziRAH/U9R2kZMS
	 qnVlrScxXMTR+aij1253AguCwtOB36ZJlqGONrgVB0aIem+0zGFOPt2bkghO19pNQA
	 0L11F8QdXG3xIS9oH+cULaOedAwOQpsrBZ8+RmrxF+WXYCsMkF8ip8T0M2sh/dSMah
	 zEJrNBRx53ziG79D5Bk6qHq/Ay1OkwovDv8nf9b1+5iqiKFwvZNA6/ZlQIlt+gGpli
	 OcoR5vcOBHqTjCfrBl6hNTosFoPsoO5PxYZ505Drx/3wDSyHCEo3Fw7RyinOJ8sFFX
	 N8ihdn7Dk2vHA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c029505b389so159088166b.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:46:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RruOoJlW2DqCrlzxigWb89/zXeJGg50mGQj+XWUbXYs/thchcGK1ec6+Hfy1Rm/wbWmpmKJqgVj46FxYYyz+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Qnq16KB4y7z8+laEuF8dTheEkp4pttoKuIO2p4l4UvjO+BwI
	sHRgNygq7cyb4hyge546ymA73iA14z32kb1y/Dq+yHEU/jHVFtwOn0BEApbgZR2gT0nYGlnq9WJ
	T+aSbmFIxrKprZokvXO7c+xbn5bKjLQ==
X-Received: by 2002:a17:907:6d06:b0:c08:580e:899a with SMTP id
 a640c23a62f3a-c129042e82emr232092166b.10.1782855967114; Tue, 30 Jun 2026
 14:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
 <20260630180219.GA4139943-robh@kernel.org> <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
In-Reply-To: <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Jun 2026 16:45:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
X-Gm-Features: AVVi8Cc4MorOqwfKhUItBpWtyYeUsNNDkbig_T10OqzF2nSF1JgV4ariSeJFQ-w
Message-ID: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@makrotopia.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38419-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ulfh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com
 ,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1215D6E8347

On Tue, Jun 30, 2026 at 2:59=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Hi Rob,
>
> On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > > Child nodes of a fixed-partitions node are not necessarily partition
> > > entries, for example an nvmem-layout node has no reg property. The
> > > current code passes a NULL reg pointer and uninitialized len to the
> > > length check, which can result in a kernel panic or silent failure to
> > > register any partitions.
> >
> > That does not sound right to me. A fixed-partitions node should only be
> > defining partitions with address ranges. I would expect a partition nod=
e
> > could be nvmem-layout, but not the whole address range. If you wanted
> > the latter, then just do:
> >
> > partitions {
> >   ...
> > };
> >
> > nvmem-layout {
> >   ...
> > };
>
> In our case, the nvmem-layout needs to be associated with a specific
> eMMC hardware partition, nvmem cells can be a simple sub-range within
> the global eMMC, each hardware partition (boot0, boot1, user...)
> having its own address spaces.
>
> That said, your point about not abusing fixed-partitions is valid. I
> initially dropped the compatible =3D "fixed-partitions" from the
> partitions-boot1 node when it only carries an nvmem-layout and no
> actual partition entries, making it a plain named container node. But
> it's a bit fragile if we want to support both nvmem-layout and
> fixed-partitions.
>
> Regarding your expectation of a partition node being a nvmem-layout,
> do you mean that the nvmem-layout should live under a fixed-partitions
> node? Something along these lines:
>
> partitions-boot1 {
>       compatible =3D "fixed-partitions";
>       #address-cells =3D <1>;
>       #size-cells =3D <1>;
>
>       nvmem@4400 {

partition@4400

>           reg =3D <0x4400 0x1000>;
>
>           nvmem-layout {
>               compatible =3D "fixed-layout";
>               #address-cells =3D <1>;
>               #size-cells =3D <1>;
>
>               wifi_mac_addr: mac-addr@0 {
>                   compatible =3D "mac-base";
>                   reg =3D <0x0 0x6>;
>                   #nvmem-cell-cells =3D <1>;
>               };
>       [...]

Either this or replacing "fixed-partitions" with "fixed-layout" if you
want to make the whole boot1 partition nvmem-layout looks like the
right way to me.

> That makes some sense, this would require extra work for the
> emmc/block layer to also associate fwnodes with logical partitions,
> not just the whole disk/hw (hw part), Is that the direction you'd like
> us to go?

Yes.

> Also, Note that regardless of which approach we settle on, this
> specific fix/patch remains necessary to validate the partition node
> and prevent NULL-deref.

Fair enough, though the reasoning for it would be different and
perhaps should give a warning.

Rob

