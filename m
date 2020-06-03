Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECE41ED555
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFCRu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 13:50:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48906 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgFCRu4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591206655; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=luWTnmLgrRwK4cr6Elv21DKheVafZmEwvDP8tIGTuZw=;
 b=XnfphK36tLtzF+OPc7Uaov58//r6Ysm1xVRC1GU1u4NZlTV8D4onUfNxTuoBoHtNklcLBpMk
 H0i+JaHOeOkUDqBkaMuoSchxhzc8bd3UMKfs3bwBgWkTSO03rhpIwu891o6uZoZDgOjZqku+
 YBmyiJjIjZaV4t3Aw22yjTfEZnw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ed7e2ffc0031c71c2772e43 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Jun 2020 17:50:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD565C433CB; Wed,  3 Jun 2020 17:50:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A082C433C6;
        Wed,  3 Jun 2020 17:50:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jun 2020 10:50:53 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/8] add 6GHz radio support in ath11k driver
In-Reply-To: <871rmwl2d6.fsf@codeaurora.org>
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
 <871rmwl2d6.fsf@codeaurora.org>
Message-ID: <97dabee94c4faecbc83bbd02baf3a798@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-03 06:12, Kalle Valo wrote:
> Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> writes:
> 
>> This patch series adds 6GHz frequency listing in ath11k driver and 
>> mac80211
>> registration for the 6GHz band. Also, extends some of wmi command tlvs 
>> for
>> supporting 6GHz.
>> 
>> changes in v5:
>>  - latest 6ghz patches on mac80211 expects driver not to pass ht/vht
>>    caps for 6GHZ band at device registration. so fix that.
> 
> What are the dependencies for this patch? Is everything that is in
> mac80211-next as of today enough?
Yes Kalle. current mac80211-next is enough.

> 
> Also what I do with Rajkumar's patch:
> 
> [PATCH] ath11k: build HE 6 GHz capability
> 
> Should I apply it before or after this patchset?
Although there is no compile dependency with above patchset,
there will be 6ghz functionality dependency with above. So, IMO, its 
better
to apply after this patch set.

Thanks
Pradeep
