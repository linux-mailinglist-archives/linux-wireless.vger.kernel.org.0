Return-Path: <linux-wireless+bounces-4347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB07870A02
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0804CB260D4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261B6BB58;
	Mon,  4 Mar 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tOSd2HJC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BE4653A
	for <linux-wireless@vger.kernel.org>; Mon,  4 Mar 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578855; cv=none; b=EQfP0oX3VktnvL0vRa/H0kw8IxUY/i8y/G2tYQfnk3exxGS4GcyfTF5PerfLyQ5z529o/gsU0PK8wbo5JwZx/bU8UTCnzDdM+8TJx1TqhcjDAR/1X+XTmrsNf8TMNtV9lYD3ynCw7zF+UNlFdBY95g4rdNMXbniSe1i6e7z2LXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578855; c=relaxed/simple;
	bh=lfbcQPitdwRRFACF6OFcWymdu7fJx8gv7YqQA1/XCK0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUEXOgpgSDxY/DNP3Bew07l8CIM9T+hpE33Sp31gsZP636y1k8N+6iB95PxkxMwyFyknD6WvRDyBJ0S3q0q/UAxF6Ctn5FVzvGgXTXzYL1uCgdrGG7EskiQS4wMJB42Jl0dmIpBMNa9XcbZ+xwmDZus88l9zNymQEolgfEwcxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tOSd2HJC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lfbcQPitdwRRFACF6OFcWymdu7fJx8gv7YqQA1/XCK0=;
	t=1709578853; x=1710788453; b=tOSd2HJC+Vskoh0FwDTQl1vzJ2CdNDtUbEzJHNRArTHvOVs
	VvcxgWItNOyzyEv8iILM9/rEWCVTbPOlP5se4trgj68wXpq/T2geg+ichM0PD/DA32cxWc8YVHmyi
	6pAt9S+QfmO0IZBejfgm6vsPEqnhGVuJjVAo6z4Ma/omS0bjiLaBwr8pMbYsd5eqWwE3fhnwQ/XQM
	gb1LCb2DfxCuF7IsaVP8PW9HGhstGUUugDj+PUrssZc8Ynro7HsOKFE2Xqe5Gj8GEe/wmkdn4aTzm
	fUoPRbHYMAISpIe30ulAa6fDpf82ao/IpveFYjULEijL59oYxmuTdtptkenfJxcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhDYP-00000001ZSO-23zm;
	Mon, 04 Mar 2024 20:00:49 +0100
Message-ID: <4370a021c6870c58fb15718ee9e4ce8d675b3e3a.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: Add JSON output options to 'iw' for scan results
From: Johannes Berg <johannes@sipsolutions.net>
To: Isaev Ruslan <legale.legale@gmail.com>, linux-wireless@vger.kernel.org
Date: Mon, 04 Mar 2024 20:00:48 +0100
In-Reply-To: <CACDmYyeipzNzeBoXQEtsXRu9uHUuteZ1ymJZZ-GsM=zhT19trg@mail.gmail.com>
References: 
	<CACDmYyeipzNzeBoXQEtsXRu9uHUuteZ1ymJZZ-GsM=zhT19trg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> If these changes prove valuable, I am prepared to continue working on
> extending JSON output support throughout the tool.
> Feedback is welcome and appreciated.
>=20

I'd prefer to look at it unmangled - can you resend it with whitespace
preserving tools please?

johannes

