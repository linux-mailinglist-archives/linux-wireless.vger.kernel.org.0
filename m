Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A861263FA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLSNtq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:49:46 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:58762 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbfLSNtp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:49:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576763385; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9RnoUeGfktZIeoc4N0o7RN8cowShMV+lAkk7GEI3L6Q=; b=qgBErW+Io1UFT06mWcQ8l7ZaeIWmGTucoweMBFPvhBxWU4Ri+U3KNxTBy/LArNgJqnrSLHDb
 aFABlW9hm/n5iR+kdlHRPWrKIFd2RrmwRbhHn0gOtQebr7XajdzPR8zD/WVCl5zSa17yC0vL
 YY1tcE8xg525diXEneLg8GbW2do=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb7ff7.7f7ef0e35a08-smtp-out-n01;
 Thu, 19 Dec 2019 13:49:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1FBFC447B6; Thu, 19 Dec 2019 13:49:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E098DC447A6;
        Thu, 19 Dec 2019 13:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E098DC447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 1/2] dt: bindings: net: ath11k: add qcom,board_id definition
References: <20191217164329.4151-1-john@phrozen.org>
Date:   Thu, 19 Dec 2019 15:49:39 +0200
In-Reply-To: <20191217164329.4151-1-john@phrozen.org> (John Crispin's message
        of "Tue, 17 Dec 2019 17:43:28 +0100")
Message-ID: <871rt077d8.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> We need to be able to define what id the board has allowing us to load the
> correct definition data. This patch adds the description of the required
> property.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index a1717db36dba..c68daf6ad424 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -142,6 +142,11 @@ properties:
>          * reg
>          * reg-names
>  
> +  qcom,board_id:
> +      $ref: /schemas/types.yaml#/definitions/uint32
> +      description:
> +        The board id defining what board definition should be loaded

I think this needs more discussion. This is very tricky to get right, as
it needs to be extensible and what not. With ath10k we have learned that
a simple integer is not enough.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
