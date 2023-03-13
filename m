Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784146B793D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCMNnP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCMNnO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87509166CB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 335BDB8106E
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9BC433EF;
        Mon, 13 Mar 2023 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678714990;
        bh=3wGAch4m9QD4iKpbIzC4U0INYvqVPMdl25jpt3loXts=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kUMIiKGsBFuvK6oVyKx2Yew3FcduCTpP2YAMgmxP+pVWs1pEcnCvBbieTHye+Gt5S
         el+nyKL6HWxOqH0/4aikILcMrWKN8llmoGihYgeN1LGDHZs7FEnBksuUZksVFwbUfw
         e87QLpVTKpaUrN4m0r0tc70zvxOFhvsTEaiPJ6GaEEOFlrEW0WHkVr1IpZyhB7uITM
         LDgDA3DnV3cBd/xBEEfcBF0JQc5aqWnzwZQpFVdhlKZ9MO3Yr5TK0McxVptZQi0j6d
         wCnhJu94Mcm0qc1EAnH7pzfN9ECoyczBczlscP3ZApEateTw0Ykk+jrqSieQR82TUX
         Zbom1vAZW7tSg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Use ISO3166 country code and rev 0 as
 fallback on 4356
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230303222331.285663-1-hdegoede@redhat.com>
References: <20230303222331.285663-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871498723.31347.9611885110540011157.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:43:08 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> Since linux-firmware has moved to the new cyfmac4356-pci.bin +
> cyfmac4356-pci.clm_blob firmware files this no longer works and
> 4356 devices using e.g. an X2 ccode fail to connect to an AP on
> channel 13.
> 
> Add the 4356 chip-id to the list of chips for which to use the ISO3166
> country code + rev 0 as fallback in brcmf_translate_country_code() to
> fix this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied to wireless-next.git, thanks.

659fda7f35f0 wifi: brcmfmac: Use ISO3166 country code and rev 0 as fallback on 4356

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230303222331.285663-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

