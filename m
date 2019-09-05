Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9966BAA13B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfIELYR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 07:24:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfIELYR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 07:24:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2887660863; Thu,  5 Sep 2019 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567682656;
        bh=bXBc7zdddhaTSlMEPK7QbTKYtRiz+go4+nkLx5X8eGo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Dw3p9VD1EiFBn6m05v01IAd5hewDHO58IUpHPFnO2+rgUyPHaFDb0rdx+7ViYa4Ug
         YMOsCKCCt5LMz9SsoklOHWK7Ym9JIxBoXC4hP3dBJbOaFLUh92hR2eHskKng4h1/Bg
         M8qZ4CwSGqzmak/7BFcQzMt8lNcbWWK1V8U9Y2wo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 516EA605A0;
        Thu,  5 Sep 2019 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567682655;
        bh=bXBc7zdddhaTSlMEPK7QbTKYtRiz+go4+nkLx5X8eGo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=o/c+5rO6ZLjyJfeUGgc/+kRxkSAcMHI3IJE3C8bn7dMzRII5cWU2CjHiLPPBOSItU
         HNzme+I89qUyXfoBqFANzjJsJYRONvawJrY8k0WgyQWZaSXeabEwmKMz4jrLd8Sqfd
         yudt+xTC+p2XFrgNg5RQ+wywwlYm4gP7yG//kJGY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 516EA605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
        <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
        <4076919b34cad119eb4146025f587285ef40e37c.camel@sipsolutions.net>
        <ee38dc5e80097d0ebc186f81b2f11d37@codeaurora.org>
Date:   Thu, 05 Sep 2019 14:24:11 +0300
In-Reply-To: <ee38dc5e80097d0ebc186f81b2f11d37@codeaurora.org> (Vasanthakumar
        Thiagarajan's message of "Fri, 23 Aug 2019 17:45:41 +0530")
Message-ID: <878sr3nfz8.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:

> On 2019-08-21 02:16, Johannes Berg wrote:
>> On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
>>
>>> +static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
>>> +{
>>> +	struct ath11k *ar = hw->priv;
>>> +	int ret = 0;
>>> +
>>> +	/* mac80211 requires this op to be present and that's why
>>> +	 * there's an empty function, this can be extended when
>>> +	 * required.
>>> +	 */
>>
>> Well, oops. Maybe it shouldn't be required?
>
> I think we require this for some configuration handling. The comment
> is to be updated with proper information. We'll address that.

The way I'm understanding Johannes' comment is that maybe we should
change mac80211 to require this op to be present. Should be easy to fix
in mac80211, right?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
