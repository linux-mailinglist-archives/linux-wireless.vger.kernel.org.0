Return-Path: <linux-wireless+bounces-24445-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3AAE6D9A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C827AC097
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4722B59D;
	Tue, 24 Jun 2025 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Oum8EnWw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFEE219A95
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786288; cv=none; b=qlCsqgNTyfrGcrxSszocgD8S5qnQCAtZs7Qh8LFOKsjZTr5FXnPUkqfXZAiYdKoRXM0dMJtRHSqnEakNsKHKSSPtGMY4NtjFeYFhF9g0gYpRHFgGWH77c3k+GM1hbZ8guEFPzwkF8bmXRJo6LdBC6V9Aq41NPsfW+nPrk1bXxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786288; c=relaxed/simple;
	bh=U1xXtUp3ASInkfVIFTgd16QsZnCGOYns5qW05o/K40M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhHy8w2tnJlwuGv3njQsdDV5wrVGqAUP5KLUU6ZW1e63QAra+OZwHWK0llff0hPd9JYrOz3WEfs8swEjBbps2PgC/MjbUhT1rckyACEPdbVpsHB5/G4/YMTZa3ce8KFszQXfRmwumGLcPguhcLg7ynvjV6bHg80a1akHZyVDh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Oum8EnWw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aZz0bJP7qfgshQFq6ottKlcCPqZeoRwUQLdXEdnTbk0=;
	t=1750786286; x=1751995886; b=Oum8EnWwJ5/+FoeEra2fVpJivF2g2Zqqggx2Q78cZUooP6R
	5+NUM4eIWaj8gUPDAjvIVMmuBljeEAFqCm86lLlOc/s949GEchauY1oP8OQn2gbfy9yucRWHTDjW0
	4p6Nra78ehzowtWiIIsiUllpK0NUBcRTpJE7EgvAYrR6MB3ozJM5I3hkcwSdCMrS2tNXd/raZyfsm
	r6KK7zezPR5gsbPUi2iMQCu3HCiF8YM8J/s47Ajp5Q2VjsImnsolHOHPS6xFvqRryWuMqxS/0gZbg
	UBJeimo9uhMXsCQCMJx2CaAK5T0Yc4ef6ZG2MRh5gZBh2xzG9iZYqif5elVtVY7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU7UR-000000090c0-0ny5;
	Tue, 24 Jun 2025 19:31:23 +0200
Message-ID: <0b29ee81d16f7c75a2cb7b5e48d30f945e36b7ce.camel@sipsolutions.net>
Subject: Re: [PATCH] ath12k: add module param to control MSI mode and
 address width
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Govind Singh
	 <govind.sk85@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 24 Jun 2025 19:31:22 +0200
In-Reply-To: <58fa9f69-2525-4c6a-acc8-571b20a4646f@oss.qualcomm.com>
References: <20250624165031.58616-1-govind.sk85@gmail.com>
	 <58fa9f69-2525-4c6a-acc8-571b20a4646f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-06-24 at 10:26 -0700, Jeff Johnson wrote:
> On 6/24/2025 9:50 AM, Govind Singh wrote:
> > This patch adds two module parameters to the ath12k PCI driver.
>=20
> Please use imperative voice.
> And it is preferential to first describe the problem, and then describe t=
he
> proposed solution.
>=20
> >=20
> >  - ath12k_msi_mode: Allows selecting the MSI allocation mode.
> >    * 0 =3D multi-vector MSI (default)
> >    * 1 =3D single-vector MSI
> >=20
> >  - ath12k_32bit_msi: Forces the use of 32-bit MSI addressing
> >    by setting pdev->no_64bit_msi =3D 1 before IRQ vector allocation.
> >=20
> > These options are useful for working around hardware or platform
> > limitations(ex:  i.MX 8M Plus) where 64-bit MSI or multi-vector MSI
> > allocations fails or cause stability issues.
>=20
> So there is no way to detect this?

For the record, Jakub has very much been pushing back against new module
parameters, so I don't think we should take this.

johannes

