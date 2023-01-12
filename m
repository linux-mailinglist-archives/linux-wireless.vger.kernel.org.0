Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3E666E9B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 10:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjALJsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 04:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjALJrV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 04:47:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACC851318
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 01:43:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so19660330plw.11
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 01:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BCnOI57UTMuZBY8ttuWaWyhOE2RAr35dNvKJuI2jpjo=;
        b=ygbcPKK4FYbKlI0784ZnOo3Y1vhA15ypnakMPlk672u1KjbUYgoAYZVLpiQ2CsCD1n
         pMeo6j6iE/90fiCxgCTTpAy5wkqUWqw9LE5VhJfDFor1q8M1aeZW5tV+XmSid6ZaPkoH
         BilQqYsq37+eAf2Ws9aLkY8HxoVp+hpJapgAZID6KWrJjz4mdj6rv4iJiD+1NNPTRF1L
         fLf5iznch9aVN9mjHJtbZUBtiroso/RJsPwAEjs+eyJWkekbsyJWP3DUnAtrXRudnR3x
         i0N54hDX7EgHZFV9L0UGmgr12AHpE3QGISYtuQ0DYCJpg5Cr/d8vUikXiQb3tXH3HPtn
         jLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCnOI57UTMuZBY8ttuWaWyhOE2RAr35dNvKJuI2jpjo=;
        b=MrSj0InC5QQsIp69tslrC1QSdy2lRxitl9UPJMCWc6o6Rtae3VEQACEConVwN/rLsh
         TDVggvqWIEKmy2TOsokcuhNhVz5vT9/PHEMfDf/A4U87k984czOzoSH3WobC4FVL9b/a
         +rDa3+5LDTvJoNUMLya9YAhXnYdzWt+91ZoDouDQgD56CqMhlrxEAvcolAZ15QOGyo3I
         jDPMpBw/4VLbIRglMSnueroP3s7mo5Vt3qw+uUJ1sx4uwrUsgVbbzU80J7lnPERGQ+WP
         eeA1YUtFgqyqEJRQmQwjKTUGgs/qMCkw1xBxG6hvlNIK1qR4iB/l/ZV/+49RuwVOeoRe
         XdIA==
X-Gm-Message-State: AFqh2kq6r9tiWqTwBy1DaG2exFFvBQSzTaMciSgo+jflaQ3YpX08QCWe
        syvnX2ALIWpMVGnZZ6oOFqBUJTnw0L69K7TpCJWDug==
X-Google-Smtp-Source: AMrXdXueoMMev/WBFF9vUihTNyWPTMJxjr2hVS/wMKsdd4Z2hy1m7ecn34yBd4kpcw5X3go5dMJsCg4sMDlHq8PGPsU=
X-Received: by 2002:a17:90b:48cf:b0:226:164f:522e with SMTP id
 li15-20020a17090b48cf00b00226164f522emr3948204pjb.22.1673516628746; Thu, 12
 Jan 2023 01:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20221105194943.826847-1-robimarko@gmail.com> <20221105194943.826847-2-robimarko@gmail.com>
 <20221107174727.GA7535@thinkpad> <87cz9xcqbd.fsf@kernel.org>
 <877czn8c2n.fsf@kernel.org> <CA+HBbNFCFtJwzN=6SCsWnDmAjPkmxE4guH1RrLc+-HByLcVVXA@mail.gmail.com>
 <87k02jzgkz.fsf@kernel.org> <CA+HBbNHi0zTeV0DRmwLjZu+XzUQEZQNnSpBMeQeUPiBu3v-2BQ@mail.gmail.com>
 <87358hyp3x.fsf@kernel.org> <CA+HBbNGdOrOiCxhSouZ6uRPRnZmsBSAL+wWpLkczMK9cO8Mczg@mail.gmail.com>
 <877cxsdrax.fsf@kernel.org>
In-Reply-To: <877cxsdrax.fsf@kernel.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 12 Jan 2023 10:43:37 +0100
Message-ID: <CA+HBbNGbg88_3FDu+EZhqMj0UKb8Ja_vyYsxGtmJ_HGt4fNVBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath11k: use unique QRTR instance ID
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Robert Marko <robimarko@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, elder@linaro.org,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        quic_qianyu@quicinc.com, bbhatt@codeaurora.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jan 12, 2023 at 10:40 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Robert Marko <robert.marko@sartura.hr> writes:
>
> > On Wed, Jan 11, 2023 at 6:10 PM Kalle Valo <kvalo@kernel.org> wrote:
> >>
> >> Robert Marko <robert.marko@sartura.hr> writes:
> >>
> >> >> Really sorry, I just didn't manage to get this finalised due to other
> >> >> stuff and now I'm leaving for a two week vacation :(
> >> >
> >> > Any news regarding this, I have a PR for ipq807x support in OpenWrt
> >> > and the current workaround for supporting AHB + PCI or multiple PCI
> >> > cards is breaking cards like QCA6390 which are obviously really
> >> > popular.
> >>
> >> Sorry, came back only on Monday and trying to catch up slowly. But I
> >> submitted the RFC now:
> >>
> >> https://patchwork.kernel.org/project/linux-wireless/patch/20230111170033.32454-1-kvalo@kernel.org/
> >
> > Great, thanks for that.
> >
> > Does it depend on firmware-2 being available?
>
> The final solution for the users will require firmware-2.bin. But for a
> quick test you can omit the feature bit test by replacing
> "test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)" with
> "true". Just make sure that the firmware release you are using supports
> this feature, I believe only recent QCN9074 releases do that.

Hi,
I was able to test on IPQ8074+QCN9074 yesterday by just bypassing the
test and it worked.
Sideffect is that until firmware-2.bin is available cards like QCA6390
wont work like with my
hack.

Regards,
Robert
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
