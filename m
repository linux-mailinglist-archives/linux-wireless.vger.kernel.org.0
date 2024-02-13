Return-Path: <linux-wireless+bounces-3545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234788532CA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F601C20C81
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956465647F;
	Tue, 13 Feb 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KwPa/v4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E355733D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833704; cv=none; b=DN6VnyChnW/VSYmKbSTfakoP/Hop9Zb0l/1jkVwBjivMqyi9bIj1HeAh8ZQbWYH6o995vyhJQ6pcgUxGCBEAGD9DxUC0WWNmDNeSr5ecEP9jZs6IU5y3iniXC/6wS4kRTdxF86UaV0HHddY85zsIR+REdQvU8eNX1snKbNXjRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833704; c=relaxed/simple;
	bh=cb4IpjwOgrksQPoyu5cR5Xssc55F8sK778m1ngdj6V4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hAeZgKpgtvAv3X9pvFwR7isZFIIHbZ9H6BreWKzE3ohNqxZjMwoqY/zRPJlOqAx3BLL1bCuAIEfoUyp9ju9YpfwIUP4fjIHL3WPxhr9s6EiIF4Uy/V3R9rR86zp4tJagFwzDqA1MHOfefvYJXwvdJqBUumix3tVDhc42amBfleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KwPa/v4m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VjFc3jhHuElcCQSq+w6t6a5QCmPepadUZqwvgmxVMbY=;
	t=1707833702; x=1709043302; b=KwPa/v4meo1ArtkpkzqSJvh52o/svElYdCZUmeMUi/mAvA/
	PeiapN5S6qKRUbzRDskixjheb9teRaEPjz8zqb9+E22KRgg2m1TxFhdUNiyBi682Iaphb6uGLXVw4
	/bE8vhXYaFFu1kvdiUvVabyPeiSGGU/mP7ZyuwAXdsVAozAQ8gkPcTjHuYWUFFA4HCTISnb5axZmO
	snkTl/nkfXAebEVVlZwhGyYZ77e1UsyAn8PaU+7cySGOW9bEp1xW4dwsGb5JTTF55uruFdirKGXE/
	zGTB3UyQks3IM4XsS9FAF7kTOnRZ0KD+TkBAQJ4LHnStfDVBiLQwJjgGmIfICjjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZtYq-00000007kHG-2Onu;
	Tue, 13 Feb 2024 15:15:00 +0100
Message-ID: <25395d1cee68fcd6d19a6c7843afd48ad8448a82.camel@sipsolutions.net>
Subject: Re: iwlwifi RFC related to iwl_mvm_tx_reclaim
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 13 Feb 2024 15:14:59 +0100
In-Reply-To: <2839f687-88af-ecd8-c6cb-7bdaf1808496@candelatech.com>
References: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
	 <9779efb62cec04926e3bb2575a8aecc8bbf0e7ff.camel@sipsolutions.net>
	 <2839f687-88af-ecd8-c6cb-7bdaf1808496@candelatech.com>
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

On Tue, 2024-02-13 at 06:13 -0800, Ben Greear wrote:
>=20
> If sta is NULL, we should still reclaim the frames?  If so the check earl=
ier in the code where
> it returns early if sta is NULL could be deleted, and add a null check do=
wn near the IS_ERR
> check?

If the sta is NULL something went pretty much horribly wrong, not sure
what we should be trying to do in that case. I guess you could argue for
reclaiming anyway, but question is how far you go and what that risks, I
don't really know.

johannes

