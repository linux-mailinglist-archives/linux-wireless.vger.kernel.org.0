Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8AD25A7F2
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 10:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBIr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 04:47:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:58649 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBIrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 04:47:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599036444; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4h0ipg5/aFd2L0oIgKn9tOzzlf38TDXmZZeE/iyY8Lw=; b=p99K1w9Jq+Ead9ASdTz7qmYNyIXfwFVEGDd4+ZCHoIevD8nJ4/Mnitr+CQi3LBbJoJ578dym
 V29U5yCeqAgtqwit1QggIWemWPNWAy/W5IOhN0hUe1VENETFHa2qWysARFVnJbGc3ZKdocSC
 TdSEeDgVU2f46Ida8/o8a4L0gE4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f4f5c19885efaea0a59bf39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 08:47:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 544F5C433C9; Wed,  2 Sep 2020 08:47:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=2.0 tests=ALL_TRUSTED,
        GUARANTEED_100_PERCENT,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A1A7C433C6;
        Wed,  2 Sep 2020 08:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A1A7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath10k: Use bdf calibration variant for snoc targets
References: <1593193990-30366-1-git-send-email-pillair@codeaurora.org>
Date:   Wed, 02 Sep 2020 11:47:16 +0300
In-Reply-To: <1593193990-30366-1-git-send-email-pillair@codeaurora.org>
        (Rakesh Pillai's message of "Fri, 26 Jun 2020 23:23:10 +0530")
Message-ID: <87y2ls4lbf.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> writes:

> Board Data File (BDF) is loaded upon driver boot-up procedure.
> The right board data file is identified using bus and qmi-board-id.
>
> The problem, however, can occur when the (default) board data
> file cannot fulfill with the vendor requirements and it is
> necessary to use a different board data file.
>
> Add the support to get the variant field from DTSI and
> use tht information to load the vendor specific BDF.
>
> The device tree requires addition strings to define the variant name
>
>     wifi@a000000 {
>             status = "okay";
>             qcom,ath10k-calibration-variant = "xyz-v2";
>     };
>
>     wifi@a800000 {
>             status = "okay";
>             qcom,ath10k-calibration-variant = "xyz-v1";
>     };
>
> This would create the boarddata identifiers for the board-2.bin search
>
>  *  bus=snoc,qmi-board-id=16,qmi-chip-id=0,variant=xyz-v1
>  *  bus=snoc,qmi-board-id=17,qmi-chip-id=0,variant=xyz-v2

You mention nothing about qmi-chip-id in the commit log. Please document
what it is and also give some examples what kind of values there can be.

> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -576,6 +576,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
>  	if (resp->chip_info_valid) {
>  		qmi->chip_info.chip_id = resp->chip_info.chip_id;
>  		qmi->chip_info.chip_family = resp->chip_info.chip_family;
> +	} else {
> +		qmi->chip_info.chip_id = 0xFF;
>  	}

So you hard code chip_id to 0xff if it's not valid. Is it 100%
guaranteed that there never will be a chip id with 0xff?

>  
>  	if (resp->board_info_valid)
> @@ -817,12 +819,18 @@ static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
>  static int ath10k_qmi_fetch_board_file(struct ath10k_qmi *qmi)
>  {
>  	struct ath10k *ar = qmi->ar;
> +	int ret;
>  
>  	ar->hif.bus = ATH10K_BUS_SNOC;
>  	ar->id.qmi_ids_valid = true;
>  	ar->id.qmi_board_id = qmi->board_info.board_id;
> +	ar->id.qmi_chip_id = qmi->chip_info.chip_id;

To me a safer, and cleaner, option would be to have
ar->id.qmi_chip_id_valid, and only add qmi-chip-id=%x to the board id if
qmi_chip_id_valid is true. That way there's not this magic 0xff value
hardcoded anywhere.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
