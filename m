Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5777B1C3045
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 01:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgECX35 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 May 2020 19:29:57 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:49402 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbgECX35 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 May 2020 19:29:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2690716921;
        Sun,  3 May 2020 23:29:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:978:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:2901:3138:3139:3140:3141:3142:3352:3622:3865:3866:3871:3872:3873:4321:4605:5007:6238:7903:8603:10004:10293:10400:10848:11232:11658:11914:12043:12296:12297:12438:12555:12698:12737:12740:12760:12895:13069:13146:13230:13311:13357:13439:13870:14181:14659:14721:14777:21080:21433:21451:21627:21789:21819:21939:21990:30022:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brick38_5682053cb3621
X-Filterd-Recvd-Size: 2157
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 May 2020 23:29:54 +0000 (UTC)
Message-ID: <d3e07dfd0efe21192d172b2e4e7d4a489a4fcc62.camel@perches.com>
Subject: Re: [PATCH v2] staging: wilc1000: Increase the size of wid_list
 array
From:   Joe Perches <joe@perches.com>
To:     Ajay.Kathat@microchip.com, oscar.carter@gmx.com,
        adham.abozaeid@microchip.com
Cc:     gregkh@linuxfoundation.org, rachel.kim@atmel.com,
        johnny.kim@atmel.com, chris.park@atmel.com, dean.lee@atmel.com,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 03 May 2020 16:29:53 -0700
In-Reply-To: <d75b7f64-0ba0-65e9-ea4c-cc87b3a51a10@microchip.com>
References: <20200503075145.4563-1-oscar.carter@gmx.com>
         <d75b7f64-0ba0-65e9-ea4c-cc87b3a51a10@microchip.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-05-03 at 14:52 +0000, Ajay.Kathat@microchip.com wrote:
> On 03/05/20 1:21 pm, Oscar Carter wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Increase by one the size of wid_list array as index variable can reach a
> > value of 5. If this happens, an out-of-bounds access is performed.
> > 
> > Addresses-Coverity-ID: 1451981 ("Out-of-bounds access")
> > Fixes: f5a3cb90b802d ("staging: wilc1000: add passive scan support")
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
[]
> > diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif.c
[]
> > @@ -151,7 +151,7 @@ int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
> >               void *user_arg, struct cfg80211_scan_request *request)
> >  {
> >         int result = 0;
> > -       struct wid wid_list[5];
> > +       struct wid wid_list[6];

This looks like it should be using a #define instead of
a hard-coded number.

> >         u32 index = 0;
> >         u32 i, scan_timeout;
> >         u8 *buffer;
> > --
> > 2.20.1

