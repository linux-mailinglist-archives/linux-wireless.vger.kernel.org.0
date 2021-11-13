Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4419944F227
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Nov 2021 09:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhKMI0U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Nov 2021 03:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMI0T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Nov 2021 03:26:19 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4382C061766
        for <linux-wireless@vger.kernel.org>; Sat, 13 Nov 2021 00:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1636791805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaiGszgndv4FsPmJOSElCJHgKF5/Qy5bqELPSPqfAgY=;
        b=lV5F22q14U5Oi0DReBuHv7cf8rpt0pX23E9RqHgqV/tt+IN6EGAXl9vztmgkxO9OY6hxPr
        zT1oIpMZs6XHSMzjihak41Wf/LJWXtbn0HFHs2zJlQGA9zdHFU3x0BMBitRSynriac/8lB
        SKq9GWjyll9ZvQajXxkGDOmLGkZvysw=
From:   Sven Eckelmann <sven@narfation.org>
To:     luciano.coelho@intel.com,
        Sharadanand Karanjkar <sk@simonwunderlich.de>,
        johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date:   Sat, 13 Nov 2021 09:23:17 +0100
Message-ID: <8620510.1Rxf2nTHJ8@sven-desktop>
In-Reply-To: <6520824.1yIjQniEF0@sven-l14>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1820442.fXUfBpcmLJ"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1820442.fXUfBpcmLJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: luciano.coelho@intel.com, Sharadanand Karanjkar <sk@simonwunderlich.de>, johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date: Sat, 13 Nov 2021 09:23:17 +0100
Message-ID: <8620510.1Rxf2nTHJ8@sven-desktop>
In-Reply-To: <6520824.1yIjQniEF0@sven-l14>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <dd512568-9d9f-289a-bc7b-9b6dfc1c0c8a@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14>

On Saturday, 30 October 2021 19:17:38 CET Sven Eckelmann wrote:
> But the commit at least provides some good reasons why Intel might consider 
> enabling the indoor channel in the frequency range 5945 - 6425 MHz.  It would 
> therefore be nice to know whether/when Intel actually has plans to enable 
> these channels in Germany (and not only for the US) in the near future. Maybe 
> there are even newer (test) firmware versions available but I am not aware 
> of any newer firmware version than the previously mentioned one [1].
> And this firmware was published for linux-firmware right around the time when
> Vfg. 55/2021 was released - so it is to some extend expected that Intel didn't 
> yet incorporated such a change.

Johannes asked to forward it to the support system [1]. This was done now by 
Sharadanand [2]. Interested persons might check the status there in case there 
is no update in this thread.

Just for the laughs: Intel recommended [3] a couple of weeks ago to get a 
cellar [4] where your Intel card can only receive an (from a legal perspective 
incorrectly configured) AP which was set to the US country code. While it is 
dubious for various reasons, this was part of the marked as solution (which 
closed the discussion). I still hope that Intel customers aren't forced to 
move their apartments into properly shielded cellars to use Intel HW. Would 
give the German term "Kellerkind" a new meaning. :)

Kind regards,
	Sven

[1] https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi#support
[2] https://community.intel.com/t5/Wireless/6-GHz-Wifi-with-AX210/td-p/1329556
[3] https://community.intel.com/t5/Wireless/6-GHz-Wifi-with-AX210-and-Ubuntu-20-04/td-p/1318011
[4] I still have some hope that they actually meant "shield box" here. And only 
    recommended it for controlled tests and not normal operation
--nextPart1820442.fXUfBpcmLJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGPdfUACgkQXYcKB8Em
e0YCJg/8CCcg7df4MiHEFzN9fKN9FLLKla8Hrht2Y10WsCO8cMfChPeHcXuvCvJ7
yjHw8buhepkYYx/xBt9LrN/BMDuHFgZezOWnRLrH5o0Rff72gpeuiPnU368LugIj
OARdMcKy7p7PljgCj/NyQaW/fYf9hzn8LPqVdsSVbOP2JlDWUWPtpzXO/9qWAgip
EYvDlqF+RS1fqmk9oYz893HPXqSjxshYGTZAjQolM4WNvYPCy8hh1qRl1wM+tu/p
Jyc/t/LGMcOcMkuPDxLGYXeNtfQ7UePjwQHgWGhnktmVjCvlU1GMdPRwJ4AyovEY
SiSZkukwfsneqmTF39LWmYwmuftvastbvKaSDmzBW4s9nfOinf08P+Y7tP5nUiMF
YqouOz/QuQrDjkXW27LgphgNUKirD1Hp+EnlqHfWZkJEAlYiAe90jtQo4WN2H+P5
bQeWDBBiRRbplCTjYlYs5kHmYQcgJwfSF+REdk+WOSOqTjbN5trR/meDfM7lfKwE
h3dzcRS/7xWTU/EezgJgRih1u7a/FUdpaGpm008LgZUpB206r3IIjtVnQdySt4kt
JK60p2quvILXukdWx8EeuCxGV8M0Agaab5BBzg2GlO5WHyld/hNZmNiq9UL0oEFX
Mc/VecrXDdNsGsNk9A2h+BYGkLCcZmNU01ev8UcZyrglOWTXQYY=
=RmSR
-----END PGP SIGNATURE-----

--nextPart1820442.fXUfBpcmLJ--



