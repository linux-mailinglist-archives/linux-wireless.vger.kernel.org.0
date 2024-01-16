Return-Path: <linux-wireless+bounces-1973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76BF82EE08
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 12:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186B11C22308
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D9F1BC25;
	Tue, 16 Jan 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Btb2fs00"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270791BC20;
	Tue, 16 Jan 2024 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0OCZPW6BtUdee4wcdmdcNhZkbu6nqvpWo+Hiv6o8ilQ=;
	t=1705405447; x=1706615047; b=Btb2fs00mYKLl4zp+7z7mvXrfVVlJ+cegj5+sWweRYmJzOc
	JlldMwwUeMofcxeW9Awr2qt8/ylt9BXcuqNFtNp/tb+Q+ZsGzYHl4DIYiDB0DNTE0wUY2b9SLwxaI
	hqBHJNwf6dcTB5SWj/L0edWPAz0JIH3Krb5arY+pZ72YW2eFUKXcSCw47JoTzUu0bzDCVfXtWfSbd
	As/4qieHUV7jv6X8qwDqAqy1Wkc9RSDYWDAox1HeVTPqIRzdvNH5rzHmc0VgPoDlGyU80nVXezPn+
	s+Fq+wEusJfmzH2OFEEuQb2Hv2h0DuODQUL/6Yo/jsLd7pOzzIMNWLe0oCGLUkVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rPhrJ-00000004vh7-46DK;
	Tue, 16 Jan 2024 12:43:58 +0100
Message-ID: <d14d6b4c02282d6ef48a936b1ac8be71c80a8835.camel@sipsolutions.net>
Subject: Re: [REGRESSION] 6.7 broke wifi "AP is in CSA process, reject auth"
From: Johannes Berg <johannes@sipsolutions.net>
To: coldolt <andypalmadi@gmail.com>
Cc: ayala.beker@intel.com, linux-wireless@vger.kernel.org, 
	regressions@lists.linux.dev
Date: Tue, 16 Jan 2024 12:43:56 +0100
In-Reply-To: <CAJvGw+ATM3B09KbuLM0VsmU9GZRSO-ZP6ffwvvOa75xVHR3-kw@mail.gmail.com>
References: 
	<CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
	 <dae4bb032ad8b0c9fa6547de5e869e51f9f6e766.camel@sipsolutions.net>
	 <CAJvGw+ATM3B09KbuLM0VsmU9GZRSO-ZP6ffwvvOa75xVHR3-kw@mail.gmail.com>
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

On Tue, 2024-01-16 at 01:56 +0200, coldolt wrote:
> I can try to keep connecting for over 5 minutes, it never connects,
> keeps outputting the same dmesg message. The kernel before 6.7
> connects immediately.


>         DS Parameter set: channel 36
>         Unknown IE (60): 01 16 24 09
>=20

So it is indeed - as expected of course - advertising that it's about to
switch channel and even saying everyone else needs to be *quiet*. This
is

struct ieee80211_ext_chansw_ie {
        u8 mode;
        u8 new_operating_class;
        u8 new_ch_num;
        u8 count;
} __packed;


so mode=3D=3D1 indicates quiet, new_operating_class/new_ch_num are actually
the channel it's currently on, and count is 9.

Can you say if it actually changes the count? Maybe capture on channel
36 using the NIC as a sniffer what it does over time:
https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#air_sni=
ffing


Initially I'd say though that if this situation persists, then your AP
is having some problems and we'd not have stayed connected without the
patch in question either. If you want, maybe revert and see what the
symptom is then?

johannes

