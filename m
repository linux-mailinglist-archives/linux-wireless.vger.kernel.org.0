Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAB44290B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 09:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBICs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 04:02:48 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:49442 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhKBICp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 04:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1635839999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lneO6MOnA890bpMplZX2IMLAAqCaBUq03kGB6tLvVd4=;
        b=fbOd2HyVud33gpR5APffBCvZPTUeN4L/2NYfA6V9ZIK8x0wR+zDUZuaIlmjvVbFPO0V1mv
        0uXbNXpj8FXebwT517BpzXs+EcOZTUK72s9rDm6UG3vPEwm3lvtFPtyThzPHLSiEnbK4iV
        zcrobTXUkQIEZ56jzEehKDnfY6R7Sjc=
From:   Sven Eckelmann <sven@narfation.org>
To:     luciano.coelho@intel.com,
        Sharadanand Karanjkar <sk@simonwunderlich.de>,
        johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date:   Tue, 02 Nov 2021 08:59:56 +0100
Message-ID: <2019679.eXh7N0oMcK@ripper>
In-Reply-To: <12264353.XuppNRcviy@ripper>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14> <12264353.XuppNRcviy@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2770532.ap9d39JTAV"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2770532.ap9d39JTAV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: luciano.coelho@intel.com, Sharadanand Karanjkar <sk@simonwunderlich.de>, johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date: Tue, 02 Nov 2021 08:59:56 +0100
Message-ID: <2019679.eXh7N0oMcK@ripper>
In-Reply-To: <12264353.XuppNRcviy@ripper>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14> <12264353.XuppNRcviy@ripper>

On Monday, 1 November 2021 15:58:50 CET Sven Eckelmann wrote:
> On Saturday, 30 October 2021 19:17:38 CET Sven Eckelmann wrote:
> > [...]
> > Maybe 
> > there are even newer (test) firmware versions available but I am not aware 
> > of any newer firmware version than the previously mentioned one [1].
> > And this firmware was published for linux-firmware right around the time when
> > Vfg. 55/2021 was released - so it is to some extend expected that Intel didn't 
> > yet incorporated such a change.
> > 
> > I only saw newer releases for other HW [2] but not for Ty.
> 
> Seems like there was just a newer release with Sharadanand should test

It looks like 6GHz channels are still disabled in DE with this firmware 
version.

Kind regards,
	Sven

> [3] https://lore.kernel.org/all/19391a6dd10076e3a64aff20d68a9a37ac56e794.camel@coelho.fi/


--nextPart2770532.ap9d39JTAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGA7/wACgkQXYcKB8Em
e0a5BA/9EhU980dk1+yDr9GLafsaevE2iefdwMaaOwlD2gFyaiJfJUSCYggXeFoQ
1kyYup/kusZz66sQVIok5BfQg0kLykGUPXv/GV+gsjwG7abM+Uv6sVaykMimHIE/
qfolV+HIHFiRPUhi74nzNsGMLQyf5cL4YD1M+YQPsGTAnEcL2xCgRlWKhBJmTh5a
vgx7iFlHuZiJ2+TszjZcSjkHWY3OMzsmf07vZwlIJ+/SpEru9R3nMbgNnb07cVPN
ymuGraZ/FpdnKkYQj45huzQR3dJa0p7E5bav4Vjh6GIibTifDNuarfMNJsNCcF8o
2xvLcIFTe/PAuATUUOFSnEwnZJQiFlACrRbJgzqW17A4Sx8C1CvLFoB+l5c9uLOx
BtyyN6alAvXVgQJs2h2m6WqSsktI7FLIN+ElT9pjDnhsrBtuWMgGB9gBEbadpf1Z
8reMFMHhoUC9N2Mn6yIzbnK0QFjKX/LibWT6kJJhYE5/v7eV/ZatpQitxmVupx4I
aZodbf0R3fjBNWreDxJ7+tn7GN621BOO8G2nUBPmZOU7XKsQzr9d/A5iharzQ3r6
7Sh17jRGPkwxdnz67uC/vApWV7Ld+aVJbjuTNbPxFAwDD1Cz8WF76Svd9h6j67sx
CaKqxfDeCnLVCxB5bj7pvNukWujiFkum6+ad+BvjOqQFk89Rh6s=
=CnTu
-----END PGP SIGNATURE-----

--nextPart2770532.ap9d39JTAV--



