Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62373816C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjFUJqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjFUJqR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9ECA
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A54614DA
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21A7C433C0;
        Wed, 21 Jun 2023 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687340775;
        bh=Dvj1P7PKFBOGBBu1CEXdy+sACGReMr9PT3ox/T5HwTg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=T7bMT63bXVgsa/yS9TdcHB0xiJAVPcrmldETtuvq1x4/w9Ev3yJLoz1GU+TXOrwiA
         /u4DOuGnVlmyDxDCVrSGRyzkrwU5Ir0JT8LWqR0uIaClVYrsDgpMZi1tfPYvjwqd2F
         hzbNNqCCuERuOvjHg4nVDCy5gXOJONI6E8hVIIqnIE0Dh7Wmf2rCLT93jz4vBs/6cA
         pHfYZn7OYHCt0fQA+tMoQMLaOmulAkwMi3GGX6zHQo0PVslKJNbzh7WMFqmG534562
         VbNskI2R7KpKP0z/+6xzPchuwCZJaXexV+JVBUbOL8iqSmtx3OhnzYKcWy5etO+REK
         hGZXyLp+x8h5Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: 8851b: update RF radio A parameters to
 R28
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230615130442.18116-2-pkshih@realtek.com>
References: <20230615130442.18116-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168734076887.380100.13968814729721689262.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 09:46:14 +0000 (UTC)
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

> Update 8851b radio A parameters to R28 along with internal HALRF_029_00_103
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

f5993f39f3a7 wifi: rtw89: 8851b: update RF radio A parameters to R28
b067acb1325a wifi: rtw89: 8851b: update TX power tables to R28
b686bc67e043 wifi: rtw89: 8851b: rfk: add LCK track
76a7c7acaa78 wifi: rtw89: 8851b: rfk: update IQK to version 0x8
076031a09ae9 wifi: rtw89: 8851b: configure to force 1 TX power value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230615130442.18116-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

