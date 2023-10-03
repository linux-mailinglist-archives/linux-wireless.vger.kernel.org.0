Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17AC7B682C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 13:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjJCLoU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 07:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJCLoT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 07:44:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72739A1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 04:44:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C470C433C9;
        Tue,  3 Oct 2023 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696333457;
        bh=1ZHQ/8YgwEfzgFbkL9qF9ChB6L2yi23VDEiHrr0QSOc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ok4Gd3nvHv1EyjGVLUsCl7xtuwHxjPUWEjBD3qkDA6gsXTrnKQYAlPmZcG7rAXYY/
         9KDHyZtSxr88tcOEplso1aK/By0kcmnJati7UEpKeELlS6ElK3vaIs6NJnH/2jRXZT
         jc7N0SCKtiyU7lfVxyE0SScXS/Y6O4MJR0tU+5xHQdmKYa4kqRw3fb/B5TUcm8BQsa
         PCAtkRdyOTKGnXfcGaG0Xq5C3PHrQbsJ0ycPD7moI/soiTRbsl9qTTJkaMNNdVy/A3
         ipozdRkNbxbsaBURS8GtAnVHQ0Eiz8+ck8nDlDwXYWuA8MKbC4wBJQ0RGLHFaX2l0T
         VQ1TwXiJyqsOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: use unsigned long for rtl_bssid_entry
 timestamp
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230929154524.222498-1-dmantipov@yandex.ru>
References: <20230929154524.222498-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169633345416.28914.4857738400744205275.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 11:44:15 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'age' of 'struct rtl_bssid_entry' is in jiffies, prefer 'unsigned
> long' over 'u32' to avoid possible truncation in 'rtl_collect_scan_list()'
> and thus weird result in 'rtl_scan_list_expire()'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

f0fb62e090bd wifi: rtlwifi: use unsigned long for rtl_bssid_entry timestamp

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230929154524.222498-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

