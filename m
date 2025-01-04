Return-Path: <linux-wireless+bounces-17069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A066CA01467
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 13:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E6163AF2
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jan 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1941AAA3D;
	Sat,  4 Jan 2025 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="hg8vLjWs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50B169397;
	Sat,  4 Jan 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995098; cv=none; b=HkNLa6c2WfCH307c+C4VUS8UW+BL3sM20tZyV6qev2OqhqKjhaKYuZbF9yznfu9PelPjRxhQROQ25SGRvTSveUDjAvhB2Tl33lBQdUwJF2x+rWP4SUGcOOQ8T8/09wUzOx/66X0XwOPgh74Q0Ud3fl0fmdBAQ/tae8LbxNrvbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995098; c=relaxed/simple;
	bh=M7LLsnYehiKGxea9MD0/O9pJQhjciQvdb4292T/Wm4M=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=ArUqRYOBLcJqjeg489awqe3zOddpjd93UJlWnbtIBeCCH3NzkR86raGwuSdQNan6hIjRFQYb+5gtRW2dCmBud17XfdcY1Z/ce/+G5HolOQvBIgFmzPV38/sMVB0l8kzr++ikZFOzwgUDpUGM42WpolaWCh4/5eQqNJ8kVXN5/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=hg8vLjWs; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1735995094; x=1767531094;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=M7LLsnYehiKGxea9MD0/O9pJQhjciQvdb4292T/Wm4M=;
  b=hg8vLjWsV1TNANg1MapqTutX6eG9eOytXNce64YQNfZtpwFPpYy0UyOe
   FElRhBL7Nl731nmaNs1KiRVkHq5axSjxFVQEmVhEjqFoAlRYMqF0xoR/M
   LgQttiofX3eI8XvgxyNK+Dae+XU7Xv2XAnGApyy+h1rwgzBPb8dMJe/k+
   U=;
X-CSE-ConnectionGUID: NTo97UkKTjyINeex7PL52w==
X-CSE-MsgGUID: srHxAmPaQ5uKQ2AaofTMfQ==
X-IronPort-AV: E=Sophos;i="6.12,288,1728943200"; 
   d="scan'208";a="28370202"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 04 Jan 2025 13:51:25 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <20250104103753.GA2228@wp.pl>
Content-Type: text/plain; charset="utf-8"
X-Forward: 88.183.119.157
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
 <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
 <20250103131002.GA100011@wp.pl>
 <2f7a83-6777e880-a451-5cf12280@99910178> <20250104103753.GA2228@wp.pl>
Date: Sat, 04 Jan 2025 13:51:25 +0100
Cc: "Daniel Golle" <daniel@makrotopia.org>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, "Kalle Valo" <kvalo@kernel.org>, =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>, Linux-kernel@vger.kernel.org
To: "Stanislaw Gruszka" <stf_xl@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f7a8b-67792f00-52db-be99fc0@193911177>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/2] =?utf-8?q?rt2x00=3A?= Remove unusued value
User-Agent: SOGoMail 5.11.1
Content-Transfer-Encoding: quoted-printable

Hi Stanislaw,

On Saturday, January 04, 2025 11:37 CET, Stanislaw Gruszka <stf=5Fxl@wp=
.pl> wrote:

> Hi
>=20
> On Fri, Jan 03, 2025 at 02:39:21PM +0100, Ariel Otilibili-Anieli wrot=
e:
> > On Friday, January 03, 2025 14:10 CET, Stanislaw Gruszka <stf=5Fxl@=
wp.pl> wrote:
> >=20
> >=20
> > Thanks for having looked into this; I much appreciate your feedback=
.
> >=20
> > From what you two said, I understand that the patch should remove t=
he duplicate code, and not change the logic behind.
> >=20
> > Is this right?
>=20
> Yes.=20

Great, then; thanks for having acked the patch as such.
>=20
> Regards
> Stanislaw
> >=20
> > If so; then, I have nothing else to do.
> >


