Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85984782D9E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjHUP46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjHUP45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 11:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D758F3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 08:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7F1262195
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 15:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3238DC433C8;
        Mon, 21 Aug 2023 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633406;
        bh=PW0f4YVuPKi5U58E/+39DmPaiIQGY6KvblcKJI+HSVw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=p1uvGSt37YR2uhrSLf3JmH3lzzKwwtIRyeFSjwJSzWCQBFNXGe96Eer6VkK0kj6r/
         +nvLpS1XVQLqCP60vhwPv201zVzUM3D2/2J1L2E4BSWbr20R5nIiL9gX+z2EcrfK3D
         6kmBwmwMlC/sA37wXogGywsq+k3mKPbMdQ+jPi4y85F6ZY9XEYSbonnUkEJQFGVMRZ
         wreIh9mJsOqCeGJFs7UBjXAO7Cz2GVa7/e796z92dpHthOUiBB+PLYD+dusIAqLb8m
         k2GU6KHVWGBYjEpX6KovPyTCF3sT3zMbpNjgLjw+dN4Gb17G02QCW1ZiyR5E/pRBuj
         T2ZXFPA9T0y+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] [v3] wifi: mwifiex: fix memory leak in
 mwifiex_histogram_read()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230802160726.85545-1-dmantipov@yandex.ru>
References: <20230802160726.85545-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263340292.572263.10549766708835713921.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 15:56:44 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Always free the zeroed page on return from 'mwifiex_histogram_read()'.
> 
> Fixes: cbf6e05527a7 ("mwifiex: add rx histogram statistics support")
> 
> Acked-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

5 patches applied to wireless-next.git, thanks.

9c8fd72a5c2a wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
9b1cd8266f35 wifi: mwifiex: cleanup private data structures
968d02c61311 wifi: mwifiex: handle possible sscanf() errors
a6b3a0169ade wifi: mwifiex: handle possible mwifiex_write_reg() errors
359838758cea wifi: mwifiex: drop BUG_ON from TX paths

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230802160726.85545-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

