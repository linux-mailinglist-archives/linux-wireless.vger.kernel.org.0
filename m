Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0F44609D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Nov 2021 09:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhKEI2E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Nov 2021 04:28:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:35570 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhKEI2D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Nov 2021 04:28:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636100724; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=PodyxWQ8aytFTJyLWgc6LTD5vO5t/jcyhMo21PoIjXk=; b=JOuwEYAyH/0az3J52Ey8r0MqwyvlHySMt77L+F2/0fLPqssGDjNv6KWpouAV2FWLxSVEffo8
 sgmgE3gAiejXuXabvxZ8I3vwzKmIf7RPlN84MS6Yw+mmENwdd71XFIzNFnEMEu4VKdZf1L91
 LV5Vf9eLJuWTxISCNQJ/b8bYe08=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6184ea6e7d93184cc7b1b74b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Nov 2021 08:25:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0522C4360C; Fri,  5 Nov 2021 08:25:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1B86C4338F;
        Fri,  5 Nov 2021 08:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org F1B86C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Larry Finger <Larry.Finger@gmail.com>
Subject: Re: [PATCH] rtw89: Fix crash by loading compressed firmware file
In-Reply-To: <s5hpmrfgj93.wl-tiwai@suse.de> (Takashi Iwai's message of "Fri,
        05 Nov 2021 08:21:44 +0100")
References: <20211105071725.31539-1-tiwai@suse.de>
        <s5hpmrfgj93.wl-tiwai@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 05 Nov 2021 10:25:13 +0200
Message-ID: <87zgqjqaae.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> On Fri, 05 Nov 2021 08:17:25 +0100,
> Takashi Iwai wrote:
>> 
>> When a firmware is loaded in the compressed format or via user-mode
>> helper, it's mapped in read-only, and the rtw89 driver crashes at
>> rtw89_fw_download() when it tries to modify some data.
>> 
>> This patch is an attemp to avoid the crash by re-allocating the data
>> via vmalloc() for the data modification.
>
> Alternatively, we may drop the code that modifies the loaded firmware
> data?  At least SET_FW_HDR_PART_SIZE() in rtw89_fw_hdr_parser() looks
> writing it, and I have no idea why this overwrite is needed.

Strange, isn't the firmware data marked as const just to avoid this kind
of problem? Does rtw89 have wrong casts somewhere which removes the
const?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
