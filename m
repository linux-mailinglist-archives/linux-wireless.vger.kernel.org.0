Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFD4D4DB0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiCJP4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 10:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiCJP4S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 10:56:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF711162BE
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 07:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66C4A61873
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 15:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4228FC340E8;
        Thu, 10 Mar 2022 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646927716;
        bh=ku3Elz9rxVphhEOa/yYkSn34K11nk3Y/ocW0n+/OATs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=a2eWGlOEDRc7obsZTBSxtyf8SR5wTE54En6pwTwxrHmO8LusqJV5iXdtHIkoqR42Y
         iteiJvXCg9ctqLlK/4++ksad2kzHQecTQbaALodF12q0GGJsMWhvFi+34uWWk04AX3
         3uiPX+0E0Po2txT/CH4IIMC2hKFpj7qu43STpOZU4QO6d2IclnUd2kQPNubjz/tFVz
         tdOiSYFvAXQKepspWo+AjCo6n+2OEOgxnqyHYMEBIgn/98otbF1/IQR0J7nCS3XgX6
         YH/l/udmKla22W2AOpzr7iP+TgYIRJlQSLPxizue90IzpMl61mHvFdqseGfvUXeoge
         CQ6+Da+a/LVUA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 1/5] carl9170: replace GFP_ATOMIC in ampdu_action,
 it can sleep
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com>
References: <0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164692771389.18489.2897355378625450610.kvalo@kernel.org>
Date:   Thu, 10 Mar 2022 15:55:16 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> Since ~2010, the driver is allowed to sleep in the ampdu_action
> callback thanks to:
> commit 85ad181ea788 ("mac80211: allow drivers to sleep in ampdu_action")
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

5 patches applied to ath-next branch of ath.git, thanks.

e42fe43a216c carl9170: replace GFP_ATOMIC in ampdu_action, it can sleep
23de0fa0d2a0 carl9170: devres-ing hwrng_register usage
87ddb2fc29f1 carl9170: devres-ing input_allocate_device
a8da65f901fa carl9170: replace bitmap_zalloc with devm_bitmap_zalloc
83fe43abdacf carl9170: devres ar->survey_info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/0036538d0933626a1a5eb2c2c3935cf173028926.1646250537.git.chunkeey@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

