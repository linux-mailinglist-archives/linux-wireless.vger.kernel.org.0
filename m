Return-Path: <linux-wireless+bounces-2545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515583D783
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D65297949
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADEE219F0;
	Fri, 26 Jan 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t0iOXrbN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198421372
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261509; cv=none; b=iJ1B+KNGIT8OHw6abRYtw3krwtr+QAKAoyx1HasryWj45QfU7OZeBwcbkQTUMFTFttCxsWQ2IQpuH1CKHodqDT6twoOWsDaiuHpF6jeROxDRY7om/HZfe7/E/jRIjHPHvMXzkwT+uZAiGHK1MLmoHcHBGG8G8RYakZTeM2q5lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261509; c=relaxed/simple;
	bh=uvB2hjASDzn4vOgaYySBL1ho+/4LEeI4tA2Q5Scv+x4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eK69sPKzIvIkNsYK0C8nPFL+ZDsLDGPCDq1MSutbl9NwouM17Yj/vZ/HO5luF11lXNKOWTmG0CbacKFTGNjw70CzhKMuSJjRKw+UnOV8W46IZ2JeK3Co36P1trqq811VxVIu0kZPSqvdjmISH/5d6EVtBcBwhn8iuw6/L/tIWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t0iOXrbN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uvB2hjASDzn4vOgaYySBL1ho+/4LEeI4tA2Q5Scv+x4=;
	t=1706261507; x=1707471107; b=t0iOXrbNu73bFxGHsVGpN6MlywwP7PtAvTBRCsb7wb0rghV
	ubYGBbN1tOgXTj3rgklzkOtNmoFjasS3zyn+qdgaNzleZSa4cAw5b+vcft90tTuAvzIbMjmgZdPIZ
	tx3rgOvjp5neltt/2ExfM0LCJbU81OsmVrNHwU/z1SQMKxAe3N21XpNeOye4c0+2z1FCYEbdFbaMx
	P9S7/W3RW4jxXmsMYFtrpyJ5t5FPOaHssrahfKN5WvUMKVSSKhE1FYa31zBarxvL0up8WUTfEQ7qr
	LzeQch4aIOtTlhhLFGFVfJwnIllmHo3xZq7dhvjHb4qC8b1opqRVZBMmjh6Ob9VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rTIYq-000000014wY-1FdL;
	Fri, 26 Jan 2024 10:31:44 +0100
Message-ID: <dca9bc4a793f338d4681f3a2a1f2e326f0b5d9ec.camel@sipsolutions.net>
Subject: Re: [PATCH v5 3/3] wifi: mac80211: update beacon counters per link
 basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 26 Jan 2024 10:31:43 +0100
In-Reply-To: <20240125130410.827701-4-quic_adisi@quicinc.com>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
	 <20240125130410.827701-4-quic_adisi@quicinc.com>
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

On Thu, 2024-01-25 at 18:34 +0530, Aditya Kumar Singh wrote:
> Currently, function to update beacon counter uses deflink to fetch
> the beacon and then update the counter. However, with MLO, there is
> a need to update the counter for the beacon in a particular link.
>=20
> Add support to use link_id in order to fetch the beacon from a particular
> link data during beacon update counter.
>=20

Seems it would make sense to put this patch _before_ patch 2, since
otherwise in patch 2 it would appear to be kind of working but then not
really work?

johannes

