Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759A62F0D8E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 08:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbhAKH7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 02:59:37 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:42232 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKH7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 02:59:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610351966; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fydO7ShoDW9yP3PfpzBZBsPMBYpKxceJ74QJikNwb5A=; b=XTRJQ3movgoKGENHRxlAmoxoGlqpTaGWgtEN7n2i83OOdzPu4EJV6AGF1UA7TbxN0/DTOr1y
 l+8H9ayprnoNjRAsjHQbgvM6hFBv3j3ReckTD5ByWyVyaDRf//UcCDl21Azas47r4URiAnG2
 hI604RhGaEEIdgIUGVjByl1yccY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ffc0533af68fb3b0670d154 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 07:58:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84CC3C433ED; Mon, 11 Jan 2021 07:58:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB4B1C433C6;
        Mon, 11 Jan 2021 07:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB4B1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <vincent_fann@realtek.com>
Subject: Re: [PATCH] rtw88: 8821c: apply CCK PD level which calculates from dynamic mechanism
References: <20201228082516.16488-1-pkshih@realtek.com>
Date:   Mon, 11 Jan 2021 09:58:38 +0200
In-Reply-To: <20201228082516.16488-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Mon, 28 Dec 2020 16:25:16 +0800")
Message-ID: <87sg77lxap.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: vincent_fann <vincent_fann@realtek.com>
>
> Hal function must follow the value that calculates from dynamic mechanism.
> Force to set new_lvl to 4 damages receiving ability. System will not able
> to reconnect to the AP if wifi unexpected disconnecting at this moment.
>
> Signed-off-by: vincent_fann <vincent_fann@realtek.com>

The real name looks to be just a copy of username, badly configured git
maybe? I can fix it during commit, how does Vincent format his name in
regular email? Does this look ok:

Vincent Fann <vincent_fann@realtek.com>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
