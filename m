Return-Path: <linux-wireless+bounces-26069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F4B176FD
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7B3A82BBF
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAA198E81;
	Thu, 31 Jul 2025 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J43Ria56"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AA134CF;
	Thu, 31 Jul 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992945; cv=none; b=ZpnzhF8tWOaprHCj2CLPZUuL9DIpLXkcCpogF1lVg95Py6n7PQx5+y5dr/cDxpmtzLlBNymtaMj4gFvKLO4vBWrXeDWQKUcWQ6hPG1yNu4skJdVFB8F3xUnJMo64Cum+MnMUI1KgAQYkd4RPwjYJzP/5/UkM4YmYxV/TwNS/Z5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992945; c=relaxed/simple;
	bh=YsqkD43+hpu6qX0USDmPKg7vk2QZlIz+oan97sbFpBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkaVgyaX80bXbF9XDomwqFtrC1uTf5aWPIg17Xy5lQ6UfjFNrkrRvYP+DwjF+9S8Sh1hl3uLDRxbrVdiMe/L7WdLnlgFkeUIAMPQyPPcMzU7A4SDAl1abpKP633mLzynti2juTOL7PCGsbDAqNYBwXaX3rx7F75uS/Bfh87vsT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J43Ria56; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JB9O0UpAJzIc16IFq8Wl29yX64OJZ+JxvuXoSpEaDZE=;
	t=1753992944; x=1755202544; b=J43Ria56/2+U2d4IepGLjDW7zT90R1oM6NuN/DNQNLnsAE+
	p8KN++x3VUzjOEY9Km6BE1QXNf9NTIc2hxMxdVl+sWWFlyc4znkFybbeN7QIED2FwzWP0/zyI9FOQ
	p2w0NTOv5imIPHNyr9981RTh4FEfkMuCTh8vcDFT+r3BFkZT14CWsrjH/w6bshC2FTLY0IK9ACozB
	3o8DZLUmEeVpYOyEBLwlDOj6aYKYgLtp+boWwCAhblXCj7OS6YR5gskcG1l5Tthux46u7JMk4jHK5
	hvlzh49Wan4LSoIpCAasFro/uMq4nRhpld5EA3juwYiVUdWKGwpP7ywmkmkmpxOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uhZgh-00000001lnw-2WnO;
	Thu, 31 Jul 2025 22:15:39 +0200
Message-ID: <a2dbed0d6d0e529e4ced7e838455345b1ae11a23.camel@sipsolutions.net>
Subject: Re: [PATCHv2 wireless-next] wifi: ath9k: add OF dependency to AHB
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, open list	 <linux-kernel@vger.kernel.org>
Date: Thu, 31 Jul 2025 22:15:38 +0200
In-Reply-To: <20250726025541.11331-1-rosenp@gmail.com>
References: <20250726025541.11331-1-rosenp@gmail.com>
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

On Fri, 2025-07-25 at 19:55 -0700, Rosen Penev wrote:
> The conversion to OF missed adding a Kconfig dependency.
>=20
> Fixes: 2fa490c0d7 ("wifi: ath9k: ahb: replace id_table with of")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: Resend to satisfy bot as the commit is now present

Well, bot points out the fixes tag is wrong :)

johannes

