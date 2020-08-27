Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A62542AF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgH0JrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0JrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 05:47:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C18C061264
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 02:47:15 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBEV0-00BX6w-7E; Thu, 27 Aug 2020 11:47:14 +0200
Message-ID: <01ec43694f7b35c64eaf9c357a37b5b7ddc166c3.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/2] nl80211: Add FILS discovery support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 27 Aug 2020 11:47:08 +0200
In-Reply-To: <20200805011838.28166-2-alokad@codeaurora.org>
References: <20200805011838.28166-1-alokad@codeaurora.org>
         <20200805011838.28166-2-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-08-04 at 18:18 -0700, Aloka Dixit wrote:
> FILS discovery attribute, NL80211_ATTR_FILS_DISCOVERY, is nested which
> supports following parameters as given in IEEE Std 802.11ai-2016,
> Annex C.3 MIB detail:
> (1) NL80211_FILS_DISCOVERY_INT_MIN - Minimum packet interval
> (2) NL80211_FILS_DISCOVERY_INT_MAX - Maximum packet interval
> (3) NL0211_FILS_DISCOVERY_TMPL - Template data

Please keep _ATTR_ in these names. I've sent you some cleaned up version
that you can start working from. I was going to do all the cleanups, but
then realized that there are some questions I cannot answer.

> + * @support_fils_discovery: can HW support FILS discovery transmission
> + *
>   * @pmsr_capa: peer measurement capabilities
>   *
>   * @tid_config_support: describes the per-TID config support that the
> @@ -4880,6 +4901,8 @@ struct wiphy {
>  	u8 support_mbssid:1,
>  	   support_only_he_mbssid:1;
>  
> +	u8 support_fils_discovery:1;

Notably, you never use this.

Actually, you do later, in the mac80211 patch, but that makes no sense.
Somehow it should be used in cfg80211 if the information lives there.

I suspect this might actually want to be an extended feature flag to
userspace also knows, and also that cfg80211 should reject the operation
if not supported?


The rest of my minor comments are about policy use, using
NLA_POLICY_RANGE() with NLA_BINARY now, etc. which I've all cleaned up
in the versions I just sent you.

johannes

