Return-Path: <linux-wireless+bounces-22763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9346AB0A6C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 08:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C091C04A52
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 06:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ACB1D7E41;
	Fri,  9 May 2025 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdKEqg0S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D226A1A4
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771486; cv=none; b=jiug9nBKpbpfNLf7KKYvyHyEa4BbADHuCncf1fyI4bg/6qoEh0cDXi2ulLhBTAALazjoVatpf3DDOnlzZycqO/9QpL4HVPgw1w/ZoQE8GqXLP3ZyfsbKJc12FVEmrI/6GRjgirCB1sTMWyhwNeyTTHo755n1gIReC+nvan9FFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771486; c=relaxed/simple;
	bh=XGRA8z0FQpZb36WuK9Qki7QIfYp7ABMuaqT4gDjGuMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBZjDcuafCaD96CHjnLznBwny/b7xmK2bKj8sbhSVmP27dC04rZYMJpgKT8RAGCjnxfcqOCIlJNnpAxOpFEfBNlTKspFYG0q6sFUofss2PANk2IjC5v2DON1m1OEqVRrsD5N67jWCH2JEb9BaCuNYVlDzHECRaZbXQNAbyJLhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdKEqg0S; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fca2805ca4so855048a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 May 2025 23:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746771483; x=1747376283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd7IokCXcxPu4089U+9sNdIm+EEP00ZCyqIgus9/ygw=;
        b=MdKEqg0SqM6kC3xEsO4wpNP2XP6UZ64O7VZReh/q93iwIkGEK+17Rr34m/LEOEbm4A
         WQj7ibZMxx9R/wRAKskzMEzDhnPUYBEax7zzD39GYAHjJvtMaZEY2yk3x2nIHSm/B1ql
         CSVee48SUJZl+kQO9x1eegYLXYeSQzN4yR6O5UlNXAeqtu9OW4+Srrsd4VDgsM6a5MRS
         6D1DEjnDEuGMGaMyPZsZ81g4Ch4xwz1jw7gvTDbaXp1qos2MX+li/RGtBsB8hT3xFVsM
         nZoxNf/GS89+cvlLw3SWK/1VVVnevY4JVTOrz1kbFnHBP08tX4CHYi1oKmx6NnzQWmCj
         L6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771483; x=1747376283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd7IokCXcxPu4089U+9sNdIm+EEP00ZCyqIgus9/ygw=;
        b=TovXobR4faUxV3Bs4n0iZuuhzY4MdmKAxcPh2wzs6q3p55+tne0P4k8TEol9hZPjuy
         O1TueZDu1TnFEwR+Vwl6ByYYOL5jCYc4YQ+h0z7Daxte7yMmDU56nJHehgE2rvsImurH
         xoLFnqNWg4IkQWsD7BiQRIn28pK3bl1xbl4BBVi7TecxV+tCG2b9Sqnuyn61FYJPUtD/
         3EwQfpzUAzUwmYCJ+VOCMNEidUGjV+xwpY/dyW8keQ4bcF3tPHr0iC6cdYlf0h1OFS7W
         bZ5xiTv9vG3e5DGt5hqCzQ/a570MaZebHM2Zm/E9p56yhIa5a1Xy6LQvp6SWcMvJjYnV
         xanw==
X-Gm-Message-State: AOJu0YzRM4IOoJIioqlBGrf6vOt1mb/te+zyLmoAFi+Oj57IBiL3xiGB
	uUMKUEIOdKXzg4KwqiQfP0jJvUsahWWXgoIVKtDQRJWnzucYD1LJcOfVWlksZ6rrBZekONYID9z
	45Ltx8mnj2MMeUj7PnCnvHLhwzeFOALYBCFA=
X-Gm-Gg: ASbGncvQzytdQ1/vHeQOLaY5rnaJa5+HU0VoWMoGTYHxWqfjALtMWGz8pg4jVvHJESH
	6jqVn1hmqKaY+dRoEipc4ns2VwuWLi/qVVcLRCoRNgpI72QfZRAcivG7M2lT+DrV21um3dcpQiU
	qrDqIKKu2JNRHL3EmOtfbtjktaCVSameUVIKQSBWyDiRKh/nWdVHuo/g==
X-Google-Smtp-Source: AGHT+IFAKlX+DHlba2pKR/XJb0yhBw1lZn9Ul6F8tp40S0CrLbbVH14nkKX2ld5pK8FYWfHjRvKrrfvqODApi0cmcu8=
X-Received: by 2002:a17:907:da9:b0:abf:6d24:10bb with SMTP id
 a640c23a62f3a-ad2192a61a1mr206027066b.44.1746771482947; Thu, 08 May 2025
 23:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
 <0cf9bd4b99864f428175e34a2f2e014b@realtek.com> <CAD+XiyFkogCyQTk8Xhu8htGa892zFkY707+8WVCOdejb3FLNpg@mail.gmail.com>
 <ae5013a930574e68b96544df82f93157@realtek.com> <CAD+XiyEQPt9HGngt0XBB7Hf=0tDHHcU+3=E20vhPnC3VL1Y+vg@mail.gmail.com>
 <31b6571789b34b95aca2bca73dca2d62@realtek.com> <CAD+XiyEXU_cxgfk1DxFZLFMLXWbmo-cDf7d30Hb1F7_BqdBCQw@mail.gmail.com>
 <f4355539f3ac46bbaf9c586d059a8cbb@realtek.com>
In-Reply-To: <f4355539f3ac46bbaf9c586d059a8cbb@realtek.com>
From: Samuel Reyes <zohrlaffz@gmail.com>
Date: Fri, 9 May 2025 00:17:46 -0600
X-Gm-Features: AX0GCFu9nung3M5RQxxBIR1WTErUjIw_wpDn4JeVkGj3xFNHIOtT7Sy1HCJtLgg
Message-ID: <CAD+XiyGWqu6TA==PBZaffnsABbHFycuzQDBKE4mBDWPOw9fx7Q@mail.gmail.com>
Subject: Re: RTL8922AE driver issues
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 6:38=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Samuel Reyes <zohrlaffz@gmail.com> wrote:
> > On Wed, May 7, 2025 at 7:23=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com=
> wrote:
> > >
> > > Samuel Reyes <zohrlaffz@gmail.com> wrote:
> > > > On Mon, May 5, 2025 at 8:11=E2=80=AFPM Ping-Ke Shih <pkshih@realtek=
.com> wrote:
> > > > >
> > > > > Samuel Reyes <zohrlaffz@gmail.com> wrote:
> > > > > > Big update, I updated my motherboard to the newest BIOS (vF4) a=
nd it
> > > > > > has helped dramatically with the amount of errors in dmesg. But=
 the
> > > > > > issue with the connection dropping after some time remains. I a=
dded
> > > > > > amd_iommu=3Doff to my kernel parameters and ran sudo iw wlan0 s=
et
> > > > > > power_save off. I did NOT apply the kernel patch you included y=
et. I
> > > > > > ran dmesg when my connection dropped and saw a bunch of 'failed=
 to
> > > > > > update XX RXBD info: -11' errors again.
> > > > >
> > > > > I don't have clear idea now. Please try my patch first.
> > > > > I will check internally and will need your help to collect more d=
ata.
> > > > >
> > > > > >
> > > > > > I managed to capture the connection drop in a recording so you =
can see
> > > > > > what it looks like on my end. My connection will remain 'broken=
'
> > > > > > indefinitely until I toggle airplane mode.
> > > > > >
> > > > > > Video: https://youtu.be/BbVlTU8K9Hg
> > > > > >
> > > > >
> > > > > Can you open a terminal to show kernel log next time? I would lik=
e to
> > > > > know disconnection happens along 'failed to update XX RXBD info: =
-11'.
> > > > >
> > > > > By the way, please not top-posting in wireless mailing.
> > > > >
> > > >
> > > > Hi!
> > > >
> > > > Thanks again for your assistance.
> > > >
> > > > I spent all day yesterday and this morning trying to figure out how=
 to
> > > > apply your patch and wasn't able to do it. I'm by no means an exper=
t
> > > > and quickly found that patching a kernel is no easy feat.
> > >
> > > What are the problems you met? Below is the rough steps to build driv=
er:
> > > 1. grab kernel source
> > >    git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/lin=
ux-stable.git
> > > 2. switch to tag you are using
> > >    eg. git checkout v6.14.2
> > > 3. install toolchain/kernel header by 'apt install'
> > >    sudo apt install build-essential
> > >    (I don't remember how to install kernel header. Please google it y=
ourself.)
> > > 4. make driver
> > >    e.g. make -C /lib/modules/6.14.2-061402-generic/build
> > M=3D/$(KERNEL_SOURCE_PATH)/drivers/net/wireless/realtek/rtw89/
> > > 5. rmmod/insmod
> > >    ```lsmod | grep rtw89``` can see all rtw89 modules
> > >
> > >
> > > > I wanted to
> > > > record a before and after video (before your patch and after) of th=
e
> > > > download, but since I couldn't figure out how to patch my kernel I
> > > > only have a before video. It has the terminal running so you can se=
e
> > > > the errors pop up in real time. It's pretty long since I recorded i=
t
> > > > from the very start of the download. The crash happens at around 11=
:30
> > > > into the video: https://youtu.be/2nrLOuY6Pwk
> > >
> > > I guess the cause is that RXD can't be recognized and then
> > > "failed to release TX skbs" can't free TX WD properly, so run out of
> > > TX resource. Therefore, let's try the patch to see if we can resolve
> > > 'failed to update XX RXBD info: -11' problem first.
> > >
> > > >
> > > > P.S. I hope this is what you meant about top-posting, I also had to
> > > > research what that meant and how to avoid it :P
> > >
> > > Yes, it is. :)
> > >
> >
> > The obstacle was unloading the module which was in use to load in the
> > patched one. I did it though, I had to boot from an Arch live
> > environment on a USB.
>
> That will be easier after this success. :)
>
> >
> > Anyways the patch works!! dmesg is clear of those pesky RXBD messages
> > and my download completed without failure. This is the first time I've
> > been able to make a large download like that without the connection
> > dropping :)
>
> Good to hear the good news. I will make a patch for it.
>
> >
> > You'll see the download speed dip a few times (e.g. around 4:45
> > minutes in the video) over the course of the download, but it always
> > recovers successfully. In the past those dips were a sign of the
> > connection dropping.
> >
>
> For me, these dips seems to be acceptable. If you want to dig further,
> I should check PHY rate first via debugfs:
>
>    cd /sys/kernel/debug/ieee80211/phy0/rtw89
>    watch cat phy_info
>
> And, capture video as before.
>
> I admit this is only first step to see if the symptom is caused by
> PHY rate. If yes, I need air sniffer to know how it happens. If not,
> maybe system enters power save mode or others.
>


> Good to hear the good news. I will make a patch for it.
Thank you, that's great news!! I'm glad this will prevent this issue
from happening to other people.

> For me, these dips seems to be acceptable. If you want to dig further,
> I should check PHY rate first via debugfs:
>
>    cd /sys/kernel/debug/ieee80211/phy0/rtw89
>    watch cat phy_info
>
> And, capture video as before.
>
> I admit this is only first step to see if the symptom is caused by
> PHY rate. If yes, I need air sniffer to know how it happens. If not,
> maybe system enters power save mode or others.

I agree, they don't make a meaningful impact on my connection. For the
sake of getting to the bottom of the issue I went ahead and followed
your advice. I recorded 5 of those dips, they can be found at the
following timestamps within the video: 2:45, 5:40, 10:47, 13:12, and
15:50.

Video: https://youtu.be/h7v-qSGEbH0

