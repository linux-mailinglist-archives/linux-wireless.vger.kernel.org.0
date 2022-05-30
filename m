Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108E5379AA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiE3LSU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 07:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiE3LSS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 07:18:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0C23F
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 04:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ED22B80B95
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 11:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE82C34119;
        Mon, 30 May 2022 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653909494;
        bh=fABlWihkpJZK66VjZ/Ibh3uPSNRqK/tlKK2XE/fwQ4Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eWuTYddw+ct7PCUiciV+SIuoYEByNgIpQy8t+KHt1+JpxE1roMfL5GYkRGWI3kZFI
         WRqNoDXz7VIr5JXLOWZw3f6n5HaGYCJ5r7fPwF3ews5LYZKX4hew75l94/AGIeJKKB
         2VUju8iZi+gSzUMRG9vO/Wc5eKIG2RvwlQIKNoWZxQbZ/ppoBjBdLduYIiYUq6X5OQ
         GO3AG98scjH2DCk1cga09XakOcO+2+IBK4zS/xshl/1JDZMxeiBRCvbJSJWPfKkcLc
         QCvlBrQ3WMI4bgUbYjSreu7K6cYbrAai9iPYcuW2abSSSPmD/VLX1ZPfXDDG7Gbc/H
         QjhgCUOXt5KWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3,1/4] wifi: wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220524120606.9675-1-ajay.kathat@microchip.com>
References: <20220524120606.9675-1-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390949198.29197.492480890040838038.kvalo@kernel.org>
Date:   Mon, 30 May 2022 11:18:13 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> For power-up sequence, WILC expects RESET set to high 5ms after making
> chip_en(enable) so corrected chip power-up sequence by making RESET high.
> For Power-Down sequence, the correct sequence make RESET and CHIP_EN low
> without any extra delay.
> 
> Fixes: ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver")
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

4 patches applied to wireless-next.git, thanks.

fcf690b0b474 wifi: wilc1000: use correct sequence of RESET for chip Power-UP/Down
3c76ec880588 wifi: wilc1000: remove WEP security support
c5b331d4f550 wifi: wilc1000: add WPA3 SAE support
0e703de3ef41 wifi: wilc1000: add IGTK support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220524120606.9675-1-ajay.kathat@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

