Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9C20E160
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 23:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgF2UzQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 16:55:16 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:59408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731296AbgF2TNM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:12 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id D923D180178AE
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 06:18:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A7B0A1802912C;
        Mon, 29 Jun 2020 06:18:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3871:3873:4321:5007:6119:7576:7903:7904:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21324:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: jump22_500d9c826e6d
X-Filterd-Recvd-Size: 1439
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Jun 2020 06:18:02 +0000 (UTC)
Message-ID: <300f12f5c266cb0940dfeee94dd13d42851ccdea.camel@perches.com>
Subject: Re: [PATCH 2/2] rtlwifi: 8821ae: remove unused path B parameters
 from swing table
From:   Joe Perches <joe@perches.com>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Date:   Sun, 28 Jun 2020 23:18:01 -0700
In-Reply-To: <1593410915.25527.3.camel@realtek.com>
References: <20200629032937.17374-1-pkshih@realtek.com>
         <20200629032937.17374-2-pkshih@realtek.com>
         <be95d3c3e40e3670ed368b0df4ba397a@perches.com>
         <1593410915.25527.3.camel@realtek.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-06-29 at 06:09 +0000, Pkshih wrote:
> On Sun, 2020-06-28 at 22:21 -0700, Joe Perches wrote:
> > On 2020-06-28 20:29, pkshih@realtek.com wrote:
> > > From: Ping-Ke Shih <pkshih@realtek.com>
> > >  
> > > 8821AE is a 1x1 chip, so swing parameters for path B aren't necessary.
> > 
> > Then all the now unused arrays could be removed as well.
> > 
> My gcc doesn't warn this. Could I know how you find them?

Logic then inspection.


