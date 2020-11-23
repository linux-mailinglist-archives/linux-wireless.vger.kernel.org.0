Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F82C13DB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 20:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgKWStX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 13:49:23 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:51966 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728953AbgKWStW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 13:49:22 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 13:49:21 EST
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 7FE034FA747;
        Mon, 23 Nov 2020 18:40:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id MRqcd5_cqVrQ; Mon, 23 Nov 2020 18:40:12 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 660C04FA5C9;
        Mon, 23 Nov 2020 18:40:12 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 23 Nov 2020 10:40:11 -0800
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 14/17] mac80211: support S1G association
In-Reply-To: <af51dd8e9dea2961546a502d9090d1a7@codeaurora.org>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
 <20200922022818.15855-15-thomas@adapt-ip.com>
 <af51dd8e9dea2961546a502d9090d1a7@codeaurora.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0a87b577fe443b0d7979f30d24767c4b@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-23 00:38, Wen Gong wrote:
> On 2020-09-22 10:28, Thomas Pedersen wrote:
> ...
>> @@ -3446,6 +3453,42 @@ bool ieee80211_chandef_he_6ghz_oper(struct
>> ieee80211_sub_if_data *sdata,
>> 
>>  	*chandef = he_chandef;
>> 
>> +	return false;
>> +}
> This change the "return true" to "return false" by default of
> ieee80211_chandef_he_6ghz_oper.
> It should be typo mistake.

Thanks Wen. This was maybe rebase damage? Will send a fixup.

-- 
thomas
