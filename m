Return-Path: <linux-wireless+bounces-22918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B40AB585C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 17:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BE97B398D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787D1C861E;
	Tue, 13 May 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Gn+Tab7H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887C2BE7D0;
	Tue, 13 May 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149258; cv=none; b=WUC5b/zbTfEvVo5+hovwsxh0HRdapNSoGe4jjVtHKQ87wMb+PsWeY0vVKPaB59zXn0escn3XUq70I3239eouqnHHM1z2bogELOPpbyYH22hgKqa2U2FDtKQUo23+QnQUwVmrzTe0XzvIONPpsVaDw/63XVxbesyf41Ngadhl/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149258; c=relaxed/simple;
	bh=QrWmoCDKJXEQDgKy2rmxXvTY0nLRibUW7cYY9xMNagU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3cpEw4Mww654gPUQ/LxKUDUCnYHAe7NgJL5YL40NPj6YRsXuKSsYh7fJ0w+7pwBZxXMqHh3oeZoeyxQx9W+Eh1jRPq23K5LeXCYIMll/t9mEO1lijEGVODq1z8QHFS0k2sXCSWaWJXEzI9PxSXLmeQ2vwGbjNCcgas/i3gdkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Gn+Tab7H; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jk9WfFaLDrty3mZlWnEen8DfIEBvTmXjboHh8bZUisc=;
	t=1747149256; x=1748358856; b=Gn+Tab7HAR0cVwrh2PvmrzJ6HXx/hcjBAxNiR6pdE8OOBB5
	K4YmsGFfZ/Q54LN49ZcAG7e8IK0ItfU9YnrfO6b8hOF7HBY2jUo71ulELBES8s/jkS8TKa7v+GVM/
	CDHtKOxmG4aNzfQMq2oK1ZYC+2NfgrbQha3CM3A0A75sldmK/kzImYs/5Gxp2gLeJD90zZWwoMMKI
	z6mnuj+PS4zn3l9d7ysGNCkpir/l/z2XtWhHy8PoWgh2XAQ1pJM849YUoTSjTBpxWpVnLonYo2O6v
	ToWWKnA46BisvGPknw+VCYs1RGdCyjLTHf4oZMkAhBTy5sdbM+kBIxiXJMh6mL1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uErKf-00000005o0z-0BlJ;
	Tue, 13 May 2025 17:14:13 +0200
Message-ID: <78e9e1d3eb36ac5f90f9fb826287929a75e2127e.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Denis Kenzior <denkenz@gmail.com>, Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
Date: Tue, 13 May 2025 17:14:12 +0200
In-Reply-To: <f413e1d5-a10b-4317-86b0-2c1cb0dc3df7@gmail.com>
References: <aB30Ea2kRG24LINR@archlinux>
	 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
	 <aB4HC8Iaa6wR5dj7@archlinux>
	 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
	 <aB4hMsBfyawYatoj@archlinux>
	 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
	 <aB5onavenLymR-QJ@archlinux>
	 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
	 <aCMtCCYtNNl4dL5Q@archlinux>
	 <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
	 <eb59751ab2a22adc6237c05cb0a5519657498613.camel@sipsolutions.net>
	 <f413e1d5-a10b-4317-86b0-2c1cb0dc3df7@gmail.com>
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

On Tue, 2025-05-13 at 10:04 -0500, Denis Kenzior wrote:
> > I think it's expecting a confirm in response, but that was already lost
> > before.
>=20
> Sorry, what is 'it' referring to here?

mac80211

> iwd sends the Commit and Confirm via CMD_AUTHENTICATE.  You can see that =
Commit=20
> frame from the AP was received and then iwd submits a Confirm to the kern=
el:
>=20
> May 09 22:10:56 archlinux iwd[31729]: [SAE]: Sending Commit to 96:2a:6f:b=
6:d7:9f
> May 09 22:10:56 archlinux iwd[31729]: [SAE]: Received frame transaction=
=3D1=20
> status=3D126 state=3Dcommitted
> May 09 22:10:56 archlinux iwd[31729]: [SAE]: Sending Confirm to=20
> 96:2a:6f:b6:d7:9f sc=3D1

sure

> The kernel then transmits the Confirm three times, but attempt 2 and 3 so=
mehow=20
> never make it out over the air.  I find that strange since they should st=
ill go=20
> out, regardless whether the Confirm from the AP was lost initially.

By that time iwlwifi has given up on the whole thing and said it was
disconnected, I'm not super surprised that something is mixed up. OTOH,
according to trace-cmd, the frames _are_ going to the firmware and even
ACKed in the log:

 irq/134-iwlwifi-392   [002] 64416.251984: iwlwifi_dbg:          iwl_mvm_rx=
_tx_cmd_single -- TXQ 1 status SUCCESS (0x00000001)
 irq/134-iwlwifi-392   [002] 64416.251987: iwlwifi_dbg:          iwl_mvm_rx=
_tx_cmd_single --                            initial_rate 0x8100 retries 0,=
 idx=3D3 ssn=3D4 next_reclaimed=3D0x4 seq_ctl=3D0x30


so not sure, the PHY context seems correct as well. Don't think this is
the underlying issue here though.

johannes

