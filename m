Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A948AB53
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiAKK0B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 05:26:01 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:47560 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiAKK0A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 05:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1641896759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+S4TZBvovdjyS6f0BrlMjVtfRnHbOvMJAUwQCrw9Yg=;
        b=nGO+YcnHHWpsPIerAkGByxJ5FzUyF7wmzon0c9BNa5NCdSzhyTxtd/ZdjYem5JcVl2USaJ
        jOUtHQle6Jj6aWFgSaYAuxt+z5EHj8yBmmCORzGtPUJ8lmsKw0TM3v5eAzxfCU1v6iQfsX
        5oNuvlj9tq9WVaLuN5rWdTBRgJi6LGM=
From:   Sven Eckelmann <sven@narfation.org>
To:     luciano.coelho@intel.com,
        Sharadanand Karanjkar <sk@simonwunderlich.de>,
        johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date:   Tue, 11 Jan 2022 11:25:56 +0100
Message-ID: <1718688.u4LHSoq7CI@ripper>
In-Reply-To: <8620510.1Rxf2nTHJ8@sven-desktop>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14> <8620510.1Rxf2nTHJ8@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3683306.TFpEzV6JuY"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3683306.TFpEzV6JuY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: luciano.coelho@intel.com, Sharadanand Karanjkar <sk@simonwunderlich.de>, johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: Re: iwlwifi: ax210: 6GHz channels disabled in Germany by firmware
Date: Tue, 11 Jan 2022 11:25:56 +0100
Message-ID: <1718688.u4LHSoq7CI@ripper>
In-Reply-To: <8620510.1Rxf2nTHJ8@sven-desktop>
References: <57f467ec-074c-8260-7872-84eccfdcc1c7@simonwunderlich.de> <6520824.1yIjQniEF0@sven-l14> <8620510.1Rxf2nTHJ8@sven-desktop>

On Saturday, 13 November 2021 09:23:17 CET Sven Eckelmann wrote:
> Johannes asked to forward it to the support system [1]. This was done now by 
> Sharadanand [2]. Interested persons might check the status there in case there 
> is no update in this thread.

The new firmware [3] seems to solve this. I have posted some output in the 
intel community thread [4].

Kind regards,
	Sven


> [1] https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi#support
> [2] https://community.intel.com/t5/Wireless/6-GHz-Wifi-with-AX210/td-p/1329556
[3] https://patchwork.kernel.org/project/linux-wireless/patch/2aa6a2bb7efda2b9b322371211eff7a7d0aae706.camel@coelho.fi/
[4] https://community.intel.com/t5/Wireless/6-GHz-Wifi-with-AX210/m-p/1350364/highlight/true#M39752
--nextPart3683306.TFpEzV6JuY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHdWzQACgkQXYcKB8Em
e0ZufBAAnxp3GfF3M1dJ/9wNUyJ1Lxyg05IMbV71yiKngNJ4woxyV2z2w+XJ2nVa
Wc1dJIEeYIbOSesoE6T3d3clZyJZ5iBS0zrnpDpTUSB6clLmRQvHrqROeipvIHBj
iKpRX1DuDxeQ3ZExJOE5BgfxbkFsXor7PIlzPsMU10TebVROL6rBECJxzaBDGGeb
EiWeFCFBIiA66ZDSC+DeKS8GYg77fzVSnAe3dQBhdL6BOCcB4Pi6JasDCMwBMDWt
2ZSgUDbJdj7H4nvkwlFrlnXfdPfP/tXQwUKu7iaKSNzpYcHvdoiH+0/bSbMF2BPo
KOGQZlan35dXZxtoK4U5iUxllPB6x3zd7MQJWgFPN9kod065Y7B2uP03SXmGQNlr
Y9sKbq9frlNe9/t488ssQH2oiLF5bQAB3rmpngLAm34jJZIMgLPu9Lucj+zDiNCS
W7HWUMTm7u8dBj4+poYUP3Dxut746MChwCH/yyxmmAIiBrD9WJCQyyaKDojjeQe5
3Uo/il5Ov6z167DhTUqRugqpFCvfgacTyXBXlRN6xJANGuxsLScBorfMAh5RHysR
o0wkm4bMat+yH0G0uqd2fcLW0eEvnrxgOJOtm8aqK7ar2hgs76MSTPuRGLhMfabv
sOQAIufvb6PEILtzKbnH+WXvi/17tFvTZy9CXSiBi45zFWxzy1E=
=rw2n
-----END PGP SIGNATURE-----

--nextPart3683306.TFpEzV6JuY--



