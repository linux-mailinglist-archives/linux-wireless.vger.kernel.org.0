Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1207FD5DFA
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfJNI5x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 04:57:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbfJNI5x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 04:57:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2CFD60240; Mon, 14 Oct 2019 08:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571043471;
        bh=vEpaAXBe+dJHnNJjhSIggvvTIktrwoFHvHgLxkxYqH4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aeqqQ8YtOAPcrDZnHZ0KGQ0Lq+kdlBjHP9HTYVvkwV8MjvnPTqLiVxO34EeFL8v/4
         2WdgodPpNzvloOFCZvm62Re7s/CXuabivQMXbD3isHaDWoMscQhreBazxQkrP2eBwe
         hdl46udsMcRlWbTnVYs2zMGYXRer7m8XXsF5Fj5Y=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2B6760240;
        Mon, 14 Oct 2019 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571043471;
        bh=vEpaAXBe+dJHnNJjhSIggvvTIktrwoFHvHgLxkxYqH4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aeqqQ8YtOAPcrDZnHZ0KGQ0Lq+kdlBjHP9HTYVvkwV8MjvnPTqLiVxO34EeFL8v/4
         2WdgodPpNzvloOFCZvm62Re7s/CXuabivQMXbD3isHaDWoMscQhreBazxQkrP2eBwe
         hdl46udsMcRlWbTnVYs2zMGYXRer7m8XXsF5Fj5Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2B6760240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        vnaralas@codeaurora.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [RFC PATCH 0/2] ath10k: provide survey info as accumulated data
References: <20190918124259.17804-1-sven@narfation.org>
        <9a9ec99b-9643-7288-eed5-b549a9fe1487@newmedia-net.de>
        <1614044.H5m0Cyd3Ly@bentobox>
Date:   Mon, 14 Oct 2019 11:57:47 +0300
In-Reply-To: <1614044.H5m0Cyd3Ly@bentobox> (Sven Eckelmann's message of "Mon,
        14 Oct 2019 09:07:42 +0200")
Message-ID: <871rvfzotw.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> On Monday, 14 October 2019 00:15:20 CEST Sebastian Gottschall wrote:
>> i checked your patch on 10.4 based chipsets with 9984. the values are 
>> now looking bogus and wrong at all. busy and active time time in ms does 
>> increase in hours each second
>> the problem seem to be that your patch is 10.2.4 only related. 
>> ath_clean_survey does not trigger on 10.4 so the values double itself 
>> each time the event raises since you add the full values and not just a 
>> delta on top
>
> Thanks for the feedback. So we have now a firmware 10.2.4 which is counting 
> busy + active up and has wraparound problems. And then we have a 10.4 firmware 
> (on QCA9888 and QCA4019) which is clearing everything as expected with 
> WMI_BSS_SURVEY_REQ_TYPE_READ_CLEAR  and then we have some 10.4 firmware (one 
> QCA9984) which behaves more like ath 10.2.4 firmware but is marked as 
> ATH10K_HW_CC_WRAP_SHIFTED_EACH like the QCA4019.
>
> So I have no idea how to fix this when QCA4019 and QCA9984 are currently 
> marked the same but behave differently. Does somebody have a overview how the 
> different HW versions should behave or is there some special bit in the data 
> reported by the firmware which can be used to evaluate the expected behavior?

I hope there's an easy way to detect this behaviour change, but if
nothing else we could add a new bit to enum ath10k_fw_features. But of
course that's the last resort, maintaining the firmware features
bitfield accross different firmware branches is quite cumbersome.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
