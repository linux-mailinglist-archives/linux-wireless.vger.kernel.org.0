Return-Path: <linux-wireless+bounces-8424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7478D83AF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 15:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01841C213F5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D086184D0F;
	Mon,  3 Jun 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XVzNI7fx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5612D210
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420522; cv=none; b=MrzCpv7Rmjfut3psWPihx8U4e5rgeUA5d/ChK5hNwN294iMfcH+AXZVsxGMDl4yo6xsaCOOFtfXSf6y/gPP9qKqD8PShoQ8gAJX3OEMkWPDXBOHc5RJavme3End+vT3QKs9KUU/LZideTF7PN2fEumtc3XR+tbRK08ds03sOCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420522; c=relaxed/simple;
	bh=Hfw/OFJv5jPhE+pjptCCl5HrbbJfqf+E2qR+4z6HYKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaOX30QTZT2BmOKsSvSJr/RZFqOOAFimfJCIhV7o2SDnBQvjQgW9RSnKs8AlwEPUb5GZLlM7YJD5MVaDTlLqfWpQBYT4F1Dyosvls2iaEtAlsGZ50M/gEUZ2B+moZFFjhr9RDCbC1DzudFonTLQY6+ky+/4wLitZ8cewXl7Qobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XVzNI7fx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:content-transfer-encoding
	:in-reply-to; s=k1; bh=Hfw/OFJv5jPhE+pjptCCl5HrbbJfqf+E2qR+4z6HY
	KM=; b=XVzNI7fxvwbsxg1kfm9oK51zLHah6fxb9GKGCsd+gWMxCwfncSwygzddT
	SnDpFV0CarWdYmgnGCtWMM6bVVwBDXQS7y/FPns8/QNPG6hi6tuFfb1Lvjb58wZW
	mLmmq/UW3l0qYdFQkyP9gDyAjG2HenLtKPnP3UM+TgCXp05kDTchQ4Ed0igJk/o4
	aHBMNF/D7a0vLVDVUvj4oFaw66UOh0gTHxQUGICQ7ywo0EmR4OqanfTN5KI0TxYU
	//lEJYFjo3T7xnV5KKCAqXYPNjpxVwTURoI98dW3gPPLEPVbsP9P3BPkg8E4cW8o
	uiDHINxkpTEcxMFQe9X+KkVwahSnQ==
Received: (qmail 1964875 invoked from network); 3 Jun 2024 15:15:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 15:15:15 +0200
X-UD-Smtp-Session: l3s3148p1@bVS3H/wZ5NNehhtB
Date: Mon, 3 Jun 2024 15:15:14 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 2/6] wifi: brcmfmac: use 'time_left' variable with
 wait_event_timeout()
Message-ID: <zelrtyr4kv75cfrt2ije3ifjdmaqy25zm4sa774w7v5sa5soy2@qvufjqml47m3>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
 <20240603091541.8367-3-wsa+renesas@sang-engineering.com>
 <08985c11-3652-4699-81d9-8a6769b061da@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <08985c11-3652-4699-81d9-8a6769b061da@broadcom.com>


> I feel this type of changes fall into the category of bike-shedding. Peop=
le

I have two motivations for this change: One may be bike-shedding, yet
"if (!timeout) return -ETIMEDOUT" looks stupid to me.

> should know how wait_event_timeout() works and then a variable name does =
not
> really matter.

And for a new developer, I am quite sure the change will help to
understand how wait_event-family() works. Especially given that
wait_event_interruptible() returns 0 if condition is true and
wait_event_interruptible_timeout() returns 0 if condition is false.

> > Fix to the proper variable type 'long' while here.
>=20
> But it may have useful side-effects to go over the code with fresh look.

:)

> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Thank you!


