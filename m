Return-Path: <linux-wireless+bounces-3952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD6860F28
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7040F1F25881
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA285C8FC;
	Fri, 23 Feb 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jc+F2rTT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33EC5CDC9
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683894; cv=none; b=QJb1HdkOBNAJLepr2fzF1YS6tmUlh5b2JF5wGdWGftzq3NmdtWGTPuo5oXAMicafJ/k9UWDVuM7MX0TBs5b13LPE62Bj8gch27WHIW7DkR9yJ5bgKTJQM3TRDPte8gT22g0IlVBGZ+O69wwmfTICaK4khljtT3IQMBkKTWnflHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683894; c=relaxed/simple;
	bh=seHIDCaE09IrD+Kzps1y8HBnkWqbAxe+/oLoH+5V3wU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOKHnkNaDl/ntT6VWqByiuNx4w0nvBKA+IXECSXAYvWkDCW2DOEUVZ1xj8H/AEKA0NKvTATDHiZFlBUxCPOk4skiRc5PaQL7+m871bImPRxneAJtd7LaRPTuhEVJ1IscEK8s7mMb9AayFjXf8Mw8Q7e+MU9JX/jMhF4qd5aF8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jc+F2rTT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sp2B4D9/0w1QTOZortpqHMVQ4ts9mYrEajVEaf5OebA=;
	t=1708683893; x=1709893493; b=Jc+F2rTTv66klLams65ieeRAIFPgeloFimkdZ0IbBREq9Gr
	rpSVwahe7YdQoOoOVzan+6C6Roq7Q3zKW1G5gEDNLFin9mNdjGBdF2g8ICiz2CM7gUNytNV9xO/PJ
	dZD+8wwrXK1W858kNfFZyROjqkgns0Qr0YuPzofDvVTA3xmsFR/9js8VRcibzpCLigXpgR7z6zBuI
	p7oEcrz1SQUR4J/EjBdQiHIuYI0IHX9oYK5uGiQNsOj5EljSzcib+aInttLzcRtwJihQn3+ZZc0aO
	+DOvLMtUgJaguovIXI4Dmf3MCMpMwmz+6h8EsMtbqFLyLGNrfUWoOzGnx6rJabjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSjZ-000000051Gr-3mwB;
	Fri, 23 Feb 2024 11:24:50 +0100
Message-ID: <43aa9b89d5066d9a81b8f9d8e5e60124cf84193d.camel@sipsolutions.net>
Subject: Re: [PATCH 8/8] rsi: miscallaneous changes for 9116 and common
From: Johannes Berg <johannes@sipsolutions.net>
To: Siva Rebbagondla <siva8118@gmail.com>, Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, amitkarwar@gmail.com, 
	krishna.pedda@redpinesignals.com, Ganapathiraju Kondraju
	 <ganapathi.kondraju@redpinesignals.com>
Date: Fri, 23 Feb 2024 11:24:48 +0100
In-Reply-To: <20190403041309.12829-9-siva8118@gmail.com> (sfid-20190403_061346_533049_3118E7F8)
References: <20190403041309.12829-1-siva8118@gmail.com>
	 <20190403041309.12829-9-siva8118@gmail.com>
	 (sfid-20190403_061346_533049_3118E7F8)
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

On Wed, 2019-04-03 at 09:43 +0530, Siva Rebbagondla wrote:
>=20
>  static int rsi_usb_reg_write(struct usb_device *usbdev,
>  			     u32 reg,
> -			     u16 value,
> +			     u32 value,
>  			     u16 len)
>  {
>  	u8 *usb_reg_buf;
> @@ -226,17 +226,17 @@ static int rsi_usb_reg_write(struct usb_device *usb=
dev,
>  	if (!usb_reg_buf)
>  		return status;
> =20
> -	usb_reg_buf[0] =3D (value & 0x00ff);
> -	usb_reg_buf[1] =3D (value & 0xff00) >> 8;
> -	usb_reg_buf[2] =3D 0x0;
> -	usb_reg_buf[3] =3D 0x0;
> +	usb_reg_buf[0] =3D (cpu_to_le32(value) & 0x00ff);
> +	usb_reg_buf[1] =3D (cpu_to_le32(value) & 0xff00) >> 8;
> +	usb_reg_buf[2] =3D (cpu_to_le32(value) & 0x00ff0000) >> 16;
> +	usb_reg_buf[3] =3D (cpu_to_le32(value) & 0xff000000) >> 24;


The cpu_to_le32() was wrong here, it's already contained in the shifting
that happened here ...


Easier to just write that as

 __le32 *usb_reg_buf;

 ...

 usb_reg_buf[0] =3D cpu_to_le32(value);

however.

=20
>  	status =3D usb_control_msg(usbdev,
>  				 usb_sndctrlpipe(usbdev, 0),
>  				 USB_VENDOR_REGISTER_WRITE,
>  				 RSI_USB_REQ_OUT,
> -				 ((reg & 0xffff0000) >> 16),
> -				 (reg & 0xffff),
> +				 ((cpu_to_le32(reg) & 0xffff0000) >> 16),
> +				 (cpu_to_le32(reg) & 0xffff),

This change also seems completely wrong, and we should probably revert
it?

johannes

