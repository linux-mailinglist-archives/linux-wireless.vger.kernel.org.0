Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DDE425077
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhJGJzj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 05:55:39 -0400
Received: from phobos.denx.de ([85.214.62.61]:36138 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240478AbhJGJzj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 05:55:39 -0400
Received: from [10.88.0.104] (dslb-002-207-026-172.002.207.pools.vodafone-ip.de [2.207.26.172])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ch@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5166E83484;
        Thu,  7 Oct 2021 11:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633600424;
        bh=zHAEhNX/N5IuLuIN5LqhwR8Pujx2D2YcTBrMgzVZUtA=;
        h=To:Cc:From:Subject:Date:From;
        b=UaVefCfDnmGJSBeYUtw1LRj0ff4EtjIF7uWrIu8e3V/jMIYBRcNBBovxdZfZcP5rl
         FzN5RLAf7so04rSBtrmG193NvU+wxn0l4bp6DZUaZ17kSFbv2toz+WcS1KDkESmD3E
         vXkFrhPQAu+sO9FFiqEWd3zBqrX2b2HI7rnyRrObIxTtQAk8Ul0jmwTZFpSFo46XML
         LQPQA752sMQVdl3fkHTjYC67TomZScc4dqZr+XsTc02SLcjMYqP3hml3EZgDU0akzb
         d20NpMB9ogvMuVbWmBDLoF7mLu+MjFzVTN9QU0wjr6s0XyvOStP7M/iCMis+z474Vx
         G0mXqPbMJXrog==
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>
From:   Claudius Heine <ch@denx.de>
Subject: Operating Intel Wireless-AC 9260 with one antenna (iwlmvm)
Organization: Denx Software Engineering
Message-ID: <ada8f488-fdab-b421-7376-78e5fc403f4b@denx.de>
Date:   Thu, 7 Oct 2021 11:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luca Coelho,

the available documentation [1] [2] on the Intel Wireless-AC 9260 
doesn't explicitly state that operating it with just one antenna is 
impossible, just that it would be necessary for optimal performance.

Operating that module with wifi-only and just one antenna connected 
seems to work somewhat ok, but we had some deauth issues, which could be 
unrelated.

Operating both wifi+bt with just one antenna, makes wifi loose packages 
while bt is active. I hard-coded the `valid_{t,r}x_ant` to `1` in the 
nvm parser code, which seem to improve this issue somewhat, but bt 
pairing seems to be unstable.

But the general question is: Is that module even designed to operate 
with just one antenna connected and are wifi and bt issues to be 
expected in that case? Bt would not be strictly required in our use-case.

If it should work with just one antenna, do you know of any available 
tools to create those nvm image files or overwrite the nvm with the 
correct antenna configuration? Or is there another way for this to be 
configured?

Thanks a lot and kind regards,
Claudius Heine

[1] 
https://www.intel.com/content/www/us/en/support/articles/000031221/wireless.html
[2] 
https://www.intel.com/content/dam/support/us/en/documents/network-and-i-o/wireless-networking/intel-wifi-adapter-information-guide.pdf
