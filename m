Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47A344610F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhKEJGp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 05:06:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22002 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhKEJGo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 05:06:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636103045; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Pa3ICw5KIRTQO6FEZOuM+DFjebBoG9lYhHSPEJ5QY60=; b=qfp4LKIGoTC6veiLQoVn1tShiXSeHhvDXqohuZKx6rQAtJJbxQZcWe4CwOac2NvemR7scDV4
 rQbccOaitbMAv32IzxkAYAVuWc4M0GAm08xNHQgAf95n/H/f7X8yzTIyCevF07IOgfXwxvjt
 RVr/+nZ65qa8jNzkj10m2hV1Ob4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6184f383045d18c07587da03 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Nov 2021 09:04:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74191C4360C; Fri,  5 Nov 2021 09:04:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58877C4338F;
        Fri,  5 Nov 2021 09:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 58877C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@gmail.com>
Subject: Re: [PATCH] rtw89: Fix crash by loading compressed firmware file
References: <20211105071725.31539-1-tiwai@suse.de>
        <s5hpmrfgj93.wl-tiwai@suse.de> <87zgqjqaae.fsf@codeaurora.org>
        <s5hh7crgflg.wl-tiwai@suse.de>
Date:   Fri, 05 Nov 2021 11:03:55 +0200
In-Reply-To: <s5hh7crgflg.wl-tiwai@suse.de> (Takashi Iwai's message of "Fri,
        05 Nov 2021 09:40:43 +0100")
Message-ID: <87v917q8hw.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> On Fri, 05 Nov 2021 09:25:13 +0100,
> Kalle Valo wrote:
>> 
>> Takashi Iwai <tiwai@suse.de> writes:
>> 
>> > On Fri, 05 Nov 2021 08:17:25 +0100,
>> > Takashi Iwai wrote:
>> >> 
>> >> When a firmware is loaded in the compressed format or via user-mode
>> >> helper, it's mapped in read-only, and the rtw89 driver crashes at
>> >> rtw89_fw_download() when it tries to modify some data.
>> >> 
>> >> This patch is an attemp to avoid the crash by re-allocating the data
>> >> via vmalloc() for the data modification.
>> >
>> > Alternatively, we may drop the code that modifies the loaded firmware
>> > data?  At least SET_FW_HDR_PART_SIZE() in rtw89_fw_hdr_parser() looks
>> > writing it, and I have no idea why this overwrite is needed.
>> 
>> Strange, isn't the firmware data marked as const just to avoid this kind
>> of problem? Does rtw89 have wrong casts somewhere which removes the
>> const?
>
> Yes.  SET_FW_HDR_PART_SIZE() does the cast, dropping the const.

Oh man, all of GET and SET macros in fw.h have those casts:

#define GET_FW_HDR_MAJOR_VERSION(fwhdr)	\
	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(7, 0))
#define GET_FW_HDR_MINOR_VERSION(fwhdr)	\
	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(15, 8))
#define GET_FW_HDR_SUBVERSION(fwhdr)	\
	le32_get_bits(*((__le32 *)(fwhdr) + 1), GENMASK(23, 16))

I don't know how I missed those during my review :( But this is exactly
why I prefer having a proper struct for commands and events, instead of
u8 buf used with these macros.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
