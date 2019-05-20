Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9426F23DE1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbfETQyN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 12:54:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388746AbfETQyN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 12:54:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01DE360A00; Mon, 20 May 2019 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558371253;
        bh=filpsvajFpZGmcNEeuFMkQdavM4iEFvAD69hKsTDXaE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YfAojvtOWFHAiPP9Z/0rwph3pCrysykr8iwjxRQgXuAaFedl90RzVTg39LARyaTQ9
         ywL9UGBp/G2IDrpYMdYIvQ7TUoCPitrBQxk8yIVNUHrd2b7+VKotxnYQ+R3MK5wAWD
         sL7Sn1JsLOHX/ZCbBixUrBwWbcJCcBRqQQOsO/CY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (178-55-149-241.bb.dnainternet.fi [178.55.149.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD58E607DF;
        Mon, 20 May 2019 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558371252;
        bh=filpsvajFpZGmcNEeuFMkQdavM4iEFvAD69hKsTDXaE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h9o63J3wvfE8q1ZBmoVtMc5IAIZZlQhmEZrsCNu2D8Mhb2kx0eHlvkE2JCiLrItc6
         jRwbUdb3mpf2vdfSo7WiJpzMZZpo+5YpSzVeKkAeBnNk7K9DtanfNiGkJ55029iG5y
         AWeIkJX95NbgxJTZiMyKVHRbS+zK+h3zajC5eI/Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD58E607DF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/7] brcm80211: switch common header files to using SPDX license identifier
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
        <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
        <3dcbfbab-a1f0-bdc6-909a-d9ed225e060a@broadcom.com>
        <f35219bc-88c2-cc8d-530e-516fb7a4ce80@broadcom.com>
Date:   Mon, 20 May 2019 19:54:09 +0300
In-Reply-To: <f35219bc-88c2-cc8d-530e-516fb7a4ce80@broadcom.com> (Arend Van
        Spriel's message of "Fri, 17 May 2019 20:04:42 +0200")
Message-ID: <87mujhoymm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On 5/16/2019 10:57 PM, Arend Van Spriel wrote:
>> On 5/16/2019 2:04 PM, Arend van Spriel wrote:
>>> With ISC license text in place under the LICENSES folder switch
>>> to using the SPDX license identifier to refer to the ISC license.
>>
>> Hi Kalle,
>>
>> Given the feedback on checkpatch (or spdxcheck) failures let me
>> respin this series.
>
> Actually let's *NOT* respin and leave this series as is and ignore the
> warning for the header files as Thomas wrote in his response: " So we
> can fixup the documentation and allow // style for headers as well.".

What about patch 3, should I drop that patch? Wasn't the conclusion that
you need separately change led.c?

-- 
Kalle Valo
