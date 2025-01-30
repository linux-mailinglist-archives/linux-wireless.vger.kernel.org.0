Return-Path: <linux-wireless+bounces-18218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C84A22D00
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 13:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12E918864EB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093FE1BEF90;
	Thu, 30 Jan 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="p2thcdV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EC1EEE6;
	Thu, 30 Jan 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738240594; cv=none; b=FKxISG0vzWWJbys3FS7g8J4bXdQ7kDGZji1sOSZdGss9ua+VVp+A3opaPhGuMcEy+o0fLxUlAOw0uFagb41oYfkIXAzn6Ypa5tGToHpZg4/T6OFnBrIcniXvE7o/KSu483WYcw/D2zm97/MKUrQ5ggNq5ZarM5e1qoE+hVSdDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738240594; c=relaxed/simple;
	bh=92+SzlRAkjhakdFgxl0KMmzfQ3P1vecIc37HwkXXxJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQ6rPSwGN2xSHrw+Z6107fb84cZbT1f5xO5NzhWLvvyM4VuoNtMAI0piJI5nFG7n2SyYrMi8NV7ED7dP3NL1yzRzA2ePeczR+1/IGL/6yWWt44vcImU3wWd+llArXJdNM16yNOEGMqKUT5y2S1mwAzKixpPQXhd6A/N3A+WfGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p2thcdV6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=92+SzlRAkjhakdFgxl0KMmzfQ3P1vecIc37HwkXXxJM=;
	t=1738240593; x=1739450193; b=p2thcdV6MCTVCjtLO/4RwBOZapmm7CYGCxNWf5gG2zHDwuh
	a8S/rIk9V+aloOzE6P6hpQpzgP4CNWJgBjzsihwaq/JOhvjrfhvCoILib6+NS62hUh+m+AMLrfpVw
	1mKH7BLWz+lqHBVTimZHQz/0GB8BMhSynlp9NXXFek+r8XYimr2pfhLJsZSViADl1Bo+Euc59RlDY
	Y50jfQYnOtKCdXxz1ulivaVzkAOXTt/hpiDaabkwWnZykBy29dhRk2abtLD5GMzSQetWuWHw8pF/m
	BFU9SSxU/dlM7da4C101StfGdvQEjbMhTPxEHk9g3BoN9Tm5tQC+r4hYz4myGjIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tdTmX-0000000F59r-0V26;
	Thu, 30 Jan 2025 13:36:29 +0100
Message-ID: <14c5edc71a74049c49d51960249b0aefc77208be.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: override all other flags if
 MONITOR_FLAG_COOK_FRAMES is set
From: Johannes Berg <johannes@sipsolutions.net>
To: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Cc: "John W. Linville" <linville@tuxdriver.com>, Michael Wu
	 <flamingice@sourmilk.net>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Date: Thu, 30 Jan 2025 13:36:28 +0100
In-Reply-To: <20250130123432.4534-1-v.shevtsov@mt-integration.ru>
References: <20250130123432.4534-1-v.shevtsov@mt-integration.ru>
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

On Thu, 2025-01-30 at 17:34 +0500, Vitaliy Shevtsov wrote:
> It is possible to set both MONITOR_FLAG_COOK_FRAMES and MONITOR_FLAG_ACTI=
VE
> flags simultaneously on the same monitor interface from the userspace. Th=
is
> causes a sub-interface to be created with no IEEE80211_SDATA_IN_DRIVER bi=
t
> set because the monitor interface is in the cooked state and it takes
> precedence over all other states. When the interface is then being delete=
d
> the kernel calls WARN_ONCE() from check_sdata_in_driver() because of miss=
ing
> that bit.
>=20
> Fix this by overriding all flags if MONITOR_FLAG_COOK_FRAMES is set becau=
se
> this flag is incompatible with other monitor flags being set.
>=20

That seems wrong, reject it instead. Anyway we should probably remove
cooked mode.

johannes

