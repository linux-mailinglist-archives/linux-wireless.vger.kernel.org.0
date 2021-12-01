Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86441464DDA
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbhLAMbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhLAMbh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:31:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484CC061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 04:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB5C1B81EAE
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 12:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A8EC53FCC;
        Wed,  1 Dec 2021 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638361693;
        bh=KKJl+mhx0O8LCR+z5yqK/1cit2zKhNWB0V698tem0IY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Wedae2ADWr1gpZ6cbAfrzeVCVz2Vp84pRPMxiSQr4v7oNK0RoYI1uC/8S9x33yDU9
         zWXhKT9E/VrEMk9Ut0xTEkvna0DPaJhmETt976CR5MKLW6mSRszRks9HLZN7KwitSM
         bYDKrGacjDUqSYo9H6CprkbVhHtZ482uDSZNY52gcqPtRA06IyMqtaABHzidEHfIEK
         gtiF2j+f+rCCVhXVBdZAOfA+OO432XPJ4KBJB24bOy/IvITuQ3AQp8sGDfCyhw2PCe
         Gjl9/uSspkq3hdwGeMNgog8GyQ7EenZVUSe7Uv0PKgL5QLWaLQbrb5LzIBUcJuB2FX
         yprXEJMOpsj2g==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "luca\@coelho.fi" <luca@coelho.fi>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
References: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
        <87fsrco6r1.fsf@codeaurora.org>
        <SA1PR11MB5825B46CCB4DF4207F4D5B4DF2689@SA1PR11MB5825.namprd11.prod.outlook.com>
Date:   Wed, 01 Dec 2021 14:28:09 +0200
In-Reply-To: <SA1PR11MB5825B46CCB4DF4207F4D5B4DF2689@SA1PR11MB5825.namprd11.prod.outlook.com>
        (Emmanuel Grumbach's message of "Wed, 1 Dec 2021 12:23:48 +0000")
Message-ID: <87bl20o6g6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com> writes:

>> 
>> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>> 
>> > I forgot to add stubs in case tracing is disabled.
>> >
>> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
>> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>> 
>> Fixes tag? I can add that.
>
> I skipped that because it's not merged in Linus's tree yet, so, no
> stable consideration.
> I didn't know we need a Fixes tag for patches that are just in next as well.

I don't rebase my trees and neither does Dave&Jakub, so the commit ids
won't change. What commit id should I use? I can then add the fixes tag.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
