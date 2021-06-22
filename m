Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D653B05D5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVNbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 09:31:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44415 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFVNbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 09:31:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624368576; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=qw4qwoH2ZqUNGdgEGYLCVJJOtbJiNs6sdFNSqhDVjK0=; b=f1YSM5sE9dVVL+1M1dxUk+LoIhxq6PfrVpo/mckYUIDFI293CigTE9594VVZ3/bkCMfNYOFO
 fhRbNYbNMjGE5wRTZkowLFgn5P72mPkpiGhOT2HJNlUNkR5e6qY7BONlFY/agaq2qY9wVUti
 ky6/fOGhVv6QhkS3YMIAYIns+mw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60d1e59312003202412c281e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 13:28:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFEFAC43460; Tue, 22 Jun 2021 13:28:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A429C433D3;
        Tue, 22 Jun 2021 13:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A429C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     luciano.coelho@intel.com, linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>
Subject: Re: [PATCH v2 1/4] iwlwifi: mei: add the driver to allow cooperation with CSME
References: <20210621080159.12883-1-emmanuel.grumbach@intel.com>
Date:   Tue, 22 Jun 2021 16:28:46 +0300
In-Reply-To: <20210621080159.12883-1-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Mon, 21 Jun 2021 11:01:56 +0300")
Message-ID: <87k0mmjaep.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> iwlmei is a driver that handles the communication with the
> Wireless driver of the CSME firmware.
> More details in the documentation included in this patch.

A complicated new feature and just two sentences in the commit log? The
commit log should give a proper overview what the patch does and why.
This commit log really says to the reader "I don't care, find out
yourself".

And being nice I did try to read few paragraphs from the patch but as I
didn't even see any explanation for CSME or SAP I gave up.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
