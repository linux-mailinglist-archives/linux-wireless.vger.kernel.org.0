Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DC43174A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhJRLaS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:30:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37386 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhJRLaR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:30:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634556486; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=dwfW/Vg5fgNyjaeuC225Lwf3+Ov++emzpu2E8WZmP3s=; b=pSUaobqR/3o8vj0wP/SZROozl5q9c98LzK29n/yTWcFbM/no6qLNONtkxY3AaeMUKAYXFzBO
 R2PzlMVHR8HSPJR+Y/3yvBODGvx4V+7dQ2z0iKZlzhmDpNPfe540VQp16FYLQgyeOcwoa/W2
 wcVIYjuEd1QbZhJIq5L8YoAv3JM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 616d5a3430ce13d2b4617594 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Oct 2021 11:27:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41F39C4338F; Mon, 18 Oct 2021 11:27:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B5B3C4360D;
        Mon, 18 Oct 2021 11:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6B5B3C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     Emmanuel Grumbach <egrumbach@gmail.com>,
        "Coelho\, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker\, Ayala" <ayala.beker@intel.com>
Subject: Re: [PATCH v3 4/4] iwlwifi: mvm: add vendor commands needed for iwlmei
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <20210623141033.27475-4-emmanuel.grumbach@intel.com>
        <87fsx7i416.fsf@codeaurora.org>
        <CANUX_P3HWWBkeHHSw+-wdQEBFNF1V+GWRDFiEerH7NhksRvOzA@mail.gmail.com>
        <87o8acc8v1.fsf@codeaurora.org>
        <SA0PR11MB4752D9B34C2A60B85CA3E5F3F2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
Date:   Mon, 18 Oct 2021 14:27:44 +0300
In-Reply-To: <SA0PR11MB4752D9B34C2A60B85CA3E5F3F2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
        (Emmanuel Grumbach's message of "Sat, 7 Aug 2021 18:34:34 +0000")
Message-ID: <87zgr6tvwv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:

>  
>> > On Thu, Jun 24, 2021 at 8:13 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>> >>
>> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>> >>
>> >> > Add the vendor commands that must be used by the network manager
>> to
>> >> > allow proper operation of iwlmei.
>> >> >
>> >> > * Send information on the AP CSME is connected to
>> >> > * Notify the userspace when roaming is forbidden
>> >> > * Allow the userspace to require ownership
>> >> >
>> >> > Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
>> >> > Signed-off-by: Emmanuel Grumbach
>> <emmanuel.grumbach@intel.com>
>> >> > ---
>> >> >  drivers/net/wireless/intel/iwlwifi/Kconfig    |  11 ++
>> >> >  .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
>> >> >  .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +
>> >> >  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
>> >> >  .../wireless/intel/iwlwifi/mvm/vendor-cmd.c   | 186
>> ++++++++++++++++++
>> >> >  5 files changed, 203 insertions(+), 6 deletions(-)  create mode
>> >> > 100644 drivers/net/wireless/intel/iwlwifi/mvm/vendor-cmd.c
>> >> >
>> >> > diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig
>> >> > b/drivers/net/wireless/intel/iwlwifi/Kconfig
>> >> > index 629aaa26a230..f91516d08b28 100644
>> >> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
>> >> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
>> >> > @@ -92,11 +92,22 @@ config IWLWIFI_BCAST_FILTERING
>> >> >         If unsure, don't enable this option, as some programs might
>> >> >         expect incoming broadcasts for their normal operations.
>> >> >
>> >> > +config IWLMVM_VENDOR_CMDS
>> >> > +     bool "Enable vendor commands"
>> >> > +     depends on IWLMVM
>> >> > +     help
>> >> > +       This option enables support for vendor commands, including some
>> >> > +       that don't have their own Kconfig option. Other Kconfig options
>> >> > +       depend on this one as well.
>> >> > +
>> >> > +       This is not enabled by default, if unsure, say N.
>> >>
>> >> Why do we need a new Kconfig option? Why not always include it in the
>> >> compilation?
>> >
>> > I expect 99.9% of the users to want to disable this.VENDOR_CMDS adds a
>> > user space API and in a sense, it increases the attack surface. You
>> > can claim that I can reuse the IWLMEI Kconfig option, which is true,
>> > but we have other features that need VENDOR_CMDS that are not (yet)
>> > upstream. So the idea here is that any feature that needs the
>> > VENDOR_CMDS will select it and if none of them are enabled (for 99.9%
>> > of the use cases), then, we would disable VENDOR_CMDS and decrease
>> the
>> > attack surface.
>> >
>> > Makes sense?
>> 
>> How do you prevent users or distros from enabling the feature? They can be
>> in a hurry, lazy or not caring and enable the feature anyway. So no, I'm not
>> really buying this. If the interface is not secure it should not be in upstream, I
>> think only exception to this is the nl80211 testmode interface which is for lab
>> or similar use.
>> 
>
> So what do you want? To make it depend on IWLMEI Kconfig knob and not
> add the VENDOR_CMDS one? Fine.

Yes, that sounds like a good idea. And I saw you did that already in v6.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
