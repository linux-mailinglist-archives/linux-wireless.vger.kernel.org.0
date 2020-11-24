Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A382C1EA0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 08:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgKXHFA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 02:05:00 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:34212 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729240AbgKXHE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 02:04:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 5A9A74FA9A3;
        Tue, 24 Nov 2020 07:04:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id a_hUqD-UMCw3; Tue, 24 Nov 2020 07:04:56 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id B6E814FA8EF;
        Tue, 24 Nov 2020 07:04:55 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 23 Nov 2020 23:04:54 -0800
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 14/17] mac80211: support S1G association
In-Reply-To: <5d5df04df5a972d8be0c67c75298b82a@codeaurora.org>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
 <20200922022818.15855-15-thomas@adapt-ip.com>
 <af51dd8e9dea2961546a502d9090d1a7@codeaurora.org>
 <0a87b577fe443b0d7979f30d24767c4b@adapt-ip.com>
 <5d5df04df5a972d8be0c67c75298b82a@codeaurora.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <1361fa0bd41e8807c2f402e0802241e8@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-23 19:59, Wen Gong wrote:
> On 2020-11-24 02:40, Thomas Pedersen wrote:
>> On 2020-11-23 00:38, Wen Gong wrote:
>>> On 2020-09-22 10:28, Thomas Pedersen wrote:
>>> ...
>>>> @@ -3446,6 +3453,42 @@ bool ieee80211_chandef_he_6ghz_oper(struct
>>>> ieee80211_sub_if_data *sdata,
>>>> 
>>>>  	*chandef = he_chandef;
>>>> 
>>>> +	return false;
>>>> +}
>>> This change the "return true" to "return false" by default of
>>> ieee80211_chandef_he_6ghz_oper.
>>> It should be typo mistake.
>> 
>> Thanks Wen. This was maybe rebase damage? Will send a fixup.
> yes, I have sent a patch, 6G connect success with this patch,
> otherwise fail for 6G connect.
> https://lore.kernel.org/linux-wireless/1606121152-3452-1-git-send-email-wgong@codeaurora.org/

Excellent, thank you.

-- 
thomas
