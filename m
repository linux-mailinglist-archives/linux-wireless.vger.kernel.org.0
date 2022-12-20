Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E465211D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 14:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiLTNBG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 08:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiLTNAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 08:00:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FFD2CA
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 05:00:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 558EAB81240
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 13:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A638C433F1;
        Tue, 20 Dec 2022 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671541245;
        bh=aidxwJjUug90+EjdPUEfRcVzaxbaF8dFXXl0j1gYKXk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gDQxRGY8wFuJB7HHRti8ydPTEV4VYdd9HACHiSITiIH2szjSJb5iTDU5yiZAfCZyy
         XtGk2i3m0CLQdLyBtcmh3MpEkLp3s07iVkZRKkXWkvaEhK/U1z9EkC7/5oYdB/8lWy
         vq2vn/wj4RrcKW9VrtMfm3ur9oXf/efvIa/t2S4UmkfINJkWszSZhIBcuglQMqG06R
         nhcX5d8tdo/nq93nJp++VMEDjCp8qMkpCIsrcwPQdyYnokA4HgmwvvGOmooWcIX9JS
         ZNxOLY6MFvO0n8/eVgy3gMxu9Kau5SoTGvXnSoe5NnFhEDII+AXKziKC0T+FMziCYG
         x58SctdYsbGiA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: iwlwifi: fw: skip PPAG for JF
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221213225723.2a43415d8990.I9ac210740a45b41f1b2e15274e1daf4284f2808a@changeid>
References: <20221213225723.2a43415d8990.I9ac210740a45b41f1b2e15274e1daf4284f2808a@changeid>
To:     gregory.greenman@intel.com
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167154123971.23629.12497331084665884088.kvalo@kernel.org>
Date:   Tue, 20 Dec 2022 13:00:44 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

gregory.greenman@intel.com wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> For JF RFs we don't support PPAG, but many firmware
> images lie about it. Always skip support for JF to
> avoid firmware errors when sending the command.
> 
> Reported-and-tested-by: Íñigo Huguet <ihuguet@redhat.com>
> Link: https://lore.kernel.org/linux-wireless/CACT4oufQsqHGp6bah2c4+jPn2wG1oZqY=UKa_TmPx=F6Lxng8Q@mail.gmail.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>

Patch applied to wireless.git, thanks.

1c4c0b28b517 wifi: iwlwifi: fw: skip PPAG for JF

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221213225723.2a43415d8990.I9ac210740a45b41f1b2e15274e1daf4284f2808a@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

