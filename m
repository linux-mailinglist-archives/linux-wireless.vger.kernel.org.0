Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD35EBA5E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiI0GJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI0GJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:09:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC38A8CF4
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDFA3B8198C
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 06:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BD5C433C1;
        Tue, 27 Sep 2022 06:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664258961;
        bh=O7PHhiXl2enc4GeHYdqTfjccGlT2xhKYj9m3Erzp6MI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X2OB48CW5gPKCsyirUUg82YAvkqD6GHyOWelOkSMOi68EwHWYq47treFibtQzVGjz
         4TVFIYuHI5htCgKGbVggp42Arj3NjYFDJHhcOL3yC564uZz3MZ5LtBTcy6A8Qze1f8
         ZWKJ+PYEz0AMbVx/fC5LbPbBwvzErgCmbFhfP0GhmZ0FER2K6cr8AAq+GQy0Ca/uPl
         ISjzbA6zeWRBaL0JWOSq2+6r2jPBGZkD6dy/CePJwHCjFkRl+N4YJQjQTVPmE+4jOs
         HXHWbs4uTeYf4oZIFHizOnxszdhVdMRZKiejo4jepBePq/iq3rPLTG22iiy5/2LRmi
         F1lY6m7Wvkm1A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] brcmfmac: increase default max WOWL patterns to 16
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220922104140.11889-2-ian.lin@infineon.com>
References: <20220922104140.11889-2-ian.lin@infineon.com>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>,
        <ian.lin@infineon.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166425895809.10854.10988463481252010620.kvalo@kernel.org>
Date:   Tue, 27 Sep 2022 06:09:19 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin@infineon.com> wrote:

> From: Ryohei Kondo <ryohei.kondo@cypress.com>
> 
> 4373 has support of 16 WOWL patterns thus increasing the default value
> 
> Signed-off-by: Ryohei Kondo <ryohei.kondo@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>

4 patches applied to wireless-next.git, thanks.

459e552bae96 brcmfmac: increase default max WOWL patterns to 16
dce45ded7619 brcmfmac: Support 89459 pcie
11eda8f01d6a brcmfmac: increase dcmd maximum buffer size
a373f38cd1f5 brcmfmac: Remove the call to "dtim_assoc" IOVAR

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220922104140.11889-2-ian.lin@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

