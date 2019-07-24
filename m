Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86772CCB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfGXLDv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:03:51 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:52747 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726070AbfGXLDv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:03:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A888718037D48;
        Wed, 24 Jul 2019 11:03:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2559:2562:2828:2898:3138:3139:3140:3141:3142:3352:3622:3865:4225:4321:5007:6119:8603:10004:10400:10848:11026:11232:11657:11658:11914:12043:12297:12438:12681:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30046:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: tax54_21268d0501225
X-Filterd-Recvd-Size: 2072
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 11:03:47 +0000 (UTC)
Message-ID: <54692f19e845a74650c1d24cbe7b79c5dad7b061.camel@perches.com>
Subject: Re: [PATCH v1 5/6] mt76: fix some checkpatch warnings
From:   Joe Perches <joe@perches.com>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Jul 2019 04:03:46 -0700
In-Reply-To: <0afa87cc70b34ee17d6c2247dfc8dac92c36852f.1563944758.git.ryder.lee@mediatek.com>
References: <cover.1563944758.git.ryder.lee@mediatek.com>
         <0afa87cc70b34ee17d6c2247dfc8dac92c36852f.1563944758.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-24 at 16:58 +0800, Ryder Lee wrote:
> This fixes the following checkpatch warnings:
[]
> diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
[]
> @@ -74,15 +75,14 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
>  	for (idx = (tid->head + 1) % tid->size;
>  	     idx != start && nframes;
>  	     idx = (idx + 1) % tid->size) {
> -
>  		skb = tid->reorder_buf[idx];
>  		if (!skb)
>  			continue;
>  
>  		nframes--;
> -		status = (struct mt76_rx_status *) skb->cb;
> +		status = (struct mt76_rx_status *)skb->cb;
>  		if (!time_after(jiffies, status->reorder_time +
> -					 REORDER_TIMEOUT))
> +				REORDER_TIMEOUT))

trivia/bikeshedding:  perhaps better slightly differently:

 		if (!time_after(jiffies,
				status->reorder_time + REORDER_TIMEOUT))


