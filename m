Return-Path: <linux-wireless+bounces-8426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DEC8D8487
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066931C223C9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213522075;
	Mon,  3 Jun 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HRfPJWLO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE01F60A;
	Mon,  3 Jun 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423270; cv=none; b=AQVjNCZu6pJVgLgqXDgxP4HvQzFUXz8Jd6Hv1hE601pcleDm1Ud5n2aMu4VSE1pbDHzWUuMy2t9JLAVHdLqKfjGE3Ru+Ox29Km7wwsm2MxWANJcWI4e4HVjiApLr6GHLdkwnXFfzK3Y7aoHV7sHdNKDYAAlVDXRikMOPMiz//q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423270; c=relaxed/simple;
	bh=KigDkYlUVYPi4VN0FAZUwqLgtCcxe8P3YdnN1njj9/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjvBr5ZyKgdOKtTe/b4Cm+W5/f7QopTgUp2a83Y2zAh+pbr0Yx+/IB3urSVWZN2a0kEBT7Z9OpVE6dOcZQBa7MEkR+7zzfv9OGr/u4hOtQcO2gWTudNr1hi2XIYTJz3f0fpJKtwFW0zMskb6ad7QOH3dIh5GyTcRz1R69CIal+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HRfPJWLO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6kJmTBIsZBFDNMW5B06DOo6mCcxLehfhy0Mtld07+lw=;
	t=1717423234; x=1718632834; b=HRfPJWLOrivt0ckOtGb1GNlab96wxOPm+QOmGzGLNpWfLwu
	jLrX3WjFG4FplBi0h7b5YXidvTFpRRMa/j2bnYnzHGHiK8My2VpiQkpiqxvtVTPVHZ2UOXHXWFrHl
	NvDIXONFmlH+mnksuIsT7eVSSjGogkRJpzNypfBiI/Gd1o3sjqjg/5yp2xSVsa9hp70HRmsh2kNon
	9pB3HdWbH6fTZtR4V3oyi4wONqj3HXYJ2ExJ93PpMv7F/uRT99QdwgotKQx+oyE8ngDsGmwlOZa3v
	Q7BqXK5A9IIjNQ7beleklLU8pkIZEPTXxIpRd6TS93Lj4Gxu86eNUEU1vE9R4SBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sE8EX-0000000A2ab-2BZw;
	Mon, 03 Jun 2024 16:00:21 +0200
Message-ID: <3ce1e435e28b1c7fbec9e8009b0c52ca8c9c730b.camel@sipsolutions.net>
Subject: Re: AC 8265: Microcode SW error detected. Restarting 0x82000000.
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date: Mon, 03 Jun 2024 16:00:20 +0200
In-Reply-To: <6f5b433e-889d-4d24-ba59-5df89f3ba4a5@molgen.mpg.de>
References: <6f5b433e-889d-4d24-ba59-5df89f3ba4a5@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
>      [   12.828399] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band  Wi=
reless AC 8265, REV=3D0x230

>      [   13.509514] iwlwifi 0000:02:00.0: Loaded firmware version: 36.ca7=
b901d.0 8265-36.ucode
>      [   13.509540] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND

>      [   13.513527]  iwl_mvm_send_cmd_pdu+0x58/0x90 [iwlmvm]
>      [   13.513552]  iwl_mvm_sar_select_profile+0xea/0x160 [iwlmvm]
>=20

I think that's probably (also) fixed by=20

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3D788e4c75f831d06fcfbbec1d455fac429521e607

johannes

