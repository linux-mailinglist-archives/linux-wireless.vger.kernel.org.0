Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED831E81F3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgE2Pg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 11:36:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48706 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgE2Pg4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 11:36:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590766615; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=R0S37/3Lq9MgkJb1uC/wBrJU6DhgGifbVcb6FAu1Uig=; b=g/BxSciezYXn9aFN0O6alwP1aiJ+/j56D+eFrc+GGnWht6Vph3D3NAFB+IG5c/+8VikNhWbt
 KSxZsEMZpW4m+LBhROGsyVdnO6PeLsEkztoOCXPCydjbFU0pyk4BuQETasXnrcIu2SgOFthh
 Xie0p7n0aLC0S3uSNDYsG8utOc0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ed12c144776d1da6db65ed5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 15:36:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA991C433C6; Fri, 29 May 2020 15:36:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74C76C433CA;
        Fri, 29 May 2020 15:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74C76C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
References: <1587649759-14381-1-git-send-email-mkenna@codeaurora.org>
        <20200505073422.BFA51C433BA@smtp.codeaurora.org>
        <63ec6f30-ee3b-c412-7c56-46d447b17c8e@dd-wrt.com>
Date:   Fri, 29 May 2020 18:36:48 +0300
In-Reply-To: <63ec6f30-ee3b-c412-7c56-46d447b17c8e@dd-wrt.com> (Sebastian
        Gottschall's message of "Tue, 26 May 2020 17:29:24 +0200")
Message-ID: <87ftbisqgf.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:

> Am 05.05.2020 um 09:34 schrieb Kalle Valo:
>
>> Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:
>>
>>> As the exisiting CE configurations are defined in global, there
>>> are the chances of QCA99X0 family chipsets CE configurations
>>> are getting changed by the ath10k_pci_override_ce_config()
>>> function.
>>>
>>> The override will be hit and CE5 configurations will be changed,
>>> when the user bring up the QCA99X0 chipsets along with QCA6174
>>> or QCA9377 chipset. (Bring up QCA99X0 family chipsets after
>>> QCA6174 or QCA9377).
>>>
>>> Hence, fixing this issue by moving the global CE configuration
>>> to radio specific CE configuration.
>>>
>>> Tested hardware: QCA9888 & QCA6174
>>> Tested firmware: 10.4-3.10-00047 & WLAN.RM.4.4.1.c3-00058
>>>
>>> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
>> Patch applied to ath-next branch of ath.git, thanks.
>>
>> 521fc37be3d8 ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
>
> this patch will crash on ipq4019 devices. i reverted it and it worked again

Yeah, that patch is buggy but this should fix it:

commit 32221df6765b3773ff1af37c77f8531ebc48f246
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Sat May 9 14:06:33 2020 +0200
Commit:     Kalle Valo <kvalo@codeaurora.org>
CommitDate: Tue May 12 10:33:13 2020 +0300

    ath10k: fix ath10k_pci struct layout

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
