Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB138551537
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jun 2022 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiFTKFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jun 2022 06:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbiFTKFO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jun 2022 06:05:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE15610C8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 03:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DE0CB80FA8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 10:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2F4C3411B;
        Mon, 20 Jun 2022 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655719496;
        bh=+tMfZ0Il1dvxau8xrzbu0lTjL+tgihqvb3oYf2E/OeM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tvJUUwbb+CLM4vIvxLlqbcWt2fTw2UNkIkd938Z9vXQqeGiz/56RYbgS+T4uo/pkH
         5HEXrJH6SQAnkuhrn5G0sEAQcEOCM9LjOEjKvVvtCqZaWQmJMre5XDqcWDtAF4WFg/
         J7Iku3WkJj85PPKqJIBusuBuEZO5R8IJsQr+BWAPNeac8MYomTfp1axwGd2qxVXd7p
         mPDJKykDigJyGTy7DynrXWFa+Frp7NS1teXidYpdrjKsbKHGLd35FVhycAUCrtbWya
         uvCa256lywF8/pQFBs/KmirJ0zskjfYJrdLZ+jfhG+KtMqCwgTSPQy3vkib9LPLoeq
         ZIS8rcB1eWfpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath6kl: avoid flush_scheduled_work() usage
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <f78ddbdc-8989-a1a7-2234-ce9ec3894625@I-love.SAKURA.ne.jp>
References: <f78ddbdc-8989-a1a7-2234-ce9ec3894625@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165571949355.24910.10080336909041474703.kvalo@kernel.org>
Date:   Mon, 20 Jun 2022 10:04:55 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> As per commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using
> a macro") says, use per "struct ath6kl_usb" workqueue.
> 
> This is a blind conversion, and is only compile tested.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

62ebaf2f9261 ath6kl: avoid flush_scheduled_work() usage

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f78ddbdc-8989-a1a7-2234-ce9ec3894625@I-love.SAKURA.ne.jp/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

