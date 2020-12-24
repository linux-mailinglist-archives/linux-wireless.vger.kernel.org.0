Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691F62E2847
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Dec 2020 18:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgLXRIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Dec 2020 12:08:54 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:42416 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgLXRIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Dec 2020 12:08:54 -0500
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7839313C2B0;
        Thu, 24 Dec 2020 09:08:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7839313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1608829693;
        bh=oCowPKW6aP6ZhyDp64QY45cgY8fT8fWhW+s1yumAXc0=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=CZeIwiH0kGcdGDwwmLLGRSf5OVSRjWFxLZSX0sDgC8DvGTUX8xWhYICqF8RGXhX3Q
         9Q+DnHZSQhoKQ/dB70T073PIj085ZbDKOUAMAKXk1LPrBWq2+Py7LsbZDydYlC3dB/
         Y8To0BxNsg8Dn0vEz74tDJrbSXs2b+LKRB93x8U0=
Subject: Re: skb_cb corruption in ath10k
From:   Ben Greear <greearb@candelatech.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
References: <86170a90-da2f-3227-d7e5-fe9486156705@candelatech.com>
Organization: Candela Technologies
Message-ID: <c79bb1d2-3571-4f3f-12a8-bce6701a7241@candelatech.com>
Date:   Thu, 24 Dec 2020 09:08:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <86170a90-da2f-3227-d7e5-fe9486156705@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/21/20 3:55 PM, Ben Greear wrote:
> Hello,
> 
> I'm trying to figure out what changed in the last few kernels that is making:
> 
> struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
> if (info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)
>      /* why is code here all of a sudden */
> 
> in data frames in ath10k,
> when, to the best of my knowledge, nothing should be setting that up in the stack.
> 
> My guess is that something is stepping on the cb field somewhere in ath10k,
> but I am not sure where that might be at this point.
> 
> And it also appears mac80211 or maybe supplicant is setting the rate-inject flag on some mgt frames,
> but I think that is a separate concern at this point.
> 
> If anyone has any ideas of likely points, please let me know.

This issue was me being confused about how the ath10k skb_cb sits in
the same memory as the iee skb_cb.  I just needed to reorder the
ath10k-skb-cb struct a bit to not clobber the control.flags area.

I also see no reason not to natually pack that stuct so that the
pointers are 8-byte aligned.  Any idea why it is force-packed
currently instead of using proper padding?

Thanks,
Ben


