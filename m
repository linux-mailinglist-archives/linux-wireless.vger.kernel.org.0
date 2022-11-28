Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED0263A987
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 14:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiK1NbT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 08:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiK1Nap (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 08:30:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41781DDC2
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 05:30:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BFAFCE0E5F
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 13:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC04C433D6;
        Mon, 28 Nov 2022 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669642241;
        bh=cFLTvkUZGozT8K94l2UKTO6K59u2aEegCDKf+0pnPn0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Htkc59AnsJ2JU4o+amGjltr9Be0EhWSf+TZYJmearP6kfRDvT27OSga6VESSipAxG
         3iwS72p3F9Qx2xCkL6oF3V7R06HkQ59khGer+G3ndw7hfsA9+WQEccxsGNSUG1vasv
         Z8l37RoAVgWkjJraPK8OVY7VK+KkIpo4P40C3jnP6w5qGo70BvFyXxb02ZSo6pV0rM
         OAEAFeoA2558St1w7Nih3zm5Js7WF7W8KTJ+fypz6BTgYSGnAWEV+YtY0TWZ8zIWe0
         +j7YN+PM/RBheJBRlwx9kSXjSAKnsjFoKxiKqfVZAWQBRlsQudWkOxRg+E0dZX4sg1
         ZVDyUvXdr9T+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/6] wifi: rtw89: mac: process MCC related C2H
References: <20221118051042.29968-1-pkshih@realtek.com>
        <20221118051042.29968-5-pkshih@realtek.com>
Date:   Mon, 28 Nov 2022 15:30:38 +0200
In-Reply-To: <20221118051042.29968-5-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 18 Nov 2022 13:10:40 +0800")
Message-ID: <87o7sr5hq9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> Process C2H(s) related to MCC (multi-channel concurrency). These handling,
> which either call rtw89_complete_cond() or show message in debug mode, can
> be considered atomic/lock-free. So, they should be safe to be processed
> directly after C2H pre-check in previous patch.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static
> +void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
> +					   struct sk_buff *c2h, u32 len) = {
> +	[RTW89_MAC_C2H_FUNC_MCC_RCV_ACK] = rtw89_mac_c2h_mcc_rcv_ack,
> +	[RTW89_MAC_C2H_FUNC_MCC_REQ_ACK] = rtw89_mac_c2h_mcc_req_ack,
> +	[RTW89_MAC_C2H_FUNC_MCC_TSF_RPT] = rtw89_mac_c2h_mcc_tsf_rpt,
> +	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
> +};

static const?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
