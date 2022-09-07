Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB65AFE3D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIGH7I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 03:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIGH7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 03:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34AA8943
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 00:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30F2616EF
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 07:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB40C433D6;
        Wed,  7 Sep 2022 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662537545;
        bh=/ZdOg4ZPP+FE/vsDhizIZ9hMa17gEonQC5yx+7KOVsE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tBe3kf6GqbXGLE5733x6DZkYD/MN33b+QA829yvg3XBcWBc/mjoepRxSloo0KX+XT
         dAN8XnJNseXXCzmLUvYn+FjLW3wdgxSClC7E957in07lK6ch4vKpGmZmc5gY6rLUbj
         mxg4eigyTJqC0vYv2U81s2YFnjNUtmPv2Q5g9pH2Fh1BrACCfK7KcnAZZoQXefErBe
         MKmjLAvkv1UpASNMx67LpURb/UlzNSVv2xsnS+5sZh3NqALpB0ej1vnRdEtkI/LXUO
         ieZpFrZnEmGi5FDL4xFQay8UmQLvYPdMISriC+nW9m0Bb6kb2f+mP+9RkQqOs2UI21
         9R9gy/mPFRUAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: Add DMI nvram filename quirk for Chuwi Hi8 Pro
 tablet
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220810142333.141044-1-hdegoede@redhat.com>
References: <20220810142333.141044-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166253754139.23292.2253159123139509753.kvalo@kernel.org>
Date:   Wed,  7 Sep 2022 07:59:03 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> The Chuwi Hi8 Pro tablet contains quite generic names in the sys_vendor
> and product_name DMI strings, without this patch brcmfmac will try to load:
> "brcmfmac43430a0-sdio.Default string-Default string.txt" as nvram file
> which is way too generic.
> 
> The Chuwi Hi8 Pro uses the same Ampak AP6212 module as the Chuwi Vi8 Plus
> and the nvram for the Vi8 Plus is already in linux-firmware, so point
> the new DMI nvram filename quirk to the Vi8 Plus nvram file.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied to wireless-next.git, thanks.

7d6e30dfcc72 wifi: brcmfmac: Add DMI nvram filename quirk for Chuwi Hi8 Pro tablet

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220810142333.141044-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

