Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2622026C72D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Sep 2020 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgIPSUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Sep 2020 14:20:13 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:53596 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgIPSUJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Sep 2020 14:20:09 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9A91413C2B5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Sep 2020 11:19:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9A91413C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1600280390;
        bh=rfNG1MUsVBH0iVUvAKOU7AIP3DfhMl1qzV6Gm10Mw/E=;
        h=To:From:Subject:Date:From;
        b=snk9rMq5WhUL0nbw8QkGuNsybkWggjgjcO+5U17wfrYCa3LxIU5B3yu9cvmVZBP2m
         qGu4KoxoZiZGNDo4I5sD6Xnn9Ky5OMJkqGQpnhuzbpiOu30Ehgp4wsARRZ+J3rAi17
         YVEyti5rAcGhCx862KZEImPl/Wxq+STaRSjxqqGA=
To:     linux-wireless@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Subject: wifi: Hardware became unavailable during restart.
Organization: Candela Technologies
Message-ID: <e38c8d80-a076-4298-4de2-c0be3927de28@candelatech.com>
Date:   Wed, 16 Sep 2020 11:19:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I managed to reproduce this problem again...ath10k-ct crapped out while trying to
recover from a crash, and then mac80211 gives up.

AP needs to be rebooted at this point since it has lost at least one radio,
and no sane way in software to attempt to recover.

Johannes:  What do you think about adding a sysfs file to note the radio
is in this state?  Then a watch-dog program can notice and take appropriate
action?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
