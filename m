Return-Path: <linux-wireless+bounces-22786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6033AB117C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 13:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC991C053E5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B96228C99;
	Fri,  9 May 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s/hFjhIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A428F527
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788758; cv=none; b=NB/Jx9kxwVWdFbZXn6yU1mSDJSMg/zsRRpcSh7bFk904hnbGAA+EMt2Wq+mOsONmOBZMnYaMYLNGEtzejAIN/jPfcStFrWwkkbBR9RXALmfvvLSz3UT3J+XyiiJBGtmH55zaEP0aPdQFPbMekQBATj0Yedqf6pxrk4XbF/1Tzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788758; c=relaxed/simple;
	bh=d2mqp5DQcGBijaVc3bb+Pil1vAklUrOzt9DHWYTUNw0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGfXLvOPeznNj66b8p346c0up2eJMwDIyCGweBhWFzKvi6FkWLNc5HIfSMJXDuxguxPPu381RV8capHd7loURLKVOvhljGYvRyg62VvvI3IaLJ7xTAtFrqIun63mIOeu+6OnLk9fn8hsJUrxXECRva4OXCzyY46ZZvpQyEJAFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s/hFjhIf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d2mqp5DQcGBijaVc3bb+Pil1vAklUrOzt9DHWYTUNw0=;
	t=1746788756; x=1747998356; b=s/hFjhIfnOgUuxMwrAF3ek+wsvQNKItwih0qIAYIxOOvBjQ
	FADVNDfm6sH/oIbnLQGRqBR9NzBHOBFKaHMRS7Nv94zaLaK13aHwnaGCaP/qS3r1UOgkIOg7htC27
	Cocqu+8eIpJYsdVWZ0oAnPrru2sv3lFS4uk3qDACvrD9IS//pom2Fq7anZpFX1oP4soVmrtrCnldt
	rMr3Xj1p0CuEGGstSEZRg9riiaPv68zZb1JrBcETSnAIimzAXir3+iv2T2xqxl/y855LWFvDfoqIB
	fGGO3qynETJXO1h6k52m2zk3A3Uec+omi5c/JYxIARm8ykQxfKo0g47PTKqm+8Dg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uDLY8-0000000DPaZ-2x7J;
	Fri, 09 May 2025 13:05:52 +0200
Message-ID: <22ca10df0be259f20ea3cc4296c92cc148978ec1.camel@sipsolutions.net>
Subject: Re: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: cfg: add ucode API
 min/max to MAC config
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Date: Fri, 09 May 2025 13:05:51 +0200
In-Reply-To: <20250509104454.2582160-2-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
	 <20250509104454.2582160-2-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-09 at 13:44 +0300, Miri Korenblit wrote:
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Message-Id: <20250509134302.23a88a8b57cf.I9ba14e8caa547a9cd0301e5ee7f0d40=
a8e99a2ba@changeid>
>=20

Something odd happened here?

The actual message-id ended up being

Message-Id: <20250509104454.2582160-2-miriam.rachel.korenblit@intel.com>

but you probably wanted the above one to be in.

johannes

