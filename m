Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79AC63B97F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 06:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiK2FfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 00:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiK2FfT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 00:35:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8F827CE1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 21:35:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A034B80EAC
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 05:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D5AC433C1;
        Tue, 29 Nov 2022 05:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669700114;
        bh=o4s4M3GENouVY2otpcgIvA0Qfh+MGpfYdT+ZZJ7I/SQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D+b5m4aaY4PRctY+wYuUvUroHeeLCDmA/mjG0yju8PAqBabK/oGmdrAkHOHdQf6Bz
         b5MzC1VsUuvW2ZaFXEi8qki9uMmQyjJkxTbCbXztx6st2iEJQ5Cc0AiYc60sHhSBl9
         dtsDqXJbxmtj4A8a7+23Vk8HaMPAEA/27Jq5hEbn7L4t+kapTxuw9HiQDKLphkX+6E
         o/Ir8KwBQT3nhGIQWtKyQHbyS0BzJQwcT9IvvfOkKIs2uz6BqHB53uTsQUsFowCHNR
         OInWONjS2XGpkQD/LbzV0+gaIiljBiX+s3L0OdvpNBKsASK8aS9bExmqBw/8TlyI9u
         T5ye+6b6I72nw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kevin Yang <kevin_yang@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/6] wifi: rtw89: mac: process MCC related C2H
In-Reply-To: <6444fb9949e14656b3ccf0adb6babb63@realtek.com> (Ping-Ke Shih's
        message of "Tue, 29 Nov 2022 00:22:40 +0000")
References: <20221118051042.29968-1-pkshih@realtek.com>
        <20221118051042.29968-5-pkshih@realtek.com>
        <87o7sr5hq9.fsf@kernel.org>
        <6444fb9949e14656b3ccf0adb6babb63@realtek.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 29 Nov 2022 07:35:10 +0200
Message-ID: <8735a25nn5.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Monday, November 28, 2022 9:31 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Kevin Yang <kevin_yang@realtek.com>; linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH 4/6] wifi: rtw89: mac: process MCC related C2H
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
>> >
>> > Process C2H(s) related to MCC (multi-channel concurrency). These handling,
>> > which either call rtw89_complete_cond() or show message in debug mode, can
>> > be considered atomic/lock-free. So, they should be safe to be processed
>> > directly after C2H pre-check in previous patch.
>> >
>> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> [...]
>> 
>> > +static
>> > +void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
>> > +					   struct sk_buff *c2h, u32 len) = {
>> > +	[RTW89_MAC_C2H_FUNC_MCC_RCV_ACK] = rtw89_mac_c2h_mcc_rcv_ack,
>> > +	[RTW89_MAC_C2H_FUNC_MCC_REQ_ACK] = rtw89_mac_c2h_mcc_req_ack,
>> > +	[RTW89_MAC_C2H_FUNC_MCC_TSF_RPT] = rtw89_mac_c2h_mcc_tsf_rpt,
>> > +	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
>> > +};
>> 
>> static const?
>> 
>
> These are function pointers, so const is before instance name, 
> i.e. '... const rtw89_mac_c2h_mcc_handler ..'

Ah indeed, missed that. Thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
