Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB4674076
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjASSCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 13:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjASSCq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 13:02:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67168C93F
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 10:02:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F95661D15
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 18:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFCEC433EF;
        Thu, 19 Jan 2023 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674151364;
        bh=UvwYarr9WiLtSDbrCDsgiw227tBzrcMUnmb6zKCEZYM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mUdQ7aGpf/47EoLPjqwixTKurKTEYxugjSd3aoYp4pgZOLO8cvOahSPW+YqEFT8aq
         lbf32uaXZxX1cvxlZ+kAjzw1pK7Pf8WU19G18Es13oz4H2OSGBURkaMzzTgbXmnLme
         CIRkPxeLehhdPSbWy1wQmG9LS7Jce0WrCv4/A4uDYaHBGi6LzDMJOTFmYz/BS8mhwD
         8Fty+UcSEUOMDB03BKEl6XT10uh1KCPYMKkOrtn3oFLU4cl48k13UuV4uPXSOE5ckb
         4tktCPKudAlsagOWYMX5/1TXbhJnpu5MDmHWTJBLBFr5rMGWX1YUvcNtW4w+vP3y7l
         iPveuOr4mwhwQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: wireless: warn on most wireless extension usage
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230118105152.a7158a929a6f.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
References: <20230118105152.a7158a929a6f.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167415134514.8563.17230078549145755127.kvalo@kernel.org>
Date:   Thu, 19 Jan 2023 18:02:43 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> With WiFi 7 (802.11ax, MLO/EHT) around the corner, we're going to
> remove support for wireless extensions with new devices since MLO
> (multi-link operation) cannot be properly indicated using them.
> 
> Add a warning to indicate which processes are still using wireless
> extensions, if being used with modern (i.e. cfg80211) drivers.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

2 patches applied to wireless-next.git, thanks.

dc09766c755c wifi: wireless: warn on most wireless extension usage
4ca69027691a wifi: wireless: deny wireless extensions on MLO-capable devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230118105152.a7158a929a6f.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

