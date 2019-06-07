Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09BF38299
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 04:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfFGCL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 22:11:58 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:34873 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbfFGCL6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 22:11:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 21E89181D3419;
        Fri,  7 Jun 2019 02:11:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3868:4321:5007:6119:10004:10400:10848:11026:11232:11473:11658:11914:12043:12438:12555:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: crate03_4b162def26913
X-Filterd-Recvd-Size: 1418
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  7 Jun 2019 02:11:55 +0000 (UTC)
Message-ID: <c3f982260cdf0749201f5535bf0f3bf9f6bfa7ba.camel@perches.com>
Subject: Re: [PATCH V2] iw: print HE capabilities
From:   Joe Perches <joe@perches.com>
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Date:   Thu, 06 Jun 2019 19:11:53 -0700
In-Reply-To: <20190528065828.25356-1-john@phrozen.org>
References: <20190528065828.25356-1-john@phrozen.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-05-28 at 08:58 +0200, John Crispin wrote:
> Print the HE MAC/PHY capabilities and MCS/NSS sets.

trivia:

> diff --git a/util.c b/util.c
[]
> +void print_he_info(struct nlattr *nl_iftype)
> +{
> +	struct nlattr *tb[NL80211_BAND_IFTYPE_ATTR_MAX + 1];
> +	struct nlattr *tb_flags[NL80211_IFTYPE_MAX + 1];
> +	char *iftypes[NUM_NL80211_IFTYPES] = {
> +		"Unspec", "Adhoc", "Station", "AP", "AP/VLAN", "WDS", "Monitor",
> +		"Mesh", "P2P/Client", "P2P/Go", "P2P/Device", "OCB", "NAN",
> +	};

Should probably be
	const char * const iftypes[...]


