Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BCB1C225C
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 04:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEBCmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 22:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgEBCmv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 22:42:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F6C061A0C;
        Fri,  1 May 2020 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=syLJ6ShJVBap9F3cLcnuX8tEVEJu08QjLeEfNy3ZQo0=; b=DQXBgoP9T5cDTv3kytUC3iiCiH
        9s0rBK4RRgU8VfHIxc8ptcCklB8Ub9LuzVxTlP3x/NFuITAl3Ow6NC7zu4m9BDG299rWrZvyCGiRW
        bRNMLtIb3ljR/bjlDOIAIHxWbLq3JcwPeKd/sipj/a16dheOzxCMnvhyf21z1Tb2MXVPb0hXnWuKq
        /BwCOhneUhbjVZgvQGvyEFGgTvAisuAyjjjmNo82ToBb3AYrtXRdhuuTH1NE1NcFE3KLMl3kx++Ll
        D8IxIfXkkWi2h4XWBw7tcEQZAh4BGpt/TrxFy6kATgY5tFtHn38nhZOcPXKY7M3ffiENq03JMLZtI
        W9d8vvIQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUi74-00049G-KN; Sat, 02 May 2020 02:42:46 +0000
Subject: Re: New Wiki URLs?
To:     webmaster@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20200428044440.kd2rf3cxa5rffewm@falbala.internal.home.lespocky.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c12c7fbe-d0e0-9a75-8e31-3a06e156f29d@infradead.org>
Date:   Fri, 1 May 2020 19:42:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428044440.kd2rf3cxa5rffewm@falbala.internal.home.lespocky.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[adding people + linux-wireless@ ]

Should we assume that the current wireless wiki URLs are more or less
permanent and so update lots of outdated references to them?

I see that the MAINTAINERS file is already updated.

Plus there is a request for redirects @kernel.org.


On 4/27/20 9:44 PM, Alexander Dahl wrote:
> Hello,
> 
> I noticed the kernel wiki URLs might have changed. The URLs now are
> like this:
> 
> https://wireless.wiki.kernel.org/en/users/drivers/b43
> 
> However in the kernel source code and in the kernel log output you
> find something like this:
> 
>     b43-phy1 ERROR: You must go to http://wireless.kernel.org/en/users/Drivers/b43#devicefirmware and do
>     wnload the correct firmware for this driver version. Please carefully read all instructions on this 
>     website.
> 
> (Notice the additional subdomain and the case change in the resource
> path.)
> 
> Some websites seem to link on those old URLs, see
> https://packages.debian.org/source/buster/b43-fwcutter for example.
> 
> Could the webmasters of kernel.org please configure some kind of
> redirects so people don't get 404 errors when looking for docs?
> 
> Bonus question: would it make sense to change all those URLs in the
> source (as in: send patches for that)? Then what URLs are supposed to
> be the right ones now?
> 
> Kind regards
> Alex


-- 
~Randy

