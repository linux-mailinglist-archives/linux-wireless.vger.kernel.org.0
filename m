Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6374B08D6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 09:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiBJIva (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 03:51:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiBJIv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 03:51:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0564CC2A;
        Thu, 10 Feb 2022 00:51:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 966E5618A8;
        Thu, 10 Feb 2022 08:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA027C004E1;
        Thu, 10 Feb 2022 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644483090;
        bh=EvfC7rJ1/vU9yODlAa2UFpTY70T5X3vyIK8wNpiwKjQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PRADujnLNBprel5XN+N4dNwBUPN8vt41O2XHGKu9ZwNweL7zFdZQQ25eLqcpMp0jx
         GMB+hhgdyUfOIerbamoe7t7SdjgtS76EVmT8ps2Y8NpJqFdBmOiouXzPmFcLjJO6lK
         Ez48QykqtQB155K++ZxE3KyB9IQKy0vVRbZrIlFMvRyOOpAlmJ3SjdDRBb4b9y9jc+
         HmUFQeFoWyZ22rpMhwGYVMLm2T/ccYG5/GtUPK4LQKqylwrS7PUanVTF7n33CwNBeR
         F+bHSdtBrEoiMdn1pwvkAvT6puUocbQFsQ7KB/hcGMMIGYvdsU1ztPllj6yYQ68GzF
         HZumCWs8TtnFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Uninitialized variable in
 wcn36xx_change_opchannel()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220201125941.GA22458@kili>
References: <20220201125941.GA22458@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164448308689.3808.15371784000486693976.kvalo@kernel.org>
Date:   Thu, 10 Feb 2022 08:51:28 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This code needs "channel" to be initialized to NULL for it to work
> correctly.
> 
> Fixes: d6f2746691cb ("wcn36xx: Track the band and channel we are tuned to")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonghue@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

11e41e292937 wcn36xx: Uninitialized variable in wcn36xx_change_opchannel()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220201125941.GA22458@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

