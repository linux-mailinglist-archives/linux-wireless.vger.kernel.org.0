Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89112305C67
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 14:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313842AbhAZWrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 17:47:22 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:43618 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbhAZV5e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 16:57:34 -0500
Received: from [192.168.254.6] (unknown [50.34.179.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8C90113C2B0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jan 2021 13:56:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8C90113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1611698201;
        bh=KjkanbY1cud5fMt1MhWEiVRktcCYskziFPCG0I30nGY=;
        h=To:From:Subject:Date:From;
        b=f4WwFRuISL6COfuvcaLaC5X+ILnlzzBmcMSn1wiiY3Q7lvApTYU07sKpYWwz9anAW
         psMeqyHFHnhnFrg5tpsMS2odnXQzG4kiwAbXdxNGCZ0Q4CtWMD94gf9B+gMRmjefi/
         2hfM+EzaHPX82oheUQtnrm7vNT5SNFE/y11ZKFVE=
To:     linux-wireless@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Subject: Interest in NL80211_ATTR_DISABLE_HE option?
Organization: Candela Technologies
Message-ID: <10a771d1-407a-1f33-d9fc-32b3294cea58@candelatech.com>
Date:   Tue, 26 Jan 2021 13:56:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes,

Would you be OK with an option to disable HE, similar to how we can disable VHT?

If so, I'll code something up.   If not, then I'll go to private hack land...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
