Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53BD7B56
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfJOQYi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 12:24:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJOQYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 12:24:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D622C60BEA; Tue, 15 Oct 2019 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571156677;
        bh=TLXzKaLgAlXy4RnEdq1+kK9xYyxZfCis3fJ9E8UWSc4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=A5tX6D+sC/m1Fgcjf5DxqWmh6cSVveSWyx+6t0/zQt6/aCvWMtYftGFLwOMhN0tde
         Ekj6sXb8306mlZRDxnEspKj9uRYDnEVPkO+R4g3AM/+gg6p5NHWAM1SuJOoD9Y5usd
         g4FqS2s9WNtToslBvLwWDS4UXxyPNLqHgP3Bkcpo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-79-201-nat.elisa-mobile.fi [85.76.79.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2755260BEA;
        Tue, 15 Oct 2019 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571156675;
        bh=TLXzKaLgAlXy4RnEdq1+kK9xYyxZfCis3fJ9E8UWSc4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mMPeemZpQQq6uVOxx8hGlc3an876I99Rp8OAasBUM3ZLKhc/Rskb95EK03asp2hl3
         XQ/MaPJrcEQr/MwdG3sLRMQ2N1LCGUNKyRCMhoVF5bjSxhClGDNC0/HJ9botmw1s9+
         Wc0JNS/a3PJuM5Z4aAbwDIhj9O3dpo/KFmznxpeQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2755260BEA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 08/49] ath11k: add core.c
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
        <1566316095-27507-9-git-send-email-kvalo@codeaurora.org>
        <0c526ce00e6e1c7731c990515e7438230efb55af.camel@sipsolutions.net>
Date:   Tue, 15 Oct 2019 19:24:29 +0300
In-Reply-To: <0c526ce00e6e1c7731c990515e7438230efb55af.camel@sipsolutions.net>
        (Johannes Berg's message of "Tue, 20 Aug 2019 22:32:45 +0200")
Message-ID: <87h84am0xu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

>> +module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
>> +
>> +MODULE_PARM_DESC(debug_mask, "Debugging mask");
>> +
>> +static const struct ath11k_hw_params ath11k_hw_params = {
>> +			.name = "ipq8074",
>
> indentation here seems a bit too much

I'll fix that. I'll also group the module parameter macros above next to
each other.

>> +MODULE_LICENSE("Dual BSD/GPL");
>
> All your files state "ISC", shouldn't that be reflected here?

AFAIK MODULE_LICENSE() macro does not support ISC. AFAIK this is what
all ISC wireless drivers have.

Related to this, we now changed the license in ath11k to
BSD-3-Clause-Clear.

-- 
Kalle Valo
