Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201AA43173A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJRL2p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:28:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31945 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhJRL2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:28:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634556394; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4qw20NfMOIpD0SMvY9UFDAqIrqByF75nsUo2VUEWA/w=; b=TuDbWSiQ6ZTPGNYE8qtcWWCREf5UDR4OoGY9NBn1jmG44QLoJQ3roM8yuZZwOreDLcvIMSFz
 153hY1V0c5TkuAOCNJ9WNgGuoUSnzlD6YXk2CXVCqqAR06OWQTKfw+Gxgere9VW5aaClzZXy
 xwL2ZV2wPREfz9wpyhexHn5FP/Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 616d59cf835b7947c10b2306 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 11:26:07
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B54F3C43616; Mon, 18 Oct 2021 11:26:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB801C4338F;
        Mon, 18 Oct 2021 11:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CB801C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     Emmanuel Grumbach <egrumbach@gmail.com>,
        "Coelho\, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker\, Ayala" <ayala.beker@intel.com>
Subject: Re: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <20210623141033.27475-3-emmanuel.grumbach@intel.com>
        <87k0mji43p.fsf@codeaurora.org>
        <CANUX_P0d0jrq9x99jM824oKOhmi0Wa5WqhECMsX=hd269H6atw@mail.gmail.com>
        <87sfzoc9bw.fsf@codeaurora.org>
        <SA0PR11MB47521818C15629E58B99525AF2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
Date:   Mon, 18 Oct 2021 14:25:57 +0300
In-Reply-To: <SA0PR11MB47521818C15629E58B99525AF2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
        (Emmanuel Grumbach's message of "Sat, 7 Aug 2021 18:32:26 +0000")
Message-ID: <874k9evaka.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:

>> 
>> > On Thu, Jun 24, 2021 at 8:09 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>> >>
>> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>> >>
>> >> > iwlmei allows to integrate with the CSME firmware. There are flows
>> >> > that are prioprietary for this purpose:
>> >> >
>> >> > * Get the information the AP, the CSME firmware is connected
>> >> >   to. This is useful when we need to speed up the connection
>> >> >   process in case the CSME firmware has an TCP connection
>> >> >   that must be kept alive across the ownership transition.
>> >> > * Forbid roaming, which will happen when the CSME firmware
>> >> >   wants to tell the user space not disrupt the connection.
>> >> > * Request ownership, upon driver boot when the CSME firmware
>> >> >   owns the device.
>> >>
>> >> Vendor command requirements are documented here:
>> >>
>> >> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#
>> >> vendor-specific_api
>> >>
>> >> The commit log is not really answering to those. For example, how a
>> >> user would use this? Or is there a user space tool?
>> >
>> > We intend to send those command from the NetworkManager.
>> 
>> I'm not really fond of the idea that NetworkManager uses nl80211 vendor
>> commands, sounds quite hacky to me. I would prefer that NetworkManager
>> uses generic nl80211 interface so that it works with every driver. But I need
>> to look at v4 to understand more how this all works.
>> 
>
> You'd need to look at v5 which I already sent.
> Nothing of this can be generic, because it is really Intel
> proprietary.

Every company always says that their implemention is proprietary :) So
that's not really a technical reason....

> CSME can only use Intel devices by design. It uses a proprietary bus
> implemented only in Intel devices (and not even all of them, only the
> ones in systems with the vPRO sticker).

Ok, fair enough. I guess this is exotic enough that no other driver ever
wants to implement, and I haven't seen any complaints either about this
vendor interface. But please do include the justification for the vendor
interface in the commit log as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
