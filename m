Return-Path: <linux-wireless+bounces-2413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65462839798
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CC81C212AE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A981AAA;
	Tue, 23 Jan 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lFzJpcLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2081AA1
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034259; cv=none; b=gtV9DJ/G2u/BbeDkSijT95mIWJzCrPigcIUAeEpHC3m9uaSDl/X28M5FUuufxtdR50EUcZ3RwktFlMFbGuV3wIu8E2EX3Rgdy7JyiQvXJqfJLBIOiDdGgm7GHZGWwj1MTryzXK89NLa20UPCpcFgtL0PF2qrOSXeYu+2kwtQFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034259; c=relaxed/simple;
	bh=Pqm+SMlMCuJQwrISlyutJvbcRH3nEF0qxWr42P0cEm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsgEagxjp+jufPKB23xiWYX0+WEdtIHHRPsQRJ297nhQ8gzeE3fzurWGmxzI3RMFShOSOXd4omGix9m9HkqIqOGPMEW6Rhe0B+0ie6zHUWLRX2EK+q6YLOmcRRhKthcg62EaShV0hynzKaTLvMeS58ViIA2+m9OjAbmDCyqLGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lFzJpcLQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=g7+soZ2L4KXfXYzuHH4VBPf0TKeyYkKd0yufjLwOILY=;
	t=1706034257; x=1707243857; b=lFzJpcLQbqlnLdcUk8Hbfc62RILUlisFdR9MO2/poydPQuA
	07GAGiJMAZ4w32QPoXiC/G7DeP4CT7orjw3O5wlSIqVuoKMKFA3CZ6x2VxM+5s/L41xeEoe09QyiU
	tWe4ahxxL/mGqp/uzqcV21Rmg5GUt8AiLb4sY/Dg8hmJeFogFlD848fRGi4DBxV7gqvnvrKlWhpdD
	SFZDvgmPtZ14CnkvBk8JmitRTVMIVE8Kp8DBE2zwcw0UkpjTyWT9R+juiTAcfCY3ikCYrxb1Ff5+A
	LWXPHLPaTc65oeUMy24hnOm7AIN9gGUo0JnYpU1KW2xWpTG26pg3VJfsjRvCTrxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rSLRW-0000000FAet-0MD5;
	Tue, 23 Jan 2024 19:24:14 +0100
Message-ID: <b4ff77cddb83b547f1ecd5fd9ea8e1cb6f184abe.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] wifi: iwlwifi: add kunit test for devinfo ordering
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Date: Tue, 23 Jan 2024 19:24:13 +0100
In-Reply-To: <20240123200528.a4a8af7c091f.I0fb09083317b331168b99b8db39656a126a5cc4d@changeid>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
	 <20240123200528.a4a8af7c091f.I0fb09083317b331168b99b8db39656a126a5cc4d@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-23 at 20:08 +0200, Miri Korenblit wrote:
>=20
> +	default KUNIT_ALL_TESTS || IWLWIFI_SIMULATION

That IWLWIFI_SIMULATION shouldn't be here, that doesn't exist upstream
(and for upstream folks: it never will, since you wouldn't be able to
get the device simulation binary, it's basically firmware compiled for
x86 host.)

I'll try to remember to remove it, or Lukas will clean it up later ;-)

johannes

