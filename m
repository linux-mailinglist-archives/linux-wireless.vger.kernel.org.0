Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6F41F198
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 17:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhJAP53 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 11:57:29 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50568 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhJAP53 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 11:57:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633103745; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=oloV5Ja6lf4KgMjKTFE3+2vpTpDYQj+Bi87L/1/Ou9c=; b=ovpd4qAI48BSM37ABhiU+cS4lsZD/Aaf3m1dxEo6V4/VREzC5OWNLgQbiJ12I90J6hkqsWXY
 4EP4DEv2ZAhmdiaZpXohvhappjGAusV3T95jNRfusA3C3LQw7VKEEbCNboxZam6a3/gjzxtz
 gAD2ijVZHVTo2lHtIEw5K96LPBk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61572f768578ef11ed99f02b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 15:55:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21A6AC4360D; Fri,  1 Oct 2021 15:55:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9054C4338F;
        Fri,  1 Oct 2021 15:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B9054C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 06/24] rtw89: add files to download and communicate with firmware
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-7-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 18:55:27 +0300
In-Reply-To: <20210820043538.12424-7-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:20 +0800")
Message-ID: <87o888ivtc.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> The firmware must be downloaded right after HCI basic initialization, and
> then we can obtain hardware capabilities that are used to do mac80211
> register hw.
>
> To download firmware, we need to parse the header to know how many sections
> the firmware has, and then download each section to proper location.
>
> We introduce H2C and C2H to do bi-direction communication with firmware,
> and both support packet-based and register-based methods.
> Normally, we use packet-based H2C/C2H, because it has no number and size
> limits. In contrast, register-based H2C/C2H has only one message and
> fix-four-dword in size.
>
> Header size of packet-based H2C/C2H is eight bytes (two dwords), which uses
> a hierarchical IDs, containing type, category, class and function, to
> classify a H2C or C2H command.
>
> When a C2H is received in interrupt context, we don't process it right
> there, but queue the skb and wake up a ieee80211 work to handle the skb.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static __always_inline void RTW89_SET_FWCMD(u8 *cmd, u32 val, u8 offset, u32 mask)
> +{
> +	u32 *cmd32 = (u32 *)cmd;
> +
> +	le32p_replace_bits((__le32 *)(cmd32 + offset), val, mask);
> +}
> +
> +static __always_inline void RTW89_SET_FWCMD_UA8(u8 *cmd, u8 val, u8 offset, u32 mask)
> +{
> +	u8p_replace_bits(cmd + offset, val, mask);
> +}
> +
> +static __always_inline void RTW89_SET_FWCMD_UA16(u8 *cmd, u16 val, u8
> offset, u32 mask)
> +{
> +	le16p_replace_bits((__le16 *)(cmd + offset), val, mask);
> +}
> +
> +static __always_inline void RTW89_SET_FWCMD_UA32(u8 *cmd, u32 val, u8
> offset, u32 mask)
> +{
> +	le32p_replace_bits((__le32 *)(cmd + offset), val, mask);
> +}

Is __always_inline really necessary? I would say just use the regular
inline keyword and let the compiler optimise as it sees fit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
