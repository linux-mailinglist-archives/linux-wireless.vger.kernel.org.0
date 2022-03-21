Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F944E3225
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 22:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiCUVJD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCUVJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 17:09:02 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539CB1F044C
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 14:07:35 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1647896854; bh=J/nUSBjnVaZ4LWBHgqrqJtugw+LaXY/KYoTnhip5+Rg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ne9UoW3YB13o4rauQPm8tabFc/aMI4cwh76ivPD8pwXRbp6mg0B/X6noJOxpdBblw
         Xq2bRGl7r8X+q0+3PIDs7slq5S7ph7a3IPkgOdpAjBrAFERU6y1pq0Le89nSNeZK1X
         JqBr18TzQWFwmqKNIBiMQbqjeuawp7UXD/xIl5Puz+FoobIbmSD7gvNoriDahICg+y
         JvXwNs9+E5tUMEKO3kESU7UvGyodrVPzq3KR9CZrvANdsuKEODaZT8Kko50VvUTyGa
         yfC/hLhhyZXDt3VjDlpY6SMlFsPBNL6TihQJ15pK3DINhC1d7rSEOPmxOwo56yCHtg
         U95oV4XIK/XXg==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 4/6] ath9k: fix ar9003_get_eepmisc
In-Reply-To: <CAKe_nd0huJzqsn=8bQfyZ0oPLTzCjJFCrPPhUCwTY5W8WL-H5g@mail.gmail.com>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-5-wlooi@ucalgary.ca> <87a6dj9uds.fsf@toke.dk>
 <CAKe_nd0huJzqsn=8bQfyZ0oPLTzCjJFCrPPhUCwTY5W8WL-H5g@mail.gmail.com>
Date:   Mon, 21 Mar 2022 22:07:33 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87pmmf8162.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> On Mon, Mar 21, 2022 at 8:51 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@to=
ke.dk> wrote:
>>
>> Wenli Looi <wlooi@ucalgary.ca> writes:
>>
>> > The current implementation is reading the wrong eeprom type.
>> >
>> > Fixes: d8ec2e ("ath9k: Add an eeprom_ops callback for retrieving the e=
epmisc value")
>> > Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
>> > ---
>> >  drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c b/drivers/=
net/wireless/ath/ath9k/ar9003_eeprom.c
>> > index 669b49b56..a109a44a1 100644
>> > --- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
>> > +++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
>> > @@ -5615,7 +5615,7 @@ unsigned int ar9003_get_paprd_scale_factor(struc=
t ath_hw *ah,
>> >
>> >  static u8 ar9003_get_eepmisc(struct ath_hw *ah)
>> >  {
>> > -     return ah->eeprom.map4k.baseEepHeader.eepMisc;
>> > +     return ah->eeprom.ar9300_eep.baseEepHeader.opCapFlags.eepMisc;
>> >  }
>>
>> Looks like this is only ever used to check for the
>> AR5416_EEPMISC_BIG_ENDIAN flag - so is that never used by AR9300, or how
>> was this ever working given that it's a completely different offset?
>>
>> -Toke
>
> I think it's never used by AR9300, because get_eepmisc is only used in
> ath9k_hw_nvram_swap_data, which is only used in the eeprom types other
> than AR9300.

Alright, fair enough; let's merge this as a fix anyway...

-Toke
