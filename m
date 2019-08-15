Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70658EF3D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfHOPXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 11:23:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfHOPXJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 11:23:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6D0F60316; Thu, 15 Aug 2019 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565882588;
        bh=N1TGviypDozexgW2XAtfbZgd+tM59/RR+UyBKJ27jSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OZXtp42V/zzLgdUXGBeDJmWG5GmAPbnaU358iv/IWIyM123b78mPFHExBduf+rlni
         ygDU4WX285+R+b1D+uKpOfWlKGA1b3eIZmFod3uptztQKS54krlAMWrOOhX0oxok94
         610XN137aLh3Kpo92Loc6GaNyb87LObyn+kNhULU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5D20B60316;
        Thu, 15 Aug 2019 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565882588;
        bh=N1TGviypDozexgW2XAtfbZgd+tM59/RR+UyBKJ27jSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OZXtp42V/zzLgdUXGBeDJmWG5GmAPbnaU358iv/IWIyM123b78mPFHExBduf+rlni
         ygDU4WX285+R+b1D+uKpOfWlKGA1b3eIZmFod3uptztQKS54krlAMWrOOhX0oxok94
         610XN137aLh3Kpo92Loc6GaNyb87LObyn+kNhULU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Aug 2019 08:23:08 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] cfg80211: VLAN offload support for set_key and
 set_sta_vlan
In-Reply-To: <20190815133825.8131-1-jouni@codeaurora.org>
References: <20190815133825.8131-1-jouni@codeaurora.org>
Message-ID: <16c2c5a92fb9b51ce2305a0585cb17d1@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-15 06:38, Jouni Malinen wrote:
> From: Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>
> [...]
> By setting NL80211_EXT_FEATURE_VLAN_OFFLOAD flag the driver indicates
> support for a single netdev with VLAN tagged frames. Separate
> VLAN-specific netdevs are added using vcongig similar to Ethernet.

nit: s/vcongig/vconfig/

