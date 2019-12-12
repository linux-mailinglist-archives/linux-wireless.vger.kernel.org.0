Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398E711D8AC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 22:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfLLVhw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 16:37:52 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:49418 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbfLLVhw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 16:37:52 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6123C13C283
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 13:37:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6123C13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576186671;
        bh=1Uifk8dHieIJcCLUFhZA4MOGGlVki2T7wGWqNjgkVLI=;
        h=To:From:Subject:Date:From;
        b=TJMV3V0QT2ETxzFXJHmMxJpmP4BijMO5fIuU8SkZkDb0jj2NQVJNs1/52bQaFf650
         MFxB5tK7o1ITRUojG8Uqny5sQBODPS0YVfKROuNuPrihjbSCp4YRQzv7393hI/95o9
         lZjcf/Rs9+lorlXYYAdMnSePxgwZpjvG9/lfazsc=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200: Is there a way to find the tx power rate table?
Organization: Candela Technologies
Message-ID: <f764c746-3a37-4df0-4edb-dc1eb81b85ad@candelatech.com>
Date:   Thu, 12 Dec 2019 13:37:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm curious if we can get some debug info to show the power at which different rates
are transmitted, as well as current tx power setting?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

