Return-Path: <linux-wireless+bounces-14974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0FC9BE53D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 977BAB211DB
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE51DE3D5;
	Wed,  6 Nov 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Zio44dHF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9C1DDA15
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891375; cv=none; b=GkR8osWcRQJRCsL7eApykvX9mxOeO3Qo6ON2C5qRMov3A2eXZd/f9NX9hFqsAQbSCiQOokrJAbKYZkxF+7hvefu06yyntsL0R+gZ+S+BBOQrUcdANH0luMenZYlT7tw8vMkp24KnAK1sq//wJMqOBaPfioCqFrNg+eoUE0Ns4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891375; c=relaxed/simple;
	bh=VI3ws/fM4UGfWMPbcUp9n+7P4ZC9x39Rchidleai794=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MQt1MjGiVsINdzH+EsK+OVACRL+lJuvpy+7qcqNVe09eQESn6H0f1pKjT0b/Bl2Or42OpiL/fuA86A3z9zGLv2Sx+1x89AnQ1NZz7wX6mMQ0nWn8DKTBldZkvNwS5HfDHoVgjeccpavjJi4OhakLpG5MslUADm5Q70bO9RW4VgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Zio44dHF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VI3ws/fM4UGfWMPbcUp9n+7P4ZC9x39Rchidleai794=;
	t=1730891373; x=1732100973; b=Zio44dHF9gnRO23FJueRIsOPKVRfxqCE5AxAH25C1dMTfKO
	ugs+pbqB6bqHc36dla9+An0V/OHw5esP2X7mxk9DSQR2KNnfTBj75YAnZRcfm2fLEtlG3S0Pgdse9
	9+4oyq28nTElmzrtECoACTp9+ADGeNajw9LM12nfYbN2kT81NN1bkiSah4JBQQztpSQ35G39Hh/Mh
	yNLuPwBNNOwhHeKbz/T+sbt1gg6CKlfKEpfhx/FBOVgTMoDwGH5k7uS1RRyY/1a+o7X++K/T2QvS5
	/I2gnih+VRkuofS1owKOCfnkiLNOJkCEbgUBMJyn5OLgMDqdyuk8zuk/RWGTKVww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t8duk-0000000Fagl-2Xj0;
	Wed, 06 Nov 2024 12:09:30 +0100
Message-ID: <df6c3317a71c8fa76f2b64623a0278f1fd0a68dd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix mbss changed flags corruption on 32
 bit systems
From: Johannes Berg <johannes@sipsolutions.net>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: linux-wireless@vger.kernel.org, sw@simonwunderlich.de, Kretschmer
 Mathias <mathias.kretschmer@fit.fraunhofer.de>
Date: Wed, 06 Nov 2024 12:09:29 +0100
In-Reply-To: <20241104172415.3790038-1-ih@simonwunderlich.de>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
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

On Mon, 2024-11-04 at 18:24 +0100, Issam Hamdi wrote:
> On 32-bit systems, the size of an unsigned long is 4 bytes,

yes

> while a u64 is 8 bytes.

yes


> Therefore, when using
> or_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE),
> the code is incorrectly searching for a bit in a 32-bit
> variable that is expected to be 64 bits in size,
> leading to incorrect bit finding.

No.

> +++ b/net/mac80211/mesh.c
> @@ -1164,7 +1164,7 @@ void ieee80211_mbss_info_change_notify(struct ieee8=
0211_sub_if_data *sdata,

You evidently have _hundreds_ of out-of-tree lines, probably some of
those cause this bug too.

johannes


