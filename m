Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229E7472AAA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 11:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhLMKts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 05:49:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51926 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbhLMKtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 05:49:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2BE0B810CE
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 10:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F6AC34600;
        Mon, 13 Dec 2021 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639392584;
        bh=48ui/Fx+pr+KqXI1vS2BHpuNmZZ9YHeEmWVcFl3LO0Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jRtIwqBTY02XL+bVnKzV2N4tVaq2NEtj6/VuxNtV65eejY/c8RVJwlliJheAUnx/t
         UyOu2WhGL3YHbz7rYpISVSCwXCqLlFyiNvQlWgnrOHmdJNVVZtAFG2CYGyuICSe1QQ
         EnfypCUzofnBwtmvoI7KkcOvlTy5iyuQO5LsY6mIi4bFcA/M/791NGPgaiREd6ydXX
         sYIfn7+TKlOujRPLAEz9NQ47yP5EP3sfbtezeqkJiC6hDhu1tUMwW8MJpgLqfUrlXo
         IdVT6XbuvgMaO583U2V0Fmx1JnRfIpN9muK0YLQFJ3VcXrho5G7A2tPf4NDHg2shMQ
         SXUSJZ1yCD24g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/10] iwlwifi: mvm: fix 32-bit build in FTM
References: <20211210091245.289008-1-luca@coelho.fi>
        <iwlwifi.20211210110539.4b397e664d44.Ib98004ccd2c7a55fd883a8ea7eebd810f406dec6@changeid>
Date:   Mon, 13 Dec 2021 12:49:40 +0200
In-Reply-To: <iwlwifi.20211210110539.4b397e664d44.Ib98004ccd2c7a55fd883a8ea7eebd810f406dec6@changeid>
        (Luca Coelho's message of "Fri, 10 Dec 2021 11:12:40 +0200")
Message-ID: <87czm0kce3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> On a 32-bit build, the division here needs to be done
> using do_div(), otherwise the compiler will try to call
> a function that doesn't exist, thus failing to build.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Fixes tag? And should this go to wireless-drivers?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
