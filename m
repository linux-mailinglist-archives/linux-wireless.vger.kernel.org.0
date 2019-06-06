Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634CC37A2C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 18:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfFFQy3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 12:54:29 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:56496 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfFFQy3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 12:54:29 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 139D913C283
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2019 09:54:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 139D913C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1559840069;
        bh=uHj7VBqqMStGMj89t/C8nB4TA5VgJOTVv0TM0riw6cM=;
        h=To:From:Subject:Date:From;
        b=ZjM3qth2Xb9OHwAgOkAXStKoTCLxrfFwQ5SYhk9ezv/Hu2VZG+Wkp19iO6XzGJdgF
         pEvDKlp87YEuyZKGQm6pKd0xrtG402icGeRnGaUcFUNtKL++7dAuAw0dG+UPbH3tq1
         eee8RbmwlDeRYR9WcZhC+YWukhHizLUSWSHxCh5s=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Help with encrypting PMF management frames
Organization: Candela Technologies
Message-ID: <fe571fe9-d5e5-38b8-5afa-2ba4fbb51f67@candelatech.com>
Date:   Thu, 6 Jun 2019 09:54:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

My variant of ath10k uses the normal 'native-wifi' tx path for management frames.
Internally in the firmware, it seems that the management TID is flagged to expect
raw frames, and I think that is why I see Action frames on-air that are not actually
encrypted but which have some space added to their packet that should be filled in by
the hw-crypt engine.

Is there a way to get mac80211 to software-crypt just management-tid PMF frames?

So far, I have not been able to find the correct place in the tx logic of
mac80211...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

