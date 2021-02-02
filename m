Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53130B684
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 05:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhBBEd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 23:33:58 -0500
Received: from so15.mailgun.net ([198.61.254.15]:19033 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231477AbhBBEd5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 23:33:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612240410; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=PtR/UtoHlz8eXcl6vbirWe2nIkoVwvfU1OnuGoOADZk=; b=rms6sCjBQ+3Ua0SfJVNoav+hqfrgiwTSRWrC79wczljo8nrwMvoAOImNMz1FAKPYKFbFZUV0
 zhoqxHENjUInwPh4d9BYrvtVD9rsQpCw+GlNvSfM1B8dVQdjj0HNzUvSq8Aw5dOGVnLZDdHX
 erdYir3HN+mLczHjgHt7kAAfgGc=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6018d5f2ab96aecb9f8b9913 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Feb 2021 04:32:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5647DC433ED; Tue,  2 Feb 2021 04:32:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E307AC433CA;
        Tue,  2 Feb 2021 04:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E307AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Peter Oh <peter.oh@eero.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Carl Huang <cjhuang@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] ath11k: fix a locking bug in ath11k_mac_op_start()
References: <YBfy+zc3XkiyIe6t@mwanda>
        <896a68dd-02ec-4fe3-3fbf-ec1bd2decefe@eero.com>
Date:   Tue, 02 Feb 2021 06:32:44 +0200
In-Reply-To: <896a68dd-02ec-4fe3-3fbf-ec1bd2decefe@eero.com> (Peter Oh's
        message of "Mon, 1 Feb 2021 13:47:27 -0800")
Message-ID: <875z3b84yb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Oh <peter.oh@eero.com> writes:

> On 2/1/21 4:24 AM, Dan Carpenter wrote:
>> This error path leads to a Smatch warning:
>>
>>      drivers/net/wireless/ath/ath11k/mac.c:4269 ath11k_mac_op_start()
>>      error: double unlocked '&ar->conf_mutex' (orig line 4251)
>>
>> We're not holding the lock when we do the "goto err;" so it leads to a
>> double unlock.  We should hold the lock because the error path sets
>> "ar->state" so the right fix is to take the lock before doing the goto.
>>
>> Fixes: c83c500b55b6 ("ath11k: enable idle power save mode")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/mac.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireles=
s/ath/ath11k/mac.c
>> index c1608f64ea95..12e981e9e3d7 100644
>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>> @@ -4259,6 +4259,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw=
 *hw)
>>   						1, pdev->pdev_id);
>>   		if (ret) {
>>   			ath11k_err(ab, "failed to enable idle ps: %d\n", ret);
>> +			mutex_lock(&ar->conf_mutex);
>>   			goto err;
>>   		}
>>   	}
>
> It seems moving idle_ps condition in between ath11k_wmi_pdev_lro_cfg()
> and mutex_unlock()
> =C2=A0is a better way in this case.

I agree. In Dan's approach I'm worried about the race when we unlock and
lock again, the state can change in that case.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
