Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177614F5DA2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiDFMG2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiDFMFV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:05:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9307347CDEF
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 00:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ABB6B82135
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 07:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E870EC385A1;
        Wed,  6 Apr 2022 07:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649231327;
        bh=sUa+cmlS9FuJXAqIkwT4f8T97GpnbJ3xFzoP5aUC2Fs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rv11ASdnYBPDsrEGpHzOSp30UbGa9noKecYAUcT3RlPzwpn5QRpOjbmEXeE/T/Kpy
         mOqDPWvNsX5bLLU0+5LMX0M2u6bDJb5bp603sEbVvFcD+XGzxPsAjWKaOtlQTFeWRY
         CQVVGDCz6AchudWkjalWCUhGnczJpQTSsE/WkPvZeBEyr0M/yM20wNaGyOE081+x7o
         5EcPT9WyeluM0XCqHX2i4IJnzfdRun8ri4MWMt0IDIeRYbxLe5vB3OcCiAGRHfoV+W
         3KdLfJ8jbyYMYj3I35Y1a0fPgwSfSBny2nkwINffHpSrDFuhV0aaZBsGhF0IkXc+Pn
         FCAGfFjZXbYEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] rtw89: add UK to regulation type
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220318023214.32411-2-pkshih@realtek.com>
References: <20220318023214.32411-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923132099.18336.6363944763958355945.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 07:48:46 +0000 (UTC)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Add RTW89_UK to enum rtw89_regulation_type.
> The follow-up commit will configure the corresponding values for it
> to TX power tables.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patches applied to wireless-next.git, thanks.

5a0e776bec96 rtw89: add UK to regulation type
c504bf23290c rtw89: 8852a: update txpwr tables to HALRF_027_00_038
034307088cb2 rtw89: regd: consider 6G band
1ae30c37ecf1 rtw89: regd: update mapping table to R59-R32
bed4045ffb9c rtw89: packed IGI configuration flow into function for DIG feature
1e6f0d2a677a rtw89: disabled IGI configuration for unsupported hardware
a95bd62ec01d rtw89: add chip_info::h2c_desc_size/fill_txdesc_fwcmd to support new chips
6d5b5d6290ec rtw89: pci: support variant of fill_txaddr_info
f59acdde5197 rtw89: support variant of fill_txdesc
79a6c9a4f3c4 rtw89: support hardware generate security header
84fc6999f0d0 rtw89: read RX bandwidth from v1 type RX descriptor

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220318023214.32411-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

