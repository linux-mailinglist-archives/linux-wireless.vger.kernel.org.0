Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E047D3F73C1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhHYKys (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 06:54:48 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:55198 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbhHYKyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 06:54:47 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 06:54:47 EDT
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 8291E3C0A7C;
        Wed, 25 Aug 2021 12:46:26 +0200 (CEST)
Received: from lxhi-065 (10.72.94.13) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 25 Aug
 2021 12:46:26 +0200
Date:   Wed, 25 Aug 2021 12:46:20 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>,
        <linux-wireless@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 4/4] cfg80211: implement regdb signature checking
Message-ID: <20210825104620.GA3561@lxhi-065>
References: <20171006135532.29550-1-johannes@sipsolutions.net>
 <20171006135532.29550-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171006135532.29550-5-johannes@sipsolutions.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.13]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Johannes,
Dear Linux wireless,

On Fr, Okt 06, 2017 at 03:55:32 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Currently CRDA implements the signature checking, and the previous
> commits added the ability to load the whole regulatory database
> into the kernel.
> 
> However, we really can't lose the signature checking, so implement
> it in the kernel by loading a detached signature (regulatory.db.p7s)
> and check it against built-in keys.
> 
> TODO
>  - add Seth's key, obviously
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/wireless/Kconfig         |  30 +++++++++++
>  net/wireless/Makefile        |  22 ++++++++
>  net/wireless/certs/none.x509 |   0
>  net/wireless/reg.c           | 121 ++++++++++++++++++++++++++++++++++++++++++-
>  net/wireless/reg.h           |   8 +++
>  5 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 net/wireless/certs/none.x509
> 
> diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
> index f050030055c5..da91bb547db3 100644
> --- a/net/wireless/Kconfig
> +++ b/net/wireless/Kconfig
> @@ -83,6 +83,36 @@ config CFG80211_CERTIFICATION_ONUS
>  	  you are a wireless researcher and are working in a controlled
>  	  and approved environment by your local regulatory agency.
>  
> +config CFG80211_REQUIRE_SIGNED_REGDB
> +	bool "require regdb signature" if CFG80211_CERTIFICATION_ONUS
> +	default y
> +	select SYSTEM_DATA_VERIFICATION

Since v4.15 commit 90a53e4432b122 ("cfg80211: implement regdb signature
checking"), CFG80211_REQUIRE_SIGNED_REGDB is enabled unconditionally
and users have no flexibility to disable it when
CFG80211_CERTIFICATION_ONUS is unset (since the visibility of
CFG80211_REQUIRE_SIGNED_REGDB depends on CFG80211_CERTIFICATION_ONUS).

Based on the documentation of CFG80211_CERTIFICATION_ONUS, this option
is supposed to stay disabled most of the times, hence users have to live
with CFG80211_REQUIRE_SIGNED_REGDB=y and SYSTEM_DATA_VERIFICATION=y
enabled in their kernel, which consumes a few tens of KB in the
uncompressed binary Image (particularly on arm64).

A few tens of KB is not much, but on embedded systems it matters.

Can you please confirm Wireless subsystem requires
CFG80211_REQUIRE_SIGNED_REGDB=y and SYSTEM_DATA_VERIFICATION=y
regardless of the status of CFG80211_CERTIFICATION_ONUS ?

Thanks,
Eugeniu
