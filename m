Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B244FEFCA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 08:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiDMG3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Apr 2022 02:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiDMG3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Apr 2022 02:29:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2795615A32
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 23:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1B81B82110
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 06:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45C7C385A4;
        Wed, 13 Apr 2022 06:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649831228;
        bh=jmdAGht6MD8R9fiCJeCI/gHfhcS57OJnpmLlyAUto4M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FVP/+hOJbMNKeMCl8cllHzSfVIWiE8fgqRBBB+H9pIcwUt1MpekhWwKaK5sz2O7zI
         kii/OEFZuMZClwF97M82kyLEUOAmSEJYdW0ejmsRGm5cweRbq+gfeRc9bQvk1hn6YI
         PO3MU+yCLvna1XK/076x/M2lQ8SjW9tCiRcm/Gwhxlnx9ynHFAmAqt/5UGzDG0djks
         PO+Eg/+aTAftxjwAWul44DziwEohafx1OzwsyK5XXIWei+dGBimtumfymYfooyyvYo
         g+gIE4m0bDOiVhU0yWoF359CnTF0Hov7tlbahvOi5lh4Bv1xH/6HZKX7McQNwK/I2A
         z/ekhnmesFx5w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4] rtw89: extend H2C of CMAC control info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220413010804.8941-2-pkshih@realtek.com>
References: <20220413010804.8941-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164983122568.9687.3834731389166012523.kvalo@kernel.org>
Date:   Wed, 13 Apr 2022 06:27:07 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In order to support new chip that has capability of 160M, we need new
> format to fill new information, so add a new V1 ID for newer use. Since
> most fields are the same, fill fields according to the function ID of chip.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

aa7f148bedca rtw89: extend H2C of CMAC control info
04b5983ef700 rtw89: add new H2C to configure security CAM via DCTL for V1 chip
0a6f299b6782 rtw89: configure security CAM for V1 chip
dc4246eff026 rtw89: pci: correct return value handling of rtw89_write16_mdio_mask()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220413010804.8941-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

