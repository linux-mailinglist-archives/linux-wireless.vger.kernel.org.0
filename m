Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F304E6ED3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 08:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiCYH2E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345828AbiCYH1x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 03:27:53 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21AC6824
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1648193175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+y0EoZNvS8wlq8z+BSVtPdl9tjxgILVz0c89RdWlznc=;
        b=nC6zIy1roWwhMJQhK3evmQhPndU3CieItULRFtT5quihhfnCzCdL8RqEYwHFTAds/qOhUO
        i3SoUBrNIrsEVUjM/D0v7IGHn26vx9h/OhHbITUKB89hdjEBmf9r49JY0w0h6xFDBQv5FR
        TW6kVIB9Z1hCbci0Z09FHFJ96Ze9oRI=
From:   Sven Eckelmann <sven@narfation.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
Date:   Fri, 25 Mar 2022 08:26:10 +0100
Message-ID: <4594028.WNQrFERZ9z@ripper>
In-Reply-To: <3c54fa579046082c6dc30286ab291936@codeaurora.org>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org> <6210385.n8AMQ0p90U@ripper> <3c54fa579046082c6dc30286ab291936@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1758225.uXCZi3jzxr"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1758225.uXCZi3jzxr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 1/3] nl80211: Add support for beacon tx mode
Date: Fri, 25 Mar 2022 08:26:10 +0100
Message-ID: <4594028.WNQrFERZ9z@ripper>
In-Reply-To: <3c54fa579046082c6dc30286ab291936@codeaurora.org>
References: <1628585783-21139-1-git-send-email-mkenna@codeaurora.org> <6210385.n8AMQ0p90U@ripper> <3c54fa579046082c6dc30286ab291936@codeaurora.org>

On Thursday, 24 March 2022 19:10:20 CET Maharaja Kennadyrajan wrote:
> [Maha]: yes, it is radio/PHY setting only and it is supported for AP and 
> MESH mode now.

But why are you setting it by vif when it is actually a PHY setting?

Kind regards,
	Sven
--nextPart1758225.uXCZi3jzxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmI9bpIACgkQXYcKB8Em
e0amsw//XVFMI3zFPPfBdQNhZu2vXOzUJUQ+WnSE6gqmNY1WmPs41tV4bTZkWuqS
6nba7dXnviTrASs4QOGfNvhlaEGxucAt1E/eaEEhyPTtioX4IMSdII8dfaFIv/yE
vWLlOUR17muCHWJ+eRBMSJX2WJnIP5A4lWhuTNwkqLLhlIXhZQpwDOAryruFQ7Gq
foOvEw+eUtFXVOq/YsrSMZwzMHX3qOPY8segup1lsAYFfTUgK48e+Wj4LOmUND2i
zGGPHK6CAp10oF8ISzKMq+ERF3gsDlxdnvfuxc6RbDLKS6kkbE6nfU84fX8ZXZt5
Z/gNlEUQCFKCFxWC6jkM9qhR+9q8wg748etPqSq+ov4vPrFaMWUhMh545a+bLVsi
CCnckQMrWfPNv9WxwyYMjrtQS7huq1F41DEoXPCu4IoGF5Eb9TKwZyw1m1HKjm/5
wLW/E+CCfgHnsTFvs9paTh80AKqoIbesGO1OxTyKgeInZ9oqbmNMQhSE4xprBW44
TP5OoPxBTR+Y+Y5OKTkuW2sYRCqGc9yCEFUGa0vFBKdY0idXXhgi6AJgOzQVhm8m
7XxP18PPRYCXcWoM+QoeqmddxNDdZfk6YBg22mVGSUfavPWHiB4PKtXiD4uMGcuV
R6O2i8ddIE4r3lx3UVb0X1YMrh9j88uUIO3Q/Z1werxKw6T1vBc=
=Ee0X
-----END PGP SIGNATURE-----

--nextPart1758225.uXCZi3jzxr--



