Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07C810C319
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 04:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfK1DyY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 22:54:24 -0500
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:45784 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbfK1DyY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 22:54:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D0883180A8128;
        Thu, 28 Nov 2019 03:54:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4250:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12740:12760:12895:13069:13138:13231:13311:13357:13439:14659:14819:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cord05_261e104f2dd33
X-Filterd-Recvd-Size: 1920
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Nov 2019 03:54:21 +0000 (UTC)
Message-ID: <d02f4eef9aa674cb36c1d90069a13e7bd02b7e40.camel@perches.com>
Subject: Re: [PATCH RESEND] wireless: Use offsetof instead of custom macro.
From:   Joe Perches <joe@perches.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" 
        <clang-built-linux@googlegroups.com>
Date:   Wed, 27 Nov 2019 19:53:55 -0800
In-Reply-To: <20191128033959.87715-1-pihsun@chromium.org>
References: <20191128033959.87715-1-pihsun@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-11-28 at 11:39 +0800, Pi-Hsun Shih wrote:
> Use offsetof to calculate offset of a field to take advantage of
> compiler built-in version when possible, and avoid UBSAN warning when
> compiling with Clang:
[]
> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
[]
> @@ -1090,8 +1090,7 @@ struct iw_event {
>  /* iw_point events are special. First, the payload (extra data) come at
>   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
>   * we omit the pointer, so start at an offset. */
> -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> -			  (char *) NULL)
> +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
>  #define IW_EV_POINT_LEN	(IW_EV_LCP_LEN + sizeof(struct iw_point) - \
>  			 IW_EV_POINT_OFF)

This is uapi.  Is offsetof guaranteed to be available?

Perhaps this is better without using another macro

#define IW_EV_POINT_OFF	((size_t)&((struct iw_point *)NULL)->length)

