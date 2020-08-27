Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A872544F0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgH0MZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgH0MYs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 08:24:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F96C061235
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:24:47 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBGxS-00BaJ7-0F; Thu, 27 Aug 2020 14:24:46 +0200
Message-ID: <c5b79f189345b0fccbe797a8ed158dcae30fdd10.camel@sipsolutions.net>
Subject: Re: [PATCH V5 3/5] nl80211: add support for BSS coloring
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 27 Aug 2020 14:24:45 +0200
In-Reply-To: <20200826055650.1101224-3-john@phrozen.org> (sfid-20200826_075709_238174_DD905459)
References: <20200826055650.1101224-1-john@phrozen.org>
         <20200826055650.1101224-3-john@phrozen.org>
         (sfid-20200826_075709_238174_DD905459)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +	if (info->attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
> +		params.counter_offset_presp =
> +			nla_get_u16(info->attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);

You need to check the attribute size here, apparently only exactly a
single counter is supported.

I'm not really sure *why* though - wouldn't be that much more difficult
to add support for an arbitrary number in mac80211?

Either way this is missing a check.

johannes


