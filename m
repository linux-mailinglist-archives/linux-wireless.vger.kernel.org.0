Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBEBA3D6E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfH3SIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 14:08:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfH3SIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 14:08:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A02556020A; Fri, 30 Aug 2019 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567188514;
        bh=1pKFuUQE5xzl4UuFEP6ZvXvrKsLZzRjVK2Emp7wjFZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iveKN1UUdKkyNSmSK9/CWp1EyePKngZ5Yn1/Q8ovekkO81F1MTc1hwTBefu9EfDZN
         59lS5lWYWsONND5LR9yPtiecNOpmysv+47Y4++HZVYRlyZWtx+y2Yc0wK7MOUWSULF
         8w2zPAQX3DCak+TrtcRz2ZhnKxVcpMrXjSCtrwl8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 285626014B;
        Fri, 30 Aug 2019 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567188514;
        bh=1pKFuUQE5xzl4UuFEP6ZvXvrKsLZzRjVK2Emp7wjFZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iveKN1UUdKkyNSmSK9/CWp1EyePKngZ5Yn1/Q8ovekkO81F1MTc1hwTBefu9EfDZN
         59lS5lWYWsONND5LR9yPtiecNOpmysv+47Y4++HZVYRlyZWtx+y2Yc0wK7MOUWSULF
         8w2zPAQX3DCak+TrtcRz2ZhnKxVcpMrXjSCtrwl8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Aug 2019 11:08:34 -0700
From:   asinghal@codeaurora.org
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     johannes@sipsolutions.net, jouni@codeaurora.org,
        linux-wireless@vger.kernel.org, jjohnson@codeaurora.org,
        rmanohar@codeaurora.org
Subject: Re: [PATCH] cfg80211: Convert 6 GHz channel frequency to channel
 number
In-Reply-To: <eced13d4e91dee3f5ad82a2278ef7af5@codeaurora.org>
References: <1567117290-19295-1-git-send-email-asinghal@codeaurora.org>
 <544cab9b-8914-370d-c8a9-407ce88f6f32@broadcom.com>
 <eced13d4e91dee3f5ad82a2278ef7af5@codeaurora.org>
Message-ID: <c0e98022ea9be0e9f2bb01c06b712bf0@codeaurora.org>
X-Sender: asinghal@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Correction in typo below:

On 2019-08-30 11:03, asinghal@codeaurora.org wrote:
> On 2019-08-30 03:45, Arend Van Spriel wrote:
>> On 8/30/2019 12:21 AM, Amar Singhal wrote:
>>> Enhance function ieee80211_frequency_to_channel by adding 6 GHz
>>> channels.
>> 
>> This look very similar to what I submitted earlier:
>> 
>> https://patchwork.kernel.org/patch/11073197/
>> 
>> Regards,
>> Arend
> -	else if (freq <= 45000) /* DMG band lower limit */
> +	else if (freq < 5940)
>  		return (freq - 5000) / 5;
> +	else if (freq <= 45000) /* DMG band lower limit */
> +		/* see 802.11ax D4.1 27.3.22.2 */
> +		return (freq - 5940) / 5;
> 
> hi Arend,
>           I see a small issue in your patch above; for frequency 5940,
> the channel number returned would be 0 which is an invalid channel. I
> guess 6 GHz center frequency numbers begin with 5945.
> 
> rgds,
> Amar
