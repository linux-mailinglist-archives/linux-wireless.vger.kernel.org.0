Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80141BCE8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Sep 2021 04:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbhI2Coh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 22:44:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22026 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242877AbhI2Coh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 22:44:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632883377; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YUW1DQ7L4ZgQSKFXRt97oq4J/MqnA0T0yeCiCDSR2PA=;
 b=JiItjgJxWUexix5HQWhpICVFwjz996HMffB/oLX3pbdITuRnNYFuTDaqoKaLgn/0hixGGzuk
 UauI6E40tl+lDLn1GneK8f6UiHmnyqkKS11kpo8VZA1rdZBA82MWF1FU5qDc50AyEGjygi6h
 hZQ+X48mVVGrdQ6MWWIFXnMIUhY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6153d2a53cc3a01f2637095e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Sep 2021 02:42:45
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C0A0C4360C; Wed, 29 Sep 2021 02:42:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16783C4338F;
        Wed, 29 Sep 2021 02:42:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Sep 2021 10:42:43 +0800
From:   bqiang@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] ath11k: change return buffer manager for QCA6390
In-Reply-To: <87pmsspwa9.fsf@codeaurora.org>
References: <20210914163726.38604-1-jouni@codeaurora.org>
 <20210914163726.38604-2-jouni@codeaurora.org>
 <87pmsspwa9.fsf@codeaurora.org>
Message-ID: <43fd66ccc28fe80b3ef00e5f1c7e6fbb@codeaurora.org>
X-Sender: bqiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-28 23:14, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Baochen Qiang <bqiang@codeaurora.org>
>> 
>> QCA6390 firmware uses HAL_RX_BUF_RBM_SW1_BM, not 
>> HAL_RX_BUF_RBM_SW3_BM.
>> 
>> Tested-on: QCA6390 hw2.0 PCI 
>> WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>> 
>> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> 
> Same question as in patch 1, does this fix a bug or is just a
> theoretical issue found during code review?

Yes, this patch did fix a bug.
QCA6390 firmware expects some specific packets from WBM2SW1 ring, which, 
however, will
not happen because they are routed directly to host through WBM2SW3 ring 
due to wrong
configuration of RBM.
