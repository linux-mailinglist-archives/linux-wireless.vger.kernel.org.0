Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B247A233E94
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 06:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgGaE7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 00:59:16 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:56078 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729043AbgGaE7Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 00:59:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id E37204E7D77;
        Fri, 31 Jul 2020 04:59:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bAK_w9LxqUUj; Fri, 31 Jul 2020 04:59:13 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 262DF4E7C36;
        Fri, 31 Jul 2020 04:59:12 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 30 Jul 2020 21:59:12 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mac80211-next tree
In-Reply-To: <20200731132830.75d7a905@canb.auug.org.au>
References: <20200731132830.75d7a905@canb.auug.org.au>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <451863e31438ded0dc46b84b968a1d2c@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-30 20:28, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mac80211-next tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:

Thanks Stephen. I'll send a fix against mac80211-next to linux-wireless.

-- 
thomas
