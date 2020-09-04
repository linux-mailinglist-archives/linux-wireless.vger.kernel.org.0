Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E93625DFE2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Sep 2020 18:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIDQkq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Sep 2020 12:40:46 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:48534
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbgIDQkp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Sep 2020 12:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599237645;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=j4XVxVZyCl1nvm0HzA9cJkMT53izM1ras/rv8ANF328=;
        b=iZxxLwxomH125oyY+8CYLCOliqDKkXPK2cnFSdqMWafW2raMYf7wNINtA5Gvsovr
        eeXIG6uJE15o1WDcqRYbKzYeA3jpkk+Fn7x+cNwfZrEbMGKKcQnsCrju+ubAAn35+sB
        LIjf9HXHqnGL4DsUiFjVqFf+sjHkmrmYVMb+0nHU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599237645;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=j4XVxVZyCl1nvm0HzA9cJkMT53izM1ras/rv8ANF328=;
        b=QpgdcYSbT4xa/xKmfYBHC+fbDffIJKs/+c7qVrXHyKaALo6+KjHBHNUCjFK5OYAp
        hfiPtnhGqheHWKHCHVx6HmE6EPKSb7GSYAL4iSMUrioWBrwoGDRd+pDLpYViG5wv3P/
        DukQWJPUn7DpstbVZqQvtRryVixpzsV4LO0ilzu0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=2.0 tests=ALL_TRUSTED,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1C43C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1593193990-30366-1-git-send-email-pillair@codeaurora.org> <87y2ls4lbf.fsf@codeaurora.org>
In-Reply-To: <87y2ls4lbf.fsf@codeaurora.org>
Subject: RE: [PATCH] ath10k: Use bdf calibration variant for snoc targets
Date:   Fri, 4 Sep 2020 16:40:44 +0000
Message-ID: <0101017459fde1e4-001edcbb-cfa8-42f9-9865-2913f410e67c-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJRm8Tt2m+V2vXQfAtV0J7j7miBFwIt3U/7qFENAoA=
Content-Language: en-us
X-SES-Outgoing: 2020.09.04-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,


> -----Original Message-----
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Wednesday, September 2, 2020 2:17 PM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k@lists.infradead.org; linux-wireless@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] ath10k: Use bdf calibration variant for snoc targets
> 
> Rakesh Pillai <pillair@codeaurora.org> writes:
> 
> > Board Data File (BDF) is loaded upon driver boot-up procedure.
> > The right board data file is identified using bus and qmi-board-id.
> >
> > The problem, however, can occur when the (default) board data
> > file cannot fulfill with the vendor requirements and it is
> > necessary to use a different board data file.
> >
> > Add the support to get the variant field from DTSI and
> > use tht information to load the vendor specific BDF.
> >
> > The device tree requires addition strings to define the variant name
> >
> >     wifi@a000000 {
> >             status = "okay";
> >             qcom,ath10k-calibration-variant = "xyz-v2";
> >     };
> >
> >     wifi@a800000 {
> >             status = "okay";
> >             qcom,ath10k-calibration-variant = "xyz-v1";
> >     };
> >
> > This would create the boarddata identifiers for the board-2.bin search
> >
> >  *  bus=snoc,qmi-board-id=16,qmi-chip-id=0,variant=xyz-v1
> >  *  bus=snoc,qmi-board-id=17,qmi-chip-id=0,variant=xyz-v2
> 
> You mention nothing about qmi-chip-id in the commit log. Please document
> what it is and also give some examples what kind of values there can be.


Let me add a bit more details about the chip-id and send v2 for this change.


> 
> > --- a/drivers/net/wireless/ath/ath10k/qmi.c
> > +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> > @@ -576,6 +576,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct
> ath10k_qmi *qmi)
> >  	if (resp->chip_info_valid) {
> >  		qmi->chip_info.chip_id = resp->chip_info.chip_id;
> >  		qmi->chip_info.chip_family = resp->chip_info.chip_family;
> > +	} else {
> > +		qmi->chip_info.chip_id = 0xFF;
> >  	}
> 
> So you hard code chip_id to 0xff if it's not valid. Is it 100%
> guaranteed that there never will be a chip id with 0xff?

0x0 and 0xff are invalid chip id and are are not used.
If the chip_id read fails, we fallback to the default board data.
0xff is used to go to the default board data (Also this is in alignment with
the current implementation of board_id)

Does that make sense ?


> 
> >
> >  	if (resp->board_info_valid)
> > @@ -817,12 +819,18 @@ static void
> ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
> >  static int ath10k_qmi_fetch_board_file(struct ath10k_qmi *qmi)
> >  {
> >  	struct ath10k *ar = qmi->ar;
> > +	int ret;
> >
> >  	ar->hif.bus = ATH10K_BUS_SNOC;
> >  	ar->id.qmi_ids_valid = true;
> >  	ar->id.qmi_board_id = qmi->board_info.board_id;
> > +	ar->id.qmi_chip_id = qmi->chip_info.chip_id;
> 
> To me a safer, and cleaner, option would be to have
> ar->id.qmi_chip_id_valid, and only add qmi-chip-id=%x to the board id if
> qmi_chip_id_valid is true. That way there's not this magic 0xff value
> hardcoded anywhere.
> 
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches

