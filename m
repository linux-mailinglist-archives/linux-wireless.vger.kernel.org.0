Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4204F3E15DB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhHENjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 09:39:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44130 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhHENjo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 09:39:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628170770; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Au1vZ3unnzBq8+b+pIHLqSTcwnlcYL3+tksAECjd/cs=; b=PAZgSkOxt81IILDexjfTnDWjMnb9PgL0/9ITWU8nWHg/C7Y1G6blBoU/Xh7a+qcxD6HUXipY
 LTacmHBBml5j0jHTPEBwjkrASYFG9T5l0VQhiI0OsUkXf/XciQxiTYe7VzYWD9ZY2UHtBm0d
 YiyXAp+GYSnZscqW25/y6EbLQvw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 610be9f6041a739c467414b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Aug 2021 13:39:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 799CCC43460; Thu,  5 Aug 2021 13:39:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6823C433D3;
        Thu,  5 Aug 2021 13:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6823C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho\, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <87bl7vi3o1.fsf@codeaurora.org>
        <CANUX_P3QE9xNnQLT=mHNDp4VCv37Bcjuvn9O1wQ4Btejjkbrvg@mail.gmail.com>
Date:   Thu, 05 Aug 2021 16:38:57 +0300
In-Reply-To: <CANUX_P3QE9xNnQLT=mHNDp4VCv37Bcjuvn9O1wQ4Btejjkbrvg@mail.gmail.com>
        (Emmanuel Grumbach's message of "Thu, 24 Jun 2021 23:04:56 +0300")
Message-ID: <87k0l0c8pa.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <egrumbach@gmail.com> writes:

>> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_OPEN !=
>> > +                  (u32)SAP_WIFI_AUTH_TYPE_OPEN);
>> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA !=
>> > +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA);
>> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA_PSK !=
>> > +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA_PSK);
>> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_SAE !=
>> > +                  (u32)SAP_WIFI_AUTH_TYPE_SAE);
>> > +
>> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_NONE !=
>> > +                  (u32)SAP_WIFI_CIPHER_ALG_NONE);
>> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_CCMP !=
>> > +                  (u32)SAP_WIFI_CIPHER_ALG_CCMP);
>> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP !=
>> > +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP);
>> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP_256 !=
>> > +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP_256);
>>
>> These look just weird, and suspicious. You are using two different enums
>> but they have to be same values, or what?
>
> Exactly. I don't want the userspace to have to include all the SAP
> protocol header file. OTOH, I don't want to have to translate between
> vendor commands attributes values and the SAP values.

Why not? I assume you would just need a helper function with switch
statements to "translate" between enums, not much more lines of code but
a lot cleaner code.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
