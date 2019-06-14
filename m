Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2F46047
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfFNONl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:13:41 -0400
Received: from durin.narfation.org ([79.140.41.39]:52882 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfFNONl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:13:41 -0400
Received: from bentobox.localnet (p200300C59711D1FA000000000000070D.dip0.t-ipconnect.de [IPv6:2003:c5:9711:d1fa::70d])
        by durin.narfation.org (Postfix) with ESMTPSA id 308AD1100D8;
        Fri, 14 Jun 2019 16:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560521618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTi2YHCWTxpCSwbIFfd2PMHuN1W+VHui/TGqIlSYEaI=;
        b=2A65hEP3J7LqIcxFC7sMcguCfyJb7n6DPWasnPJW+LcsuAomgOV902CrRUZIyDN83QO5Ln
        Dol7kXfwXKEhJpO+0e+wQ4i7KUHu4EpUxO68fBaaczLYDR2SiirLWOvpQyjhHwMuitVwwT
        PPJnEZ5o5Vum3vRCgJAiLqjJYquFFXU=
From:   Sven Eckelmann <sven@narfation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v3 2/3] mac80211: implement HE support for mesh
Date:   Fri, 14 Jun 2019 16:13:32 +0200
Message-ID: <2194147.kqlnQF7k4C@bentobox>
In-Reply-To: <8d0d11ca39b6216b24cf4e9e3a1522072db5c0d2.camel@sipsolutions.net>
References: <20190612193510.29489-1-sven@narfation.org> <20190612193510.29489-3-sven@narfation.org> <8d0d11ca39b6216b24cf4e9e3a1522072db5c0d2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1611464.BoocHWZ4b5"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560521618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTi2YHCWTxpCSwbIFfd2PMHuN1W+VHui/TGqIlSYEaI=;
        b=189JCyai+9xSeV7LT/eZAh1N+5IPaxVPGHV8KgfmyzHfKsfTiqpNxI/RQrmhBXSB2vQO2K
        vWHCYeEYVswxFQwIOhsKJMSuG2on/6vDULrFWgxgYrg6ROmRprgFwWyZVhk8Wmwgb38EFM
        Ist+3dhbgKG/GU9yXfu414Y+aAYYC1M=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560521618; a=rsa-sha256;
        cv=none;
        b=tnCW7/Mb7l9iOY5TMAPFkX0XFPMyFSeUqBOS4unYC/y24VOa21+XvWBzJXQUnoGDuyj7l2
        s0V5AgLCG3GXJxtiPbfSdHL+RIK7ZcQiD0XRJ0D160jbjD8uzgR9CkZJ8jOWqXAvejH0rQ
        /a+n1i1dZ6/aVmYr+zj/P2BfvGEKPrU=
ARC-Authentication-Results: i=1;
        durin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1611464.BoocHWZ4b5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 14 June 2019 16:11:15 CEST Johannes Berg wrote:
> > +       ie_len = 2 + 1 +
> > +                sizeof(he_cap->he_cap_elem) + n +
> > +                ieee80211_he_ppe_size(he_cap->ppe_thres[0],
> > +                                      he_cap->he_cap_elem.phy_cap_info);
> > +
> > +       return ie_len;
> 
> There's no value in the "ie_len" variable here.

Sorry, my parser just broke. Why is there no value in ie_len? Was just 
assigned a line before. Or are you talking about something else?

Kind regards,
	Sven
--nextPart1611464.BoocHWZ4b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0Dq4wACgkQXYcKB8Em
e0butBAAu0U2S7wFCG42oSqGv9AjRaZtFJHKf6JLUfaHbld0mJNvxXMMncLsYNQV
gmPmIEoDJuk6d4BlRUa9whCPPc8V6kMODylOwqVDx1qpeuVUuNUxbK/7rvMwQPCF
TAuwzZ/ILxX4onafvgI2OCcJD+BauDCYPlgBSJwZi9OMOaLwgz5F59fcA/R2MlEt
nAqxyUdL/tJRjLNxDMtVOZdm8VSUGFBZLD8Ww7RIqUuZb7dsAkGAcmhbPyoGzoqy
IFXwqwVtGjb7YPASrqfG1N+LJjKVAbBvknofHEkHciDUV9o5VKKX/I7IiJAyMF1X
IILegixRN8MJtVXXZEx+9K2r8V5lB/KZWj9x75qw3ZHh2uta7ga7pbUYta6PHIHr
80jvJ5KTkGsYia3XEXgxNaAO77xT8Ai85itex5V5zrL/HmtNWBcZl4XPYc1HSa8+
PVa82kX0puYi7pa5QKj7GfKeUn9Xetty52hrT7aqyLeGgFf1Nrry3lzcCAK5BKWI
1ExMP2wevkv+11UHR4xaVl9/1oNcmMIWlU7nZJgClUMOigt8U5r70Us2lQ2kSkck
kgQEzt0yDvpfB9lhQoO2H3E38VhlWljC928YecyZcvKDlZo+7ZhI3VeIKy62aSYX
AttrUYElR8SutIZN8YlwF1If61rx9SBnK6oBTYmWnejz9HQOPFE=
=0tJn
-----END PGP SIGNATURE-----

--nextPart1611464.BoocHWZ4b5--



