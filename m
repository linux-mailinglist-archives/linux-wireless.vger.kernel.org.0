Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7471CC13
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfENPoH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 11:44:07 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:42410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726296AbfENPoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 11:44:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 69906182CF668;
        Tue, 14 May 2019 15:44:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:5007:7903:10004:10400:10848:11026:11232:11473:11658:11914:12663:12740:12760:12895:13019:13069:13095:13311:13357:13439:14659:14777:21080:21212:21433:21627:21819:30022:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: note02_5d98fc2c7d635
X-Filterd-Recvd-Size: 2261
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 May 2019 15:44:03 +0000 (UTC)
Message-ID: <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
Subject: Re: [PATCH v2] mac80211: remove warning message
From:   Joe Perches <joe@perches.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Date:   Tue, 14 May 2019 08:44:01 -0700
In-Reply-To: <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
         (sfid-20190514_110314_752671_7E53E9A2) <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
         <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
         <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-05-14 at 11:12 +0200, Johannes Berg wrote:
> On Tue, 2019-05-14 at 17:10 +0800, Yibo Zhao wrote:
> > On 2019-05-14 17:05, Johannes Berg wrote:
> > > On Tue, 2019-05-14 at 17:01 +0800, Yibo Zhao wrote:
> > > > In multiple SSID cases, it takes time to prepare every AP interface
> > > > to be ready in initializing phase. If a sta already knows everything 
> > > > it
> > > > needs to join one of the APs and sends authentication to the AP which
> > > > is not fully prepared at this point of time, AP's channel context
> > > > could be NULL. As a result, warning message occurs.
[]
> > I was planning to use WARN_ON_ONCE() in the first place to replace 
> > WARN_ON() then after some discussion, we think removing it could be 
> > better. So the first patch was based on my first version which is sent 
> > incorrectly. Please check again.
[]
> I guess changing it to WARN_ON_ONCE() makes sense,

WARN_ON_RATELIMIT exists.

> but as per my earlier
> email I'm really not sure about removing it entirely, it doesn't seem
> like a valid scenario and we should take steps elsewhere to prevent it.



