Return-Path: <linux-wireless+bounces-15570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB29D51C9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 18:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604B8B26B1D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877F31AB51E;
	Thu, 21 Nov 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D00Yjusd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C681B5820;
	Thu, 21 Nov 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210106; cv=none; b=DetPm3xBXeyKotU9sE6HHhNqarIVVtojBz/SJKO0eroJsSgyVww8Cc5xw/9Rzx2HHK+SYfBPDNiAM7euOmA3iA++zih8WOs3L+B+bRW6Pps7SJnQ9tVhD6KzAyc7fJqBStPhqzlS6qow/thjMXuWG9WQlocRBXT0FB+pwzK6rfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210106; c=relaxed/simple;
	bh=yTk5w2wkClqnCi7HQNf++Vk5uWZxpQOHXxsnPoh7CTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9Qeh0+rNtqatUU/duCLLKMJ7VrJf9PNhIXwyV09mMLHrOse3iZo28AWuTXvndITdYyxk/TWXM5nMhPIHbvWLwH39YCpE/FgZcSEEQGkbPXQMsAiJAwHzciHSrN3N/IaRVX9mAQ/Ba62xRY728BBco20WYR6J2cVliLtPIucD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D00Yjusd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yTk5w2wkClqnCi7HQNf++Vk5uWZxpQOHXxsnPoh7CTk=;
	t=1732210104; x=1733419704; b=D00YjusduUepSngDF7s4/w6jLpSsp/RPBqwaFpKBLWyYsKQ
	SLIkfJL6t+K1tPqlhYIO4HL8ua3VVBxNWjVYKh1ZP5yz+lnPRkHbBMUKgQr8g6SKrqGf/guqoXTc8
	Vhil6z0ZqXdqitExnMO5ckvyJs2RjD6Cp+nSIORy2m3WQouSGGVgN/V9hwp+qPukBUrz2HUJ0hVYs
	j1eO3yMLludtrhQFloKNCOwhJT4+n5J6wMOEJZrnODx7ZICet1DEyQ9OBRygwsu0r1j4oR74uRUR9
	Cg259BoeA8zSHCc1zV2TlEu2FK1Hpc4SH0WRfxFZXhVR2bb6ByGvenbatzTGL4rA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tEAyV-0000000AkVW-0dlL;
	Thu, 21 Nov 2024 18:28:15 +0100
Message-ID: <e37392a6a1fcb11db42646da2afe055416ca4cea.camel@sipsolutions.net>
Subject: Re: [PATCH] drivers:wireless: Fix a dereference before null check
 issue
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Perego <pperego@suse.de>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo
 <kvalo@kernel.org>, Shaul Triebitz <shaul.triebitz@intel.com>, Emmanuel
 Grumbach <emmanuel.grumbach@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>,  Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 21 Nov 2024 18:28:14 +0100
In-Reply-To: <20241121170257.275607-1-pperego@suse.de>
References: <20241121170257.275607-1-pperego@suse.de>
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

On Thu, 2024-11-21 at 18:02 +0100, Paolo Perego wrote:
> This patch fixes a dereference before null check issue discovered by=20
> Coverity (CID 1601547)
>=20

This was reported before by smatch too, and Emmanuel just made a patch
to simply remove the NULL checks, because the pointers are statically
known to be not NULL. So it's not really an issue other than
style/checkers/... anyway :)

johannes

