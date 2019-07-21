Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25E6F43B
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2019 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfGUQ4Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jul 2019 12:56:24 -0400
Received: from smtprelay0051.hostedemail.com ([216.40.44.51]:50311 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbfGUQ4Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jul 2019 12:56:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 11E49100E86C1;
        Sun, 21 Jul 2019 16:56:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3743:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8985:9025:10004:10400:10848:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13071:13311:13357:13439:14180:14181:14659:14721:21080:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: mist98_1a5900528f025
X-Filterd-Recvd-Size: 1887
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jul 2019 16:56:20 +0000 (UTC)
Message-ID: <3a2d6eb86fc211002607aad12b35648736e46342.camel@perches.com>
Subject: Re: [PATCH 1/3] mt76: fix checkpatch warnings and errors
From:   Joe Perches <joe@perches.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Jul 2019 09:56:18 -0700
In-Reply-To: <87blxnsmxm.fsf@purkki.adurom.net>
References: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
         <87blxnsmxm.fsf@purkki.adurom.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-07-21 at 13:26 +0300, Kalle Valo wrote:
> Ryder Lee <ryder.lee@mediatek.com> writes:
> > Fix warnings and errors as much as possible.
[]
> This is way too big and the commit log is too vague, please fix one
> problem at a time and describe in the commit log what you fixed.

Hello Ryder.

One option is to perform all the whitespace corrections
in a single patch and then show that the object files
have not changed.

I posted a trivial script several years ago that might
be of some help here.

https://lore.kernel.org/lkml/1405128087.6751.12.camel@joe-AO725/

It trivially reformats using checkpatch and produces a
possible set of changes that can be used to update a
git tree.


