Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B703CD22
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404095AbfFKNjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 09:39:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404086AbfFKNjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 09:39:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27B28602F3; Tue, 11 Jun 2019 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560260364;
        bh=8muyLxQ9Esx6e3DdbOApaV2hLR5OTkQcbjpdWShSb3I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AUcXD+4puYnHnUy8+OBXwiK+kO3jvZ1f0WeQaGoG1o6j15nr8Z7pZvhoy8lpJRuCG
         EQp2iueONHcQoq/h6ZJvdOgoMYgHKTi5niLWr0zK52JJ4BOomZKb4MaXoCTAxngyNb
         06Uq9Inksw1fySfwek7uAqnFDSkPi7lZK0Vws3XM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB1AE602F3;
        Tue, 11 Jun 2019 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560260363;
        bh=8muyLxQ9Esx6e3DdbOApaV2hLR5OTkQcbjpdWShSb3I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KHmYKtWcGnDHI7VzVTn6rwyGvx7Afgsko3tTu1Njd5Xz35kjWKtIISzk7AAqeF9AD
         fqpHPNyp233lJfXEI45mAM6PvQBxqoc2l0euGDUh2FKS49EPjzooeGJki4hXkzHlPD
         zW0tbGk9Qcx1wkfaJp808epe/NPCFyb1cXCi68FY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB1AE602F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/11] rtw88: power index setting routine updates and fixes
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
        <F7CD281DE3E379468C6D07993EA72F84D1803B44@RTITMBSVM04.realtek.com.tw>
Date:   Tue, 11 Jun 2019 16:39:19 +0300
In-Reply-To: <F7CD281DE3E379468C6D07993EA72F84D1803B44@RTITMBSVM04.realtek.com.tw>
        (Tony Chuang's message of "Tue, 11 Jun 2019 10:07:54 +0000")
Message-ID: <87pnnkgs1k.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> -----Original Message-----
>> From: linux-wireless-owner@vger.kernel.org
>> [mailto:linux-wireless-owner@vger.kernel.org] On Behalf Of
>> yhchuang@realtek.com
>> Sent: Wednesday, May 29, 2019 3:55 PM
>> To: kvalo@codeaurora.org
>> Cc: linux-wireless@vger.kernel.org
>> Subject: [PATCH 00/11] rtw88: power index setting routine updates and fixes
>> 
>
> ...
>
>>  drivers/net/wireless/realtek/rtw88/debug.c         |  112 ++
>>  drivers/net/wireless/realtek/rtw88/main.c          |   26 +-
>>  drivers/net/wireless/realtek/rtw88/main.h          |   27 +-
>>  drivers/net/wireless/realtek/rtw88/phy.c           | 1298
>> +++++++++++---------
>>  drivers/net/wireless/realtek/rtw88/phy.h           |   18 +-
>>  drivers/net/wireless/realtek/rtw88/regd.c          |   69 +-
>>  drivers/net/wireless/realtek/rtw88/regd.h          |    4 +
>>  .../net/wireless/realtek/rtw88/rtw8822c_table.c    |  799 +++++++++++-
>>  8 files changed, 1653 insertions(+), 700 deletions(-)
>> 
>> --
>
> Hi Kalle
>
> I am going to submit a v2 for this.
> Will you suggest me to format the patches based on
> wireless-drivers or wireless-drivers-next?

Please use wireless-drivers-next as the baseline. I recommend to split
the set, submit now the patches which apply right now and submit the
rest after the dependencies are in w-d-next.

But do note that I haven't had a chance to review your patches yet.

-- 
Kalle Valo
