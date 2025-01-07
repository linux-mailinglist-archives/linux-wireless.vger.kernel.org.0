Return-Path: <linux-wireless+bounces-17142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A553A03D56
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67703A4C1F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B21E231F;
	Tue,  7 Jan 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U5QlboDc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00E1E32D3
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248332; cv=none; b=K/+zcNYcdbkTxL1/AwTYdwPiD3QKh1J4wSDDzYuJV6HalYUNhseq7Xa0HrTg4VlWH0UKZ5JuKbEEIh/a6NBNN99Smf0LMWsOVmLgT46vs9rnFwaxfLxU8S21tf6pdERV6JYEmf1ciqE607J667/xzSYg+hyoAmomCGSm7mpzQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248332; c=relaxed/simple;
	bh=jBohdYlqNvv8XkZXKNhgTFHa1ol71i9DUpyprh/UAJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QOV/GQ3pPw0hkFRGCUWwMYwRbGrEAmlce4yO+vrbw+lTWtu3HjILBsx3EOYsAtLaFSrBJX7POKKvnUmiJX1SC7SY4DoD1VzRtoOdln1jiS0Q4V9hB5li3E5JMvOmAyZbrKt3UZhE5WI5iQHXojpO2CaUMhfcc5KqTDDCAmX0y6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U5QlboDc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jBohdYlqNvv8XkZXKNhgTFHa1ol71i9DUpyprh/UAJ8=;
	t=1736248330; x=1737457930; b=U5QlboDcU/ueDldwLK6VSoMGL2zJusue3ioqT/ZXX33aBFf
	T/RzUq8oXEmdM8C/J1XcdYiP4BrK/pQ/Q3A51XES9iARogL1QXXnQEk2ip2gER4Iv1rqm2TImXsgV
	bCm9r90iydUvT8NJLi3rCLpMISsB0awTYb827gxxg9Rsn+a6AIlhje5Yg41qOYVTygnedyfzCJ0Tl
	WoQi1GjiMHL5BTR78c1IRuVOXQJ3CBQTIFxUt/wU/G4/U1ZPu4cQahMbnVJTdEQf6i2b8RwtEethO
	AykL0SiDrqAuG30TidDDCTWWPtPFaN4cQQ1DLC9HAhJNT8SEaQVuuM69JIfvRHvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tV7VG-000000078xr-23ev;
	Tue, 07 Jan 2025 12:12:06 +0100
Message-ID: <00982f1dfed63df24aa5d836fad1c577201754ed.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: rearrange kernel document for sinfo
 structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 07 Jan 2025 12:12:05 +0100
In-Reply-To: <f7738ed3-d27a-48a8-b0cc-cb52d47e54f9@quicinc.com>
References: <20250107041727.3810446-1-quic_sarishar@quicinc.com>
	 <5f774e0f0e00138240108bc0e4028b588e1ac927.camel@sipsolutions.net>
	 <f7738ed3-d27a-48a8-b0cc-cb52d47e54f9@quicinc.com>
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

On Tue, 2025-01-07 at 16:03 +0530, Sarika Sharma wrote:
> Actually, there is ongoing work to extend sinfo for link-level details.=
=20
> While working on this, I noticed a documentation mismatch and decided to=
=20
> correct the existing documentation first, as it's good to have aligned=
=20
> structure and documentation.

Why do you think it's good? I don't even agree with that. The code
should be laid out to minimize holes, but the docs can be laid out to
group functionally related fields.

johannes

