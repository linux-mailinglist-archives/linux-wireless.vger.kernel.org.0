Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3E31F853
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhBSLXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 06:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBSLVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 06:21:55 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE2CC061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Feb 2021 03:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2+u9Obm0yOJLAcvuAYqdqeYabd/zzr0OVC9ki0Bt2Zs=; b=jpp4F/tcZJ1PXW5UKYrSGGxLam
        qdlHKcpsO0REp459ajH1q7GFA6vV/VC+bi+X7PVobmPVJe3n+oVXnE3aD5ks29bxRpgZHTLCfBc1W
        zFyAMPrKSJRnNJBmPIK1kRy9+XW6Fpz9fpWAb+fx4EU7cDfH/gK9TQaYJSVjOpJK73Og=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lD3qP-0000og-Cy; Fri, 19 Feb 2021 12:21:09 +0100
Subject: Re: [PATCH] mac80211: minstrel_ht: remove unused variable 'mg'
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210219105744.f2538a80f6cf.I3d53554c158d5b896ac07ea546bceac67372ec28@changeid>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <35c9a1b4-ec23-f3fc-1f74-7444f0a020a1@nbd.name>
Date:   Fri, 19 Feb 2021 12:21:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210219105744.f2538a80f6cf.I3d53554c158d5b896ac07ea546bceac67372ec28@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-02-19 10:57, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This probably came in through some refactoring and what is
> now a call to minstrel_ht_group_min_rate_offset(), remove
> the unused variable.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Felix Fietkau <nbd@nbd.name>

- Felix
