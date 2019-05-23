Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0B27904
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfEWJRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 05:17:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfEWJRW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 05:17:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EA3816119F; Thu, 23 May 2019 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558603042;
        bh=whzqWk1PVYcOxSvyx06r9Piq/ykodh2hdm7O02O45V8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=blrb1fanTQhHqaWOuy+b4qRFz1ocUj4V08gpkLz9KtYiHuZyOsq2CWfbxAQpZ21H5
         qSk6DSRC752XPB7+a5XznfOUaQ3U0RUDD9YeMEq2AfH8wx2h9t6Ge0dKtq2+GwBXqk
         Y7m6Dcz37R3yoNLkmgICRq7gLu8nSvGMYZ40p+94=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C9BF96119F;
        Thu, 23 May 2019 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558603034;
        bh=whzqWk1PVYcOxSvyx06r9Piq/ykodh2hdm7O02O45V8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MvdylwCLDiA/IcnNXRpKAnXtYeidSZtzbUKhAV3MpGhM786mRafhyj8rKDL/TE354
         Lwna4vi/YK79z/crsGRA06Z7RwTpPoZCtk2TAzPSlKt4X/pv4XAuRZ7xDQM9HLI7/g
         STfHJ/VLsIhPxTcMLtgg1/7f2ESlDiLg9kEK0woo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9BF96119F
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
        <87mujhoymm.fsf@codeaurora.org>
        <f4d582e8-3d65-959f-78bd-88b7c47131a5@broadcom.com>
Date:   Thu, 23 May 2019 12:17:10 +0300
In-Reply-To: <f4d582e8-3d65-959f-78bd-88b7c47131a5@broadcom.com> (Arend Van
        Spriel's message of "Tue, 21 May 2019 10:11:28 +0200")
Message-ID: <871s0pedih.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On 5/20/2019 6:54 PM, Kalle Valo wrote:
>> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
>>
>>> On 5/16/2019 10:57 PM, Arend Van Spriel wrote:
>>>> On 5/16/2019 2:04 PM, Arend van Spriel wrote:
>>>>> With ISC license text in place under the LICENSES folder switch
>>>>> to using the SPDX license identifier to refer to the ISC license.
>>>>
>>>> Hi Kalle,
>>>>
>>>> Given the feedback on checkpatch (or spdxcheck) failures let me
>>>> respin this series.
>>>
>>> Actually let's *NOT* respin and leave this series as is and ignore the
>>> warning for the header files as Thomas wrote in his response: " So we
>>> can fixup the documentation and allow // style for headers as well.".
>>
>> What about patch 3, should I drop that patch? Wasn't the conclusion that
>> you need separately change led.c?
>
> Okay. Let's do that.

Dropped it now.

> Or do you want me to resend the whole series without patch 3?

If the series applies without patch 3 (and I assume it does) no need to
resend the whole series.

-- 
Kalle Valo
