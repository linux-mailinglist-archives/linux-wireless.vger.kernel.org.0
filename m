Return-Path: <linux-wireless+bounces-14279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677239A8FC1
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 21:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778171C219CC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A231FB3F4;
	Mon, 21 Oct 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C36nVwCX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8341EEE0
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538791; cv=none; b=sUkwBHxuhFQ4gb8wiPH/G/MMyrjW5VlbIWAGFqNAPJa2cLCUOZja2mEnecRSLYqN4ACiCpoNLG1OtfVMNup/mv/yf+R0Mc+XMLAmHojREqrqjzQoW3DBVUhK1plPtrLk1KqBnmhBiGaUEKQs0qheUASrRsLCYwN0r67FE8fe4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538791; c=relaxed/simple;
	bh=R4jjmbj2xP+mumf5gi5BVenK8pFJCSwOkoapexUbB4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r4Hg0/dxqxdIWu9gaU6kDrlU4UhHSJmYHI3B0+nJdqIptrBVO69wXH0ZpdWCFjoC30bvPyeZELJ4xdytpT+h5gv5IbaoxpiUsPuAt6RfW5UJ58ZSYeza/OZBMkDvzKbzFqynkfYYuhSgDsFTA4fQ7kAEzwbbodMQr3jTipe2feU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C36nVwCX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4wqm1FzYc4a0mETpPsAkBa/q1uk/8sI9W1MSgOXyTH4=;
	t=1729538789; x=1730748389; b=C36nVwCXVxua1yXSTWX3dWnm4sHK6LNLeKiDw0yRswVy/II
	MdM/4Rjg47Pv685FHXZ3aZx41mp6TFiyt9kqsEhOtoToAr2OYTKwA+d39UROAHwdutZgMubNfg3mw
	bnaLOI05evTnh45FzG42f0ya9fqrQc7DXrx5DnDZ1cCtGBQGfX67nI5HAwL6CaoNxLx5grlT85NKQ
	uKBWmetT7mIG5DOVzoIsAJpEEicR/60BJuR2XvqI96Qed+61oScbFd4QDQglEkLulUEeJaJoRG9As
	4y3DiPXXx32Sry1MAZKc3nrSej2sWKn5qiQvrRbvEoC3wXBqI7sokekKld8s4DMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2y2q-00000000xFw-3AIz;
	Mon, 21 Oct 2024 21:26:24 +0200
Message-ID: <6417cba1b6478647a6dcfcf4320cd04bafc956e5.camel@sipsolutions.net>
Subject: Re: [PATCH 9/9] wifi: iwlwifi: mvm: tell iwlmei when we finished
 suspending
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Emmanuel Grumbach
	 <emmanuel.grumbach@intel.com>
Date: Mon, 21 Oct 2024 21:26:23 +0200
In-Reply-To: <d005a964caae7b9f7cccdc2092c37ccabb8deba6.camel@sipsolutions.net>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
	 <20241010140328.1dc3a7fea9d1.Ibf183824471ea5580d9276d104444e53191e6900@changeid>
	 <d005a964caae7b9f7cccdc2092c37ccabb8deba6.camel@sipsolutions.net>
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

On Mon, 2024-10-21 at 12:48 +0200, Johannes Berg wrote:
> On Thu, 2024-10-10 at 14:05 +0300, Miri Korenblit wrote:
> > From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> >=20
> > Since we no longer shut down the device in suspend, we also no longer
> > call iwl_mvm_mei_device_state() and this is a problem because iwlmei
>=20
> [snip
>=20
> config IWLMEI
> 	...
> 	depends on BROKEN
>=20
>=20
> so there's no way this matters upstream?

And since Emmanuel pointed it out - I meant here it doesn't need to go
to the wireless tree, nobody is going to mark it non-BROKEN there, so it
can go with other stuff to wireless-next, perhaps eventually together
with a patch to mark it non-BROKEN.

johannes

