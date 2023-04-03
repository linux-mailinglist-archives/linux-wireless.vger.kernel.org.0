Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCC6D41DB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjDCKVh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjDCKVX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6673C145
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0292FB816DD
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9B3C433EF;
        Mon,  3 Apr 2023 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680517278;
        bh=s2YhjxTN2V3yK/4iI2kJeZ9BLgbusGkKb1iLwAkBFZs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=k+jvY1rdK810Koj3JCD7tTLGGfvsoENH9bBfgi7ziDvY+hdE8/e3gduH08QCs8zw5
         Sze6aezIc5zcWwGzoH72jlQVjgaGnY9l2uViOBvrJqX58feROS4nxzp0iP5lnu3jy/
         zz2Ld1/6T1imYNnzcVgo8qj0jzycGMo/IsLeklNvN1jh78aFaXRjsSRtw4PbrBCPj0
         Nf9owLD3CiEX78JyKfJ1LoBBcH8nKtkucoKm1JDjni5/KZq9qTWBCommGcRsKFP+LO
         QOoCS6GoJkvk0G5AOAK3Qazin1qI96K2P01igOh+deAO9M3VOx9MT/beQYAIFTtAO9
         u+dePfn5m9RqQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Bernie Huang <phhuang@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: rtw88/rtw89: command/event structure handling
References: <20230310034631.45299-1-pkshih@realtek.com>
        <20230310034631.45299-2-pkshih@realtek.com>
        <87zg8emn4i.fsf@kernel.org>
        <e3670d1075f54c69ba3971067b3d06b7@realtek.com>
Date:   Mon, 03 Apr 2023 13:21:12 +0300
In-Reply-To: <e3670d1075f54c69ba3971067b3d06b7@realtek.com> (Ping-Ke Shih's
        message of "Wed, 15 Mar 2023 08:57:37 +0000")
Message-ID: <87a5zpb71j.fsf_-_@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(changing the subject and adding Arnd)

Ping-Ke Shih <pkshih@realtek.com> writes:

>> > @@ -3181,6 +3204,15 @@ static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
>> >  #define RTW89_GET_MAC_C2H_REV_ACK_H2C_SEQ(c2h) \
>> >       le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
>> >
>> > +#define RTW89_GET_MAC_BCNFLTR_RPT_MACID(c2h) \
>> > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 0))
>> > +#define RTW89_GET_MAC_BCNFLTR_RPT_TYPE(c2h) \
>> > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(9, 8))
>> > +#define RTW89_GET_MAC_BCNFLTR_RPT_EVENT(c2h) \
>> > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(11, 10))
>> > +#define RTW89_GET_MAC_BCNFLTR_RPT_MA(c2h) \
>> > +     le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
>> 
>> I have to admit that I every time I see this code pattern it makes me
>> regret it. Something like what Arnd proposed back in the day would look
>> so much cleaner:
>> 
>> https://lore.kernel.org/all/CAK8P3a1rsKZZKMKFTDWgE3usX9gYKJqUvTMxSdEuZrp8BaKdaA@mail.gmail.com/
>> 
>> Of course this is just a generic comment about rtw89, and has nothing to
>> do with this patchset, but it would be great if someone could take a
>> look and try out Arnd's proposal. It would be good to start with just
>> one or two commands and send that as an RFC to see how it looks like.
>> 
>
> I write a draft RFC here. Please see if it's in expectation. If so, I can
> change all of them by another patch or RFC.
>
> In header file:
>
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID_MASK GENMASK(7, 0)
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_TYPE_MASK GENMASK(9, 8)
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT_MASK GENMASK(11, 10)
> #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_MA_MASK GENMASK(23, 16)
>
>
> Access the values via le32_get_bits() in functions somewhere:
>
> 	const __le32 *c2h = skb->data;
>
> 	type =   le32_get_bits(c2h[2], RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID_MASK);
> 	sig = le32_get_bits(c2h[2],
> RTW89_C2H_MAC_BCNFLTR_RPT_W2_MA_MASK) - MAX_RSSI;
> 	event =  le32_get_bits(c2h[2], RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT_MASK);
> 	mac_id = le32_get_bits(c2h[2], RTW89_C2H_MAC_BCNFLTR_RPT_W2_MACID_MASK);

I was thinking more something towards Arnd's idea he suggests in [1].
Here's my proposal for the beacon filter command as pseudo code (so not
compiled and very much buggy!) from the patch[2] which started this
recent discussion.

So in the header file we would have something like this:

#define RTW89_C2H_BEACON_FILTER_WORD0_MACID_MASK GENMASK(7, 0)
#define RTW89_C2H_BEACON_FILTER_WORD0_TYPE_MASK GENMASK(9, 8)
#define RTW89_C2H_BEACON_FILTER_WORD0_EVENT_MASK GENMASK(11, 10)
#define RTW89_C2H_BEACON_FILTER_WORD0_MA_MASK GENMASK(23, 16)

struct rtw89_h2c_cfg_beacon_filter {
     __le32 word0;
}

static inline void rtw89_h2c_cfg_beacon_filter_set_word0(struct rtw89_h2c_cfg_beacon_filter *cmd,
        u32 macid, u32 type, u32 event_mask, u32 ma)

{
        le32_replace_bits(cmd->word0, macid, RTW89_C2H_BEACON_FILTER_WORD0_MACID_MASK);
        le32_replace_bits(cmd->word0, type, RTW89_C2H_BEACON_FILTER_WORD0_TYPE_MASK);
        le32_replace_bits(cmd->word0, event, RTW89_C2H_BEACON_FILTER_WORD0_EVENT_MASK);
        le32_replace_bits(cmd->word0, ma, RTW89_C2H_BEACON_FILTER_WORD0_MA_MASK);
}

static inline u32 rtw89_h2c_cfg_beacon_filter_get_mac_id(const struct rtw89_h2c_cfg_beacon_filter *cmd)
{
        return le32_get_bits(cmd->word0, RTW89_C2H_BEACON_FILTER_WORD0_MACID_MASK);
}

And an example how to use these:

struct rtw89_h2c_cfg_beacon_filter *cmd;

skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, sizeof(*cmd));
cmd = (struct rtw89_h2c_cfg_beacon_filter *)skb->data;
rtw89_h2c_cfg_beacon_filter_set_word0(cmd, 1, 2, 0, 0);

I'm sure this is very buggy and I'm missing a lot but I hope you get the
idea anyway. My keypoints here are:

* there's a clear struct for the command (an "object" from OOP point of
  view), something like "__le32 *c2h" is very confusing
* no casting
* no pointer arithmetic
* you get length with a simple "sizeof(*cmd)"

Downside of course is that there's quite a lot of boilerplate code but I
still consider that positives outweight the negatives. Thoughts?

And I'll emphasise that this is not a blocker for anything but it would
be nice to clean this up both in rtw88 and rtw89 at some point, if we
can.

[1] https://lore.kernel.org/all/CAK8P3a1rsKZZKMKFTDWgE3usX9gYKJqUvTMxSdEuZrp8BaKdaA@mail.gmail.com/

[2] https://patchwork.kernel.org/project/linux-wireless/patch/20230310034631.45299-2-pkshih@realtek.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
