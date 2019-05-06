Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2182A14699
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfEFImN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 04:42:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfEFImM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 04:42:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EBB7C61157; Mon,  6 May 2019 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557132131;
        bh=U0HcKzTKhMJAx+L7DrntSHVJn8Uwl4RoExSSOsr90rA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LzTCcbmlUE/ubC1rumbvwkOkGg9dENA5ms3hX24F4AERKl+o2w31ByGKHjn+ThRR8
         k63Wj6bH5YHf6NwNs3ROVFYkxG7NAOLS/NtFBrHwvI/98L+N2o66LTVRUjQfHhRFZY
         /plx+IcESnNDnrK+rTBBF+yxCTajnFEFmcNxXASc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-65-53.rev.dnainternet.fi [37.136.65.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92E1B60DB3;
        Mon,  6 May 2019 08:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557132131;
        bh=U0HcKzTKhMJAx+L7DrntSHVJn8Uwl4RoExSSOsr90rA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LzTCcbmlUE/ubC1rumbvwkOkGg9dENA5ms3hX24F4AERKl+o2w31ByGKHjn+ThRR8
         k63Wj6bH5YHf6NwNs3ROVFYkxG7NAOLS/NtFBrHwvI/98L+N2o66LTVRUjQfHhRFZY
         /plx+IcESnNDnrK+rTBBF+yxCTajnFEFmcNxXASc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92E1B60DB3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Victor Bravo <1905@spmblk.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
References: <20190504162633.ldrz2nqfocg55grb@localhost>
        <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
        <20190504194440.4zcxjrtj2aft3ka4@localhost>
        <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <20190505150355.3fbng4ny34x255vk@localhost>
        <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
Date:   Mon, 06 May 2019 11:42:06 +0300
In-Reply-To: <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com> (Hans de
        Goede's message of "Mon, 6 May 2019 10:13:38 +0200")
Message-ID: <87o94gug81.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

>> @@ -99,6 +107,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
>>   	{}
>>   };
>>   +void brcmf_dmi_sanitize(char *dst, const unsigned char *allowed,
>> char safe)
>> +{
>> +	while (*dst) {
>> +		if ((*dst < 0) || !(allowed[*dst / 8] & (1 << (*dst % 8))))
>
> At a first look I have no clue what this code is doing and I honestly do not feel
> like figuring it out, this is clever, but IMHO not readable.
>
> Please just write this as if (*dst < 0x21 || (*dst > foo && < bar) || etc,
> so that a human can actually see in one look what the code is doing.

Is there an existing function for sanitising filenames so that we don't
need to reinvent the wheel, maybe something like isalnum()?

-- 
Kalle Valo
