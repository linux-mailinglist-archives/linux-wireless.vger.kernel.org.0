Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C81A76A7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437217AbgDNIxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 04:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729365AbgDNIxF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 04:53:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C63DC0A3BDC
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2020 01:53:04 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h6so12349453iok.11
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2020 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xgnW1aPbLN9oOeaHCeNquDTagEFhzczVgOye2DWFQPA=;
        b=W1qr+Z1WYjHe4xbKDV1lmYbmMK6RFMtvxD/PDVSkDfSzlMskA0HUwhRyGtEydLjjJ+
         TNICYVr3OxqzknKtDcSfTBA/eAWOt29dV+xSJaCmHVsyWeK++krCn3z6F6Ud7qDELhpB
         8AvSrfz+w31zYeREM2ZO89IDkSHxkD4uk4cRgLnX2MFVa/GtOaK8Uhph02oRlPNTqhOc
         0Zv6mjvGvvZD8+C1sYNTVovz3mAVxfrrVcubVFerI65mnnpX1w8Ij5v0eKcVoUiIS0KO
         QiXBnZMZCtY2hzC0ElSAZ5OZp3Wl+W7XhOe9WqqzFo+9nJT7H5/h/ALZapxy0VyFp6HX
         Q4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xgnW1aPbLN9oOeaHCeNquDTagEFhzczVgOye2DWFQPA=;
        b=WnHGW10n2H+RpMUAYl940t6OlXzds8EY2GmT4FdxCoxa2r0C0B8m4nnbDAqNaLC8n3
         kAvuUB6WARlOitwJ7mJpxcPDu8FJa7St6J+iRuh353KSRMp47WzT0XyvkeGMPUQzc/ax
         FaVmFe5aOjsj9XkEH74A1GYtOgyZp5OaMIso6qag4i/dsDVqXeHOjQ07lDTwKQ69YW5P
         eY8bGSDTEFbA7cLTO1LkbmJZd8st8wrdC6A8D6E/78l5DpJfJpEuH2+L0dJWMEHiwGCr
         EZHpXv9EtuKFlJofK+VbtQsPNPvFOCjQeq6HIvsksYo/e0eYBk2sCeFtHYzLNQSDrTDi
         4/Nw==
X-Gm-Message-State: AGi0PuaEjkuhphdxajdtQKDLsIBsKsuOwc/W6a/zRRjjD40jMWOQ8BF6
        /AVt6Vow/09RvDle2bcQx340R77ggpBhxc0Gi3q6qM6P
X-Google-Smtp-Source: APiQypKjz85AvGXDEq22GsIemmLzjd+NkTFTrWd5gb5jSuMtbqA7PKIv7iLvBvUX0G+E0NwB66xS9ezyPU9oe5KQudM=
X-Received: by 2002:a5e:d709:: with SMTP id v9mr11061211iom.195.1586854383423;
 Tue, 14 Apr 2020 01:53:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2bc4:0:0:0:0:0 with HTTP; Tue, 14 Apr 2020 01:53:02
 -0700 (PDT)
In-Reply-To: <MWHPR02MB2496EE78C46698CE3E6101EB98DA0@MWHPR02MB2496.namprd02.prod.outlook.com>
References: <0101016e82883ded-63f88383-cd90-4cb0-b9bb-3dd6a1e9f4e9-000000@us-west-2.amazonses.com>
 <20200409142136.5490EC433BA@smtp.codeaurora.org> <MWHPR02MB2496EE78C46698CE3E6101EB98DA0@MWHPR02MB2496.namprd02.prod.outlook.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 14 Apr 2020 10:53:02 +0200
Message-ID: <CAKR_QVJX719-F7pF2FdjY0Q_uMbvN0-Uo0ac6u7FAWyfci_TAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ath10k: correct legacy rate in tx stats
To:     Yu Wang <yyuwang@qti.qualcomm.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Yu Wang <yyuwang@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 14/04/2020, Yu Wang <yyuwang@qti.qualcomm.com> wrote:
>
>
>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Kalle Val=
o
>> Sent: Thursday, April 9, 2020 10:22 PM
>> To: Yu Wang <yyuwang@codeaurora.org>
>> Cc: linux-wireless@vger.kernel.org; ath10k@lists.infradead.org
>> Subject: [EXT] Re: [PATCH v2 2/2] ath10k: correct legacy rate in tx stat=
s
>>
>> Yu Wang <yyuwang@codeaurora.org> wrote:
>>
>> > When working in station mode, after connected to a legacy AP, 11g
>> > only, for example, the tx bitrate is incorrect in output of command
>> > 'iw wlan0 link'.
>> >
>> > That's because the legacy tx bitrate value reported by firmware is not
>> > well handled:
>> > For QCA6174, the value represents rate index, but treated as a real
>> > rate; For QCA9888, the value is real rate, with unit 'Mbps', but
>> > treated as '100kbps'.
>> >
>> > To fix this issue:
>> > 1. Translate the rate index to real rate for QCA6174; 2. Translate the
>> > rate from 'Mbps' to 'kbps' for QCA9888.
>> >
>> > Tested with:
>> > QCA6174 PCIe with firmware WLAN.RM.4.4.1.c3-00031.
>> > QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
>> > QCA9888 PCIe with firmware 10.4-3.9.0.2-00040.
>> >
>> > Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
>> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>
>> My comments don't seem to go to patchwork, so trying again:
>>
>> What about QCA988X and WCN3990, how do they behave? Does this patch
>> break those?
> Since HTT_T2H_MSG_TYPE_PPDU_STATS_IND is a newly added message, suppose i=
t's
> won't break the other functions.
> I don=E2=80=99t have environment to verify the patch with QCA988X and WCN=
3990.
> Can anyone help on this?
>
>>
>> > +cck =3D (preamble =3D=3D WMI_RATE_PREAMBLE_CCK);
>> > +hw_rate =3D ATH10K_HW_LEGACY_RATE(*ratecode);
>> > +for (i =3D 0; i < sband->n_bitrates; i++) {
>> > +bitrates =3D &sband->bitrates[i];
>> > +if (ath10k_mac_bitrate_is_cck(bitrates->bitrate) !=3D cck)
>> > +continue;
>> > +
>> > +if (bitrates->hw_value =3D=3D hw_rate ||
>> > +    (bitrates->flags & IEEE80211_RATE_SHORT_PREAMBLE &&
>> > +     bitrates->hw_value_short =3D=3D hw_rate)) {
>> > +bitrate =3D bitrates->bitrate;
>> > +
>> > +/* The bitrate will be recovered in
>> > + * ath10k_update_per_peer_tx_stats().
>> > + */
>> > +if (bitrate =3D=3D 55)
>> > +bitrate =3D 60;
>> > +
>> > +bitrate =3D bitrate / 10;
>>
>> Here you use magic value 60 but in ath10k_update_per_peer_tx_stats() you
>> use
>> magic value 50:
>>
>> > +/* from 1Mbps to 100Kbps */
>> > +rate =3D rate * 10;
>> > +if (rate =3D=3D 50)
>> > +rate =3D 55;
>>
>> Am I missing something or how is this supposed to work?
> In existing code, ath10k_update_per_peer_tx_stats() will check the bitrat=
e
> and convert 6_CCK to 5(in the comment: FW sends CCK rate 5.5Mbps as 6), a=
nd
> then 5 will be recovered to 55.
> That's why we need to convert bitrate 55 to 6 when processing PPDU_STATS.
>
> if (txrate.flags =3D=3D WMI_RATE_PREAMBLE_CCK ||
> txrate.flags =3D=3D WMI_RATE_PREAMBLE_OFDM) {
> rate =3D ATH10K_HW_LEGACY_RATE(peer_stats->ratecode);
> /* This is hacky, FW sends CCK rate 5.5Mbps as 6 */
> if (rate =3D=3D 6 && txrate.flags =3D=3D WMI_RATE_PREAMBLE_CCK)
> rate =3D 5;
> rate_idx =3D ath10k_get_legacy_rate_idx(ar, rate);
> if (rate_idx < 0)
> return;
>
> /* from 1Mbps to 100Kbps */
> rate =3D rate * 10;
> if (rate =3D=3D 50)
> rate =3D 55;
>>
>> --
>> https://patchwork.kernel.org/patch/11251001/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp=
atch
>> es
>>
>> _______________________________________________
>> ath10k mailing list
>> ath10k@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/ath10k
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
>

Hi

I don't understand why are you fixing this in driver when the comment
clearly says "FW sends CCK rate 5.5Mbps as 6"
Shouldn't a proper way be to fix this in firmware?
