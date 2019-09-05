Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95F8AA240
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfIEL64 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 07:58:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388858AbfIEL6z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 07:58:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5872D6141C; Thu,  5 Sep 2019 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567684734;
        bh=RFBWIwj07wtOEhbOnjqpWWtm5NCKOu5K+99w2z07EL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UxWrn1zHB9Gpkwy0fQWUbHF2EsJzWPLsTK4xhs3d6LlLNr3imdzVRwvHl42IL7OBW
         uJ1HsUlzb0tXYoPlLUaOGsz04FKYL62Bi+HCN8RyGaP6SvMwUmasBuRllkHCTd5NGp
         PmabpwNs3ZvUQlpYwOqSJqdgo4vkNdok0HdwojyM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9577F61378;
        Thu,  5 Sep 2019 11:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567684733;
        bh=RFBWIwj07wtOEhbOnjqpWWtm5NCKOu5K+99w2z07EL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1mxxaAJmZpHGgfp3V8iq7pDEZta2jgcYBdnlAGnqlqlaycBh1jy1wv061/EkTvDZ
         IFCb4jd1CYhXK6KnvhO5vCClv3oNP+XmffJVDXv5Bsuy4fAc2Kxf9U/DyA9Y+m4T10
         veV7sSUW8E6c+T4bNiV3t2t3Xbbp6kHWg26l4+Mc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Sep 2019 17:28:53 +0530
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
In-Reply-To: <878sr3nfz8.fsf@kamboji.qca.qualcomm.com>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
 <4076919b34cad119eb4146025f587285ef40e37c.camel@sipsolutions.net>
 <ee38dc5e80097d0ebc186f81b2f11d37@codeaurora.org>
 <878sr3nfz8.fsf@kamboji.qca.qualcomm.com>
Message-ID: <8e90a557c1659995d117c6dc8b728d7f@codeaurora.org>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-05 16:54, Kalle Valo wrote:
> Vasanthakumar Thiagarajan <vthiagar@codeaurora.org> writes:
> 
>> On 2019-08-21 02:16, Johannes Berg wrote:
>>> On Tue, 2019-08-20 at 18:47 +0300, Kalle Valo wrote:
>>> 
>>>> +static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 
>>>> changed)
>>>> +{
>>>> +	struct ath11k *ar = hw->priv;
>>>> +	int ret = 0;
>>>> +
>>>> +	/* mac80211 requires this op to be present and that's why
>>>> +	 * there's an empty function, this can be extended when
>>>> +	 * required.
>>>> +	 */
>>> 
>>> Well, oops. Maybe it shouldn't be required?
>> 
>> I think we require this for some configuration handling. The comment
>> is to be updated with proper information. We'll address that.
> 
> The way I'm understanding Johannes' comment is that maybe we should
> change mac80211 to require this op to be present. Should be easy to fix
> in mac80211, right?

Ok. So make this callback optional in mac80211? should be a simple code 
change.

Vasanth
