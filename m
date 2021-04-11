Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C735B287
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhDKJDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:03:43 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21130 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKJDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:03:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618131807; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=pSLz/dH4+J3kxDh61EfsI7iQBV2eaH+73uKR2O3B3Ac=; b=HDjRpFL4FxZQ6kf8FlMgUmgg0FRgwEjm8HNXMSoDHVbUjBFjanHEkcVIU8+xuDcHigQwW/vS
 rWVcH1MpjUzdHoRz3g16wBFJ6kxd50AXBLbbSuTfEkALoHB1SrG7gGMkOFu1p7O/iS9WWGr/
 3yoSo8eEQdSKH0P5NA062YB+N7A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6072bb5503cfff345226f62f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 11 Apr 2021 09:03:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8286EC43463; Sun, 11 Apr 2021 09:03:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B306C433CA;
        Sun, 11 Apr 2021 09:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B306C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeff Garzik <jgarzik@pobox.com>,
        James Ketrenos <jketreno@linux.intel.com>,
        wireless <linux-wireless@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH] ipw2x00: potential buffer overflow in libipw_wx_set_encodeext()
References: <YD4enB/Er/5PWgUz@mwanda>
        <CA++WF2PBo1Mok+bnnUCEZxbbEacX7FcU7PYAPTo=iqgOb2+f3Q@mail.gmail.com>
Date:   Sun, 11 Apr 2021 12:03:11 +0300
In-Reply-To: <CA++WF2PBo1Mok+bnnUCEZxbbEacX7FcU7PYAPTo=iqgOb2+f3Q@mail.gmail.com>
        (Stanislav Yakovlev's message of "Sat, 10 Apr 2021 10:59:49 +0400")
Message-ID: <87blalmbw0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislav Yakovlev <stas.yakovlev@gmail.com> writes:

> On Tue, 2 Mar 2021 at 15:16, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> The "ext->key_len" is a u16 that comes from the user.  If it's over
>> SCM_KEY_LEN (32) that could lead to memory corruption.
>>
>> Fixes: e0d369d1d969 ("[PATCH] ieee82011: Added WE-18 support to
>> default wireless extension handler")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  drivers/net/wireless/intel/ipw2x00/libipw_wx.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)

[...]

>> --- a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
>> +++ b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
>> @@ -633,8 +633,10 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
>>         }
>>
>>         if (ext->alg != IW_ENCODE_ALG_NONE) {
>> -               memcpy(sec.keys[idx], ext->key, ext->key_len);
>> -               sec.key_sizes[idx] = ext->key_len;
>> +               int len = min_t(int, ext->key_len, SCM_KEY_LEN);
>> +
>> +               memcpy(sec.keys[idx], ext->key, len);
>> +               sec.key_sizes[idx] = len;
>>                 sec.flags |= (1 << idx);
>>                 if (ext->alg == IW_ENCODE_ALG_WEP) {
>>                         sec.encode_alg[idx] = SEC_ALG_WEP;

In another thread Linus gave a good tip about clamp_val(), I think it
should be used it here as well to make the check safer and more
readable. And also elsewhere in wireless code with similar limits.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
