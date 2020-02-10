Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10089157B93
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgBJNbC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 08:31:02 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:14749 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727755AbgBJNbB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 08:31:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581341461; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hs8RL5kGM5mjbd5UTslrOKZYxO/QqrUB5kXqpBmMwD8=; b=iThmZ1EXaCOXaLJnqZ8zBDB9/ZEymaqt8EQgKlm7t6bKFQyuDv3hXyJb1zJv8lZE2G4ndL5A
 n8/mpsSiZwQLj62NIHKz4Gx1E++Sv598qeyfXhX2RJfHr4RVD3XldWKaGyMX7qaYogz3VoQr
 Fq7V8B6jxCiSG4bmQFLoun5ZdYw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e415b10.7fdd1c17e228-smtp-out-n02;
 Mon, 10 Feb 2020 13:30:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B15CC447A4; Mon, 10 Feb 2020 13:30:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A78AC4479C;
        Mon, 10 Feb 2020 13:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A78AC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt76u: extend RX scatter gather number
References: <42e3b88414f473af278b4584b2f1d76b06ddd82a.1581328358.git.lorenzo@kernel.org>
Date:   Mon, 10 Feb 2020 15:30:50 +0200
In-Reply-To: <42e3b88414f473af278b4584b2f1d76b06ddd82a.1581328358.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Mon, 10 Feb 2020 11:34:00 +0100")
Message-ID: <87pnemwovp.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> From: Sean Wang <sean.wang@mediatek.com>
>
> From: Sean Wang <sean.wang@mediatek.com>

The From line is twice.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
