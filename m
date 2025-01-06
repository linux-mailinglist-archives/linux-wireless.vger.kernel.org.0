Return-Path: <linux-wireless+bounces-17101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023FA01FD9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 08:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C71188154B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC51D619E;
	Mon,  6 Jan 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="yZzNIEBc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8319F41D;
	Mon,  6 Jan 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736148225; cv=none; b=sioDfKbyPSj0O66eCAeToUs1qsvhLX6GE2FIL77jSgZSVP89SYxBNTh9Z3bGkP8/8ojKYeWuoU3Rb9XTYOGDk0We+aGL6kTjiJEOl0iEQMLSxzjyU7ZWhJyGueRcuAj0Z9czBbZqxBTLl+h6kBxQB3Y/9rE4v17mNFuun/xwBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736148225; c=relaxed/simple;
	bh=Mldq6LasuhhGh76OgTeq6apFEmcXzD/N9uU79E5WMJ4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=nrWjg8yI8zVLqksKMQaJDeD5GfV8J2kVGBM0LArYSMzPeQT1Pp9OsybCElFzJzbaHMzwH9AiX/yIJUQJ65v0ZhXXyRCyiBqLOy9fbs7XXh8CR267HMfSnixMe6eYD2YlEWBHY4MAAaHggT6E2vAR2Z0OQA2W/jZf+I7ABsSOi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=yZzNIEBc; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1736148222; x=1767684222;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=Mldq6LasuhhGh76OgTeq6apFEmcXzD/N9uU79E5WMJ4=;
  b=yZzNIEBcD4Oc0IP9AsDGXHZibVH7YD50ziLCfjdQnjMYlTjnpE48GxjY
   QhCSI8ZNqabptGAutKMTJ3pfFVCSuNNZ2rX+okx4Epf2DnOTXLiPUlicN
   GkhE7xAdS0mL633YOCLD8kypNC1Hd2WWblsahhl20TaK0Cq1Idznfu+gk
   Q=;
X-CSE-ConnectionGUID: +Zo/CIoeRKGxxnpUrN0Mvw==
X-CSE-MsgGUID: tWodmdsgSo6/SelmVepsuA==
X-IronPort-AV: E=Sophos;i="6.12,292,1728943200"; 
   d="scan'208";a="28378900"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 06 Jan 2025 08:23:34 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <Z3r3vxy8cRRH6w1m@pidgin.makrotopia.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 46.193.43.102
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
 <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
 <20250103131002.GA100011@wp.pl>
 <2f7a83-6777e880-a451-5cf12280@99910178>
 <20250104103753.GA2228@wp.pl>
 <2f7a8b-67792f00-52db-be99fc0@193911177> <Z3r3vxy8cRRH6w1m@pidgin.makrotopia.org>
Date: Mon, 06 Jan 2025 08:23:34 +0100
Cc: "Shiji Yang" <yangshiji66@outlook.com>, "Stanislaw Gruszka" <stf_xl@wp.pl>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, "Kalle Valo" <kvalo@kernel.org>, =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>, Linux-kernel@vger.kernel.org
To: "Daniel Golle" <daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f7a84-677b8500-5061-4ac1e700@152950135>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/2] =?utf-8?q?rt2x00=3A?= Remove unusued value
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

Hi Daniel, hi Shiji, hi Stanislaw,

On Sunday, January 05, 2025 22:21 CET, Daniel Golle <daniel@makrotopia.=
org> wrote:

> H again,
>=20
>=20
> On Sat, Jan 04, 2025 at 01:51:25PM +0100, Ariel Otilibili-Anieli wrot=
e:
> > Great, then; thanks for having acked the patch as such.
>=20
> I just noticed that Shiji Yang had posted a series of patches for
> OpenWrt which also addresses the same issue, however, instead of
> removing the augmented assignment, it fixes it to the supposedly
> originally intended way.
>=20
> See
> https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dpackage=
/kernel/mac80211/patches/rt2x00/621-04-rt2x00-fix-register-operation-on=
-RXIQ-calibration.patch;h=3Daa6f9c437c6447831490588b2cead6919accda58;hb=
=3D5d583901657bdfbbf9fad77d9247872427aa5c99
>=20
> I suppose this was tested together with the other changes of the same
> series, so we may want to pick that instead.

Thanks for having put some time into the research, Daniel; I looked int=
o the openwrt archives for 2024, none of Shiji=E2=80=99s messages menti=
ons that patch.

Though, if you three agree, I will push a new series, modelled on that =
patch, and you as Suggested-by.

Have a good week,
Ariel
>=20
>=20
> Cheers
>=20
>=20
> Daniel
>


