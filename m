Return-Path: <linux-wireless+bounces-17191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99FA05783
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAB81886D8D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7801F708D;
	Wed,  8 Jan 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Op2LBewi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CC1F6684
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330224; cv=none; b=Oqz8mYQS+MTnoy4T/XdsCGdyXFaLjhz2mISkNK+0ojEeQ8PUknYhExEprUxuCueyz+VTP7obGscub3XU9MCyBfWrCcJHjnFz+RAbvHsBzdRS9JhclFrLzZY3xEAjGyKkwV5//t//WZ0n0Xm+0AurhkAwHNYSHv9iotNWHfHixfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330224; c=relaxed/simple;
	bh=SuAYiDRqVQnE7XVE8O5FQn/tZL1Ko75u6BC3mzcxFFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7MgTDHKR0h/D5AxU93yECUepBPIYiaP47K+JvPx7AirGuD/2NHSZM1qQcvHyhSKdALobeWiN2fpF3dxvAEpObjOFniFMwFg1H1yY6ObbofgebLFMv+uDjEkCZJgbr/jKOjwuwfmUiP1xU/LUYL2CI488GaTnRcPA2dMhzlLqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Op2LBewi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SuAYiDRqVQnE7XVE8O5FQn/tZL1Ko75u6BC3mzcxFFA=;
	t=1736330222; x=1737539822; b=Op2LBewiIdcyKcXD6EztP0mjpxAVpixeT/dzJ0tid1ybuEA
	OsV6aXnsKZqRaYXsumRS8HMIFlF5Hv7IbTQKtuekwR3IsPtms9VCnXe7FyM+7aXLI1OVgzdS+s6ln
	P/0OVMq/mo3JwrYxarBcEE77nkWZkHxE17ASd4DqJ9CcpKKl0qafCWZekfzEDvMMY0UI7MyeIW1+Y
	ZUS4bj2YJ+oegyz49y8I16BD4ZmJzhfZaNJ11FQP4RPXiUDIMqeZ3XyW0fwBzCBiZAkx1sJCcLoE9
	/x0vVPES9r3Yqjd0dBS8d32+VN+RsDTZtSc7ig4QivxnEInhwxuOF9N/iMDKA0sA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tVSo7-00000008BkH-1Tj3;
	Wed, 08 Jan 2025 10:56:59 +0100
Message-ID: <bf5019f034214f5ef81adb9993a92377bb080885.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: rearrange kernel document for sinfo
 structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Sarika Sharma
	 <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 08 Jan 2025 10:56:58 +0100
In-Reply-To: <53c80072-319c-4a5e-ab40-4a61f0ef022b@oss.qualcomm.com>
References: <20250107041727.3810446-1-quic_sarishar@quicinc.com>
	 <5f774e0f0e00138240108bc0e4028b588e1ac927.camel@sipsolutions.net>
	 <f7738ed3-d27a-48a8-b0cc-cb52d47e54f9@quicinc.com>
	 <00982f1dfed63df24aa5d836fad1c577201754ed.camel@sipsolutions.net>
	 <53c80072-319c-4a5e-ab40-4a61f0ef022b@oss.qualcomm.com>
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

On Tue, 2025-01-07 at 07:40 -0800, Jeff Johnson wrote:
> On 1/7/2025 3:12 AM, Johannes Berg wrote:
> > On Tue, 2025-01-07 at 16:03 +0530, Sarika Sharma wrote:
> > > Actually, there is ongoing work to extend sinfo for link-level detail=
s.=20
> > > While working on this, I noticed a documentation mismatch and decided=
 to=20
> > > correct the existing documentation first, as it's good to have aligne=
d=20
> > > structure and documentation.
> >=20
> > Why do you think it's good? I don't even agree with that. The code
> > should be laid out to minimize holes, but the docs can be laid out to
> > group functionally related fields.
>=20
> Without any documented guidance to that effect

Yeah I don't see anything either? Though kernel-doc certainly could
complain about the order if it wanted to. I tend to think it doesn't
need to match though, per above.

> I had suggested this during
> internal review to help minimize the size of the diffs where members are =
being
> refactored out of sinfo into a new per-link struct.

Fair enough.

> But we can drop this since I think we'll be renaming some of the refactor=
ed
> members and hence the diff will be big anyway.

I think we can also apply it if you think it makes things easier, I just
didn't think "it should match" really is a good justification. I don't
care too much about the order in the docs, but also don't see needlessly
changing it as a useful thing.

johannes

