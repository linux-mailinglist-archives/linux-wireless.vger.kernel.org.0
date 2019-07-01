Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADCB5B873
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfGAJ5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 05:57:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41127 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727477AbfGAJ5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 05:57:05 -0400
X-UUID: f9cce9ae1a2e45219bad5b6a03308529-20190701
X-UUID: f9cce9ae1a2e45219bad5b6a03308529-20190701
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1222009649; Mon, 01 Jul 2019 17:57:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Jul 2019 17:57:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Jul 2019 17:57:01 +0800
Message-ID: <1561975021.3950.9.camel@mtkswgap22>
Subject: Re: [PATCH 4/6] mt76: mt7615: unlock dfs bands
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 1 Jul 2019 17:57:01 +0800
In-Reply-To: <87tvc69odh.fsf@kamboji.qca.qualcomm.com>
References: <cover.1561804422.git.lorenzo@kernel.org>
         <33184e0b78983fe7c79fa70c5fbb21042aafa4f5.1561804422.git.lorenzo@kernel.org>
         <87muhzs9qv.fsf@purkki.adurom.net>
         <CAJ0CqmU6TLhFa4ZJxWHBzvpx+5g5E4-WkSPECx47F9d3T=5YjQ@mail.gmail.com>
         <87tvc69odh.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: B8E13F6ECB07971D9ECC9794EB8A4BCC29604420E225EDAC327276D592B976E52000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-07-01 at 10:59 +0300, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> 
> >>
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>
> >> > Unlock dfs channels since now mt7615 driver supports radar detection
> >> >
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> > ---
> >> >  drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
> >> >  1 file changed, 6 insertions(+)
> >> >
> >> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> >> > index 5dc4cced5789..6d336d82cafe 100644
> >> > --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> >> > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> >> > @@ -152,6 +152,12 @@ static const struct ieee80211_iface_combination if_comb[] = {
> >> >               .max_interfaces = 4,
> >> >               .num_different_channels = 1,
> >> >               .beacon_int_infra_match = true,
> >> > +             .radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
> >> > +                                    BIT(NL80211_CHAN_WIDTH_20) |
> >> > +                                    BIT(NL80211_CHAN_WIDTH_40) |
> >> > +                                    BIT(NL80211_CHAN_WIDTH_80) |
> >> > +                                    BIT(NL80211_CHAN_WIDTH_160) |
> >> > +                                    BIT(NL80211_CHAN_WIDTH_80P80),
> >>
> >> Isn't it questionable to enable these without any testing on real
> >> hardware? Getting DFS to work correctly is hard so I'm very suspicious
> >> about this.
> >>
> >> --
> >> Kalle Valo
> >
> > Hi Kalle,
> >
> > unfortunately at the moment I am not able to run any tests with a real
> > signal generator so I just ported the code from vendor sdk.
> > I am pretty confident it works since the radar pattern detection is
> > done in fw/hw so I guess it has been already tested in the vendor sdk
> 
> DFS is really tricky to get it working right, so I'm not easily
> convinced :)
> 
> > but we can postpone this patch and apply just the rest of the series
> > until we have some test results.
> 
> Yeah, I think it would be best to drop this patch so that DFS is not
> enabled by default and apply this patch only after positive test
> results.
> 

That's why I suggested Lorenzo to add this one - "[6/6] mt76: mt7615:
add radar pattern test knob to debugfs"

We can feed radar pattern through debugfs to test if a pattern is
detected as radar pattern or not and verify the fw radar detection
algorithm.

In this format:
RadarPulsePattern="3680128-2-245;3683878-2-245;3687628-2-245;3691378-2-245;3695128-2-245;3698878-2-245;3702628-2-245;3706378-2-245;3710128-2-245;3713878-2-245"

As for testing it on 'real hardware' I need to take some other time to
borrow equipment.

Ryder

