Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD06C9E7C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 10:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjC0Iqq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjC0Iqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 04:46:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8C6EB6
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 01:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52EAD61034
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 08:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B38C4339B;
        Mon, 27 Mar 2023 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679906498;
        bh=ksMyoZX9ZAfocIBGDql+YmadNq4hqmo5Mrq/Xa+w6uc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=vEQ4kiAjAGM9AIg5Z5VE9BIp3m43tcuBggGtZVADmKUhzK3gwaRJejqtBomXJXeI4
         NmFa6KEmnzCt2aXM+uyKUA7KzzTf4MmjYr0uo5VwNG3Q1PmC45vLReuom5t/RcHffn
         xEbpOWhBcjIPuS2eHCrVwghpqCwFylblanAM9elaOkUt5VUh3f2ceFEEcLZW4qxeeX
         wSG3vMP0CoUfaH8nQEKobd+DcsVO5omyDKyiPD5jcaV7Di5mQgsJVOy9TY7ybI+rZi
         pie8JN6/d9J+2mqNk/7qMiICrXmMgLHYCKxtQUNHyThX/wXe3T50Yct8Vv2As5NdCb
         zfszRTBW2di+w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
        <20230322171905.492855-8-martin.kaistra@linutronix.de>
        <b48af4c2e9ef4555997b4a6388fdd270@realtek.com>
Date:   Mon, 27 Mar 2023 11:41:32 +0300
In-Reply-To: <b48af4c2e9ef4555997b4a6388fdd270@realtek.com> (Ping-Ke Shih's
        message of "Mon, 27 Mar 2023 01:48:06 +0000")
Message-ID: <87lejitwlf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Thursday, March 23, 2023 1:19 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
>> 
>> The HW maintains a rate_mask for each connection, referenced by the
>> macid. Add a parameter to update_rate_mask and add the macid to the
>> h2c call in the gen2 implementation.
>> 
>> Also extend refresh_rate_mask to generate the macid in AP mode from
>> sta->aid.
>
> Firmware can support 32 mac_id (station instance) at most, so it will be a
> problem if hostapd assigns aid more than 32. Though I'm not clear how
> hostpad assigns the aid, it would be always safe that rtl8xxxu maintains
> mac_id by a bitmap in driver.

Does rtlw8xxxu set struct wiphy::max_ap_assoc_sta? It would be good to
advertise the user space the maximum number of stations.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
