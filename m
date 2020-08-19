Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D183724A3AD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHSQBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 12:01:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17508 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgHSQBF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 12:01:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597852864; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=YdmHl3Ns+G1EKXzRdQxyISQdVhXzSBc6gpMCmTL8jDc=; b=DgeoN7fnPdlrIizylOxloZCagq5zHTTktRfpaKoOelCRFAQF9pzqU74nuk78ZIqH3hBw5GXx
 ALq9oweRXbxLzHHO0a9NrWW6HWZL/D/6SWuEvT05iwupt8i6nUmfvGAa35reRAnJDKk2/v8F
 4/bikuFQAPXYCfp0GGdPFuDSJvg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f3d4cb61054562ec5dc7e31 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 16:00:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2BCBC43387; Wed, 19 Aug 2020 16:00:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BE99C433C6;
        Wed, 19 Aug 2020 16:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BE99C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v4 2/2] ath10k: add fw coredump for sdio when firmware assert
References: <1569310030-834-1-git-send-email-wgong@codeaurora.org>
        <1569310030-834-3-git-send-email-wgong@codeaurora.org>
        <87mu2xkwv9.fsf@codeaurora.org>
        <103b604e367a150850d4e8fe179c727f@codeaurora.org>
Date:   Wed, 19 Aug 2020 19:00:50 +0300
In-Reply-To: <103b604e367a150850d4e8fe179c727f@codeaurora.org> (Wen Gong's
        message of "Tue, 18 Aug 2020 17:23:05 +0800")
Message-ID: <87tuwyiq19.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-08-15 00:36, Kalle Valo wrote:
>> Wen Gong <wgong@codeaurora.org> writes:
>>
>> I did some changes in the pending branch, please check:
>>
> I compared this patch with patch in pending branch, it is OK for me.

Great, thanks for testing.

I also did some changes to the commit log and added an example output of
a firmware crash.

> [ 1378.680788] ath10k_sdio mmc1:0001:1: check fw reg : 400

But I could not find this message anywhere in upstream ath10k so I
assumed it's from an out-of-tree patch and removed it from the example.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
