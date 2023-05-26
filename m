Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A37D7125EC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbjEZLta (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbjEZLt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 07:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F4E5A
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 04:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8F7164F80
        for <linux-wireless@vger.kernel.org>; Fri, 26 May 2023 11:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9235FC4339B;
        Fri, 26 May 2023 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685101755;
        bh=4zBF2mdWj0qm6m7N0xeZdQTBhYiWgiMIDwC9R8eOOIw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rfWXS/+lbBDj3ck4f7uVQVnDvHCRKJf0EGbsQhDxYNJtISN/WcheFsIw5hiURGGzF
         /P5Bwl5uWtDWX416Mcgx9R0iS2FH5yu5LOUQBOBjYF4eKxegFw9ziUoW5SuPyXB4Vy
         QDksVCM9uQ2U2N4eMwkl65Xbj/LQF9BwHLSU0zh+U5dduerT3jrJXv6aLzc8cSpBUF
         7AeZSEXIOHPsfG+3UcTQ7aM0+brCn3yRbTnQGQrQmzdtBkU9QJw8CvOEd7oYLp0e89
         SRQlZFoAd3OC+190wI/eAK+7btyRqAZVZplkFqlQFBcfk+VbWy4TpMe3UD6QQRJeNR
         rkhlLml6PO08Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: rtw89: use struct to access register-based H2C/C2H
References: <20230522122513.13559-1-pkshih@realtek.com>
        <20230522122513.13559-6-pkshih@realtek.com>
        <87cz2ol7i5.fsf@kernel.org>
        <709fd6a89f3f4a637410c0974b32154a8a1b89fe.camel@realtek.com>
Date:   Fri, 26 May 2023 14:49:12 +0300
In-Reply-To: <709fd6a89f3f4a637410c0974b32154a8a1b89fe.camel@realtek.com>
        (Ping-Ke Shih's message of "Fri, 26 May 2023 11:46:21 +0000")
Message-ID: <87y1lbjosn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Thu, 2023-05-25 at 19:07 +0300, Kalle Valo wrote:
>
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > The register-based H2C/C2H are used to exchange commands and events with
>> > firmware. The exchange data is limited, but it is relatively simple,
>> > because it can work before HCI initialization. To make these code clean,
>> > use struct to access them. This patch doesn't change logic at all.
>> > 
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> [...]
>> 
>> > --- a/drivers/net/wireless/realtek/rtw89/fw.h
>> > +++ b/drivers/net/wireless/realtek/rtw89/fw.h
>> > @@ -18,15 +18,51 @@ enum rtw89_fw_dl_status {
>> >       RTW89_FWDL_WCPU_FW_INIT_RDY = 7
>> >  };
>> > 
>> > -#define RTW89_GET_C2H_HDR_FUNC(info) \
>> > -     u32_get_bits(info, GENMASK(6, 0))
>> > -#define RTW89_GET_C2H_HDR_LEN(info) \
>> > -     u32_get_bits(info, GENMASK(11, 8))
>> > +struct rtw89_c2hreg_hdr {
>> > +     u32 w0;
>> > +};
>> 
>> Why this is u32? Shouldn't it be __le32?
>> 
>> > +#define RTW89_C2HREG_HDR_FUNC_MASK GENMASK(6, 0)
>> > +#define RTW89_C2HREG_HDR_ACK BIT(7)
>> > +#define RTW89_C2HREG_HDR_LEN_MASK GENMASK(11, 8)
>> > +#define RTW89_C2HREG_HDR_SEQ_MASK GENMASK(15, 12)
>> > +
>> > +struct rtw89_c2hreg_phycap {
>> > +     u32 w0;
>> > +     u32 w1;
>> > +     u32 w2;
>> > +     u32 w3;
>> > +} __packed;
>> 
>> Here as well? And I saw more in the patch.
>> 
>> Of course these were already there so isn't a problem introduced by this
>> patchset, but I started wondering if we are missing some little endian
>> types?
>> 
>
> I had the same question as yours when I did this conversion, but they
> are correct because we access these H2C commands/C2H events via registers
> which are CPU order.

Ah, thanks for the explanation.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
