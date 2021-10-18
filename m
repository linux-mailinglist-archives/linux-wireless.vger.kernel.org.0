Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F557431199
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJRHxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 03:53:18 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50380 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhJRHxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 03:53:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634543467; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: References: In-Reply-To: Subject: Cc:
 To: From: Sender; bh=blwQMUM81bjPherhtwXGVnwXJBP6kPeC5A4jHR5OylY=; b=VPJE2iDszF+2rjEhgva0MYQqINqfO918iGX0YkpfxwH9laeRK89wl2gfmqf+fAqScGuACilT
 ClG0ZdZK9SHKdzaz13w+ZeUYiV7FQX0M1UzJsmOKTAL/m9/UHFfa7idQ8csthE040FazeLTH
 NcXFQknhdnU8rifQil2EAByfsX0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 616d276a8ea00a941f0afcc7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 07:51:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75CD9C43460; Mon, 18 Oct 2021 07:51:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 571E9C4338F;
        Mon, 18 Oct 2021 07:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 571E9C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 08/12] iwlwifi: export DHC framework and add first public entry, twt_setup
In-Reply-To: <3be8a0e1cbe82e0c4b55b00c7e7fe06d8014aa71.camel@coelho.fi> (Luca
        Coelho's message of "Mon, 23 Aug 2021 11:57:45 +0300")
References: <20210820110318.260751-1-luca@coelho.fi>
        <iwlwifi.20210820140104.b5c7c6613634.I53b8d9fb194b88070a0df6613f7f57668ea0eaf8@changeid>
        <87y28usxl0.fsf@codeaurora.org>
        <3be8a0e1cbe82e0c4b55b00c7e7fe06d8014aa71.camel@coelho.fi>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 18 Oct 2021 10:51:01 +0300
Message-ID: <877deawz2y.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Sat, 2021-08-21 at 17:04 +0300, Kalle Valo wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>>=20
>> > From: Luca Coelho <luciano.coelho@intel.com>
>> >=20
>> > Export the debug host command framework and add the twt_setup entry.
>> > This will allow external parties to use these debugging features.
>> > More entries can be added later on.
>> >=20
>> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>>=20
>> [...]
>>=20
>> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
>> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
>> > @@ -92,6 +92,12 @@ config IWLWIFI_BCAST_FILTERING
>> > =C2=A0	  If unsure, don't enable this option, as some programs might
>> > =C2=A0	  expect incoming broadcasts for their normal operations.
>> > =C2=A0
>> >=20
>> > +config IWLWIFI_DHC
>> > +	bool "Enable debug host commands"
>> > +	help
>> > +	  This option enables the debug host command API.  It's used
>> > +	  for debugging and validation purposes.
>> > +
>>=20
>> Why a new Kconfig option? Those should not be added lightly.
>
> This is a debugging feature that is not really needed in production
> kernels, so we prefer to allow it to be removed so we don't waste
> resources.

What resources exactly? I would say if the admin or distro maintainer
wants to save on resources he will disable IWLWIFI_DEBUGFS. Why do we
need to have multiple Kconfig options for iwlwifi debugfs interface?

> We're publishing this for a few reasons:
>
> 1. it will help prevent rebasing mistakes when sending patches upstream
> from our internal tree, because a lot of this code is spread around the
> driver;
>
> 2. in some occasions, we may ask advanced users to enable it so we can
> get more data and run more tests in case of tricky bugs;
>
> 3. for the specific case of twt_setup, this allows running some TWT
> test scenarios with our driver that wouldn't be easily available
> otherwise.

Sure, I understand all that. The better debug features we have in
upstream the better. But I don't understand why a new Kconfig option is
needed for DHC feature.

> Is it okay to keep it?

In the past Linus has stated his dislike of adding pointless Kconfig
options, with which I strongly agree, and to me it looks like
IWLWIFI_DHC is exactly that. So I'm very hesitant about this.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
