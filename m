Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFB3B344E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFXRJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 13:09:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55015 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhFXRJs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 13:09:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624554449; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=QbXLgcp1VUHma4NNu0yOih9ynib1oWHVj4X3wpBbCLQ=; b=MQPweehtZ3G6doMXR4cjy0ZdyLfmn6AxPyARA7DUNeutwMW+hAsmvERjUv3ZSsU4b9nOBVHw
 /z5b0mRJgK4mLYBc2Qlblc4Kzc4eWHVi+NU6NamLLcMHBqNWt3oHNS0cTt52AUGd4Amds3fr
 QSTZKxvVS0X3b7aQd3R8DMpEtIQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60d4bbbf3a8b6d0a45378f30 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 17:07:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C7D8C4338A; Thu, 24 Jun 2021 17:07:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98EBFC433F1;
        Thu, 24 Jun 2021 17:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98EBFC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     luciano.coelho@intel.com, linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
        <20210623141033.27475-3-emmanuel.grumbach@intel.com>
Date:   Thu, 24 Jun 2021 20:07:06 +0300
In-Reply-To: <20210623141033.27475-3-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 23 Jun 2021 17:10:32 +0300")
Message-ID: <87k0mji43p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> iwlmei allows to integrate with the CSME firmware. There are
> flows that are prioprietary for this purpose:
>
> * Get the information the AP, the CSME firmware is connected
>   to. This is useful when we need to speed up the connection
>   process in case the CSME firmware has an TCP connection
>   that must be kept alive across the ownership transition.
> * Forbid roaming, which will happen when the CSME firmware
>   wants to tell the user space not disrupt the connection.
> * Request ownership, upon driver boot when the CSME firmware
>   owns the device.

Vendor command requirements are documented here:

https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

The commit log is not really answering to those. For example, how a user
would use this? Or is there a user space tool?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
