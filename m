Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8B6136903
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 09:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgAJIab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 03:30:31 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:46513 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbgAJIaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 03:30:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578645030; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=2DZ4v+XK739afF/G4MQW75B40MZvuHhsJd5wQ5Cgy94=; b=j1ks61ZwqciW9HeuQkCadX8HNIYttBgEcJpjSp8TSivaRSXV9a0T9nO/afPG9vJZ7eVfKZdE
 1FyyUcHAFzqVtkZwgb7IwHGe2zyrjX10GXI7P4SK0cLJAw2n93p3DjLgEaun1X01Z7ZS1Q56
 sG4EYqJohdLTUdbP9dv7v8gjq6U=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e18361f.7f3f218af8b8-smtp-out-n02;
 Fri, 10 Jan 2020 08:30:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A699C4479F; Fri, 10 Jan 2020 08:30:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 510A9C433A2;
        Fri, 10 Jan 2020 08:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 510A9C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Denis Kalashnikov <denis281089@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [RESEND] ath9k: fix firmware bug in some of Mikrotik R11e-2HPnD cards
References: <20191227100115.6870-1-denis281089@gmail.com>
Date:   Fri, 10 Jan 2020 10:30:19 +0200
In-Reply-To: <20191227100115.6870-1-denis281089@gmail.com> (Denis
        Kalashnikov's message of "Fri, 27 Dec 2019 13:01:15 +0300")
Message-ID: <87r207soh0.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Denis Kalashnikov <denis281089@gmail.com> writes:

> Sorry, first I sent the patch through a Gmail web interface, and spaces
> were broken.
> ---
>
> Some of the Mikrotik R11e-2HPnD cards have EEPROM where is
> flashed that a card has 3 chains, but actually all this cards
> have only 2. This leads ath9k to write periodically into the logs:
> 'ath: phy0: Unable to reset channel, reset status -5' and
> stations don't see that AP.
>
> Mikrotik R11e-2HPnD is based on AR9582 chip.
>
> Signed-off-by: Denis Kalashnikov <denis281089@gmail.com>
> ---

Add any comments after this "---" line, more info in the link below.
Please fix that and send v3.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
