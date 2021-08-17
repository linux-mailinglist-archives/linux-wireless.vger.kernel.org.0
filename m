Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA43EEDB6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhHQNtp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbhHQNtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 09:49:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F5C061764
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/W9/D3SiuIV6V9Op6YkOARi9D9mQ5/8a2ZXv22fwWa8=;
        t=1629208134; x=1630417734; b=Jy2XntR1A0mxiccbqHiwgE5FmFEId7Ck7HPVAP6Z4IMI+0l
        Sh9+OiuJSsBlv1MVCsLw+aEjs6uVbhoLaN/4P4ztrQEjylRcaDmIFdKC9bVHgUxU9sXJapG9G1TtS
        r1lRK3PebA3NOIOHkVCxC0H1h0HbdhW9aqf5KOZdfMTERZxuk+Gn8c/9Dlqy5wSyCJcGe/cK8iED1
        VNp6esabfRyHzMmFcjD5gWTM9IvBk8Bc2dF8gH55XwJwph8cqALWjEBSi5EH1p9D22PfMqV+qpMBd
        85GorNR41/UUOqLpyAyPCpW+JeOzBjaBMF07TBi4roTduJ6iQwMGX8SBATjatUfw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mFzSV-00CHYe-OQ; Tue, 17 Aug 2021 15:48:51 +0200
Message-ID: <6d85542f47955cdac0137c72b0de04e5c0fe0799.camel@sipsolutions.net>
Subject: Re: [PATCH v2] nl80211: Add HE UL MU fixed rate setting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 17 Aug 2021 15:48:50 +0200
In-Reply-To: <1627587701-13134-1-git-send-email-msinada@codeaurora.org>
References: <1627587701-13134-1-git-send-email-msinada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, 2021-07-29 at 12:41 -0700, Muna Sinada wrote:
> This patch adds nl80211 definitions, policies and parsing code required
> to pass HE UL MU fixed rate settings.
> 

I don't understand how this is sufficient?

>  		enum nl80211_txrate_gi gi;
>  		enum nl80211_he_gi he_gi;
>  		enum nl80211_he_ltf he_ltf;

Previously, for HE rates, we had configurations for:
 * HE MCS
 * HE guard interval
 * HE LTF

I guess I can sort of follow that uplink traffic is a bit different and
not already configured by the setting for rate control we have today,
but why does it not need all these parameters?

Also, why is this not a per-station parameter? OK, maybe we don't really
want it to be a per-station parameter, or maybe the firmware/algorithm
that's selecting things there can't deal with that, but it feels odd to
combine it with the "rate control fixed rate" parameters you have here,
and do that without even any explanation of how this is supposed to
work.

This is going to need some work.

johannes

