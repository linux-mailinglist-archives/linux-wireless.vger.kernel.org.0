Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C410ACB8FD
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfJDLTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 07:19:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfJDLTo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 07:19:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9661561A1B; Fri,  4 Oct 2019 11:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570187983;
        bh=VmJtK+9wMv6b2twmQaVx1NvU/jWXVR09aUTD4hwh4PI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MmoJyt5LInmKqOX7x+UGlfbvGuGqwZdQ1WXJjhsKPu4rV0s2Fez0VQs/avW4JnWf/
         BCgrvGaiC59RSBblaDpwRKe+LKJSskeR3Z8dmVse4r4neX/WoQL31kCEWtIkZli4GE
         cPLBoKllf0cXNVDAPPCmnUxJIiaDzcPLfpEu2Q6g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-33-18-250.bb.dnainternet.fi [37.33.18.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4000615C2;
        Fri,  4 Oct 2019 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570187983;
        bh=VmJtK+9wMv6b2twmQaVx1NvU/jWXVR09aUTD4hwh4PI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MmoJyt5LInmKqOX7x+UGlfbvGuGqwZdQ1WXJjhsKPu4rV0s2Fez0VQs/avW4JnWf/
         BCgrvGaiC59RSBblaDpwRKe+LKJSskeR3Z8dmVse4r4neX/WoQL31kCEWtIkZli4GE
         cPLBoKllf0cXNVDAPPCmnUxJIiaDzcPLfpEu2Q6g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4000615C2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 5.4 regression fix] brcmfmac: Fix brcmf_cfg80211_get_channel returning uninitialized fields
References: <20191003200821.819594-1-hdegoede@redhat.com>
        <87r23ssssh.fsf@codeaurora.org>
        <0d86c109-78d3-3858-ae56-e4cdcb056fe4@redhat.com>
Date:   Fri, 04 Oct 2019 14:19:37 +0300
In-Reply-To: <0d86c109-78d3-3858-ae56-e4cdcb056fe4@redhat.com> (Hans de
        Goede's message of "Fri, 4 Oct 2019 12:37:22 +0200")
Message-ID: <87muegsqpi.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> Hi,
>
> On 10/4/19 12:34 PM, Kalle Valo wrote:
>> Hans de Goede <hdegoede@redhat.com> writes:
>>
>>> With the new edmg support struct cfg80211_chan_def has been extended
>>> with a number of new members. brcmf_cfg80211_get_channel() was not setting
>>> (clearing) these causing the cfg80211_edmg_chandef_valid() check in
>>> cfg80211_chandef_valid() to fail. Triggering a WARN_ON and, worse, causing
>>> brcmfmac based wifi cards to not work.
>>>
>>> This commit fixes this by clearing the entire passed struct to 0 before
>>> setting the members used by the brcmfmac code. This solution also makes
>>> sure that this problem will not repeat itself in the future if further
>>> members are added to the struct.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> index e3ebb7abbdae..480c05f66ebd 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> @@ -5041,10 +5041,10 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
>>>   	}
>>>     	freq = ieee80211_channel_to_frequency(ch.control_ch_num,
>>> band);
>>> +	memset(chandef, 0, sizeof(*chandef));
>>>   	chandef->chan = ieee80211_get_channel(wiphy, freq);
>>>   	chandef->width = width;
>>>   	chandef->center_freq1 = ieee80211_channel_to_frequency(ch.chnum, band);
>>> -	chandef->center_freq2 = 0;
>>>     	return 0;
>>>   }
>>
>> Is this a separate issue from the cfg80211 fix:
>>
>> cfg80211: initialize on-stack chandefs
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=f43e5210c739fe76a4b0ed851559d6902f20ceb1
>
> No it is the same issue, I was actually wondering if I should do a generic fix
> instead... I'm glad someone has already fixed this with a generic fix. Assuming the
> generic fix is going upstream soon

It's in net tree right now so it should go to Linus' tree soon.

> then this (my) patch can be dropped.

Ok, I'll drop it.

-- 
Kalle Valo
