Return-Path: <linux-wireless+bounces-22674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E4AACE29
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8769824ED
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715D1F4176;
	Tue,  6 May 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DgjuTgjy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351411DED60;
	Tue,  6 May 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560247; cv=none; b=PwfuRahLPgVCsBCZ73qbJFrYiSmLmS0a7B5uNTXa/1f7BA5UrxoIq8TM8CCFe+Ewvc/N84ILeBJHLINNpCJX3N90x7BSqdW3YvthjvCE6/4/RxGwZpPUNbywHmOC/48E43Ur/k1RCnkQpZtjETNx21h4H3ROpd2PmrQ8v+Bq3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560247; c=relaxed/simple;
	bh=ww8fmemkLvDa0GXd8/2iuG3GprABKob+n5StIceBKOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSQQARDQvYbhFoo6NBuF2M393Nca3CbcHWfQBYF1iEaz2nkSvrFjpwOQhu8a/oPDIucjXKaLdGAEJJsUJed88JMlosXPdbFLGs0qwN9rf1fYgm0U+yXUSbjP3V5I314pMj3fx414KR5vqPlDQcJUzXIqpv4MF4UZuLbqdBS42S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DgjuTgjy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ww8fmemkLvDa0GXd8/2iuG3GprABKob+n5StIceBKOg=;
	t=1746560246; x=1747769846; b=DgjuTgjyamodfvkz1okcpuB3TjRq7xQvM73S1xWykcnJrqT
	Mhqkvvlicl9KhtLECPHmwvFJJ8NG3JXrGMJqnG0cU/vEujxzBKzyvSAzakh+kzFhkZ8mMgZLGwSU9
	n+KleQiPM+yS0iVJir/e0rhvGGlWShMA5YKziMpo8jP+atEdr75OmjMHjolGiyxvTWrgqDP6BxT8v
	w4vKofftxZk9phWCKBy+jFxmqZTbXERVakNqRyPtPkq58KO0dCzp2CNPjs5v8o8kgaMwNVCsUqAff
	CBBt6yuuH6T3UiKPAP/xxxWqJ3OtolM1eDnbyPhjO1zXjfXlUYVMT/fP8L6gBOxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCO6V-00000006JzD-2XeQ;
	Tue, 06 May 2025 21:37:23 +0200
Message-ID: <b1991732077354adcaf3d318a008bee9258efe0e.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-next-2025-05-06
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 06 May 2025 21:37:22 +0200
In-Reply-To: <20250506174656.119970-3-johannes@sipsolutions.net>
References: <20250506174656.119970-3-johannes@sipsolutions.net>
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

On Tue, 2025-05-06 at 19:45 +0200, Johannes Berg wrote:
> Hi,
>=20
> Here's another set of patches for -next, but I know there's
> more coming, especially from iwlwifi.
>=20

No, wait ... I'm withdrawing this, I need another change for iwlwifi
device IDs. Sorry.

johannes

