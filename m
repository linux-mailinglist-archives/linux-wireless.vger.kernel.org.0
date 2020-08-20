Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC83F24B87B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgHTLWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgHTLWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 07:22:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911DC061385
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 04:22:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so2012352ejb.11
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fucvxq1X+AGq1qAam4ZQTSfQJpTsM03NgpoLA8DvO2E=;
        b=wBNd+ryHyK3HNbbCB3Wq0ljqx8x17wFo1uEBrLlRDLvOEKmVorRguKU8IpiqohkDrj
         n4g6bIyfRdOMm3FgSxjsULGrjtlI1QnG0QcKzyFhmgfNQvCNnQlWlsQGqF3U4knAjHut
         1J942E92U8bAruaBSZJUfSHFzWOXKSHfgNQ9vjoyCPHPFgevZVs/tRD99WkRFsbPFmKm
         wndAawIe+Nv6BtK0VNEGeazFHaJ9vQYayaod15lVLdxU/zuMSoi0xw0dzsroh0uWELy7
         m7AOdUkACzAi4oJrnnDgq7y1058VU6vC1hwMRk45Y1XpSNM1XLOLj0XPnKTB/HLQtAD/
         Hr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fucvxq1X+AGq1qAam4ZQTSfQJpTsM03NgpoLA8DvO2E=;
        b=NReX1oC/LNqVzEUUnDZ1PSwYtNHej8jEvt3HY3Xs9p+r+rEeQXt1OpoqUU61iIfOmO
         1I47FE5yfGi47t86/I4Q3KVCU96h2e0DmGULxi+r55j5Cv41ssXKNP6qAXeQwDGYU8EB
         NXm4MNaWF28jcFA4Q4bH5knBcpaJAMPZGNP9jI85XCeVJCoAjuXQyIChun5UjskBWR42
         m5zQpgg3iapqCrIBr+tOtcKxqN3j3ef4dC1dsdhtSa/IGOhj70/gPIqvWq+7ZcOJl7JW
         t1eJKxvwQPafWgztH4DDBQ5ClQSEzQyprDr1D1iIOQrnIBpiJEHa7v13DwoJqEf2Zjng
         LkhQ==
X-Gm-Message-State: AOAM533n2DjtKsCFq/Hw1Uud1GQB22N4gT0mCqTXDSkJdGF2ixPbAJHY
        7ftasmMXkwgm6kbg8ZbVo8VzBpZvJQxGQQHSAd6YIw==
X-Google-Smtp-Source: ABdhPJwEbGkgxl6/FudtjCrh9TU/oVGkYWCivbhATuHRftS+6uQCZ4SHtwgPtykEez4GwTTDqS9bkOHPG0/EtvkIYjI=
X-Received: by 2002:a17:906:c310:: with SMTP id s16mr2777915ejz.466.1597922532285;
 Thu, 20 Aug 2020 04:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <1597680075-18723-1-git-send-email-loic.poulain@linaro.org>
 <87pn7ojx8g.fsf@codeaurora.org> <CAMZdPi9sQ2BM4G2cSKNfE06fOtvOtgb+ELqAkxUJdtLbuoeYzQ@mail.gmail.com>
 <9ff7836b-2d84-91bc-0691-f8696541ffc2@nexus-software.ie> <CAMZdPi9MN=pJ_j0py4egeR=HM2d=T+h8JXgH=WiN1PpnbTX3qg@mail.gmail.com>
 <bec1a210-1bfc-8d80-d2a0-41b6be7f807a@linaro.org> <494f0978-7380-e2f5-3224-0131d9bd0935@linaro.org>
In-Reply-To: <494f0978-7380-e2f5-3224-0131d9bd0935@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 20 Aug 2020 13:27:12 +0200
Message-ID: <CAMZdPi-a_YM4oSv42Rx4gY2fRRTw160bCDZ6zC_er9qz0LYh1g@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Fix software-driven scan
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HI Bryan,

On Thu, 20 Aug 2020 at 01:54, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 19/08/2020 11:52, Bryan O'Donoghue wrote:
> > On 19/08/2020 09:15, Loic Poulain wrote:
> >> Hi Bryan,
> >>
> >> On Tue, 18 Aug 2020 at 20:00, Bryan O'Donoghue
> >> <pure.logic@nexus-software.ie> wrote:
> >>>
> >>> On 18/08/2020 14:34, Loic Poulain wrote:
> >>>> On Tue, 18 Aug 2020 at 08:15, Kalle Valo <kvalo@codeaurora.org> wrote:
> >>>>>
> >>>>> Loic Poulain <loic.poulain@linaro.org> writes:
> >>>>>
> >>>>>> For software-driven scan, rely on mac80211 software scan instead
> >>>>>> of internal driver implementation. The internal implementation
> >>>>>> cause connection trouble since it keep the antenna busy during
> >>>>>> the entire scan duration, moreover it's only a passive scanning
> >>>>>> (no probe request). Therefore, let mac80211 manages sw scan.
> >>>>>>
> >>>>>> Note: we fallback to software scan if firmware does not report
> >>>>>> scan offload support or if we need to scan the 5Ghz band (currently
> >>>>>> not supported by the offload scan...).
> >>>>>>
> >>>>>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> >>>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >>>>>
> >>>>> What changed since v2? Please always include a changelog so that I
> >>>>> don't
> >>>>> need to guess what you have changed in the patch. No need to resend, a
> >>>>> reply is enough.
> >>>>
> >>>> Yes sorry, this patch has been rebased on ath master and squashed with
> >>>> Bryan's fix:
> >>>>        wcn36xx: Set sw-scan chan to 0 when not associated
> >>>> No additional changes have been made on top of the initial patches.
> >>>>
> >>>> Regards,
> >>>> Loic
> >>>>
> >>>
> >>> This is excruciatingly slow on Android.
> >>>
> >>> Android I'm finding unlike Debian where this stuff was tested, merrily
> >>> issues scan requests every 30 seconds.
> >>>
> >>> For me this ends up looking like this
> >>>
> >>> [  162.296995] wcn36xx: mac config changed 0x00000040
> >>> [  162.297001] wcn36xx: wcn36xx_config channel switch=1
> >>> [  162.297005] wcn36xx: hal init scan mode 2
> >>> [  177.492402] wcn36xx: mac config changed 0x00000040
> >>> [  177.492409] wcn36xx: wcn36xx_config channel switch=40
> >>> [  177.492413] wcn36xx: hal finish scan mode 2
> >>>
> >>> Basically it takes 15 seconds to complete.
> >>>
> >>> Interleaved scan seems very slow and is IMO unusable on Android
> >>
> >>
> >> The software scan is driven by mac80211 which interleaves channels
> >> scanning
> >> with the regular data operations. In worst case, it scans during 111ms
> >> on the
> >> channel and switches back to the operating channel for 200ms.
> >> So, with 35 channels to scan that would take about 11 seconds to
> >> complete...
> >> So yes, it's quite slow...
> >
> > Yes looks a scheduling thing in mac80211.
> >
> >> However, one remaining
> >> thing to try would be to send an update-channel-list command to the
> >> firmware before each offload scan (cf UPDATE_CHANNEL_LIST_REQ
> >> in the downstream driver). That's not something I've tried yet.
> >
> > I've tried
> >
> > 1. Setting the operating frequency to a 5ghz band before the scan
> > 2. Updating the channel list with 2g/5g channels via
> > UPDATE_CHANNEL_LIST_REQ
> > 3. Updating the channel list with 5g only with UPDATE_CHANNEL_LIST_REQ
> > 4. Doing 5g channels only in the channel list of
> > WCN36XX_HAL_START_SCAN_OFFLOAD_REQ
> >
> > I don't think the channel list matters, if I recall rightly I've also
> > tried leaving out the channel list in WCN36XX_HAL_START_SCAN_OFFLOAD_REQ
> > and get back the same set of channels in the result
> >
> > I guess we should take this patch anyway, since it makes wcn36xx and
> > mac80211 agree on ownership of the antenna...
> >
> > ---
> > bod
>
> Ah.
>
> If we implement ops->flush() we can slash that idle time down significantly
>
> static void ieee80211_scan_state_resume(struct ieee80211_local *local,
>                                          unsigned long *next_delay)
> {
>
>          if (local->ops->flush) {
>                  ieee80211_flush_queues(local, NULL, false);
>                  *next_delay = 0;
>          } else
>                  *next_delay = HZ / 10;
> }
>
> Trivial hack example:
>
> +void wcn36xx_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +                  u32 queues, bool drop)
> +{
> +}
> +
>   static const struct ieee80211_ops wcn36xx_ops = {
>          .start                  = wcn36xx_start,
>          .stop                   = wcn36xx_stop,
> @@ -1187,7 +1192,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
>          .sta_add                = wcn36xx_sta_add,
>          .sta_remove             = wcn36xx_sta_remove,
>          .ampdu_action           = wcn36xx_ampdu_action,
> -
> +       .flush                  = wcn36xx_flush,
>          CFG80211_TESTMODE_CMD(wcn36xx_tm_cmd)
>   };

Interestingly, we could indeed get rid of this extra 100ms.
Maybe a way to implement this would be to wait for the TX
ring to be empty in dxe.

> That ~ 20 seconds is cut to just 4 ! Which to be fair seems to be the
> kind of time it took to do the old version of the software scan.

Sure but In the below case, it seems scan occurs while you're not
connected to an AP, which prevents interleaving of operating channel.
The same scan while connected should be longer.

> [  869.625922] wcn36xx: mac config changed 0x00000040
> [  869.625930] wcn36xx: wcn36xx_config channel switch=1
> [  869.625938] wcn36xx: hal init scan mode 2
> [  869.628080] wcn36xx: SMD command (req 4, rsp 5) completed in 4ms
> [  869.628103] wcn36xx: hal start scan channel 1
> [  869.633985] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  869.694216] wcn36xx: mac config changed 0x00000040
> [  869.694233] wcn36xx: wcn36xx_config channel switch=2
> [  869.694240] wcn36xx: hal init scan mode 2
> [  869.695465] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  869.695472] wcn36xx: hal start scan channel 2
> [  869.700504] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  869.762229] wcn36xx: mac config changed 0x00000040
> [  869.762247] wcn36xx: wcn36xx_config channel switch=3
> [  869.762252] wcn36xx: hal init scan mode 2
> [  869.763425] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  869.763431] wcn36xx: hal start scan channel 3
> [  869.768356] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  869.830220] wcn36xx: mac config changed 0x00000040
> [  869.830237] wcn36xx: wcn36xx_config channel switch=4
> [  869.830242] wcn36xx: hal init scan mode 2
> [  869.831435] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  869.831441] wcn36xx: hal start scan channel 4
> [  869.836358] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  869.898218] wcn36xx: mac config changed 0x00000040
> [  869.898232] wcn36xx: wcn36xx_config channel switch=5
> [  869.898237] wcn36xx: hal init scan mode 2
> [  869.899401] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  869.899406] wcn36xx: hal start scan channel 5
> [  869.904244] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  869.966234] wcn36xx: mac config changed 0x00000040
> [  869.966248] wcn36xx: wcn36xx_config channel switch=6
> [  869.966256] wcn36xx: hal init scan mode 2
> [  869.967417] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  869.967423] wcn36xx: hal start scan channel 6
> [  869.972551] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.034227] wcn36xx: mac config changed 0x00000040
> [  870.034242] wcn36xx: wcn36xx_config channel switch=7
> [  870.034248] wcn36xx: hal init scan mode 2
> [  870.035426] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.035431] wcn36xx: hal start scan channel 7
> [  870.040348] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.102225] wcn36xx: mac config changed 0x00000040
> [  870.102240] wcn36xx: wcn36xx_config channel switch=8
> [  870.102246] wcn36xx: hal init scan mode 2
> [  870.103425] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.103430] wcn36xx: hal start scan channel 8
> [  870.108288] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.170241] wcn36xx: mac config changed 0x00000040
> [  870.170253] wcn36xx: wcn36xx_config channel switch=9
> [  870.170258] wcn36xx: hal init scan mode 2
> [  870.171801] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.171806] wcn36xx: hal start scan channel 9
> [  870.176850] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.238228] wcn36xx: mac config changed 0x00000040
> [  870.238245] wcn36xx: wcn36xx_config channel switch=10
> [  870.238252] wcn36xx: hal init scan mode 2
> [  870.239430] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.239435] wcn36xx: hal start scan channel 10
> [  870.244371] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.306231] wcn36xx: mac config changed 0x00000040
> [  870.306244] wcn36xx: wcn36xx_config channel switch=11
> [  870.306250] wcn36xx: hal init scan mode 2
> [  870.307409] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.307414] wcn36xx: hal start scan channel 11
> [  870.312317] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.374252] wcn36xx: mac config changed 0x00000040
> [  870.374265] wcn36xx: wcn36xx_config channel switch=12
> [  870.374270] wcn36xx: hal init scan mode 2
> [  870.375476] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.375481] wcn36xx: hal start scan channel 12
> [  870.380445] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.490250] wcn36xx: mac config changed 0x00000040
> [  870.490265] wcn36xx: wcn36xx_config channel switch=13
> [  870.490271] wcn36xx: hal init scan mode 2
> [  870.491464] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.491470] wcn36xx: hal start scan channel 13
> [  870.496469] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.606269] wcn36xx: mac config changed 0x00000040
> [  870.606280] wcn36xx: wcn36xx_config channel switch=14
> [  870.606286] wcn36xx: hal init scan mode 2
> [  870.607451] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.607457] wcn36xx: hal start scan channel 14
> [  870.612376] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.722256] wcn36xx: mac config changed 0x00000040
> [  870.722273] wcn36xx: wcn36xx_config channel switch=36
> [  870.722278] wcn36xx: hal init scan mode 2
> [  870.723462] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.723468] wcn36xx: hal start scan channel 36
> [  870.729088] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.838293] wcn36xx: mac config changed 0x00000040
> [  870.838320] wcn36xx: wcn36xx_config channel switch=40
> [  870.838328] wcn36xx: hal init scan mode 2
> [  870.839584] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.839593] wcn36xx: hal start scan channel 40
> [  870.844505] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  870.954291] wcn36xx: mac config changed 0x00000040
> [  870.954313] wcn36xx: wcn36xx_config channel switch=44
> [  870.954321] wcn36xx: hal init scan mode 2
> [  870.955544] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  870.955552] wcn36xx: hal start scan channel 44
> [  870.960510] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.070288] wcn36xx: mac config changed 0x00000040
> [  871.070312] wcn36xx: wcn36xx_config channel switch=48
> [  871.070321] wcn36xx: hal init scan mode 2
> [  871.071546] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.071553] wcn36xx: hal start scan channel 48
> [  871.076610] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.186286] wcn36xx: mac config changed 0x00000040
> [  871.186299] wcn36xx: wcn36xx_config channel switch=52
> [  871.186306] wcn36xx: hal init scan mode 2
> [  871.187547] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.187553] wcn36xx: hal start scan channel 52
> [  871.192430] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.302301] wcn36xx: mac config changed 0x00000040
> [  871.302316] wcn36xx: wcn36xx_config channel switch=56
> [  871.302322] wcn36xx: hal init scan mode 2
> [  871.303526] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.303532] wcn36xx: hal start scan channel 56
> [  871.308372] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.418292] wcn36xx: mac config changed 0x00000040
> [  871.418303] wcn36xx: wcn36xx_config channel switch=60
> [  871.418308] wcn36xx: hal init scan mode 2
> [  871.419511] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.419517] wcn36xx: hal start scan channel 60
> [  871.424368] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.534320] wcn36xx: mac config changed 0x00000040
> [  871.534335] wcn36xx: wcn36xx_config channel switch=64
> [  871.534341] wcn36xx: hal init scan mode 2
> [  871.535526] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.535532] wcn36xx: hal start scan channel 64
> [  871.540434] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.650286] wcn36xx: mac config changed 0x00000040
> [  871.650299] wcn36xx: wcn36xx_config channel switch=100
> [  871.650306] wcn36xx: hal init scan mode 2
> [  871.651480] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.651486] wcn36xx: hal start scan channel 100
> [  871.656365] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.766292] wcn36xx: mac config changed 0x00000040
> [  871.766305] wcn36xx: wcn36xx_config channel switch=104
> [  871.766311] wcn36xx: hal init scan mode 2
> [  871.767516] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.767522] wcn36xx: hal start scan channel 104
> [  871.772388] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.882301] wcn36xx: mac config changed 0x00000040
> [  871.882313] wcn36xx: wcn36xx_config channel switch=108
> [  871.882319] wcn36xx: hal init scan mode 2
> [  871.883488] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.883493] wcn36xx: hal start scan channel 108
> [  871.888315] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  871.998313] wcn36xx: mac config changed 0x00000040
> [  871.998326] wcn36xx: wcn36xx_config channel switch=112
> [  871.998335] wcn36xx: hal init scan mode 2
> [  871.999509] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  871.999514] wcn36xx: hal start scan channel 112
> [  872.004329] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.114319] wcn36xx: mac config changed 0x00000040
> [  872.114334] wcn36xx: wcn36xx_config channel switch=116
> [  872.114340] wcn36xx: hal init scan mode 2
> [  872.115511] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.115516] wcn36xx: hal start scan channel 116
> [  872.120361] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.230319] wcn36xx: mac config changed 0x00000040
> [  872.230330] wcn36xx: wcn36xx_config channel switch=120
> [  872.230337] wcn36xx: hal init scan mode 2
> [  872.231539] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.231545] wcn36xx: hal start scan channel 120
> [  872.236431] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.346316] wcn36xx: mac config changed 0x00000040
> [  872.346330] wcn36xx: wcn36xx_config channel switch=124
> [  872.346336] wcn36xx: hal init scan mode 2
> [  872.347521] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.347526] wcn36xx: hal start scan channel 124
> [  872.352380] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.462328] wcn36xx: mac config changed 0x00000040
> [  872.462343] wcn36xx: wcn36xx_config channel switch=128
> [  872.462349] wcn36xx: hal init scan mode 2
> [  872.463527] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.463534] wcn36xx: hal start scan channel 128
> [  872.468355] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.578340] wcn36xx: mac config changed 0x00000040
> [  872.578349] wcn36xx: wcn36xx_config channel switch=132
> [  872.578354] wcn36xx: hal init scan mode 2
> [  872.579558] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.579565] wcn36xx: hal start scan channel 132
> [  872.584405] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.694321] wcn36xx: mac config changed 0x00000040
> [  872.694337] wcn36xx: wcn36xx_config channel switch=140
> [  872.694343] wcn36xx: hal init scan mode 2
> [  872.695500] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.695506] wcn36xx: hal start scan channel 140
> [  872.700290] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.810339] wcn36xx: mac config changed 0x00000040
> [  872.810351] wcn36xx: wcn36xx_config channel switch=149
> [  872.810357] wcn36xx: hal init scan mode 2
> [  872.811528] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.811535] wcn36xx: hal start scan channel 149
> [  872.816424] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  872.926347] wcn36xx: mac config changed 0x00000040
> [  872.926359] wcn36xx: wcn36xx_config channel switch=153
> [  872.926366] wcn36xx: hal init scan mode 2
> [  872.927525] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  872.927531] wcn36xx: hal start scan channel 153
> [  872.932361] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  873.042347] wcn36xx: mac config changed 0x00000040
> [  873.042359] wcn36xx: wcn36xx_config channel switch=157
> [  873.042366] wcn36xx: hal init scan mode 2
> [  873.043531] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  873.043536] wcn36xx: hal start scan channel 157
> [  873.048367] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  873.158352] wcn36xx: mac config changed 0x00000040
> [  873.158366] wcn36xx: wcn36xx_config channel switch=161
> [  873.158373] wcn36xx: hal init scan mode 2
> [  873.159550] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  873.159557] wcn36xx: hal start scan channel 161
> [  873.164385] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  873.274356] wcn36xx: mac config changed 0x00000040
> [  873.274368] wcn36xx: wcn36xx_config channel switch=165
> [  873.274374] wcn36xx: hal init scan mode 2
> [  873.275673] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  873.275679] wcn36xx: hal start scan channel 165
> [  873.280543] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  873.390365] wcn36xx: mac config changed 0x00000040
> [  873.390376] wcn36xx: wcn36xx_config channel switch=36
> [  873.390382] wcn36xx: hal init scan mode 2
> [  873.391571] wcn36xx: SMD command (req 4, rsp 5) completed in 0ms
> [  873.391582] wcn36xx: hal start scan channel 36
> [  873.395275] wlan0: authenticate with e0:63:da:cc:a4:bd
> [  873.396502] wcn36xx: SMD command (req 6, rsp 7) completed in 4ms
> [  873.396522] wcn36xx: mac prepare multicast list
> [  873.396539] wcn36xx: mac configure filter
> [  873.396551] wcn36xx: hal finish scan mode 2
> [  873.405870] wcn36xx: SMD command (req 10, rsp 11) completed in 8ms
> [  873.405953] wcn36xx: mac config changed 0x00000100
> [  873.406063] wcn36xx: mac config changed 0x00000100
> [  873.406070] wcn36xx: mac config changed 0x00000040
> [  873.406075] wcn36xx: wcn36xx_config channel switch=36
>
> Not only that but I get the full scan-result list as expected...
>
> So yeah I think this patch is good as-is.
> We should add ops->flush() - I guess I'll send something out for comment
> on that in the next 12-18 hours.
>
> ---
> bod
