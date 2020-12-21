Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDA32E031A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 00:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLUX4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 18:56:13 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:56170 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUX4N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 18:56:13 -0500
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D6CAB13C2B0;
        Mon, 21 Dec 2020 15:55:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D6CAB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1608594933;
        bh=F7ozhtwuhrGggN6wJ+krzNZQfpP/UK5VVPFr3YEjxhQ=;
        h=To:From:Subject:Date:From;
        b=ogR/GZ1OPjUFX3TvDeoeHM1YmF9ARkn4sLw91wuApWn+vVHBfoLMgb3AZILxrpwgF
         m2CzWq1fQfzoS7QfTs6xa5uD2gnXYE94DLp7iIDJvZyjuqKEKWT9qQjJvu4t/gDLt+
         Zl1+cKWfrGZeMZeoisK+QDR0gojVKcRyiOMMY0ow=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: skb_cb corruption in ath10k
Organization: Candela Technologies
Message-ID: <86170a90-da2f-3227-d7e5-fe9486156705@candelatech.com>
Date:   Mon, 21 Dec 2020 15:55:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I'm trying to figure out what changed in the last few kernels that is making:

struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
if (info->control.flags & IEEE80211_TX_CTRL_RATE_INJECT)
	/* why is code here all of a sudden */

in data frames in ath10k,
when, to the best of my knowledge, nothing should be setting that up in the stack.

My guess is that something is stepping on the cb field somewhere in ath10k,
but I am not sure where that might be at this point.

And it also appears mac80211 or maybe supplicant is setting the rate-inject flag on some mgt frames,
but I think that is a separate concern at this point.

If anyone has any ideas of likely points, please let me know.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
