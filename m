Return-Path: <linux-wireless+bounces-24605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB3FAEAFD5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 09:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06283A7BC9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320F121B9E2;
	Fri, 27 Jun 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xhXtrFLC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8C219E8F;
	Fri, 27 Jun 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008282; cv=none; b=OYQNW1ksgaMfIftlCgHGNaXpt7a4RmMK13uPbZUJ0i0gRgckNY3lseSkaHJHpE4hlKVy7CkYzMabMFTbUmtQqu6FSNk6nNWnxolU8rG7jpdwFxMxryma9NeIDhDg4+GWHMf/Rzp8KZxkIlnfBRRdu6yY6ZR02AnONAyshiN8OMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008282; c=relaxed/simple;
	bh=jeOWj62VBktV2lbF8miUqMjm4wZIUMF8VgfmuLsJJfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwgHGZyPEZvFHslO04OUha58A786ZwrRn5DAtCbUkx3XQ0J8d8vMebHGTgQ4HV6WhFQISPT3ygFsskjMefgM9WAk1qgqX1FdoStOawUJ+rMLMZuv2Poi68NwOY/qpNYO+SX5Wx0oCiftp0n1nV96W4BAKWEB5rqXkKwTgqlrWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xhXtrFLC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oN9j1CmBXqrVIvSaYmetxctZyz3xJzMLI6M+DqnVu/Y=;
	t=1751008280; x=1752217880; b=xhXtrFLCT7n1zV14Ec0TBTw4NLLKNPWNQlYiRK8Loy0PWBq
	hqPfHG/Ny81EXmaSSjLMwWuB7f8VRbDBoaODeHegQIyOjFbUPgkESwovE7q3HGVfdZGrelrhq1FqJ
	beyMS1wENV0RFDpmujkrqXRMMnoM97RYi0jG/KovGCk1saoQ6uj1hMAVYbbMJ+8NqSgYJ3Vh3m2mx
	grNmJK0JMZXpx4hjBHvJx3CQWiR+U1CQe0nMEwzgKPhnsFXnog/n5/AJykQtNRC8UzYbr6HpoxpMk
	vP8O525RGOWczHttydOVdRLwyUnF8TyS5yTAECFlRhUwxdg6MGvmgKc3W5fYah+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uV3Ep-0000000DFrh-1yWn;
	Fri, 27 Jun 2025 09:11:08 +0200
Message-ID: <7625f178e7c2be9fd11f1b4cdeb4da47a4635c93.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] wifi: brcm80211: Deadcoding around phy_cmn
From: Johannes Berg <johannes@sipsolutions.net>
To: linux@treblig.org, arend.vanspriel@broadcom.com, kvalo@kernel.org, 
	linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org
Date: Fri, 27 Jun 2025 09:11:05 +0200
In-Reply-To: <20250626140812.56700-1-linux@treblig.org>
References: <20250626140812.56700-1-linux@treblig.org>
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

Hi,

Just a couple of general comments for the future:

1) you can drop Kalle, he hasn't been involved for a while now

2) it'd help for the automatic bot runs etc. to have, in the subject,
   '[PATCH wireless-next]' (or perhaps rtw-next etc.)

Thanks,
johannes

