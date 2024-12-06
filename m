Return-Path: <linux-wireless+bounces-15960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE79E6AE7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 10:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956CB283AA2
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB02D1FECBF;
	Fri,  6 Dec 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wD2/yyWU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC791FCFDB
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478213; cv=none; b=G7vqHYOUKn6e1oITSyKazbYfuHHAb6pmRXKihQTlHq9YjJ9tTX9osaff4D4N/0LDHTJLGsz9YohLaMJy4sAd5q8EAoAYcJIOHz+Ot9LS5LtcgABcV4Xj5cRh4VLicaMsyf1obw9tVJ/I8i2t5rHE0VL8QdH57hlp+TGN2b/YqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478213; c=relaxed/simple;
	bh=xdMsT7vuD9KDrUHZZXNJtxuWA21VmDcDvJaohhePJT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRaNDFgJsrS+q8093TBGj7NoCUKhL6EDZfjFVvHrEuUwaFtyOhR0e2DiCOwBihb5awNNoTWf/6lbGPBwx547DUdgYSAUD0P7w2RXLd6tLZ/fCGFrNI4eM7O0nn6Iob7y/sV+QTq1K+eYVRuOEDO94we3GilN665WbeFXnLBtpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wD2/yyWU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vn6eAcc/Df9aTtdC+IR6dlR6plPxlvckOJhPc50WJ0M=;
	t=1733478211; x=1734687811; b=wD2/yyWUnntRbyUtHVvx2vhHsWpWnhyASkTsq6Dkj9T+KDq
	XCCh2LmHBAs5QWwnEHaL7A6GrJM37e/MO06MSR8BulSuDa3GDz3xrmnRzVg0uDA1z8DoD5vdJlcgM
	PwpWIlaNKBlBgKyWLp36KfJs6LbLKU/Z/c4+8ZlnN2+/xHdHCEl+7GTWDkWRU1+H/z0jnGs/oneAz
	PPmTtjVAJMG5zEtXHMz79wwA3m7intjvluFKuvJwk9/DRM9aLmO+jAUj1PA2l+5m2R5zXgOW3Kw0j
	joBYonZWpSZc4UZ9RunlFeGADogE2fvxb5AAvJOPaDiaejT0zAfGlIhiDCbCh1ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJUrr-0000000FNBL-01KY;
	Fri, 06 Dec 2024 10:43:23 +0100
Message-ID: <4c127a8e7e03882c4b26e480350453ef5a59ff54.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless:  Remove adhoc and beacon_int_min_gcd
 check.
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Cc: nbd@nbd.name
Date: Fri, 06 Dec 2024 10:43:22 +0100
In-Reply-To: <20241205225502.878928-1-greearb@candelatech.com>
References: <20241205225502.878928-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-12-05 at 14:55 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> This check keeps mtk7996 from loading.  If someone thinks
> they can get ADHOC to work, let them try it.  If the
> kernel really needs to restrict some combination, then
> it should be done at time user attempts to actually
> use that combination, not at driver load.
>=20

I disagree, the driver shouldn't advertise non-sense interface
combinations that cannot possibly work correctly.

johannes

