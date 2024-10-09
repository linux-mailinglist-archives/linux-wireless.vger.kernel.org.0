Return-Path: <linux-wireless+bounces-13758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545E996024
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88991F213C7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE716B391;
	Wed,  9 Oct 2024 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ft/CDDTs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97471547F0;
	Wed,  9 Oct 2024 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456690; cv=none; b=AIqI6AzDfaGlanrJU+tJo4E6BtHtkPD5lRghgUEYhD9wwD29rZAQSW7Uvm5ppUm3hI3zbabbLr7oeZPO9wm3Rt/aSTGmMrb4AfSvaO+q6UnJifeQE3jwT2yEv/LiF2CilW9RkU1NosvU5/s4twsubvn4g24QKnFfha8RRa+LvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456690; c=relaxed/simple;
	bh=8H8d7EbC8TXl/MYFkUlquUEXOOcN90YUDxZa1rW/1wg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlMWsZVth3WLa8UB1Y9fzJSPRUURTNC5W1tuAsErWDdiT/+o+RKqZcswIMzBApalN7jjZEmXjSjNYjZdgLJHi2ZOfwTau6w6pgJMgADBfJjxEjBIcvem8lywrV2LE5NV0zznYEIIXnZNJbEHGIkevZCecKEOSMEFwaMsJQBWqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ft/CDDTs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x8E8MzQmckFTlTyyPWZRdTEm/mndjzwaTj5unLsNYJA=;
	t=1728456689; x=1729666289; b=Ft/CDDTsywF1lK105nmcimBOlZfxF/qnNnTQjB/lkVYzXiE
	zRCAZVM7++s9t2OzsULCpVWZF7NqoFP8P95eoR1+T8+jDkkb9n3x0irt2TVqsyyCyanL8776vkUpP
	elAtXSdd4RnRMXTdYHpfFwTEDj99X2AqXx0XlmLEBm9aWLwF2qqVSZASUsXaFRvSO9hZr0oxcKPp5
	R+63ahS8cIoFSezS7477WsTM6n/pROwrZyHfOfYXG6HK/Cs3sCVOacX6QEaMZFy4w8DVjS85c2icN
	49QIZ3TNt//csgK7gi2Rcbze9eDNq6hLsjdxSndo9SeG50LjblNFL/0jFYMrAcKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syQXb-000000050YG-26jV;
	Wed, 09 Oct 2024 08:51:23 +0200
Message-ID: <317aeb02110105be1483d13c204bfb48d4d19c61.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Rothwell
	 <sfr@canb.auug.org.au>
Cc: Kalle Valo <kvalo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Tree Davies <tdavies@darkphysics.net>
Date: Wed, 09 Oct 2024 08:51:22 +0200
In-Reply-To: <2024100945-engross-appraisal-d1f0@gregkh>
References: <20241009114455.52db31ad@canb.auug.org.au>
	 <2024100945-engross-appraisal-d1f0@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-10-09 at 08:43 +0200, Greg Kroah-Hartman wrote:
>=20
> Johannes, any objection if I just pull in your wireless-next tree into
> my staging-next branch so that we don't get these issues going forward?
>=20
> It's not going to be rebased, right?
>=20

It's not.

However, Stephen also reported a build failure that you don't want to
pull in, so you can either

 * pull in commit 836265d31631 ("wifi: remove iw_public_data from struct
   net_device") from before the build failure,

 * pull in commit 4991d2e7ad38 ("staging: don't recommend using
   lib80211") which is really all you care about (both staging
   patches I had are included at that point), or

 * give me an hour or so to revert commit aee809aaa2d1 ("wifi: cfg80211:
   unexport wireless_nlevent_flush()") which caused a build failure.


But if the conflict is to Linus's tree, is that even going to help?
Seems like I should pull in -rc2 and solve this one and the ks7010 one
that way? Just need to check with net-next?

johannes

