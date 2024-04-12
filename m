Return-Path: <linux-wireless+bounces-6227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0388A285C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 09:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD01C22D7D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B7241E2;
	Fri, 12 Apr 2024 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7a9jEZ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACED74D9F6
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907535; cv=none; b=GL1+0lUxN0X5aIltA5jHhhUnia7tPt3nh1nTCcCtOnfpl+PQvT+JGeVQ7+Ob6VudF9mezbRoxhZLP53Qe9NfwAfuNN58gSsKaXstCmd5T/deGR+qdWwGrp8z+Cd/Zjg/2t780b0/mMYWp5A3vCQlL6Gh76ajZc+aTPnPYx+sHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907535; c=relaxed/simple;
	bh=HVMk+0i4dzw032r4ZzojJPLydeB+KVQmVKDgXB1C+30=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=MVBhlFOaKqZVyxc3taJJqt9NspGgEttw5S0fTh/lv19HnR/r4D/TeWw8tFf6pgItmnejousGyAmtESCX8mQIhZ2wDKdikRft9KSBuUcNF0I0SkCqO/+zWQier6VsQtK66ubZZzjMYZo9HydWj3yOfh1eqZFznq2OHCprkG1WU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7a9jEZ0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d756eb74so758832e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907532; x=1713512332; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZweRDclpMhnDM38KhYAJkWP/JZFHfum4MtfUSrlxfjA=;
        b=e7a9jEZ0pMl5bG7j1AGUqYFxiJ9p4pqV2XNmxxggRz+uCDGTHV7QMqIWHRpAP67MU+
         Ox719OqHRkpxIMCsJl9Tf4SJZmWpHSEScj/COgnJCDH2Yoj7itxA58asijcs0QxbdeLg
         0Qq3qB1CL/hJg4gcMp4Ab9x0aa8HyiVFvqUwk89mlATm+uoXkg61dLAcyuCafymV3Sev
         FlXxqgA07/2oYh1UOWszkcEaUykjYRAkOmUcTRhgPDEcNHrlb4HjDUPZWf4N5xBDz9Z3
         wx5vH/xQxgu6n6e6rRVkwLbQdXGQS7xY8Ogg6g/R4PSO5NrrgqUvn4qVVZkvVIZqQXOQ
         WkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907532; x=1713512332;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZweRDclpMhnDM38KhYAJkWP/JZFHfum4MtfUSrlxfjA=;
        b=p5V3cMKj9bBvzFOxf8/wbvkZEUjPWbTZF5Bt60VJxVS0ReAckah/P0X1JU2FzEroFk
         4Ktbfl4WU2IRVkhoNfvF6hucVg0vFrCeXu/NINSV1F+x6armkGtGGOd15wZEUalrJutU
         HE0DURUQFeYDUC/kGceWEHtubVX3m9G06+6LmXxUBYAhUmkvNchxBZLMhXK6oLaRmQes
         jXoH+nnONbj+4tJcRVCYhYqoSspkhNxQwakNSwNTDYjlpBasGQoGgstz2w7LauqlcnI9
         SYk6hUAOcwYelyn5jNXByfAZJ/Z6uw1McUh3xkXFdpAj7oSnuzwr0ZXVsFJA2ZBxyZfP
         cgpg==
X-Gm-Message-State: AOJu0YynXQhmhdDDx1mIARfs6tz/LID3jjawEiBcKd2CTMfJixowDwlc
	t06nOfIZIIKPT1ZNn/6YboLBC1qgSgN7Mb945tO+PU8wBNi1o3Dt
X-Google-Smtp-Source: AGHT+IHadM7YvEPmFm4iLaXvTuWUMBcs6WGrn6s6M9ogyfcAzf9yuEKAi7TbzvHqsddAH1hDGecsJg==
X-Received: by 2002:a05:6512:3da8:b0:513:b90f:f4dd with SMTP id k40-20020a0565123da800b00513b90ff4ddmr1494010lfv.49.1712907531577;
        Fri, 12 Apr 2024 00:38:51 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b00414659ba8c2sm4800181wmq.37.2024.04.12.00.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 00:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 09:38:50 +0200
Message-Id: <D0HZ1KH5VJ8P.2TZZ7NNZXSJA8@gmail.com>
To: "Vasanthakumar Thiagarajan" <quic_vthiagar@quicinc.com>,
 <mbizon@freebox.fr>, "Jeff Johnson" <quic_jjohnson@quicinc.com>, "Ben
 Greear" <greearb@candelatech.com>, "Johannes Berg"
 <johannes@sipsolutions.net>, "Karthikeyan Periyasamy"
 <quic_periyasa@quicinc.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: "Nicolas Escande" <nico.escande@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
 <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
 <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
 <5fc2f2d2-7403-79d2-8909-ddda918ff8d5@quicinc.com>
 <af70ee81e583f58dada3dde87ac335137c4038b0.camel@freebox.fr>
 <6ff353e2-785a-f2ce-8d3b-acc8e79a64cf@quicinc.com>
In-Reply-To: <6ff353e2-785a-f2ce-8d3b-acc8e79a64cf@quicinc.com>

On Fri Apr 12, 2024 at 5:50 AM CEST, Vasanthakumar Thiagarajan wrote:
>
>
> On 4/11/2024 10:09 PM, Maxime Bizon wrote:
> >=20
> > On Thu, 2024-04-11 at 21:56 +0530, Vasanthakumar Thiagarajan wrote:
> >=20
> > Hello,
> >=20
> > Thanks for making it clear,
> >=20
> >=20
> >>> For example, starting a 5Ghz AP in ax-only mode, and at the same
> >>> time
> >>> creating a STA interface on 2.4GHz ?
> >=20
> >> Yes, such use cases continue to be supported in single wiphy mode.
> >=20
> > Understood, but I see some corner cases.
> >=20
> >=20
> > For example, assume two bands AP hardware, 2.4GHz and 5GHz.
> >=20
> > Previously:
> >    - phy0 is 2.4Ghz
> >    - phy1 is 5Ghz
> >    - iw phy phy0 interface create wlan0 type managed
> >    - iw dev wlan0 scan
> >=20
> > =3D> will only scan 2.4Ghz
> >=20
> >=20
> > With single phy approach:
> >    - phy0 is 2.4Ghz + 5Ghz concurrent
> >    - # iw phy phy0 interface create wlan0 type managed
> >    - # iw dev wlan0 scan
> >=20
> > =3D> will scan both bands ?
> >=20
>
> Yes, both the bands will be scanned if freq list is not given
>
> >    - <starting from previous state>
> >    - # iw phy phy0 interface create wlan1 type __ap
> >    - # hostapd -i wlan1 <config>
> >    - # iw dev wlan0 scan
> >=20
> > =3D> what will happen then ?
> >
>
> Scan will be carried out on all the radios including the one on which AP =
interface is=20
> running. Scan with freq list can be used not to disturb the radio of AP i=
nterface.
>
> > > Same goes for hostapd ACS, I assume specifying freqlist becomes
> > mandatory or we can't predict which band the AP will be on ?
> >=20
>
> If no freq list is given, ACS will run through all the bands and select a=
 channel from any=20
> of the bands. But this can be optimized to do ACS and channels selection =
on a particular=20
> band using channellist/freqlist hostapd configurations.
Hello,

And in a (very unlikely) case that there are two underlying radios that can
operate on the same frequencies, how would freqlist enable us to really sel=
ect
the underlying radio ? =20

Thanks
>
> Vasanth


