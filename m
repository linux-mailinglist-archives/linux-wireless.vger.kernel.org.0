Return-Path: <linux-wireless+bounces-17048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4346A009F8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 14:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5177A1B4B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33E1B4F09;
	Fri,  3 Jan 2025 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="ot4gsJDs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05E17FE;
	Fri,  3 Jan 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911567; cv=none; b=eQxLrlXlvTKa4mtcaawyg8KFMAx87SY6IsVJOU87YBPy9ls6AZ1208s6Hos5h4WWXui6fzFy+NV6tjEg3agL6gMwDC/IdwA+gTYL6HHXZwiteikDXO1POlbt9yxTUx3HDyx6FizsTPWj2yjcyJJsaU3u7eIwCw0yeL6ATJrL/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911567; c=relaxed/simple;
	bh=uY9i3M++jCJt8rk9Hjj58keMZJPyTpRD7BeOq8KwkpU=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=snHK0vwaojmBWL4khmDClijT63UPAlJpANQP0fz49cUhaMLdf7q/Pge7mEsHRDutxxlkJ9aU1aHWJJu72q7ck9616f8psvPXM/xO0YgpaqDQLzwS8n0G+ioVp7ANklwXTbJ6CvBWxTBAx01NFfb70mlq55doFTMJ1Nf87qBlDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=ot4gsJDs; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1735911564; x=1767447564;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=uY9i3M++jCJt8rk9Hjj58keMZJPyTpRD7BeOq8KwkpU=;
  b=ot4gsJDsLzNN3/DD2cKt2QEyt0P3bx/CVPLXsRSUZ6J9qUE8lg7jBL3Q
   NZ7AJIAz7ZKbMWfXQa4LIREqeMeQWOj04g1XqwUNEMdS0XuEvg013Sufi
   fcDfz7763hNOmKhecMWGUkm0ub3D5UlKkTxfj9krF86AXqj1VFxyeAzv0
   A=;
X-CSE-ConnectionGUID: M8Z/I3T9Q6acm6eI01JcAQ==
X-CSE-MsgGUID: 7Oea3LqbRS2SuXX2Fdgx6g==
X-IronPort-AV: E=Sophos;i="6.12,286,1728943200"; 
   d="scan'208";a="28365752"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 03 Jan 2025 14:39:21 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <20250103131002.GA100011@wp.pl>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
 <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org> <20250103131002.GA100011@wp.pl>
Date: Fri, 03 Jan 2025 14:39:21 +0100
Cc: "Daniel Golle" <daniel@makrotopia.org>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, "Kalle Valo" <kvalo@kernel.org>, =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>
To: "Stanislaw Gruszka" <stf_xl@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f7a83-6777e880-a451-5cf12280@99910178>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/2] =?utf-8?q?rt2x00=3A?= Remove unusued value
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

Hello Stanislaw, hello Daniel; happy new year,

On Friday, January 03, 2025 14:10 CET, Stanislaw Gruszka <stf=5Fxl@wp.p=
l> wrote:

> On Fri, Jan 03, 2025 at 11:40:52AM +0000, Daniel Golle wrote:
> > On Fri, Jan 03, 2025 at 09:55:40AM +0100, Stanislaw Gruszka wrote:
> >=20
> > I agree with the likely intention here, however, the vendor driver
> > also comes with the dead code, see
> > https://github.com/lixuande/rt2860v2/blob/master/files/rt2860v2/com=
mon/cmm=5Frf=5Fcal.c#L2690
> >=20
> > So this is certainly a bug in the vendor driver as well which got p=
orted
> > bug-by-bug to rt2x00... Not sure what is the best thing to do in th=
is
> > case.
>=20
> As this was already tested and match vendor driver I would prefer
> not to change behavior even if it looks suspicious.

Thanks for having looked into this; I much appreciate your feedback.

From what you two said, I understand that the patch should remove the d=
uplicate code, and not change the logic behind.

Is this right?

If so; then, I have nothing else to do.
>=20
> Regards
> Stanislaw
>


