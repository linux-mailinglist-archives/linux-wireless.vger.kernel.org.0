Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544A94A5E61
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiBAOfp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 09:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiBAOfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 09:35:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3200BC061714
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 06:35:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7021B82E0E
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 14:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83F9C340EB;
        Tue,  1 Feb 2022 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643726141;
        bh=N5N9SR6OoG9mmDAdilZCbFmm+lbMg6h87u4WGMB2Gmg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Wx1QKXvAsKP2knBT33/6662FbxiGS2MfP2QBGqxc5D3f/iAdjTmNzOI8LoRGXTJl0
         rup56ugo3eCSyJ17KlRW/I3tVMNdeQeQaFPOTdljKaw75gDLhdRsF1LbiZ7uXM4jdi
         fiWExz3WVOJiZr4S+rKZKm+3Y16jbDbzAabKfd12P5r46QEZ72Fs1PN+hIMfwQLfRi
         +GyXRVcQlN55o4rUa1SPOuFPkvd/MUksoKZQDJNRkO4o5bqmIauGhIWVTsuq32hlIS
         LkbbafrNa8+v4XGeRrSU5HV55Afc/AsCrkiRJrAOq3gqF1JCjch51535vL0OpjPCqO
         jDBzx9teLEULQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH] cfg80211: fix race in netlink owner interface destruction
References: <20220201130951.22093-1-johannes@sipsolutions.net>
Date:   Tue, 01 Feb 2022 16:35:36 +0200
In-Reply-To: <20220201130951.22093-1-johannes@sipsolutions.net> (Johannes
        Berg's message of "Tue, 1 Feb 2022 14:09:51 +0100")
Message-ID: <871r0md58n.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> My previous fix here to fix the deadlock left a race where
> the exact same deadlock (see the original commit referenced
> below) can still happen if cfg80211_destroy_ifaces() already
> runs while nl80211_netlink_notify() is still marking some
> interfaces as nl_owner_dead.
>
> The race happens because we have two loops here - first we
> dev_close() all the netdevs, and then we destroy them. If we
> also have two netdevs (first one need only be a wdev though)
> then we can find one during the first iteration, close it,
> and go to the second iteration -- but then find two, and try
> to destroy also the one we didn't close yet.
>
> Fix this by only iterating once.
>
> Change-Id: Ie56cd0ef3f0d2108bb8a25c8bb5efced15e6a909

You forgot the Change-Id.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
