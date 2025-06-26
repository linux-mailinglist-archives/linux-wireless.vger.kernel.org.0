Return-Path: <linux-wireless+bounces-24542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717BAE9D2E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1971C45AA2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8D2F1FF4;
	Thu, 26 Jun 2025 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BfJkALtX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509B2F1FED
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939275; cv=none; b=ZdRB/XV9CzU7xuRyOhbbTnEEMVhF1TBT/mfQ6qaRtWuIknVIhhrxz5pzyXGscPmNvUkZyW7qy3PmDVLyE3i5hyj3pS4cwwjueta5/yNCFjXqS9yp0Y/wVsuFnEz1CgJ37lPgsfKIeop+nqRorQKdvN7C+KrwkI+5o0B2m51XvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939275; c=relaxed/simple;
	bh=l+ByRGcDMrSLn/AaJSbuwnl1jrC5KPjWiIEvpFvdWP8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngeqDB6rwD4ROWbU5dHUihsVnMACG+tr0Uv2HnYMril99COGGW6ZHybpmqi5CgSiTD6ezKTXa7+x8xak/Vtdmqj/GsFVNRsZNprAr8ljeQjUi0j7UFRKiXpmDsV0kY9D59OXUlEebFc61Lgl5xvFUFtvbWw5cWq3erOHb64NqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BfJkALtX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+YqgEhIgkRHqoMsFILxGv20lxrJ8lnBozS/U80sj2J0=;
	t=1750939273; x=1752148873; b=BfJkALtXa53WhYflB+/TW+NBnkFsY8aT/au1m3ywCT0wmM+
	glJ3Pu9lmBK8tNvXKDFHiwO4DaKpwtDcCZtedBlFsdejSGmYqlEvjtUrjSoXRmP/mD1q2d7YlJhMt
	D9yD/yzom/zwBMPvwdLFKV5U10gwBgffSzjHRshb0W4H95/d9FzHguwXLvJIaFdRjw2qKboXKmOYY
	GPENJIHJfNj9Pad3XzCHX458Z11PsmPPwHPogQMCxvFRieVneG0nQJsH9uSi0Rd+KZ8LLnv8l/BHn
	mzQIGeSULSyTbOjo+dLXm8enNlrxa6pS8otAyQt2Bwq5XAkTp+0xS0m9mf9oYJZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUlHr-0000000BVCx-26m7;
	Thu, 26 Jun 2025 14:01:03 +0200
Message-ID: <1450bfa2265e8609699a70a493209091873040cc.camel@sipsolutions.net>
Subject: Re: [PATCH] iw: add support to parse 6 GHz channel
From: Johannes Berg <johannes@sipsolutions.net>
To: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Pradeep Kumar Chitrapu
	 <quic_pradeepc@quicinc.com>
Date: Thu, 26 Jun 2025 14:01:02 +0200
In-Reply-To: <344daf44-525b-40c9-a570-fe659717d656@quicinc.com> (sfid-20250626_082958_208216_65C41DE0)
References: <20250620073240.2770468-1-quic_surapk@quicinc.com>
	 <220639a5bbf43c125ef114c6ca8e71d050125cd6.camel@sipsolutions.net>
	 <344daf44-525b-40c9-a570-fe659717d656@quicinc.com>
	 (sfid-20250626_082958_208216_65C41DE0)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-06-26 at 11:59 +0530, Suraj P Kizhakkethil wrote:
> Adding support for the 'set channel' command provides users with the=20
> flexibility to use channel numbers instead of frequencies.

Sure, but who are "users" here? Most people we'd normally describe as
"users" will never touch iw. The users here are mostly us, who work on
wifi in the first place? There are some corner cases like sniffer
though.

The thing that might've made some sense here perhaps is the automatic
center frequency setting that you get if you just set the channel and
bandwidth, but I think that also works with center frequency, so my
example should be also possible instead as

  iw dev wlan0 set freq 6195 80MHz


> If you think this change is not acceptable or needs modification, please=
=20
> let me know. I=E2=80=99ll either drop it or make the necessary adjustment=
s.

I just think it's really quite awkward to do in the code and unnecessary
as well. _Maybe_ if we were to do something like "6ghz:5" for the
channel number? But I'm not a huge fan either.

johannes

