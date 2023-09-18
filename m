Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4CE7A5036
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjIRRCi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRRCh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E67491
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 10:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1102DC32786;
        Mon, 18 Sep 2023 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047508;
        bh=JB3bqQ+BxH47O2jLd20Yozgn+VaCyFGHxhd3pn1nTZw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BJmM0vcqnDui8iEM6rSPz2hSyxSHmWu0IqFb5abQGlpOMTLtcsZkx1UYP+rJyEr6P
         X9UwJhZGRSxAIclClIRoc76M9amHkFjcQhNV4uUnLXayZhrJuI8UJVpA1UvyTjzPSA
         0wB9sh7CP6+ZfjUXd/4TV1VrJ8nvMf++XaZHa6Yj94qk7ucOKdjrzU+FeC3qcKlxgG
         KE0Ge0EaP5KZAxuRX/AACyOZ+E2WpGE2yihU0lgo+FnW6bsao+jTaY61azlBOvEAYo
         6KeOQZkGq3UGc+3m/NtC2D9jYBx/bKyij5RcDXX9bp1qn7SrMeuUqae+ouLLFwqIb7
         flCI6jO5hdqsA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] wifi: wlcore: Convert to platform remove callback
 returning void
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230912171249.755901-1-u.kleine-koenig@pengutronix.de>
References: <20230912171249.755901-1-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-wireless@vger.kernel.org, kernel@pengutronix.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504750617.740666.8864088781140392316.kvalo@kernel.org>
Date:   Mon, 18 Sep 2023 14:31:47 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uwe Kleine-König  <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code.  However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> wlcore_remove() returned zero unconditionally. With that converted to
> return void instead, the wl12xx and wl18xx driver can be converted to
> .remove_new trivially.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Patch applied to wireless-next.git, thanks.

f00928012886 wifi: wlcore: Convert to platform remove callback returning void

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230912171249.755901-1-u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

