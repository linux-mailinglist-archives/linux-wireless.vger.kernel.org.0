Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A30978B2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHUL7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 07:59:24 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:55891 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726749AbfHUL7Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 07:59:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9803D1802B9F8;
        Wed, 21 Aug 2019 11:59:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3871:4321:4605:5007:10004:10400:10848:11232:11657:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: bead95_6e7a6e0c32b4a
X-Filterd-Recvd-Size: 2118
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Aug 2019 11:59:19 +0000 (UTC)
Message-ID: <5613f082389460cb8de4251c08038c914683bd49.camel@perches.com>
Subject: Re: [PATCH v2] mt76: fix some checkpatch warnings
From:   Joe Perches <joe@perches.com>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Aug 2019 04:59:16 -0700
In-Reply-To: <4ff1174b111ab61e147510ffbcde706d1a00600d.1566356513.git.ryder.lee@mediatek.com>
References: <4ff1174b111ab61e147510ffbcde706d1a00600d.1566356513.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-08-21 at 11:11 +0800, Ryder Lee wrote:
> This fixes the following checkpatch warnings:
> CHECK: Alignment should match open parenthesis
> CHECK: No space is necessary after a cast
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v2: remove false positive checkpatch warnings.

What were those?

> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
[]
> @@ -587,8 +589,8 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
>  	}
>  
>  	if (ieee80211_has_morefrags(hdr->frame_control) ||
> -		!(ieee80211_is_mgmt(hdr->frame_control) ||
> -		  ieee80211_is_data(hdr->frame_control)))
> +	    !(ieee80211_is_mgmt(hdr->frame_control) ||
> +	    ieee80211_is_data(hdr->frame_control)))

Poor alignment here.

This should be:

	if (ieee80211_has_morefrags(hdr->frame_control) ||
	    !(ieee80211_is_mgmt(hdr->frame_control) ||
	      ieee80211_is_data(hdr->frame_control)))


