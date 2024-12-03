Return-Path: <linux-wireless+bounces-15860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838B9E2275
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3437A16B8A0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EC61F4709;
	Tue,  3 Dec 2024 15:20:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04B1DA3D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239214; cv=none; b=DvwZsp90wZaZB4Y+c1dXRDYtPrm2e+fO03NN4MSU9mavlqZsCYlVstb6bocmMQ5bid+8XHtHIw/rV5sEwV45YODTGgVarxVmL32dcEe/nFQ7mmRHXtnUeg/NL8vv4FMGDC4vwNFYCjMJ/P8BviPtA2o/ugnXRfkb1WaA1UJZITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239214; c=relaxed/simple;
	bh=Rwel+CPAN1EvhrUDTIQLtVBjBf5mu/zpBvul9mXq5JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7vLI3AITOOBI5XkY8fpXKftjxXnkpAOq9CZxQGBkCpWmrDPiXXHoQ/baRKBm+pDon+UM+UO3bLzHr0bm+OzUx/VbDkAZschDvXy52Q81YVW6u9ocAPdlUMqxxNdIUfdiL9dMv+SFIjXO9E85tlixu2KT0zMSv6l5wFzWC9271M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from prime.localnet (p200300c59742eEd82663beCA53814B0F.dip0.t-ipconnect.de [IPv6:2003:c5:9742:eed8:2663:beca:5381:4b0f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D8878FA132;
	Tue,  3 Dec 2024 16:10:49 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: lkp@intel.com, johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 Issam Hamdi <ih@simonwunderlich.de>
Cc: Issam Hamdi <ih@simonwunderlich.de>
Subject:
 Re: [RFC] wifi: intel: incorrect RSSI values on beacons from APs using legacy
 rates
Date: Tue, 03 Dec 2024 16:10:49 +0100
Message-ID: <7743427.EvYhyI6sBW@prime>
In-Reply-To: <20241125164034.2712936-1-ih@simonwunderlich.de>
References: <20241125164034.2712936-1-ih@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3848856.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3848856.kQq0lBPeGt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Issam Hamdi <ih@simonwunderlich.de>
Date: Tue, 03 Dec 2024 16:10:49 +0100
Message-ID: <7743427.EvYhyI6sBW@prime>
In-Reply-To: <20241125164034.2712936-1-ih@simonwunderlich.de>
References: <20241125164034.2712936-1-ih@simonwunderlich.de>
MIME-Version: 1.0

Hi Johannes, all,

just wanted to bump on this issue one more time. We basically want to 
passively receive packets and evaluate the signal strength, and getting bogus 
signal strength (-128) for DSSS packets makes this unusable for this 
application. At the same time, we would like to be able to use the 6 GHz band, 
but we can only do that when we scan to have the firmware detect the country 
code and enable the 6 GHz band.

We have found a way to get the RSSI reporting working, but only if we don't 
scan, as Issam explained in more detail.

This looks like a firmware bug to us, it seems the firmware writes the RSSI too 
late. We don't have the means to debug this further, though.

Is this mailing list even the right place to report this kind of issue, or 
should we contact somebody else?

Thank you,
        Simon

On Monday, November 25, 2024 5:40:34 PM CET Issam Hamdi wrote:
> We identified an issue where the RSSI values for beacons from
> legacy rates AP are incorrect, consistently showing -128.
> 
> This issue was identified on the Intel AX210 WiFi chip with
> firmware version "89.202a2f7b.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm"
> 
> To reproduce this issue :
>     - Setup an AP with legacy rates on the frequency 2422Mhz
>     - And on the device with Intel AX210 chip run:
>         iw phy0 interface add mon0 type monitor
>         ip link set mon0 up
>         iw dev mon0 set freq 2422
>         tcpdump -i mon0 -v
> 
> After debugging, we discovered that the RSSI values become
> correct when a printk() statement is added to the RX path
> in the iwlwifi driver, as shown the patch below.
> 
> Alternatively, adding udelay() instead of printk() also corrects
> the incorrect RSSI values; however, this approach leads to
> firmware warnings and errors:
> 
> ````
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> @@ -1543,7 +1543,7 @@ restart:
>          }
> 
>          IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", rxq->id, r, i);
> -
> +        udelay(500);
>          rxb = iwl_pcie_get_rxb(trans, rxq, i, &join);
>          if (!rxb)
>              goto out;
> ````
> 
> Additionally, we found that deleting all existing interfaces on
> the PHY and then creating a monitor interface resolves this issue:
>     iw dev wlan0 interface del   # In case we have wlan0 as the existing
> interface. iw phy0 interface add mon0 type monitor
>     ip link set mon0 up
>     iw dev mon0 set freq 2422
> 
> However, in this case, it will not be possible to execute the scan
> command with the monitor interface to prompt the firmware to
> trigger the country code.
> 
> Has anyone encountered this issue before or have any insights
> into the potential root cause ?
> 
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c index
> afb88eab8174..b0ce71e6260b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
> @@ -1544,6 +1544,8 @@ static int iwl_pcie_rx_handle(struct iwl_trans *trans,
> int queue, int budget)
> 
>  		IWL_DEBUG_RX(trans, "Q %d: HW = %d, SW = %d\n", 
rxq->id, r, i);
> 
> +		printk(KERN_DEBUG "Got new packet\n");
> +
>  		rxb = iwl_pcie_get_rxb(trans, rxq, i, &join);
>  		if (!rxb)
>  			goto out;
> 
> base-commit: 2b94751626a6d49bbe42a19cc1503bd391016bd5


--nextPart3848856.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmdPH3kACgkQoSvjmEKS
nqE3fxAAxr66zQAU16neGQeuysSu56UXLGpD6JCuAhLBHpFX+CDaltI0/klKtI5g
RCo5ZubTpjXcJm2nuLp+m5mHS2HJRcOolRaMnuNM8D3IvVr0Fts7Mn9IFZ0rzoWA
Md5rYAVz5ZpsDISQv70+wTQRNd5USd8YsQW/q+JJcaTz1h8UUjmbCoTIA/dfZCtZ
WPsONHddqXP9jco2XFzAgosBcxuI8R7GRkMCKpQe9aXYnSZRLuH5Hib5JUP84gks
mNK68YWP6zpvcHLcmnBSQdW5CSqpQ0ilIrIx+ArF7c3NDP7AXnrtpaMPXBEVkE9X
XLitSqFWVFjY2gATCBILne9sg+qqZkiP6vMIFBv2io5m8GKk02s3Ob/H1wBRl5xP
JbxuJRpMyUhyPw9qpOkV7YH00Yq/bAtTpqB0YA/F6h+P8zXNTgVe6dZrBMDN2EXD
/2eDm6ISO/RulztbPQgQD2i1VOgM/9frjbCdHsGiq8jQXz1NLv1gXFCu59v+qevO
Wm/chY5Mi9EVl1lHCu/bFIswmEwLm7ckClI33nFPJnoSSac+6M9imsgOao/pmfP9
n1yZXV9yYq4U3ncLReqkRzHO3w/SXFU3gzwREvPwwHR8urNd14d7gBCDGeaW6x5d
gOCmrRjODqYzc7hKM14lMb8sBlA3dS4qAQpLpaeEuQZ4EMSYoVI=
=NvVX
-----END PGP SIGNATURE-----

--nextPart3848856.kQq0lBPeGt--




