Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF92438FB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMK6I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 06:58:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19880 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgHMK6G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 06:58:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597316286; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=lFkj72GeE2bw+45X+kHHD0BOzdXRWeQBgIzNSShoJpM=; b=RQYb0J+RHsypr28lBYEUI3a7ViSKVqqLQFIbmF4VS91wbNUOxiYP3oqbhrMGMjzd/hZb8lEN
 d3NKgFDTdbfryZHbxoTXRy30n+5chRC6Ha8qPNxo+7ZQicJdHy1H5bS85bspZgEjjTYg6fQF
 zG/F7+4/4j9BWJAkBuHVGF1qGrg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f351cae03528d40248bc852 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 10:57:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4277C433CA; Thu, 13 Aug 2020 10:57:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F1E1C433C6;
        Thu, 13 Aug 2020 10:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F1E1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com, Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] brcmfmac: reserve tx credit only when txctl is ready to send
References: <20200813070017.89023-1-wright.feng@cypress.com>
Date:   Thu, 13 Aug 2020 13:57:44 +0300
In-Reply-To: <20200813070017.89023-1-wright.feng@cypress.com> (Wright Feng's
        message of "Thu, 13 Aug 2020 02:00:16 -0500")
Message-ID: <87o8nevmmv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> The 4329 throughput drops from 40.2 Mbits/sec to 190 Kbits/sec in 2G
> 11n mode because the commit b41c232d33666 ("brcmfmac: reserve 2 credits
> for host tx control path"). To fix the issue, host driver only reserves
> tx control credit when there is a txctl frame is pending to send. And
> we also check available credit by using "not equal to 0" instead of
> "greater than 0" because tx_max and tx_seq are circled positive numbers.
>
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: b41c232d33666 ("brcmfmac: reserve 2 credits for host tx control
> path")

Fixes tag should be in one line, but I can fix it.

> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

And I'll queue this to v5.9.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
