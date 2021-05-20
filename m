Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F638B965
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhETWSq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 18:18:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39965 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhETWSn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 18:18:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621549041; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=57/hC72HhnxmP1EKSlG0sZcTh/U0DAPClbYA6t6qUrQ=;
 b=mmiNgyTmuk04crdvxIs5DpJ0dp5uBqxtN8gMVtNpcG4ODw7WIXWufftjMvvQU030iR+eNW+8
 XjWvMXx/842aeOF8nL4aW1DR7uSE2R1FbQLI9XnEqnQFzTUOZTjm0cB6RfBrc9cnwp8GdKLs
 gT4uuKfjJnAzFSkVP2Knqg8WrsE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60a6dfc4f752fca668439835 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 May 2021 22:16:36
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 26DCDC43143; Thu, 20 May 2021 22:16:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EDA9C433F1;
        Thu, 20 May 2021 22:16:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 15:16:35 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Chao Yu <chao@kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2] b43: don't save dentries for debugfs
In-Reply-To: <YKU2vMoDO0Ch1Lyg@kroah.com>
References: <20210518163304.3702015-1-gregkh@linuxfoundation.org>
 <891f28e4c1f3c24ed1b257de83cbb3a0@codeaurora.org>
 <f539277054c06e1719832b9e99cbf7f1@codeaurora.org>
 <YKScfFKhxtVqfRkt@kroah.com>
 <2eb3af43025436c0832c8f61fbf519ad@codeaurora.org>
 <YKUyAoBq/cepglmk@kroah.com>
 <48aea7ae33faaafab388e24c3b8eb199@codeaurora.org>
 <YKU2vMoDO0Ch1Lyg@kroah.com>
Message-ID: <36d75173b785819a4792ccceb5bf26b8@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-19 09:03, Greg Kroah-Hartman wrote:
> On Wed, May 19, 2021 at 08:57:00AM -0700, Jeff Johnson wrote:
>> Unless debugfs is disabled, like on Android, which is the real problem 
>> I'm
>> trying to solve.
> 
> Then use some other filesystem to place your relay file in.  A relay
> file is not a file that userspace should rely on for normal operation,
> so why do you need it at all?
> 
> What tools/operation requires access to this file that systems without
> debugfs support is causing problems on?

(trimmed some lists)

For the ath drivers (as well as the out-of-tree Android driver) it is 
being used for RF spectral scan which produces a large amount of data 
that is processed by a userspace analysis application.

I've been looking for an alternate filesystem to use, but am not finding 
anything where it appears easy to get a parent dentry, so any clues for 
the clueless (me) would be appreciated.

Jeff

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
