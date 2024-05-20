Return-Path: <linux-wireless+bounces-7846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB18C9F5D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B641AB22743
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3DC1369AF;
	Mon, 20 May 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O2EYmDoW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058928E7;
	Mon, 20 May 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217827; cv=none; b=piDhX7ljjbauhHVYGeD2hUnPXDUxvc96cpoWMwC/B2D4eEzXkUMzPJBn36PayF3x4mvCqydmcb1GSFM4IV1YAoMacJCuXJYsGpbhW6N17Xek1zGqOEXpuqX+B2elUU44UEg6oM/Z/XWsaCKp+waiBK0pzlqkkmAkl7ZTGAEyfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217827; c=relaxed/simple;
	bh=FpgQSbHQrq5k+ftN48UvraFvAUIVHl5RxgGpidd+SKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nyCuHSltlAL+k7D/EkgTDqEYD6jCT3Zjgsr2UBB1otKgiFiY3ZxjgFx4FO/6iYZ/NOQ4OpwdmOEwfGLxvjfmNE7j/aDGytXG5IiiVAtjUnLh6Y6aMOCJsSnfgzYWx6WiO5kvolJ/O9ctNgOQTF10OcNGtqLYUAGVAP94fIR/vXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=O2EYmDoW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zbIUu8grEpUBcL1Az/6gF7Vb2ioV7yl0KREtP7MddK0=;
	t=1716217825; x=1717427425; b=O2EYmDoWm/VrBSl9PtEeOGW5aEsXvs1xLra/4Ghzd9vhipF
	WJTa1ZW+QodFi4SHIcdH3Gu2UYupkb+b1AEtHZqOssgcTi9a3uuW9uAt42J5XSmOkcbj1j1NFEdD6
	lWg4c2zP5IlfE+dZIu80rrkiMUUIC6YwivUNygEoksGjbsBw/VKKEigR5XKGlAlBJA/p2StEGwtcg
	bbyi36r9dk/BZAmcTy47UTIfX1h2cO5T9xYfMpFv6QdHPZnLpdpP04XjUOIBn7y0m7G9CIWw1ixcw
	XjSYRaftqLDYka/oSqRuGRyh7fxXiGk8dbRiNCqODWCjErFoCZsFmiS06xOwcfSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s94eZ-00000000REN-2hkD;
	Mon, 20 May 2024 17:10:19 +0200
Message-ID: <daf3e4248061c21db623be84136f3da1da5de513.camel@sipsolutions.net>
Subject: Re: [WARNING] memcpy: detected field-spanning write (size 1005) of
 single field "&out_cmd->cmd.payload" at
 drivers/net/wireless/intel/iwlegacy/common.c:3173 (size 320)
From: Johannes Berg <johannes@sipsolutions.net>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	 <gustavoars@kernel.org>, Xose Vazquez Perez <xose.vazquez@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Mon, 20 May 2024 17:10:18 +0200
In-Reply-To: <20240520150857.GA709412@wp.pl>
References: <2c534d01-449a-43f4-9216-eacdb3b35577@gmail.com>
	 <20240518092939.GA643846@wp.pl> <202405181033.6399B7E416@keescook>
	 <20240520073210.GA693073@wp.pl>
	 <95f3e147de837b4833e6cf6eb67108f96640af4e.camel@sipsolutions.net>
	 <20240520150857.GA709412@wp.pl>
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

On Mon, 2024-05-20 at 17:08 +0200, Stanislaw Gruszka wrote:
> >=20
> > I don't think this is right, now the raw comes after
> > DEF_CMD_PAYLOAD_SIZE? You want it to be a union with payload, I'd think=
.
>=20
> Not sure if I understand. I think we have union with payload with=20
> the patch. The structure looks like this:
>=20
> struct il_device_cmd {
> 	struct il_cmd_header hdr;	/* uCode API */
> 	union {
> 		u32 flags;
> 		u8 val8;
> 		u16 val16;
> 		u32 val32;
> 		struct il_tx_cmd tx;
> 		u8 payload[DEF_CMD_PAYLOAD_SIZE];
> 		DECLARE_FLEX_ARRAY(u8, raw);
> 	} __packed cmd;
> } __packed;
>=20

Oh, sorry, my bad. I confused the tx_cmd and the cmd_header.

johannes

