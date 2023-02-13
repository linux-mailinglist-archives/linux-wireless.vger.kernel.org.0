Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF8694D82
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 17:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBMQzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 11:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMQze (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 11:55:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59321E2A2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 08:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40AD4611CA
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 16:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DA1C4339B;
        Mon, 13 Feb 2023 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307295;
        bh=RZEjODMXRRMp9hYyJyZ0nqULwGigaLs8fDTLqNMcOFk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RBP6BziI7Ks0iEZENGveckGV57KNGnh5RW70WkstVo6yPkXz8VrdlUji1FMnjMG2f
         W/UMCCcCM7rKIWLYQSqtIs+Ds5519wIL7gnXHxNVGfYYQCcCT1roYPPW5xrhGRF4T6
         ucSGRffcjGRKU6M6FmGSqY6mAW7+zoUVvGuhV0eDuZAy/lKRkMnmK/8jWpSEM8PCFj
         tiu/6gtSy2/m0y5mLWBz0dlqBvJspv7wLp7KTtKYbh1ZKCj+OgZZ6h8jjk9UdDPU+h
         lmWMmnrYEXvL+XYLkr+d7gV48DiS5l+E9Xe+W8I2Hmvicp+PBvQe/1DJRlk50xphHL
         nnqCUinpgniZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for-6.2 3/3] wifi: brcmfmac: change cfg80211_set_channel()
 name and signature
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230103124117.271988-4-arend.vanspriel@broadcom.com>
References: <20230103124117.271988-4-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630729305.12830.7540827913162918228.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 16:54:54 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> The function cfg80211_set_channel() is an static function in brcmfmac
> but the name is misleading. Hence rename it with 'brcmf' prefix. Also
> changing the parameters to avoid additional conversions.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

5fac18583a00 wifi: brcmfmac: change cfg80211_set_channel() name and signature

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230103124117.271988-4-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

