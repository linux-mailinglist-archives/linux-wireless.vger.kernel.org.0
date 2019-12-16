Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3998412040F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 12:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfLPLgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 06:36:03 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:64131 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727265AbfLPLgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 06:36:03 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 06:36:01 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576496162; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=tJLXZyC37vyxc6Od1K7ezQ5nMKEs5qndAu5izHZMRrA=; b=e7yJ42R7hPTKuioqpplZxE64pnTQeDBmA0MLWB5DE3U9DxGvpEZEDZTdCMHLzglrBkPBFFxU
 s0EGpzgUjpIU1Q/0oQJ9Bs0KMKmk5xmfMBPOp1tkjIL4XtFM2WcrYlDg3htwSwNWViqwJci/
 sL0Of7WaAk7bKZwx8jX/jY7v8c8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df76aeb.7f39d2214c38-smtp-out-n01;
 Mon, 16 Dec 2019 11:30:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65F0EC433CB; Mon, 16 Dec 2019 11:30:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43664C43383;
        Mon, 16 Dec 2019 11:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43664C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 28/29] mt76: mt7615: add support for registering a second wiphy via debugfs
References: <20191130153045.28105-1-nbd@nbd.name>
        <20191130153045.28105-28-nbd@nbd.name>
Date:   Mon, 16 Dec 2019 13:30:48 +0200
In-Reply-To: <20191130153045.28105-28-nbd@nbd.name> (Felix Fietkau's message
        of "Sat, 30 Nov 2019 16:30:44 +0100")
Message-ID: <87k16w4idz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This is only used for testing for now. In the future it will be possible to
> enable the second PHY through an proper API via device tree
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

An example how to use the debugfs file would be nice.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
