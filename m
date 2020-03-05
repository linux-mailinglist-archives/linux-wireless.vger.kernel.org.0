Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A9D17A81C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgCEOu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:50:57 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:58408 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbgCEOu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:50:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583419856; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hOOwuuFORPdcj3izpRwBIiLeAEHmmKdT/tOpKUOsL4I=; b=A+NKtK9PhcfSGJ/TAXkWOcsQh+O3hIH28ga0H2pT8kwkDiPZHqcgCxdMBvzjMoixZGkU7Zpc
 7nBcSL/XnHVwmm2EI9ATZ7Cxd7xL3SFLjYuRxDigD/mFjN+VRnAr3MZue+vkVRo99VSFWJb3
 Vm8pU1UMuW93oNeyBN3WCezyys4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6111c8.7f8e9612ee68-smtp-out-n03;
 Thu, 05 Mar 2020 14:50:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0559FC433A2; Thu,  5 Mar 2020 14:50:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2364C43383;
        Thu,  5 Mar 2020 14:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2364C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update web URL for iwlwifi
References: <iwlwifi.20200305142622.3b1f9018cd2e.Iccbce3e78befd4ac39735b26617cfb6a12a2ae5a@changeid>
Date:   Thu, 05 Mar 2020 16:50:43 +0200
In-Reply-To: <iwlwifi.20200305142622.3b1f9018cd2e.Iccbce3e78befd4ac39735b26617cfb6a12a2ae5a@changeid>
        (Luca Coelho's message of "Thu, 5 Mar 2020 14:26:22 +0200")
Message-ID: <87ftemq2ik.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> The current URL mentioned in iwlwifi's W entry is outdated and
> currently pointing to a dead link.  Change it so that it points to the
> correct Wiki page directly.
>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

I'll queue this for v5.6, ok?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
