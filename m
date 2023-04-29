Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCA6F2514
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjD2Om5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Apr 2023 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjD2Omz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Apr 2023 10:42:55 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708D21737
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 07:42:54 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7C045A80068;
        Sat, 29 Apr 2023 14:42:52 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B1C8813C2B0;
        Sat, 29 Apr 2023 07:42:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B1C8813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682779371;
        bh=4UarVyRhic768HrhGCVRtTFGaQ5g8iTg+aVt5RhViQY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GEd5FDyQnlwSNYudKvoZUG/PzGsPDjAEj2pEniZL3RlOZMa1dAQ/BD0p+I4ywwmf5
         dt7mqk95c0WfnmKDKV2/y1HZRwQ/wF03aGgqS5PtaAQvcaJdnO+9KN7cnXfyFy8wKu
         bi50r/zEGc+5LfsQSC6/CyCjJ6ANYtYJzKqjjVzk=
Subject: Re: [PATCH 5/6] wifi: mt76: mt7915: Improve monitor-mode flags
 settings.
To:     Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20230428205000.2647945-1-greearb@candelatech.com>
 <20230428205000.2647945-5-greearb@candelatech.com>
 <b57553ac83ab6ad3c6b998e99a2cd63eb3acfb24.camel@mediatek.com>
 <8d448f52-01f6-6a5a-2599-b0539404b29e@candelatech.com>
 <0fdbb82a50d69e39f150d49d3003ab1087954e8b.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <ba94f448-d297-fc5c-0653-a3db877caf09@candelatech.com>
Date:   Sat, 29 Apr 2023 07:42:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0fdbb82a50d69e39f150d49d3003ab1087954e8b.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1682779373-4K943rfYwMpH
X-MDID-O: us5;ut7;1682779373;4K943rfYwMpH;<greearb@candelatech.com>;37a35c97fc9c1e05f76a159dc7b8fe99
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/28/23 7:33 PM, Ryder Lee wrote:
> On Fri, 2023-04-28 at 15:06 -0700, Ben Greear wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>> 
>> 
>> On 4/28/23 14:48, Ryder Lee wrote:
>> > On Fri, 2023-04-28 at 13:49 -0700, greearb@candelatech.com wrote:
>> > > External email : Please do not click links or open attachments
>> > > until
>> > > you have verified the sender or the content.
>> > > 
>> > > 
>> > > From: Ben Greear <greearb@candelatech.com>
>> > > 
>> > > This enables capturing more frames, and now when the rx5 group
>> > > option is also enabled for rx-status, wireshark shows HE-TRIG
>> > > as well as HE-MU frames.
>> > > 
>> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
>> > > ---
>> > >   .../net/wireless/mediatek/mt76/mt7915/main.c  | 26
>> > > +++++++++++++++++--
>> > >   .../net/wireless/mediatek/mt76/mt7915/regs.h  | 16 ++++++++++++
>> > >   2 files changed, 40 insertions(+), 2 deletions(-)
>> > > 
>> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
>> > > b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
>> > > index 64c14fc303a2..55aed3c6d3be 100644
>> > > --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
>> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
>> > > @@ -562,6 +562,12 @@ static void __mt7915_configure_filter(struct
>> > > ieee80211_hw *hw,
>> > >                          MT_WF_RFCR1_DROP_BF_POLL |
>> > >                          MT_WF_RFCR1_DROP_BA |
>> > >                          MT_WF_RFCR1_DROP_CFEND |
>> > > +                       MT_WF_RFCR1_DROP_PS_BFRPOL |
>> > > +                       MT_WF_RFCR1_DROP_PS_NDPA |
>> > > +                       MT_WF_RFCR1_DROP_NO2ME_TF |
>> > > +                       MT_WF_RFCR1_DROP_NON_MUBAR_TF |
>> > > +                       MT_WF_RFCR1_DROP_RXS_BRP |
>> > > +                       MT_WF_RFCR1_DROP_TF_BFRP |
>> > >                          MT_WF_RFCR1_DROP_CFACK;
>> > >          u32 flags = 0;
>> > >          bool is_promisc = *total_flags & FIF_CONTROL || phy-
>> > > > monitor_vif ||
>> > > 
>> > > @@ -587,7 +593,9 @@ static void __mt7915_configure_filter(struct
>> > > ieee80211_hw *hw,
>> > >                             MT_WF_RFCR_DROP_BCAST |
>> > >                             MT_WF_RFCR_DROP_DUPLICATE |
>> > >                             MT_WF_RFCR_DROP_A2_BSSID |
>> > > -                          MT_WF_RFCR_DROP_UNWANTED_CTL |
>> > > +                          MT_WF_RFCR_DROP_UNWANTED_CTL | /* 0
>> > > means
>> > > drop */
>> > > +                          MT_WF_RFCR_IND_FILTER_EN_OF_31_23_BIT
>> > > |
>> > > +                          MT_WF_RFCR_DROP_DIFFBSSIDMGT_CTRL |
>> > >                             MT_WF_RFCR_DROP_STBC_MULTI);
>> > > 
>> > >          phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
>> > > @@ -602,8 +610,22 @@ static void __mt7915_configure_filter(struct
>> > > ieee80211_hw *hw,
>> > >                               MT_WF_RFCR_DROP_RTS |
>> > >                               MT_WF_RFCR_DROP_CTL_RSV |
>> > >                               MT_WF_RFCR_DROP_NDPA);
>> > > -       if (is_promisc)
>> > > +       if (is_promisc) {
>> > >                  phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
>> > > +               phy->rxfilter |=
>> > > MT_WF_RFCR_IND_FILTER_EN_OF_31_23_BIT;
>> > > +               if (flags & FIF_CONTROL) {
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_DROP_UNWANTED_CTL; /* 1 means receive */
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_SECOND_BCN_EN;
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_RX_MGMT_FRAME_CTRL;
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_RX_SAMEBSSIDPRORESP_CTRL;
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_RX_DIFFBSSIDPRORESP_CTRL;
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_RX_SAMEBSSIDBCN_CTRL;
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_RX_SAMEBSSIDNULL_CTRL;
>> > > +                       phy->rxfilter |=
>> > > MT_WF_RFCR_RX_DIFFBSSIDNULL_CTRL;
>> > > +                       phy->rxfilter &=
>> > > ~(MT_WF_RFCR_DROP_DIFFBSSIDMGT_CTRL);
>> > 
>> > FIF_CONTROL: pass control frame. However, many of these are not
>> > control
>> > frames. I think we should move monitor dedicated misc parts to
>> > IEEE80211_CONF_CHANGE_MONITOR mt7915_set_monitor and leave this
>> > function as-is ... as my reply in [2/6].
>> 
>> My understanding is that the rxfilter and related phy fields should
>> take all settings and vdevs into account.
>> So if monitor mode is enabled, and another sta/ap vdev exists, and
>> someone takes any action that causes
>> the stack to call the set_filter() logic on the sta/vdev, then
>> set_filter must know about the monitor port to
>> do the right thing.  This is why mt7915_configure_filter should
>> handle everything and be aware of
>> monitor port existing or not.
>> 
> 
> This depends on what we end up doing with mixed modes. IMO, monitor
> mode should be in the driver's seat. Hence we set/clear phy->rxfilter
> or specific registers addtionally via IEEE80211_CONF_CHANGE_MONITOR as
> we alreay did for MT_WF_RFCR_DROP_OTHER_US, right?

My patch should make monitor mode work whether or not other vdevs are active
(and causing calls to set_filter logic after monitor mode was enabled).
And it puts the somewhat tricky filter and related register logic into a single location.

If we do not pay attention to monitor-mode in the set_filter, then it
will probably break in mixed vdev mode.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
