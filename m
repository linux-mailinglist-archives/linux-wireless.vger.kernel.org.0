Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764DFB5F69
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 10:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfIRIqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 04:46:24 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:43034 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfIRIqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 04:46:24 -0400
Received: from bentobox.localnet (p200300C5971113F0000000000000063E.dip0.t-ipconnect.de [IPv6:2003:c5:9711:13f0::63e])
        by dvalin.narfation.org (Postfix) with ESMTPSA id A033E1FF9B;
        Wed, 18 Sep 2019 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568794612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BX4fjwFVQL4NLd+uNgUnLQ9RSR+S9QPFP1f84ohjf/4=;
        b=dPoPVt/pmEoL8Zgr/+ZSYBFVTPjJaJUifQNR7aFbb1+Cp9bFL6nPxlzQ7qrBqpzirqGxbc
        AVOttPUjObj0Qw9GuADtjs2oYE2w/4I3NK7LfL9DiqWW6nOMsa109Ku5iwiwIlUmmstr4F
        p3kYBWoEdGoqrcm4gzlv4KtYSmKFVF8=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath10k@lists.infradead.org, sw@simonwunderlich.de
Cc:     vnaralas@codeaurora.org, Johannes Berg <johannes@sipsolutions.net>,
        slakkavalli@datto.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] cfg80211: Add cumulative channel survey dump support.
Date:   Wed, 18 Sep 2019 10:46:08 +0200
Message-ID: <18458963.ukFM9YuvQx@bentobox>
In-Reply-To: <2083094.mFhUXK7yzB@bentobox>
References: <1526980556-26707-1-git-send-email-vnaralas@codeaurora.org> <ebf1c95acb34649b3d2a5435142dc06a@codeaurora.org> <2083094.mFhUXK7yzB@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3954164.CNjgTPF8Pu"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1568794612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BX4fjwFVQL4NLd+uNgUnLQ9RSR+S9QPFP1f84ohjf/4=;
        b=zmSLPj7CkLwF3xTKf9tyTQsLqXn3oEOXbtzJhpvlrQWNPMjp4VzoXpwRuOnLBDDKHoIpik
        bLHa2OcdPP7Rt+sx3UsmlqLwZWaLEkXjKx74a9z64kyq8hFONEzGcWPNLtAMkvfXqCi9eg
        WccEVY2UBHrP+qy6DQUGF3i2a/fB3P4=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1568794612; a=rsa-sha256;
        cv=none;
        b=YjbDJOMyfpt1uGFX2M9iVhiCJeZCpY2odfjnlQEodkkPP5dpdy7qK37W8JALFQ/2YBRQu4
        d/2CERSjP4DYPmCF9AIZQ/if7vlO/sU0X6VeFUwck59FYFnQ9YrvU/4BvQrY+GRt3JmoMt
        su7SZR2luVoqz2iw/qb5pu7hagfZfpI=
ARC-Authentication-Results: i=1;
        dvalin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3954164.CNjgTPF8Pu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 17 September 2019 19:27:50 CEST Sven Eckelmann wrote:
[...]
> So whatever the firmware does when it gets a 
> WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR -  it is not a CLEAR after read. And they 
> also don't simply wrap around but there all values have to get some kind of 
> "fix" like the active time one shown in ath10k_hw_fill_survey_time.
> Just that the actual "fixes" for them are unknown. To me it looks like
> firmware ATH10K_HW_CC_WRAP_SHIFTED_ALL have busy and rx interlinked with
> the overflow of total. But the tx and rx_bss are actually cleared.
> 
> Other than that, the counters are wrapping every ~14-30 seconds. So we
> also need also some worker for ath10k which every couple of seconds
> requests new values for all the channel from the firmware. Which already
> sounds problematic because I get
> "ath10k_pci 0000:00:00.0: bss channelsurvey timed out" all the time
> when requesting surveys manually.

I've just tested it on 10.4 (wave-2) cards and it seems like it is cleared as 
expected on them. So the change I posted earlier (with a minor fix for 
ath10k_hw_fill_survey_time) returns now useful (accumulated) values. This can 
be seen in 
https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86749f4d60&fullscreen&panelId=5&from=1568782046974&to=1568807068706 
(after the reboot at 10:15 UTC+2)

So as Ben Greear said, the 10.4 firmware version is fixed and 10.2.* (for
the wave-1 cards) is still broken and we need a QCA firmware engineer to
fix it. Or to work around it by polling every couple of seconds and 
manually do the cleanup of the values from the firmware.

Kind regards,
	Sven
--nextPart3954164.CNjgTPF8Pu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl2B7tAACgkQXYcKB8Em
e0aTpA/+Mw2cCvo49jZ32Ctihgqw3ZkWKxTaizRZzAKNDnCArDWWs3wER2zw1BPm
2Y4S9Nj0fq4fju1W+JRG/gX9gDFGJEhuCwG695aCofby6a9cXerq/3dzz3ciiJlh
EJnkQOIgf4zHTGDhbzdca+2NxXWvxwXOhWZ+jehFrBux8P6oi/UafWpXVEALTsUV
Byj4lW7/5rmJ99xDGXzeQF1S1MWw4q7clMKYGvlJl6yurbiHQpSqc859dDRsVhDw
00mfmhCu4aEIJl9MlVMWY4HLpmW7S1sl1Y+dFR9ioDLgChWUQzq//EihpWwtYJUD
Sjnvfpa77OZ9HO52bdWH2Epi45YoLdSV3jSoY2OSw0cQmYZMPiPod2C+tctfeg6U
9Ky4MZ0ELXvzmrlYHE3p0QVu1IOQywCIzkjwDjHQuFsOam7KcpL1D2Nt/etnKN0D
O+bVWoe0FEZ1ZDVnyjrX+bYcth7LH42LJrSIbBL+deAdO/6EIxrfTcibk6iYKJhq
0uProQ4J4DtcqBvhI+zw1O1lGViIZ+csmODioRGPvSjMJ2zXwkLJRKZQAqz8i+QJ
QRWFdi0oEsQyCGI4bg0i7p+6VzeFfc2dh6z95HdbfOKDzwaLYjuZkuCJBPVAB0fQ
ql6U6cyZccZARNAVSAhG6/hq8NpWJmMmwB93Vt2NgKNWfmriMgY=
=GhvJ
-----END PGP SIGNATURE-----

--nextPart3954164.CNjgTPF8Pu--



