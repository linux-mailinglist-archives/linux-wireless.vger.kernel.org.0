Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901E22231B5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 05:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGQDck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 23:32:40 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:54164 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgGQDch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 23:32:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 47253100E7B43;
        Fri, 17 Jul 2020 03:32:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tent30_630630226f07
X-Filterd-Recvd-Size: 1513
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jul 2020 03:32:35 +0000 (UTC)
Message-ID: <dec0f4641a13ed392a37526a812062b35e8098f1.camel@perches.com>
Subject: Re: [PATCH 01/14] rtlwifi: Replace RT_TRACE with RT_DEBUG
From:   Joe Perches <joe@perches.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 16 Jul 2020 20:32:34 -0700
In-Reply-To: <20200717020201.18209-2-Larry.Finger@lwfinger.net>
References: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
         <20200717020201.18209-2-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-16 at 21:01 -0500, Larry Finger wrote:
> The macro name RT_TRACE makes it seem that it is used for tracing, when
> is actually used for debugging. Change the name to RT_DEBUG.
> 
> In the initial step, RT_TRACE must be kept to allow building. It will
> be removed at the end of the patch series.

Likely this patch could be broken out
so that the addition of RT_DEBUG is
patch 1 and the remainder of this patch
is patch 2.

And I'd suggest not using RT_DEBUG as the
macro but use rtl_dbg instead.

Lastly, the _rtl_dbg_trace function
should probably be renamed _rtl_dbg.

Other than that, I think this entire
series is sensible, thanks.


