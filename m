Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6964C5B637
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfGAH7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 03:59:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGAH7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 03:59:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 990596081E; Mon,  1 Jul 2019 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561967976;
        bh=b11qQbhk0zaXcTzfE7iWgOyP9U+ErvxrmUu8LjwJsvY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OtiMZckQUPJnaqKj2dSVHdXy9gHWDyOztey+QLDJyQjnBd7LkPCNwdCVwShF+YhrL
         Fnd4U3C5zsaM9tRf1All4UkKbODkDbfKIiak9xKqkcFWvXijLfBMNYWA1Rxzki8jsb
         fE1gla0KGhAci/BmFDN3fWafH+5lTmoBcy6caOug=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D25AF602F8;
        Mon,  1 Jul 2019 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561967974;
        bh=b11qQbhk0zaXcTzfE7iWgOyP9U+ErvxrmUu8LjwJsvY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=khq+4Dv/VdIZ/9ZdxLhqWclU4K0qdaYEERPyIU3nbP37saTrq3O9XY1FeXsoIjiZX
         W8ZZJF1km49Nl7lEx0bsD/bFRMcwEsa2UqeNT7CFdFIfgXa2yIid/7/Pylex2jfrY/
         ZvuE3Ff78sVsme1vFNVXtBmS3tZVTZRm+EoOmAg4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D25AF602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>
Subject: Re: [PATCH 4/6] mt76: mt7615: unlock dfs bands
References: <cover.1561804422.git.lorenzo@kernel.org>
        <33184e0b78983fe7c79fa70c5fbb21042aafa4f5.1561804422.git.lorenzo@kernel.org>
        <87muhzs9qv.fsf@purkki.adurom.net>
        <CAJ0CqmU6TLhFa4ZJxWHBzvpx+5g5E4-WkSPECx47F9d3T=5YjQ@mail.gmail.com>
Date:   Mon, 01 Jul 2019 10:59:22 +0300
In-Reply-To: <CAJ0CqmU6TLhFa4ZJxWHBzvpx+5g5E4-WkSPECx47F9d3T=5YjQ@mail.gmail.com>
        (Lorenzo Bianconi's message of "Sun, 30 Jun 2019 13:25:56 +0200")
Message-ID: <87tvc69odh.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>>
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>
>> > Unlock dfs channels since now mt7615 driver supports radar detection
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> >  drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
>> > index 5dc4cced5789..6d336d82cafe 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
>> > @@ -152,6 +152,12 @@ static const struct ieee80211_iface_combination if_comb[] = {
>> >               .max_interfaces = 4,
>> >               .num_different_channels = 1,
>> >               .beacon_int_infra_match = true,
>> > +             .radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
>> > +                                    BIT(NL80211_CHAN_WIDTH_20) |
>> > +                                    BIT(NL80211_CHAN_WIDTH_40) |
>> > +                                    BIT(NL80211_CHAN_WIDTH_80) |
>> > +                                    BIT(NL80211_CHAN_WIDTH_160) |
>> > +                                    BIT(NL80211_CHAN_WIDTH_80P80),
>>
>> Isn't it questionable to enable these without any testing on real
>> hardware? Getting DFS to work correctly is hard so I'm very suspicious
>> about this.
>>
>> --
>> Kalle Valo
>
> Hi Kalle,
>
> unfortunately at the moment I am not able to run any tests with a real
> signal generator so I just ported the code from vendor sdk.
> I am pretty confident it works since the radar pattern detection is
> done in fw/hw so I guess it has been already tested in the vendor sdk

DFS is really tricky to get it working right, so I'm not easily
convinced :)

> but we can postpone this patch and apply just the rest of the series
> until we have some test results.

Yeah, I think it would be best to drop this patch so that DFS is not
enabled by default and apply this patch only after positive test
results.

-- 
Kalle Valo
