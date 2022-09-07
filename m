Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA785AFE3B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIGH6Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIGH6O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 03:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3043CA7ABB
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 00:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1398615F9
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 07:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0AFC433D6;
        Wed,  7 Sep 2022 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662537492;
        bh=DgqUxOgZXdbmjf5D/FtjV8E6+9j2CtKLMbamsHP87a4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dThtsl1LBeOlOIZntmRJYGn9/yq/uoLKIU7uoqdeQrd9q3MecD/cHC5hU2MnmlKMu
         9xoM678apw1rkvoauMKJcVXt2tv+AWxe/z4QdBYA3NxGX7Dbe2Whf7X96jUxWpxTpR
         t4Ph/Yi73lsb4A9UoT5gnLvUK7AJiJKi2ysg5QP9W8UDsucrSKfKWkTu9r0AjgByb4
         JLMNC4UVS89ClIHF/nne1QLvpuA2DKn/cB9b8+EQWdY8EzvvrkCvS9FaYuGQfLUauQ
         uOlFGfg/d5ZyKTk61Qy9dsS85a3q1lOEH0gji04rZ1QARP+CkpYp5YWH5n6BgcU4wR
         oedAqkUZEpmRQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: Use ISO3166 country code and rev 0 as fallback on
 43430
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220810142328.141030-1-hdegoede@redhat.com>
References: <20220810142328.141030-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166253748829.23292.3531008317556781080.kvalo@kernel.org>
Date:   Wed,  7 Sep 2022 07:58:10 +0000 (UTC)
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

> Many devices ship with a nvram ccode value of X2/XT/XU/XV/ALL which are
> all special world-wide compatibility ccode-s. Most of these world-wide
> ccode-s allow passive scan mode only for 2.4GHz channels 12-14,
> only enabling them when an AP is seen on them.
> 
> Since linux-firmware has moved to the new cyfmac43430-sdio.bin +
> cyfmac43430-sdio.clm_blob firmware files this no longer works and
> 43430 devices using e.g. an X2 ccode fail to connect to an AP on
> channel 13.
> 
> Add the 43430 chip-id to the list of chips for which to use the ISO3166
> country code + rev 0 as fallback in brcmf_translate_country_code() to
> fix this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied to wireless-next.git, thanks.

d173d0207bda wifi: brcmfmac: Use ISO3166 country code and rev 0 as fallback on 43430

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220810142328.141030-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

