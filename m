Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA0DD86E
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 13:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfJSLSr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 07:18:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfJSLSr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 07:18:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CE6C060D51; Sat, 19 Oct 2019 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571483926;
        bh=tzXbFW4kYaZiiNhGwwEw45iiXOQBfAG34KD6qlnzorw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=i7JTMK2Lfg2rU7cfv+QRTFLwwpwkWnsemr6tKK23V+pYNDHnbnhh6PXksiY5U/fTP
         Hl9E+AvKT69DQJZz5STnc5C3neSBlgVT5w/tU6TQAkkWW0xnpOyEga5fSq9shudKn/
         mkNal9TF5gEyLaA+3pKoZO+FevT41koCCep9QzFE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 121B360615;
        Sat, 19 Oct 2019 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571483926;
        bh=tzXbFW4kYaZiiNhGwwEw45iiXOQBfAG34KD6qlnzorw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=i7JTMK2Lfg2rU7cfv+QRTFLwwpwkWnsemr6tKK23V+pYNDHnbnhh6PXksiY5U/fTP
         Hl9E+AvKT69DQJZz5STnc5C3neSBlgVT5w/tU6TQAkkWW0xnpOyEga5fSq9shudKn/
         mkNal9TF5gEyLaA+3pKoZO+FevT41koCCep9QzFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 121B360615
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 5/6] rtw88: add set_bitrate_mask support
References: <20191016123301.2649-1-yhchuang@realtek.com>
        <20191016123301.2649-6-yhchuang@realtek.com>
        <CAB4CAwe-9Ne-cSJC45bpggBKCsJ_UDFuFdB3f-wf7+A=qVnKnw@mail.gmail.com>
Date:   Sat, 19 Oct 2019 14:18:42 +0300
In-Reply-To: <CAB4CAwe-9Ne-cSJC45bpggBKCsJ_UDFuFdB3f-wf7+A=qVnKnw@mail.gmail.com>
        (Chris Chiu's message of "Thu, 17 Oct 2019 18:25:46 +0800")
Message-ID: <87h845vv8t.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chris Chiu <chiu@endlessm.com> writes:

> On Wed, Oct 16, 2019 at 8:33 PM <yhchuang@realtek.com> wrote:
>>
>> From: Tzu-En Huang <tehuang@realtek.com>
>>
>
>> +
>> +       band = hal->current_band_type;
>> +       if (band == RTW_BAND_2G) {
>> +               band = NL80211_BAND_2GHZ;
>> +               cfg_mask = mask->control[band].legacy;
>> +       } else if (band == RTW_BAND_5G) {
>> +               band = NL80211_BAND_5GHZ;
>> +               cfg_mask = mask->control[band].legacy << 4;
>> +       }
>> +
>> +       if (!is_vht_enable) {
>> +               if (ra_mask & RA_MASK_HT_RATES_1SS)
>> +                       cfg_mask |= mask->control[band].ht_mcs[0] << 12;
>> +               if (ra_mask & RA_MASK_HT_RATES_2SS)
>> +                       cfg_mask |= mask->control[band].ht_mcs[1] << 20;
>> +       } else {
>> +               if (ra_mask & RA_MASK_VHT_RATES_1SS)
>> +                       cfg_mask |= mask->control[band].vht_mcs[0] << 12;
>> +               if (ra_mask & RA_MASK_VHT_RATES_2SS)
>> +                       cfg_mask |= mask->control[band].vht_mcs[1] << 22;
>> +       }
>> +
>> +       ra_mask &= cfg_mask;
>> +
>> +       return ra_mask;
>> +}
>> +
>
> I believe you can replace the 4, 12, 20, 22 with a more descriptive macro.

Good point. GENMASK() and FIELD_PREP() are my favourites. Or maybe
u64_encode_bits() is actually better than FIELD_PREP(), as cfg_mask is
u64?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
