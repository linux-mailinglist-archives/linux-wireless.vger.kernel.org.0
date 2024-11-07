Return-Path: <linux-wireless+bounces-15096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9059C08CB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6203F2845E3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1A212164;
	Thu,  7 Nov 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nBlrbBU4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353A29CF4
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989375; cv=none; b=kDZ9b0KqAekv9ylZo9ucvdhmDG4YnZv7CtSsZp2SVf/S3NTwS9s96dnwwHr0AM9d6f0fMzyoMSM33PXuHYy88wQfpAVt0dGsD1LmksNCBtT0LJy8eO/JRPZSSXtCOwDzpFMI/S1dIW/EwauZeWA/WiULPVmMxQbf2DqxoUrJ1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989375; c=relaxed/simple;
	bh=1+wq0dSYy4wjLKzqezvQylfN8uLvNACu27iOMJikbqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FksV30Klm2cnX+0EpFIgO3j206LXS9WNyju84wPChCIfByZ8Pspr1cwtWXrpdCnF2WULI4v5yF2UOvAP0UBLstOr1/3SBgaJi3/aYG62902KtVKa8XScwpF/uvHOXr94hlh7jeAESKa4pE+y8RPPRJWOqwU0wd8yw7uicOrwF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nBlrbBU4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1+wq0dSYy4wjLKzqezvQylfN8uLvNACu27iOMJikbqU=;
	t=1730989374; x=1732198974; b=nBlrbBU4RrPgUFxr9hiMn0deElE/HBHWbjNmsw/bKGMChdZ
	bjfbc8zAfmqW9HGBiG9T+GTGTZcCtd+O7nGXxhBT5WC3pl/s3yAkXaVzqzRcYpJPiy3QA8IfuWL26
	7C0CVEyYhj+LcA+FqMeLsR+14M5c77UP/A4xciWjOUZzbudnZlArdSxouxOQb6XjjZYeLfkpw6HgK
	fJJZKg/NNI/GDFaSOgHLp3ceMeWTKiqXMFIzlkNQ4k9YADr3iYaBiaOEBQzDWt9byCq/9qI1rHRdZ
	yTTUroHK789dIpcOZMwAdR96M7MXqa7b6LptmSw4Mq3lfTO4wMJm+fmFDhF6CJig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93PQ-0000000GRyt-0JnO;
	Thu, 07 Nov 2024 15:22:52 +0100
Message-ID: <69fa8e26fe6ebed7dbff2ab0c725d84a02b08ed8.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] iw: scan: replace passed ie buffer with alias struct
From: Johannes Berg <johannes@sipsolutions.net>
To: Dylan Eskew <dylan.eskew@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 07 Nov 2024 15:22:51 +0100
In-Reply-To: <20240930181145.1043048-4-dylan.eskew@candelatech.com>
References: <20240930181145.1043048-1-dylan.eskew@candelatech.com>
	 <20240930181145.1043048-4-dylan.eskew@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-09-30 at 11:11 -0700, Dylan Eskew wrote:
> Prevent needing to reparse the ie buffer by passing
> the ieee80211_elems struct containing the alias ie
> pointers.
>=20

I think I see why you'd want the previous and this patch, and it's OK
for certain elements (such as the VHT capability or HE capability where
you'd need it), but in general it can't work this way.

We could either make the parsing even more generic to be able to deal
with elements occurring multiple times, or, perhaps more plausibly, have
a context with only what we need (VHT capability seen here, HE
capability for EHT, ...) filled by a pre-parsing step, and then pass
that context around.

In practice for HE/EHT we could also just pass a context around and say
it's an error if e.g. the EHT capabilities element is in the list
_before_ the HE capabilities element, since by spec that's not supposed
to happen. So we could just have the HE capabilities parsing fill the
context with the necessary information about HE (and set a validity
flag) and then check that it was already found when we get to EHT later.

However, that doesn't work for the case with capabilities/VHT ... where
the parsing of the capabilities element is actually referencing the VHT
element _later_ in the frame.

johannes

