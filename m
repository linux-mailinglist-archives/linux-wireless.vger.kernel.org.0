Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805382646C9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 15:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgIJNTj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 09:19:39 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:55914
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728350AbgIJNTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 09:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599743499;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=q1h4X0rhfpIJxvratDwVA1xQ2ilL0QOAEAb+uD7egDE=;
        b=VjstSm6SLxkPGyaLYcFwWUhmBToXnHG7l+rPcxgvCItWVC0aa+7BTPxCIEiutCBF
        2p5s6MXaf3uKMyr0AzVSiTQbQoOyhXGhHgl+aPbEwdjDR+gmpqr4L939wRwraQM7fDN
        GIchkauHt3Q1jTqkC87trqepleIPWxEz8EL4YeNk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599743499;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=q1h4X0rhfpIJxvratDwVA1xQ2ilL0QOAEAb+uD7egDE=;
        b=EAP81zcmtP5pM8qeNkBZwikGEcWsITaMeTFgnhhfP/D0RTXC9/1oiApbm+j5aTiQ
        F3AMLWsXs1oJjeEtga7PvYsGxOczIdA4BGHQWTUacdnXP/yl6EsfMKsQdgLP9RfUZK+
        AofoY6SjblTMp97w49y9/GMCbmUqRByEVpP/uixA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92023C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath10k@lists.infradead.org>
References: <1593193990-30366-1-git-send-email-pillair@codeaurora.org>  <87y2ls4lbf.fsf@codeaurora.org> <0101017459fdd62b-791355e4-ea88-4142-96a7-06849bcd7b09-000000@us-west-2.amazonses.com> <87k0x51rz3.fsf@codeaurora.org>
In-Reply-To: <87k0x51rz3.fsf@codeaurora.org>
Subject: RE: [PATCH] ath10k: Use bdf calibration variant for snoc targets
Date:   Thu, 10 Sep 2020 13:11:39 +0000
Message-ID: <0101017478249a7e-ec85ae99-51da-4af5-9314-c3a6b205795e-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJRm8Tt2m+V2vXQfAtV0J7j7miBFwIt3U/7AmGQD+ACiFXeLKgy8eGg
Content-Language: en-us
X-SES-Outgoing: 2020.09.10-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Monday, September 7, 2020 9:48 PM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> ath10k@lists.infradead.org
> Subject: Re: [PATCH] ath10k: Use bdf calibration variant for snoc targets
> 
> "Rakesh Pillai" <pillair@codeaurora.org> writes:
> 
> >> > --- a/drivers/net/wireless/ath/ath10k/qmi.c
> >> > +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> >> > @@ -576,6 +576,8 @@ static int
> ath10k_qmi_cap_send_sync_msg(struct
> >> ath10k_qmi *qmi)
> >> >  	if (resp->chip_info_valid) {
> >> >  		qmi->chip_info.chip_id = resp->chip_info.chip_id;
> >> >  		qmi->chip_info.chip_family =
resp->chip_info.chip_family;
> >> > +	} else {
> >> > +		qmi->chip_info.chip_id = 0xFF;
> >> >  	}
> >>
> >> So you hard code chip_id to 0xff if it's not valid. Is it 100%
> >> guaranteed that there never will be a chip id with 0xff?
> >
> > 0x0 and 0xff are invalid chip id and are are not used.
> > If the chip_id read fails, we fallback to the default board data.
> > 0xff is used to go to the default board data (Also this is in alignment
with
> > the current implementation of board_id)
> >
> > Does that make sense ?
> 
> I'm a bit hesitant, over the years I have seen cases so many cases where
> "foo is not used anywhere" and later that foo is actually used
> somewhere. 0xff means that there's only 254 different values, but I
> guess there are not that many chip ids? So a chip id is very different
> from a board id, right?

Yes that's correct.
Chip id is already being used in case of qca6174 (pci bus)
We are bringing this to snoc bus chipset (WCN3990)

> 
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches

