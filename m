Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602544C2875
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 10:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiBXJrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 04:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiBXJrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 04:47:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A3352E4C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 01:46:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 653A3B824F1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 09:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843DEC340E9;
        Thu, 24 Feb 2022 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645696000;
        bh=BaqiZe94zYheKxMPzONgGBsZzBTLQLc+ygEW0JsYwcM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=O5Fik0ICIAc+RVr1csemdj5i/Rez7mNkiocOeKF9oCkjmKI1qr86x2STBaxPCgruF
         RcX/26pIYX3CRFwe1M2PqQahRBi1jQZmp9iLe6cRlfagvsUu78I6RuilCQhe0foH39
         RW4Hgo0ym94/vvOmcAgQmNNtMbdDyxWRsx3ycL2+MR6T4J+CYhJykchASj4Um2sc/T
         Vfr9SdxzWaRO1kaQGYc8TFYAptl4f+oG9TZofbzEdtqpEykjBtldBwBBe+fV6Pi0oW
         PFq8nsa5Iknew8G+5Q/yj1FwfJ/XgID4l5eUKlp68sLq3teKFIJFgAbuIuyVv2agHB
         suo0qD+AFPeuw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2022-02-23
References: <e7f282ef-7dce-7d65-ae15-d26fb8fb6773@nbd.name>
Date:   Thu, 24 Feb 2022 11:46:33 +0200
In-Reply-To: <e7f282ef-7dce-7d65-ae15-d26fb8fb6773@nbd.name> (Felix Fietkau's
        message of "Wed, 23 Feb 2022 14:53:59 +0100")
Message-ID: <87k0dkvbpi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> here's my second pull request for 5.18
>
> - Felix
>
> The following changes since commit a0061be4e54b52e5e4ff179c3f817107ddbb2830:
>
>   rtw88: change rtw_info() to proper message level (2022-02-22 17:31:13 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-02-23
>
> for you to fetch changes up to f8629a7a5772747b6aaf4e672f7b9729209e34a5:
>
>   mt76: mt7915: simplify conditional (2022-02-23 14:53:00 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.18
>
> - bugfixes
> - mt7915 thermal management improvements
> - SAR support for more mt76 drivers
> - mt7986 wmac support on mt7915
>
> ----------------------------------------------------------------

Please switch to use my new email address: kvalo@kernel.org

This has new warnings with GCC 11.1:

drivers/net/wireless/mediatek/mt76/mt7915/soc.c: In function 'mt7986_wmac_gpio_setup':
drivers/net/wireless/mediatek/mt76/mt7915/soc.c:197:19: error: implicit declaration of function 'devm_pinctrl_get'; did you mean 'of_pinctrl_get'? [-Werror=implicit-function-declaration]
  197 |         pinctrl = devm_pinctrl_get(dev->mt76.dev);
      |                   ^~~~~~~~~~~~~~~~
      |                   of_pinctrl_get
drivers/net/wireless/mediatek/mt76/mt7915/soc.c:197:17: error: assignment to 'struct pinctrl *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  197 |         pinctrl = devm_pinctrl_get(dev->mt76.dev);
      |                 ^
drivers/net/wireless/mediatek/mt76/mt7915/soc.c:201:25: error: implicit declaration of function 'pinctrl_lookup_state' [-Werror=implicit-function-declaration]
  201 |                 state = pinctrl_lookup_state(pinctrl, "default");
      |                         ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/mediatek/mt76/mt7915/soc.c:201:23: error: assignment to 'struct pinctrl_state *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  201 |                 state = pinctrl_lookup_state(pinctrl, "default");
      |                       ^
drivers/net/wireless/mediatek/mt76/mt7915/soc.c:206:23: error: assignment to 'struct pinctrl_state *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  206 |                 state = pinctrl_lookup_state(pinctrl, "dbdc");
      |                       ^
drivers/net/wireless/mediatek/mt76/mt7915/soc.c:212:15: error: implicit declaration of function 'pinctrl_select_state' [-Werror=implicit-function-declaration]
  212 |         ret = pinctrl_select_state(pinctrl, state);
      |               ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
