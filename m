Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E6D5A5045
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH2Pfs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2Pfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 11:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E577B28E
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 839086117B
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 15:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E34C433D6;
        Mon, 29 Aug 2022 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661787344;
        bh=ZWwqvIOS9mKhwMqfV535d6v5lPa4Z7WaRzovmpmsTIM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j77jFmbVcXy8QsAxHW060Wx/JU21N7UD8xeipEs78TYaxExRfYhxrmIkCODMNH9Nh
         iBTtl/Xz500VNGlfI/UwVrMjBTtXTbNc2psXglt+oL7i/uHp94u2+vps30xr7Pebnb
         6oKsWSm8KpD0BM4C5SyHxw2Hf21AOr+dYonKE3e6c/Rcd7mk+EYm61N+a62Uuxc//8
         Odb0huZdHLLG7TvAOm6dhN/+lEmzzz8PyM5EqpzqMh6D3N6m6Gk+XTM0A04H0lskjE
         W1JUxJ1Eh4UpkCF2le7GMaCM4ZJqBZBzJiD9jVRgTUhnKYDOo/ZUwFnJ1n4x3Mzt0Y
         KAYjut4Yhtd5w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: fix uninitialized use of primary channel index
In-Reply-To: <YwZ+RsHL+n02gHZx@dev-arch.thelio-3990X> (Nathan Chancellor's
        message of "Wed, 24 Aug 2022 12:38:46 -0700")
References: <20220815062004.22920-1-pkshih@realtek.com>
        <YwZ+RsHL+n02gHZx@dev-arch.thelio-3990X>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 29 Aug 2022 18:35:39 +0300
Message-ID: <87o7w3f4fo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

> On Mon, Aug 15, 2022 at 02:20:04PM +0800, Ping-Ke Shih wrote:
>
>> clang reports uninitialized use:
>> 
>> >> drivers/net/wireless/realtek/rtw88/main.c:731:2: warning: variable
>>    'primary_channel_idx' is used uninitialized whenever switch default is
>>    taken [-Wsometimes-uninitialized]
>>            default:
>>            ^~~~~~~
>>    drivers/net/wireless/realtek/rtw88/main.c:754:39: note: uninitialized
>>    use occurs here
>>            hal->current_primary_channel_index = primary_channel_idx;
>>                                                 ^~~~~~~~~~~~~~~~~~~
>>    drivers/net/wireless/realtek/rtw88/main.c:687:24: note: initialize the
>>    variable 'primary_channel_idx' to silence this warning
>>            u8 primary_channel_idx;
>>                                  ^
>>                                   = '\0'
>> 
>> This situation could not happen, because possible channel bandwidth
>> 20/40/80MHz are enumerated.
>> 
>> Fixes: 341dd1f7de4c ("wifi: rtw88: add the update channel flow to support setting by parameters")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> Can we get this into -next soon? This warning is breaking our builds due
> to CONFIG_WERROR.

Johannes applied it:

https://git.kernel.org/netdev/net-next/c/4ffb4d25ef12

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
