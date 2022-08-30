Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656025A5B08
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 07:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiH3FSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 01:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3FSa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 01:18:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0629E10B
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 22:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C860B811B2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 05:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777AEC433C1;
        Tue, 30 Aug 2022 05:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661836707;
        bh=nCbPAjIAPqJ/YO8bszJdZw+GFvqrBlsOPZLW1wkqTSM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uE/1lkRXGNRVgC7IHZgu3JOGUEIOSiKMlKQftKurS/ae1KYsL4ANQU7EZV4vyImFt
         rtdZfh1NXQ3s7YgeJW2R6wXuH7D41GqpQk1HctTPUVszryY0IGkwm/DZUTQxwbPWc0
         tWsZh0qVCNT+aZns3puUaZyyfy+dvBRwVCreaDQrrzTey3CXVDhbEUvlrnMbmCSJoR
         4/KVp2pzYpfiVlCUPp6x54KeB34cuFBUU501RK1/M63YU91PpcDbO+QsS9LGFrMMtp
         PVkMp4f2wGJaoEDnYvW9d26qv1urcUC7CrCaRLtPUlajnjmbVc6Tf6PuA3PRQgnEyh
         69V9N37Evb3nA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        =?utf-8?B?U2VhbiBXYW5nICjnjos=?= =?utf-8?B?5b+X5LqYKQ==?= 
        <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren Wu <Deren.Wu@mediatek.com>,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        "moderated list\:ARM\/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 8/9] wifi: mt76: mt7921: introduce remain_on_channel support
References: <cover.1660606893.git.objelf@gmail.com>
        <f48a750e8ad17d5b2410eea03fc30a6403732168.1660606893.git.objelf@gmail.com>
        <YvyUwEdURYHiAduf@lore-desk>
        <CAGp9LzrvVQOrUNPR8aguUTgWo1wZFMR2Y3kdTk8WqxmG=B8--w@mail.gmail.com>
        <Yv3sqvhXnGiOpKkE@lore-desk>
        <CAGp9LzpjeKH2AHcDGjpeKb02fiE9yHD_p-T9oeY1HS-nDKcUNQ@mail.gmail.com>
Date:   Tue, 30 Aug 2022 08:18:19 +0300
In-Reply-To: <CAGp9LzpjeKH2AHcDGjpeKb02fiE9yHD_p-T9oeY1HS-nDKcUNQ@mail.gmail.com>
        (Sean Wang's message of "Wed, 24 Aug 2022 17:10:59 -0700")
Message-ID: <87k06qfgx0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sean Wang <sean.wang@kernel.org> writes:

>> > > > +static int mt7921_check_offload_capability(struct mt7921_dev *dev)
>> > > > +{
>> > > > +     struct ieee80211_hw *hw = mt76_hw(dev);
>> > > > +     int year, mon, day, hour, min, sec;
>> > > > +     struct wiphy *wiphy = hw->wiphy;
>> > > > +     bool fw_can_roc = false;
>> > > > +     int ret;
>> > > > +
>> > > > +     ret = sscanf(dev->mt76.hw->wiphy->fw_version + 11, "%4d%2d%2d%2d%2d%2d",
>> > > > +                  &year, &mon, &day, &hour, &min, &sec);
>> > >
>> > > does the fw have a differnt base version with respect to the previous ones?
>> > > checking the date is a bit ugly.
>> >
>> > I admitted that way was a bit ugly, but I have investigated for a
>> > while, and that is the only way we can use to distinguish the version
>> > in current mt7921 firmware.
>>
>> the fw seems pretty new (2022/7/15), is it already available in linux-firmware
>> git tree? If not I guess you can increment fw version in a more evident way.
>> For the future please remember to do it for major fw changes.
>
> The new FW is not released in linux-firmware. I will try to figure out
> a better way to recognize the FW can support the feature and add it in
> v2.

It would be a lot better and more future proof to use some kind feature
advertising instead of guessing from a firmware version. For example,
ath11k uses WMI service bits and other upstream drivers have something
similar.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
