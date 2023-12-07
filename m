Return-Path: <linux-wireless+bounces-544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79732808953
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 14:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228C81F21338
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A979D40BEA;
	Thu,  7 Dec 2023 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jd1KSIQI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299F1AD
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 05:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j7xB4VKKFZ00zlEU2hqt8NhHYDvluPKVj9WaG+023nk=;
	t=1701956259; x=1703165859; b=Jd1KSIQIfHTQeuVpt05fD52FDGtbwzFY6RlPt8BWcRAYymI
	LnjZFP76OVQTOuSJ41AFg3odFgmkpXCEfQgzYfzWcB79BBSs0x3+ahooVCHMuNB0K7V8+mqWtFtlx
	csGvI6siu2iRkOsRIb1kgl823EhZ/OB8v1O36ENMz2xUunS7jf3jfJo2dr60lfYtoFjbKL3R6wjAv
	KoRJewJyYqcZfKK/ksjdNrZ1gUjFQ/4pEgf8W2+5t1E/F3Lfw7AGMFVhdAwEfOXZyv7FbzP1qz8Nc
	npQkAAzwM6SdhPVIaKTy6RxdIFWqqBdDH+ISLxBfbzIXwOcOLGSoGcqqt23t8gyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rBEZM-00000001QcX-0lbb;
	Thu, 07 Dec 2023 14:37:36 +0100
Message-ID: <0891030abb35a6262c4bdf2d81b99cd85fd36e73.camel@sipsolutions.net>
Subject: Re: [PATCH 00/13] wifi: iwlwifi: updates - 2023-12-06
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Date: Thu, 07 Dec 2023 14:37:35 +0100
In-Reply-To: <87lea65e40.fsf@kernel.org>
References: <20231207025018.1022929-1-miriam.rachel.korenblit@intel.com>
	 <87lea65e40.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-12-07 at 15:36 +0200, Kalle Valo wrote:
>=20
> From: Miri Korenblit miriam.rachel.korenblit@intel.com

Yeah, it was a misconfiguration.

> https://lore.kernel.org/linux-wireless/20231207025018.1022929-1-miriam.ra=
chel.korenblit@intel.com/raw
>=20
> And on my end something changed it to even more strange:
>=20
> From: Miri@web.codeaurora.org, Korenblit@web.codeaurora.org, miriam.rache=
l.korenblit@intel.com
>=20

This was the list, I mentioned it to Konstantin but he said that's
because all the hosts running Linuxfoundation stuff are still called
names from/for code aurora forum.

johannes

