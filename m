Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C02694DD1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBMRTN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBMRTM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:19:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99A1CACA
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6FC3B810D6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFBFC433EF;
        Mon, 13 Feb 2023 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676308746;
        bh=fLXVuJEz33WUQqMhbIK497AXT8+c7IGRBEsgRWk208E=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t/OFcGYoK4n6tw2341CWoxUxE2TNjaA90VMo1t0uBK8tSlLXl8RtNc+WXdHIjNi0y
         9d6I4gB+T13O7Bu7705LlSxH7YCDUx2w7zpdHiQTrqCs2QuTVtTe8/hJd7KntpGE/F
         a0IrFDdY/sjlcPBejlK4Cnz8tEMfiOIzMTq1WYvixDpGD/nDzVP+Q8vXwuJ0Io4GtB
         O6Qyz2x0HmHM96RxtHcasjaXLI00GHN0j0zWtKxRV0skujpzKyJUoZSJUN4Y5U/sAy
         UM5xEgvsbFjQznhxKD5mZz33DQXLe3VUZgGcF6DjVr327QZlB6wDv/vCoWGkOOW0UR
         q4AG1msQc0DbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: 8852b: correct register mask name of TX
 power
 offset
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230203064907.8046-1-pkshih@realtek.com>
References: <20230203064907.8046-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630874419.12830.1620149307028782469.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:19:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> For a packet with 1SS rate, it can also transmit via 2 antenna, called
> 2T mode. For 2T TX power offset, mask should be 2T as well. Fortunately,
> the mask of 2T and 1T are the same, so it can still work well without
> this fix.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

5466ee9a7c63 wifi: rtw89: 8852b: correct register mask name of TX power offset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230203064907.8046-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

