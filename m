Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BABA2F686
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 06:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfE3E46 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 00:56:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51672 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfE3E45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 00:56:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 41D4460A00; Thu, 30 May 2019 04:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559192217;
        bh=HzjoCcQKElgW5yawy9MIbUKp4D4xCMIcf8BixISztcs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QFR54PCTm4J7TLMW0iFACyrmqQhyN/4tb7iMpG+u8kEWBrOgYI/okbFnY5yveNGQa
         +dyd/xrMnMVcIrgkumTHkacNX9JM9QZLhi6iNk8fJnyGerGegbNiVDLTACwph1Fro7
         fm4yTZ8nMmHOt7Af1uEppt8nnThvUdHKVrLwitB0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 557F6604D4;
        Thu, 30 May 2019 04:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559192216;
        bh=HzjoCcQKElgW5yawy9MIbUKp4D4xCMIcf8BixISztcs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JD5wbx4k2uQcsUNV/1vgILMgdoGGespvwZH2C8Ej/XTaL60Il8rMNhCKt1MfGpFJ5
         qu9bES6rgagQ7uQ72rzKgwdI+lXF5Ef6Ux+FyOWaGro6htSdRnca1bpAeIUuT5+Cda
         sqJc3Iu2nZ+r/JqgFBxUrQBHTWX2xSQLzSXLTOvE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 557F6604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: Re: [PATCH wireless-drivers] mt76: usb: fix buffer allocation for scatter-gather capable devices
References: <f1f5b9f564e374174a9a2bbae29f4b72fd4c6ddd.1559163190.git.lorenzo@kernel.org>
Date:   Thu, 30 May 2019 07:56:52 +0300
In-Reply-To: <f1f5b9f564e374174a9a2bbae29f4b72fd4c6ddd.1559163190.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Wed, 29 May 2019 23:01:49 +0200")
Message-ID: <87zhn4pmjv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Partially revert commit f8f527b16db5 ("mt76: usb: use EP max packet
> aligned buffer sizes for rx") since it breaks A-MSDU support.
> When A-MSDU is enable the device can receive frames up to
> q->buf_size but they will be discarded in mt76u_process_rx_entry
> since there is no enough room for skb_shared_info.
> Fix it by introducing q->data_size and take info account
> skb_shared_info size in q->buf_size
> Moreover increase buffer size even for legacy mode (scatter-gather not
> available)
>
> Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes for rx")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Felix, can I take this directly to wireless-drivers?

-- 
Kalle Valo
