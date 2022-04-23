Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0760750CA0C
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 14:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiDWMuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiDWMuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 08:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC01A066
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 05:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A1C61123
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 12:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F043C385A0;
        Sat, 23 Apr 2022 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650718029;
        bh=MeKJqdRE/4umX9GIoMLr6EIlWYrZ0JtMrp4Z9R5Nqxc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TwmblnMR+130TjdVuvuT6fojV3NG/HxVmdtNCbgLTJQApBNs31DerpUcOI42VRbfE
         1WSMNdaFoHCTdEPxU0gMhtIvmuLnfml4TlV57HxbRUjEDadhxF2kfjf8xGuO7aedMG
         IPvxNHTLKwC+Iyqh/TTK+TnV9rugAJlpxEmWNAchhTJ7TyTOBZm2Tm6GmrH/zUnhPM
         NhfK0BAHGLdve5+9S/PJjtIA/KzlRNdCnGhaFeJErzaflA69K7Qdr/43C2k6r/d5sY
         voLyG9KKLP5hjVINiSqbR7j8B9klsJNVXBBOj2ENkeLJqoRJOthn/CRW1BiOUUxicE
         Q8KBH0AAtsu6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: fix uninitialized 'tim_offset' warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220420093058.31646-1-pkshih@realtek.com>
References: <20220420093058.31646-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165071802597.1434.4137792080732021281.kvalo@kernel.org>
Date:   Sat, 23 Apr 2022 12:47:07 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> This avoids below warning and makes compiler happy.
> error: uninitialized symbol 'tim_offset'
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

9cbdadf0097f rtw88: fix uninitialized 'tim_offset' warning
9ebacb1e7e75 rtw88: pci: 8821c: Disable 21ce completion timeout

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220420093058.31646-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

