Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2B4669D3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbhLBSkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 13:40:05 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:60438 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhLBSkF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 13:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1638470201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsfXl6MBF6KX+nZQodF+Dv4umxwnNv+y0c9FeuMN/eQ=;
        b=o/vMj0ZVANRSiKaeHHlHrDlNDQm+J4Mxow5SuyTjG2dKQqNj0Y+cj8Up0wruZqRm+LRV4t
        AkH8Aupus9Q4nbrln0f+2QYXYBmuEmr2ht0lNvTH8aPJMyppV8MXO6t52xDQISJfXY8gMF
        sBgnYoDZKavTtcoIBDKA6zj+hwNcp6o=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add regdb.bin download for regdb offload
Date:   Thu, 02 Dec 2021 19:36:35 +0100
Message-ID: <2715590.fzSe1J7v7S@sven-l14>
In-Reply-To: <20211202083616.15406-1-quic_wgong@quicinc.com>
References: <20211202083616.15406-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3557057.OuUsEEyBDt"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3557057.OuUsEEyBDt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add regdb.bin download for regdb offload
Date: Thu, 02 Dec 2021 19:36:35 +0100
Message-ID: <2715590.fzSe1J7v7S@sven-l14>
In-Reply-To: <20211202083616.15406-1-quic_wgong@quicinc.com>
References: <20211202083616.15406-1-quic_wgong@quicinc.com>

On Thursday, 2 December 2021 09:36:16 CET Wen Gong wrote:
> The regdomain is self-managed type for ath11k, the regdomain info is
> reported from firmware, it is not from wireless regdb. Firmware fetch
> the regdomain info from board data file before. Currently most of the
> regdomain info has moved to another file regdb.bin from board data
> file for some chips such as QCA6390 and WCN6855, so the regdomain info
> left in board data file is not enough to support the feature which need
> more reg rules such as 6 GHz LPI, SP and VLP.

But for the latter, you are also missing the patch to support the 
WMI_REG_CHAN_LIST_CC_EXT_EVENTID (with the 6GHz specific fields in the struct 
wmi_reg_chan_list_cc_ext_event)? Otherwise it should not be possible to
get the 6GHz reg rules (which you showed in your commit message).

struct wmi_reg_chan_list_cc_event (for WMI_REG_CHAN_LIST_CC_EVENTID) supports 
only 2.4GHz and 5GHz.

Kind regards,
	Sven

[1] https://source.codeaurora.org/quic/qsdk/oss/system/feeds/wlan-open/tree/mac80211/patches/302-ath11k-Add-support-to-parse-new-wmi-event-for-6G-reg.patch?h=NHSS.QSDK.11.4.0.5
--nextPart3557057.OuUsEEyBDt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGpEjMACgkQXYcKB8Em
e0ZwAxAAiQgfVTeTTa4jXtUlnpfrWl3imAtXNa514tyOYbr/whXDehewzLd3ykQE
EomUEHQGfiYSDSkmaKdyJsRxyTzKOC5IbymWlrojv61V8AAi00bADbhsh2OR/HeD
VHU40hBBcQTHpm3Ps5GTU4RAS+FTIoSmCUlJxG5o7NeQtndLkH/ghW+8MwLtfrL5
2mIYfMRZ9+sfqCwcCd7vlFys/M8pnJmqnzpYXtVWQAJ1K9vQPdGz3eDAa37W8VmU
m0URf+Ek8qO9PNiqOC0xzftgpm7qhkkAmUJBO5UcuObj1DERbL52+9ozYN5MQtLk
NYMDEhWQLRhZ6CXcfOSqxQFZFH8WwJ1jV2FE1iop6ZBZo+isOALQnUHNMMvtovve
VZwHOMpJitQtTJyv12hkjrwi7VHOcq2OloMBDybWAeMAAJxbsYPPaw5cD5syOn7f
ygGYuce5TyP+9pOML5+AkS5zzpWW5iMG+1t8DFxKTjSxy5ocKot9ArxkRi8O+yKY
HoTdMg7ItmlaB6TFZXDQLjmwycCiRBftFbdW4Ni4UYUR8Pvyt+LbQK5SCpSDTOoy
MEOvxAWniT4mnwQUtzzQwxWIIrCBZs4jW62HCtaKurmcYLPmZdK3eOiZt72NWGa4
barn7ECpFaA5yFZMWB0aTO2Pwjo4ddmXHupfY3OemltZ3v8pdlU=
=n60A
-----END PGP SIGNATURE-----

--nextPart3557057.OuUsEEyBDt--



