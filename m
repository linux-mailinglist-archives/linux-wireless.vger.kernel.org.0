Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08A44346BF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTIXb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 04:23:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52903 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTIXa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 04:23:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634718076; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9a/lBUPLEX9oekw9Cx3rqnVMr3Nf9ETTTIIpjPQQ3tA=; b=w0Qq9/PhasKq9asd/+Ldy1HWEJB1YEfpitkG12FMhWIA5Ts6BmfRoFAEZxJmEEhBVHhZzCro
 Bs3DSO5sk/V4FtZ1sIBUF1Um4ig43xi+dC/I/PASZBdgXTWnnXaYqTim2pZxs0MEoQH7Ar19
 kU7WC0hbIO2tICohS/Ye0HnaLYM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 616fd17afd91319f0f02447d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 08:21:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B92F5C43460; Wed, 20 Oct 2021 08:21:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 933B4C4338F;
        Wed, 20 Oct 2021 08:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 933B4C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
        <20210811105541.43426-2-emmanuel.grumbach@intel.com>
        <87y26qvg05.fsf@codeaurora.org>
        <CANUX_P0CxotNk1omOELgFWWDTzJXMmzSBPKg6k1f_kbBookWuQ@mail.gmail.com>
        <CANUX_P25aQuih=ZnAsVchiWqQdO7G1aHyReZ2yxUAc29GH=bog@mail.gmail.com>
Date:   Wed, 20 Oct 2021 11:21:09 +0300
In-Reply-To: <CANUX_P25aQuih=ZnAsVchiWqQdO7G1aHyReZ2yxUAc29GH=bog@mail.gmail.com>
        (Emmanuel Grumbach's message of "Mon, 18 Oct 2021 14:17:04 +0300")
Message-ID: <87pms0f6oa.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

>> > > +
>> > > +/*
>> > > + * Do not export the device table because this module is loaded by
>> > > + * iwlwifi's dependency.
>> > > + */
>> > > +
>> > > +static struct mei_cl_driver iwl_mei_cl_driver = {
>> > > +     .id_table = iwl_mei_tbl,
>> > > +     .name = KBUILD_MODNAME,
>> > > +     .probe = iwl_mei_probe,
>> > > +     .remove = iwl_mei_remove,
>> > > +};
>> > > +
>> > > +module_mei_cl_driver(iwl_mei_cl_driver);
>> >
>> > Not sure iwl_mei_cl_driver can be const or not, most probably not. But
>> > please do check.
>>
>> I will.
>
> I can't :(

Ok, thanks for checking.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
