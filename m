Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6D46908F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 07:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhLFG7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 01:59:48 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:46410 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbhLFG7r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 01:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1638773776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pv8TB+g588DsnRCeOefbPFBHB+8AgUI3a/uGs3NBbgI=;
        b=DU5yfbpKJd0GFi5j+ONXubahVsZsCyY3m+agwScwy8rSeoR8+EYzoFSYen7KAdvqAfCWL5
        1iUdHkBgeDUqsc/toKJ9mGMM5tqtoTRBpyMZ6Swe20X/78ynnzBgDRqxFk+K/yvk8DNrR/
        1uuWoovjCq5SEKQ2vYAz83gBlmxk2b8=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
Date:   Mon, 06 Dec 2021 07:56:11 +0100
Message-ID: <7418334.kqliQQpNxi@ripper>
In-Reply-To: <7318ffac-f5ec-4c1b-3e80-c816bdb28a79@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com> <1854698.r8H18GsEis@ripper> <7318ffac-f5ec-4c1b-3e80-c816bdb28a79@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6005903.RJP74QPFIO"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart6005903.RJP74QPFIO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
Date: Mon, 06 Dec 2021 07:56:11 +0100
Message-ID: <7418334.kqliQQpNxi@ripper>
In-Reply-To: <7318ffac-f5ec-4c1b-3e80-c816bdb28a79@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com> <1854698.r8H18GsEis@ripper> <7318ffac-f5ec-4c1b-3e80-c816bdb28a79@quicinc.com>

On Monday, 6 December 2021 04:29:39 CET Wen Gong wrote:
[...]
> I did test in my setup, not see the crash.
> 
> I am afraid you also need this patch("ath11k: change to use dynamic 
> memory for channel list of scan",
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20211129110939.15711-1-quic_wgong@quicinc.com 
> )
> 
> Could you apply this patch and try again?

Tried it and I see the same problem.

Kind regards,
	Sven
--nextPart6005903.RJP74QPFIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGttAsACgkQXYcKB8Em
e0ZZSA//WgYpkZW20C/AjhjDjbPmw9hGD93VZxE4PwscESBViXDLXTCCFMqB+jJt
x5sjOPQfIg6hXEkfIIUtW8tQi87/kmVh+LtLFZmnw/4yoYJjZoC17X8UQPjXGpXL
EMvrvi2N1hyY8K3H5Ke7AFsfYe7CdkcOGPkfbH/LZRD74Zw1ZB68ddkCHfLLeLDJ
WClfy25kzqU3sTTa7kCpMgs/QiYvOIhGPLBpNdhOKUmFSL9yrSeE5C2BRp7vkfh1
cu0WNjC4gWGn5h0zbYeZbUkzpSGB1THkLAMXCKX6/UEPXLFKkZ1kP/bCa9u/lduR
snFMov44SE+YGDssKdoxw9rZM5XlGb9+rwNSQu46vyY63XX/28Zc8ijvh+gWxUO5
kLvOsJBxrAWNAgD/gVn4uZmIYMb2dOggMXyESzJBjKv/XK4vpqrNbI+/eEWtzyUy
tBP3IV5VW3O/5/8qBxYIlBNO29TW0MDdWEUkPZlZJvAgqA4/rlXft8kdlOBVPgmi
dwVQ+yZ9c+10lqgD8UBO6nk+3Nfep5SdHR0SkVktH/E7/NA3khrAk694xgSibTpb
qWj7TEKoUIg9RbC22b/WeSWzPmuiM4j7lEA/g6M91WLkEeNkysdy2v+xb7/pVKFD
jQ+rRR28z+nsF6eNPZwKsM5z1ZRfREmgGUT7EsJibGAb3ihz/2M=
=LrIj
-----END PGP SIGNATURE-----

--nextPart6005903.RJP74QPFIO--



