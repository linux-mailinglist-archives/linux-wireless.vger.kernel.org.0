Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7732118
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2019 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFAWvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Jun 2019 18:51:52 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:33853 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbfFAWvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Jun 2019 18:51:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C1BEE18029120;
        Sat,  1 Jun 2019 22:51:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:7576:7875:7901:7903:10004:10400:10482:10848:11026:11232:11473:11657:11658:11914:12043:12291:12296:12438:12555:12740:12760:12895:13019:13439:14181:14659:14721:19901:19997:21080:21433:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: idea06_4a372f3a4ea18
X-Filterd-Recvd-Size: 2863
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Jun 2019 22:51:49 +0000 (UTC)
Message-ID: <39d56df83cc8de95969c6ba3003d8101caedc045.camel@perches.com>
Subject: Re: [PATCH 11/11] rtw88: debug: dump tx power indexes in use
From:   Joe Perches <joe@perches.com>
To:     yhchuang@realtek.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 01 Jun 2019 15:51:43 -0700
In-Reply-To: <1559116487-5244-12-git-send-email-yhchuang@realtek.com>
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
         <1559116487-5244-12-git-send-email-yhchuang@realtek.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-05-29 at 15:54 +0800, yhchuang@realtek.com wrote:
> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Add a read entry in debugfs to dump current tx power
> indexes in use for each path and each rate section.
> The corresponding power bases, power by rate, and
> power limit are also included.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/debug.c | 112 +++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
> index f0ae260..ee2937c2 100644
> --- a/drivers/net/wireless/realtek/rtw88/debug.c
> +++ b/drivers/net/wireless/realtek/rtw88/debug.c
> @@ -8,6 +8,7 @@
>  #include "sec.h"
>  #include "fw.h"
>  #include "debug.h"
> +#include "phy.h"
>  
>  #ifdef CONFIG_RTW88_DEBUGFS
>  
> @@ -460,6 +461,112 @@ static int rtw_debug_get_rf_dump(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +static void rtw_print_cck_rate_txt(struct seq_file *m, u8 rate)
> +{
> +	static const char * const
> +	cck_rate[] = {"1M", "2M", "5.5M", "11M"};
> +	u8 idx = rate - DESC_RATE1M;
> +
> +	seq_printf(m, "%5s%-5s", "CCK_", cck_rate[idx]);

Why use %5s instead of just embedding the prefix directly?
Also why use %5s at all when the length is 4?

I think it'd be more sensible as:

	seq_printf(m, " CCK_%-5s", cck_rate[idx]);

> +}
> +
> +static void rtw_print_ofdm_rate_txt(struct seq_file *m, u8 rate)
> +{
> +	static const char * const
> +	ofdm_rate[] = {"6M", "9M", "12M", "18M", "24M", "36M", "48M", "54M"};
> +	u8 idx = rate - DESC_RATE6M;
> +
> +	seq_printf(m, "%6s%-4s", "OFDM_", ofdm_rate[idx]);

here too

> +}
> +
> +static void rtw_print_ht_rate_txt(struct seq_file *m, u8 rate)
> +{
> +	u8 mcs_n = rate - DESC_RATEMCS0;
> +
> +	seq_printf(m, "%4s%-6u", "MCS", mcs_n);

and here, etc...



